define vyatta::system::login (
  $ensure = present,
  $configuration,
  $login = $name,
) {
  concat::fragment { "login_${login}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/login.erb'),
    order   => 502,
  }
}
