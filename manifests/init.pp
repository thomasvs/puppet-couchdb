define couchdb ($port=5984, $query_servers=[]) {
  couchdb::config {$name:
    port          => $port,
    query_servers => $query_servers,
  }
  couchdb::service {$name: }
}
