# Outline VPN in GCP

---

## Step 0: Optional

```
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install wget
```

---

## Step 1: Create Firewall Rule

```
Name: outline-server
Target tags: outline
Source IP ranges: 0.0.0.0/0
Protocols and ports: Allow all
```

---

## Step 2: Create VM (Outline)

```
Name: outline-us

Network tags: outline
```

```
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"

{"apiUrl":"https://34.29.1.96:21209/j7hMDa1mKKsK9BfH_U-rfg","certSha256":"DAC339C66DF1116D6F3FE1BD72CF4AAC8AE924AC34B1AA74EC10F92973968A29"}
```

---

## Step 3: Open VPN

Google Marketplace
```
Admin Url: https://34.19.82.113:943/admin
Admin User: openvpn
Admin Password: LK2MuL9)[xo[
```