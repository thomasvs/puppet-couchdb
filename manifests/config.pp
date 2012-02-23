define couchdb::config ($port=5984, $query_servers=[]) {
    $owner    = 'couchdb'
    $group    = 'root'
    $mode     = '0644'
    $dirowner = 'couchdb'
    $dirmode  = '0755'

    include couchdb::install

    file { "/etc/$name":
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
        ensure  => directory,
    }

    file { "/etc/$name/local.ini":
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        ensure  => file,
        content => template('couchdb/local.ini.erb'),
        require => [
            File["/etc/$name"],
            File["/var/lib/$name"],
            File["/var/log/$name"],
            File["/etc/rc.d/init.d/$name"],
            Class['couchdb::install'],
        ],
        notify => Couchdb::Service[$name],
    }

    file { "/var/lib/$name":
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
        ensure  => directory,
    }

    file { "/var/log/$name":
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
        ensure  => directory,
    }

    # if it's not the standard service name, symlink the new service script
    if $name != 'couchdb' {
        file { "/etc/rc.d/init.d/$name":
            ensure => link,
            target => 'couchdb',
        }
    } else {
        file { "/etc/rc.d/init.d/$name":
            require  => Class['couchdb::install'],
        }
    }
}
