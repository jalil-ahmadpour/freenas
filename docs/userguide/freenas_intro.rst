:orphan:

|fn93cover.jpg|

.. |fn93cover.jpg| image:: images/fn93cover.jpg
    :width: 8.5in
    :height: 11in

.. centered:: FreeNAS® is © 2011-2014 iXsystems

.. centered:: FreeNAS® and the FreeNAS® logo are registered trademarks of iXsystems.
   
.. centered:: FreeBSD is a registered trademark of the FreeBSD Foundation
   
.. centered:: Cover art by Jenny Rosenberg

Written by users of the FreeNAS® network-attached storage operating system.

Version 9.3

Published XX, 2014

Copyright © 2011-2014
`iXsystems <http://www.ixsystems.com/>`_
    
This Guide covers the installation and use of FreeNAS® 9.3.

The FreeNAS® Users Guide is a work in progress and relies on the contributions of many individuals. If you are interested in helping us to improve the Guide,
read the instructions in the `README 
<https://github.com/freenas/freenas/blob/master/docs/userguide/README>`_. If you use IRC Freenode, you are welcome to join the #freenas channel where you will
find other FreeNAS® users.

The FreeNAS® Users Guide is freely available for sharing and redistribution under the terms of the
`Creative Commons Attribution License
<http://creativecommons.org/licenses/by/3.0/>`_. This means that you have permission to copy, distribute, translate, and adapt the work as long as you
attribute iXsystems as the original source of the Guide.

FreeNAS® and the FreeNAS® logo are registered trademarks of iXsystems.

3ware® and LSI® are trademarks or registered trademarks of LSI Corporation.

Active Directory® is a registered trademark or trademark of Microsoft Corporation in the United States and/or other countries.

Apple, Mac and Mac OS are trademarks of Apple Inc., registered in the U.S. and other countries.

Chelsio® is a registered trademark of Chelsio Communications.

Cisco® is a registered trademark or trademark of Cisco Systems, Inc. and/or its affiliates in the United States and certain other countries.

Django® is a registered trademark of Django Software Foundation.

Facebook® is a registered trademark of Facebook Inc.

FreeBSD and the FreeBSD logo are registered trademarks of the FreeBSD Foundation.

Fusion-io is a trademark or registered trademark of Fusion-io, Inc.

Intel, the Intel logo, Pentium Inside, and Pentium are trademarks of Intel Corporation in the U.S. and/or other countries.

LinkedIn® is a registered trademark of LinkedIn Corporation.

Linux® is a registered trademark of Linus Torvalds.

Marvell® is a registered trademark of Marvell or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its affiliates.

Twitter is a trademark of Twitter, Inc. in the United States and other countries.

UNIX® is a registered trademark of The Open Group.

VirtualBox® is a registered trademark of Oracle.

VMware® is a registered trademark of VMware, Inc.

Wikipedia® is a registered trademark of the Wikimedia Foundation, Inc., a non-profit organization.

Windows® is a registered trademark of Microsoft Corporation in the United States and other countries.

**Typographic Conventions**

The FreeNAS® 9.3 Users Guide uses the following typographic conventions:

* Names of graphical elements such as buttons, icons, fields, columns, and boxes are enclosed within quotes. For example: click the "Performance Test" button.

* Menu selections are italicized and separated by arrows. For example: :menuselection:`System --> Information`.

* Commands that are mentioned within text are highlighted in :command:`bold text`. Command examples and command output are contained in green code blocks.

* Volume, dataset, and file names are enclosed in a blue box :file:`/like/this`.

* Keystrokes are formatted in a blue box. For example: press :kbd:`Enter`.

* **bold text:** used to emphasize an important point.

* *italic text:* used to represent device names or text that is input into a GUI field.

.. _Introduction:

Introduction
============

FreeNAS® is an embedded open source network-attached storage (NAS) system based on FreeBSD and released under a BSD license. A NAS provides an operating
system that has been optimized for file storage and sharing.

Notable features in FreeNAS® include:

* supports AFP, CIFS, FTP, NFS, SSH (including SFTP), and TFTP as file sharing mechanisms

