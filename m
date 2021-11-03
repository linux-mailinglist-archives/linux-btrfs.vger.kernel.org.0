Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D654441C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Nov 2021 13:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhKCMo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhKCMo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 08:44:58 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Nov 2021 05:42:22 PDT
Received: from tart.uberspace.net (tart.uberspace.net [IPv6:2a01:4f8:1c0c:73c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C093C061714
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Nov 2021 05:42:21 -0700 (PDT)
Received: from dws.uberspace.net (broadband-95-84-195-15.ip.moscow.rt.ru [95.84.195.15])
        by tart.uberspace.net (Postfix) with ESMTPSA id 1A3B721BAD
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Nov 2021 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uberspace.net;
        s=tart2020; t=1635942779;
        bh=DaQ+5dES51k7U8Fl0prKs5rkl/smoD54KAFyTSAxBYU=;
        h=From:To:Subject:Date:From;
        b=USms8SyCdWOv0ql2noISCiXg9RUWzYLjV8QbCojGx213IrLUJgkboADRT+B8xyTCt
         BvsT1UNOYzBauX44USiX3WA0zITG86INWthrCsRn58FBDbGjn+aQn9+2BDmdxchxEY
         sqXc+EVlavg6Cy+kDhZG7NlgOSYA/yF29G31gbFZuKpnXXTXsto2gXL85sbEKQj5KS
         4aXGzh1klKE3kjl/oAAJ0IsCqDQjVsKzM/AAskknnGdGRdGUV5jubz4+7f4eDEsF0s
         vv/M6GCuMDNuXvPHw01cgFuW7o37U2j2lJT9L9VvmQQuenE9G95luTCKg1yihGhaa7
         7B9rdlL0GRh8g==
User-agent: mu4e 1.4.15; emacs 27.1
From:   defanor <defanor@uberspace.net>
To:     linux-btrfs@vger.kernel.org
Subject: ENOSPC consequences on Linux 4.9
Date:   Wed, 03 Nov 2021 15:32:57 +0300
Message-ID: <87zgqlju6e.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hello,

I've observed an ENOSPC-related issue on a rather dated system. The
files are already copied to a newly created filesystem, and possibly
it's a bug that was fixed in newer versions, but I'm still curious to
find out what it was, and maybe there's a surviving bug involved.

The system:

# uname -a
Linux venus 4.9.0-14-amd64 #1 SMP Debian 4.9.246-2 (2020-12-17) x86_64 GNU/Linux
# btrfs --version
Btrfs v3.17
# cat /etc/debian_version 
9.9

The /home file system on sda4 ran out of space, some files were removed
from it, but it was still reporting not having space, and rebalancing
("btrfs balance start -dusage=5 /home") kept reporting "No space left on
device". Usually on that system it helps to add a device, rebalance it,
and remove the device in such a case; a loop device was added,
rebalancing still failed, and then the loop device was removed. That
happened between 11:58:35 and 12:01:17 in the attached kern.log
excerpts.

At about 13:50 in the same log I've joined and tried to add a 200 GB
device (sdb6) to rebalance with it, but that also failed with the same
error message. Attempted to remount with the clear_cache option, which
didn't seem to affect it, and neither did "btrfs balance start -dusage=0
/home". As was suggested on the btrfs IRC channel, tried to check
quotas, with `btrfs qgroup show /home` only printing "ERROR: can't
perform the search - No such file or directory" and "ERROR: can't list
qgroups: No such file or directory" (but I'm pretty sure that quotas
were never configured there). No snapshots or anything fancy was used on
it, and it was mounted with the default options.

Filesystem state at that point:

$ sudo btrfs fi df /home
Data, single: total=442.01GiB, used=338.97GiB
System, DUP: total=8.00MiB, used=80.00KiB
System, single: total=4.00MiB, used=0.00B
Metadata, DUP: total=11.81GiB, used=1.32GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

$ sudo btrfs fi show /home
Label: none  uuid: f0d4f203-f70d-4a84-b18d-a1f34ffdaa8b
        Total devices 2 FS bytes used 340.29GiB
        devid    1 size 465.66GiB used 465.66GiB path /dev/sda4
        devid    2 size 200.00GiB used 8.00MiB path /dev/sdb6

At 15:10:22 I've created sdb7 with a new filesystem on it, and started
copying files with `rsync -a`. "Input/Output" errors started happening
soon, and rsync got stuck in a loop of the following two function calls,
as was seen with strace (a path to a file is replaced with "PATH"; it
was the same path in every call):

lstat("PATH", {st_mode=S_IFREG|0640, st_size=192512, ...}) = 0
getdents(3, /* 1 entries */, 32768)     = 56

Trying to access that path with ls(1) led to ls hanging as well, so I've
excluded it. As checked later, apparently the file was a few years
old. About half the files (by volume) still failed to be copied with
"Input/Output error", with mostly those "parent transid verify failed"
errors in dmesg, which was happening when trying to access them with ls
too. As the attached log points out, early in the copying process the
filesystem went read-only (15:11:19).

By 21:44 I've killed all the processes that were using /home, unmounted
it, mounted it read-only in a different location, and all the files were
readable again, without errors on reading or in dmesg.

The current filesystem state:

# btrfs fi df /mnt/old-home
Data, single: total=442.01GiB, used=338.97GiB
System, DUP: total=8.00MiB, used=80.00KiB
System, single: total=4.00MiB, used=0.00B
Metadata, RAID1: total=8.00MiB, used=4.73MiB
Metadata, DUP: total=11.81GiB, used=1.32GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfs fi show /mnt/old-home
Label: none  uuid: f0d4f203-f70d-4a84-b18d-a1f34ffdaa8b
        Total devices 2 FS bytes used 340.29GiB
        devid    1 size 465.66GiB used 465.66GiB path /dev/sda4
        devid    2 size 200.00GiB used 8.00MiB path /dev/sdb6

Booting into a newer operating system or updating it now would be
problematic, but potentially dangerous/invasive to that filesystem
repairs and checks are fine, since it's not used or needed anymore. Is
it the time to run `btrfs check` or `btrfs rescue`?

The kern.log excerpts are attached.


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=kern-log-excerpts.txt
Content-Description: /var/log/kern.log excerpts

Nov  2 11:33:39 venus kernel: [22186672.211451] BTRFS info (device sda4): relocating block group 535289659392 flags 1
Nov  2 11:33:53 venus kernel: [22186686.011360] BTRFS info (device sda4): found 14 extents
Nov  2 11:34:03 venus kernel: [22186696.085245] BTRFS info (device sda4): found 14 extents
Nov  2 11:34:08 venus kernel: [22186701.147422] BTRFS info (device sda4): relocating block group 15598616576 flags 1
Nov  2 11:34:24 venus kernel: [22186717.713420] BTRFS info (device sda4): found 12410 extents
Nov  2 11:35:05 venus kernel: [22186758.551519] BTRFS info (device sda4): found 12410 extents
Nov  2 11:35:05 venus kernel: [22186758.669245] BTRFS info (device sda4): relocating block group 14524874752 flags 1
Nov  2 11:35:07 venus kernel: [22186759.886442] BTRFS info (device sda4): found 11 extents
Nov  2 11:35:07 venus kernel: [22186759.940501] BTRFS info (device sda4): found 11 extents
Nov  2 11:35:07 venus kernel: [22186759.947234] BTRFS info (device sda4): relocating block group 13451132928 flags 1
Nov  2 11:35:07 venus kernel: [22186760.361546] BTRFS info (device sda4): found 32 extents
Nov  2 11:35:07 venus kernel: [22186760.536201] BTRFS info (device sda4): found 32 extents
Nov  2 11:35:07 venus kernel: [22186760.542565] BTRFS info (device sda4): relocating block group 12914262016 flags 36
Nov  2 11:36:00 venus kernel: [22186813.150709] BTRFS info (device sda4): found 2239 extents
Nov  2 11:36:00 venus kernel: [22186813.157496] BTRFS info (device sda4): 443 enospc errors during balance
Nov  2 11:36:20 venus kernel: [22186833.251325] BTRFS info (device sda4): relocating block group 538109280256 flags 36
Nov  2 11:36:20 venus kernel: [22186833.262899] BTRFS info (device sda4): relocating block group 537035538432 flags 1
Nov  2 11:36:31 venus kernel: [22186844.561910] BTRFS info (device sda4): relocating block group 535961796608 flags 1
Nov  2 11:36:37 venus kernel: [22186850.357671] BTRFS info (device sda4): relocating block group 19356712960 flags 36
Nov  2 11:36:50 venus kernel: [22186863.235494] BTRFS info (device sda4): relocating block group 18819842048 flags 36
Nov  2 11:37:20 venus kernel: [22186893.647285] BTRFS info (device sda4): relocating block group 18282971136 flags 36
Nov  2 11:38:33 venus kernel: [22186966.298985] BTRFS info (device sda4): found 3539 extents
Nov  2 11:38:34 venus kernel: [22186967.111365] BTRFS info (device sda4): relocating block group 5398069248 flags 1
Nov  2 11:38:50 venus kernel: [22186983.321384] BTRFS info (device sda4): found 1228 extents
Nov  2 11:39:06 venus kernel: [22186999.739311] BTRFS info (device sda4): found 1228 extents
Nov  2 11:39:07 venus kernel: [22187000.368272] BTRFS info (device sda4): relocating block group 4324327424 flags 1
Nov  2 11:39:08 venus kernel: [22187000.813273] BTRFS info (device sda4): relocating block group 4194304 flags 4
Nov  2 11:39:09 venus kernel: [22187001.274713] BTRFS info (device sda4): 326 enospc errors during balance
Nov  2 11:51:46 venus kernel: [22187759.054280] BTRFS info (device sda4): 440 enospc errors during balance
Nov  2 11:51:53 venus kernel: [22187766.793725] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 11:52:03 venus kernel: [22187776.378873] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 11:54:34 venus kernel: [22187927.463608] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 11:58:35 venus kernel: [22188168.026352] loop: module loaded
Nov  2 11:59:43 venus kernel: [22188236.650688] BTRFS info (device sda4): disk added /dev/loop0
Nov  2 12:00:39 venus kernel: [22188292.180502] BTRFS info (device sda4): 282 enospc errors during balance
Nov  2 12:00:48 venus kernel: [22188301.531539] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 12:01:17 venus kernel: [22188330.384305] BTRFS info (device sda4): disk deleted /dev/loop0
Nov  2 12:04:34 venus kernel: [22188527.570038] BTRFS info (device sda4): disk space caching is enabled
Nov  2 12:04:41 venus kernel: [22188534.643421] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 12:05:33 venus kernel: [22188586.433920] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 12:07:01 venus kernel: [22188674.729122] BTRFS info (device sda3): relocating block group 1823595298816 flags 1
Nov  2 12:07:03 venus kernel: [22188676.708319] BTRFS info (device sda3): found 64 extents
Nov  2 12:07:13 venus kernel: [22188686.103427] BTRFS info (device sda3): found 64 extents
Nov  2 12:07:30 venus kernel: [22188702.992753] BTRFS info (device sda3): relocating block group 2003582320640 flags 1
Nov  2 12:07:30 venus kernel: [22188703.048822] BTRFS info (device sda3): found 4 extents
Nov  2 12:07:31 venus kernel: [22188703.917933] BTRFS info (device sda3): found 4 extents
Nov  2 12:07:31 venus kernel: [22188703.969487] BTRFS info (device sda3): relocating block group 2002508578816 flags 1

[...]

Nov  2 12:09:46 venus kernel: [22188839.116233] BTRFS info (device sda3): found 102 extents
Nov  2 12:09:50 venus kernel: [22188843.126863] BTRFS info (device sda3): found 102 extents
Nov  2 12:09:50 venus kernel: [22188843.228689] BTRFS info (device sda3): relocating block group 1561652625408 flags 1
Nov  2 12:09:55 venus kernel: [22188848.203375] BTRFS info (device sda3): found 98 extents
Nov  2 12:09:58 venus kernel: [22188851.585354] BTRFS info (device sda3): found 98 extents
Nov  2 12:15:07 venus kernel: [22189160.566595] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 13:50:12 venus kernel: [22194865.168109] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 13:55:06 venus kernel: [22195159.568987] BTRFS info (device sda4): disk added /dev/sdb6
Nov  2 13:55:16 venus kernel: [22195169.717906] BTRFS info (device sda4): 3 enospc errors during balance
Nov  2 13:55:39 venus kernel: [22195193.053344] BTRFS info (device sda4): 3 enospc errors during balance
Nov  2 13:55:41 venus kernel: [22195194.971100] BTRFS info (device sda4): 41 enospc errors during balance
Nov  2 13:56:16 venus kernel: [22195230.030284] BTRFS info (device sda4): 41 enospc errors during balance
Nov  2 13:57:09 venus kernel: [22195282.282191] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 13:57:17 venus kernel: [22195290.486295] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 13:57:25 venus kernel: [22195298.792523] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 14:01:34 venus kernel: [22195547.163431] BTRFS info (device sda4): force clearing of disk cache
Nov  2 14:01:34 venus kernel: [22195547.163434] BTRFS info (device sda4): disk space caching is enabled
Nov  2 14:01:57 venus kernel: [22195570.724751] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 14:03:29 venus kernel: [22195662.287141] BTRFS info (device sda4): 7 enospc errors during balance
Nov  2 14:04:23 venus kernel: [22195716.559779] BTRFS info (device sda4): 30 enospc errors during balance
Nov  2 14:04:28 venus kernel: [22195721.670090] BTRFS info (device sda4): 20 enospc errors during balance
Nov  2 14:04:33 venus kernel: [22195726.261514] BTRFS info (device sda4): 17 enospc errors during balance
Nov  2 14:06:28 venus kernel: [22195841.765549] BTRFS info (device sda4): 10 enospc errors during balance
Nov  2 14:06:34 venus kernel: [22195847.802959] BTRFS info (device sda4): 10 enospc errors during balance
Nov  2 14:06:37 venus kernel: [22195850.332055] BTRFS info (device sda4): 10 enospc errors during balance
Nov  2 14:08:29 venus kernel: [22195962.864883] BTRFS info (device sda4): 1 enospc errors during balance
Nov  2 14:08:45 venus kernel: [22195979.110124] BTRFS info (device sda4): 51 enospc errors during balance
Nov  2 14:09:14 venus kernel: [22196007.806092] BTRFS info (device sda4): 51 enospc errors during balance
Nov  2 14:37:17 venus kernel: [22197690.391953] BTRFS info (device sda4): 51 enospc errors during balance
Nov  2 15:10:22 venus kernel: [22199675.531292] BTRFS: device label home devid 1 transid 3 /dev/sdb7
Nov  2 15:10:39 venus kernel: [22199692.474505] BTRFS info (device sdb7): disk space caching is enabled
Nov  2 15:10:39 venus kernel: [22199692.474508] BTRFS info (device sdb7): flagging fs with big metadata feature
Nov  2 15:10:39 venus kernel: [22199692.535795] BTRFS info (device sdb7): creating UUID tree
Nov  2 15:11:19 venus kernel: [22199732.716461] ------------[ cut here ]------------
Nov  2 15:11:19 venus kernel: [22199732.716502] WARNING: CPU: 24 PID: 31995 at /build/linux-1O0D1e/linux-4.9.246/fs/btrfs/extent-tree.c:2967 btrfs_run_delayed_refs+0x27f/0x2b0 [btrfs]
Nov  2 15:11:19 venus kernel: [22199732.716503] BTRFS: Transaction aborted (error -28)
Nov  2 15:11:19 venus kernel: [22199732.716507] Modules linked in: loop unix_diag tcp_diag udp_diag inet_diag fuse ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c ext4 crc16 jbd2 fscrypto ecb mbcache dm_mod ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xt_policy iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype drbg ansi_cprng authenc iptable_filter echainiv xfrm6_mode_tunnel xfrm4_mode_tunnel des3_ede_x86_64 des_generic xt_conntrack cbc nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user aufs(O) xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo overlay pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) binfmt_misc intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_ascii nls_cp437 vfat fat irqbypass iTCO_wdt iTCO_vendor_support
Nov  2 15:11:19 venus kernel: [22199732.716577]  evdev joydev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mgag200 mxm_wmi intel_cstate ttm drm_kms_helper intel_uncore drm i2c_algo_bit intel_rapl_perf lpc_ich sg efi_pstore mfd_core wmi shpchp mei_me mei ioatdma efivars pcspkr acpi_pad button acpi_power_meter efivarfs ip_tables x_tables autofs4 btrfs crc32c_generic xor raid6_pq hid_generic usbhid hid sr_mod cdrom sd_mod crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd xhci_pci ehci_pci ahci ixgbe xhci_hcd libahci ehci_hcd dca libata ptp usbcore i2c_i801 megaraid_sas pps_core usb_common i2c_smbus mdio scsi_mod
Nov  2 15:11:19 venus kernel: [22199732.716647] CPU: 24 PID: 31995 Comm: kworker/u64:4 Tainted: G           O    4.9.0-14-amd64 #1 Debian 4.9.246-2
Nov  2 15:11:19 venus kernel: [22199732.716648] Hardware name: Intel Corporation S2600WTTR/S2600WTTR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
Nov  2 15:11:19 venus kernel: [22199732.716684] Workqueue: btrfs-extent-refs btrfs_extent_refs_helper [btrfs]
Nov  2 15:11:19 venus kernel: [22199732.716687]  0000000000000000 ffffffffa2137f0e ffffb3d2a92fbcf0 0000000000000000
Nov  2 15:11:19 venus kernel: [22199732.716691]  ffffffffa1e7b97b ffffffffc078bc98 ffffb3d2a92fbd48 ffff9f3f40106a48
Nov  2 15:11:19 venus kernel: [22199732.716693]  ffff9f4ef7c28800 ffff9f3ff88c44c0 ffff9f3ff88c44e0 ffffffffa1e7b9ff
Nov  2 15:11:19 venus kernel: [22199732.716697] Call Trace:
Nov  2 15:11:19 venus kernel: [22199732.716714]  [<ffffffffa2137f0e>] ? dump_stack+0x66/0x88
Nov  2 15:11:19 venus kernel: [22199732.716723]  [<ffffffffa1e7b97b>] ? __warn+0xcb/0xf0
Nov  2 15:11:19 venus kernel: [22199732.716725]  [<ffffffffa1e7b9ff>] ? warn_slowpath_fmt+0x5f/0x80
Nov  2 15:11:19 venus kernel: [22199732.716746]  [<ffffffffc06e958f>] ? btrfs_run_delayed_refs+0x27f/0x2b0 [btrfs]
Nov  2 15:11:19 venus kernel: [22199732.716763]  [<ffffffffc06e9649>] ? delayed_ref_async_start+0x89/0xa0 [btrfs]
Nov  2 15:11:19 venus kernel: [22199732.716784]  [<ffffffffc073448d>] ? btrfs_scrubparity_helper+0xcd/0x350 [btrfs]
Nov  2 15:11:19 venus kernel: [22199732.716793]  [<ffffffffa1e958ca>] ? process_one_work+0x18a/0x430
Nov  2 15:11:19 venus kernel: [22199732.716796]  [<ffffffffa1e95bbd>] ? worker_thread+0x4d/0x490
Nov  2 15:11:19 venus kernel: [22199732.716798]  [<ffffffffa1e95b70>] ? process_one_work+0x430/0x430
Nov  2 15:11:19 venus kernel: [22199732.716801]  [<ffffffffa1e9be69>] ? kthread+0xd9/0xf0
Nov  2 15:11:19 venus kernel: [22199732.716811]  [<ffffffffa241f871>] ? __switch_to_asm+0x41/0x70
Nov  2 15:11:19 venus kernel: [22199732.716814]  [<ffffffffa1e9bd90>] ? kthread_park+0x60/0x60
Nov  2 15:11:19 venus kernel: [22199732.716818]  [<ffffffffa241f8f7>] ? ret_from_fork+0x57/0x70
Nov  2 15:11:19 venus kernel: [22199732.716821] ---[ end trace 6eccdc4d465806ec ]---
Nov  2 15:11:19 venus kernel: [22199732.716824] BTRFS: error (device sda4) in btrfs_run_delayed_refs:2967: errno=-28 No space left
Nov  2 15:11:19 venus kernel: [22199732.718136] BTRFS info (device sda4): forced readonly
Nov  2 15:12:58 venus kernel: [22199831.933717] BTRFS warning (device sda4): sda4 checksum verify failed on 541671260160 wanted 43B0F6AE found ED3DD56D level 0
Nov  2 15:12:58 venus kernel: [22199831.946199] BTRFS error (device sda4): parent transid verify failed on 541671260160 wanted 100359837 found 100359822
Nov  2 15:12:59 venus kernel: [22199832.331160] BTRFS error (device sda4): parent transid verify failed on 541671260160 wanted 100359837 found 100359822

