# = Define couchdb::config
#
# This define creates configuration for CouchDB.
# This class is a define because it can create multiple service
# configurations.
#
# == Parameters
#
# [* namevar *]
#   name of the couchdb service.  Should start with 'couchdb'
#
# [* port *]
#   The port to run CouchDB on.
#   Default: 5984
#
# [* query_servers *]
#   A list of additional query servers to run.
#   The format is: language = binary
#
# == Examples
#     couchdb::config { 'couchdb-feat':
#        port => 5985,
#        query_servers => [
#            "python = /usr/bin/feat-couchpy",
#        ],
#    }
#
# == Author
#   Thomas Vander Stichele (thomas (at) apestaart (dot) org
define couchdb::config ($port=5984, $query_servers=[]) {
  $owner    = 'couchdb'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'couchdb'
  $dirmode  = '0755'

  if $name !~ /^couchdb/ {
    fail("Couchdb::Config[${name}]: namevar must start with couchdb")
  }

  include couchdb::install

  file { "/etc/${name}":
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

  file { "/etc/${name}/local.ini":
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('couchdb/local.ini.erb'),
    require => [
      File["/etc/${name}"],
      File["/var/lib/${name}"],
      File["/var/log/${name}"],
      File["/etc/rc.d/init.d/${name}"],
      Class['couchdb::install'],
    ],
    notify  => Couchdb::Service[$name],
  }

  file { "/var/lib/${name}":
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

  file { "/var/log/${name}":
    ensure  => directory,
    owner   => $dirowner,
    group   => $group,
    mode    => $dirmode,
  }

  # if it's not the standard service name, symlink the new service script
  if $name != 'couchdb' {
    file { "/etc/rc.d/init.d/${name}":
      ensure => link,
      target => 'couchdb',
    }
  } else {
    file { "/etc/rc.d/init.d/${name}":
        require  => Class['couchdb::install'],
    }
  }
}
