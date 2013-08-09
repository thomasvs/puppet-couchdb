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
  couchdb::config {$name:
    port               => $port,
    bind_address       => $bind_address,
    ssl_cert_file      => $ssl_cert_file,
    ssl_key_file       => $ssl_key_file,
    ssl_port           => $ssl_port,
    query_servers      => $query_servers,
    admins             => $admins,
    require_valid_user => $require_valid_user
  }
  couchdb::service {$name: }
}
