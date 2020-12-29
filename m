Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18962E70CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgL2NMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 08:12:42 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47128 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2NMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 08:12:41 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E6605917061; Tue, 29 Dec 2020 08:11:58 -0500 (EST)
Date:   Tue, 29 Dec 2020 08:11:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cedric.dewijs@eclipso.eu
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: full btrfs raid1 3 partition filesystem is only writable one
 restart after loosing a drive
Message-ID: <20201229131158.GR31381@hungrycats.org>
References: <6af3ed7574dd1077b5ced62481ee3dc9@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <6af3ed7574dd1077b5ced62481ee3dc9@mail.eclipso.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2020 at 03:27:03PM +0100,   wrote:
> =ADI'm testing with btrfs. I made a raid 1 array, filled it to the brim w=
ith data, made a "drive" fail, added a new "drive", and then the filesystem=
 got forced read only when I removed the missing drive.
>=20
> How can I recover from this situation? What are the steps to get back to =
a healthy, writable btrfs filesystem?
> How can I avoid the filesystem to go read only?
>=20
> PS, this question has also been asked on the arch linux forum, there the =
[code] [/code] tags work.
> https://bbs.archlinux.org/viewtopic.php?id=3D262062
>=20
> Here's what I did:
>=20
> Prepare test partitions:
> [code]
> fdisk /dev/sdc
> [  440.514002]  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10=
 >
