# Define vyatta::interfaces::openvpn
define vyatta::interfaces::openvpn (
  $configuration,
  $ensure = present,
  $openvpn = $name,
) {
  concat::fragment { "interfaces_${openvpn}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/openvpn.erb'),
    order   => 201,
  }
}
