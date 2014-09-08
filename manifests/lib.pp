# Tomcat lib files
define tomcat::lib (
  $mode          = '0644',
  $source        = undef,
  $content       = undef,
  $checksum      = undef,
  $checksum_type = undef,
) {
  if !$source and !$content {
    fail("Must provide source or content for tomcat::conf ${name}")
  }

  if source =~ /^puppet/ {
    file { "${tomcat::path}/lib/${name}":
      owner   => $tomcat::user,
      group   => $tomcat::group,
      mode    => $mode,
      source  => $source,
      content => $content,
      require => File[$tomcat::path],
      notify  => Service['tomcat'],
    }
  } else {
    archive { "${tomcat::path}/lib/${name}":
      source        => $source,
      checksum      => $checksum,
      checksum_type => $checksum_type,
      extract       => false,
      require       => File[$tomcat::path],
    }

    file { "${tomcat::path}/lib/${name}":
      owner   => $tomcat::user,
      group   => $tomcat::group,
      mode    => $mode,
      require => Archive["${tomcat::path}/lib/${name}"],
      notify  => Service['tomcat'],
    }
  }
}
