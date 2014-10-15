# = Define couchdb::install::one
#
# This define installs one instance of couchdb
# This class is a define because it can create multiple service instances.
#
# == Author
#   Thomas Vander Stichele (thomas (at) apestaart (dot) org
define couchdb::install::one (
) {

  include ::selinux

  if $name !~ /^couchdb/ {
    fail("Couchdb::Config[${name}]: namevar must start with couchdb")
  }

  couchdb::install::service::initinit { $name: }

  # set the same filecontext on named couchdb services as the original
  # couchdb directories
  selinux::filecontext { "/var/log/${name}":
    seltype => 'couchdb_log_t',
    recurse => true
  }

  selinux::filecontext { "/etc/${name}":
    seltype => 'couchdb_conf_t',
    recurse => true
  }

  selinux::filecontext { "/var/lib/${name}":
    seltype => 'couchdb_var_lib_t',
    recurse => true
  }
}
