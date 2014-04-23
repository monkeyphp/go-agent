#
# Cookbook Name:: go-agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# http://www.thoughtworks.com/products/docs/go/13.4/help/installing_go_agent.html

# $ wget http://download01.thoughtworks.com/go/13.4.1/ga/go-agent-13.4.1-18342.deb

package "openjdk-7-jre" do
    action :install
end

package "unzip" do
    action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/go-agent.deb" do
    source "http://download01.thoughtworks.com/go/13.4.1/ga/go-agent-13.4.1-18342.deb"
end

package "go-server" do
    source "#{Chef::Config[:file_cache_path]}/go-agent.deb"
    provider Chef::Provider::Package::Dpkg
    action :install
end