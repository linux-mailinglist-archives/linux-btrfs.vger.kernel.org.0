Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264D730C79B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 18:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhBBRZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbhBBRXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 12:23:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F86C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Feb 2021 09:22:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s24so2675886pjp.5
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Feb 2021 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nqxgPP123LtLCXQnY/pbG7OMP7na4rsg3wU4faSsLXo=;
        b=Ck0NFGYxCHHRx+Mv0kGKNROo0J+XcTDWMHnAzij2SVjnXdJbBjEYV7oEGi8RtjS/oG
         8PqZ8WCbsQRLz4NaCfAmiJdQ7u+nTzz1EOQe1FI9J5qMD41Xxq2sKot4jlkIHxm/aCnR
         mQ2TqXvpvnzBf88PNMB7b9gU6s1Y/T/wmahrUCiaAagoQk7N5WunfcmMPF63/g82wDoL
         +n6o2p+DD9ET9a/Sr9OEzek2uy4iOovkZla8sKjoy6nP4MD1+MpqUEkBajvbzOdBcRnq
         9XnE7qTJwdKTe5J9B19Auc/4y3WchZsBrEXY5jIRqkwhvI0do07gjIP+Vq+SpPl4KyL1
         uSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nqxgPP123LtLCXQnY/pbG7OMP7na4rsg3wU4faSsLXo=;
        b=cck1bt/sC0mLBELvj2wGXSwxmkfPFVqCpAMtmqAkaYOKqA7BWq2TAMoeLa+hAK+zkV
         IH3USDSUyB8+zaHNObK8nftsDs7+Ui5zgn2pl7wysiNzz4jLi+CWu+wpdG3tYtE6BgP1
         SvnDO4WpmV9arJ8ylyJs4nvFeGenFwfaXQIH3dKxC2HuD3M2+Uf5xxUTp/Mkc/uMtRqP
         kDfHkh6knbMu+KhO4zsRweoj10Qra7NkxxvIOh7Y+/WFzhCpvpILRJ8J3ASAuSG4+oQm
         WtqSNk2XvbvCdDlZcTFBr19Nt0cOJxdfB4w5/c46H/N3vz0ZOolsemxif17nz3K/t/yF
         Xqpw==
X-Gm-Message-State: AOAM533VAdC07LhVulKZ0jH7pgVlIHcLKLGcuhI1xuCxMJIRcdYhUU9Q
        4FhU+9jihm0qzYc+/z+CZ2Z3Gu/6WjA26S+lp+pXS0Syx2k=
X-Google-Smtp-Source: ABdhPJylL6ZF9mzuStnbZSX0k14OMFAbaKkGQzjrl3Vfeh78YOCnaQ3j9OiZZy1OoGA2jz37tO5FVVhy8F0fvf0mxto=
X-Received: by 2002:a17:90a:8996:: with SMTP id v22mr5439129pjn.235.1612286553954;
 Tue, 02 Feb 2021 09:22:33 -0800 (PST)
MIME-Version: 1.0
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Tue, 2 Feb 2021 18:22:22 +0100
Message-ID: <CAA7pwKM2qcRTtEctR+9DiWG+Z0n6XqcABt9NXpaQxYqVLi7gFA@mail.gmail.com>
Subject: [BUG] remove_from_free_space_tree error
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

5 disk raid1 created with Linux 3.18 once upon a time. Most disks have
been replaced through the years and I was about to replace yet another
one with a couple of bad blocks.

Running Linux 5.10.0-2-amd64 #1 SMP Debian 5.10.9-1 (2021-01-20)
x86_64 GNU/Linux. Same problem with Debian 5.9.15-1 (2020-12-17).
btrfs-progs v5.10.

Before removing the failing disk I ran:
# btrfs check --progress --clear-space-cache v1 --clear-ino-cache
/dev/mapper/sda1_crypt

I've been using space cache v2 for some time and figured I might as
well clear some old cruft while checking the filesystem before the
disk replacement.
I don't think I've ever used the inode_cache. Why isn't it called
--clear-inode-cache?

Opening filesystem to check...
Checking filesystem on /dev/mapper/sda1_crypt
UUID: 4242423a-990c-4650-b615-14fe009b0edd
WARNING: free space cache v2 detected, use --clear-space-cache v2,
proceeding with clearing v1
Free space cache cleared

Took some time. No errors, but didn't continue to clear inode_cache or
check the filesystem.

# btrfs check --progress --clear-ino-cache /dev/mapper/sda1_crypt
[sudo] password for plu:
Opening filesystem to check...
Checking filesystem on /dev/mapper/sda1_crypt
UUID: 4242423a-990c-4650-b615-14fe009b0edd
Successfully cleaned up ino cache for root id: 5

