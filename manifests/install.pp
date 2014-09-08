# Tomcat installation
class tomcat::install {
  $version = $::tomcat::version
  $md5     = $::tomcat::md5
  $url     = $::tomcat::url
  $user    = $::tomcat::user
  $group   = $::tomcat::group

  $parse_version = split($version,'[.]')
  $major_ver = $parse_version[0]
  $tomcat_name = "apache-tomcat-${version}"
  $tomcat_file = "${tomcat_name}.tar.gz"
  $source = "${url}/tomcat-${major_ver}/v${version}/bin/${tomcat_file}"

  ensure_packages(['unzip', 'redhat-lsb-core'])

  user { $user:
    ensure => present,
    gid    => $group,
    home   => $tomcat::path,
  }

  group { $group:
    ensure => present,
  }

  if source =~ /^puppet/ {
    staging::deploy { $tomcat_file:
      source  => $source,
      creates => "/opt/${tomcat_name}",
      target  => '/opt',
      notify  => Exec['tomcat owner'],
      before  => File[$::tomcat::path],
    }
  } else {
    archive { "/opt/${tomcat_file}":
      source        => $source,
      checksum      => $md5,
      checksum_type => 'md5',
      extract       => true,
      extract_path  => '/opt',
      creates       => "/opt/${tomcat_name}",
      cleanup       => true,
      notify        => Exec['tomcat owner'],
      before        => File[$::tomcat::path],
    }
  }

  exec { 'tomcat owner':
    command     => "chown -R ${user}:${group} /opt/${tomcat_name}",
    path        => $::path,
    refreshonly => true,
    require     => User[$user], # Implicit group dependency.
  }

  file { $tomcat::path:
    ensure  => symlink,
    owner   => $user,
    group   => $group,
    target  => "/opt/${tomcat_name}",
  }
}
