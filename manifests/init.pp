define couchdb (
  $port=5984,
  $bind_address=undef,
  $query_servers=[],
  $admins={},
  $require_valid_user=undef
) {
  couchdb::config {$name:
    port               => $port,
    bind_address       => $bind_address,
    query_servers      => $query_servers,
    admins             => $admins,
    require_valid_user => $require_valid_user
  }
  couchdb::service {$name: }
}
