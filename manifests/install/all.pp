# = Class couchdb::install::all
#
# This class installs everything needed for any of the CouchDB instances.
#
class couchdb::install::all {
  package { 'couchdb':
    ensure  => present,
    require => User['couchdb'],
  }

  user { 'couchdb':
    ensure  => present,
    comment => 'Couchdb Database Server',
    gid     => 'couchdb',
    home    => '/var/lib/couchdb',
    require => Group['couchdb'],
  }

  group { 'couchdb':
    ensure => present,
  }
}
