A [Vagrant](https://www.vagrantup.com/) development box running Ubuntu 14.04 to experiment with different things. The box is provisioned by [Ansible](http://www.ansible.com/) to make recreation easier and consistent. Both `dev-box` and `ansible-control-box` are auto-provisioned, there is nothing that is installed or configured manually.

The steps to provision the box and the reason of using separate `ansible-control-box` instead of simple `vagrant up` is explained [here](https://github.com/taskinoor/misc-codes/tree/master/vagrant-ansible-win7).

Since this is my personal dev environment, there are a few things that are  very specific to my own workstation (e.g. shared folder paths) and can't be reused. However, other things, specially Ansible roles can be re-used in other places.

Here are some of the roles:

* `syspkg`: Install system wide packages and tools.
* `mysql`: Install and configure MySQL server and client. Also creates necessary databases used by other roles.
* `flask`: Install and configure Python Flask development environment.
* `tzone`: Set timezone to `Asia/Dhaka`.
* `c_cpp`: Install g++ and [Google Test framework](https://github.com/google/googletest).
* `elasticsearch`: Install and configure Elasticsearch.
