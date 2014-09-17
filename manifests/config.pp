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
# [* ssl_cert_file *]
#   The SSL certificate file to use for SSL, in .pem format
#
# [* ssl_key *]
#   The SSL key file to use for SSL, in .pem format
#
# [* ssl_port *]
#   The SSL port to run CouchDB on.
#   Default: 6984
#
# [* bind_address *]
#   The address for CouchDB to bind to.
#   Default: 127.0.0.1
#
# [* query_servers *]
#   A list of additional query servers to run.
#   The format is: language = binary
#
# [* admins *]
#   A hash of usernames and passwords for admin accounts;
#   the password can be plaintext, in which case couchdb will rewrite it,
#   or hashed.
#
# [* require_valid_user *]
#   Whether you require a valid user to access the database
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
define couchdb::config (
  $port=5984,
  $bind_address=undef,
  $ssl_cert_file=undef,
  $ssl_key_file=undef,
  $ssl_port=undef,
  $query_servers=[],
  $admins={},
  $require_valid_user=undef
) {
  $owner    = 'couchdb'
  $group    = 'root'
  $mode     = '0644'
  $dirowner = 'couchdb'
  $dirmode  = '0755'

  if $name !~ /^couchdb/ {
    fail("Couchdb::Config[${name}]: namevar must start with couchdb")
  }
  if bool2num($ssl_cert_file == undef) + bool2num($ssl_key_file == undef) == 1 {
    fail('Couchdb::Config: specify both ssl_cert_file and ssl_key_file')
  }

  couchdb::install { $name: }

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
      Couchdb::Install[$name],
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

  # if it's not the standard service name, install the logrotate script
  if $name != 'couchdb' {
    file { "/etc/logrotate.d/${name}":
      ensure  => file,
      content => template('couchdb/logrotate.d/couchdb.erb')
    }
  }
}
