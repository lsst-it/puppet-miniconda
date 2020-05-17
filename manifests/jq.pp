# @summary Ensure jq is available for miniconda::package
#
# Ensure jq is available for miniconda::package
#
# @param url
#   URL to download jq binary
#
#
# @example
#   include miniconda::jq
class miniconda::jq (
  String $url,
) {

  $conda_root = lookup( 'miniconda::conda_root' )
  $_tgt = "${conda_root}/bin/jq"

  # FAILS due to https://tickets.puppetlabs.com/browse/PUP-6380
  # file { $_tgt :
  #   ensure  => file,
  #   source  => $url,
  #   mode    => '0555',
  #   owner   => 'root',
  #   require => [ Class[ 'miniconda::install' ] ]
  # }

  # use curl to download jq
  exec { 'miniconda - puppet module requires jq' :
    command => "/bin/curl -fsSL -o ${_tgt} ${url}",
    creates => $_tgt,
    require => [ Class[ 'miniconda::install' ] ],
  }
  #
  # file resource ensures correct mode
  file { $_tgt :
    ensure  => file,
    mode    => '0555',
    owner   => 'root',
    require => [ Exec[ 'miniconda - puppet module requires jq' ] ],
  }

}
