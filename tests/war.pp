include '::tomcat'

tomcat::war { 'demo.war':
  source => 'puppet:///modules/tomcat/demo.war',
}