> [/code]
> Create the filesystem:
> [code]
> # mkfs.btrfs -L FULL_FAIL -f -d raid1 -m raid1 /dev/sdc5 /dev/sdc6 /dev/s=
dc7
> btrfs-progs v5.9
> See http://btrfs.wiki.kernel.org for more information.
>=20
> Label:              FULL_FAIL
> UUID:               490a7330-079b-4b03-a301-47a70a3acdcf
> Node size:          16384
> Sector size:        4096
> Filesystem size:    21.00GiB
> Block group profiles:
>   Data:             RAID1             1.00GiB
>   Metadata:         RAID1           256.00MiB
>   System:           RAID1             8.00MiB
> SSD detected:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:  =20
> Checksum:           crc32c
> Number of devices:  3
> Devices:
>    ID        SIZE  PATH
>     1     6.00GiB  /dev/sdc5
>     2     7.00GiB  /dev/sdc6
>     3     8.00GiB  /dev/sdc7
>=20
> [  563.633284] BTRFS: device label FULL_FAIL devid 1 transid 5 /dev/sdc5 =
scanned by mkfs.btrfs (470)
> [  563.634228] BTRFS: device label FULL_FAIL devid 2 transid 5 /dev/sdc6 =
scanned by mkfs.btrfs (470)
> [  563.648238] BTRFS: device label FULL_FAIL devid 3 transid 5 /dev/sdc7 =
scanned by mkfs.btrfs (470)
> [/code]
> Mount the filesystem
> [code]
> # mkdir /mnt/full_fail
> # mount /dev/sdc5 /mnt/full_fail
> [  718.454333] BTRFS info (device sdc5): disk space caching is enabled
> [  718.454337] BTRFS info (device sdc5): has skinny extents
> [  718.454338] BTRFS info (device sdc5): flagging fs with big metadata fe=
ature
> [  719.635715] BTRFS info (device sdc5): checking UUID tree
> [/code]
> Fill the filesystem to the brim
> [code]
> # mkdir /mnt/full_fail/write_test
> # chown cedric /mnt/full_fail/write_test
> # su cedric
> $ cat ~/mkfiles_and_md5.sh
> #! /bin/bash
> for n in {1..6000}; do
>     if [ ! -f file$( printf %03d "$n" ).bin ]; then
>         dd if=3D/dev/urandom of=3Dfile$( printf %03d "$n" ).bin bs=3D1M c=
ount=3D100
>         md5sum file$( printf %03d "$n" ).bin >> md5sums.txt
>     fi
> done
>=20
> $ cd /mnt/full_fail/write_test/
> $ ~/mkfiles_and_md5.sh
> [/code]
> Confirm the filesystem is indeed filled
> [code]
> $ df -h
> /dev/sdc5        11G   11G   64K 100% /mnt/full_fail
>=20
> # btrfs fi show
> Label: 'FULL_FAIL'  uuid: 490a7330-079b-4b03-a301-47a70a3acdcf
>     Total devices 3 FS bytes used 10.01GiB
>     devid    1 size 6.00GiB used 6.00GiB path /dev/sdc5
>     devid    2 size 7.00GiB used 6.52GiB path /dev/sdc6
>     devid    3 size 8.00GiB used 8.00GiB path /dev/sdc7
> [/code]
> Simulate a failed drive
> [code]
> # umount /dev/sdc5
> # wipefs -a /dev/sdc6
> /dev/sdc6: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 =
66 53 5f 4d
> [/code]
> Remount the filesystem in degraded mode
> [code]
> # mount /dev/sdc5 /mnt/full_fail/
> mount: /mnt/full_fail: wrong fs type, bad option, bad superblock on /dev/=
sdc5, missing codepage or helper program, or other error.
> [ 2922.031458] BTRFS info (device sdc5): disk space caching is enabled
> [ 2922.031462] BTRFS info (device sdc5): has skinny extents
> [ 2922.032429] BTRFS error (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e66=
-ae8d-987e93f78392 is missing
> [ 2922.032432] BTRFS error (device sdc5): failed to read the system array=
: -2
> [ 2922.063492] BTRFS error (device sdc5): open_ctree failed
>=20
> # mount /dev/sdc5 /mnt/full_fail/ -o,degraded
> [ 3080.872748] BTRFS info (device sdc5): allowing degraded mounts
> [ 3080.872751] BTRFS info (device sdc5): disk space caching is enabled
> [ 3080.872752] BTRFS info (device sdc5): has skinny extents
> [ 3080.873732] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [ 3080.890568] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [/code]
> Add a new "drive"
> [code]
> # btrfs device add /dev/sdc8 /mnt/full_fail/

This step is wrong.  You should use 'btrfs replace' to restore the array
to non-degraded mode after a disk failure.  'btrfs device add' adds new
disks to an array--it does not replace missing disks.  The difference
between these two approaches will become apparent shortly.

> [ 3163.872400] BTRFS info (device sdc5): disk added /dev/sdc8
>=20
> # btrfs fi show
> Label: 'FULL_FAIL'  uuid: 490a7330-079b-4b03-a301-47a70a3acdcf
>     Total devices 4 FS bytes used 10.01GiB
>     devid    1 size 6.00GiB used 6.00GiB path /dev/sdc5
>     devid    3 size 8.00GiB used 8.00GiB path /dev/sdc7
>     devid    4 size 9.00GiB used 0.00B path /dev/sdc8
>     *** Some devices missing
> [/code]

Here you have added a single disk to an existing raid1 array that is
fully allocated.  There will not be space to allocate any new chunks until
after a second drive is added, because raid1 requires unallocated space
on two or more disks.  It's not possible to remove any device here except
device 4, because it is empty and all the other devices are all full
(including the missing one).

This also occurs in non-degraded mode--the fact that disks are missing
is irrelevant.

There is one bug here--the balance should fail to delete the device with
an error without forcing the whole filesystem read-only.  This seems to
be a regression since 5.0--4.19 handled the error and stayed read-write.

> Remove the failed "drive"
> [code]
> # btrfs device remove missing /mnt/full_fail/
> ERROR: error removing device 'missing': Read-only file system
> [ 3283.230781] BTRFS info (device sdc5): relocating block group 107583897=
60 flags data|raid1
> [ 3284.989011] BTRFS info (device sdc5): relocating block group 888877875=
2 flags data|raid1
> [ 3285.172340] BTRFS info (device sdc5): relocating block group 781503692=
8 flags data|raid1
> [ 3285.355690] BTRFS info (device sdc5): relocating block group 566755328=
0 flags data|raid1
> [ 3285.563993] BTRFS info (device sdc5): relocating block group 459381145=
6 flags data|raid1
> [ 3285.789070] BTRFS info (device sdc5): relocating block group 244632780=
8 flags data|raid1
> [ 3286.064095] BTRFS info (device sdc5): relocating block group 298844160=
 flags data|raid1
> [ 3286.213950] ------------[ cut here ]------------
> [ 3286.213953] BTRFS: Transaction aborted (error -28)
> [ 3286.214032] WARNING: CPU: 1 PID: 2460 at fs/btrfs/free-space-cache.c:2=
81 btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btrfs]
> [ 3286.214034] Modules linked in: cfg80211 8021q garp mrp stp llc hwmon_v=
id f75375s intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powe=
rclamp coretemp kvm_intel kvm radeon irqbypass i2c_algo_bit snd_hda_codec_r=
ealtek ttm snd_hda_codec_generic crct10dif_pclmul drm_kms_helper crc32_pclm=
ul ledtrig_audio ghash_clmulni_intel cec aesni_intel snd_hda_intel rc_core =
syscopyarea sysfillrect sysimgblt snd_intel_dspcfg crypto_simd snd_hda_code=
c psmouse cryptd glue_helper fb_sys_fops hp_wmi serio_raw snd_hda_core spar=
se_keymap atkbd tpm_infineon ppdev gpio_ich iTCO_wdt mei_hdcp snd_hwdep rap=
l mei_wdt intel_pmc_bxt rfkill snd_pcm wmi_bmof libps2 at24 iTCO_vendor_sup=
port tpm_tis snd_timer intel_cstate snd mei_me e1000e intel_uncore parport_=
pc soundcore mei evdev input_leds i8042 tpm_tis_core parport pcspkr mac_hid=
 wmi i2c_i801 lpc_ich tpm serio i2c_smbus rng_core drm fuse agpgart ip_tabl=
