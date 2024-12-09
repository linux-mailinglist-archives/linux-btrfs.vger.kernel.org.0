Return-Path: <linux-btrfs+bounces-10143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C698E9E891E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 03:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3518850E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C6481AF;
	Mon,  9 Dec 2024 02:08:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5425777
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710102; cv=none; b=fY7cxTQewf7LdMW9SdCaI/m2FM2Rb0roDW6pAUHQzv5RxHzt6PD7RGeOCXJ5JoIabOQylR7gsp6wuL+iOdRNBchbl41/0BfwpTwl64/j+odeitxx6EKdBMBooNHM3eILUsdmVy08zw04jC35HWLA467otR7ZA35I/cKHLjPCIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710102; c=relaxed/simple;
	bh=EE6gIBFIDcxg3RK+Dqes9lyzwCfPSJeMP7eFCNIBzFg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rdUwwBu4pNh6qUvu0PaZ2NA3Dxg9XUNUPUpLUCmP3azfNnjN2U7g3pN+LSEfA4w7VZsm4VupB+4fjlolB4nf3aJpLZJt7CWEGs/6R0BLDucQ0NF9orcIz3itEG8DB+32GjAaOlu95JW69h1Xxkn8a+MyxFwLr9/VYxPHBTImsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so89527945ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 18:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733710098; x=1734314898;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lfXNRAqHGJS20AQG8iVGH/wROLaZ5+/Nok7R88sm14=;
        b=OfmQkn3KTJRnD83LNtPQvoDN1Tl1oxqfVKjKOwqXXkBjGZIyUEajuMcZTRqDFfa60s
         6V82iKiac3ZXCAU/0Zs1W3busaEARtZ4WA8VsJRTnNibZVhAy5/2TymNip1x6LwDBYhT
         udamBTSQuZyL2J83YSj6tKt83UDzeWsEObbzZ9ckVSGHzXRT515k0jeFxY2gJD/GsgNZ
         +JCNA3fefJoMLVE4Xy7mQ5OgcFonuEhNsUR80BQpzSqHJwWCuU2T0tzxJfE3GL4GQ0X2
         THhflVKbrH++wYUs1k5ZVeTThkHWIJNlzeGH+OEPOUAn2mrEhD8R1NHlMjL8GVf3TCOj
         fL6g==
X-Forwarded-Encrypted: i=1; AJvYcCUP0XwXE6mTN732efDZ3mQ9nkCHZsh3+JRanS85cWmBCwYVYk/TFLnPZZkN3SFUA12JX0QuRnfys5VUBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkYwhQN+d9nvZyvbXCLKFkY5BTIUqqAvUsOFMj0lkLFJ0jtyH
	+4n8wY0PGLeqQLIywr92xINdaIIYQGbeViwZIYAN7QxAfjGXF8zFFkAk4JkjEJYF0K7cUN+cfW7
	dU2Ts1o93NeReFLauKHcrVXshscyugChc8t/TdZI038eXZ29mJMP7v3E=
X-Google-Smtp-Source: AGHT+IFr2OksC5GTD2SW+Y6PpbxZm6aQ0cFpIBbR5fma0+RwO0UCD1F+saGux94/BQKXEjlJnfpd8aGw2ucyE4GiQudev/942tYS
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c24:b0:3a7:e103:3c46 with SMTP id
 e9e14a558f8ab-3a811e06848mr124178305ab.16.1733710098350; Sun, 08 Dec 2024
 18:08:18 -0800 (PST)
Date: Sun, 08 Dec 2024 18:08:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67565112.050a0220.2477f.0035.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in join_transaction (2)
From: syzbot <syzbot+77cf6638a2a1806ef852@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b428df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad7dafcfaa48849c
dashboard link: https://syzkaller.appspot.com/bug?extid=77cf6638a2a1806ef852
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c51d22ca6229/disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/282335ac1978/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d341f69bc687/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77cf6638a2a1806ef852@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0 Not tainted
------------------------------------------------------
kworker/u8:11/15834 is trying to acquire lock:
ffff888067216470 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x430/0x1010 fs/btrfs/transaction.c:288

