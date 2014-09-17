# = Class: couchdb::install::service::systemd
#
# This class makes sure that a systemd service script exists if needed.
# This is a class because only one service script needs to be installed
# for all instances
#
class couchdb::install::service::systemd {
  include couchdb::params

  if $couchdb::params::service == 'systemd' {
    file { '/lib/systemd/system/couchdb-instance@.service':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 0644,
      source  => 'puppet:///modules/couchdb/install/couchdb-instance@.service',
      require => Exec['couchdb::install::service-systemd-daemon-reload'],
    }

    exec { 'couchdb::install::service-systemd-daemon-reload':
      command     => '/usr/bin/systemctl daemon-reload',
      refreshonly => true,
    }

  }

}