* supports exporting file or device extents via iSCSI

* supports Active Directory or LDAP for user authentication as well as manual user and group creation

* supports the creation and import of
  `ZFS <http://en.wikipedia.org/wiki/ZFS>`_
  pools, enabling many features such as quotas, snapshots, compression, replication, and datasets for sharing subsets of volumes

* upgrade procedure saves the current operating system to an inactive partition, allowing for an easy reversal of an undesirable upgrade

* system notifications are automatically mailed to the root user account

* `Django <http://en.wikipedia.org/wiki/Django_%28Web_framework%29>`_
  driven graphical user interface available through a web browser

* secure replication, automatic ZFS snapshots, scheduling of ZFS scrubs, and cron management are all configurable through the graphical interface

* support for menu localization and keyboard layouts

* SMART monitoring and UPS management in GUI

* support for Windows ACLs and UNIX filesystem permissions

* periodic ZFS snapshots are visible in Windows as shadow copies

* includes
  `tmux <http://sourceforge.net/projects/tmux/>`_, a BSD-licensed utility similar to GNU screen

.. _What's New in 9.3:

What's New in 9.3
-----------------

FreeNAS® 9.3 fixes this list of bugs.

It is based on the stable version of FreeBSD 9.3 which adds 
`these features <https://www.freebsd.org/releases/9.3R/relnotes.html>`_, supports
`this hardware <https://www.freebsd.org/releases/9.3R/hardware.html>`_, and incorporates all of the
`security releases <http://www.freebsd.org/security/advisories.html>`_
issued since FreeBSD 9.3 RELEASE.

* FreeNAS® is now 64-bit only.

* FreeNAS® is now ZFS only. This means that the "UFS Volume Manager" has been removed and disks can no longer be formatted with UFS. However, for backwards
  compatibility, existing UFS-formatted disks can still be imported using "Import Volume" and UFS software RAID volumes can be imported using "Auto Import
  Volume".

* There is now only one type of installation file, :file:`.iso`. This file can be either burned to CD or written to a USB flash drive. This is an installer
  file as new versions of FreeNAS® must be installed using a menu-driven installer.
  
* FreeNAS® now formats the device holding the operating system with ZFS and uses the GRUB boot loader. This provides support for multiple boot environments,
  allowing you to easily recover from a failed upgrade, system patch, or configuration.
  
* The new installer provides the option to select multiple devices, meaning that you can now mirror the boot device.
  
* The administrative GUI can now be accessed over IPv6.

* NFSv4 support, which includes Kerberized NFS support, has been added.

* A configuration wizard has been added. On a fresh install, this wizard will run after the *root* password is set, making it easy to quickly create a volume
  and share(s). Users who prefer to manually create their volumes and shares can exit the wizard and create these as usual. The wizard can be re-run at a
  later time by selecting :ref:`Wizard` from the graphical tree menu.

* The ability to manage boot environments has been added to :menuselection:`System --> Boot`.

* The ability to check for updates and perform upgrades has been added to :menuselection:`System --> Upgrade`.

* The ability to import or create an internal or intermediate CA (Certificate Authority) has been added to :menuselection:`System --> CAs`. 

* The ability to import existing certificates or to create self-signed certificates has been added to :menuselection:`System --> Certificates`. All services
  which support the use of certificates now have a drop-down menu for selecting an imported or created certificate.

* The ZFS pool version can now be upgraded by clicking the "Upgrade" button in the :menuselection:`Storage --> Volumes --> View Volumes` screen.

* The :command:`afpusers` command has been added. Similar to
  `macusers <http://netatalk.sourceforge.net/3.0/htmldocs/macusers.1.html>`_, it can be used to list the users connected to AFP shares.

* Kernel iSCSI has replaced :command:`istgt`. This improves support for VMWare VAAI acceleration and adds support for Microsoft ODX acceleration and Windows
  2012 clustering.

* Support for Link Layer Discovery Protocol (:ref:`LLDP`) has been added. This allows network devices to advertise their identity, capabilities, and neighbors on
  an Ethernet LAN.

