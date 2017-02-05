#!/usr/bin/python2.7

import glob
import os
import sys
import difflib
import filecmp
from termcolor import colored

os.chdir(os.path.dirname(os.path.abspath(__file__)))

HOME = os.path.expanduser("~")
DRY_RUN = False

def mkdir(d):
    if not os.path.exists(d):
        if DRY_RUN: print 'mkdir -p', d
        else: os.mkdirs(d)

def home(p):
    return os.path.join(HOME, p)

def link_files(src, dst, force=False, sym=False):
    if force: 
        if DRY_RUN: print 'rm', dst
        else: os.remove(dst)
    if sym:
        if DRY_RUN: print 'ln -s', src, dst
        else: os.symlink(src, dst)
    else:
        if DRY_RUN: print 'ln', src, dst
        else: os.link(src, dst)

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

mkdir(home('.vim'))
mkdir(home('.vim/view'))
mkdir(home('.vim/undo'))

# # TODO check if exists
# # leave to vim
# #curl -sfLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# # TODO
# # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#
# rm -f ~/.vim/UltiSnips
# ln -s "$(readlink -e UltiSnips)" ~/.vim/UltiSnips

if os.path.islink((home('.vim/UltiSnips'))):
    link_files('UltiSnips', home('.vim/UltiSnips'), force=True, sym=True)
    print colored('[Exists]'.ljust(12), 'yellow'), '%-24s'%'UltiSnips', '|', colored('Re-Linked', 'green')
elif os.path.exists(home('.vim/UltiSnips')):
    print colored('[Error]'.ljust(12), 'red'), '%-24s'%'UltiSnips', '|', colored('Directory Exists', 'green')
else:
    link_files('UltiSnips', home('.vim/UltiSnips'), sym=True)
    print colored('[Unused]'.ljust(12), 'yellow'), '%-24s'%'UltiSnips', '|', colored('Linked', 'green')

for src_file in glob.glob("files/*"):
    name = os.path.basename(src_file)
    dst_file = os.path.join(HOME, '.'+name)

    if not os.path.exists(dst_file):
        link_files(src_file, dst_file)
        print colored('[Unused]'.ljust(12), 'yellow'), '%-24s'%name, '|', colored('Linked', 'green')
        # print '|', colored('OK', 'green')
        continue

    src_stat = os.stat(src_file)
    dst_stat = os.stat(dst_file)

    if src_stat.st_ino == dst_stat.st_ino:
        print colored('[Linked]'.ljust(12), 'green'), '%-24s'%name, '|', colored('No Action', 'green')
        continue

    if filecmp.cmp(src_file, dst_file, shallow=False):
        link_files(src_file, dst_file, force=True)
        print colored('[Unlinked]'.ljust(12), 'yellow'), '%-24s'%name, '|', colored('Similar files linked', 'green')
        continue


    src = open(src_file,'r')
    dst = open(dst_file,'r')

    diff = difflib.unified_diff(src.readlines(),
                                dst.readlines(),
                                fromfile=src_file,
                                tofile=dst_file,
                                n=0)
    difflines = []
    for line in diff:
        if len(line) >= 2 and line[:2] == '@@' or \
           len(line) >= 3 and line[:3] == '---' or \
           len(line) >= 3 and line[:3] == '+++' or \
           line.strip() == '':
            continue
        difflines.append(line.strip())

    if len(difflines) == 0:
        link_files(src_file, dst_file, force=True)
        print colored('[Unlinked]'.ljust(12), 'red'), '%-24s'%name, '|', colored('Similar files linked', 'yellow')

    elif len(difflines) < 10:
        print '-'*40, 'Local Diff'
        print '\n'.join(difflines)
        print '-'*40

        options = {
            'o':'Keep local modifications, overwrite source',
            'x':'Overwrite local modifications',
            's':'Skip',

        }
        choice = get_user_choice(options)

        if choice == 'o':
            link_files(dst_file, src_file, force=True)
        elif choice == 'x':
            link_files(src_file, dst_file, force=True)

        print colored('[Error]'.ljust(12), 'red'), '%-24s'%name, '|', colored('%s'%options[choice], 'yellow')

    else:
        print colored('[Abort]'.ljust(12), 'red'), '%-24s'%name, '|', colored('No Action', 'red')

# #!/bin/bash
#
# cd "$(dirname "$0")"
#
# mkdir -p ~/.vim
# mkdir -p ~/.vim/view
# mkdir -p ~/.vim/undo
#
#
# link() {
#   echo "$1"
#   rm -f "$HOME/.$1"
#   ln "$1" "$HOME/.$1"
# }
#
# # for f in *; do
# # for f in $(find . type f); do
# for f in $(find files -type f -printf "%f\n"); do
#     link "$f"
# done
#
