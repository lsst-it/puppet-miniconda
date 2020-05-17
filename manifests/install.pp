# @summary Ensure miniconda is installed
#
# Ensure miniconda is installed
#
# @example
#   include miniconda::install
class miniconda::install {

  $installer_url = lookup( 'miniconda::installer_url' )
  $conda_root    = lookup( 'miniconda::conda_root' )

  $_installer_fn = '/root/install_miniconda.sh'

  exec { 'miniconda - run installer' :
    command => "/bin/bash ${_installer_fn} -b -f -p ${conda_root}",
    creates => $conda_root,
    require => Exec[ 'miniconda - download installer' ],
  }

  exec { 'miniconda - download installer' :
    command => "/bin/curl -fsSL -o ${_installer_fn} ${installer_url}",
    creates => $_installer_fn,
  }

}
