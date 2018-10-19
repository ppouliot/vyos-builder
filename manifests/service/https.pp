# define vyatta::service::https
define vyatta::service::https (
  $ensure = present,
  $https = $name,
  $configuration = {},
) {
  concat::fragment { "https_${https}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/https.erb'),
    order   => 401,
  }
}
