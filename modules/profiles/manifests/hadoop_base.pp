class profiles::hadoop_base ( 	$hdfs_hostname1   = hiera('hdfs_hostname1'),
				$hdfs_hostname2   = hiera('hdfs_hostname2'),
				$yarn_hostname    = hiera('yarn_hostname1'),
				$yarn_hostname2   = hiera('yarn_hostname2'),
				$historyserver1   = hiera('historyserver1'),
			     #  $httpfs_hostnames = hiera('httpfs_hostnames'),
				$slaves		  = hiera('slaves'),
				$frontends	  = hiera('frontends'),
				$quorum_hostnames = hiera('quorum_hostnames'),
				$cluster_name     = hiera('hadoop_clustername'),

				$hdfs_deployed 	  = hiera('hdfs_deployed'),
			$zookeeper_deployed 	= hiera('zookeeper_deployed'), 
				) {

  class {'hadoop':
    hdfs_hostname		=> $hdfs_hostname1,
    hdfs_hostname2		=> $hdfs_hostname2,
    yarn_hostname		=> $yarn_hostname1,
    yarn_hostname2		=> $yarn_hostname2,
    historyserver_hostname	=> $historyserver1,
  # httpfs_hostnames		=> $httpfs_hostnames,
    slaves			=> $slaves,
    frontends			=> $frontends,
    journalnode_hostnames	=> $quorum_hostnames,
    zookeeper_hostnames		=> $quorum_hostnames,
    cluster_name		=> $cluster_name,
    realm			=> '',

    hdfs_deployed		=> $hdfs_deployed,
    zookeeper_deployed		=> $zookeeper_deployed,

    #enabling hive
    properties			=> {
      'hadoop.proxyuser.hive.groups'	=> 'hive,users',
      'hadoop.proxyuser.hive.hosts'	=> '*',
'dfs.replication' => 1, 
     },

    #enabling impala
    impala_enable		=> true,
  }

}
