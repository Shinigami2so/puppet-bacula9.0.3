# bacula_9
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bacula_9
class bacula_9 {

# Copy installation script to node
file { 'install script':
ensure => file,
path   => '/root/bacula_install.sh',
owner  => root,
group  => root,
mode   => '0755',
source => 'puppet:///modules/bacula_9/bacula_install.sh',
}

# Create bacula-fd config file in the node
file {'/etc/bacula/bacula-fd.conf':
require  => Exec['/root/bacula_install.sh'],
content  => epp('bacula_9/bacula-fd.conf.epp'),
mode     => '0755',
owner    => root,
group    => root,
notify   => Service['bacula-fd'],
}

# Ensure bacula-fd is running only after installation script has run
service { 'bacula-fd':
ensure  => 'running',
require => Exec['/root/bacula_install.sh'],
enable  => true,
}

# Execute the installation script. Rerun only if the script has changed
exec { '/root/bacula_install.sh':
cwd         => '/root',
refreshonly => true,
}

# Open port 9102 on the firewall
exec { '/usr/sbin/ufw allow 9102':
cwd => '/root',
}

}