es x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor hid_generic =
usbhid hid raid6_pq ata_generic
> [ 3286.214074]  pata_acpi ata_piix crc32c_intel ehci_pci ehci_hcd
> [ 3286.214080] CPU: 1 PID: 2460 Comm: btrfs Not tainted 5.9.14-arch1-1 #1
> [ 3286.214081] Hardware name: Hewlett-Packard HP Compaq 8200 Elite CMT PC=
/1494, BIOS J01 v02.28 03/24/2015
> [ 3286.214116] RIP: 0010:btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btr=
fs]
> [ 3286.214119] Code: 55 50 f0 48 0f ba aa 48 0a 00 00 02 72 22 83 f8 fb 7=
4 40 83 f8 e2 74 3b 89 c6 48 c7 c7 68 0d 5b c0 89 44 24 04 e8 32 ab c8 ec <=
0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24 04 48 c7
> [ 3286.214121] RSP: 0018:ffffa01a016fbc08 EFLAGS: 00010286
> [ 3286.214123] RAX: 0000000000000000 RBX: ffff8ef120f6ac00 RCX: 000000000=
0000000
> [ 3286.214124] RDX: 0000000000000001 RSI: ffffffffadb59b0f RDI: 00000000f=
fffffff
> [ 3286.214125] RBP: ffff8ef121335bc8 R08: 00000000000003a9 R09: 000000000=
0000001
> [ 3286.214127] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8ef0d=
0ff27c8
> [ 3286.214128] R13: ffff8ef11f4bfee0 R14: ffff8ef11e5fe000 R15: ffff8ef12=
0f6ac10
> [ 3286.214130] FS:  00007f7ca80a6200(0000) GS:ffff8ef125c80000(0000) knlG=
S:0000000000000000
> [ 3286.214132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3286.214134] CR2: 000055e08d943920 CR3: 000000021e768005 CR4: 000000000=
00606e0
> [ 3286.214135] Call Trace:
> [ 3286.214173]  delete_block_group_cache+0x6f/0xb0 [btrfs]
> [ 3286.214206]  btrfs_relocate_block_group+0xd3/0x300 [btrfs]
> [ 3286.214238]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> [ 3286.214270]  btrfs_shrink_device+0x211/0x550 [btrfs]
> [ 3286.214303]  btrfs_rm_device+0x174/0x570 [btrfs]
> [ 3286.214308]  ? __check_object_size+0x136/0x150
> [ 3286.214312]  ? _copy_from_user+0x2e/0x60
> [ 3286.214344]  btrfs_ioctl+0x2c60/0x3050 [btrfs]
> [ 3286.214349]  ? vfs_statx+0x8f/0x140
> [ 3286.214353]  ? __do_sys_newstat+0x47/0x80
> [ 3286.214358]  ? __x64_sys_ioctl+0x83/0xb0
> [ 3286.214360]  __x64_sys_ioctl+0x83/0xb0
> [ 3286.214366]  do_syscall_64+0x33/0x40
> [ 3286.214369]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3286.214372] RIP: 0033:0x7f7ca81c4f6b
> [ 3286.214375] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff f=
f ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64 89 01 48
> [ 3286.214376] RSP: 002b:00007fffa3200758 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [ 3286.214379] RAX: ffffffffffffffda RBX: 00007fffa3202920 RCX: 00007f7ca=
81c4f6b
> [ 3286.214380] RDX: 00007fffa3201780 RSI: 000000005000943a RDI: 000000000=
0000003
> [ 3286.214381] RBP: 0000000000000000 R08: 00007fffa32017b8 R09: 00007f7ca=
8290a60
> [ 3286.214383] R10: 0000000000000016 R11: 0000000000000246 R12: 000000000=
0000000
> [ 3286.214384] R13: 00007fffa3201780 R14: 0000000000000003 R15: 00007fffa=
3202928
> [ 3286.214388] ---[ end trace 95a480e236de7d8e ]---
> [ 3286.214392] BTRFS warning (device sdc5): btrfs_truncate_free_space_cac=
he:281: Aborting unused transaction(No space left).
> [ 3286.214427] BTRFS info (device sdc5): relocating block group 22020096 =
flags system|raid1
> [ 3286.215852] BTRFS warning (device sdc5): Skipping commit of aborted tr=
ansaction.
> [ 3286.215856] BTRFS: error (device sdc5) in cleanup_transaction:1898: er=
rno=3D-30 Readonly filesystem
> [ 3286.215858] BTRFS info (device sdc5): forced readonly
> [/code]

