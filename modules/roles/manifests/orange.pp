class roles::orange {
  #include base hadoop settings
  include profiles::hadoop_base

  include hadoop::namenode
  include hadoop::datanode
  include hadoop::nodemanager

  #set zookeeper settings
  include profiles::zookeeper_base
  include hadoop::zkfc

  #include mysql
  include profiles::mysql_base

  #include hive
  #make sure hive sets up after hadoop
  Class['hadoop::namenode::service'] -> Class['hive::metastore::service']
  include profiles::hive_base

  include hive::hdfs
  #server
  include hive::metastore
  include hive::server2
  #client
  include hive::frontend
  #worker nodes
  include hive::worker

  #include impala
  #include impala::hdfs
}
