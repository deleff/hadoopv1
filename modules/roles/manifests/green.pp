class roles::green{
  #include base hadoop setup
  include profiles::hadoop_base

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::datanode
  include hadoop::nodemanager

  #specify zookeeper settings
  include profiles::zookeeper_base
  include hadoop::zkfc

  include ::impala::user
}
