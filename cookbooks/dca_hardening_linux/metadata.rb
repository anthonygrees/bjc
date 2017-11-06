name 'dca_hardening_linux'
maintainer 'Nick Rycar'
maintainer_email 'nrycar@chef.io'
license 'All Rights Reserved'
description 'Linux Baseline Hardening'
long_description 'Updates Linux security configs per industry best practices.'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'os-hardening'

%w( centos ubuntu ).each do |os|
  supports os
end
