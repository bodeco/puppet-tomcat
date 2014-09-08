# Tomcat war file
define tomcat::war (
  $source,
  $checksum      = undef,
  $checksum_type = undef,
) {
  $file_path = "${::tomcat::path}/webapps/${name}"
  $user = $::tomcat::user
  $group = $::tomcat::group

  if $source =~ /^puppet/ {
    file { $file_path,
      owner   => $user,
      group   => $group,
      mode    => '0644',
      source  => $source,
      require => File[$tomcat::path],
      notify  => Service['tomcat'],
    }
  } else {
    archive { $file_path:
      source        => $source,
      checksum      => $checksum,
      checksum_type => $checksum_type,
      extract       => false,
      require       => File[$tomcat::path],
    }

    file { $file_path:
      owner   => $user,
      group   => $group,
      mode    => '0644',
      require => Archive[$file_path],
      notify  => Service['tomcat'],
    }
  }
}
