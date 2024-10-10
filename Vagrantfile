# Vagrant.configure("2") do |config|
#   config.vm.define "debian" do |d|
#     d.vm.hostname = "debian-docker"
#     d.ssh.username = "root"
#     d.ssh.password = "root"
#     d.ssh.insert_key = false
#     d.ssh.host = "127.0.0.1"
#     d.ssh.port = 2200
#   end

#   config.vm.provider "docker" do |docker|
#     docker.build_dir = "."
#     docker.has_ssh = true
#     docker.ports = ["2200:22"]  # Redirige le port 2200 de l'hôte vers le port 22 du conteneur
#   end
# end

# Vagrant.configure("2") do |config|
#   config.vm.define "debian" do |d|
#     d.vm.hostname = "debian-docker"
#     d.ssh.username = "root"
#     d.ssh.password = "root"
#     d.ssh.insert_key = false
#     d.ssh.host = "127.0.0.1"
#     d.ssh.port = 2200
#   end

#   config.vm.provider "docker" do |docker|
#     docker.build_dir = "."
#     docker.has_ssh = true
#     docker.ports = ["2200:22"]  # Redirige le port 2200 de l'hôte vers le port 22 du conteneur
#   end
# end

Vagrant.configure("2") do |config|
  # Load Balancer
  config.vm.define "load_balancer" do |lb|
    lb.vm.provider "docker" do |docker|
      docker.build_dir = "./haproxy"
      docker.ports = ["80:80", "443:443"]
      # docker.remains_running = true
    end
  end

  # Web Server 1
  config.vm.define "web1" do |web1|
    web1.vm.provider "docker" do |docker|
      docker.build_dir = "./wordpress"
      docker.ports = ["8081:80"]
    end
  end

  # Web Server 2
  config.vm.define "web2" do |web2|
    web2.vm.provider "docker" do |docker|
      docker.build_dir = "./wordpress"
      docker.ports = ["8082:80"]
    end
  end

  # Database Server 1
  config.vm.define "db1" do |db1|
    db1.vm.provider "docker" do |docker|
      docker.build_dir = "./mariadb"
      docker.ports = ["3306:3306"]
    end
  end

  # Database Server 2
  config.vm.define "db2" do |db2|
    db2.vm.provider "docker" do |docker|
      docker.build_dir = "./mariadb"
      docker.ports = ["3307:3306"]
    end
  end

  # Monitoring Server - Graylog
  config.vm.define "graylog" do |graylog|
    graylog.vm.provider "docker" do |docker|
      docker.build_dir = "./graylog"
      docker.ports = ["9000:9000"]
    end
  end

  # Monitoring Server - Prometheus
  config.vm.define "prometheus" do |prometheus|
    prometheus.vm.provider "docker" do |docker|
      docker.build_dir = "./prometheus"
      docker.ports = ["9090:9090"]
    end
  end
end