# @summary Create miniconda config file and add cusomizations
#
# Create miniconda config file and add cusomizations
#
# @param channels
#   List of install channels.
#   Values can be any String that represents valid miniconda channel.
#
# @param settings
#   Hash of miniconda settings to put into the rcfile.
#   Keys and values are both strings.
#
# @param rcfile
#   Absolute path to rcfile.
#   If value does not start with a `/`, it will default to
#   `$conda_root/.condarc`.
#
# @example
#   include miniconda::config
class miniconda::config (
  Array               $channels,
  Hash[String,String] $settings,
  Optional[String]    $rcfile,
) {

  $conda_root = lookup( 'miniconda::conda_root' )

  $_rcfile = $rcfile ? {
    /^\//   => $rcfile,
    default => "${conda_root}/.condarc"
  }

  $_conf_data = $settings + { 'channels' => $channels }

  file { $_rcfile :
    ensure  => file,
    content => template( 'anaconda/condarc.erb' ),
  }

}
