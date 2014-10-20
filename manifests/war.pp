# Tomcat war file
define tomcat::war (
  $source,
  $checksum      = undef,
  $checksum_type = undef,
) {

  tomcat::conf { "webapps/${name}":
    source        => $source,
    checksum      => $checksum,
    checksum_type => $checksum_type,
  }
}
