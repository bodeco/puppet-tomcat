define tomcat::war (
  $source,
) {
  file { "${tomcat::path}/webapps/${name}":
    owner   => $tomcat::user,
    group   => $tomcat::group,
    mode    => '0644',
    source  => $source,
    content => $content,
    require => File[$tomcat::path],
    notify  => Service['tomcat'],
  }
}

