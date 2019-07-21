# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.define "dns-server" do |dns|
    dns.vm.hostname = "dns"
    dns.vm.provider :virtualbox do |vb| 
      vb.memory = 1024
      vb.cpus = 1
    end
    dns.vm.synced_folder "dns-server", "/dns-server"
    dns.vm.network "forwarded_port", guest: 53, host: 5353, host_ip: "127.0.0.1"
    dns.vm.network "private_network", ip: "192.168.33.10"
    dns.vm.provision :shell, path: "./dns-server/setup.bash"
  end
  config.vm.define "app1", autostart: false do |app|
    app.vm.hostname = "app1"
    app.vm.provider :virtualbox do |vb| 
      vb.memory = 1024
      vb.cpus = 1
    end
    app.vm.synced_folder "app", "/app"
    app.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    app.vm.network "private_network", ip: "192.168.33.11"
    app.vm.provision :shell, path: "./app/setup.bash"
  end
  config.vm.define "app2", autostart: false do |app|
    app.vm.hostname = "app2"
    app.vm.provider :virtualbox do |vb| 
      vb.memory = 1024
      vb.cpus = 1
    end
    app.vm.synced_folder "app", "/app"
    app.vm.network "forwarded_port", guest: 80, host: 8082, host_ip: "127.0.0.1"
    app.vm.network "private_network", ip: "192.168.33.12"
    app.vm.provision :shell, path: "./app/setup.bash"
  end
  config.vm.define "app3", autostart: false do |app|
    app.vm.hostname = "app3"
    app.vm.provider :virtualbox do |vb| 
      vb.memory = 1024
      vb.cpus = 1
    end
    app.vm.synced_folder "app", "/app"
    app.vm.network "forwarded_port", guest: 80, host: 8083, host_ip: "127.0.0.1"
    app.vm.network "private_network", ip: "192.168.33.13"
    app.vm.provision :shell, path: "./app/setup.bash"
  end
end