Here you are out of space, as expected when adding a single device to a
full raid1.  You need to add two devices, or add one device while having
some unallocated space on one of the existing devices, before you can do
device remove.  This is also true if the array is not degraded--if all
disks were online, you still would not be able to complete that sequence
of 'device add' and 'device remove' operations.

'btrfs replace' avoids all of these issues because it doesn't allocate
anything.  replace simply rebuilds an image, block by block, of the
missing drive on a new drive.  This requires an equal or larger sized
drive, so you can't use btrfs replace in all cases.

If you have to use device add followed by device remove, it's a good idea
to put a metadata balance between add and remove ('btrfs balance start
-mdevid=3D<missing device>').  You want to have degraded metadata for the
minimum time possible to prevent a second disk error from killing the
filesystem.  This is one of the rare use cases when it is appropriate to
balance metadata (normally metadata should never be balanced, but some
raid array rearrangements will require it).  If possible, use btrfs
replace instead--btrfs replace is 2-3 orders of magnitude faster than
metadata balance, so if you want to minimize time in degraded mode,
replace is the tool to use.

If you need to replace a failed disk with a smaller one on a fully
allocated filesystem, you first need to deallocate (balance) some data
block groups until there is sufficient space to allocate metadata on
the disks that are still online.  btrfs-balance-least-used (from the
python-btrfs package) will help with this by selecting the most empty
block groups to balance first.

If you can borrow a second smaller device, you can use that device to
provide the extra space required to complete the device remove, then
remove the second of the added devices.  This is a specific case of "have
some unallocated space on one of the existing devices" where we simply
add two new devices to ensure that two devices have unallocated space.
The second device can be _really_ small, like an 8G USB stick--it is
only there to provide one unallocated block group to swap chunks around
the other 3 devices.


> My version:
> [code]
> # uname -a
> Linux bcache-test 5.9.14-arch1-1 #1 SMP PREEMPT Sat, 12 Dec 2020 14:37:12=
 +0000 x86_64 GNU/Linux
> [/code]
>=20
> =ADFurther testing: Rebooted the system. Now the filesystem is writable a=
gain. i figured it to be a good idea to run a balance, so the data from the=
 full drives gets dumped into the new drive. That didn't work so well, the =
filesystem gets forced read only a few seconds in, and this time a reboot d=
idn't work anymore.
>=20
> I find it strange, as the new "drive" is larger (9GB) than the failed "dr=
ive" (7GB) it replaces.
>=20
> I'm out of idea's.
>=20
> In detail:
> After rebooting the system, the filesystem can be remounted read / write:
> [code]
> # btrfs filesystem show
> warning, device 2 is missing
> Label: 'FULL_FAIL'  uuid: 490a7330-079b-4b03-a301-47a70a3acdcf
>     Total devices 4 FS bytes used 10.01GiB
>     devid    1 size 6.00GiB used 6.00GiB path /dev/sdc5
>     devid    3 size 8.00GiB used 8.00GiB path /dev/sdc7
>     devid    4 size 9.00GiB used 0.00B path /dev/sdc8
>     *** Some devices missing
>=20
> # mount /dev/sdc5 /mnt/full_fail/
> mount: /mnt/full_fail: wrong fs type, bad option, bad superblock on /dev/=
sdc5, missing codepage or helper program, or other error.
> [  317.151879] BTRFS info (device sdc5): disk space caching is enabled
> [  317.151882] BTRFS info (device sdc5): has skinny extents
> [  317.152888] BTRFS error (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e66=
-ae8d-987e93f78392 is missing
> [  317.152891] BTRFS error (device sdc5): failed to read the system array=
: -2
> [  317.180190] BTRFS error (device sdc5): open_ctree failed
>=20
> # mount /dev/sdc5 /mnt/full_fail/ -o,degraded
> [  332.192932] BTRFS info (device sdc5): allowing degraded mounts
> [  332.192935] BTRFS info (device sdc5): disk space caching is enabled
> [  332.192937] BTRFS info (device sdc5): has skinny extents
> [  332.193941] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [  332.206721] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [  332.248353] BTRFS info (device sdc5): checking UUID tree
>=20
> # df -h
> /dev/sdc5        15G   11G  832K 100% /mnt/full_fail
>=20
> # touch /mnt/full_fail/test
> # ls -l /mnt/full_fail
> total 0
> -rw-r--r-- 1 root   root    0 Dec 27 12:46 test
> drwxr-xr-x 1 cedric root 8118 Dec 27 11:52 write_test
> [/code]
> Start the balance
> [code]
> # btrfs balance start /mnt/full_fail
> WARNING:
>=20
>     Full balance without filters requested. This operation is very
>     intense and takes potentially very long. It is recommended to
>     use the balance filters to narrow down the scope of balance.
>     Use 'btrfs balance start --full-balance' option to skip this
>     warning. The operation will start in 10 seconds.
>     Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/mnt/full_fail': Read-only file system
> There may be more info in syslog - try dmesg | tail
> [  610.428524] BTRFS info (device sdc5): balance: start -d -m -s
> [  610.428628] BTRFS info (device sdc5): relocating block group 107583897=
60 flags data|raid1
> [  610.695382] BTRFS info (device sdc5): relocating block group 996252057=
6 flags data|raid1
> [  610.962003] BTRFS info (device sdc5): relocating block group 888877875=
2 flags data|raid1
> [  611.236969] BTRFS info (device sdc5): relocating block group 781503692=
8 flags data|raid1
> [  617.437051] BTRFS info (device sdc5): relocating block group 674129510=
4 flags data|raid1
> [  617.737177] BTRFS info (device sdc5): relocating block group 566755328=
0 flags data|raid1
> [  618.070493] BTRFS info (device sdc5): relocating block group 459381145=
6 flags data|raid1
> [  618.345070] BTRFS info (device sdc5): relocating block group 352006963=
2 flags data|raid1
> [  618.611753] BTRFS info (device sdc5): relocating block group 244632780=
8 flags data|raid1
> [  618.869989] BTRFS info (device sdc5): relocating block group 137258598=
4 flags data|raid1
> [  619.128457] BTRFS info (device sdc5): relocating block group 298844160=
 flags data|raid1
> [  619.303350] ------------[ cut here ]------------
> [  619.303353] BTRFS: Transaction aborted (error -28)
> [  619.303436] WARNING: CPU: 1 PID: 493 at fs/btrfs/free-space-cache.c:28=
1 btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btrfs]
> [  619.303437] Modules linked in: cfg80211 8021q garp mrp stp llc hwmon_v=
id f75375s intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powe=
rclamp radeon coretemp kvm_intel i2c_algo_bit kvm ttm irqbypass crct10dif_p=
clmul crc32_pclmul drm_kms_helper ghash_clmulni_intel aesni_intel snd_hda_c=
odec_realtek snd_hda_codec_generic cec hp_wmi ledtrig_audio crypto_simd snd=
_hda_intel cryptd rc_core sparse_keymap snd_intel_dspcfg snd_hda_codec glue=
_helper iTCO_wdt psmouse rfkill syscopyarea serio_raw mei_hdcp intel_pmc_bx=
t gpio_ich mei_wdt rapl sysfillrect ppdev iTCO_vendor_support mei_me intel_=
cstate snd_hda_core atkbd tpm_infineon snd_hwdep libps2 sysimgblt snd_pcm w=
mi_bmof at24 intel_uncore snd_timer e1000e fb_sys_fops snd mei soundcore lp=
c_ich i8042 pcspkr wmi tpm_tis serio tpm_tis_core i2c_i801 input_leds tpm p=
arport_pc evdev parport rng_core i2c_smbus mac_hid drm fuse agpgart ip_tabl=
es x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor hid_generic =
usbhid hid raid6_pq ata_generic
> [  619.303478]  pata_acpi crc32c_intel ehci_pci ata_piix ehci_hcd
> [  619.303484] CPU: 1 PID: 493 Comm: btrfs Not tainted 5.9.14-arch1-1 #1
> [  619.303485] Hardware name: Hewlett-Packard HP Compaq 8200 Elite CMT PC=
/1494, BIOS J01 v02.28 03/24/2015
> [  619.303520] RIP: 0010:btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btr=
fs]
> [  619.303524] Code: 55 50 f0 48 0f ba aa 48 0a 00 00 02 72 22 83 f8 fb 7=
4 40 83 f8 e2 74 3b 89 c6 48 c7 c7 68 ed 2c c0 89 44 24 04 e8 32 cb b6 ce <=
0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24 04 48 c7
> [  619.303525] RSP: 0018:ffffa0ca80283cf8 EFLAGS: 00010282
> [  619.303527] RAX: 0000000000000000 RBX: ffff94c2e1d92c00 RCX: 000000000=
0000000
> [  619.303528] RDX: 0000000000000001 RSI: ffffffff8f759b0f RDI: 00000000f=
fffffff
> [  619.303530] RBP: ffff94c2e3830548 R08: 000000000000039c R09: 000000000=
0000001
> [  619.303531] R10: 0000000000000000 R11: 0000000000000001 R12: ffff94c2e=
1249058
> [  619.303532] R13: ffff94c2e04d5b60 R14: ffff94c2e1775800 R15: ffff94c2e=
1d92c10
> [  619.303535] FS:  00007fd0ea4a3200(0000) GS:ffff94c2e5c80000(0000) knlG=
S:0000000000000000
> [  619.303536] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  619.303538] CR2: 00007f75dcb4bf30 CR3: 00000002207e6003 CR4: 000000000=
00606e0
> [  619.303539] Call Trace:
> [  619.303577]  delete_block_group_cache+0x6f/0xb0 [btrfs]
> [  619.303610]  btrfs_relocate_block_group+0xd3/0x300 [btrfs]
> [  619.303642]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> [  619.303674]  btrfs_balance+0x779/0xef0 [btrfs]
> [  619.303709]  btrfs_ioctl_balance+0x292/0x340 [btrfs]
> [  619.303716]  __x64_sys_ioctl+0x83/0xb0
> [  619.303721]  do_syscall_64+0x33/0x40
> [  619.303725]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  619.303727] RIP: 0033:0x7fd0ea5c1f6b
> [  619.303731] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff f=
f ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 ae 0c 00 f7 d8 64 89 01 48
> [  619.303732] RSP: 002b:00007ffdffa33088 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [  619.303734] RAX: ffffffffffffffda RBX: 00007ffdffa33120 RCX: 00007fd0e=
a5c1f6b
> [  619.303736] RDX: 00007ffdffa33120 RSI: 00000000c4009420 RDI: 000000000=
0000003
> [  619.303737] RBP: 0000000000000003 R08: 000055a1cc6a86e0 R09: 00007fd0e=
a68da60
> [  619.303738] R10: 0000000000000231 R11: 0000000000000246 R12: 000000000=
0000001
> [  619.303739] R13: 00007ffdffa34dae R14: 0000000000000000 R15: 000000000=
0000000
> [  619.303743] ---[ end trace 38946790256c33d0 ]---
> [  619.303747] BTRFS warning (device sdc5): btrfs_truncate_free_space_cac=
he:281: Aborting unused transaction(No space left).
> [  619.303783] BTRFS info (device sdc5): relocating block group 22020096 =
flags system|raid1
> [  619.305161] BTRFS warning (device sdc5): Skipping commit of aborted tr=
ansaction.
> [  619.305166] BTRFS: error (device sdc5) in cleanup_transaction:1898: er=
rno=3D-30 Readonly filesystem
> [  619.305168] BTRFS info (device sdc5): forced readonly
> [  619.306680] BTRFS info (device sdc5): 12 enospc errors during balance
> [  619.306683] BTRFS info (device sdc5): balance: ended with status: -30
> [/code]
> Remounting also gives a read only filesystem
> [code]
> # btrfs filesystem show
> Label: 'FULL_FAIL'  uuid: 490a7330-079b-4b03-a301-47a70a3acdcf
>     Total devices 4 FS bytes used 10.01GiB
>     devid    1 size 6.00GiB used 6.00GiB path /dev/sdc5
>     devid    3 size 8.00GiB used 8.00GiB path /dev/sdc7
>     devid    4 size 9.00GiB used 0.00B path /dev/sdc8
>     *** Some devices missing
>=20
> # umount /mnt/full_fail
> # mount /dev/sdc5 /mnt/full_fail/ -o,degraded
> [  856.434698] BTRFS info (device sdc5): allowing degraded mounts
> [  856.434702] BTRFS info (device sdc5): disk space caching is enabled
> [  856.434704] BTRFS info (device sdc5): has skinny extents
> [  856.451425] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [  856.474289] BTRFS info (device sdc5): checking UUID tree
> [  856.543382] BTRFS info (device sdc5): balance: resume -dusage=3D90 -mu=
sage=3D90 -susage=3D90
> [  856.543469] ------------[ cut here ]------------
> [  856.543471] BTRFS: Transaction aborted (error -28)
> [  856.543550] WARNING: CPU: 0 PID: 532 at fs/btrfs/free-space-cache.c:28=
1 btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btrfs]
> [  856.543551] Modules linked in: cfg80211 8021q garp mrp stp llc hwmon_v=
id f75375s intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powe=
rclamp radeon coretemp kvm_intel i2c_algo_bit kvm ttm irqbypass crct10dif_p=
clmul crc32_pclmul drm_kms_helper ghash_clmulni_intel aesni_intel snd_hda_c=
odec_realtek snd_hda_codec_generic cec hp_wmi ledtrig_audio crypto_simd snd=
_hda_intel cryptd rc_core sparse_keymap snd_intel_dspcfg snd_hda_codec glue=
_helper iTCO_wdt psmouse rfkill syscopyarea serio_raw mei_hdcp intel_pmc_bx=
t gpio_ich mei_wdt rapl sysfillrect ppdev iTCO_vendor_support mei_me intel_=
cstate snd_hda_core atkbd tpm_infineon snd_hwdep libps2 sysimgblt snd_pcm w=
mi_bmof at24 intel_uncore snd_timer e1000e fb_sys_fops snd mei soundcore lp=
c_ich i8042 pcspkr wmi tpm_tis serio tpm_tis_core i2c_i801 input_leds tpm p=
arport_pc evdev parport rng_core i2c_smbus mac_hid drm fuse agpgart ip_tabl=
es x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor hid_generic =
usbhid hid raid6_pq ata_generic
> [  856.543591]  pata_acpi crc32c_intel ehci_pci ata_piix ehci_hcd
> [  856.543598] CPU: 0 PID: 532 Comm: btrfs-balance Tainted: G        W   =
      5.9.14-arch1-1 #1
