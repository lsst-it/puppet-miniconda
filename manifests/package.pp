# @summary Install a miniconda package
#
# Install a miniconda package
#
# @example
#   miniconda::package { 'pkgname': }
define miniconda::package (
) {

  $conda_root = lookup( 'miniconda::conda_root' )
  $conda = "${conda_root}/bin/conda"

  $jq_install_dir = lookup( 'miniconda::jq::install_dir' )
  $jq = "${jq_install_dir}/jq"

  # Strip any version requirements from name
  $_parts = split( $name, '/=+/' )
  $_name = $_parts[0]

  exec { "miniconda_package_${name}" :
    command => "${conda} install --yes --quiet ${name}",
    unless  => "${conda} list --json -f ${_name} | ${jq} '.[0].name == \"${_name}\"' | grep -F true",
    require => [ Class[ 'miniconda::install', 'miniconda::jq' ] ],
  }
}
