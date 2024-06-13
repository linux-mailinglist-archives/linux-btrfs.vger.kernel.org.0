Return-Path: <linux-btrfs+bounces-5697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC0906172
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 03:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA49228373D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 01:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78441A28B;
	Thu, 13 Jun 2024 01:59:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB117597
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243967; cv=none; b=ezRB4PZUtA4YVdchnVHDd/fHqg2we8H9aDZ2sxyel1MAbrG7/k9PVtbofb3AhEC+4aeTBvEnE/6V3JcgtQ6oylMEhvuumVw0WSqRfpkOx7FJ8bvBx1GSb27Y10pnT97dGYPh+p9dBKhsNER1N4fBeOCRYAHCoSZpd4Z5lu9eK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243967; c=relaxed/simple;
	bh=DhwdmDTYYdS/KgBMvVC3FESO/ezNcJYLdBLHBP5oquY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=umk1ClHh4jyDmECIWegLGYIqUhR7LSjSQAvLykVyrZmPWxPe1pOSIpZUpsTHyBqobklnbtC5XEmCD8h6SeH55u0fvK9cbimFde0AcmW25/fpiSJ5OCPhfw8gvLxbNE9jqw08KNJpZBCwYPegkClLMpTdahk/CJQ1vA7SGiZP+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3737b3ae019so4871155ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 18:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243965; x=1718848765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LPamGuf5auMpJc0VNkSXfd3XFXO0t7m5Gs9owLkQwM=;
        b=SyQChAKackzwohDUIyaacY6t+FRTvX60nmMuAOQmFZbIpI+83dMIUu1Atkce0I4+/C
         T0pUx3LHXEM9tlrgO8IsQ3BStyOSEEWHGk0f2sAvUqa6IyLGAzK2JAewzgX5cidoxljD
         5cf+0JJxhfgazAnrB8V3O+fBV0kIljnWkx7DeTSS6G59AHdE6eBGXEGsJbe9vhJqqPwJ
         Li7Lc4SHQNe7UwyjVHL+18E2hbVJUYnH3ZkW01YqmG/PSzfhAV3+iM1AACnxU3eFO420
         4ypMo+cTuv8ojngbWiMtzgtG3RZy0Y6UYmbMc80MR59tvdNgVH0EesPtEONpd3t/dYU5
         yMqg==
X-Forwarded-Encrypted: i=1; AJvYcCX4O6ssEbRE1yYtjpyJ09afQoyW38f7h/d0CFwoQVdXe04tkUvyDK2mEzQz9Bfy7ah0MWNZ9AFX25bK4E/uAbksumdHKUqFmp4YKg4=
X-Gm-Message-State: AOJu0YyW29LS2+SzmbQRMB+Tn5JeJRZvQfeLSgDmh3Q78pbYX2QPPM/u
	3BbYMhcUOprTKgOtziBG+sHeJR6Od0Um+e4is9miVKZLLT8nJdDehnYxurPwKs8BMd1AarNtjje
	vrxMRTLkHQYMUxfBUPG/wNL6YB98oTpK+oc3AD6Z3Rs25fIYLkufgbMg=
X-Google-Smtp-Source: AGHT+IELFhcMnbtKp/UxLs6gt5XUnBCHticu1wv7+7jR2HuEj4cHcI5w/+8OVw8l0/y/34WkAOeO9Io26xzQjJ+hVI7vdLoPPlj8
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:375:9deb:ceb8 with SMTP id
 e9e14a558f8ab-375cd13c005mr1906045ab.3.1718243964697; Wed, 12 Jun 2024
 18:59:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 18:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000274a3a061abbd928@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_log_inode
From: syzbot <syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    061d1af7b030 Merge tag 'for-linus-2024060801' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170743fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96fd46a1ee1615e0
dashboard link: https://syzkaller.appspot.com/bug?extid=8576cfa84070dce4d59b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-061d1af7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91e6b5bb0acf/vmlinux-061d1af7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3cc757eadf33/bzImage-061d1af7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-00361-g061d1af7b030 #0 Not tainted
------------------------------------------------------
syz-executor.1/9919 is trying to acquire lock:
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3891 [inline]
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3981 [inline]
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020

