Return-Path: <linux-btrfs+bounces-9903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624849D8F66
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 01:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2264A28B2E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC279DC;
	Tue, 26 Nov 2024 00:02:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74F4C83
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579350; cv=none; b=Z4gb1s2NRQRL+p/FnFUfnTmb1oxikAUmVO7JKCUVDDyrljSbBgybkt0deJnM2KI/WXTDJ0MUmDJeCFTPKYfqMHOQCc7TBTIMyRIT44RYRHMJylF7H4nqpuqEVruv/wRIg5L9DByNr6G+rKXbI8q8PW3t1Ws+TqhKCJV7Vcx0LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579350; c=relaxed/simple;
	bh=L97FXXViOke/So7heRFF3Qu+EGXAJkZM60fqFA1C8lU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fuRSnrNnUbGED32keQfKPjy/r/ykwNcd+BHIre6G+leLa2uKrPHk7rAmZNeZFdJYxR1XqybXclMzLBbrW3QIWLphupKJipuMFmQrCX50Tyrz6iftgpu2yj5NLIGlisUDwZYW1UNYyEz6Xk2xRIIor1rRC6evnZjZUGhNGRGGXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79039ae30so52486135ab.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 16:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579347; x=1733184147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VGyvlQpCUhqKQA83jeMS9qHghOg588rybdYFLNIRas=;
        b=rpdatxiBsBFajzeJf/xlitUcCWd44R7gwoGaRJVNxG7T4uTRn2MiFSuYI9v9+CBQqh
         MZ0NJu0amDSuT643lDk9/ddp5UYuPQwNsFdLBYM9JPbDHW0IRNCkB6P4XZQkB5RSwae2
         QM5Kmk90al4KN0+q2cSlT5ZCog2PC8/wbNHEhxyRang5aJEfelIqJkdlsaHcQ1FMwIYz
         bGP1f93UI3+8Muohiod2TbtPjxigTSob2SI9jO4PblxWG+zIpF0Pn/Dq5EDMbSNZw6hT
         liUZzxsmh+J7won+tUeF9nHnqn0VFd86pd1oslHZ4hHZBM83MY9AV25dYlyfkODhNhpS
         M3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVlAyLc2Jkf+L9cPiFGGaZqhf3z7/m3TuEikavxx19EDX4AzMCuJyMO9istjCUCPKTxz7yihh4EdI+FGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vKGV6cprhFxD6+aUO3PlbfNqX/r6o+cOFZqlTqJwc26MYgFV
	gPk+Zhw0WKumMeH7DZOPahhD5hRKGGYX+DcKOMPKzHZSVUzC2DMaxBDcRGJTySDmJG9cxVEOjZE
	wiFxfehCgHD5b07ZPUHvajMdvEP3eTXMYkScVnHOer/1SBR51qBk0ORA=
X-Google-Smtp-Source: AGHT+IGfMT7oYRb607hrFwjRvBPwhHHtHM8jN7SZ7PnngTd/LEU9EczuBACSdWEaHQFcyxrXIQC0CrfZ+v7ogWVKcJO/EZsVi87r
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a7:86ab:bebe with SMTP id
 e9e14a558f8ab-3a79af75dc2mr150617505ab.16.1732579347547; Mon, 25 Nov 2024
 16:02:27 -0800 (PST)
Date: Mon, 25 Nov 2024 16:02:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67451013.050a0220.1286eb.000a.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_finish_one_ordered
From: syzbot <syzbot+a8356bab106afd565cbd@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43fb83c17ba2 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133e8ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1638cad79464dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=a8356bab106afd565cbd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b7a3a910252/disk-43fb83c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78e328593d54/vmlinux-43fb83c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3dd5bf3f229a/bzImage-43fb83c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8356bab106afd565cbd@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-03657-g43fb83c17ba2 #0 Not tainted
------------------------------------------------------
kworker/u8:4/72 is trying to acquire lock:
ffff88807ee86610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_finish_one_ordered+0x3a8/0x2200 fs/btrfs/inode.c:3069

but task is already holding lock:
ffff88806a552588 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0xa1c/0x2200 fs/btrfs/inode.c:3047

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (btrfs_ordered_extent){++++}-{0:0}:
       btrfs_start_ordered_extent+0x4e9/0x6f0 fs/btrfs/ordered-data.c:872
       btrfs_page_mkwrite+0x925/0x18b0 fs/btrfs/file.c:1870
       do_page_mkwrite+0x17a/0x380 mm/memory.c:3162
       wp_page_shared mm/memory.c:3563 [inline]
       do_wp_page+0xcbf/0x49d0 mm/memory.c:3713
       handle_pte_fault mm/memory.c:5782 [inline]
       __handle_mm_fault+0x1a93/0x2a10 mm/memory.c:5909
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
       do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #8 (sb_pagefaults#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_pagefault include/linux/fs.h:1890 [inline]
       btrfs_page_mkwrite+0x2b5/0x18b0 fs/btrfs/file.c:1813
       do_page_mkwrite+0x17a/0x380 mm/memory.c:3162
       do_shared_fault mm/memory.c:5373 [inline]
       do_fault mm/memory.c:5435 [inline]
       do_pte_missing+0x29e/0x3e70 mm/memory.c:3965
       handle_pte_fault mm/memory.c:5766 [inline]
       __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
       do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #7 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6716 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6709
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1121 [inline]
       sg_ioctl+0x65e/0x2750 drivers/scsi/sg.c:1163
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
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       loop_reconfigure_limits+0x2da/0x8d0 drivers/block/loop.c:1003
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

