# = Class: couchdb::install::service
#
# This class makes sure that an /etc/rc.d/init.d/couchdb exists.
# In CentOS 7, systemd is now used, and until we adapt its package
# to allow for multiple instances, we need the old service script
# to symlink to.
#
class couchdb::install::service {
  include couchdb::params

  if $couchdb::params::service == 'systemd' {
    file { '/lib/systemd/system/couchdb-instance@.service':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      source  => 'puppet:///modules/couchdb/install/couchdb-instance@.service',
      require => Exec['couchdb::install::service-systemd-daemon-reload'],
    }

    exec { 'couchdb::install::service-systemd-daemon-reload':
      command     => '/usr/bin/systemctl daemon-reload',
      refreshonly => true,
    }

  }

}
