include 'tomcat'

tomcat::lib { 'jta-1.1.jar':
  source => 'puppet:///modules/tomcat/jta-1.1.jar',
}
