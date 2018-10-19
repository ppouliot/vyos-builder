# define vyatta::system::package
define vyatta::system::package (
  $configuration,
  $ensure = present,
  $package = $name,
) {
  concat::fragment { "package_${package}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/package.erb'),
    order   => 509,
  }
}