* `Net-SNMP <http://net-snmp.sourceforge.net/>`_ has replaced :command:`bsnmpd` as the SNMP service.

* Support for WebDAV has been added which can be configured from :menuselection:`Services --> WebDAV`. This provides a file browser with HTTP authentication
  and optional SSL encryption.

* The Linux jail templates have been removed as they were too experimental and limited to 32-bit. Instead, use the VirtualBox template, which installs a
  web-based instance of phpVirtualBox, and use that to install the desired Linux distro or any other operating system.

* Plugins and Jails now support DHCP configuration for IPv4 and IPv6. This should resolve most software connectivity issues when the network contains a DHCP
  server.

* The cruciblewds, s3cmd, and Syncthing plugins have been added.

The GUI has been reorganized as follows:

* :menuselection:`System --> System Information` is now :menuselection:`System --> Information`.

* :menuselection:`System --> Settings` has been divided into :menuselection:`System --> General`, :menuselection:`System --> Advanced`,
  :menuselection:`System --> Email`, and :menuselection:`System --> System Dataset`.

* :menuselection:`System --> Sysctls` and :menuselection:`System --> Tunables` have been merged into :menuselection:`System --> Tunables`. The "Type" field
  has been added to :menuselection:`System --> Tunables` so you can specify whether a "Loader" or a "Sysctl" is being created.

* NTP Servers has been moved to :menuselection:`System --> General`.

* :menuselection:`System --> Settings --> SSL` has been moved to :menuselection:`System --> General --> Set SSL Certificate`.
  
* A new :ref:`Tasks` menu has been added and the following have been moved to Tasks: Cron Jobs, Init/Shutdown Scripts, Rsync Tasks, and S.M.A.R.T Tests.

* A :ref:`Snapshots` menu has been added to Storage.

* :menuselection:`Services --> Directory Services` has been renamed to Directory Service and moved as its own item in the tree.

* :menuselection:`Services --> Directory Services --> Domain Controller` has been moved to :menuselection:`Services --> Domain Controller`.

* :menuselection:`Services --> LLDP` has been added.

* Log Out has been moved from the upper right corner to the tree menu.

The following fields have been added or deleted:

* The "Reset WebGUI login credentials" entry in the "Console setup" menu has been renamed to "Reset Root Password".

* The "Certificate" drop-down menu and "WebGUI -> HTTPS Port" field have been added to :menuselection:`System --> General`.

* The "System dataset pool" and "Use system dataset for syslog" fields have been removed from :menuselection:`System --> Advanced` as these are now set in
  :menuselection:`System --> System Dataset`.

* A "Performance Test" button has been added to :menuselection:`System --> Advanced`.

* The "Firmware Update" button has been moved from :menuselection:`System --> Advanced` and renamed to :menuselection:`System --> Upgrade -> Manual Update`.

* The "Directory Services" field is now deprecated and has been removed from :menuselection:`System --> General`. FreeNAS® now supports the
  `System Security Services Daemon (SSSD) <https://fedorahosted.org/sssd/>`_
  which provides support for multiple directory services.

* The "Rebuild LDAP/AD Cache" button has been removed from :menuselection:`System --> Advanced`. It has been renamed to "Rebuild Directory Service Cache" and
  now appears in the configuration screen for each type of directory service.

* The "HTTP Proxy" field has been added to :menuselection:`Network --> Global Configuration`.

* A "Run Now" button has been added for the highlighted cron job in :menuselection:`Tasks --> Cron Jobs --> View Cron Jobs`.

* The icons in Storage have been renamed to clarify their purpose. "Auto Import Volume" is now "Import Volume", "Import Volume" is now "Import Disk", "ZFS
  Volume Manager" is now "Volume Manager", and "ZFS Scrubs" are now "Scrubs".

* The "Case Sensitivity" drop-down menu has been added to :menuselection:`Storage --> Volumes --> Create ZFS Dataset`.

* An "Upgrade" button has been added to the available icons for a highlighted volume in :menuselection:`Storage --> Volumes --> View Volumes`. This means that
  you no longer need to upgrade a ZFS pool from the command line.