but task is already holding lock:
ffff88801271a610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_finish_one_ordered+0x3c9/0x2200 fs/btrfs/inode.c:3082

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (sb_internal#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_intwrite include/linux/fs.h:1908 [inline]
       start_transaction+0xbd3/0x1aa0 fs/btrfs/transaction.c:691
       btrfs_dirty_inode+0xc8/0x200 fs/btrfs/inode.c:6055
       btrfs_update_time fs/btrfs/inode.c:6089 [inline]
       btrfs_update_time+0xb2/0xf0 fs/btrfs/inode.c:6080
       inode_update_time fs/inode.c:2124 [inline]
       touch_atime+0x352/0x5d0 fs/inode.c:2197
       file_accessed include/linux/fs.h:2539 [inline]
       btrfs_file_mmap+0x118/0x150 fs/btrfs/file.c:1953
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x1789/0x2670 mm/vma.c:2456
       mmap_region+0x270/0x320 mm/mmap.c:1347
       do_mmap+0xc00/0xfc0 mm/mmap.c:496
       vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x109/0x6d0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x42b/0x640 block/blk-mq-sched.c:473
       elevator_init_mq+0x2cd/0x420 block/elevator.c:610
       add_disk_fwnode+0x113/0x1300 block/genhd.c:413
       sd_probe+0xa86/0x1000 drivers/scsi/sd.c:4024
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #5 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       blk_queue_enter+0x50f/0x640 block/blk-core.c:328
       blk_mq_alloc_request+0x59b/0x950 block/blk-mq.c:651
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x1eb/0xf40 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x213/0xe10 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk.isra.0+0x1a06/0xa8d0 drivers/scsi/sd.c:3734
       sd_probe+0x904/0x1000 drivers/scsi/sd.c:4010
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:949 [inline]
       loop_reconfigure_limits+0x407/0x8c0 drivers/block/loop.c:998
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x901/0x18b0 drivers/block/loop.c:1559
       blkdev_ioctl+0x279/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3091
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       btrfs_submit_dev_bio+0x54d/0xb20 fs/btrfs/bio.c:456
       btrfs_submit_bio+0x50b/0x6d0 fs/btrfs/bio.c:493
       btrfs_submit_chunk fs/btrfs/bio.c:745 [inline]
       btrfs_submit_bbio+0x5c0/0x19c0 fs/btrfs/bio.c:773
       read_extent_buffer_pages+0x5d0/0x8f0 fs/btrfs/extent_io.c:3558
       btrfs_read_extent_buffer+0xd8/0x740 fs/btrfs/disk-io.c:229
       read_block_for_search+0x5fc/0xb60 fs/btrfs/ctree.c:1619
       btrfs_search_slot+0x95f/0x32a0 fs/btrfs/ctree.c:2240
       btrfs_init_root_free_objectid+0xf4/0x2a0 fs/btrfs/disk-io.c:4837
       btrfs_init_fs_root fs/btrfs/disk-io.c:1137 [inline]
       btrfs_get_root_ref+0x646/0xcc0 fs/btrfs/disk-io.c:1364
       btrfs_get_fs_root fs/btrfs/disk-io.c:1416 [inline]
       open_ctree+0x394d/0x5320 fs/btrfs/disk-io.c:3532
       btrfs_fill_super fs/btrfs/super.c:972 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1894 [inline]
       btrfs_get_tree+0x11e7/0x1b20 fs/btrfs/super.c:2105
       vfs_get_tree+0x92/0x380 fs/super.c:1814
       fc_mount+0x16/0xc0 fs/namespace.c:1231
       btrfs_get_tree_subvol fs/btrfs/super.c:2068 [inline]
       btrfs_get_tree+0xa53/0x1b20 fs/btrfs/super.c:2106
       vfs_get_tree+0x92/0x380 fs/super.c:1814
       do_new_mount fs/namespace.c:3507 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount fs/namespace.c:4034 [inline]
       __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs-tree-00){++++}-{4:4}:
       down_read_nested+0x9e/0x330 kernel/locking/rwsem.c:1649
       btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
       btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
       btrfs_read_lock_root_node+0x6d/0xa0 fs/btrfs/locking.c:267
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1790 [inline]
       btrfs_search_slot+0x3ba/0x32a0 fs/btrfs/ctree.c:2116
       btrfs_del_orphan_item+0xbb/0x180 fs/btrfs/orphan.c:41
       btrfs_orphan_del fs/btrfs/inode.c:3472 [inline]
       btrfs_evict_inode+0xcd4/0xe90 fs/btrfs/inode.c:5372
       evict+0x40c/0x960 fs/inode.c:796
       iput_final fs/inode.c:1946 [inline]
       iput fs/inode.c:1972 [inline]
       iput+0x52a/0x890 fs/inode.c:1958
       do_unlinkat+0x5c3/0x760 fs/namei.c:4594
       __do_sys_unlink fs/namei.c:4635 [inline]
       __se_sys_unlink fs/namei.c:4633 [inline]
       __x64_sys_unlink+0xc5/0x110 fs/namei.c:4633
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x164/0x1010 fs/btrfs/transaction.c:313
       start_transaction+0x42c/0x1aa0 fs/btrfs/transaction.c:697
       btrfs_dirty_inode+0xc8/0x200 fs/btrfs/inode.c:6055
       btrfs_update_time fs/btrfs/inode.c:6089 [inline]
       btrfs_update_time+0xb2/0xf0 fs/btrfs/inode.c:6080
       inode_update_time fs/inode.c:2124 [inline]
       touch_atime+0x352/0x5d0 fs/inode.c:2197
       file_accessed include/linux/fs.h:2539 [inline]
       filemap_read+0xb91/0xd70 mm/filemap.c:2714
       btrfs_file_read_iter+0x17b/0x1c0 fs/btrfs/file.c:3676
       __kernel_read+0x3f4/0xb50 fs/read_write.c:523
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
       process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
       ima_file_check+0xc6/0x110 security/integrity/ima/ima_main.c:572
       security_file_post_open+0x8e/0x210 security/security.c:3121
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1419/0x2d60 fs/namei.c:3987
       do_filp_open+0x20c/0x470 fs/namei.c:4014
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (btrfs_trans_num_writers){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       join_transaction+0x436/0x1010 fs/btrfs/transaction.c:288
       start_transaction+0x42c/0x1aa0 fs/btrfs/transaction.c:697
       btrfs_finish_one_ordered+0x3c9/0x2200 fs/btrfs/inode.c:3082
       btrfs_work_helper+0x225/0xc80 fs/btrfs/async-thread.c:314
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  btrfs_trans_num_writers --> &mm->mmap_lock --> sb_internal#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#4);
                               lock(&mm->mmap_lock);
                               lock(sb_internal#4);
  rlock(btrfs_trans_num_writers);

 *** DEADLOCK ***

4 locks held by kworker/u8:11/15834:
 #0: ffff88802768c148 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002f97d80 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888067216588 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0x8a0/0x2200 fs/btrfs/inode.c:3047
 #3: ffff88801271a610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_finish_one_ordered+0x3c9/0x2200 fs/btrfs/inode.c:3082

stack backtrace:
CPU: 0 UID: 0 PID: 15834 Comm: kworker/u8:11 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-endio-write btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 join_transaction+0x436/0x1010 fs/btrfs/transaction.c:288
 start_transaction+0x42c/0x1aa0 fs/btrfs/transaction.c:697
 btrfs_finish_one_ordered+0x3c9/0x2200 fs/btrfs/inode.c:3082
 btrfs_work_helper+0x225/0xc80 fs/btrfs/async-thread.c:314
 process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