> [  856.543599] Hardware name: Hewlett-Packard HP Compaq 8200 Elite CMT PC=
/1494, BIOS J01 v02.28 03/24/2015
> [  856.543633] RIP: 0010:btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btr=
fs]
> [  856.543637] Code: 55 50 f0 48 0f ba aa 48 0a 00 00 02 72 22 83 f8 fb 7=
4 40 83 f8 e2 74 3b 89 c6 48 c7 c7 68 ed 2c c0 89 44 24 04 e8 32 cb b6 ce <=
0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24 04 48 c7
> [  856.543638] RSP: 0018:ffffa0ca81647d20 EFLAGS: 00010282
> [  856.543640] RAX: 0000000000000000 RBX: ffff94c2e0567800 RCX: 000000000=
0000000
> [  856.543642] RDX: 0000000000000001 RSI: ffffffff8f759b0f RDI: 00000000f=
fffffff
> [  856.543643] RBP: ffff94c2e481cb60 R08: 00000000000003cd R09: 000000000=
0000001
> [  856.543644] R10: 0000000000000000 R11: 0000000000000001 R12: ffff94c2e=
12a35d8
> [  856.543646] R13: ffff94c2e3667070 R14: ffff94c2e156d800 R15: ffff94c2e=
0567810
> [  856.543648] FS:  0000000000000000(0000) GS:ffff94c2e5c00000(0000) knlG=
S:0000000000000000
> [  856.543650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  856.543651] CR2: 000055cab9f6fbc0 CR3: 000000021500e005 CR4: 000000000=
00606f0
> [  856.543653] Call Trace:
> [  856.543690]  delete_block_group_cache+0x6f/0xb0 [btrfs]
> [  856.543725]  btrfs_relocate_block_group+0xd3/0x300 [btrfs]
> [  856.543764]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> [  856.543803]  btrfs_balance+0x779/0xef0 [btrfs]
> [  856.543844]  ? btrfs_balance+0xef0/0xef0 [btrfs]
> [  856.543882]  balance_kthread+0x35/0x50 [btrfs]
> [  856.543887]  kthread+0x142/0x160
> [  856.543891]  ? __kthread_bind_mask+0x60/0x60
> [  856.543895]  ret_from_fork+0x22/0x30
> [  856.543899] ---[ end trace 38946790256c33d1 ]---
> [  856.543903] BTRFS warning (device sdc5): btrfs_truncate_free_space_cac=
he:281: Aborting unused transaction(No space left).
> [  856.543972] BTRFS info (device sdc5): relocating block group 22020096 =
flags system|raid1
> [  856.545589] BTRFS warning (device sdc5): Skipping commit of aborted tr=
ansaction.
> [  856.545593] BTRFS: error (device sdc5) in cleanup_transaction:1898: er=
rno=3D-30 Readonly filesystem
> [  856.545595] BTRFS info (device sdc5): forced readonly
> [  856.547025] BTRFS info (device sdc5): 1 enospc errors during balance
> [  856.547027] BTRFS info (device sdc5): balance: ended with status: -30
> [/code]
> Rebooting the server doesn't help anymore
> [code]
> mount /dev/sdc5 /mnt/full_fail/ -o,degraded