-> #3 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fc4/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x6fb/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e10 block/blk-core.c:868
       btrfs_submit_dev_bio+0x54d/0xb20 fs/btrfs/bio.c:456
       btrfs_submit_bio+0x50b/0x6d0 fs/btrfs/bio.c:493
       btrfs_submit_chunk fs/btrfs/bio.c:745 [inline]
       btrfs_submit_bbio+0x5c0/0x19c0 fs/btrfs/bio.c:773
       submit_eb_page fs/btrfs/extent_io.c:1931 [inline]
       btree_write_cache_pages+0xb95/0x11c0 fs/btrfs/extent_io.c:1981
       btree_writepages+0x187/0x1e0 fs/btrfs/disk-io.c:520
       do_writepages+0x1b6/0x820 mm/page-writeback.c:2683
       filemap_fdatawrite_wbc mm/filemap.c:398 [inline]
       filemap_fdatawrite_wbc+0x104/0x160 mm/filemap.c:388
       __filemap_fdatawrite_range+0xb3/0xf0 mm/filemap.c:431
       btrfs_write_marked_extents+0x116/0x2e0 fs/btrfs/transaction.c:1149
       btrfs_write_and_wait_transaction+0xec/0x2a0 fs/btrfs/transaction.c:1257
       btrfs_commit_transaction+0x1fcf/0x3b30 fs/btrfs/transaction.c:2519
       btrfs_sync_fs+0x134/0x7b0 fs/btrfs/super.c:1040
       sync_filesystem+0x1cf/0x290 fs/sync.c:66
       generic_shutdown_super+0x7e/0x3d0 fs/super.c:621
       kill_anon_super+0x3a/0x60 fs/super.c:1237
       btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2112
       deactivate_locked_super+0xc1/0x1a0 fs/super.c:473
       deactivate_super+0xde/0x100 fs/super.c:506
       cleanup_mnt+0x222/0x450 fs/namespace.c:1373
       task_work_run+0x151/0x250 kernel/task_work.c:239
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&fs_info->tree_log_mutex){+.+.}-{4:4}:
       __lock_release kernel/locking/lockdep.c:5563 [inline]
       lock_release+0x369/0x6f0 kernel/locking/lockdep.c:5870
       __mutex_unlock_slowpath+0xa3/0x690 kernel/locking/mutex.c:896
       btrfs_commit_transaction+0x1f16/0x3b30 fs/btrfs/transaction.c:2509
       insert_balance_item.isra.0+0x343/0x390 fs/btrfs/volumes.c:3757
       btrfs_balance+0x1085/0x3ef0 fs/btrfs/volumes.c:4633
       btrfs_ioctl_balance fs/btrfs/ioctl.c:3670 [inline]
       btrfs_ioctl+0x39c8/0x5b70 fs/btrfs/ioctl.c:5242
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (btrfs_trans_unblocked){++++}-{0:0}:
       wait_current_trans+0x241/0x490 fs/btrfs/transaction.c:523
       start_transaction+0x41c/0x1aa0 fs/btrfs/transaction.c:694
       btrfs_create_common+0x18b/0x270 fs/btrfs/inode.c:6562
       btrfs_create+0x114/0x160 fs/btrfs/inode.c:6608
       lookup_open.isra.0+0x1177/0x14c0 fs/namei.c:3649
       open_last_lookups fs/namei.c:3748 [inline]
       path_openat+0x904/0x2d60 fs/namei.c:3984
       do_filp_open+0x20c/0x470 fs/namei.c:4014
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1398
       do_sys_open fs/open.c:1413 [inline]
       __do_sys_open fs/open.c:1421 [inline]
       __se_sys_open fs/open.c:1417 [inline]
       __x64_sys_open+0x154/0x1e0 fs/open.c:1417
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
       btrfs_finish_one_ordered+0x3a8/0x2200 fs/btrfs/inode.c:3069
       btrfs_work_helper+0x228/0xc90 fs/btrfs/async-thread.c:314
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> sb_pagefaults#2 --> btrfs_ordered_extent

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs_ordered_extent);
                               lock(sb_pagefaults#2);
                               lock(btrfs_ordered_extent);
  rlock(sb_internal#2);

 *** DEADLOCK ***

3 locks held by kworker/u8:4/72:
 #0: ffff88806bec4148 ((wq_completion)btrfs-endio-write){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900020afd80 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88806a552588 (btrfs_ordered_extent){++++}-{0:0}, at: btrfs_finish_one_ordered+0xa1c/0x2200 fs/btrfs/inode.c:3047

stack backtrace:
CPU: 0 UID: 0 PID: 72 Comm: kworker/u8:4 Not tainted 6.12.0-syzkaller-03657-g43fb83c17ba2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1725 [inline]
 sb_start_intwrite include/linux/fs.h:1908 [inline]
 start_transaction+0xbd3/0x1aa0 fs/btrfs/transaction.c:691
 btrfs_finish_one_ordered+0x3a8/0x2200 fs/btrfs/inode.c:3069
 btrfs_work_helper+0x228/0xc90 fs/btrfs/async-thread.c:314
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

