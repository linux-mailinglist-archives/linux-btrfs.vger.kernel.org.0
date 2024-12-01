Return-Path: <linux-btrfs+bounces-9993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B556E9DF706
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 20:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7255A28171D
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D221D8A14;
	Sun,  1 Dec 2024 19:56:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C11D7E33
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733082992; cv=none; b=MpckaOUq/iIW2tADTqe2v7P2TTEX95l3knfgV8draeg9ypb7jE+pwn7D/3W9vbXjEA3Mf78i7UAxGlaym2YH3FAswTokPUkEPkHoPiNb4MPPYxYoCKBlWAAQwV4yLQ7JUMIB82YfN5x8VxxMT9k/N8DI+ttUuoSmLDjd2XtAoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733082992; c=relaxed/simple;
	bh=SCch2L2MtN+Fyn17nUlVN196V4YEMDm1bKP/yEOwR50=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kRTNZTISJpnGHizHR37R7epex9aFjpjtAvWpadV0Fn4CFLeUy7jkBO2nKmoP/Ws+aK57+A/HMBrc78WAxtAMBDj5xCO9GoXHa8jzYoFLfYt5fiGekq/perwY9+3fLTxwNlD7RjvUwcMEcyO/bfqaywJus3UVWSVkVTCZLjhQP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-84182041b05so345791039f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Dec 2024 11:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733082989; x=1733687789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zywbpfhQVInWWU7yfuHrgIF9fr2pzzw6OCVB+iJtQ/Q=;
        b=L4uurOR7qQWNU+j9PueZntNupUII42goFWx1FMjRY9Z2WUhFEZnm/lWGvrPy1MbYIH
         7g4H+R2DdvwHlWGaHtNi7SeHrocQVI+amNfihseB9GA0/s7x8PHUnHKUFmQC4b50KAe0
         uonOrnzAdejIFvS7bZkh6TY41ZMbS/Z4agw/GO9Gviz5tkCf9R9W9rdFyX5KNnstNK6c
         ZyjrtBSCoaCgoGlCL95GSlFd9qaJpuuGA/ht2S+VKjs7pj2bXIwYv5QxTQ2yDdpCeObr
         Dg5ZLCK6+GDvayQql89pRzuV2SzKLGsA8x8cXTX+awv5Lz9xk4V24OW1swqpbMUYUM1P
         LDZA==
X-Forwarded-Encrypted: i=1; AJvYcCUe8Na46+xJ4W0xz1i/Jui1YhB1Fy0PICkb//5NlSgGZWVLSdL7FluaNmuCYOhSHDj3b7NH3eiczZCTNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwS6hzNRsz3sroWL1h1Meex9BizhJiRlNqj0dQbB6LDdl8yCe
	t7jsWxjTnGzQ8YEH9uj+m1rLAusM6TTj/6prmBi3MtvkkWo6Lu2vSoarB6Amvpbvq4oWJrVUS07
	tCWijGuZPryiyts9E8e+lM9Mnt5WxXNPJQCew5cB71kP1PkRVts7GYGE=
X-Google-Smtp-Source: AGHT+IHys3c+YsqeM5Pq2OzIjdAxgufwZLhIHgS5fAcoPziiReZeJ70FT9hNVGLqwGhIQRFxbSY07iWuI0ElzZVz09tsuZ30cy+J
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3a7c55ea494mr171381105ab.21.1733082989302; Sun, 01 Dec 2024
 11:56:29 -0800 (PST)
Date: Sun, 01 Dec 2024 11:56:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674cbf6d.050a0220.48a03.0011.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_search_slot (3)
From: syzbot <syzbot+7791482179507f327138@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaf20f870da0 Merge tag 'rpmsg-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1655af5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=493f836b3188006b
dashboard link: https://syzkaller.appspot.com/bug?extid=7791482179507f327138
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08102d213bca/disk-aaf20f87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80a985df7f54/vmlinux-aaf20f87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2eccce18d2d9/bzImage-aaf20f87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7791482179507f327138@syzkaller.appspotmail.com

BTRFS info (device loop6): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
BTRFS info (device loop6): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device loop6): using free-space-tree
======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-10296-gaaf20f870da0 #0 Not tainted
------------------------------------------------------
syz.6.761/8746 is trying to acquire lock:
ffff8880262b3598 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

