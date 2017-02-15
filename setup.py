#!/usr/bin/python

# TODO remove dependency on termcolor

import glob
import os
import sys
import difflib
import filecmp
import getopt

try:
    from termcolor import colored
except:
    colored = lambda x,y: x

HOME = os.path.expanduser("~")
settings = {
    'dryrun': True,
    'verbose': False,
}

os.chdir(os.path.dirname(os.path.abspath(__file__)))

optlist, args = getopt.getopt(sys.argv[1:], 'dv', ['dryrun', 'verbose'])
for opt,arg in optlist:
    if opt in ['-d', '--dryrun']:
        settings['dryrun'] = True
        settings['verbose'] = True
    if opt in ['-v', '--verbose']:
        settings['verbose'] = True


def home(p):
    return os.path.join(HOME, p)

def file_diff(src, dst):
    pass

def system(cmd):
    if settings['verbose']: print cmd
    if not settings['dryrun']: os.system(cmd)

def get_user_choice(choices):
    keys = choices.keys()

    first = True
    choice = None
    while first or choice not in keys:
        if not first: print 'Invalid Choice'
        for k in keys:
            print '(%s): %s'%(str(k), choices[k])
        choice = raw_input('Enter Option (%s): '%('/'.join(map(str, keys)).strip()))
        first = False
    return choice

def is_linked(src_file, dst_file):
    src_stat = os.stat(src_file)
    dst_stat = os.stat(dst_file)

    if src_stat.st_ino == dst_stat.st_ino:
        return True
    return False


def diff_files(src_file, dst_file):

    if filecmp.cmp(src_file, dst_file, shallow=False):
        return []

    src = open(src_file,'r')
    dst = open(dst_file,'r')

    diff = difflib.unified_diff(src.readlines(),
                                dst.readlines(),
                                fromfile=src_file,
                                tofile=dst_file,
                                n=0)
    src.close()
    dst.close()

    difflines = []
    for line in diff:
        if len(line) >= 2 and line[:2] == '@@' or \
           len(line) >= 3 and line[:3] == '---' or \
           len(line) >= 3 and line[:3] == '+++' or \
           line.strip() == '':
            continue
        difflines.append(line.strip())
    return difflines


# TODO
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# TODO leave to vim?
# curl -sfLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# TODO check the terminal and do various setup
# TERM=xterm-256color-italic? (if xterm-256-color)
# <BS> = C-?
# Home/End/PU/PD work
# Fkeys work

# install vim plug
# TODO: fix snippets

system('mkdir -p "%s"'%home('.vim'))
system('mkdir -p "%s"'%home('.vim/view'))
system('mkdir -p "%s"'%home('.vim/undo'))

# TODO check if exists
# don't run, leave to bash/zsh?
# system('tic "files/xterm-256color-italic.terminfo"')


for src_file in glob.glob("files/*"):
    name = os.path.basename(src_file)
    dst_file = home('.'+name)

    if not os.path.exists(dst_file):
        print colored('[Unused]'.ljust(12), 'yellow'), '%-32s'%name, '|', colored('Linked', 'green')
        system('ln "%s" "%s"', src_file, dst_file)
        continue

    if is_linked(src_file, dst_file):
        print colored('[Linked]'.ljust(12), 'green'), '%-32s'%name, '|', colored('No Action', 'green')
        continue
    
    difflines = diff_files(src_file, dst_file)

    if len(difflines) == 0:
        print colored('[Unlinked]'.ljust(12), 'red'), '%-32s'%name, '|', colored('Similar files linked', 'yellow')
        system('rm -rf "%s"', dst_file)
        system('ln "%s" "%s"', src_file, dst_file)

    elif len(difflines) < 10:
        print colored('[Error]'.ljust(12), 'red'), '%-32s'%name, '|', colored('%s'%options[choice], 'yellow')

        print '-'*40, 'Local Diff:', name
        print '\n'.join(difflines)
        print '-'*40

        options = {
            'o':'Keep local modifications, overwrite source',
            'x':'Overwrite local modifications',
            's':'Skip',
        }

        choice = get_user_choice(options)

        if choice == 'o':
            system('rm -rf "%s"', src_file)
            system('ln "%s" "%s"', dst_file, src_file)
        elif choice == 'x':
            system('rm -rf "%s"', src_file)
            system('ln "%s" "%s"', src_file, dst_file)

    else:
        print colored('[Abort]'.ljust(12), 'red'), '%-32s'%name, '|', colored('No Action', 'red')