OK, but still no filesystem check.

# btrfs check --progress /dev/mapper/sda1_crypt
Opening filesystem to check...
Checking filesystem on /dev/mapper/sda1_crypt
UUID: 4242423a-990c-4650-b615-14fe009b0edd
[1/7] checking root items                      (0:00:30 elapsed,
860551 items checked)
[2/7] checking extents                         (0:02:07 elapsed,
639663 items checked)
could not load free space tree: No such file or directorylapsed, 5435
items checked)
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
[3/7] checking free space tree                 (0:00:02 elapsed, 9211
items checked)
[4/7] checking fs roots                        (0:00:30 elapsed, 9943
items checked)
[5/7] checking csums (without verifying data)  (0:00:14 elapsed,
6846615 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 3
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 9777363066880 bytes used, error(s) found
total csum bytes: 9339968672
total tree bytes: 10480091136
total fs tree bytes: 163545088
total extent tree bytes: 79773696
btree space waste bytes: 708109622
file data blocks allocated: 10818211295232
 referenced 10000370573312

"could not load free space tree: No such file or directory" is a bit
odd. Seems like the free space tree was loaded and checked after all.
Btrfs rebuilds invalid space caches so no worries I guess.

Mounting it and after a little while...

[  859.209667] BTRFS: device label btrfs_pool devid 2 transid 24477751
/dev/dm-0 scanned by systemd-udevd (3446)
[  861.342075] BTRFS: device label btrfs_pool devid 1 transid 24477751
/dev/dm-1 scanned by systemd-udevd (3446)
[  862.050699] BTRFS: device label btrfs_pool devid 3 transid 24477751
/dev/dm-2 scanned by systemd-udevd (3446)
[  864.984361] BTRFS: device label btrfs_pool devid 5 transid 24477751
/dev/dm-4 scanned by systemd-udevd (3446)
[ 1145.035114] BTRFS info (device dm-1): enabling auto defrag
[ 1145.035125] BTRFS info (device dm-1): allowing degraded mounts
[ 1145.035128] BTRFS info (device dm-1): using free space tree
[ 1145.035131] BTRFS info (device dm-1): has skinny extents
[ 1145.037572] BTRFS warning (device dm-1): devid 4 uuid
99017596-67a7-4513-a8f7-738b24c9df2c is missing
[ 1145.058706] BTRFS warning (device dm-1): devid 4 uuid
99017596-67a7-4513-a8f7-738b24c9df2c is missing
[ 1146.384794] BTRFS info (device dm-1): bdev (efault) errs: wr 0, rd
316, flush 0, corrupt 1, gen 0
[ 1161.145402] BTRFS info (device dm-1): checking UUID tree
[ 1223.036539] BTRFS warning (device dm-1): missing free space info
for 15616899547136
[ 1223.036547] ------------[ cut here ]------------
[ 1223.036550] BTRFS: Transaction aborted (error -2)
[ 1223.036742] WARNING: CPU: 6 PID: 3746 at
fs/btrfs/free-space-tree.c:847 remove_from_free_space_tree+0x1a8/0x470
[btrfs]
[ 1223.036755] Modules linked in: dm_crypt dm_mod binfmt_misc
ipmi_ssif intel_powerclamp nls_ascii nls_cp437 coretemp vfat fat
kvm_intel ast kvm drm_vram_helper drm_ttm_helper ttm irqbypass
intel_cstate drm_kms_helper wdat_wdt watchdog pcspkr efi_pstore joydev
evdev at24 cec sg acpi_ipmi ipmi_si button acpi_cpufreq sch_cake
wireguard libchacha20poly1305 chacha_x86_64 poly1305_x86_64
ip6_udp_tunnel udp_tunnel libblake2s blake2s_x86_64 curve25519_x86_64
libcurve25519_generic libchacha libblake2s_generic ipmi_poweroff
ipmi_devintf drm ipmi_msghandler sunrpc bfq fuse configfs efivarfs
ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs
blake2b_generic xor raid6_pq libcrc32c crc32c_generic hid_generic
usbhid hid sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_pclmul
crct10dif_common crc32_pclmul crc32c_intel ghash_clmulni_intel ahci
libahci aesni_intel ehci_pci xhci_pci libaes xhci_hcd crypto_simd
libata cryptd glue_helper ehci_hcd i2c_i801 i2c_smbus igb usbcore
scsi_mod i2c_algo_bit
[ 1223.036947]  lpc_ich dca ptp i2c_ismt pps_core usb_common
[ 1223.036966] CPU: 6 PID: 3746 Comm: btrfs-transacti Not tainted
5.10.0-2-amd64 #1 Debian 5.10.9-1
[ 1223.036969] Hardware name: Supermicro A1SAi/A1SAi, BIOS 2.1 01/18/2018
[ 1223.037048] RIP: 0010:remove_from_free_space_tree+0x1a8/0x470 [btrfs]
[ 1223.037055] Code: 40 0a 00 00 02 72 25 41 83 ff fb 0f 84 d5 02 00
00 41 83 ff e2 0f 84 cb 02 00 00 44 89 fe 48 c7 c7 60 c9 5a c0 e8 18
48 4f d3 <0f> 0b 44 89 f9 ba 4f 03 00 00 48 c7 c6 10 d2 59 c0 48 89 ef
e8 83
[ 1223.037059] RSP: 0018:ffffb62780883ca0 EFLAGS: 00010286
[ 1223.037066] RAX: 0000000000000000 RBX: 0000000000004000 RCX: ffff8f75efd98a08
[ 1223.037070] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8f75efd98a00
[ 1223.037073] RBP: ffff8f7283693410 R08: 0000000000000000 R09: ffffb62780883ac0
[ 1223.037077] R10: ffffb62780883ab8 R11: ffffffff948cb368 R12: ffff8f7284540380
[ 1223.037081] R13: 00000e3417c00000 R14: ffff8f72972a3400 R15: 00000000fffffffe
[ 1223.037086] FS:  0000000000000000(0000) GS:ffff8f75efd80000(0000)
knlGS:0000000000000000
[ 1223.037090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1223.037094] CR2: 0000563827c1c278 CR3: 000000027a80a000 CR4: 00000000001006e0
[ 1223.037098] Call Trace:
[ 1223.037115]  ? kmem_cache_free+0x103/0x410
[ 1223.037180]  ? __btrfs_run_delayed_refs+0x95a/0xfb0 [btrfs]
[ 1223.037247]  __btrfs_run_delayed_refs+0x972/0xfb0 [btrfs]
[ 1223.037323]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 1223.037392]  btrfs_commit_transaction+0x57/0xb40 [btrfs]
[ 1223.037463]  ? start_transaction+0xd2/0x580 [btrfs]
[ 1223.037476]  ? schedule_timeout+0x10/0x140
[ 1223.037544]  transaction_kthread+0x14c/0x170 [btrfs]
[ 1223.037613]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
[ 1223.037620]  kthread+0x11b/0x140
[ 1223.037626]  ? __kthread_bind_mask+0x60/0x60
[ 1223.037634]  ret_from_fork+0x1f/0x30
[ 1223.037641] ---[ end trace 6c9fdea7bec21648 ]---
[ 1223.037649] BTRFS: error (device dm-1) in
remove_from_free_space_tree:847: errno=-2 No such entry
[ 1223.046667] BTRFS info (device dm-1): forced readonly
[ 1223.047416] BTRFS: error (device dm-1) in
btrfs_run_delayed_refs:2191: errno=-2 No such entry

