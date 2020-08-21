Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18624D1E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHUKBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 06:01:11 -0400
Received: from mx01.isnic.is ([193.4.58.133]:53466 "EHLO mx01.isnic.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgHUKBK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 06:01:10 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 06:01:05 EDT
Received: from localhost (wg-client01.isnic.is [185.93.159.98])
        by mx01.isnic.is (Postfix) with ESMTPS id D270AC694;
        Fri, 21 Aug 2020 09:51:40 +0000 (UTC)
Date:   Fri, 21 Aug 2020 09:51:38 +0000
From:   =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@isnic.is>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs filesystem errors
Message-ID: <20200821095138.GC1481@disp4150>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

One of our btrfs filesystems is giving us problems. This filesystem is used=
 to
store backups, so we will most likely recreate the filesystem and take new
backups, but we are very interested in understanding what went wrong. For
now I've left the filesystem as-is.

The machine is running fully upgraded debian buster
root@ht-backup01:/home/ansible# uname -a
Linux ht-backup01.isnic.is 4.19.0-9-amd64 #1 SMP Debian 4.19.118-2+deb10u1 =
(2020-06-07) x86_64 GNU/Linux
root@ht-backup01:/home/ansible# btrfs --version
btrfs-progs v4.20.1=20

The layout of the filesystem is RAID10 with 6 component devices:
root@ht-backup01:/var/log/apt# btrfs  fi df /var/urbackup
Data, RAID10: total=3D8.37TiB, used=3D8.24TiB
System, RAID10: total=3D7.88MiB, used=3D848.00KiB
Metadata, RAID10: total=3D212.34GiB, used=3D210.97GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
root@ht-backup01:/var/log/apt# btrfs  filesystem show /var/urbackup
Label: none  uuid: be13f041-ba50-4d37-860b-7acfcfe96248
        Total devices 6 FS bytes used 8.45TiB
        devid    1 size 9.10TiB used 2.86TiB path /dev/sda
        devid    2 size 9.10TiB used 2.86TiB path /dev/sdb
        devid    3 size 9.10TiB used 2.86TiB path /dev/sdc
        devid    4 size 9.10TiB used 2.86TiB path /dev/sdd
        devid    5 size 9.10TiB used 2.86TiB path /dev/sde
        devid    6 size 9.10TiB used 2.86TiB path /dev/sdf


Here's an overview of events and actions taken so far.

A couple of days ago while running a heavy read workload, a process crashed
due to an IO error. Testing reading the same subvolume or any file under
it resulted in IO errors:
root@ht-backup01:/var/log/apt# ls /var/urbackup/consus.isnic.is/200712-1900=
=20
ls: cannot access '/var/urbackup/consus.isnic.is/200712-1900': Input/output=
 error

A look at the kernel log revealed a bunch of checksum errors. The earliest
ones look like this, there are more but they look the same with different
inode numbers and checksums. I can send the full kernel log (quite large)
if needed).
[2146111.297911] BTRFS info (device sda): no csum found for inode 124415604=
 start 12288
[2146111.297913] BTRFS error (device sda): parent transid verify failed on =
16717660405760 wanted 168871 found 168866
[2146111.298084] BTRFS error (device sda): parent transid verify failed on =
16717660405760 wanted 168871 found 168866
[2146111.298255] BTRFS info (device sda): no csum found for inode 124415604=
 start 16384
[2146111.298258] BTRFS info (device sda): no csum found for inode 124415604=
 start 20480
[2146111.298261] BTRFS info (device sda): no csum found for inode 124415604=
 start 24576
[2146111.298278] BTRFS info (device sda): no csum found for inode 124415604=
 start 28672
[2146111.298280] BTRFS info (device sda): no csum found for inode 124415604=
 start 32768
[2146111.298283] BTRFS info (device sda): no csum found for inode 124415604=
 start 36864
