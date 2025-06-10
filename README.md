# Why?
When you have your cloudflare domain pointed to a server that has a dynamic IP, it is difficult to update the DNS record everytime manually.

# Pre Requisites
- IPv6 support for the server
    - The primary reason for creating this solution is that my server is behind a CG-NAT (Carrier-Grade NAT) / double NAT (ACT Fibernet 🤡). This configuration prevents port forwarding, effectively blocking external access to the server over IPv4.
    - Thats where IPv6 comes in. IPv6 allocates unique global address to each device on the network, allowing direct access over the internet.  Since CG-NAT is only relevant to IPv4, using IPv6 bypasses this limitation.
- Systemd as your init service
- A Custom Cloudflare API Token (not the global API key)
  - Set the following permission for the token
  ![image](https://github.com/user-attachments/assets/05530195-cabf-48f5-81a9-1b247c323376)
- Your Cloudflare `ZONE_ID` and `DNS_ID`

# Setup
- Clone this repository.
- Copy the contents of the `.env.example` file to a new `.env` file.
- Edit the `.env` file with your actual values.
- Replace the `WorkingDirectory` in `cloudflare-update-dns.service` with the location of this repository in your system.
- Run the following command to start the timer
  ```
  sudo systemctl enable cloudflare-update-dns.timer
  sudo systemctl start cloudflare-update-dns.timer
  ```