* The "Change Permissions" screen for a volume or dataset now has three "Permission Type"s: *Unix*, 
  *Mac*, and
  *Windows*.

* The "Volume Status" screen now shows the status of the latest ZFS scrub, the number of errors, number of repaired blocks, and the date of the last scrub.

* The "Volume Status" screen now shows the resilvering status when a disk is replaced.
  
* The "Enable High Speed Ciphers" checkbox has been replaced by the "Encryption Cipher" drop-down menu in 
  :menuselection:`Storage --> Replication Tasks -> Add Replication Tasks`. This allows you to temporarily disable encryption for the initial replication which
  can significantly reduce the time needed for the initial replication.

* The "Workgroup Name" field is deprecated and has been removed from :menuselection:`Directory Service --> Active Directory`. The "Encryption Mode",
  "Certificate", and "Enable" fields and the "Idmap backend" drop-down menu have been added to :menuselection:`Directory Service --> Active Directory`. The
  "Kerberos Server" and "Kerberos Password Server" fields have been replaced by the "Kerberos Realm" drop-down menu.

* The "Encryption Mode" and "Auxiliary Parameters" fields have been removed from :menuselection:`Directory Service --> LDAP`. The "Enable" and "Samba Schema"
  checkboxes, "SUDO Suffix" and "Use default domain" fields, and "Kerberos Realm", "Kerberos Keytab", and "Idmap backend" drop-down menus have been added.

* The "Enable" checkbox has been added to :menuselection:`Directory Service --> NIS`.

* The "Use default domain" and "Enable" checkboxes and the "Idmap backend" drop-down menu have been added to :menuselection:`Directory Service --> NT4`.

* :menuselection:`Directory Service --> Kerberos Realms` and `Directory Service --> Kerberos Keytabs` have been added. Added keytabs are stored in the
  configuration database so that they persist across reboots and system upgrades.

* The "Database Path" field has been moved from :menuselection:`Sharing --> Apple (AFP) Share --> Add Apple (AFP) Share` to :menuselection:`Services --> AFP`.

* A "Global auxiliary parameters" field has been added to :menuselection:`Services --> AFP`.

* The "Zero Device Numbers" field has been moved from :menuselection:`Services --> AFP to Sharing --> Apple (AFP) Share --> Add Apple (AFP) Share`.

* The "Security" selection fields have been added to :menuselection:`Sharing --> Unix (NFS) Shares --> Add Unix (NFS) Share`.

* The "Domain logons", "Obey pam restrictions", and "Bind IP Addresses" checkboxes and the "Idmap Range Low" and "Idmap Range High" fields have been added to
  :menuselection:`Services --> CIFS`.

* :menuselection:`Services --> Directory Services` has been renamed to :menuselection:`Services --> Domain Controller`.

* The "Kerberos Realm" drop-down menu has been added to :menuselection:`Services --> Domain Controller`.

* The "IP Server" field has been added to :menuselection:`Services --> Dynamic DNS`.

* The "TLS use implicit SSL" checkbox has been removed from `Services --> FTP` as this feature is deprecated. The "Certificate and private key" field has
  been replaced by the "Certificate" drop-down menu which is integrated into the new Certification Manager, allowing one to select their own certificates.

* The "Enable TPC" field has been added to :menuselection:`Services --> iSCSI --> Extents --> Add Extent`.

* :menuselection:`Services --> iSCSI --> Target Global Configuration` has been reduced to three configuration options used by kernel iSCSI.

* The "Target Flags" and "Queue Depth" fields are now deprecated and have been removed from :menuselection:`Services --> iSCSI --> Targets --> Add Target`.

* The "Enable NFSv4" checkbox has been added to :menuselection:`Services --> NFS`.

* The "vanilla" option has been removed from :menuselection:`Jails --> Add Jails` as it was confusing.

* The "NIC" drop-down menu has been added to :menuselection:`Jails --> Add Jails` so that the interface to use for jail connections can be specified.

* The "Upload Plugin" button has been removed from the "Jails" screen. To install a plugin, use "Plugins" instead.

