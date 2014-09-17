define couchdb::service () {

  include couchdb::params

  include couchdb::install::service

  if ($name != 'couchdb') {
    if $couchdb::params::service == 'systemd' {
      $service_name = regsubst($name, '^couchdb-', 'couchdb-instance@')
    } else {
      $service_name = $name
    }
  } else {
    $service_name = $name

  }
  service { $service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Couchdb::Config[$name],
  }
}
