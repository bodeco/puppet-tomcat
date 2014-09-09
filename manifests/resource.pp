# Tomcat resource
define tomcat::resource (
  $host,
  $port,
  $service,
  $username,
  $password,
  $full_name         = "jdbc/${name}",
  $auth              = 'Container',
  $type              = 'javax.sql.DataSource',
  $driver_class_name = 'oracle.jdbc.OracleDriver',
  $max_active        = '20',
  $max_idle          = '10',
  $max_wait          = '-1',
) {

  $data = {
    'resource' => {
      "${full_name}" => { # NOTE: ignore puppet-lint, must double quote variable in hash
        'auth'              => $auth,
        'type'              => $type,
        'driver_class_name' => $driver_class_name,
        'url'               => "jdbc:oracle:thin:@${host}:${port}:${service}",
        'username'          => $username,
        'password'          => $password,
        'max_active'        => $max_active,
        'max_idle'          => $max_idle,
        'max_wait'          => $max_wait,
      },
    },
  }

  datacat_fragment { "${name} resource in tomcat context.xml":
    target => "${::tomcat::path}/conf/context.xml",
    data   => $data,
  }
}
