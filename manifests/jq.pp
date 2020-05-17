# @summary Ensure jq is available for miniconda::package
#
# Ensure jq is available for miniconda::package
#
# @param url
#   URL to download jq binary
#
# @param install_dir
#   OPTIONAL
#   Where to install jq binary file.
#   Defaults to ${conda_root}/bin
#
#
# @example
#   include miniconda::jq
class miniconda::jq (
  String             $url,
  Optional[ String ] $install_dir,
) {

  $_tgt = "${install_dir}/jq"
  exec { 'puppet-miniconda requires jq' :
    command => "curl -fsSL -o ${_tgt} ${url}",
    creates => $_tgt,
    require => [ Class[ 'miniconda::install' ] ]
  }
}
