include '::tomcat'

tomcat::resource { 'db1':
  host     => '191.168.1.1',
  port     => '1521',
  service  => 'orcl',
  username => 'user',
  password => 'password',
}