.. _Known Issues:

Known Issues
------------

Before installing FreeNAS® you should be aware of the following known issues:

* **UPGRADES FROM FreeNAS® 0.7x ARE NOT SUPPORTED.** The system has no way to import configuration settings from 0.7x versions of FreeNAS®, meaning that you
  will have to manually recreate your configuration. However, you should be able to import_supported FreeNAS® 0.7x volumes.

* **The ZFS upgrade procedure is non-reversible.** Do not upgrade your ZFS version unless you are absolutely sure that you will never want to go back to the
  previous version. There is no reversing a ZFS pool upgrade, and there is no way for a system with an older version of ZFS to access pools that have been
  upgraded.

* The available space reported in the parent zpool may not reflect reality and can be confusing because the available space represented by datasets or zvols
  can exceed that of the parent zpool.

* Disks with certain configurations can get probed by GEOM and become essentially unwritable without manual intervention. For instance, if you use disks that
  previously had a gmirror on them, the system may pick that up and the disks will be unavailable until the existing gmirror is stopped and destroyed.

* The mps driver for 6G LSI SAS HBAs is version 16, which requires phase 16 firmware on the controller. It is recommended to upgrade the firmware before
  installing FreeNAS® or immediately after upgrading FreeNAS®. Running older firmware can cause many woes, including the failure to probe all of the
  attached disks, which can lead to degraded or unavailable arrays.

.. _Hardware Recommendations:

Hardware Recommendations
------------------------

Since FreeNAS® 9.3 is based on FreeBSD 9.3, it supports the same hardware found in the `FreeBSD Hardware Compatibility List
<http://www.freebsd.org/releases/9.3R/hardware.html>`__. Supported processors are listed in section
`2.1 amd64 <https://www.freebsd.org/releases/9.3R/hardware.html#proc>`_. Beginning with version 9.3, FreeNAS® is only available for 64-bit (also known as
amd64) processors.

Actual hardware requirements will vary depending upon what you are using your FreeNAS® system for. This section provides some guidelines to get you started.
You can also skim through the
`FreeNAS® Hardware Forum <http://forums.freenas.org/forumdisplay.php?18-Hardware>`_ for performance tips from other FreeNAS® users or to post questions
regarding the hardware best suited to meet your requirements. This
`forum post <http://forums.freenas.org/index.php?threads/hardware-recommendations-read-this-first.23069/>`_
provides some specific recommendations if you are planning on purchasing hardware.

.. _RAM:

RAM
~~~

The best way to get the most out of your FreeNAS® system is to install as much RAM as possible. The recommended minimum is 8 GB of RAM. The more RAM, the
better the performance, and the
`FreeNAS® Forums <http://forums.freenas.org/>`_
provide anecdotal evidence from users on how much performance is gained by adding more RAM. For systems with a disk capacity greater than 8 TB, a general rule
of thumb is 1 GB of RAM for every 1 TB of storage. This
`post <http://hardforum.com/showpost.php?s=8d31305e57c1dd2853eb817124ff18d9&p=1036865233&postcount=3>`_
describes how RAM is used by ZFS.

If you plan to use your server for home use, you can often soften the rule of thumb of 1 GB of RAM for every 1 TB of storage, though 8 GB of RAM is still the
recommended minimum. If performance is inadequate, consider adding more RAM as a first remedy. The sweet spot for most home or small business users is 16 GB
of RAM. While it is possible to use ZFS on systems with less than 8 GB of RAM, performance will be substantially reduced. The ZFS filesystem will
automatically disable pre-fetching (caching) on systems where it is not able to use at least 4 GB of memory for its cache and data structures.

If your system supports it and your budget allows for it, install ECC RAM. While more expensive, ECC RAM is highly recommended as it prevents in-flight
corruption of data before the error-correcting properties of ZFS come into play, thus providing consistency for the checksumming and parity calculations
performed by ZFS. If you consider your data to be important, use ECC RAM. This 
`Case Study <http://research.cs.wisc.edu/adsl/Publications/zfs-corruption-fast10.pdf>`_ describes the risks associated with memory corruption.

