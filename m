Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A485634FCB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFDSY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 14:24:28 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35798 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDSY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jun 2019 14:24:27 -0400
Received: by mail-wm1-f51.google.com with SMTP id c6so1079409wml.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2019 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=pE8erKMSCGkW9pCwo94U7mf28jQ62Vxuq6K1O/qsqmY=;
        b=INczUhHi+LUu+hwUm9XN2M0NsmCbzXN2WcGTWiVH9Y4zoq6KMnxj0FeJiJwvNzpmHC
         0pat2+IZi0YRdGuMH9F/y1clFknnnqFSzFg1XPGxu+CAi9h0XCwcQFuN6uWfUKlsRXeG
         ubuJGyllM3P+LRhgAYULVny8Tivz6z6DwlKI5+bn4Rrwv/sSByYmrMNi9eKIvBxZRNL6
         ZSKRc5AdZXxbihKAnwx795ew8QdWHDvOOZ7wo9THiF6Sal7UWDzRarZOhcByms+LqFwO
         mCOjHEaV41sg3Gz/I+VH3r5hExtgPUXUHfcmZAdyzZJmRZBe8a0l9l9WUAW4p1SAqzd6
         87zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pE8erKMSCGkW9pCwo94U7mf28jQ62Vxuq6K1O/qsqmY=;
        b=CTJGtHgll5ubfnFymquOxB2uJgGBv4yqiGXx12iiPwYen34SrxMl08vCEvBWVhAXrb
         vx6unFMULSEm36Cbdl8ToEWIgC7xvl8gigBSncqbzEDeujEFFSsjZwH3p0Iy5k1yK6ui
         GMjVPV1gPyUTZ3iYFxw12oLsZYdqWrgBTHZsBuAgK0lNKaNhMCOcF6wNamIV+173qPqq
         wHSDlDY+KnyZ5Y13DhSx2uxHrSQHAovlcKdXr2N/uCgGbhex96/NlnlP3qDfQOMDyC6w
         2D/gNeaTi/Y3ne/aCa3juN6q8GbFXEmEQRAhRr7RekPTMpZ9649ZMqTPk4lMqkdbyYBv
         jCCw==
X-Gm-Message-State: APjAAAVRTaX8BjWVk/QN+TJx5KFD5x7zaJU1GR/tc5+hViuxQS3I08MJ
        uPTvRk8EU6SWn2rRYaxfK+Zx4kM3oekE0YUkPyq8Zg==
X-Google-Smtp-Source: APXvYqws+Hx5axpZ3cpX0Kl21ZczKMh4eLbY9WmtsyDfLl3xtd/r2Uu8zFeDIqQQkvQgBXR/VAf1kKiGqKNiCy/7828=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr12504909wmj.65.1559672663065;
 Tue, 04 Jun 2019 11:24:23 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 4 Jun 2019 12:24:12 -0600
Message-ID: <CAJCQCtS4PRWU=QUY87FRd4uGE_wA+KSSLW+2e_9XDs5m+RYzsQ@mail.gmail.com>
Subject: 5.2rc2, circular lock warning systemd-journal and btrfs_page_mkwrite
To:     systemd Mailing List <systemd-devel@lists.freedesktop.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is on Fedora Rawhide
systemd-242-3.git7a6d834.fc31.x86_64
kernel 5.2.0-0.rc2.git1.2.fc31.x86_64

Pretty and complete log:
https://drive.google.com/open?id=1vhnIki9lpiWK8T5Qsl81_RToQ8CFdnfU

Probably MUA wrapped, and excerpt only:

[    7.816458] fmac.local systemd[1]: Starting Flush Journal to
Persistent Storage...
[    7.833724] fmac.local systemd-journald[642]: Time spent on
flushing to /var is 83.426ms for 5804 entries.
[    7.833724] fmac.local systemd-journald[642]: System journal
(/var/log/journal/6d5657355b064460b154f7f5da220b50) is 48.0M, max
4.0G, 3.9G free.
[    7.886889] fmac.local kernel:
[    7.886892] fmac.local kernel:
======================================================
[    7.886893] fmac.local kernel: WARNING: possible circular locking
dependency detected
[    7.886895] fmac.local kernel: 5.2.0-0.rc2.git1.2.fc31.x86_64 #1 Not tainted
[    7.886896] fmac.local kernel:
------------------------------------------------------
[    7.886897] fmac.local kernel: systemd-journal/642 is trying to acquire lock:
[    7.886899] fmac.local kernel: (____ptrval____)
(&fs_info->reloc_mutex){+.+.}, at:
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.886926] fmac.local kernel:
                                  but task is already holding lock:
