**dev-box: a personal development environment**

A [Vagrant](https://www.vagrantup.com/) development box running Ubuntu 14.04 to experiment with different things. The box is provisioned by [Ansible](http://www.ansible.com/) to make recreation easier and consistent. Both `dev-box` and `ansible-control-box` are auto-provisioned, there is nothing that is installed or configured manually.

**Ansible Roles:**

* `syspkg`: Install system wide packages and tools.
* `mysql`: Install and configure MySQL server and client. Also creates necessary databases used by other roles.
* `flask`: Install and configure Python Flask development environment.
* `tzone`: Set timezone to `Asia/Dhaka`.
* `c_cpp`: Install g++, Google Test framework and Valgrind.
* `elasticsearch`: Install and configure Elasticsearch.

**Provisioning:**

[Vagrant](https://www.vagrantup.com/) supports [Ansible provisioner](https://docs.vagrantup.com/v2/provisioning/ansible.html). However, unlike Chef or Puppet, [Ansible](http://www.ansible.com/) needs to be installed on host machine. This is generally not an issue, since Ansible is easy to install, unless Windows is used as host. The problem is that Windows is still not supported as Ansible control machine. Starting from Ansible 1.7, Windows machines [can be managed](http://docs.ansible.com/ansible/intro_windows.html) by Ansible, but the opposite is NOT true, i.e. it is not possible to use Windows as Ansible control machine.

To get around the problem, an additional Vagrant machine can be used which acts as Ansible control machine. There is a `dev-box` which is the development machine and an `ansible-control-box` which runs Ansible and provisions `dev-box`. These two machines are managed by a single [Vagrantfile](https://github.com/taskinoor/dev-box/blob/master/Vagrantfile) with [multi-machine cluster](https://docs.vagrantup.com/v2/multi-machine/) setup.

`ansible-control-box` is provisioned by a [bash script](https://github.com/taskinoor/dev-box/blob/master/provision_control_box.sh) which installs Ansible and setup SSH keys. Setting up Ansible is pretty much straight forward but getting the SSH keys correctly is a bit tricky. This shell provisioner is needed to run as [non-privileged user](https://github.com/taskinoor/dev-box/blob/master/Vagrantfile#L30) to get around with SSH key verification.

To use `ansible-contorl-box`:

- Run `vagrant up` to boot `dev-box`.
- Run `vagrant up ansible-control-box` to boot the control box. It will run the shell provisioner for the first time.
- SSH to the control box: `vagrant ssh ansible-control-box`.
- Move to the project directory: `cd /vagrant/`.
- Run the test playbook:

```
vagrant@ansible-control-box:/vagrant$ ansible-playbook ansible/test_connection.yml

PLAY [dev-box] ****************************************************************

GATHERING FACTS ***************************************************************
ok: [192.168.31.11]

TASK: [test playbook execution on dev-box] ************************************
changed: [192.168.31.11]

TASK: [debug var=res.stdout] **************************************************
ok: [192.168.31.11] => {
    "var": {
        "res.stdout": "Hello dev-box"
    }
}

PLAY RECAP ********************************************************************
192.168.31.11              : ok=3    changed=1    unreachable=0    failed=0
```

- If the connection is okay then run the provisioner: `ansible-playbook ansible/playbook.yml` which will run all Ansible roles and provision `dev-box`.

**Tested with**:

- Windows 7 professional (SP1)
- VirtualBox 4.3.26
- Vagrant 1.7.2
- Ansible 1.9.4

**Reference:**

- [Vagrant: Up and Running](http://www.amazon.com/Vagrant-Up-Running-Mitchell-Hashimoto/dp/1449335837) by Mitchell Hashimoto, specially chapter 3 - *Provisioning Your Vagrant VM* and chapter 5 - *Modeling Multimachine Clusters*.
- [Ansible for AWS](https://leanpub.com/ansible-for-aws) by Yan Kurniawan, specially *SSH Keys* section from Chapter 2 - *Getting Started with Ansible*.
- [Using Vagrant to Explore Ansible](http://software.danielwatrous.com/using-vagrant-to-explore-ansible/), a nice atricle by Daniel Watrous.
- [Bash script for generating ssh keys](http://stackoverflow.com/questions/3659602/bash-script-for-generating-ssh-keys).
- [Copy my ssh key to remote machine via ssh-copy-id in a script without prompt?](http://superuser.com/questions/908037/copy-my-ssh-key-to-remote-machine-via-ssh-copy-id-in-a-script-without-prompt).
- [Generate script in bash and save it to location requiring sudo](http://stackoverflow.com/questions/4412029/generate-script-in-bash-and-save-it-to-location-requiring-sudo).
