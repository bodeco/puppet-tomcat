define tomcat::lib (
  $mode    = '0644',
  $source  = undef,
  $content = undef,
) {
  if !$source and !$content {
    fail("Must provide source or content for tomcat::conf ${name}")
  }

  file { "${tomcat::path}/lib/${name}":
    owner   => $tomcat::user,
    group   => $tomcat::group,
    mode    => $mode,
    source  => $source,
    content => $content,
    require => File[$tomcat::path],
    notify  => Service['tomcat'],
  }
}
