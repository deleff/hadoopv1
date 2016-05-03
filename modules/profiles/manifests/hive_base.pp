class profiles::hive_base ( $quorum_hostnames = hiera('quorum_hostnames'),
				$hivepassword = hiera('hivepassword'),
				$dbpassword = hiera('dbpassword'),
		$hive_path = '/usr/lib/hive/scripts/metastore/upgrade/mysql',
		$hive_schema = 'hive-schema-1.1.0.mysql.sql',

				) {

  class {"hive":
    hdfs_hostname	=> $::fqdn,
    metastore_hostname	=> $::fqdn,
    server2_hostname	=> $::fqdn,
    zookeeper_hostnames	=> $quorum_hosts,

    #enable hadoop (see hadoop_base module for settings)
    group		=> 'users',
    realm		=> 'MY.REALM', #maybe it should be '' ?
    

    #enable Hive to work with mysql
    db			=> 'mysql',
    db_password		=> $dbpassword,
  }

  Class['hive::metastore::install']
  ->
  exec{ 'hive-bug':
    command	=> "sed -i ${hive_path}/${hive_schema} -e 's, ^SOURCE hive,SOURCE ${hive_path}/hive,'",
    unless	=> "grep 'SOURCE ${hive_path}' ${hive_path}/${hive_schema}",
    path	=> '/sbin:/usr/sbin:/bin:/usr/bin',
    }
  ->
  mysql::db {'metastore':
    user	=> 'hive',
    password	=> $hivepassword, #possibly "${hivepassword}" ?
    grant	=> ['SELECT', 'INSERT', 'UPDATE', DELETE'],
    sql		=> "${hive_path}/${hive_schema}",
    }

  class {'mysql::bindings':
    java_enable	=> true,
  }

  Mysql::Db['metastore' -> Class['hive::metastore::service']
  Class['mysql::bindings'] -> Class['hive::metastore::config']

}
