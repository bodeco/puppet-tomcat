# Tomcat conf files
define tomcat::conf (
  $mode          = '0644',
  $source        = undef,
  $content       = undef,
  $checksum      = undef,
  $checksum_type = undef,
) {
  $file_path = "${::tomcat::path}/${name}"
  $user = $::tomcat::user
  $group = $::tomcat::group

  if !$source and !$content {
    fail("Must provide source or content for tomcat::conf ${name}")
  }

  if $content or $source =~ /^puppet/ or $source =~ /^\// {
    file { $file_path:
      owner   => $user,
      group   => $group,
      mode    => $mode,
      source  => $source,
      content => $content,
      require => File[$::tomcat::path],
      notify  => Service['tomcat'],
    }
  } else {
    archive { $file_path:
      source        => $source,
      checksum      => $checksum,
      checksum_type => $checksum_type,
      extract       => false,
      require       => File[$::tomcat::path],
    }

    file { "${tomcat::path}/${name}":
      owner   => $user,
      group   => $group,
      mode    => $mode,
      require => Archive[$file_path],
      notify  => Service['tomcat'],
    }
  }
}
