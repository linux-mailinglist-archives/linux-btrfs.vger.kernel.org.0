Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E12F964A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 00:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbhAQXkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 18:40:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48798 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbhAQXkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 18:40:45 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A05173A20CB
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 23:40:00 +0000 (UTC)
X-Originating-IP: 87.154.221.14
Received: from luna.localnet (p579add0e.dip0.t-ipconnect.de [87.154.221.14])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1740940004
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 23:38:58 +0000 (UTC)
From:   chainofflowers <chainofflowers@neuromante.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Access Beyond End of Device & Input/Output Errors
Date:   Mon, 18 Jan 2021 00:38:57 +0100
Message-ID: <5975832.dRgAyDc8OP@luna>
Organization: neuromante.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4011358.L3lc81ADqU"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4011358.L3lc81ADqU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all,
Hi Qu,

I am also getting this very same error on my system.
Actually, I am experiencing this since the following old bug was introduced AND also even after it has been fixed:
https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/

That (dm-related) bug was claimed to have been fixed and users confirmed that their btrfs partitions were working correctly again, but I am still experiencing some issues from time to time - and obviously only on SSD devices.

Just to clarify: I am using btrfs volumes on encrypted LUKS partitions, where every partition is encrypted individually.
I am *NOT* using LVM at all: just btrfs directly on top of LUKS (which is different from the users' setup in the above-mentioned bug reports).
And I am trimming the partitions only via fstrim, have configured the mount points with the "nodiscard" option and the LUKS volumes in /etc/crypttab with "discard", so to have the pass-through when I use fstrim.

Opposite to Justin, my partitions are all aligned.

When this happens on my root partition, I cannot launch any command anymore because the file system is not responding (e.g.: I get "ls: command not found"). I cannot actually do anything in reality, because the system console is flooded with messages like:

 "sd <....> [sdX] tag#29 access beyond end of device"

and that "clogs" the system. Since the root fs is unusable, the system log cannot store those messages, so I can't find them at the next reboot.
I can only soft-reset (CTRL-ALT-DEL), it's the "cleanest" (and only) way I can get back to a working system.

When the system restarts, it takes 2 seconds longer than usual to mount the file systems, and then I can use the PC again.
Immediately after login, if I run btrfs scrub, I get no errors (I scrub ALL of my partitions: they're all fine). So, it seems that at least the auto-recovery capability of btrfs works fine, thanks to you devs :-)

Then, if I boot from an external device and run btrfs check on the unmounted file systems, it also reports NO errors - opposite to what was happening when the dm bug was still open: to me, this really means that btrfs today is able to heal itself from this issue (it was not always the case in 2019, when the dm bug was opened).
I have not tried to boot from external device directly after this issue occurs - I mean, performing btrfs check without going first through the btrfs scrub step. I will do that next time and see what output I get.

All my partitions are snapshotted, and surely this could help with auto-recovery.

What I have noticed is that when this bug happens, it ALWAYS happens after I have purged the old snapshots: that is, when the root partition only has one "fresh" (read-only) snapshot. This is never happening when I have more than one snapshot - maybe it means nothing, but it seems to me to be systematic.

I have attached a file with my setup.
Could you maybe spot anything weird there? It looks fine to me. The USER and SCRATCH volumes are in RAID-0.

I am unable to provide any dmesg output or system log because, as said, when it happens it does not write anything to the SYS partition (where /var/log is). I will move at least /var/log/journal to another device, so hopefully next time I will be able to provide some useful info.

Another info: of course, I have tried (twice!) to reconstruct the system SSD from scratch, because I wanted to be sure that it was not depending on some exotic issue. And each time I used a brand new device.
So, this issue has been happening with a SanDisk Ultra II and with two different Samsung EVO 860.

Is it possible that what we are experiencing is still an effect of that dm bug, that it was not completely fixed?


Thanks for your help, and for reading till here :)

(c)

--nextPart4011358.L3lc81ADqU
Content-Disposition: attachment; filename="system-setup.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; name="system-setup.txt"

=2D------------
# uname -a
Linux <****> 5.10.7-3-MANJARO #1 SMP PREEMPT Fri Jan 15 21:11:34 UTC 2021 x=
86_64 GNU/Linux
=2D------------
# btrfs fi show
Label: 'SYS'  uuid: 8c63fc14-a0a8-4a6a-9e2a-45d8735a6cb8
        Total devices 1 FS bytes used 39.44GiB
        devid    1 size 440.57GiB used 58.05GiB path /dev/mapper/SYS

Label: 'HOME'  uuid: 9362ac9d-c280-451d-9c8a-c09798e1c887
        Total devices 1 FS bytes used 129.38GiB
        devid    1 size 232.88GiB used 179.05GiB path /dev/mapper/OMO

Label: 'USER'  uuid: b0b9b664-6629-43c0-b89e-e2db1fe0f39b
        Total devices 2 FS bytes used 2.94TiB
        devid    1 size 1.77TiB used 1.49TiB path /dev/mapper/user1
        devid    2 size 1.77TiB used 1.49TiB path /dev/mapper/user2

Label: 'SCRATCH'  uuid: cdb788b8-665b-44db-a6f0-ee743fd67b4f
        Total devices 2 FS bytes used 76.61GiB
        devid    1 size 46.55GiB used 40.01GiB path /dev/mapper/duro1
        devid    2 size 46.55GiB used 40.01GiB path /dev/mapper/duro2
=2D------------
# btrfs fi df /
Data, single: total=3D56.01GiB, used=3D38.48GiB
System, single: total=3D32.00MiB, used=3D16.00KiB
Metadata, single: total=3D2.01GiB, used=3D976.75MiB
GlobalReserve, single: total=3D107.81MiB, used=3D0.00B
=2D------------
# blkid
/dev/sda1: UUID=3D"ee18ef63-d156-4c61-a4d3-09ffc6a82659" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"BACKUP" PARTUUID=3D"11c718e6-d06e-4d42-bfd0-2325d7da14dc"
/dev/sdb1: UUID=3D"dd0a3dc5-c8dc-4c0d-86e8-294e6c76cb30" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"SCRATCH" PARTUUID=3D"0af5e58d-c057-4972-96f6-d12cf1005180"
/dev/sdb2: UUID=3D"99e588a1-5f1d-43f9-bace-d5dc0d251c0f" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"USER" PARTUUID=3D"79794d70-6cb8-4e84-b6db-32b6ddefb398"
/dev/sdc1: UUID=3D"0a51adb7-b8dd-4cc2-816f-13ed478391a7" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"HOME" PARTUUID=3D"2a43d162-ea4f-40a9-a5ab-44e922472b80"
/dev/sdd1: UUID=3D"1af89040-20e8-43f9-a4b4-0359ab938c37" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"SCRATCH" PARTUUID=3D"adf428b0-93ba-4bdc-bba9-e12c4dbaa18a"
/dev/sdd2: UUID=3D"9c78d9bb-8830-4576-91f6-1425b85616c9" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"USER" PARTUUID=3D"bb10bd57-53d8-40fe-8705-9bae6893e892"
/dev/sde2: UUID=3D"e821b81b-2cc2-4b51-84a7-d5a9e459e108" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"BOOT" PARTUUID=3D"349bb8d4-ef92-4d3f-95fc-7cf3029bc8f2"
/dev/sde3: UUID=3D"bb95b6d5-6567-4837-8f66-eac5de4aa7ba" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"SYS" PARTUUID=3D"653ae11a-4c13-4797-8f86-2807a961420d"
/dev/sde4: UUID=3D"58e5764f-6522-4dad-86f2-696c3c87847c" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"SWAP" PARTUUID=3D"943befb3-ccd4-440a-a4e1-ad98874e1aa3"
/dev/sdh1: UUID=3D"fb23d5c4-1cec-4a2b-b5c6-701b15436bfc" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"Entertainment" PARTUUID=3D"9228f216-982a-4c32-9996-9df66893=
d71b"
/dev/sdg1: UUID=3D"ec9deffe-47d8-4776-9e2e-0a74ad93cd29" TYPE=3D"crypto_LUK=
S" PARTLABEL=3D"orfano" PARTUUID=3D"1d1dd982-f810-4993-a705-61d356da39b0"
/dev/mapper/SYS: LABEL=3D"SYS" UUID=3D"8c63fc14-a0a8-4a6a-9e2a-45d8735a6cb8=
" UUID_SUB=3D"1e5141ca-474c-4144-a1e3-cd1810739d91" BLOCK_SIZE=3D"4096" TYP=
E=3D"btrfs"
/dev/mapper/suoppo: LABEL=3D"SWAP" UUID=3D"762cf066-660f-4a2b-9ecb-b91220d2=
3868" TYPE=3D"swap"
/dev/mapper/OMO: LABEL=3D"HOME" UUID=3D"9362ac9d-c280-451d-9c8a-c09798e1c88=
7" UUID_SUB=3D"eab5d229-1328-483e-9ad8-43e570e4e223" BLOCK_SIZE=3D"4096" TY=
PE=3D"btrfs"
/dev/mapper/duro2: LABEL=3D"SCRATCH" UUID=3D"cdb788b8-665b-44db-a6f0-ee743f=
d67b4f" UUID_SUB=3D"fde44687-d8e8-4603-bb1c-dd3b77482d9f" BLOCK_SIZE=3D"409=
6" TYPE=3D"btrfs"
/dev/mapper/buttalo: LABEL=3D"BOOT" UUID=3D"afba68e5-56da-4af0-bab4-6c05025=
ba0d8" BLOCK_SIZE=3D"1024" TYPE=3D"ext4"
/dev/mapper/duro1: LABEL=3D"SCRATCH" UUID=3D"cdb788b8-665b-44db-a6f0-ee743f=
d67b4f" UUID_SUB=3D"371e9000-94f5-4a15-a74f-c60ffb6d8a7c" BLOCK_SIZE=3D"409=
6" TYPE=3D"btrfs"
/dev/mapper/user1: LABEL=3D"USER" UUID=3D"b0b9b664-6629-43c0-b89e-e2db1fe0f=
39b" UUID_SUB=3D"9c0d7301-6318-48c8-9507-bf36e0056e55" BLOCK_SIZE=3D"4096" =
TYPE=3D"btrfs"
/dev/mapper/user2: LABEL=3D"USER" UUID=3D"b0b9b664-6629-43c0-b89e-e2db1fe0f=
39b" UUID_SUB=3D"065f20e5-8ab4-4361-a377-7eae43f90eb9" BLOCK_SIZE=3D"4096" =
TYPE=3D"btrfs"
/dev/sde1: PARTLABEL=3D"GRUB" PARTUUID=3D"3c12ac5f-275c-40c0-914b-73c1b728d=
ea0"
=2D------------
# lsblk -b
NAME        MAJ:MIN RM          SIZE RO TYPE  MOUNTPOINT
sda           8:0    1 2000398934016  0 disk =20
=E2=94=94=E2=94=80sda1        8:1    1 2000397795328  0 part =20
sdb           8:16   1 2000398934016  0 disk =20
=E2=94=9C=E2=94=80sdb1        8:17   1   49999249408  0 part =20
=E2=94=82 =E2=94=94=E2=94=80duro2   254:3    0   49982472192  0 crypt=20
=E2=94=94=E2=94=80sdb2        8:18   1 1950398545920  0 part =20
  =E2=94=94=E2=94=80user2   254:7    0 1950381768704  0 crypt=20
sdc           8:32   1  250059350016  0 disk =20
=E2=94=94=E2=94=80sdc1        8:33   1  250058113024  0 part =20
  =E2=94=94=E2=94=80OMO     254:2    0  250056015872  0 crypt /home
sdd           8:48   1 2000398934016  0 disk =20
=E2=94=9C=E2=94=80sdd1        8:49   1   49999249408  0 part =20
=E2=94=82 =E2=94=94=E2=94=80duro1   254:5    0   49982472192  0 crypt /var/=
lib/libvirt/images
=E2=94=94=E2=94=80sdd2        8:50   1 1950398545920  0 part =20
  =E2=94=94=E2=94=80user1   254:6    0 1950381768704  0 crypt /PATTUME/Ente=
rtainment
sde           8:64   1  500107862016  0 disk =20
=E2=94=9C=E2=94=80sde1        8:65   1       1048576  0 part =20
=E2=94=9C=E2=94=80sde2        8:66   1     198180864  0 part =20
=E2=94=82 =E2=94=94=E2=94=80buttalo 254:4    0     196083712  0 crypt /boot
=E2=94=9C=E2=94=80sde3        8:67   1  473064038400  0 part =20
=E2=94=82 =E2=94=94=E2=94=80SYS     254:0    0  473061941248  0 crypt /
=E2=94=94=E2=94=80sde4        8:68   1   26842497024  0 part =20
  =E2=94=94=E2=94=80suoppo  254:1    0   26840399872  0 crypt [SWAP]
sdg           8:96   0 2000398934016  0 disk =20
=E2=94=94=E2=94=80sdg1        8:97   0 2000397795328  0 part =20
sdh           8:112  0 3000558944256  0 disk =20
=E2=94=94=E2=94=80sdh1        8:113  0 3000556847104  0 part =20
sr0          11:0    1    1073741312  0 rom  =20
sr1          11:1    1    1073741312  0 rom  =20
=2D------------
# btrfs ins dump-tree -t chunk /dev/mapper/SYS
btrfs-progs v5.9=20
chunk tree
leaf 120415338496 items 62 free space 9755 generation 312763 owner CHUNK_TR=
EE
leaf 120415338496 flags 0x1(WRITTEN) backref revision 1
fs uuid 8c63fc14-a0a8-4a6a-9e2a-45d8735a6cb8
chunk uuid f24f036f-ad1a-43b0-bba9-83ca72d633be
	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
		devid 1 total_bytes 473061941248 bytes_used 62327357440
		io_align 4096 io_width 4096 sector_size 4096 type 0
		generation 0 start_offset 0 dev_group 0
		seek_speed 0 bandwidth 0
		uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
		fsid 8c63fc14-a0a8-4a6a-9e2a-45d8735a6cb8
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 5242880) itemoff 16105 itemsize 80
		length 8388608 owner 2 stripe_len 65536 type METADATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 5242880
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16025 itemsize 80
		length 8388608 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 0
			stripe 0 devid 1 offset 13631488
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15945 itemsize 80
		length 1073741824 owner 2 stripe_len 65536 type METADATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 22020096
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 1095761920) itemoff 15865 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 1095761920
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 2169503744) itemoff 15785 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 2169503744
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 3243245568) itemoff 15705 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 3243245568
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 4316987392) itemoff 15625 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 4316987392
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 8 key (FIRST_CHUNK_TREE CHUNK_ITEM 5390729216) itemoff 15545 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 5390729216
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 9 key (FIRST_CHUNK_TREE CHUNK_ITEM 6464471040) itemoff 15465 itemsize=
 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 6464471040
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 10 key (FIRST_CHUNK_TREE CHUNK_ITEM 7538212864) itemoff 15385 itemsiz=
e 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 7538212864
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 11 key (FIRST_CHUNK_TREE CHUNK_ITEM 8611954688) itemoff 15305 itemsiz=
e 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 8611954688
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 12 key (FIRST_CHUNK_TREE CHUNK_ITEM 9685696512) itemoff 15225 itemsiz=
e 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 9685696512
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 13 key (FIRST_CHUNK_TREE CHUNK_ITEM 12906921984) itemoff 15145 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 12906921984
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 14 key (FIRST_CHUNK_TREE CHUNK_ITEM 13980663808) itemoff 15065 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 13980663808
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 15 key (FIRST_CHUNK_TREE CHUNK_ITEM 15054405632) itemoff 14985 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 15054405632
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 16 key (FIRST_CHUNK_TREE CHUNK_ITEM 16128147456) itemoff 14905 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 16128147456
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 17 key (FIRST_CHUNK_TREE CHUNK_ITEM 17201889280) itemoff 14825 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 17201889280
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 18 key (FIRST_CHUNK_TREE CHUNK_ITEM 18275631104) itemoff 14745 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 18275631104
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 19 key (FIRST_CHUNK_TREE CHUNK_ITEM 19349372928) itemoff 14665 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 19349372928
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 20 key (FIRST_CHUNK_TREE CHUNK_ITEM 20423114752) itemoff 14585 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 20423114752
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 21 key (FIRST_CHUNK_TREE CHUNK_ITEM 21496856576) itemoff 14505 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 21496856576
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 22 key (FIRST_CHUNK_TREE CHUNK_ITEM 22570598400) itemoff 14425 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 22570598400
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 23 key (FIRST_CHUNK_TREE CHUNK_ITEM 23644340224) itemoff 14345 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 23644340224
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 24 key (FIRST_CHUNK_TREE CHUNK_ITEM 24718082048) itemoff 14265 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 24718082048
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 25 key (FIRST_CHUNK_TREE CHUNK_ITEM 25791823872) itemoff 14185 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 25791823872
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 26 key (FIRST_CHUNK_TREE CHUNK_ITEM 26865565696) itemoff 14105 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 26865565696
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 27 key (FIRST_CHUNK_TREE CHUNK_ITEM 27939307520) itemoff 14025 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 27939307520
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 28 key (FIRST_CHUNK_TREE CHUNK_ITEM 29013049344) itemoff 13945 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 29013049344
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 29 key (FIRST_CHUNK_TREE CHUNK_ITEM 30086791168) itemoff 13865 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 30086791168
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 30 key (FIRST_CHUNK_TREE CHUNK_ITEM 31160532992) itemoff 13785 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 31160532992
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 31 key (FIRST_CHUNK_TREE CHUNK_ITEM 32234274816) itemoff 13705 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 32234274816
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 32 key (FIRST_CHUNK_TREE CHUNK_ITEM 33308016640) itemoff 13625 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 33308016640
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 33 key (FIRST_CHUNK_TREE CHUNK_ITEM 34381758464) itemoff 13545 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 34381758464
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 34 key (FIRST_CHUNK_TREE CHUNK_ITEM 35455500288) itemoff 13465 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 35455500288
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 35 key (FIRST_CHUNK_TREE CHUNK_ITEM 36529242112) itemoff 13385 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type METADATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 36529242112
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 36 key (FIRST_CHUNK_TREE CHUNK_ITEM 37602983936) itemoff 13305 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 37602983936
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 37 key (FIRST_CHUNK_TREE CHUNK_ITEM 38676725760) itemoff 13225 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 38676725760
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 38 key (FIRST_CHUNK_TREE CHUNK_ITEM 39817576448) itemoff 13145 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 39817576448
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 39 key (FIRST_CHUNK_TREE CHUNK_ITEM 40891318272) itemoff 13065 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 40891318272
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 40 key (FIRST_CHUNK_TREE CHUNK_ITEM 43038801920) itemoff 12985 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 43038801920
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 41 key (FIRST_CHUNK_TREE CHUNK_ITEM 49481252864) itemoff 12905 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 49481252864
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 42 key (FIRST_CHUNK_TREE CHUNK_ITEM 54883516416) itemoff 12825 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 47333769216
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 43 key (FIRST_CHUNK_TREE CHUNK_ITEM 55990812672) itemoff 12745 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 10759438336
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 44 key (FIRST_CHUNK_TREE CHUNK_ITEM 57064554496) itemoff 12665 itemsi=
ze 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 11833180160
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 45 key (FIRST_CHUNK_TREE CHUNK_ITEM 117194096640) itemoff 12585 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 104242085888
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 46 key (FIRST_CHUNK_TREE CHUNK_ITEM 118267838464) itemoff 12505 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 41965060096
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 47 key (FIRST_CHUNK_TREE CHUNK_ITEM 119341580288) itemoff 12425 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 44112543744
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 48 key (FIRST_CHUNK_TREE CHUNK_ITEM 120415322112) itemoff 12345 items=
ize 80
		length 33554432 owner 2 stripe_len 65536 type SYSTEM
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 39750467584
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 49 key (FIRST_CHUNK_TREE CHUNK_ITEM 154808614912) itemoff 12265 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 52702478336
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 50 key (FIRST_CHUNK_TREE CHUNK_ITEM 166619774976) itemoff 12185 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 61292412928
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 51 key (FIRST_CHUNK_TREE CHUNK_ITEM 179504676864) itemoff 12105 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 63439896576
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 52 key (FIRST_CHUNK_TREE CHUNK_ITEM 180578418688) itemoff 12025 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 64513638400
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 53 key (FIRST_CHUNK_TREE CHUNK_ITEM 182725902336) itemoff 11945 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 66661122048
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 54 key (FIRST_CHUNK_TREE CHUNK_ITEM 381368139776) itemoff 11865 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 62366154752
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 55 key (FIRST_CHUNK_TREE CHUNK_ITEM 396400525312) itemoff 11785 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 67734863872
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 56 key (FIRST_CHUNK_TREE CHUNK_ITEM 397474267136) itemoff 11705 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 45186285568
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 57 key (FIRST_CHUNK_TREE CHUNK_ITEM 398548008960) itemoff 11625 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 46260027392
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 58 key (FIRST_CHUNK_TREE CHUNK_ITEM 399621750784) itemoff 11545 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 48407511040
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 59 key (FIRST_CHUNK_TREE CHUNK_ITEM 400695492608) itemoff 11465 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 50554994688
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 60 key (FIRST_CHUNK_TREE CHUNK_ITEM 631549984768) itemoff 11385 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 56997445632
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91
	item 61 key (FIRST_CHUNK_TREE CHUNK_ITEM 704564428800) itemoff 11305 items=
ize 80
		length 1073741824 owner 2 stripe_len 65536 type DATA
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 1 sub_stripes 1
			stripe 0 devid 1 offset 107463311360
			dev_uuid 1e5141ca-474c-4144-a1e3-cd1810739d91

--nextPart4011358.L3lc81ADqU--



