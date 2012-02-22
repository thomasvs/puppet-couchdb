define couchdb ($port=5984) {
    couchdb::config {$name:
        port    => $port,
    }
    couchdb::service {$name: }
}
