#!/bin/bash -ue

command -v vagrant >/dev/null 2>&1 || { echo "Command 'vagrant' required but it's not installed.  Aborting." >&2; exit 1; }
command -v vboxmanage >/dev/null 2>&1 || { echo "Command 'vboxmanage' required but it's not installed.  Aborting." >&2; exit 1; }

. config.sh

# do a clean before
. clean.sh

# do some more cleanup
echo "Suspend any running vagrant vms ..."
vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant suspend
echo "Forcibly shutdown any running virtualbox vms ..."
vboxmanage list runningvms | sed -r 's/.*\{(.*)\}/\1/' | xargs -L1 -I {} VBoxManage controlvm {} acpipowerbutton && true
vboxmanage list runningvms | sed -r 's/.*\{(.*)\}/\1/' | xargs -L1 -I {} VBoxManage controlvm {} poweroff && true
echo "Delete all virtualbox vms ..."
vboxmanage list vms | sed -r 's/.*\{(.*)\}/\1/' | xargs -L1 -I {} vboxmanage unregistervm --delete {}
echo "Current Status for Virtualbox (if any): "
vboxmanage list vms
echo "Current Status for Vagrant (if any):"
vagrant global-status
echo "All done. Environment was cleaned. You may now run './build.sh' to build a fresh box."
