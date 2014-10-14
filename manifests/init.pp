# = Define couchdb
#
# This define sets up an instance of couchdb.
# This is a define because it can create multiple services.
#
# == Parameters
#
# [* namevar *]
#   name of the couchdb service.  Should start with 'couchdb'
#
# [* port *]
#   The normal HTTP port to run CouchDB on.
#   Default: 5984
#
# [* bind_address *]
#   The address for CouchDB to bind to.
#   Default: 127.0.0.1
#
# [* ssl_cert_file *]
#   The SSL certificate file to use for SSL, in .pem format
#
# [* ssl_key_file *]
#   The SSL key file to use for SSL, in .pem format
#
# [* ssl_port *]
#   The SSL port to run CouchDB on.
#   Default: undef
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
#     couchdb { 'couchdb-feat':
#        port => 5985,
#        query_servers => [
#            "python = /usr/bin/feat-couchpy",
#        ],
#    }
#
# == Dependencies
#    stdlib:  git://github.com/puppetlabs/puppetlabs-stdlib.git
#    selinux: git://github.com/thomasvs/puppet-selinux.git
#
# == Author
#   Thomas Vander Stichele (thomas (at) apestaart (dot) org
#
define couchdb (
  $port=5984,
  $bind_address=undef,
  $ssl_cert_file=undef,
  $ssl_key_file=undef,
  $ssl_port=undef,
  $query_servers=[],
  $admins={},
  $require_valid_user=undef
) {

  # config pulls in install
  couchdb::config { $name:
    port               => $port,
    bind_address       => $bind_address,
    ssl_cert_file      => $ssl_cert_file,
    ssl_key_file       => $ssl_key_file,
    ssl_port           => $ssl_port,
    query_servers      => $query_servers,
    admins             => $admins,
    require_valid_user => $require_valid_user
  }
  couchdb::service { $name: }
}
