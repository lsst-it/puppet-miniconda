# @summary Ensure miniconda is installed
#
# Ensure miniconda is installed
#
# @example
#   include miniconda::install
class miniconda::install {

  $installer_url = lookup( 'miniconda::installer_url' )
  $conda_root = lookup( 'miniconda::conda_root' )

  exec { 'install miniconda' :
    command => "curl -fsSL ${installer_url} | bash -s -- -b -f -p ${conda_root}",
    creates => $conda_root,
  }

}
