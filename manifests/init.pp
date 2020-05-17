# @summary Ensure miniconda is installed
#
# Ensure miniconda is installed
#
# @param conda_root
#   Path to where conda will be installed.
#   Defaults to `/opt/miniconda`
#
# @param installer_url
#   URL for miniconda3 installer shell script.
#   Defaults to `https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`
#
# @example
#   include miniconda
class miniconda (
  String[1] $conda_root,
  String[1] $installer_url,
) {
    Exec { path => "${conda_root}/bin:/usr/bin:/usr/sbin/:/bin:/sbin" }
    include ::miniconda::install
}