[2146111.309761] btrfs_print_data_csum_error: 61 callbacks suppressed
[2146111.309768] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 0 csum 0x6576cb90 expected csum 0x00000000 mirror 2
[2146111.309822] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 4096 csum 0x74736b53 expected csum 0x00000000 mirror 2
[2146111.309865] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 8192 csum 0xb98e6445 expected csum 0x00000000 mirror 2
[2146111.309893] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 12288 csum 0xe04aa9a0 expected csum 0x00000000 mirror 2
[2146111.309918] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 16384 csum 0xc996dda7 expected csum 0x00000000 mirror 2
[2146111.309943] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 20480 csum 0xe414f94c expected csum 0x00000000 mirror 2
[2146111.309969] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 24576 csum 0xb80afd23 expected csum 0x00000000 mirror 2
[2146111.310966] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 0 csum 0x6576cb90 expected csum 0x00000000 mirror 2
[2146111.310976] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 4096 csum 0x74736b53 expected csum 0x00000000 mirror 2
[2146111.311022] BTRFS warning (device sda): csum failed root 5 ino 1244156=
04 off 8192 csum 0xb98e6445 expected csum 0x00000000 mirror 2
[2146162.968521] verify_parent_transid: 178 callbacks suppressed
[2146162.968526] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868
[2146162.982356] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868
[2146162.983157] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868
[2146162.984230] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868
[2146163.285382] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868
[2146163.285945] BTRFS error (device sda): parent transid verify failed on =
16717271908352 wanted 168871 found 168868

First action was to try a scrub, but the scrub was immediately marked
canceled without operator action:
root@ht-backup01:/var/log/apt# btrfs scrub start /var/urbackup/
scrub started on /var/urbackup/, fsid be13f041-ba50-4d37-860b-7acfcfe96248 =
(pid=3D2475)
root@ht-backup01:/var/log/apt# btrfs scrub status /var/urbackup/
scrub status for be13f041-ba50-4d37-860b-7acfcfe96248
        scrub started at Tue Aug 18 11:32:15 2020 and was aborted after 00:=
00:00
        total bytes scrubbed: 0.00B with 0 errors

Despite the checksum errors in kernel log, device stats show no IO errors:
root@ht-backup01:/home/ansible# btrfs device stats /var/urbackup/
[/dev/sda].write_io_errs    0
[/dev/sda].read_io_errs     0
[/dev/sda].flush_io_errs    0
[/dev/sda].corruption_errs  0
[/dev/sda].generation_errs  0
[/dev/sdb].write_io_errs    0
[/dev/sdb].read_io_errs     0
[/dev/sdb].flush_io_errs    0
[/dev/sdb].corruption_errs  0
[/dev/sdb].generation_errs  0
[/dev/sdc].write_io_errs    0
[/dev/sdc].read_io_errs     0
[/dev/sdc].flush_io_errs    0
[/dev/sdc].corruption_errs  0
[/dev/sdc].generation_errs  0
[/dev/sdd].write_io_errs    0
[/dev/sdd].read_io_errs     0
[/dev/sdd].flush_io_errs    0
[/dev/sdd].corruption_errs  0
[/dev/sdd].generation_errs  0
[/dev/sde].write_io_errs    0
[/dev/sde].read_io_errs     0
[/dev/sde].flush_io_errs    0
[/dev/sde].corruption_errs  0
[/dev/sde].generation_errs  0
[/dev/sdf].write_io_errs    0
[/dev/sdf].read_io_errs     0
[/dev/sdf].flush_io_errs    0
[/dev/sdf].corruption_errs  0
[/dev/sdf].generation_errs  0

SMART data also looks fine, and there are no IO errors from the underlying
block devices in the kernel log.

Following advice from the #btrfs IRC on freenode, I unmounted the filesystem
and ran "btrfs check --readonly /dev/sda" the stdout/stderr from the piped
file looks like:
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 12376079204352 has wrong amount of free space, free space cache=
 has 5619712 block group has 5718016
failed to load free space cache for block group 12376079204352
block group 12377186500608 has wrong amount of free space, free space cache=
 has 5767168 block group has 5832704
failed to load free space cache for block group 12377186500608
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: be13f041-ba50-4d37-860b-7acfcfe96248
found 9280877776896 bytes used, no error found
total csum bytes: 8846572604
total tree bytes: 226491777024
total fs tree bytes: 212365148160
total extent tree bytes: 4458266624
btree space waste bytes: 41516609810
file data blocks allocated: 1279139722285056
 referenced 38321097904128

