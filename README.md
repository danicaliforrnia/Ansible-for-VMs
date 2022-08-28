# Ansible for VMs

<!-- TABLE OF CONTENTS -->
## Table of Contents

- [Table of Contents](#table-of-contents)
- [About The Project](#about-the-project)
    - [Built With](#built-with)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Usage](#usage)
    - [Directory structure](#directory-structure)
    - [Running Playbooks](#run-playbooks)
      - [First Run](#first-run)
      - [First Setup: Security](#first-setup-security)
      - [Run Playbooks](#run-playbooks)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About The Project

Ansible for VMs is a project to 

### Built With

- [Ansible](https://docs.ansible.com/)
* [Vagrant 2.2.10](https://www.vagrantup.com/)

## Getting Started

### Prerequisites

In order to use this project to provision a server, you'll need:

- **One Ansible Control Node**: an Ubuntu machine with Ansible installed.

    > **_Note:_** You can create a control node VM using Vagrant within the `ansible-control-node-vm` folder. This VM will
  > Ansible already installed with a vault password file.

- **One or more Ansible hosts**: one or more Ubuntu server to be configured and provisioned.

> **_Note:_** You can use a host VM using Vagrant within the `ansible-host-vm` folder for testing purpose.

#### Ansible

> **_Note:_** In case you do not use Vagrant VM.

1. From your control node, run the scripts located in `./ansible-control-node-vm/sh/core.sh` and `./ansible-control-node-vm/sh/firewall.sh`

2. To install Ansible in your control node, run scripts located in `./ansible-control-node-vm/sh/ansible.sh`.

3. Clone the repo or mount the ansible-playbooks directory into a control node VM directory.

4. You can list the inventories by running:

    ```sh
      ansible-inventory -i inventories/development/hosts.yml --list
    ```
   > **Note:** assuming you are inside the ansible-playbooks directory.

5. In order to test the Ansible connection to the remote host run:

      ```sh
        ansible all -m ping -i inventories/development/hosts.yml -u username -k
      ```

   Where username is the host username you're trying to ping. The console will prompt you to enter the password and, if
   it is correct, you should get an output similar to this:

    ```ssh
       host-name | SUCCESS => {
          "changed": false,
          "ping": "pong"
      }
    ```

### Installation

1. Clone the repo
   ```sh
    git clone 
   ```

2. Locate in the project folder

   ```sh
    cd ansible-provisioner/
   ```

3. To use Vagrant control node VM, locate int he `ansible-control-node-vm` folder and run:
   ```sh
    Vagrant up
   ```
   During the creation and provisioning of the VM, the ansible-provisioner content will be mounted in the VM.

## Usage

### Directory structure

The project has the following structure:

    ansible-provisioner
    ├── ansible-control-node-vm
    ├── ansible-host-vm
    ├── ansible-playbooks
       ├── inventories
           ├── development
           ├── production
           ├── staging
       ├── roles
           ├── common
           ├── web
       ├── *-playbooks.yml
       ├── control-node-hosts

- ansible-control-node-vm: A Vagrant project to create and provision a VM to be used as a Control Node for Ansible.
- ansible-host-vm: A Vagrant project to create and provision a VM to be used for testing purpose as a host machine.
- ansible-playbooks:
    - inventories: Definitions of each server (ip addresses, variables and secrets) separate by environment. The secrets
      (stored in the vault.yml files) were encrypted using ansible-vault commands.
    - roles: Definitions of different tasks grouped by role with its own variables, templates and handlers.
    - *-playbooks.yml: playbooks to be run using ansible-playbook in order to execute tasks.

### Running Playbooks

To run a playbook you need to specify where, by selecting one inventory, and which playbook you want to run, for
example:

   ```sh
   sudo ansible-playbook -i inventories/development web-playbook.yml
   ```

The command above will execute the task of each role in the web-playbook playbook for the servers in the development
inventory. In some cases you need to pass the user (-u username) and the password (-k password).

> **Note:** For next examples we'll assume you are located inside the ansible-playbooks directory and will configure the
> development environment.

> **Note:** For local environment to develop and test, create a directory called *local* inside the inventories' directory 
> with the same content of another inventory. This directory called local will be ignored by git.

#### First Run

First time a server is ready to be configured and provisioned with Ansible, the playbook called `first-contanct-playbook.yml`
must be run:

   ```sh
   ansible-playbook -i inventories/development first-contact-playbook.yml
   ```

This playbook has the intention of scanning the hosts in the inventory through SSH and registering them in the `known_hosts`
file for further connections.

#### First Setup: security

The `security-playbook.yml` playbook MUST be the first playbook (after the first contact) to be
run to set and enforce secure access to the servers:

   ```sh
   ansible-playbook -i inventories/development security-playbook.yml -u username -k
   ```

The username must exist in the remote host. The console will prompt you to enter the password for that user.

> **Note:** If you are using Vagrant VMs the username and password are vagrant.

#### Run Playbooks

The `web-playbook.yml` will configure and provision the server with a NGINX web server:

   ```sh
   ansible-playbook -i inventories/development web-playbook.yml -u username
   ```

Only the username must be specified because, after the security playbook, the servers only accept
SSH Key for authentication. These playbooks execute two roles: `common` and the role needed for that server. The `common-playbook.yml`
execute tasks that all servers need.

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/amazing_feature`)
3. Commit your Changes (`git commit -m 'My new amazing feature'`)
4. Push to the Branch (`git push origin feature/amazing_feature`)
5. Open a Pull Request

## License

Distributed under the MIT License.

## Contact

Daniel Stefanelli - [Repositories](https://github.com/danicaliforrnia) - [LinkedIn](https://www.linkedin.com/in/daniel-stefanelli/)
