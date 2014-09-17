# = Define couchdb::install::one
#
# This define installs one instance of couchdb
# This class is a define because it can create multiple service instances.
#
# == Author
#   Thomas Vander Stichele (thomas (at) apestaart (dot) org
define couchdb::install::one (
) {

  if $name !~ /^couchdb/ {
    fail("Couchdb::Config[${name}]: namevar must start with couchdb")
  }

  couchdb::install::service::initinit { $name: }
}