Use '-o skip_balance,degraded' here.  Without skip_balance, the kernel
will automatically resume the balance and run out of space again.

> [  319.244480] BTRFS info (device sdc5): allowing degraded mounts
> [  319.244484] BTRFS info (device sdc5): disk space caching is enabled
> [  319.244485] BTRFS info (device sdc5): has skinny extents
> [  319.246699] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [  319.252305] BTRFS warning (device sdc5): devid 2 uuid abe6f4b2-4fd2-4e=
66-ae8d-987e93f78392 is missing
> [  319.377704] BTRFS info (device sdc5): balance: resume -dusage=3D90 -mu=
sage=3D90 -susage=3D90
> [  319.377792] ------------[ cut here ]------------
> [  319.377794] BTRFS: Transaction aborted (error -28)
> [  319.377877] WARNING: CPU: 2 PID: 469 at fs/btrfs/free-space-cache.c:28=
1 btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btrfs]
> [  319.377878] Modules linked in: cfg80211 8021q garp mrp stp llc hwmon_v=
id f75375s radeon i2c_algo_bit ttm drm_kms_helper intel_rapl_msr cec snd_hd=
a_codec_realtek intel_rapl_common snd_hda_codec_generic ledtrig_audio x86_p=
kg_temp_thermal intel_powerclamp rc_core snd_hda_intel coretemp snd_intel_d=
spcfg syscopyarea snd_hda_codec sysfillrect kvm_intel sysimgblt fb_sys_fops=
 snd_hda_core kvm snd_hwdep iTCO_wdt irqbypass snd_pcm psmouse crct10dif_pc=
