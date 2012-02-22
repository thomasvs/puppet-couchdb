define couchdb::service () {
    service { $name:
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        enable => true,
        require => Couchdb::Config[$name],
    }
}