[    7.886926] fmac.local kernel: (____ptrval____)
(sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x69/0x570 [btrfs]
[    7.886943] fmac.local kernel:
                                  which lock already depends on the new lock.
[    7.886944] fmac.local kernel:
                                  the existing dependency chain (in
reverse order) is:
[    7.886945] fmac.local kernel:
                                  -> #6 (sb_pagefaults){.+.+}:
[    7.886949] fmac.local kernel:        __sb_start_write+0x12b/0x1b0
[    7.886965] fmac.local kernel:        btrfs_page_mkwrite+0x69/0x570 [btrfs]
[    7.886970] fmac.local kernel:        do_page_mkwrite+0x2f/0x100
[    7.886973] fmac.local kernel:        do_wp_page+0x306/0x570
[    7.886975] fmac.local kernel:        __handle_mm_fault+0xce8/0x1730
[    7.886976] fmac.local kernel:        handle_mm_fault+0x16e/0x370
[    7.886978] fmac.local kernel:        do_user_addr_fault+0x1f9/0x480
[    7.886980] fmac.local kernel:        do_page_fault+0x33/0x210
[    7.886983] fmac.local kernel:        page_fault+0x1e/0x30
[    7.886984] fmac.local kernel:
                                  -> #5 (&mm->mmap_sem#2){++++}:
[    7.886987] fmac.local kernel:        __might_fault+0x60/0x80
[    7.886989] fmac.local kernel:        _copy_from_user+0x1e/0x90
[    7.886992] fmac.local kernel:        scsi_cmd_ioctl+0x218/0x440
[    7.886994] fmac.local kernel:        cdrom_ioctl+0x3c/0x1272
[    7.886997] fmac.local kernel:        sr_block_ioctl+0xa0/0xd0
[    7.886998] fmac.local kernel:        blkdev_ioctl+0x32b/0xad0
[    7.887001] fmac.local kernel:        block_ioctl+0x3f/0x50
[    7.887003] fmac.local kernel:        do_vfs_ioctl+0x400/0x740
[    7.887004] fmac.local kernel:        ksys_ioctl+0x5e/0x90
[    7.887005] fmac.local kernel:        __x64_sys_ioctl+0x16/0x20
[    7.887008] fmac.local kernel:        do_syscall_64+0x5c/0xa0
[    7.887010] fmac.local kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.887011] fmac.local kernel:
                                  -> #4 (sr_mutex){+.+.}:
[    7.887014] fmac.local kernel:        __mutex_lock+0x92/0x930
[    7.887016] fmac.local kernel:        sr_block_open+0x81/0x100
[    7.887018] fmac.local kernel:        __blkdev_get+0xed/0x590
[    7.887019] fmac.local kernel:        blkdev_get+0x4a/0x380
[    7.887021] fmac.local kernel:        do_dentry_open+0x14c/0x3c0
[    7.887022] fmac.local kernel:        path_openat+0x4e6/0xca0
[    7.887024] fmac.local kernel:        do_filp_open+0x91/0x100
[    7.887025] fmac.local kernel:        do_sys_open+0x184/0x220
[    7.887027] fmac.local kernel:        do_syscall_64+0x5c/0xa0
[    7.887028] fmac.local kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.887029] fmac.local kernel:
                                  -> #3 (&bdev->bd_mutex){+.+.}:
[    7.887032] fmac.local kernel:        __mutex_lock+0x92/0x930
[    7.887033] fmac.local kernel:        __blkdev_get+0x7a/0x590
[    7.887034] fmac.local kernel:        blkdev_get+0x214/0x380
[    7.887036] fmac.local kernel:        blkdev_get_by_path+0x46/0x80
[    7.887053] fmac.local kernel:        btrfs_get_bdev_and_sb+0x1b/0xb0 [btrfs]
[    7.887069] fmac.local kernel:        open_fs_devices+0x7a/0x2a0 [btrfs]
[    7.887086] fmac.local kernel:        btrfs_open_devices+0x92/0xa0 [btrfs]
[    7.887097] fmac.local kernel:        btrfs_mount_root+0x30b/0x690 [btrfs]
[    7.887099] fmac.local kernel:        legacy_get_tree+0x30/0x50
[    7.887102] fmac.local kernel:        vfs_get_tree+0x28/0xf0
[    7.887104] fmac.local kernel:        fc_mount+0xe/0x40
[    7.887106] fmac.local kernel:        vfs_kern_mount.part.0+0x71/0x90
[    7.887117] fmac.local kernel:        btrfs_mount+0x155/0x8b0 [btrfs]
[    7.887119] fmac.local kernel:        legacy_get_tree+0x30/0x50
[    7.887121] fmac.local kernel:        vfs_get_tree+0x28/0xf0
[    7.887123] fmac.local kernel:        do_mount+0x7f5/0xaa0
[    7.887124] fmac.local kernel:        ksys_mount+0x7e/0xc0
[    7.887126] fmac.local kernel:        __x64_sys_mount+0x21/0x30
[    7.887128] fmac.local kernel:        do_syscall_64+0x5c/0xa0
[    7.887129] fmac.local kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.887130] fmac.local kernel:
                                  -> #2 (&fs_devs->device_list_mutex){+.+.}:
