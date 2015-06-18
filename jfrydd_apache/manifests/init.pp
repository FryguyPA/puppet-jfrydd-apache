class jfrydd_apache (
 $vhost,
 $docroot,
 $source_repo,
 ){
  # Include the apache class to install the packages etc.
  class{'apache':}

  # Deefine a name based VirutalHost
  apache::vhost { $vhost:
   port	   => '80',
   docroot => $docroot,
   }
 
 # Install the git package for vscrepo
 package{'git':
  ensure => present,
  }

  # Clone the site content into place
  vcsrepo { $docroot:
  	owner    => 'apache',
  	group    => 'apache',
  	provider => git,
  	source   => $source_repo,
  }

# Ensure things fire off in the correct order
Class['apache'] -> Apache::Vhost[$vhost] -> Vcsrepo[$docroot]
Package['git'] -> Vcsrepo[$docroot]

}