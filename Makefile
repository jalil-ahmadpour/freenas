.if exists(build/hooks/Makefile)
.include "build/hooks/Makefile"
.endif

NANO_LABEL?=SadrNAS
VERSION?=9.3-M2
TRAIN?=FreeNAS-ALPHA
BUILD_TIMESTAMP!=date '+%Y%m%d'
COMPANY?="iXsystems"

.ifdef SCRIPT
RELEASE_LOGFILE?=${SCRIPT}
.else
RELEASE_LOGFILE?=release.build.log
.endif

GIT_REPO_SETTING=.git-repo-setting
.if exists(${GIT_REPO_SETTING})
GIT_LOCATION!=cat ${GIT_REPO_SETTING}
.endif
ENV_SETUP=env NANO_LABEL=${NANO_LABEL} VERSION=${VERSION} GIT_LOCATION=${GIT_LOCATION} BUILD_TIMESTAMP=${BUILD_TIMESTAMP}
ENV_SETUP+= TRAIN=${TRAIN}

.if defined(NANO_ARCH)
 ENV_SETUP+= NANO_ARCH=${NANO_ARCH}
.endif

all:	build

.BEGIN:
	${ENV_SETUP} build/check_build_host.sh
.if !make(checkout) && !make(update) && !make(clean) && !make(distclean) && !make(git-internal) && !make(git-external)
	${ENV_SETUP} build/check_sandbox.sh
.endif

build: git-verify
	@[ `id -u` -eq 0 ] || (echo "Sorry, you must be running as root to build this."; exit 1)
	@${ENV_SETUP} ${MAKE} portsjail
	@${ENV_SETUP} ${MAKE} ports
	${ENV_SETUP} build/do_build.sh

checkout: git-verify
	${ENV_SETUP} build/do_checkout.sh

update: git-verify
	git pull
	${ENV_SETUP} build/do_checkout.sh

clean:
	${ENV_SETUP} build/build_cleanup.py
	rm -rf ${NANO_LABEL}-${VERSION}-* release.build.log
	rm -rf objs os-base

clean-packages:
	find objs/os-base/*/ports -type f -delete

clean-package:
.if defined(p)
	find objs/os-base/*/ports -name "${p}*" | xargs rm -fr
.else
	@echo "Clean a single package from object tree"
	@echo "" 
	@echo "Usage:  ${MAKE} ${.TARGET} p=[package name]"
	@echo ""
	@echo "Examples:"
	@echo "        ${MAKE} ${.TARGET} p=freenas-ui"
	@echo "        ${MAKE} ${.TARGET} p=netatalk"
.endif

clean-ui-package:
	${MAKE} clean-package p=freenas-ui

distclean: clean
	rm -fr FreeBSD nas_source

save-build-env:
	${ENV_SETUP} build/save_build.sh

freenas: release
release: git-verify
	@echo "Doing executing target $@ on host: `hostname`"
	@echo "Build directory: `pwd`"
	${ENV_SETUP} script -a ${RELEASE_LOGFILE} ${MAKE} build
	${ENV_SETUP} script -a ${RELEASE_LOGFILE} build/create_release_distribution.sh

rebuild:
	@${ENV_SETUP} ${MAKE} checkout
	@${ENV_SETUP} ${MAKE} all
	@${ENV_SETUP) sh build/create_release_distribution.sh

cdrom:
	${ENV_SETUP} sh -x build/create_iso.sh

truenas: git-verify
	@[ "${GIT_LOCATION}" = "INTERNAL" ] || (echo "You can only run this target from an internal repository."; exit 1)
	env NANO_LABEL=TrueNAS script -a ${RELEASE_LOGFILE} ${MAKE} build
	mkdir -p objs/TrueNAS-${VERSION}-${BUILD_TIMESTAMP}
	mv objs/os-base/amd64/TrueNAS-${VERSION}-* objs/TrueNAS-${VERSION}-${BUILD_TIMESTAMP}

# intentionally split up to prevent abuse/spam
BUILD_BUG_DOMAIN?=ixsystems.com
BUILD_BUG_USER?=build-bugs
BUILD_BUG_EMAIL?=${BUILD_BUG_USER}@${BUILD_BUG_DOMAIN}

build-bug-report:
	mail -s "build fail for $${SUDO_USER:-$$USER}" ${BUILD_BUG_EMAIL} < \
		${RELEASE_LOGFILE}

git-verify:
	@if [ ! -f ${GIT_REPO_SETTING} ]; then \
		echo "No git repo choice is set.  Please use \"make git-external\" to build as an"; \
		echo "external developer or \"make git-internal\" to build as an ${COMPANY}"; \
		echo "internal developer.  You only need to do this once."; \
		exit 1; \
	fi
	@echo "NOTICE: You are building from the ${GIT_LOCATION} git repo."

git-internal:
	@echo "INTERNAL" > ${GIT_REPO_SETTING}
	@echo "You are set up for internal (${COMPANY}) development.  You can use"
	@echo "the standard make targets (e.g. build or release) now."

git-external:
	@echo "EXTERNAL" > ${GIT_REPO_SETTING}
	@echo "You are set up for external (github) development.  You can use"
	@echo "the standard make targets (e.g. build or release) now."

tag:
	${ENV_SETUP} build/apply_tag.sh

ports:
	@[ `id -u` -eq 0 ] || (echo "Sorry, you must be running as root to build this."; exit 1)
	${ENV_SETUP} build/ports/create-poudriere-conf.sh
	${ENV_SETUP} build/ports/create-poudriere-make.conf.sh
	${ENV_SETUP} build/ports/prepare-jail.sh
	${ENV_SETUP} build/ports/fetch-ports-srcs.sh
	${ENV_SETUP} build/ports/create-ports-list.sh
	${ENV_SETUP} build/ports/build-ports.sh

portsjail:
	${ENV_SETUP} build/build_jail.sh
