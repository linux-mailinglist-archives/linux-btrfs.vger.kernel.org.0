Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEB2F03B8
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 22:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbhAIVJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 9 Jan 2021 16:09:41 -0500
Received: from mail.eclipso.de ([217.69.254.104]:49484 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhAIVJk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Jan 2021 16:09:40 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 5E3D8138
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 22:08:59 +0100 (CET)
Date:   Sat, 09 Jan 2021 22:08:59 +0100
MIME-Version: 1.0
Message-ID: <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: cloning a btrfs drive with send and receive: clone is bigger
        than  the original?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     "Andrei Borzenkov" <arvidjaar@gmail.com>
Cc:     <linux-btrfs@vger.kernel.org>
In-Reply-To: <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
        <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 
> How can I transfer the snapshots in such a way that the snapshots only
occupy the difference between the snapshots?
> 
> The data on the original drive is organized like this:
> /mnt/send/storage/ <= here's all the data
> /mnt/send/storage_snapshots/ <= here are the 3 snapshots
> 
> The data on the receiving drive is organized like this:
> /mnt/rec/storage/ <= this folder is empty
> /mnt/rec/storage_snapshots/ <= here are the 3 snapshots
> /mnt/rec/btrfs_receive/ <= here are the 3 files generated by btrfs
send 
> 
> How can I transfer the snapshots in such a way that /mnt/rec/storage/
holds the latest version of the data, just like on the original drive?
> 
> In detail:
> # mkfs.btrfs -L SEND /dev/sda3
> # mount /dev/sda3 /mnt/send/ -o,compress,noatime
> # mkfs.btrfs /dev/sdd2 -L DATA
> # mount /dev/sdd2 ./mnt/rec/ -o,compress,noatime

I can think of at least two reasons

1. Inline data is not shared and compressing increases probability of
inlining

2. I believe only extents that are aligned on and exact multiple of
filesystem block are reflinked during send.


Thanks. I've made the following script to test it in a more controlled way. It turns out that btrfs send and receive work correctly, provided all commands are entered correctly. it's also important to explicitly call sync between deleting subvolumes and re-creating them, or calling btrfs filesystem show. 

# cat ~/btrfs-send-test.sh 
#!/bin/bash

btrfs subvolume delete /mnt/send/storage
btrfs subvolume delete /mnt/send/snapshots/*
btrfs subvolume delete /mnt/send/snapshots/
btrfs subvolume delete /mnt/rec/diff
btrfs subvolume delete /mnt/rec/snapshots/*
btrfs subvolume delete /mnt/rec/snapshots/
sync
btrfs subvolume create /mnt/send/storage
btrfs subvolume create /mnt/send/snapshots/
btrfs subvolume create /mnt/rec/diff
btrfs subvolume create /mnt/rec/snapshots

btrfs subvolume snapshot -r /mnt/send/storage/ /mnt/send/snapshots/0
btrfs send /mnt/send/snapshots/0 | btrfs receive /mnt/rec/snapshots

onelesscounter=0
counter=1
while [ $counter -le 10 ]
do
	dd if=/dev/urandom of=/mnt/send/storage/file$( printf %03d "$counter" ).bin bs=1M count=100
	md5sum /mnt/send/storage/file$( printf %03d "$counter" ).bin >> /mnt/send/storage/md5sums.txt
	btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/snapshots/$counter
	btrfs send -p /mnt/send/snapshots/$onelesscounter /mnt/send/snapshots/$counter -f /mnt/rec/diff/$counter 
	btrfs receive -f /mnt/rec/diff/$counter /mnt/rec/snapshots
	((counter++))
	((onelesscounter++))
done
echo All done

# ls -lh /mnt/rec/diff/
total 1001M
-rw------- 1 root root 101M Jan  9 22:54 1
-rw------- 1 root root 101M Jan  9 22:55 10
-rw------- 1 root root 101M Jan  9 22:54 2
-rw------- 1 root root 101M Jan  9 22:54 3
-rw------- 1 root root 101M Jan  9 22:54 4
-rw------- 1 root root 101M Jan  9 22:54 5
-rw------- 1 root root 101M Jan  9 22:54 6
-rw------- 1 root root 101M Jan  9 22:54 7
-rw------- 1 root root 101M Jan  9 22:54 8
-rw------- 1 root root 101M Jan  9 22:55 9

# btrfs filesystem show
Label: 'SEND'  uuid: 61b7e45f-62a7-4b04-bc0c-ba1304548b02
	Total devices 1 FS bytes used 1001.69MiB
	devid    1 size 5.00GiB used 1.52GiB path /dev/sda3

Label: 'DATA'  uuid: 95e85fa4-217c-429a-be55-833bb63e2c71
	Total devices 1 FS bytes used 1.96GiB <= 1GB for the snapshots, and one GB for the diff files
	devid    1 size 931.01GiB used 10.02GiB path /dev/sdd2

Output of the script:
# ~/btrfs-send-test.sh 
Delete subvolume (no-commit): '/mnt/send/storage'
Delete subvolume (no-commit): '/mnt/send/snapshots/0'
Delete subvolume (no-commit): '/mnt/send/snapshots/1'
Delete subvolume (no-commit): '/mnt/send/snapshots/10'
Delete subvolume (no-commit): '/mnt/send/snapshots/2'
Delete subvolume (no-commit): '/mnt/send/snapshots/3'
Delete subvolume (no-commit): '/mnt/send/snapshots/4'
Delete subvolume (no-commit): '/mnt/send/snapshots/5'
Delete subvolume (no-commit): '/mnt/send/snapshots/6'
Delete subvolume (no-commit): '/mnt/send/snapshots/7'
Delete subvolume (no-commit): '/mnt/send/snapshots/8'
Delete subvolume (no-commit): '/mnt/send/snapshots/9'
Delete subvolume (no-commit): '/mnt/send/snapshots'
Delete subvolume (no-commit): '/mnt/rec/diff'
Delete subvolume (no-commit): '/mnt/rec/snapshots/0'
Delete subvolume (no-commit): '/mnt/rec/snapshots/1'
Delete subvolume (no-commit): '/mnt/rec/snapshots/10'
Delete subvolume (no-commit): '/mnt/rec/snapshots/2'
Delete subvolume (no-commit): '/mnt/rec/snapshots/3'
Delete subvolume (no-commit): '/mnt/rec/snapshots/4'
Delete subvolume (no-commit): '/mnt/rec/snapshots/5'
Delete subvolume (no-commit): '/mnt/rec/snapshots/6'
Delete subvolume (no-commit): '/mnt/rec/snapshots/7'
Delete subvolume (no-commit): '/mnt/rec/snapshots/8'
Delete subvolume (no-commit): '/mnt/rec/snapshots/9'
Delete subvolume (no-commit): '/mnt/rec/snapshots'
Create subvolume '/mnt/send/storage'
Create subvolume '/mnt/send/snapshots'
Create subvolume '/mnt/rec/diff'
Create subvolume '/mnt/rec/snapshots'
Create a readonly snapshot of '/mnt/send/storage/' in '/mnt/send/snapshots/0'
At subvol /mnt/send/snapshots/0
At subvol 0
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.482553 s, 217 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/1'
At subvol /mnt/send/snapshots/1
At snapshot 1
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.467191 s, 224 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/2'
At subvol /mnt/send/snapshots/2
At snapshot 2
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.465809 s, 225 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/3'
At subvol /mnt/send/snapshots/3
At snapshot 3
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.418819 s, 250 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/4'
At subvol /mnt/send/snapshots/4
At snapshot 4
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.466965 s, 225 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/5'
At subvol /mnt/send/snapshots/5
At snapshot 5
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.466293 s, 225 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/6'
At subvol /mnt/send/snapshots/6
At snapshot 6
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.46744 s, 224 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/7'
At subvol /mnt/send/snapshots/7
At snapshot 7
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.467267 s, 224 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/8'
At subvol /mnt/send/snapshots/8
At snapshot 8
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.467288 s, 224 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/9'
At subvol /mnt/send/snapshots/9
At snapshot 9
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.467526 s, 224 MB/s
Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/snapshots/10'
At subvol /mnt/send/snapshots/10
At snapshot 10
All done


---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


