# Tomcat war file
define tomcat::war (
  $source,
  $checksum      = undef,
  $checksum_type = undef,
) {
  if source =~ /^puppet/ {
    file { "${tomcat::path}/webapps/${name}":
      owner   => $tomcat::user,
      group   => $tomcat::group,
      mode    => '0644',
      source  => $source,
      require => File[$tomcat::path],
      notify  => Service['tomcat'],
    }
  } else {
    archive { "${tomcat::path}/webapps/${name}":
      source        => $source,
      checksum      => $checksum,
      checksum_type => $checksum_type,
      extract       => false,
      require       => File[$tomcat::path],
    }

    file { "${tomcat::path}/webapps/${name}":
      owner   => $tomcat::user,
      group   => $tomcat::group,
      mode    => '0644',
      require => Archive["${tomcat::path}/webapps/${name}"],
      notify  => Service['tomcat'],
    }
  }
}
