# define vyatta::system::syslog
define vyatta::system::syslog (
  $configuration,
  $ensure = present,
  $syslog = $name,
) {
  concat::fragment { "syslog_${syslog}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/syslog.erb'),
    order   => 502,
  }
}
