class couchdb::install {
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
