# define vyatta::system::login
define vyatta::system::login (
  $configuration,
  $ensure = present,
  $login = $name,
) {
  concat::fragment { "login_${login}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/login.erb'),
    order   => 502,
  }
}
