# Tomcat confiuration
class tomcat::config {
  $user  = $tomcat::user
  $group = $tomcat::group

  $use_http_only = $tomcat::use_http_only

  datacat { "${tomcat::path}/conf/context.xml":
    template => 'tomcat/context.xml.erb',
  }

  datacat_fragment { 'use_http_only in tomcat context.xml':
    target => "${tomcat::path}/conf/context.xml",
    data   => {
      'use_http_only' => $use_http_only,
    }
  }
}