[    7.887132] fmac.local kernel:        __mutex_lock+0x92/0x930
[    7.887149] fmac.local kernel:        btrfs_run_dev_stats+0x46/0x3e0 [btrfs]
[    7.887163] fmac.local kernel:        commit_cowonly_roots+0xb5/0x300 [btrfs]
[    7.887177] fmac.local kernel:
btrfs_commit_transaction+0x4e7/0xa30 [btrfs]
[    7.887192] fmac.local kernel:        btrfs_sync_file+0x38d/0x4b0 [btrfs]
[    7.887193] fmac.local kernel:        do_fsync+0x38/0x70
[    7.887195] fmac.local kernel:        __x64_sys_fsync+0x10/0x20
[    7.887196] fmac.local kernel:        do_syscall_64+0x5c/0xa0
[    7.887198] fmac.local kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.887198] fmac.local kernel:
                                  -> #1 (&fs_info->tree_log_mutex){+.+.}:
[    7.887201] fmac.local kernel:        __mutex_lock+0x92/0x930
[    7.887215] fmac.local kernel:
btrfs_commit_transaction+0x48f/0xa30 [btrfs]
[    7.887230] fmac.local kernel:        btrfs_sync_file+0x38d/0x4b0 [btrfs]
[    7.887231] fmac.local kernel:        do_fsync+0x38/0x70
[    7.887232] fmac.local kernel:        __x64_sys_fsync+0x10/0x20
[    7.887234] fmac.local kernel:        do_syscall_64+0x5c/0xa0
[    7.887235] fmac.local kernel:
entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.887236] fmac.local kernel:
                                  -> #0 (&fs_info->reloc_mutex){+.+.}:
[    7.887239] fmac.local kernel:        lock_acquire+0xa2/0x1b0
[    7.887241] fmac.local kernel:        __mutex_lock+0x92/0x930
[    7.887255] fmac.local kernel:
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887269] fmac.local kernel:        start_transaction+0x95/0x4f0 [btrfs]
[    7.887283] fmac.local kernel:        btrfs_dirty_inode+0x44/0xd0 [btrfs]
[    7.887284] fmac.local kernel:        file_update_time+0xeb/0x140
[    7.887299] fmac.local kernel:        btrfs_page_mkwrite+0xfe/0x570 [btrfs]
[    7.887301] fmac.local kernel:        do_page_mkwrite+0x2f/0x100
[    7.887303] fmac.local kernel:        do_wp_page+0x306/0x570
[    7.887304] fmac.local kernel:        __handle_mm_fault+0xce8/0x1730
[    7.887306] fmac.local kernel:        handle_mm_fault+0x16e/0x370
[    7.887307] fmac.local kernel:        do_user_addr_fault+0x1f9/0x480
[    7.887308] fmac.local kernel:        do_page_fault+0x33/0x210
[    7.887310] fmac.local kernel:        page_fault+0x1e/0x30
[    7.887311] fmac.local kernel:
                                  other info that might help us debug this:
[    7.887312] fmac.local kernel: Chain exists of:
                                    &fs_info->reloc_mutex -->
