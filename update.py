#!/usr/bin/env python

import subprocess


def remote_run(node, command):
    c = subprocess.Popen(['ssh', '-t', '-o', 'StrictHostKeyChecking=no', 'node%s.princeton.vicci.org' % node, '-X',] + command, stdout=subprocess.PIPE)
    return c


# install on all nodes
outputs = []
other_nodes = [10] + range(12, 71)

def install_packages_on_all_nodes():
    for n in other_nodes:
        c = remote_run(n, 'sudo yum -y install vim git htop java-1.6.0-openjdk-devel libunwind.x86_64 libsqlite3x-devel.x86_64 && sudo yum -y groupinstall "Development Tools"'.split(' '))
        #c = remote_run(n, 'echo "bob\n"'.split(' '))
        outputs.append(c)

    for output in outputs:
        o,e = output.communicate()
        print o, e, '\n'

if __name__ == '__main__':
    install_packages_on_all_nodes()
