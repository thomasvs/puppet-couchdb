class couchdb::config {
    $owner    = 'couchdb'
    $group    = 'root'
    $mode     = '0644'

    file { '/etc/couchdb/local.ini':
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        content => template('couchdb/local.ini.erb'),
    }
}
