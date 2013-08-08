define couchdb (
  $port=5984,
  $query_servers=[],
  $admins={}
) {
  couchdb::config {$name:
    port          => $port,
    query_servers => $query_servers,
    admins        => $admins,
  }
  couchdb::service {$name: }
}