but task is already holding lock:
ffff8880262b2878 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (btrfs-tree-01){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
       btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
       btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
       btrfs_read_lock_root_node+0x3f/0xd0 fs/btrfs/locking.c:267
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1790 [inline]
       btrfs_search_slot+0x4f7/0x3150 fs/btrfs/ctree.c:2112
       btrfs_lookup_file_extent+0x14c/0x210 fs/btrfs/file-item.c:267
       btrfs_drop_extents+0x453/0x33e0 fs/btrfs/file.c:233
       __cow_file_range_inline+0x2e9/0x1140 fs/btrfs/inode.c:679
       cow_file_range_inline+0x317/0x3d0 fs/btrfs/inode.c:738
       cow_file_range+0x39e/0x11f0 fs/btrfs/inode.c:1357
       run_delalloc_cow+0x107/0x1f0 fs/btrfs/inode.c:1743
       submit_uncompressed_range+0x191/0x3a0 fs/btrfs/inode.c:1128
       submit_one_async_extent fs/btrfs/inode.c:1183 [inline]
       submit_compressed_extents+0x7b4/0x16e0 fs/btrfs/inode.c:1632
       run_ordered_work fs/btrfs/async-thread.c:245 [inline]
       btrfs_work_helper+0x56d/0xc50 fs/btrfs/async-thread.c:324
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #7 (btrfs_trans_num_extwriters){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       join_transaction+0x19c/0xda0 fs/btrfs/transaction.c:313
       start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
       btrfs_rebuild_free_space_tree+0xaf/0x490 fs/btrfs/free-space-tree.c:1327
       btrfs_start_pre_rw_mount+0xeed/0x1300 fs/btrfs/disk-io.c:2998
       open_ctree+0x24f5/0x2a30 fs/btrfs/disk-io.c:3543
       btrfs_fill_super fs/btrfs/super.c:972 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1894 [inline]
       btrfs_get_tree+0x1274/0x1a10 fs/btrfs/super.c:2105
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       fc_mount+0x1b/0xb0 fs/namespace.c:1231
       btrfs_get_tree_subvol fs/btrfs/super.c:2068 [inline]
       btrfs_get_tree+0x65b/0x1a10 fs/btrfs/super.c:2106
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (btrfs_trans_num_writers){++++}-{0:0}:
       reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5374
       __lock_release kernel/locking/lockdep.c:5563 [inline]
       lock_release+0x396/0xa30 kernel/locking/lockdep.c:5870
       percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
       __sb_end_write include/linux/fs.h:1720 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs.h:1837
       __btrfs_end_transaction+0x251/0x630 fs/btrfs/transaction.c:1068
       btrfs_dirty_inode+0x151/0x1a0 fs/btrfs/inode.c:6059
       inode_update_time fs/inode.c:2124 [inline]
       touch_atime+0x27f/0x690 fs/inode.c:2197
       file_accessed include/linux/fs.h:2539 [inline]
       btrfs_file_mmap+0xbd/0x120 fs/btrfs/file.c:1953
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x2206/0x2cd0 mm/vma.c:2456
       mmap_region+0x226/0x2c0 mm/mmap.c:1347
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1013/0xbce0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       loop_reconfigure_limits+0x283/0x9e0 drivers/block/loop.c:1003
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
       blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       btrfs_submit_chunk fs/btrfs/bio.c:745 [inline]
       btrfs_submit_bbio+0xf93/0x18e0 fs/btrfs/bio.c:773
       read_extent_buffer_pages+0x65a/0x910 fs/btrfs/extent_io.c:3558
       btrfs_read_extent_buffer+0xd9/0x770 fs/btrfs/disk-io.c:229
       read_block_for_search+0x79e/0xbb0 fs/btrfs/ctree.c:1619
       btrfs_search_slot+0x121b/0x3150 fs/btrfs/ctree.c:2236
       btrfs_init_root_free_objectid+0x148/0x330 fs/btrfs/disk-io.c:4837
       btrfs_init_fs_root fs/btrfs/disk-io.c:1137 [inline]
       btrfs_get_root_ref+0x5d7/0xc30 fs/btrfs/disk-io.c:1364
       btrfs_get_fs_root fs/btrfs/disk-io.c:1416 [inline]
       open_ctree+0x2470/0x2a30 fs/btrfs/disk-io.c:3532
       btrfs_fill_super fs/btrfs/super.c:972 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1894 [inline]
       btrfs_get_tree+0x1274/0x1a10 fs/btrfs/super.c:2105
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       fc_mount+0x1b/0xb0 fs/namespace.c:1231
       btrfs_get_tree_subvol fs/btrfs/super.c:2068 [inline]
       btrfs_get_tree+0x65b/0x1a10 fs/btrfs/super.c:2106
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (btrfs-tree-00){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
       btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
       btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
       btrfs_search_slot+0x136b/0x3150 fs/btrfs/ctree.c:2260
       btrfs_lookup_file_extent+0x14c/0x210 fs/btrfs/file-item.c:267
       run_delalloc_nocow+0x350/0x11e0 fs/btrfs/inode.c:2022
       btrfs_run_delalloc_range+0x31d/0xf70 fs/btrfs/inode.c:2290
       writepage_delalloc+0x8aa/0xc70 fs/btrfs/extent_io.c:1239
       extent_writepage fs/btrfs/extent_io.c:1499 [inline]
       extent_write_cache_pages fs/btrfs/extent_io.c:2194 [inline]
       btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2325
       do_writepages+0x361/0x880 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       __filemap_fdatawrite_range mm/filemap.c:430 [inline]
       filemap_fdatawrite_range+0x215/0x2c0 mm/filemap.c:448
       btrfs_fdatawrite_range fs/btrfs/file.c:3719 [inline]
       start_ordered_ops fs/btrfs/file.c:1454 [inline]
       btrfs_sync_file+0x3ac/0x1230 fs/btrfs/file.c:1536
       generic_write_sync include/linux/fs.h:2904 [inline]
       btrfs_do_write_iter+0x5e0/0x760 fs/btrfs/file.c:1406
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xaed/0xd30 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  btrfs-tree-00 --> btrfs_trans_num_extwriters --> btrfs-tree-01

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs-tree-01);
                               lock(btrfs_trans_num_extwriters);
                               lock(btrfs-tree-01);
  rlock(btrfs-tree-00);

 *** DEADLOCK ***

3 locks held by syz.6.761/8746:
 #0: ffff88807e73ed38 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1191
 #1: ffff8880245de420 (sb_writers#17){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #1: ffff8880245de420 (sb_writers#17){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #2: ffff8880262b2878 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

stack backtrace:
CPU: 1 UID: 0 PID: 8746 Comm: syz.6.761 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
 btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
 btrfs_tree_read_lock fs/btrfs/locking.h:178 [inline]
 btrfs_search_slot+0x136b/0x3150 fs/btrfs/ctree.c:2260
 btrfs_lookup_file_extent+0x14c/0x210 fs/btrfs/file-item.c:267
 run_delalloc_nocow+0x350/0x11e0 fs/btrfs/inode.c:2022
 btrfs_run_delalloc_range+0x31d/0xf70 fs/btrfs/inode.c:2290
 writepage_delalloc+0x8aa/0xc70 fs/btrfs/extent_io.c:1239
 extent_writepage fs/btrfs/extent_io.c:1499 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2194 [inline]
 btrfs_writepages+0x1157/0x2370 fs/btrfs/extent_io.c:2325
 do_writepages+0x361/0x880 mm/page-writeback.c:2702
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0x215/0x2c0 mm/filemap.c:448
 btrfs_fdatawrite_range fs/btrfs/file.c:3719 [inline]
 start_ordered_ops fs/btrfs/file.c:1454 [inline]
 btrfs_sync_file+0x3ac/0x1230 fs/btrfs/file.c:1536
 generic_write_sync include/linux/fs.h:2904 [inline]
 btrfs_do_write_iter+0x5e0/0x760 fs/btrfs/file.c:1406
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaed/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a48580809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a49300058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1a48745fa0 RCX: 00007f1a48580809
RDX: 0000000000000006 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f1a485f393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1a48745fa0 R15: 00007ffec059ee68
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

