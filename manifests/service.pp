class tomcat::service {
  $java_xms           = $tomcat::java_xms
  $java_xmx           = $tomcat::java_xmx
  $java_max_perm_size = $tomcat::java_max_perm_size
  $java_options       = $tomcat::java_options

  $java_home = '/usr/java/latest'
  $catalina_base = '/opt/tomcat'
  $java_opts = "-Xms${java_xms} -Xmx${java_xmx} -XX:MaxPermSize=${java_max_perm_size} ${java_options}"

  file { '/etc/init.d/tomcat':
    content => template('tomcat/tomcat.init.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  service { 'tomcat':
    ensure => running,
    enable => true,
    require => File['/etc/init.d/tomcat'],
  }
}
