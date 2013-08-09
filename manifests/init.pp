define couchdb (
  $port=5984,
  $query_servers=[],
  $admins={},
  $require_valid_user=undef
) {
  couchdb::config {$name:
    port               => $port,
    query_servers      => $query_servers,
    admins             => $admins,
    require_valid_user => $require_valid_user
  }
  couchdb::service {$name: }
}