I remounted the filesystem, at which point the following lines were added to
kernel log:
[2238865.763060] BTRFS info (device sda): disk space caching is enabled
[2238865.763064] BTRFS info (device sda): has skinny extents
[2238889.870492] BTRFS info (device sda): start tree-log replay
[2238901.447456] BTRFS warning (device sda): block group 12376079204352 has=
 wrong amount of free space
[2238901.447460] BTRFS warning (device sda): failed to load free space cach=
e for block group 12376079204352, rebuilding it now
[2238901.717617] BTRFS warning (device sda): block group 12377186500608 has=
 wrong amount of free space
[2238901.717621] BTRFS warning (device sda): failed to load free space cach=
e for block group 12377186500608, rebuilding it now

At this point, the subvolume and files that were previously unreadable seem=
ed
to be working. I tried reading a couple of them and succeeded.

At this point I ran a scrub on the filesystem, which ran normally and
finished with no errors:
root@ht-backup01:/home/ansible# btrfs scrub status /var/urbackup/
scrub status for be13f041-ba50-4d37-860b-7acfcfe96248
	scrub started at Wed Aug 19 13:13:16 2020 and finished after 04:16:41
	total bytes scrubbed: 16.89TiB with 0 errors

I started our backup server again, but overnight our backup jobs failed with
"no space available" errors. In the kernel log the following messages had
appeared:
[2350368.220399] ------------[ cut here ]------------
[2350368.220401] BTRFS: Transaction aborted (error -28)
[2350368.220462] WARNING: CPU: 4 PID: 14252 at fs/btrfs/extent-tree.c:6805 =
__btrfs_free_extent.isra.75+0x26c/0x8c0 [btrfs]
[2350368.220463] Modules linked in: fuse ufs qnx4 hfsplus hfs minix vfat ms=
dos fat jfs xfs ipmi_ssif nft_counter intel_rapl skx_edac nfit libnvdimm x8=
6_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ast irqbypass cr=
ct10dif_pclmul crc32_pclmul ttm ghash_clmulni_intel intel_cstate drm_kms_he=
lper intel_uncore drm intel_rapl_perf pcspkr iTCO_wdt mei_me ipmi_si i2c_al=
go_bit iTCO_vendor_support pcc_cpufreq joydev sg mei ioatdma wmi ipmi_devin=
tf ipmi_msghandler evdev acpi_power_meter acpi_pad nft_ct nf_conntrack butt=
on nf_defrag_ipv6 nf_defrag_ipv4 nf_tables_set nf_tables nfnetlink ip_table=
s x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb btrfs zstd_decompre=
ss zstd_compress xxhash dm_mod raid10 raid456 async_raid6_recov async_memcp=
y async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic
[2350368.220489]  raid1 raid0 multipath linear md_mod hid_generic usbhid hi=
d sd_mod crc32c_intel ahci xhci_pci libahci xhci_hcd libata ixgbe i40e aesn=
i_intel nvme usbcore aes_x86_64 scsi_mod crypto_simd cryptd glue_helper nvm=
e_core dca mdio lpc_ich i2c_i801 mfd_core usb_common
[2350368.220504] CPU: 4 PID: 14252 Comm: kworker/4:2 Tainted: G        W   =
      4.19.0-9-amd64 #1 Debian 4.19.118-2+deb10u1
