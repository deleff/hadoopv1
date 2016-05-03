class profiles::zookeeper_base ( $quorum_hostnames = hiera('quorum_hostnames'),
					) {

  class {'zookeeper':
    hostnames 	=> $quorum_hostnames,
    realm	=> '',
  }


}