If you plan to use ZFS deduplication, a general rule of thumb is 5 GB RAM per TB of storage to be deduplicated.

If you use Active Directory with FreeNAS®, add an additional 2 GB of RAM for winbind's internal cache.

If you are installing FreeNAS® on a headless system, disable the shared memory settings for the video card in the BIOS.

If you don't have at least 8GB of RAM, you should consider getting more powerful hardware before using FreeNAS® to store your data. Plenty of users expect
FreeNAS® to function with less than these requirements, just at reduced performance.  The bottom line is that these minimums are based on the feedback of
many users. Users that do not meet these requirements and who ask for help in the forums or IRC will likely be ignored because of the abundance of information
that FreeNAS® may not behave properly with less than 8GB of RAM.

.. _Compact or USB Flash:

Compact or USB Flash
~~~~~~~~~~~~~~~~~~~~

The FreeNAS® operating system is installed to at least one device that is separate from the storage disks. The device can be a USB stick, compact flash,
or SSD. Technically, it can also be installed onto a hard drive, but this is discouraged as that drive will then become unavailable for data storage.

When determining the type and size of device to install the operating system to, keep the following points in mind:

- the recommended bare minimum size is 4GB. This provides room for the operating system and two boot environments. The recommended minimum is 8GB or 16GB as
  this provides more room for boot environments.

- If you plan to make your own boot environments, budget about 1GB of storage per boot environment. Consider deleting older boot environments once you are
  sure that a boot environment is no longer needed. Boot environments can be created and deleted using :menuselection:`System --> Boot`.

- when using a USB stick, it is recommended to use a name brand USB stick as ZFS will quickly find errors on cheap, not well made sticks.

- when using a USB stick, USB 3.0 support is disabled by default as it currently is not compatible with some hardware, including Haswell (Lynx point)
  chipsets. If you receive a "failed with error 19" message when trying to boot FreeNAS®, make sure that xHCI/USB3 is disabled in the system BIOS. While this
  will downclock the USB ports to 2.0, the bootup and shutdown times will not be significantly different. To see if USB 3.0 support works with your hardware,
  follow the instructions in :ref:`Tunables` to create a "Tunable" named *xhci_load*, set its value to *YES*, and reboot the system.
  
- if a reliable boot disk is required, use two identical devices and select them both during the installation. Doing so will create a mirrored boot device.

.. _Storage Disks and Controllers:

Storage Disks and Controllers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The
`Disk section <http://www.freebsd.org/releases/9.3R/hardware.html#DISK>`_
of the FreeBSD Hardware List lists the supported disk controllers. In addition, support for 3ware 6gbps RAID controllers has been added along with the CLI
utility :command:`tw_cli` for managing 3ware RAID controllers.

FreeNAS® supports hot pluggable drives. To use this feature, make sure that AHCI is enabled in the BIOS. Note that hot plugging is **not the same** as a hot
spare, which is not supported at this time.

If you need reliable disk alerting and immediate reporting of a failed drive, use a fully manageable hardware RAID controller such as a LSI
MegaRAID controller or a 3Ware twa-compatible controller. More information about LSI cards and FreeNAS® can be found in this
`forum post <http://forums.freenas.org/showthread.php?11901-Confused-about-that-LSI-card-Join-the-crowd>`_.

Suggestions for testing disks before adding them to a RAID array can be found in this
`forum post <http://forums.freenas.org/showthread.php?12082-Checking-new-HDD-s-in-RAID>`_.

`This article <http://technutz.com/purpose-built-nas-hard-drives/>`_
provides a good overview of hard drives which are well suited for a NAS.

If you have some money to spend and wish to optimize your disk subsystem, consider your read/write needs, your budget, and your RAID requirements:

* If you have steady, non-contiguous writes, use disks with low seek times. Examples are 10K or 15K SAS drives which cost about $1/GB. An example
  configuration would be six 600 GB 15K SAS drives in a RAID 10 which would yield 1.8 TB of usable space or eight 600 GB 15K SAS drives in a RAID 10 which
  would yield 2.4 TB of usable space.