[...]

Nov  2 15:43:10 venus kernel: [22201643.655825] BTRFS error (device sda4): parent transid verify failed on 541668425728 wanted 100359837 found 100359518
Nov  2 15:43:10 venus kernel: [22201643.656265] BTRFS error (device sda4): parent transid verify failed on 541668425728 wanted 100359837 found 100359518
Nov  2 15:43:10 venus kernel: [22201643.656676] BTRFS error (device sda4): parent transid verify failed on 541668425728 wanted 100359837 found 100359518
Nov  2 15:44:52 venus kernel: [22201745.405803] BTRFS warning (device sda4): sda4 checksum verify failed on 541671243776 wanted A62763EF found B2DC2FF5 level 1
Nov  2 15:44:52 venus kernel: [22201745.418087] verify_parent_transid: 346 callbacks suppressed
Nov  2 15:44:52 venus kernel: [22201745.418090] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 15:45:02 venus kernel: [22201755.506295] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 15:45:02 venus kernel: [22201755.513752] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822

[...]

Nov  2 15:52:07 venus kernel: [22202180.453496] BTRFS error (device sda4): parent transid verify failed on 541672816640 wanted 100359837 found 100359834
Nov  2 15:52:07 venus kernel: [22202180.506505] BTRFS error (device sda4): parent transid verify failed on 541672816640 wanted 100359837 found 100359834
Nov  2 15:52:07 venus kernel: [22202180.506986] BTRFS error (device sda4): error loading props for ino 7312799 (root 5): -5
Nov  2 15:52:07 venus kernel: [22202180.507813] BTRFS error (device sda4): parent transid verify failed on 541672816640 wanted 100359837 found 100359834
Nov  2 15:52:07 venus kernel: [22202180.855135] BTRFS error (device sda4): parent transid verify failed on 541672816640 wanted 100359837 found 100359834

