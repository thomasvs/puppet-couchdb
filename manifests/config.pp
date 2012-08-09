define couchdb::config ($port=5984, $query_servers=[]) {
    $owner    = 'couchdb'
    $group    = 'root'
    $mode     = '0644'
    $dirowner = 'couchdb'
    $dirmode  = '0755'

    include couchdb::install

    file { "/etc/$name":
        ensure  => directory,
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
    }

    file { "/etc/$name/local.ini":
        ensure  => file,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
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
        ensure  => directory,
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
    }

    file { "/var/log/$name":
        ensure  => directory,
        owner   => $dirowner,
        group   => $group,
        mode    => $dirmode,
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
