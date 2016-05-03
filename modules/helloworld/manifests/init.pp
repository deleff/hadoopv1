class helloworld ( $msg = hiera('hellomsg') ){
  notify { $msg : }
}
