# Wraps the Tomcat war file management to facilitate pulling multiple WARs from the same location when used
# im a manner like this:
#
# tomcat::wars{['file1.war', 'file2.war']:
#   source => '/opt/temp/source_dir',
# }
#
# This usage does not provide the full set of features available from tomcat::war, such as checksum verification,
# but it does simplify the deployment of multiple WAR files from a common location.
define tomcat::wars(
  $source,
) {
  tomcat::war { $name :
    source => "${source}/${name}",
  }
}