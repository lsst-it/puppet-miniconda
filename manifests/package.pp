# Install a miniconda package
#
# @example
#   miniconda::package { 'pkgname': }
define miniconda::package (
) {

  # conda_root is hardcoded in lib/facter/installed_pkg_versions
  # $conda_root = lookup( 'miniconda::conda_root' )
  $conda_root = '/opt/miniconda'

  # split pkgname from version
  $_parts = split( $name, /=+/ )
  # conda reports pkg names in all lowercase
  $pkg_name = $_parts[0].downcase()
  $req_ver = $_parts[1]
  # cur_ver will be undef if key is not found
  $cur_ver = $facts['miniconda_installed_pkg_versions'] ? {
    Hash    => $facts['miniconda_installed_pkg_versions'][$pkg_name],
    default => undef,
  }
#  notify {"REQUEST package '${pkg_name}' req_ver='${req_ver}' cur_ver='${cur_ver}'" : }
  if ! $cur_ver {
#    notify {"NEEDS INSTALL '${pkg_name}' (cur_ver empty)" : }
    $_needs_install = true
  } elsif $req_ver {
    if ! $cur_ver.match("\A${req_ver}") {
#      notify {"NEEDS INSTALL '${pkg_name}' (version mismatch)" : }
      $_needs_install = true
    }
  }

  if $_needs_install {
#    notify {"INSTALL package '${name}'" : }
    exec { "miniconda_package_${name}" :
      command => "conda install --yes --quiet ${name}",
      require => [ Class[ 'miniconda::install', 'miniconda::jq' ] ],
      path    => [ "${conda_root}/bin", '/bin', ]
    }
  }

}

