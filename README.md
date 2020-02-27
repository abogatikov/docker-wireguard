# Docker Wireguard

1. Create `wireguard.service` file in `/etc/systemd/system`.
2. Create a writable overlay.
    ```shell script
    modules=/opt/modules  # Adjust this writable storage location as needed.
    sudo mkdir -p "$modules" "$modules.wd"
    sudo mount \ 
      -o "lowerdir=/lib/modules,upperdir=$modules,workdir=$modules.wd" \ 
      -t overlay overlay /lib/modules
    ``` 
3. To mount the overlay automatically when the system boots, add the following line to `/etc/fstab` (creating it if necessary).
    ```shell script
    overlay /lib/modules overlay lowerdir=/lib/modules,upperdir=/opt/modules,workdir=/opt/modules.wd,nofail 0 0
    ```
4. Create `00-wg0.network` file in `/etc/systemd/network/`.
    ```shell script
    [Match]
    Name=wg0
    
    [Network]
    Description=network interface on wireguard network
    DHCP=no
    Address=10.0.0.1
    Domains=~example.com
    ```
6. Reload `network` and `resolve` services.
    ```shell script
    sudo systemctl restart systemd-networkd
    sudo systemctl restart systemd-resolved
    ```
7. Start `qireguard` service.
    ```shell script
    sudo systemctl start wireguard.service
    ```