Simply remounting didn't invalidate and clear the space cache but
remounting with clear_cache,nospace_cache,degraded solved the problem.

[ 1043.410912] BTRFS info (device dm-1): enabling auto defrag
[ 1043.410917] BTRFS info (device dm-1): force clearing of disk cache
[ 1043.410920] BTRFS info (device dm-1): disabling free space tree
[ 1043.410923] BTRFS info (device dm-1): allowing degraded mounts
[ 1043.410924] BTRFS info (device dm-1): has skinny extents
[ 1043.429598] BTRFS warning (device dm-1): devid 4 uuid
99017596-67a7-4513-a8f7-738b24c9df2c is missing
[ 1044.779693] BTRFS info (device dm-1): bdev (efault) errs: wr 0, rd
316, flush 0, corrupt 1, gen 0
[ 1059.485942] BTRFS info (device dm-1): clearing free space tree
[ 1059.485950] BTRFS info (device dm-1): clearing compat-ro feature
flag for FREE_SPACE_TREE (0x1)
[ 1059.485953] BTRFS info (device dm-1): clearing compat-ro feature
flag for FREE_SPACE_TREE_VALID (0x2)
[ 1064.817989] BTRFS info (device dm-1): checking UUID tree

Unmount and btrfs check is clean now. Remount with
space_cache=v2,degraded and btrfs replace start -B 4
/dev/mapper/sdd1_crypt /raid
Device replacement completes without problem so everything is fine again.
