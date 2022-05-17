#!/bin/bash
#
# Description: Expose metrics for disk spin status (without spinning the disks).
#

echo '# HELP disk_spin_status Disk spin status via smartctl.'
echo '# TYPE disk_spin_status gauge'

ls -1p  /dev/disk/by-id | egrep 'ata-|usb-' | grep -v 'part' | while read disk; do active=1; /usr/sbin/smartctl -n standby -d sat /dev/disk/by-id/$disk > /dev/null || active=0; echo "disk_spin_status{disk=\"${disk}\"}" "${active}"; done


