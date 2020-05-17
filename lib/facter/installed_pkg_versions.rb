Facter.add('miniconda_installed_pkg_versions') do
  confine do
    Dir.exist? '/opt/miniconda'
  end

  setcode do
    require 'json'
    pkg_data = {}
    rawjson = Facter::Core::Execution.execute( '/opt/miniconda/bin/conda list --json' )
    a_of_h = JSON.parse( rawjson )
    a_of_h.each { |pkginfo|
      pkg_data[ pkginfo['name'] ] = pkginfo['version']
    }
    pkg_data
  end
end