lmul crc32_pclmul intel_pmc_bxt serio_raw ghash_clmulni_intel atkbd aesni_i=
ntel hp_wmi iTCO_vendor_support crypto_simd mei_hdcp mei_wdt ppdev cryptd s=
nd_timer e1000e gpio_ich libps2 snd sparse_keymap glue_helper mei_me parpor=
t_pc at24 rfkill wmi_bmof soundcore rapl tpm_infineon intel_cstate mei parp=
ort intel_uncore pcspkr i8042 tpm_tis tpm_tis_core tpm evdev input_leds lpc=
_ich serio i2c_i801 mac_hid i2c_smbus rng_core wmi drm agpgart fuse ip_tabl=
es x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor hid_generic =
usbhid hid raid6_pq ata_generic
> [  319.377919]  pata_acpi crc32c_intel ehci_pci ata_piix ehci_hcd
> [  319.377925] CPU: 2 PID: 469 Comm: btrfs-balance Not tainted 5.9.14-arc=
h1-1 #1
> [  319.377927] Hardware name: Hewlett-Packard HP Compaq 8200 Elite CMT PC=
/1494, BIOS J01 v02.28 03/24/2015
> [  319.377961] RIP: 0010:btrfs_truncate_free_space_cache+0x1c0/0x1f0 [btr=
fs]
> [  319.377965] Code: 55 50 f0 48 0f ba aa 48 0a 00 00 02 72 22 83 f8 fb 7=
4 40 83 f8 e2 74 3b 89 c6 48 c7 c7 68 9d 35 c0 89 44 24 04 e8 32 1b 4e f3 <=
0f> 0b 8b 44 24 04 89 c1 ba 19 01 00 00 48 89 ef 89 44 24 04 48 c7
> [  319.377966] RSP: 0018:ffffa9aa0055bd20 EFLAGS: 00010282
> [  319.377968] RAX: 0000000000000000 RBX: ffff99e52269a400 RCX: 000000000=
0000000
> [  319.377970] RDX: 0000000000000001 RSI: ffffffffb4159b0f RDI: 00000000f=
fffffff
> [  319.377971] RBP: ffff99e51e5229c0 R08: 000000000000037c R09: 000000000=
0000001
> [  319.377972] R10: 0000000000000000 R11: 0000000000000001 R12: ffff99e52=
22b72c8
> [  319.377974] R13: ffff99e522b0a930 R14: ffff99e521bdb000 R15: ffff99e52=
269a410
> [  319.377976] FS:  0000000000000000(0000) GS:ffff99e525d00000(0000) knlG=
S:0000000000000000
> [  319.377977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  319.377979] CR2: 00007ff3765f3e20 CR3: 000000020f40e005 CR4: 000000000=
00606e0
> [  319.377980] Call Trace:
> [  319.378019]  delete_block_group_cache+0x6f/0xb0 [btrfs]
> [  319.378052]  btrfs_relocate_block_group+0xd3/0x300 [btrfs]
> [  319.378085]  btrfs_relocate_chunk+0x27/0xc0 [btrfs]
> [  319.378117]  btrfs_balance+0x779/0xef0 [btrfs]
> [  319.378151]  ? btrfs_balance+0xef0/0xef0 [btrfs]
> [  319.378181]  balance_kthread+0x35/0x50 [btrfs]
> [  319.378188]  kthread+0x142/0x160
> [  319.378191]  ? __kthread_bind_mask+0x60/0x60
> [  319.378195]  ret_from_fork+0x22/0x30
> [  319.378200] ---[ end trace 75e1a8739f7fa9dd ]---
> [  319.378203] BTRFS warning (device sdc5): btrfs_truncate_free_space_cac=
he:281: Aborting unused transaction(No space left).
> [  319.378266] BTRFS info (device sdc5): relocating block group 22020096 =
flags system|raid1
> [  319.379737] BTRFS warning (device sdc5): Skipping commit of aborted tr=
ansaction.
> [  319.379742] BTRFS: error (device sdc5) in cleanup_transaction:1898: er=
rno=3D-30 Readonly filesystem
> [  319.379744] BTRFS info (device sdc5): forced readonly
> [  319.381224] BTRFS info (device sdc5): 1 enospc errors during balance
> [  319.381227] BTRFS info (device sdc5): balance: ended with status: -30
> [/code]
>=20
>=20
> ---
>=20
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: htt=
ps://www.eclipso.eu - Time to change!
>=20
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCX+srHAAKCRCB+YsaVrMb
nJLEAJ9c/t61Z2LlsO0PblOlj7nMCk6weQCeM3kCkGaFpgKAeGkWewCWL8Ku/bU=
=/A/F
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
