#!/bin/bash

echo "# HELP mmc_status eMMC health status as reported by the controller"
echo "# TYPE mmc_status gauge"


for disk in `ls -1p /dev/mmcblk[0-9]`;
do
        usage=`/usr/bin/mmc extcsd read $disk | grep Estimation | head -1 | cut -d ':' -f 2 | cut -d 'x' -f 2`
        usageDecimal=$(( 16#$usage ))
        let usagePercent="10*usageDecimal"
        echo "mmc_status{disk=\"$disk\"} $usagePercent"

done
