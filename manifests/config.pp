class tomcat::config {
  $user  = $tomcat::user
  $group = $tomcat::group

  $use_http_only = $tomcat::use_http_only
}
