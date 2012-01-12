#!/usr/bin/env python

import subprocess


def remote_run(node, command):
    c = subprocess.Popen(['ssh', '-t', '-o', 'StrictHostKeyChecking=no', 'node%s.princeton.vicci.org' % node, '-X',] + command, stdout=subprocess.PIPE)
    return c.communicate()


# install on all nodes
other_nodes = [10] + range(12, 20)
for n in other_nodes:
    remote_run(n, 'sudo yum -y install vim git htop java-1.6.0-openjdk-devel libunwind.x86_64 libsqlite3x-devel.x86_64 && sudo yum -y groupinstall "Development Tools"'.split(' '))
    #print remote_run(n, 'echo "bob"'.split(' '))

