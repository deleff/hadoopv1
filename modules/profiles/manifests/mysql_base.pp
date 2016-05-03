class profiles::mysql_base ( $mysql_password = hiera('mysql_password'),
				) {

  class {'mysql::server':
    root_password => $mysql_password,
  }

}
