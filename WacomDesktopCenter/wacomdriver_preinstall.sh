#!/bin/bash

uninstall_script="/Applications/Wacom Tablet.localized/Wacom Tablet Utility.app/Contents/Resources/uninstall.pl"

# Because Wacom's uninstall.pl script will fail when run from Munki
# (it assumes $HOME and $USER are not empty), we are going to trick
# the script just enough so that it uninstalls everything, and does
# not fail or complain. See notes keys in pkginfo file for more
# information on why we need to use this script.
fakeout_user="foo"
fakeout_home="$(mktemp -d -t _wacom_uninstall_tmp)"

if [[ -f "$uninstall_script" &amp;&amp; -x "$uninstall_script" ]]; then
    echo "preuninstall_script: Calling Wacom uninstall script: ${uninstall_script}"
    USER="${fakeout_user}" HOME="${fakeout_home}" "$uninstall_script"
    echo "preuninstall_script: End of Wacom uninstall script."
else
	echo "preuninstall_script ERROR: Could not locate uninstall_script: $uninstall_script"
	exit 1
fi

exit 0