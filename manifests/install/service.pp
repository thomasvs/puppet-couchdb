# = Class: couchdb::install::service
#
# This class makes sure that an /etc/rc.d/init.d/couchdb exists.
# In CentOS 7, systemd is now used, and until we adapt its package
# to allow for multiple instances, we need the old service script
# to symlink to.
#
class couchdb::install::service {
  case $operatingsystem {
    /CentOS/, /RedHat/: {
      if ($operatingsystemmajrelease >= 7) {
        file { '/etc/rc.d/init.d/couchdb':
          ensure => present,
          owner  => root,
          group  => root,
          mode   => 0755,
          source => 'puppet:///modules/couchdb/install/service'
        }
      }
    }
  }
  
}
