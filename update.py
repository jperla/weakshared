#!/usr/bin/env python

import subprocess


def remote_run(node, command):
    c = subprocess.Popen(['ssh', '-t', '-o', 'StrictHostKeyChecking=no', 'node%s.princeton.vicci.org' % node, '-X',] + command, stdout=subprocess.PIPE)
    return c


# install on all nodes
other_nodes = [10] + range(12, 13)

def install_packages_on_all_nodes():
    outputs = []
    for n in other_nodes:
        c = remote_run(n, 'sudo yum -y install vim git htop java-1.6.0-openjdk-devel libunwind.x86_64 libsqlite3x-devel.x86_64 cppunit-devel.x86_64 cppunit.x86_64 && sudo yum -y groupinstall "Development Tools"'.split(' '))
        # test run, should print bobs
        #c = remote_run(n, 'echo "bob\n"'.split(' '))
        outputs.append(c)

    for output in outputs:
        o,e = output.communicate()
        print e, '\n'
      
def rsync_all():
    outputs = []
    # runs in parallel
    dir = '/home/princeton_ram'
    command = 'rsync -r -P {0}/ node{1}.princeton.vicci.org:{0}'.format(dir, n)
    # command = 'rsync -r -P {0}/spark/ node{1}.princeton.vicci.org:{0}/spark'.format(dir, n)
    for n in other_nodes:
        c = subprocess.Popen(command.split(' '), stdout=subprocess.PIPE)
        outputs.append(c)

    for output in outputs:
        o,e = output.communicate()
        print e, '\n'


if __name__ == '__main__':
    # install_packages_on_all_nodes()
    rsync_all()

