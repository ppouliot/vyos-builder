# Define:  vyatta::interfaces::ethernet
define vyatta::interfaces::ethernet (
  $configuration,
  $ensure = present,
  $ethernet = $name,
) {
  include vyatta
  concat::fragment { "interfaces_${ethernet}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/ethernet.erb'),
    order   => 201,
  }
}
