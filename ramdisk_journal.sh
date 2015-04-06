#!/bin/bash

mknod -m 660 /dev/ram16 b 1 16
dd if=/dev/zero of=/dev/ram16 bs=1K count=1048576

mke2fs -O journal_dev -t ext4 /dev/ram16
ls -l /dev/disk/by-uuid/


mount -t ext4 -o remount,rw,relatime,nodelalloc,journal_async_commit /dev/sda1 /

# recovery mode 
# sudo tune2fs -f -O ^has_journal /dev/sdc1
# sudo e2fsck -fp /dev/sdc1
tune2fs -J device=/dev/ram16 /dev/sdc1

