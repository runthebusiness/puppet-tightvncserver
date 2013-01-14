# Class: tightvnc::params
#
# Params for tightvnc
#
# Parameters:
#
# Sample Usage:
#
class tightvncserver::params {
	$execlaunchpaths = ["/usr/bin", "/usr/sbin", "/bin", "/sbin", "/etc"]
	$executefrom = "/tmp/"
	
	case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      #TODO: Confirm flavors
      $initdpath='/etc/init.d/tightvncserver'
      $triggeronstartupexec='update-rc.d tightvncserver defaults'
    }
    'ubuntu', 'debian': {
      $initdpath='/etc/init.d/tightvncserver'
      $triggeronstartupexec='update-rc.d tightvncserver defaults'
    }
    default: {
      $initdpath='/etc/init.d/tightvncserver'
      $triggeronstartupexec='update-rc.d tightvncserver defaults'
    }
  }
}
