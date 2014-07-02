# Tomcat installation
class tomcat::install {
  $version = $tomcat::version
  $url     = $tomcat::url
  $user    = $tomcat::user
  $group   = $tomcat::group

  $parse_version = split($version,'[.]')
  $major_ver = $parse_version[0]
  $tomcat_name = "apache-tomcat-${version}"
  $tomcat_file = "${tomcat_name}.tar.gz"
  $source = "${url}/tomcat-${major_ver}/v${version}/bin/${tomcat_file}"

  ensure_packages(['unzip', 'redhat-lsb-core'])

  user { $user:
    ensure => present,
    gid    => $group,
    home   => '/opt/tomcat',
  }

  group { $group:
    ensure => present,
  }

  staging::deploy { $tomcat_file:
    source  => $source,
    creates => "/opt/${tomcat_name}",
    target  => '/opt',
  }

  exec { 'tomcat owner':
    command     => "chown -R ${user}:${group} /opt/${tomcat_name}",
    path        => $::path,
    refreshonly => true,
    require     => User[$user], # Implicit group dependency.
    subscribe   => Staging::Deploy[$tomcat_file],
  }

  file { $tomcat::path:
    ensure  => symlink,
    owner   => $user,
    group   => $group,
    target  => "/opt/${tomcat_name}",
    require => Staging::Deploy[$tomcat_file],
  }
}
