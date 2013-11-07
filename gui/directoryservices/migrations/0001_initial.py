# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'NT4'
        db.create_table(u'directoryservices_nt4', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('ds_type', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_name', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_enable', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('nt4_dcname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('nt4_netbiosname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('nt4_workgroup', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('nt4_adminname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('nt4_adminpw', self.gf('django.db.models.fields.CharField')(max_length=120)),
        ))
        db.send_create_signal(u'directoryservices', ['NT4'])

        # Adding model 'ActiveDirectory'
        db.create_table(u'directoryservices_activedirectory', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('ds_type', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_name', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_enable', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ad_domainname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ad_netbiosname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ad_workgroup', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ad_adminname', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ad_adminpw', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ad_verbose_logging', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ad_unix_extensions', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ad_allow_trusted_doms', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ad_use_default_domain', self.gf('django.db.models.fields.BooleanField')(default=True)),
            ('ad_dcname', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ad_gcname', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ad_krbname', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ad_kpwdname', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ad_timeout', self.gf('django.db.models.fields.IntegerField')(default=10)),
            ('ad_dns_timeout', self.gf('django.db.models.fields.IntegerField')(default=10)),
        ))
        db.send_create_signal(u'directoryservices', ['ActiveDirectory'])

        # Adding model 'NIS'
        db.create_table(u'directoryservices_nis', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('ds_type', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_name', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_enable', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('nis_domain', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('nis_servers', self.gf('django.db.models.fields.CharField')(max_length=8192, blank=True)),
            ('nis_secure_mode', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('nis_manycast', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal(u'directoryservices', ['NIS'])

        # Adding model 'LDAP'
        db.create_table(u'directoryservices_ldap', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('ds_type', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_name', self.gf('django.db.models.fields.CharField')(max_length=120)),
            ('ds_enable', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ldap_hostname', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_basedn', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_anonbind', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('ldap_rootbasedn', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_rootbindpw', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_pwencryption', self.gf('django.db.models.fields.CharField')(default='clear', max_length=120)),
            ('ldap_usersuffix', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_groupsuffix', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_passwordsuffix', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_machinesuffix', self.gf('django.db.models.fields.CharField')(max_length=120, blank=True)),
            ('ldap_ssl', self.gf('django.db.models.fields.CharField')(default='off', max_length=120)),
            ('ldap_tls_cacertfile', self.gf('django.db.models.fields.TextField')(blank=True)),
            ('ldap_options', self.gf('django.db.models.fields.TextField')(max_length=120, blank=True)),
        ))
        db.send_create_signal(u'directoryservices', ['LDAP'])


    def backwards(self, orm):
        # Deleting model 'NT4'
        db.delete_table(u'directoryservices_nt4')

        # Deleting model 'ActiveDirectory'
        db.delete_table(u'directoryservices_activedirectory')

        # Deleting model 'NIS'
        db.delete_table(u'directoryservices_nis')

        # Deleting model 'LDAP'
        db.delete_table(u'directoryservices_ldap')


    models = {
        u'directoryservices.activedirectory': {
            'Meta': {'object_name': 'ActiveDirectory'},
            'ad_adminname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ad_adminpw': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ad_allow_trusted_doms': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ad_dcname': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ad_dns_timeout': ('django.db.models.fields.IntegerField', [], {'default': '10'}),
            'ad_domainname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ad_gcname': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ad_kpwdname': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ad_krbname': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ad_netbiosname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ad_timeout': ('django.db.models.fields.IntegerField', [], {'default': '10'}),
            'ad_unix_extensions': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ad_use_default_domain': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'ad_verbose_logging': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ad_workgroup': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ds_enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ds_name': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ds_type': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        },
        u'directoryservices.ldap': {
            'Meta': {'object_name': 'LDAP'},
            'ds_enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ds_name': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ds_type': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'ldap_anonbind': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ldap_basedn': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_groupsuffix': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_hostname': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_machinesuffix': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_options': ('django.db.models.fields.TextField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_passwordsuffix': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_pwencryption': ('django.db.models.fields.CharField', [], {'default': "'clear'", 'max_length': '120'}),
            'ldap_rootbasedn': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_rootbindpw': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'}),
            'ldap_ssl': ('django.db.models.fields.CharField', [], {'default': "'off'", 'max_length': '120'}),
            'ldap_tls_cacertfile': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'ldap_usersuffix': ('django.db.models.fields.CharField', [], {'max_length': '120', 'blank': 'True'})
        },
        u'directoryservices.nis': {
            'Meta': {'object_name': 'NIS'},
            'ds_enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ds_name': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ds_type': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'nis_domain': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'nis_manycast': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'nis_secure_mode': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'nis_servers': ('django.db.models.fields.CharField', [], {'max_length': '8192', 'blank': 'True'})
        },
        u'directoryservices.nt4': {
            'Meta': {'object_name': 'NT4'},
            'ds_enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'ds_name': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'ds_type': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'nt4_adminname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'nt4_adminpw': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'nt4_dcname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'nt4_netbiosname': ('django.db.models.fields.CharField', [], {'max_length': '120'}),
            'nt4_workgroup': ('django.db.models.fields.CharField', [], {'max_length': '120'})
        }
    }

    complete_apps = ['directoryservices']