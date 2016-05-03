class roles::blue {
  #include base hadoop settings
  include profiles::hadoop_base

  include hadoop::datanode
  include hadoop::nodemanager

  #include zookeeper
  include profiles::zookeeper_base

  #include hive user
  include profiles::hive_base
  include hive::user

}
