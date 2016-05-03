node 'orange01.example.com' {
include roles::orange
}

node default {
  
  class {"hadoop":
    hdfs_hostname => $::fqdn,
    yarn_hostname => $::fqdn,
    slaves => [ $::fqdn  ],
    frontends => [ $::fqdn ],
    properties => {
      'dfs.replication' => 1,
    },
  }

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend

  class {"hive":
    hdfs_hostname => $::fqdn,
    metastore_hostname => $::fqdn,
    server2_hostname => $::fqdn,
}

include ::hive::metastore
include ::hive::server2
include ::hive::frontend
include ::hive::hcatalog
include ::hive::worker
Class['hadoop::namenode::service'] -> Class['hive::metastore::service']

  class {'zookeeper':
    hostnames => [ $::fqdn ],
    realm => 'MY.REALM',
  }


 class {'impala':
 }
 include ::impala::frontend
 include ::impala::statestore
 include ::impala::catalog
 include ::impala::server

 Class['::hadoop::common::hdfs::config'] -> Class['::impala::common::config']

#if hbase is installed:
# Class['::hbase::common::config'] ->Class['::impala::common::config']

  include pig

}