[2350368.220505] Hardware name: Supermicro SYS-5029P-WTR/X11SPW-TF, BIOS 2.=
1a 09/17/2018
[2350368.220528] Workqueue: events do_async_commit [btrfs]
[2350368.220550] RIP: 0010:__btrfs_free_extent.isra.75+0x26c/0x8c0 [btrfs]
[2350368.220551] Code: 24 48 8b 40 50 f0 48 0f ba a8 00 17 00 00 02 72 1b 4=
1 83 fd fb 0f 84 6b 25 09 00 44 89 ee 48 c7 c7 e0 81 7c c0 e8 4e 1d b6 ec <=
0f> 0b 48 8b 3c 24 44 89 e9 ba 95 1a 00 00 48 c7 c6 a0 da 7b c0 e8
[2350368.220553] RSP: 0018:ffffba5647217b18 EFLAGS: 00010286
[2350368.220554] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000006
[2350368.220555] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff96dc1=
0d166b0
[2350368.220556] RBP: 00000a4ed7910000 R08: 000000000006f2ba R09: 000000000=
0000004
[2350368.220557] R10: 0000000000000000 R11: 0000000000000001 R12: ffff96d8e=
7b50540
[2350368.220558] R13: 00000000ffffffe4 R14: 0000000000000000 R15: 000000000=
0000002
[2350368.220559] FS:  0000000000000000(0000) GS:ffff96dc10d00000(0000) knlG=
S:0000000000000000
[2350368.220560] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2350368.220561] CR2: 00007fb20412a9c0 CR3: 0000000353a0a002 CR4: 000000000=
07606e0
[2350368.220562] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[2350368.220563] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[2350368.220564] PKRU: 55555554
[2350368.220564] Call Trace:
[2350368.220594]  ? btrfs_merge_delayed_refs+0x21e/0x310 [btrfs]
[2350368.220613]  __btrfs_run_delayed_refs+0x70a/0xfe0 [btrfs]
[2350368.220633]  btrfs_run_delayed_refs+0x6a/0x180 [btrfs]
[2350368.220652]  btrfs_write_dirty_block_groups+0x165/0x3a0 [btrfs]
[2350368.220670]  ? btrfs_run_delayed_refs+0xac/0x180 [btrfs]
[2350368.220691]  commit_cowonly_roots+0x242/0x2f0 [btrfs]
[2350368.220712]  btrfs_commit_transaction+0x314/0x890 [btrfs]
[2350368.220716]  ? __switch_to_asm+0x41/0x70
[2350368.220718]  ? __switch_to+0x8c/0x440
[2350368.220720]  ? __switch_to_asm+0x35/0x70
[2350368.220741]  do_async_commit+0x22/0x30 [btrfs]
[2350368.220745]  process_one_work+0x1a7/0x3a0
[2350368.220748]  worker_thread+0x30/0x390
[2350368.220751]  ? create_worker+0x1a0/0x1a0
[2350368.220753]  kthread+0x112/0x130
[2350368.220755]  ? kthread_bind+0x30/0x30
[2350368.220757]  ret_from_fork+0x35/0x40
[2350368.220759] ---[ end trace 29a36f403bc46833 ]---
[2350368.220761] BTRFS: error (device sda) in __btrfs_free_extent:6805: err=
no=3D-28 No space left
[2350368.220800] BTRFS info (device sda): forced readonly
[2350368.220802] BTRFS: error (device sda) in btrfs_run_delayed_refs:2935: =
errno=3D-28 No space left
[2350368.238585] BTRFS warning (device sda): Skipping commit of aborted tra=
nsaction.
[2350368.238587] BTRFS: error (device sda) in cleanup_transaction:1860: err=
no=3D-28 No space left

df reports plenty of free space:
root@ht-backup01:/home/ansible# df -h /var/urbackup/
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda         28T  8.6T   13T  41% /var/urbackup


At this point, I believe this filesystem can not be trusted, even if some
tooling managed to repair it to a seemingly working state. However, I am
interested in knowing what happened so we can prevent the same situation
in the future.

The filesystem was created on this machine only a couple of months ago.
The machine has not been reinstalled during that period (it's been on
debian buster the entire time). This is a physical supermicro server hosted
in our primary datacenter with redundant power. To my knowledge it has
never had an unclean shutdown.

Any ideas?

-Dav=ED=F0

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEvylfYbt7o3c60Grm/+HlKLuPmJoFAl8/mSoACgkQ/+HlKLuP
mJrydgf+O8Y6EHFUspFbjLDy1oMWY2K0cKIH5EiMFpcOaza1juR3PkVwWwdm6EFo
sysvbQ5VYVkdmPY8uFL4o+l4kRe6RZr+daUCBcrp6aykcjaIMJ1d4UNtl7atMHQM
Rq8Ymqv5gXKEQVQA9tkoI81EYhcW+MHoXVnkl6MppK3UgpV3OW/eOlGizl6OYRL8
AyUALWsVOepUPTT0QCNlEN/qd0dR5dPP99h7YvVmUEXiirI3V6jNBQEmtKs2KsCC
ub98S46gRrJhBKfs2zLQc3Vqk4alQsXDQAOf3vICQ2KXbUiZzSLjwjlQzl86Lz/T
5IQgbLANuT2MOZFFCInqJR0Jyjm3mQ==
=ozgZ
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