but task is already holding lock:
ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->log_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481
       btrfs_log_inode_parent+0x8cb/0x2a90 fs/btrfs/tree-log.c:7079
       btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
       btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
       vfs_fsync_range+0x141/0x230 fs/sync.c:188
       generic_write_sync include/linux/fs.h:2794 [inline]
       btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6b6/0x1140 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_commit_super+0xa1/0x110 fs/btrfs/disk-io.c:4170
       close_ctree+0xcb0/0xf90 fs/btrfs/disk-io.c:4324
       generic_shutdown_super+0x159/0x3d0 fs/super.c:642
       kill_anon_super+0x3a/0x60 fs/super.c:1226
       btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
       deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
       deactivate_super+0xde/0x100 fs/super.c:506
       cleanup_mnt+0x222/0x450 fs/namespace.c:1267
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
       percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
       __sb_end_write include/linux/fs.h:1650 [inline]
       sb_end_intwrite include/linux/fs.h:1767 [inline]
       __btrfs_end_transaction+0x5ca/0x920 fs/btrfs/transaction.c:1071
       btrfs_commit_inode_delayed_inode+0x228/0x330 fs/btrfs/delayed-inode.c:1301
       btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
       dput+0x1f/0x30 fs/dcache.c:835
       ovl_stack_put+0x60/0x90 fs/overlayfs/util.c:132
       ovl_destroy_inode+0xc6/0x190 fs/overlayfs/super.c:182
       destroy_inode+0xc4/0x1b0 fs/inode.c:311
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3891 [inline]
       slab_alloc_node mm/slub.c:3981 [inline]
       kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
       btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
       alloc_inode+0x5d/0x230 fs/inode.c:261
       iget5_locked fs/inode.c:1235 [inline]
       iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
       btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
       btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
       btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
       add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
       copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:5928
       btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
       log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
       btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
       btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
       btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
       btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
       btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
       vfs_fsync_range+0x141/0x230 fs/sync.c:188
       generic_write_sync include/linux/fs.h:2794 [inline]
       btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
       do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
       vfs_writev+0x36f/0xde0 fs/read_write.c:971
       do_pwritev+0x1b2/0x260 fs/read_write.c:1072
       __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
       __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
       __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> btrfs_trans_num_extwriters --> &ei->log_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->log_mutex);
                               lock(btrfs_trans_num_extwriters);
                               lock(&ei->log_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

7 locks held by syz-executor.1/9919:
 #0: ffff88802be20420 (sb_writers#23){.+.+}-{0:0}, at: do_pwritev+0x1b2/0x260 fs/read_write.c:1072
 #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888065c0f8f0 (&sb->s_type->i_mutex_key#33){++++}-{3:3}, at: btrfs_inode_lock+0xc8/0x110 fs/btrfs/inode.c:385
 #2: ffff888065c0f778 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_inode_lock+0xee/0x110 fs/btrfs/inode.c:388
 #3: ffff88802be20610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_sync_file+0x95b/0xe10 fs/btrfs/file.c:1952
 #4: ffff8880546323f0 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
 #5: ffff888054632418 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290
 #6: ffff88804b569358 (&ei->log_mutex){+.+.}-{3:3}, at: btrfs_log_inode+0x39c/0x4660 fs/btrfs/tree-log.c:6481

stack backtrace:
CPU: 2 PID: 9919 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00361-g061d1af7b030 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
 might_alloc include/linux/sched/mm.h:334 [inline]
 slab_pre_alloc_hook mm/slub.c:3891 [inline]
 slab_alloc_node mm/slub.c:3981 [inline]
 kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4020
 btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
 btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
 btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
 add_conflicting_inode fs/btrfs/tree-log.c:5657 [inline]
 copy_inode_items_to_log+0x1039/0x1e30 fs/btrfs/tree-log.c:5928
 btrfs_log_inode+0xa48/0x4660 fs/btrfs/tree-log.c:6592
 log_new_delayed_dentries fs/btrfs/tree-log.c:6363 [inline]
 btrfs_log_inode+0x27dd/0x4660 fs/btrfs/tree-log.c:6718
 btrfs_log_all_parents fs/btrfs/tree-log.c:6833 [inline]
 btrfs_log_inode_parent+0x22ba/0x2a90 fs/btrfs/tree-log.c:7141
 btrfs_log_dentry_safe+0x59/0x80 fs/btrfs/tree-log.c:7180
 btrfs_sync_file+0x9c1/0xe10 fs/btrfs/file.c:1959
 vfs_fsync_range+0x141/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2794 [inline]
 btrfs_do_write_iter+0x584/0x10c0 fs/btrfs/file.c:1705
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xde0 fs/read_write.c:971
 do_pwritev+0x1b2/0x260 fs/read_write.c:1072
 __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
 __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
 __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7334579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f265ac EFLAGS: 00000292 ORIG_RAX: 000000000000017b
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200002c0
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

