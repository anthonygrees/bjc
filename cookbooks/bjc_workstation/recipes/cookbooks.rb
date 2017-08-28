#
# Cookbook Name:: bjc_workstation
# Recipe:: cookbooks
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

windows_path 'C:\\Program Files\\Git\\cmd\\' do
  action :add
end

git "#{Chef::Config[:file_cache_path]}/bjc" do
  repository 'https://github.com/chef-cft/bjc'
  revision 'rycar/add_dca'
  action :sync
end

directory "#{home}/cookbooks" do
  action :create
end

directory "#{home}/dca" do
  action :create
end

cookbook_file "#{home}/dca/linux_baseline_wrapper-0.1.0.tar.gz" do
  source 'linux_baseline_wrapper-0.1.0.tar.gz'
  mode '0644'
end

node['bjc_workstation']['cookbooks'].each do |cb|
  execute "Copy cookbooks into home directory" do
    action :run
    command "xcopy /E /I /Q /Y \"#{Chef::Config[:file_cache_path]}\\bjc\\cookbooks\\#{cb}\" \"#{home}\\cookbooks\\#{cb}\""
  end
end

template "#{home}/cookbooks/bjc-ecommerce/.kitchen.yml" do
  action :create
  source 'kitchen_ecom.yml.erb'
end

# This puts a minimal working git config and commit history in place
cookbook_file "#{home}/git_dir.zip" do
  action :create
  source 'git_dir.zip'
end

windows_zipfile "#{home}/cookbooks/bjc-ecommerce" do
  action :unzip
  overwrite true
  source "#{home}/git_dir.zip"
end
