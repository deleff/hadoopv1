class roles::pink {
  #include base hadoop settings
  include profiles::hadoop_base

  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::historyserver

}
