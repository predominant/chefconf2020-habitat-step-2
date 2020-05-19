Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  config.vm.synced_folder '.', '/chefconf2020'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '256'
  end

  config.vm.provision 'shell', inline: <<-SHELL
    /chefconf2020/scripts/install.sh
  SHELL

  config.vm.define 'master1' do |m|
    m.vm.network 'private_network', ip: '192.168.33.10'
    m.vm.hostname = 'master1'
  end

  # 3 web nodes
  (1..3).each do |i|
    config.vm.define "web#{i}" do |m|
      m.vm.network 'forwarded_port', guest: 8080, host: "8#{i}80"
      m.vm.network 'private_network', ip: "192.168.33.2#{i}"
      m.vm.hostname = "web#{i}"
      config.vm.provision 'shell', inline: <<-SHELL
        /chefconf2020/scripts/setup-bastion.sh
      SHELL
      end
  end

  # 2 load balancer nodes
  (1..2).each do |i|
    config.vm.define "lb#{i}" do |m|
      m.vm.network 'forwarded_port', guest: 8090, host: "8#{i}90"
      m.vm.network 'forwarded_port', guest: 8091, host: "8#{i}91"
      m.vm.network 'private_network', ip: "192.168.33.3#{i}"
      m.vm.hostname = "lb#{i}"
      config.vm.provision 'shell', inline: <<-SHELL
        /chefconf2020/scripts/setup-bastion.sh
      SHELL
    end
  end

  config.vm.provision 'shell', inline: <<-SHELL
    /chefconf2020/scripts/start-hab-sup.sh
  SHELL

  (1..3).each do |i|
    config.vm.define "web#{i}" do |m|
      m.vm.provision 'shell', inline: <<-SHELL
        hab svc load chefconf2020/mywebserver
      SHELL
    end
  end

  (1..2).each do |i|
    config.vm.define "lb#{i}" do |m|
      m.vm.provision 'shell', inline: <<-SHELL
        hab svc load chefconf2020/myloadbalancer --bind backend:mywebserver.default
      SHELL
    end
  end
end