[...]

Nov  2 20:54:01 venus kernel: [22220295.333188] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 20:54:01 venus kernel: [22220295.333946] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 20:54:21 venus kernel: [22220315.310658] BTRFS info (device sda4): disk space caching is enabled
Nov  2 20:54:21 venus kernel: [22220315.310662] BTRFS error (device sda4): Remounting read-write after error is not allowed
Nov  2 20:54:24 venus kernel: [22220318.750098] BTRFS info (device sda4): disk space caching is enabled
Nov  2 20:54:24 venus kernel: [22220318.750100] BTRFS error (device sda4): Remounting read-write after error is not allowed
Nov  2 20:54:29 venus kernel: [22220323.088906] verify_parent_transid: 6 callbacks suppressed
Nov  2 20:54:29 venus kernel: [22220323.088911] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 20:54:29 venus kernel: [22220323.089877] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 20:56:58 venus kernel: [22220472.884079] BTRFS info (device sda4): disk space caching is enabled
Nov  2 20:56:58 venus kernel: [22220472.884082] BTRFS error (device sda4): Remounting read-write after error is not allowed
Nov  2 20:57:39 venus kernel: [22220513.924659] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 20:57:39 venus kernel: [22220513.946860] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822

[...]

Nov  2 21:34:01 venus kernel: [22222695.707490] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:34:23 venus kernel: [22222717.918153] BTRFS info (device sdb7): disk space caching is enabled
Nov  2 21:34:24 venus kernel: [22222718.467308] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:34:24 venus kernel: [22222718.503516] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:13 venus kernel: [22223127.464012] BTRFS info (device sda4): disk space caching is enabled
Nov  2 21:41:13 venus kernel: [22223127.464016] BTRFS error (device sda4): Remounting read-write after error is not allowed
Nov  2 21:41:22 venus kernel: [22223136.202000] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:22 venus kernel: [22223136.210330] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:22 venus kernel: [22223136.214738] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:22 venus kernel: [22223136.215618] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:54 venus kernel: [22223168.415895] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:54 venus kernel: [22223168.427211] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:54 venus kernel: [22223168.428131] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:41:54 venus kernel: [22223168.429033] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:43:18 venus kernel: [22223252.457090] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:43:18 venus kernel: [22223252.473733] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:43:18 venus kernel: [22223252.474717] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:43:18 venus kernel: [22223252.475642] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:43:30 venus kernel: [22223265.080821] BTRFS info (device sdb7): disk space caching is enabled
Nov  2 21:44:23 venus kernel: [22223317.435808] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:44:23 venus kernel: [22223317.450121] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:44:23 venus kernel: [22223317.450981] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:44:23 venus kernel: [22223317.451811] BTRFS error (device sda4): parent transid verify failed on 541671243776 wanted 100359837 found 100359822
Nov  2 21:45:04 venus kernel: [22223358.350379] BTRFS error (device sda4): cleaner transaction attach returned -30
Nov  2 21:45:04 venus kernel: [22223358.392330] ------------[ cut here ]------------
Nov  2 21:45:04 venus kernel: [22223358.392382] WARNING: CPU: 22 PID: 29431 at /build/linux-1O0D1e/linux-4.9.246/fs/btrfs/extent-tree.c:5700 btrfs_free_block_groups+0x303/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392383] Modules linked in: loop unix_diag tcp_diag udp_diag inet_diag fuse ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c ext4 crc16 jbd2 fscrypto ecb mbcache dm_mod ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xt_policy iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype drbg ansi_cprng authenc iptable_filter echainiv xfrm6_mode_tunnel xfrm4_mode_tunnel des3_ede_x86_64 des_generic xt_conntrack cbc nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user aufs(O) xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo overlay pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) binfmt_misc intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_ascii nls_cp437 vfat fat irqbypass iTCO_wdt iTCO_vendor_support
Nov  2 21:45:04 venus kernel: [22223358.392456]  evdev joydev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mgag200 mxm_wmi intel_cstate ttm drm_kms_helper intel_uncore drm i2c_algo_bit intel_rapl_perf lpc_ich sg efi_pstore mfd_core wmi shpchp mei_me mei ioatdma efivars pcspkr acpi_pad button acpi_power_meter efivarfs ip_tables x_tables autofs4 btrfs crc32c_generic xor raid6_pq hid_generic usbhid hid sr_mod cdrom sd_mod crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd xhci_pci ehci_pci ahci ixgbe xhci_hcd libahci ehci_hcd dca libata ptp usbcore i2c_i801 megaraid_sas pps_core usb_common i2c_smbus mdio scsi_mod
Nov  2 21:45:04 venus kernel: [22223358.392517] CPU: 22 PID: 29431 Comm: umount Tainted: G        W  O    4.9.0-14-amd64 #1 Debian 4.9.246-2
Nov  2 21:45:04 venus kernel: [22223358.392518] Hardware name: Intel Corporation S2600WTTR/S2600WTTR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
Nov  2 21:45:04 venus kernel: [22223358.392521]  0000000000000000 ffffffffa2137f0e 0000000000000000 0000000000000000
Nov  2 21:45:04 venus kernel: [22223358.392525]  ffffffffa1e7b97b 0000000000000000 ffff9f4ef7c52090 ffff9f4ef7c52000
Nov  2 21:45:04 venus kernel: [22223358.392528]  ffff9f3ef4348800 ffff9f4ef7c520a0 0000000000000000 ffffffffc06e8613
Nov  2 21:45:04 venus kernel: [22223358.392532] Call Trace:
Nov  2 21:45:04 venus kernel: [22223358.392538]  [<ffffffffa2137f0e>] ? dump_stack+0x66/0x88
Nov  2 21:45:04 venus kernel: [22223358.392542]  [<ffffffffa1e7b97b>] ? __warn+0xcb/0xf0
Nov  2 21:45:04 venus kernel: [22223358.392563]  [<ffffffffc06e8613>] ? btrfs_free_block_groups+0x303/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392591]  [<ffffffffc06fa789>] ? close_ctree+0x119/0x350 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392595]  [<ffffffffa2010e3c>] ? generic_shutdown_super+0x6c/0xf0
Nov  2 21:45:04 venus kernel: [22223358.392599]  [<ffffffffa201113e>] ? kill_anon_super+0xe/0x20
Nov  2 21:45:04 venus kernel: [22223358.392618]  [<ffffffffc06cb5b3>] ? btrfs_kill_super+0x13/0x100 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392621]  [<ffffffffa20112aa>] ? deactivate_locked_super+0x3a/0x70
Nov  2 21:45:04 venus kernel: [22223358.392627]  [<ffffffffa203050b>] ? cleanup_mnt+0x3b/0x80
Nov  2 21:45:04 venus kernel: [22223358.392631]  [<ffffffffa1e9a35f>] ? task_work_run+0x7f/0xa0
Nov  2 21:45:04 venus kernel: [22223358.392635]  [<ffffffffa1e03754>] ? exit_to_usermode_loop+0xa4/0xb0
Nov  2 21:45:04 venus kernel: [22223358.392638]  [<ffffffffa1e03bd9>] ? do_syscall_64+0xe9/0x100
Nov  2 21:45:04 venus kernel: [22223358.392642]  [<ffffffffa241f74e>] ? entry_SYSCALL_64_after_swapgs+0x58/0xc6
Nov  2 21:45:04 venus kernel: [22223358.392644] ---[ end trace 6eccdc4d465806ed ]---
Nov  2 21:45:04 venus kernel: [22223358.392645] ------------[ cut here ]------------
Nov  2 21:45:04 venus kernel: [22223358.392665] WARNING: CPU: 22 PID: 29431 at /build/linux-1O0D1e/linux-4.9.246/fs/btrfs/extent-tree.c:5701 btrfs_free_block_groups+0x323/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392665] Modules linked in: loop unix_diag tcp_diag udp_diag inet_diag fuse ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c ext4 crc16 jbd2 fscrypto ecb mbcache dm_mod ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xt_policy iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype drbg ansi_cprng authenc iptable_filter echainiv xfrm6_mode_tunnel xfrm4_mode_tunnel des3_ede_x86_64 des_generic xt_conntrack cbc nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user aufs(O) xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo overlay pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) binfmt_misc intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_ascii nls_cp437 vfat fat irqbypass iTCO_wdt iTCO_vendor_support
Nov  2 21:45:04 venus kernel: [22223358.392719]  evdev joydev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mgag200 mxm_wmi intel_cstate ttm drm_kms_helper intel_uncore drm i2c_algo_bit intel_rapl_perf lpc_ich sg efi_pstore mfd_core wmi shpchp mei_me mei ioatdma efivars pcspkr acpi_pad button acpi_power_meter efivarfs ip_tables x_tables autofs4 btrfs crc32c_generic xor raid6_pq hid_generic usbhid hid sr_mod cdrom sd_mod crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd xhci_pci ehci_pci ahci ixgbe xhci_hcd libahci ehci_hcd dca libata ptp usbcore i2c_i801 megaraid_sas pps_core usb_common i2c_smbus mdio scsi_mod
Nov  2 21:45:04 venus kernel: [22223358.392766] CPU: 22 PID: 29431 Comm: umount Tainted: G        W  O    4.9.0-14-amd64 #1 Debian 4.9.246-2
Nov  2 21:45:04 venus kernel: [22223358.392767] Hardware name: Intel Corporation S2600WTTR/S2600WTTR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
Nov  2 21:45:04 venus kernel: [22223358.392768]  0000000000000000 ffffffffa2137f0e 0000000000000000 0000000000000000
Nov  2 21:45:04 venus kernel: [22223358.392772]  ffffffffa1e7b97b 0000000000000000 ffff9f4ef7c52090 ffff9f4ef7c52000
Nov  2 21:45:04 venus kernel: [22223358.392775]  ffff9f3ef4348800 ffff9f4ef7c520a0 0000000000000000 ffffffffc06e8633
Nov  2 21:45:04 venus kernel: [22223358.392779] Call Trace:
Nov  2 21:45:04 venus kernel: [22223358.392781]  [<ffffffffa2137f0e>] ? dump_stack+0x66/0x88
Nov  2 21:45:04 venus kernel: [22223358.392784]  [<ffffffffa1e7b97b>] ? __warn+0xcb/0xf0
Nov  2 21:45:04 venus kernel: [22223358.392816]  [<ffffffffc06e8633>] ? btrfs_free_block_groups+0x323/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392840]  [<ffffffffc06fa789>] ? close_ctree+0x119/0x350 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392844]  [<ffffffffa2010e3c>] ? generic_shutdown_super+0x6c/0xf0
Nov  2 21:45:04 venus kernel: [22223358.392847]  [<ffffffffa201113e>] ? kill_anon_super+0xe/0x20
Nov  2 21:45:04 venus kernel: [22223358.392866]  [<ffffffffc06cb5b3>] ? btrfs_kill_super+0x13/0x100 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392869]  [<ffffffffa20112aa>] ? deactivate_locked_super+0x3a/0x70
Nov  2 21:45:04 venus kernel: [22223358.392874]  [<ffffffffa203050b>] ? cleanup_mnt+0x3b/0x80
Nov  2 21:45:04 venus kernel: [22223358.392878]  [<ffffffffa1e9a35f>] ? task_work_run+0x7f/0xa0
Nov  2 21:45:04 venus kernel: [22223358.392882]  [<ffffffffa1e03754>] ? exit_to_usermode_loop+0xa4/0xb0
Nov  2 21:45:04 venus kernel: [22223358.392886]  [<ffffffffa1e03bd9>] ? do_syscall_64+0xe9/0x100
Nov  2 21:45:04 venus kernel: [22223358.392890]  [<ffffffffa241f74e>] ? entry_SYSCALL_64_after_swapgs+0x58/0xc6
Nov  2 21:45:04 venus kernel: [22223358.392892] ---[ end trace 6eccdc4d465806ee ]---
Nov  2 21:45:04 venus kernel: [22223358.392902] ------------[ cut here ]------------
Nov  2 21:45:04 venus kernel: [22223358.392924] WARNING: CPU: 22 PID: 29431 at /build/linux-1O0D1e/linux-4.9.246/fs/btrfs/extent-tree.c:10097 btrfs_free_block_groups+0x270/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.392925] Modules linked in: loop unix_diag tcp_diag udp_diag inet_diag fuse ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c ext4 crc16 jbd2 fscrypto ecb mbcache dm_mod ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xt_policy iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype drbg ansi_cprng authenc iptable_filter echainiv xfrm6_mode_tunnel xfrm4_mode_tunnel des3_ede_x86_64 des_generic xt_conntrack cbc nf_nat nf_conntrack br_netfilter bridge stp llc xfrm_user aufs(O) xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_algo overlay pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) binfmt_misc intel_rapl sb_edac edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_ascii nls_cp437 vfat fat irqbypass iTCO_wdt iTCO_vendor_support
Nov  2 21:45:04 venus kernel: [22223358.392993]  evdev joydev crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mgag200 mxm_wmi intel_cstate ttm drm_kms_helper intel_uncore drm i2c_algo_bit intel_rapl_perf lpc_ich sg efi_pstore mfd_core wmi shpchp mei_me mei ioatdma efivars pcspkr acpi_pad button acpi_power_meter efivarfs ip_tables x_tables autofs4 btrfs crc32c_generic xor raid6_pq hid_generic usbhid hid sr_mod cdrom sd_mod crc32c_intel aesni_intel aes_x86_64 glue_helper lrw gf128mul ablk_helper cryptd xhci_pci ehci_pci ahci ixgbe xhci_hcd libahci ehci_hcd dca libata ptp usbcore i2c_i801 megaraid_sas pps_core usb_common i2c_smbus mdio scsi_mod
Nov  2 21:45:04 venus kernel: [22223358.393046] CPU: 22 PID: 29431 Comm: umount Tainted: G        W  O    4.9.0-14-amd64 #1 Debian 4.9.246-2
Nov  2 21:45:04 venus kernel: [22223358.393048] Hardware name: Intel Corporation S2600WTTR/S2600WTTR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
Nov  2 21:45:04 venus kernel: [22223358.393049]  0000000000000000 ffffffffa2137f0e 0000000000000000 0000000000000000
Nov  2 21:45:04 venus kernel: [22223358.393053]  ffffffffa1e7b97b ffff9f3ef3d9ec00 ffff9f3ef3d9ec88 ffff9f4ef7c52000
Nov  2 21:45:04 venus kernel: [22223358.393057]  ffff9f3ef2084df8 ffff9f4ef7c52b60 0000000000000000 ffffffffc06e8580
Nov  2 21:45:04 venus kernel: [22223358.393061] Call Trace:
Nov  2 21:45:04 venus kernel: [22223358.393064]  [<ffffffffa2137f0e>] ? dump_stack+0x66/0x88
Nov  2 21:45:04 venus kernel: [22223358.393067]  [<ffffffffa1e7b97b>] ? __warn+0xcb/0xf0
Nov  2 21:45:04 venus kernel: [22223358.393088]  [<ffffffffc06e8580>] ? btrfs_free_block_groups+0x270/0x3f0 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.393111]  [<ffffffffc06fa789>] ? close_ctree+0x119/0x350 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.393114]  [<ffffffffa2010e3c>] ? generic_shutdown_super+0x6c/0xf0
Nov  2 21:45:04 venus kernel: [22223358.393118]  [<ffffffffa201113e>] ? kill_anon_super+0xe/0x20
Nov  2 21:45:04 venus kernel: [22223358.393136]  [<ffffffffc06cb5b3>] ? btrfs_kill_super+0x13/0x100 [btrfs]
Nov  2 21:45:04 venus kernel: [22223358.393140]  [<ffffffffa20112aa>] ? deactivate_locked_super+0x3a/0x70
Nov  2 21:45:04 venus kernel: [22223358.393144]  [<ffffffffa203050b>] ? cleanup_mnt+0x3b/0x80
Nov  2 21:45:04 venus kernel: [22223358.393148]  [<ffffffffa1e9a35f>] ? task_work_run+0x7f/0xa0
Nov  2 21:45:04 venus kernel: [22223358.393152]  [<ffffffffa1e03754>] ? exit_to_usermode_loop+0xa4/0xb0
Nov  2 21:45:04 venus kernel: [22223358.393156]  [<ffffffffa1e03bd9>] ? do_syscall_64+0xe9/0x100
Nov  2 21:45:04 venus kernel: [22223358.393160]  [<ffffffffa241f74e>] ? entry_SYSCALL_64_after_swapgs+0x58/0xc6
Nov  2 21:45:04 venus kernel: [22223358.393162] ---[ end trace 6eccdc4d465806ef ]---
Nov  2 21:45:04 venus kernel: [22223358.393166] BTRFS info (device sda4): space_info 4 has 18446744036185440256 free, is full
Nov  2 21:45:04 venus kernel: [22223358.393170] BTRFS info (device sda4): space_info total=12692488192, used=1420525568, pinned=0, reserved=0, may_use=48796008448, readonly=65536
Nov  2 21:45:04 venus kernel: [22223358.732523] BTRFS warning (device sda4): page private not zero on page 541671260160
Nov  2 21:45:04 venus kernel: [22223358.732526] BTRFS warning (device sda4): page private not zero on page 541671264256
Nov  2 21:45:04 venus kernel: [22223358.732528] BTRFS warning (device sda4): page private not zero on page 541671268352
Nov  2 21:45:04 venus kernel: [22223358.732530] BTRFS warning (device sda4): page private not zero on page 541671272448
Nov  2 21:45:06 venus kernel: [22223360.928600] BTRFS info (device sdb6): disk space caching is enabled

--=-=-=--
