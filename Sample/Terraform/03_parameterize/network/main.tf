resource "google_compute_network" "mynetwork" {
  name                    = var.network_name_input
  auto_create_subnetworks = true
}
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name    = "${var.network_name_input}-allow-http-ssh-rdp-icmp"
  network = google_compute_network.mynetwork.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}