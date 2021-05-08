#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Call alias file
. ~/.bash_aliases

PS1='\W \$ '

# Start neofetch
neofetch --ascii_distro arch_small
