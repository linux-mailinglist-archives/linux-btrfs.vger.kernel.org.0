Return-Path: <linux-btrfs+bounces-10391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8C9F2868
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A071B1643D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AD3D994;
	Mon, 16 Dec 2024 02:12:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E2E822
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315147; cv=none; b=oTyWaZWpbJMvrVtjystnbNreJr0T9HhwaJeHnluKQYD9kgivh1Wy1rVtSpksb+FYpRW3EB0ctVbRV3Pm++mAZtwANQlVt5eF2uJj2Srcas1rU+ZxZE286QelrbR+27dolIOtrtOVFtecO1mm4xkEZVlnrU4go6qAc8jKdkdLqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315147; c=relaxed/simple;
	bh=8Jm3fUfhl2AgNDFGxM0xIhPi+gge+CdPYfdi7tAQN5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BzVdKGmKcH4FB8FY0jobOR6wBkssJ6yPqcwAFzg4r/8XfBzM67B3DhZRXY28cdKlco/MRuI7dA1HVWmBHTpjKE0v3sX+wXld3FHH7B/5+GHvwmrYGab2wsWpwYai+LanwMnRoHCh2xrpBfg4xfkWHHrmc8hYFaz0Cer0iHTiOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a81570ea43so34812575ab.0
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 18:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734315145; x=1734919945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEfIXOQf51WIEQeFwajUrw9PRodBpboi2svRXLs/09A=;
        b=o0BsKeVGnkBo9eQUJ+1IwEELRhIRu9D6xVs4qptsWy8Wia0PIXOV8WpMyvjBopqEet
         OE3MFp96No6+4mzj3m6WGLvXK7xSqiELpoHrrge1RPkZYNB71CYblEgbk3G19P+GuLKn
         PDgFiDHzQDhqblvBR3/tua00qIta9HtPNghwGOIPpIBYMykWTN2qq7rGVugwJqNZDvrI
         AROsbzUM9HBwMCdBmiQJzM3YuNRXnTyJtXqVDKdrHhN4X4ZwTfYWTot4ejxZu2yQJBaJ
         1yTccpDIL52zC9jV/FOPtzVaBgFUclqR/kyjT62qIsQrZvsBBomT4+Wx7XX1AoTlGT2I
         ykMg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8rE8FGnNdEjIc7Lq/0/hxC/CrppKFwaK38MNKUzQmXJs6pAfitGgWNfwJUUUEk6fqEWwXkUo1DGCGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjoVtpTSalPIdl7t6GjFYvj8yCR/6XAvT8bxbytdXceN2Sk9e
	BMdoP1t5MuEByf780sXMlEcsTECPbYaa/MwMZNveFHRRzQiSG/yQWeX8b+jw8P5TAtJSaTMo07M
	QFoLSHrqxW5yFm4PetGAnOCCQS+JNegcuiNtoxb6RK1K8lXXLTXuUfDk=
X-Google-Smtp-Source: AGHT+IGZzs3wHhORz26B9vxneqcPoeqSVXFryzvwSVQPDKEMVmIHebOZOfvDhWSK2N1qNHIIcH5F4aFrhlZilaAtL9Q4tW+sVWEd
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe9:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3aff4615e1fmr100819615ab.2.1734315144998; Sun, 15 Dec 2024
 18:12:24 -0800 (PST)
Date: Sun, 15 Dec 2024 18:12:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f8c88.050a0220.37aaf.010f.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_dirty_inode (2)
From: syzbot <syzbot+415a049af48761105c01@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15667b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=415a049af48761105c01
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12181fa13fbd/disk-231825b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b26768e0235e/vmlinux-231825b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bff68c455428/bzImage-231825b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+415a049af48761105c01@syzkaller.appspotmail.com

BTRFS info (device loop4): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
BTRFS info (device loop4): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device loop4): using free-space-tree
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0 Not tainted
------------------------------------------------------
syz.4.2424/13982 is trying to acquire lock:
ffff88802378e610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xc8/0x200 fs/btrfs/inode.c:6055

