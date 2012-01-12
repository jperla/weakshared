#!/usr/bin/env python

import subprocess

#other_nodes = [10] + range(12, 13)
other_nodes = [10] + range(12, 71)



def remote_run(node, command):
    c = subprocess.Popen(['ssh', '-t', '-o', 'StrictHostKeyChecking=no', 'node%s.princeton.vicci.org' % node, '-X',] + command, stdout=subprocess.PIPE)
    return c

def run_on_all_nodes(command):
    outputs = []
    for n in other_nodes:
        c = remote_run(n, command.split(' '))
        # test run, should print bobs
        #c = remote_run(n, 'echo "bob\n"'.split(' '))
        outputs.append(c)

    for output in outputs:
        o,e = output.communicate()
        print e, '\n'

def install_packages_on_all_nodes():
    command = 'sudo yum -y install vim git htop java-1.6.0-openjdk-devel libunwind.x86_64 libsqlite3x-devel.x86_64 cppunit-devel.x86_64 cppunit.x86_64 && sudo yum -y groupinstall "Development Tools"'
    return run_on_all_nodes(command)
      
def rsync_all():
    outputs = []
    # runs in parallel
    dir = '/home/princeton_ram'
    for n in other_nodes:
        command = 'rsync -a -r --exclude-from {0}/weakshared/exclude.txt -P {0}/ node{1}.princeton.vicci.org:{0}'.format(dir, n)
        print command
        # command = 'rsync -a -r -P {0}/spark/ node{1}.princeton.vicci.org:{0}/spark'.format(dir, n)
        c = subprocess.Popen(command.split(' '), stdout=subprocess.PIPE)
        outputs.append(c)

    for output in outputs:
        o,e = output.communicate()
        print e, '\n'

def symlink_java_shit():
    command = 'sudo ln -s /etc/alternatives/java_sdk_1.6.0/jre/lib/amd64/server/libjvm.so /usr/lib64/libjvm.so'
    return run_on_all_nodes(command)

if __name__ == '__main__':
    #symlink_java_shit()
    #install_packages_on_all_nodes()
    rsync_all()

