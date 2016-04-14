#!/bin/bash

awk '{if ($1 != "LID0" && $3 == "*enabled") print $1}' < /proc/acpi/wakeup | while read NAME
do echo "$NAME" > /proc/acpi/wakeup
done

exit 0
