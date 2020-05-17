# @summary Install a miniconda package
#
# Install a miniconda package
#
# @example
#   miniconda::package { 'pkgname': }
define miniconda::package (
) {

  include ::miniconda

  $conda_root = lookup( 'miniconda::conda_root' )
  $conda = "${conda_root}/bin/conda"

  # Strip any version requirements from name
  $_parts = split( $name, '/=+/' )
  $_name = $_parts[0]

  exec { "miniconda_package_${name}" :
    command => "${conda} install --yes --quiet ${name}",
    unless  => "${conda} list --json -f ${_name} | jq '.[0].name == \"${_name}\"' | grep -F true",
    require => [ Class[ 'miniconda', 'miniconda::install' ] ],
  }
}
# Adds packages to an existing Conda env
# Need to add Version parameter

# Note: This can be very slow - it downloads packages from the Repo
define anaconda::package( $env=undef, $base_path='/opt/anaconda') {
    include anaconda
    
    $conda = "${base_path}/bin/conda"
        
    
    # Need environment option if env is set
    # Also requirement on the env being defined
    if $env {
        $env_option = "--name ${env}"
        $env_require = [Class["anaconda::install"], Anaconda::Env[$env] ]
        $env_name = "${env}"
    } else {
        $env_option = ''
        $env_name = "root"
        $env_require = [Class["anaconda::install"]]
    }
    
    
    exec { "anaconda_${env_name}_${name}":
        command => "${conda} install --yes --quiet ${env_option} ${name}",
        require => $env_require,
        
        # Ugly way to check if package is already installed
        # bug: conda list returns 0 no matter what so we grep output
        unless  => "${conda} list ${env_option} ${name} | grep -q -w -i '${name}'",
    }
}
