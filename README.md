# miniconda

Install miniconda and provide an interface to install packages inside
miniconda.

## Dependencies
None
 
## Reference
 
### define miniconda::package (
### class miniconda (
-  String[1] $conda_root,
-  String[1] $installer_url,
### class miniconda::jq (
-  String             $url,
-  Optional[ String ] $install_dir,
### class miniconda::config (
-  Array               $channels,
-  Hash[String,String] $settings,
-  Optional[String]    $rcfile,

[REFERENCE.md](REFERENCE.md)
