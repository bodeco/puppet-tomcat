class tomcat (
  $version            = '6.0.41',
  $url                = 'http://apache.mirrors.hoobly.com/tomcat',
  $user               = 'tomcat',
  $group              = 'tomcat',
  $path               = '/opt/tomcat',
  $use_http_only      = false,
  $java_xms           = '1536m',
  $java_xmx           = '1536m',
  $java_max_perm_size = '256m',
  $java_options       = '-Djava.awt.headless = true',
) {
  require 'java'

  include 'tomcat::install'
  include 'tomcat::config'
  include 'tomcat::service'

  Class['tomcat::install'] -> Class['tomcat::config'] ~> Class['tomcat::service']
}
