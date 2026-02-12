_This project has been created as part of the 42 curriculum by rfoo._

# Born2beroot

## Description

Born2beroot serves as an introductory project to virtualisation. I will be creating our virtual machine (VM) using `VirtualBox`, implementing strict rules at each step. Once the VM is set up, I will have a sandboxed environment safe for testing and experimenting without affecting our host computer. 

### Design Choices

- Partitioning: Separate partitions for root, home and swap to ensure system stability and resource management. 

- Security Policies: Enforced password complexity, expiration rules and disabled root login via SSH.

- User Management: Created dedicated users and groups with restricted sudo privileges, ensuring accountability.

- Services Installed: Configured SSH for secure remote access, enabled UFW firewall, and wrote a monitoring script to display system information at boot.

### Operating System (OS)

#### Debian vs Rocky Linux

| Aspect | Debian | Rocky Linux |
|--------|--------|-------------|
| **Base** | Community-driven, independent | Enterprise-focused, downstream of RHEL |
| **Stability** | Extremely stable, long release cycles | Enterprise-grade stability, aligned with RHEL updates |
| **Security** | Strong community patches, AppArmor by default | SELinux by default, enterprise security policies |

Both Debian and Rocky Linux are stable and secured OS, but I picked Debian for its wider community support, huge package repositories and non-enterprise use for learning.

### Security Framework

#### AppArmor vs SELinux

| Aspect | AppArmor | SELinux |
|--------|----------|---------|
| **Security Model** | Path-based Mandatory Access Control | Label-based Mandatory Access Control |
| **Ease of Use** | Easier to configure, human-readable profiles | Complex, steep learning curve |
| **Default Behavior** | Allows access, then restricts | Denies everything, then grants selectively |
| **Flexibility** | Good for desktop and smaller servers | Best for enterprise-grade environments |

I will be using AppArmor here because it provides a path-based security model that is easier to configure and maintain in a learning project. SELinux is more poIrful and granular, but its steep learning curve and complex troubleshooting makes it less attractive for non-enterprise use. AppArmor also comes default in Debian.

### Firewall

#### UFW vs firewalld

| Aspect | UFW | firewalld | 
|--------|-----|-----------| 
| **Design** | Simple, command-based | Zone-based, dynamic firewall manager | 
| **Ease of Use** | Very beginner-friendly | More complex, suited for advanced admins | 
| **Default Use Case** | Debian/Ubuntu systems | RHEL/CentOS/Rocky systems | 
| **Flexibility** | Limited to basic rules | Supports complex network segmentation | 

I implemented UFW (Uncomplicated Firewall) as it is beginner-friendly and integrates well with Debian. Its simple syntax makes rule management straightforward, which is ideal for a learning project. firewalld is more advanced and better suited for enterprise use cases.

### Virtualisation 

#### VirtualBox vs UTM
| Aspect | VirtualBox | UTM | 
|--------|------------|-----| 
| **Platform Support** | Cross-platform (Windows, macOS, Linux) | macOS/iOS-focused | 
| **Performance** | Mature, stable, hardware acceleration | Optimized for Apple Silicon (M1/M2) | 
| **Ease of Use** | More features, but heavier | LightIight, simple interface | 
| **Licensing** | Free, open-source | Free, open-source (uses QEMU backend) | 

Both softwares are freat for setting up the VM for this project, but I picked VirtualBox as it allows me to run Debian on Linux at 42 Singapore and on MacOS at home. 

## Instructions

### Partitions

To view partitions:

```
lsblk
```

### Password Policies

To view password policies:

```
sudo chage -l <user>
```

### Groups 

To view user(s) in group:

```
getent group <group name>
```

### Services

To view services:

#### SSH

```
sudo systemctl status ssh
```

#### Firewall

```
sudo ufw status
```

## Resources

- [vmware](https://www.vmware.com/topics/virtual-machine)
- [systemctl](https://man7.org/linux/man-pages/man1/systemctl.1.html)
- [UFW Essentials](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)
- [hostnamectl](https://man7.org/linux/man-pages/man1/hostnamectl.1.html)
- [crontab guru](https://crontab.guru/)