but task is already holding lock:
ffff888028ce8ba0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff888028ce8ba0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x160/0x360 mm/util.c:578

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0x65e/0x2750 drivers/scsi/sg.c:1156
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
       blk_mq_alloc_request+0x59b/0x950 block/blk-mq.c:652
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
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       btrfs_submit_dev_bio+0x54d/0xb20 fs/btrfs/bio.c:459
       btrfs_submit_bio+0x50b/0x6d0 fs/btrfs/bio.c:496
       btrfs_submit_chunk fs/btrfs/bio.c:757 [inline]
       btrfs_submit_bbio+0x5c5/0x19e0 fs/btrfs/bio.c:786
       submit_eb_page fs/btrfs/extent_io.c:1931 [inline]
       btree_write_cache_pages+0xb95/0x11c0 fs/btrfs/extent_io.c:1981
       btree_writepages+0x187/0x1e0 fs/btrfs/disk-io.c:520
       do_writepages+0x1b6/0x820 mm/page-writeback.c:2702
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       filemap_fdatawrite_wbc+0x104/0x160 mm/filemap.c:387
       __filemap_fdatawrite_range+0xb3/0xf0 mm/filemap.c:430
       btrfs_write_marked_extents+0x116/0x2e0 fs/btrfs/transaction.c:1149
       btrfs_write_and_wait_transaction+0xec/0x2a0 fs/btrfs/transaction.c:1257
       btrfs_commit_transaction+0x1fcf/0x3b30 fs/btrfs/transaction.c:2519
       btrfs_quota_enable+0xbba/0x1ef0 fs/btrfs/qgroup.c:1243
       btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3760 [inline]
       btrfs_ioctl+0x4c41/0x5b70 fs/btrfs/ioctl.c:5272
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&fs_info->tree_log_mutex){+.+.}-{4:4}:
       __lock_release kernel/locking/lockdep.c:5563 [inline]
       lock_release+0x369/0x6f0 kernel/locking/lockdep.c:5870
       __mutex_unlock_slowpath+0xa3/0x690 kernel/locking/mutex.c:896
       btrfs_commit_transaction+0x1f16/0x3b30 fs/btrfs/transaction.c:2509
       btrfs_rebuild_free_space_tree+0x2a3/0x480 fs/btrfs/free-space-tree.c:1360
       btrfs_start_pre_rw_mount+0x212/0xed0 fs/btrfs/disk-io.c:2998
       open_ctree+0x402e/0x5320 fs/btrfs/disk-io.c:3543
       btrfs_fill_super fs/btrfs/super.c:972 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1898 [inline]
       btrfs_get_tree+0x1039/0x1b80 fs/btrfs/super.c:2093
       vfs_get_tree+0x92/0x380 fs/super.c:1814
       fc_mount+0x16/0xc0 fs/namespace.c:1231
       btrfs_get_tree_subvol fs/btrfs/super.c:2051 [inline]
       btrfs_get_tree+0xa43/0x1b80 fs/btrfs/super.c:2094
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

-> #1 (btrfs_trans_unblocked){++++}-{0:0}:
       wait_current_trans+0x241/0x490 fs/btrfs/transaction.c:523
       start_transaction+0x41c/0x1aa0 fs/btrfs/transaction.c:694
       btrfs_ioctl_set_fslabel+0x254/0x3b0 fs/btrfs/ioctl.c:4283
       btrfs_ioctl+0xe01/0x5b70 fs/btrfs/ioctl.c:5176
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
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
       btrfs_file_mmap+0x118/0x150 fs/btrfs/file.c:1954
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x1789/0x2670 mm/vma.c:2456
       mmap_region+0x270/0x320 mm/mmap.c:1348
       do_mmap+0xc00/0xfc0 mm/mmap.c:496
       vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &q->debugfs_mutex --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&q->debugfs_mutex);
                               lock(&mm->mmap_lock);
  rlock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by syz.4.2424/13982:
 #0: ffff888028ce8ba0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888028ce8ba0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x160/0x360 mm/util.c:578
 #1: ffff88802378e420 (sb_writers#15){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2539 [inline]
 #1: ffff88802378e420 (sb_writers#15){.+.+}-{0:0}, at: btrfs_file_mmap+0x118/0x150 fs/btrfs/file.c:1954

stack backtrace:
CPU: 1 UID: 0 PID: 13982 Comm: syz.4.2424 Not tainted 6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
 btrfs_file_mmap+0x118/0x150 fs/btrfs/file.c:1954
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1789/0x2670 mm/vma.c:2456
 mmap_region+0x270/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc65157ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc652364058 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fc651745fa0 RCX: 00007fc65157ff19
RDX: 0000000000000002 RSI: 0000000000001000 RDI: 0000000020001000
RBP: 00007fc6515f3cc8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc651745fa0 R15: 00007ffd9f782dc8
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

