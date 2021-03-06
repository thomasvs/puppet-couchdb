# = Define couchdb::install
#
# This define installs one instance of couchdb
# This class is a define because it might create multiple service instances.
#
# == Author
#   Thomas Vander Stichele (thomas (at) apestaart (dot) org
#
define couchdb::install (
) {

  if $name !~ /^couchdb/ {
    fail("Couchdb::Config[${name}]: namevar must start with couchdb")
  }

  include couchdb::install::all

  couchdb::install::one { $name: }
}
