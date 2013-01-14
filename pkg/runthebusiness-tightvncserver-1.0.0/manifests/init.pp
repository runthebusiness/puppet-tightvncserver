# tightvncserver
#
# This class installs and configures tightvnc server
#
# Parameters:
# - $ensure: ensure value for tightvncserver (Default: 'present')
# - $runasservice: whether or not tightvnc server should start on boot and be runable as a service (Default: true)
# - $username: the username to put in the start up file (Default: 'pi')


define tightvncserver(
  $ensure='present',
  $runasservice=true,
  $username='pi',
  $password='changement'
) {
  
  include tightvncserver::params
  # install tightvncserver
  package{"${name}_tightvncserver":
    name=>'tightvncserver',
    ensure=>$ensure,
  }
  
  if $runasservice == true {
    $content = template('tightvncserver/tightvncserverinit.txt.erb')
    file{"${name}_tightvncserverinit":
      path=>"${tightvncserver::params::initdpath}",
      content=>$content,
      ensure=>'present',
      mode=>'777'
    }
    user {"${name}_tightvncuser":
	    ensure=>"present",
	    name=>$username,
	    managehome=>true,
	    require=>file["${name}_tightvncserverinit"],
	  }
    exec {"${name}_triggeronstartup":
      command=>$tightvncserver::params::triggeronstartupexec,
      cwd=> $rtb::params::executefrom,
      path=> $rtb::params::execlaunchpaths,
      require=>user["${name}_tightvncuser"],
      logoutput=> true,
    }
  } else {
    file{"${name}_tightvncserverinit":
      path=>"${tightvncserver::params::initdpath}",
      ensure=>'absent'
    }
  }
}
