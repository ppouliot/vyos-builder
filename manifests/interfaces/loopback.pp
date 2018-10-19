# Define vyatta::interfaces::loopback
define vyatta::interfaces::loopback (
  $configuration,
  $ensure = present,
  $loopback = $name,
) {
  concat::fragment { "loopback_${loopback}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/loopback.erb'),
    order   => 201,
  }
}
