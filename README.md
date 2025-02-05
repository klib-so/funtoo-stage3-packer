# Funtoo Stage3 Vagrant box

This is a minimal stage3 snapshot of Funtoo Linux that is packaged into a Vagrant box file. Currently, only a VirtualBox version is provided.
The repository has been forked from https://github.com/foobarlab/funtoo-stage3-packer so full credit must be given as foobarlab has done the
majority of the work here. My purpose is to customize the box to my own needs and use it as a clean environment for funtoo development.
However, most customizations in that regard will be factored out into a separate ansible stage, so the box should still be useful to others.
### What's included?

 - Latest Funtoo 1.4 stage3 tarball from [https://build.funtoo.org/1.4-release-std/x86-64bit/intel64-nehalem/stage3-latest.tar.xz](https://build.funtoo.org/1.4-release-std/x86-64bit/intel64-nehalem/stage3-latest.tar.xz) using [SystemRescueCD](http://www.system-rescue-cd.org)
 - Architecture: x86-64bit, intel64-nehalem (compatible with most CPUs since 2008)
 - 50 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP (virtio)
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default SSH authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel 5.10 (debian-sources)
 - (Optional, enabled by default) VirtualBox 6.1 Guest Additions
 - Additionally installed software:
   - *sudo*
   - *usermode-utilities*, *bridge-utils* and *nfs-utils* for advanced networking
   - *acpid* (enables graceful acpi shutdown for VirtualBox)
   - *zerofree* (fills empty hdd space with zeros)
   - *eclean-kernel* (cleanup kernel sources and stale files)

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/funtoo-stage3](https://app.vagrantup.com/foobarlab/boxes/funtoo-stage3)
Link for this fork will be added soon!

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh VirtualBox box

 - Run ```./build.sh```
 
#### Quick test the box file

 - Run ```./test.sh```

#### Upload the box to Vagrant Cloud (experimental)

 - Run ```./upload.sh```

### Regular use cases

#### Initialize a fresh box (initial state, any modifications are lost)

 - Run ```./init.sh```

#### Power on the box (keeping previous state)

 - Run ```./startup.sh```

### Special use cases

#### Show current build config

 - Run ```./config.sh```

#### Cleanup build environment (poweroff any Vagrant and VirtualBox machines)

 - Run ```./clean_env.sh```

#### Generate Vagrant Cloud API Token

 - Run ```./vagrant_cloud_token.sh```

#### Keep only a maximum number of boxes in Vagrant Cloud (experimental)

 - Run ```./clean_cloud.sh```

## Feedback and bug reports welcome

Please create an issue or submit a pull request.
