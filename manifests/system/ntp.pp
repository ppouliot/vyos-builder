# define vyatta::system::ntp
define vyatta::system::ntp (
  $configuration,
  $ensure = present,
  $ntp = $name,
) {
  concat::fragment { "ntp_${server}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/ntp.erb'),
    order   => 506,
  }
}
