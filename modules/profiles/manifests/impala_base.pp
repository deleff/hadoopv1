class profiles::impala_base (
				) {
  class { 'impala':

  }

  include ::impala::frontend
  include ::impala::statestore
  include ::impala::catalog
  include ::impala::server

Class['::hadoop::common::hdfs::config'] -> Class['::impala::common::config']
Class['::hbase::common::config'] -> Class['::impala::common::config']



}
