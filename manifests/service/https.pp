define vyatta::service::https (
  $ensure = present,
  $configuration = {},
  $https = $name,
) {
  concat::fragment { "https_${https}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/https.erb'),
    order   => 401,
  }
}
