class mellanox_openstack::cinder_iser (
  $iser_ip_address,
) {
  include cinder::params

  class { 'mellanox_openstack::cinder::cinder_conf' :
    iser_ip_address => $iser_ip_address,
  } ~>
  service { $cinder::params::volume_service :
    ensure => running
  }
}

class mellanox_openstack::cinder::cinder_conf (
  $iser_ip_address,
) {
  include cinder::params
  include mellanox_openstack::params

  cinder_config { 'DEFAULT/volume_driver' :
    value => 'cinder.volume.drivers.lvm.LVMISERDriver'
  }
  cinder_config { 'DEFAULT/iser_ip_address' :
    value => $iser_ip_address
  }
}