* 7200 RPM SATA disks are designed for single-user sequential I/O and are not a good choice for multi-user writes.

If you have the budget and high performance is a key requirement, consider a
`Fusion-I/O card <http://www.fusionio.com/products/>`_
which is optimized for massive random access. These cards are expensive and are suited for high-end systems that demand performance. A Fusion-I/O card can be
formatted with a filesystem and used as direct storage; when used this way, it does not have the write issues typically associated with a flash device. A
Fusion-I/O card can also be used as a cache device when your ZFS dataset size is bigger than your RAM. Due to the increased throughput, systems running these
cards typically use multiple 10 GigE network interfaces.

If you will be using ZFS,
`Disk Space Requirements for ZFS Storage Pools <http://download.oracle.com/docs/cd/E19253-01/819-5461/6n7ht6r12/index.html>`_
recommends a minimum of 16 GB of disk space. Due to the way that ZFS creates swap, **you can not format less than 3 GB of space with ZFS**. However, on a
drive that is below the minimum recommended size you lose a fair amount of storage space to swap: for example, on a 4 GB drive, 2 GB will be reserved for
swap.

If you are new to ZFS and are purchasing hardware, read through
`ZFS Storage Pools Recommendations <http://www.solarisinternals.com/wiki/index.php/ZFS_Best_Practices_Guide#ZFS_Storage_Pools_Recommendations>`_
first.

ZFS uses dynamic block sizing, meaning that it is capable of striping different sized disks. However, if you care about performance, use disks of the same
size. Further, when creating a RAIDZ*, only the size of the smallest disk will be used on each disk.

.. _Network Interfaces:

Network Interfaces
~~~~~~~~~~~~~~~~~~

The
`Ethernet section <http://www.freebsd.org/releases/9.3R/hardware.html#ETHERNET>`_
of the FreeBSD Hardware Notes indicates which interfaces are supported by each driver. While many interfaces are supported, FreeNAS® users have seen the best
performance from Intel and Chelsio interfaces, so consider these brands if you are purchasing a new NIC. Realteks will perform poorly under CPU load as
interfaces with these chipsets do not provide their own processors.

At a minimum, a GigE interface is recommended. While GigE interfaces and switches are affordable for home use, modern disks can easily saturate 110 MB/s. If
you require higher network throughput, you can bond multiple GigE cards together using the LACP type of :ref:`Link Aggregations`. However, the switch will
need to support LACP which means you will need a more expensive managed switch.

If network performance is a requirement and you have some money to spend, use 10 GigE interfaces and a managed switch. If you are purchasing a managed switch,
consider one that supports LACP and jumbo frames as both can be used to increase network throughput.

.. note:: at this time the following are not supported: InfiniBand, FibreChannel over Ethernet, or wireless interfaces.

If network speed is a requirement, consider both your hardware and the type of shares that you create. On the same hardware, CIFS will be slower than FTP or
NFS as Samba is
`single-threaded <http://www.samba.org/samba/docs/man/Samba-Developers-Guide/architecture.html>`_. If you will be using CIFS, use a fast CPU.

Wake on LAN (WOL) support is dependent upon the FreeBSD driver for the interface. If the driver supports WOL, it can be enabled using
`ifconfig(8) <http://www.freebsd.org/cgi/man.cgi?query=ifconfig>`_. To determine if WOL is supported on a particular interface, specify the interface name to
the following command. In this example, the capabilities line indicates that WOL is supported for the *re0* interface::

 ifconfig -m re0
 re0: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> metric 0 mtu 1500
 options=42098<VLAN_MTU,VLAN_HWTAGGING,VLAN_HWCSUM,WOL_MAGIC,VLAN_HWTSO>
 capabilities=5399b<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING,VLAN_HWCSUM,TSO4,WOL_UCAST,WOL_MCAST, WOL_MAGIC,VLAN_HWFILTER,VLAN_H WTSO>

If you find that WOL support is indicated but not working for a particular interface, create a bug report using the instructions in :ref:`Report a Bug`.

.. include:: zfsprimer.rst