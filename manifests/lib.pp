# Tomcat lib files
define tomcat::lib (
  $mode          = '0644',
  $source        = undef,
  $content       = undef,
  $checksum      = undef,
  $checksum_type = undef,
) {

  tomcat::conf { "lib/${name}":
    mode          => $mode,
    source        => $source,
    content       => $content,
    checksum      => $checksum,
    checksum_type => $checksum_type,
  }
}