&mm->mmap_sem#2 --> sb_pagefaults
[    7.887314] fmac.local kernel:  Possible unsafe locking scenario:
[    7.887315] fmac.local kernel:        CPU0                    CPU1
[    7.887316] fmac.local kernel:        ----                    ----
[    7.887316] fmac.local kernel:   lock(sb_pagefaults);
[    7.887317] fmac.local kernel:
lock(&mm->mmap_sem#2);
[    7.887319] fmac.local kernel:
lock(sb_pagefaults);
[    7.887320] fmac.local kernel:   lock(&fs_info->reloc_mutex);
[    7.887321] fmac.local kernel:
                                   *** DEADLOCK ***
[    7.887323] fmac.local kernel: 3 locks held by systemd-journal/642:
[    7.887323] fmac.local kernel:  #0: (____ptrval____)
(&mm->mmap_sem#2){++++}, at: do_user_addr_fault+0x12b/0x480
[    7.887326] fmac.local kernel:  #1: (____ptrval____)
(sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x69/0x570 [btrfs]
[    7.887342] fmac.local kernel:  #2: (____ptrval____)
(sb_internal){.+.+}, at: start_transaction+0x37f/0x4f0 [btrfs]
[    7.887357] fmac.local kernel:
                                  stack backtrace:
[    7.887359] fmac.local kernel: CPU: 1 PID: 642 Comm:
systemd-journal Not tainted 5.2.0-0.rc2.git1.2.fc31.x86_64 #1
[    7.887360] fmac.local kernel: Hardware name: Apple Inc.
MacBookPro8,2/Mac-94245A3940C91C80, BIOS
MBP81.88Z.0050.B00.1804101331 04/10/18
[    7.887361] fmac.local kernel: Call Trace:
[    7.887365] fmac.local kernel:  dump_stack+0x85/0xc0
[    7.887367] fmac.local kernel:  print_circular_bug.cold+0x15c/0x195
[    7.887370] fmac.local kernel:  __lock_acquire+0x165b/0x1c30
[    7.887373] fmac.local kernel:  ? find_held_lock+0x32/0x90
[    7.887375] fmac.local kernel:  ? sched_clock+0x5/0x10
[    7.887378] fmac.local kernel:  lock_acquire+0xa2/0x1b0
[    7.887392] fmac.local kernel:  ?
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887406] fmac.local kernel:  ?
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887408] fmac.local kernel:  __mutex_lock+0x92/0x930
[    7.887422] fmac.local kernel:  ?
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887425] fmac.local kernel:  ? rcu_read_lock_sched_held+0x6b/0x80
[    7.887427] fmac.local kernel:  ? module_assert_mutex_or_preempt+0x14/0x40
[    7.887441] fmac.local kernel:  ?
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887443] fmac.local kernel:  ? sched_clock_cpu+0xc/0xc0
[    7.887458] fmac.local kernel:  ?
btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887471] fmac.local kernel:  btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[    7.887486] fmac.local kernel:  start_transaction+0x95/0x4f0 [btrfs]
[    7.887501] fmac.local kernel:  btrfs_dirty_inode+0x44/0xd0 [btrfs]
[    7.887503] fmac.local kernel:  file_update_time+0xeb/0x140
[    7.887518] fmac.local kernel:  btrfs_page_mkwrite+0xfe/0x570 [btrfs]
[    7.887520] fmac.local kernel:  ? find_held_lock+0x32/0x90
[    7.887522] fmac.local kernel:  ? sched_clock+0x5/0x10
[    7.887524] fmac.local kernel:  do_page_mkwrite+0x2f/0x100
[    7.887526] fmac.local kernel:  do_wp_page+0x306/0x570
[    7.887529] fmac.local kernel:  __handle_mm_fault+0xce8/0x1730
[    7.887532] fmac.local kernel:  handle_mm_fault+0x16e/0x370
[    7.887534] fmac.local kernel:  do_user_addr_fault+0x1f9/0x480
[    7.887536] fmac.local kernel:  do_page_fault+0x33/0x210
[    7.887538] fmac.local kernel:  ? page_fault+0x8/0x30
[    7.887540] fmac.local kernel:  page_fault+0x1e/0x30
[    7.887541] fmac.local kernel: RIP: 0033:0x7f97107ea383
[    7.887544] fmac.local kernel: Code: ec 08 89 ee 49 89 d8 31 d2 6a
00 48 8b 4c 24 18 4c 89 f7 4c 8d 4c 24 30 e8 1a d8 ff ff 59 5e 85 c0
78 49 48 8b 44 24 20 31 d2 <48> 89 58 08 48 8b 5c 24 08 c7 40 01 00 00
00 00 66 89 50 05 c6 40
[    7.887545] fmac.local kernel: RSP: 002b:00007ffc79ed77a0 EFLAGS: 00010246
[    7.887546] fmac.local kernel: RAX: 00007f970eca84a8 RBX:
000000000000005d RCX: 0000000000000000
[    7.887548] fmac.local kernel: RDX: 0000000000000000 RSI:
00007f97107ea408 RDI: 000055d0300e8160
[    7.887549] fmac.local kernel: RBP: 0000000000000001 R08:
0000000000000001 R09: 000055d0300e8160
[    7.887550] fmac.local kernel: R10: 00007ffc79f6a080 R11:
00000000000035fc R12: 00007ffc79ed78c8
[    7.887551] fmac.local kernel: R13: 00007ffc79ed78c0 R14:
000055d0300efa60 R15: 0000000000c3d9ef

-- 
Chris Murphy
