### PROVIDER
provider "google" {
    project = "terraform-benny"
    region = "asia-south1"
    zone = "asia-south1-a"
}

### NETWORK
data "google_compute_network" "default" {
  name = "default"
}

### SUBNET
resource "google_compute_subnetwork" "subnet-1" {
  name = "subnet1"
  ip_cidr_range = "10.127.0.0/20"
  network = data.google_compute_network.default.self_link
  region = "asia-south1"
  private_ip_google_access = true
}

### FIREWALL
resource "google_compute_firewall" "default" {
  name = "benny-firewall"
  network = data.google_compute_network.default.self_link

allow {
  protocol = "icmp"
}

allow {
  protocol = "tcp"
  ports = [ "80", "8080", "1000-2000", "22" ]
}

source_tags = [ "web", "firewall", "benny" ]
}

### NGINX
resource "google_compute_instance" "nginx_instance" {
  name = "nginx-proxy"
  machine_type = "f1-micro"
  tags = [ "nginx", "terraform", "benny" ]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
    access_config {
      
    }
  }
}

### WEB SERVER 1
resource "google_compute_instance" "web1" {
  name = "web1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}

### WEB SERVER 2
resource "google_compute_instance" "web2" {
  name = "web2"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}

### WEB SERVER 3
resource "google_compute_instance" "web3" {
  name = "web3"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}

### MYSQL Server
resource "google_compute_instance" "mysqldb" {
  name = "mysqldb"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}
