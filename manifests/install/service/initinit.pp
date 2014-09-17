# = Define: couchdb::install::service::initinit
#
# This class makes sure that there is an init service script for the
# instance.
# This is a define because each instance needs its own service script.
#
# The name initinit is chosen to avoid clashing with puppet's init.pp meaning
#
define couchdb::install::service::initinit {

  include couchdb::params

  if ($name != 'couchdb') {
    if $couchdb::params::service == 'init' {
      file { "/etc/rc.d/init.d/${name}":
        ensure => present,
        owner  => root,
        group  => root,
        mode   => 0755,
        source => 'puppet:///modules/couchdb/install/service'
      }
    }
  }
}
