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

case node["platform"]

when "centos"

    package "java-1.7.0-openjdk" do
        action :install
        provider Chef::Provider::Package::Yum
        
    end
    
    cookbook_file "go-agent-14.1.0-18882.noarch.rpm" do
        path "/tmp/go-agent.rpm"
        action :create_if_missing
    end
    
    service "go-agent" do
        supports :start => true, :stop => true, :restart => true, :status => true
        action :nothing
    end
    
    execute "install_go-agent" do
        command "sudo rpm -Uhv /tmp/go-agent.rpm" 
        action :run
        notifies :start, resources(:service => "go-agent")
    end


when "ubuntu", "debian"

    package "openjdk-7-jre" do
        action :install
    end

    package "unzip" do
        action :install
    end

    remote_file "#{Chef::Config[:file_cache_path]}/go-agent.deb" do
        source "http://download01.thoughtworks.com/go/14.1.0/ga/go-agent-14.1.0-18882.deb"
    end
    
    service "go-agent" do
        supports :start => true, :stop => true, :restart => true, :status => true
        action :nothing
    end
    
    execute "install_go-agent" do
        command "sudo dpkg -i #{Chef::Config[:file_cache_path]}/go-agent.deb" 
        action :run
        notifies :start, resources(:service => "go-agent")
    end

end
