Return-Path: <linux-btrfs+bounces-20065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF6CED13E
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 15:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E773007950
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E028751D;
	Thu,  1 Jan 2026 14:50:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F738285CAD
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767279025; cv=none; b=HwZxN2dGHGDEfIkF9Z376z2d50K0jQ4Cp9qFyaQuck2LssqJydwAi7UL3Og4oZj00Rd4GKz1MOGUwTTibYloMkqIreV9Cq0jmlEv1op/UzmDVjupHcX3IqIgZVdvLI47nl8QMIclvO4th//4Wp/T7O1lAH/VVF2RbhtCfQc5YgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767279025; c=relaxed/simple;
	bh=DcORDPTxT58bQ9QQclKVQSmQCs5K2Xc5M2WMymXlQ2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HuFg47xgVQRKjDJUeEyhIGlNSiVWjy0n8iLJDQoxErssc7kiV95Woz66J+hrYajYt6/ugnGlCf6Yceh5PNU4DPone6vPe7CaDIEUpCNzwqTdMO/X0S3uyCEUTRJ7QFbJmOd7AenhkYUDm3RKsVCEo3YBaPOUcr0ktmbdKmkBxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6574475208eso9345796eaf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 06:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767279021; x=1767883821;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/es2Y6s9ewJJSpbolzpDP61kiu+BPCzQGt/A/heru0=;
        b=hSesXnm8PpDD5ug6XYEi1U4/M1PsgaQDRs/5b4FRk59yMCBW4ACYrjgtQWntX4JKi+
         6sjm6f3EUp4dxXVINxS5tjFwr9puWZPI+FQbUf7i2cKEYZANBF01U/LotMQo5tYkJfCi
         o4goD6sKOiu3VZvkaF0Mb+uSSgha+N4KWbgYojskSIpGG/wKEdmK6ttvh4izT4OASZMp
         xhthUKScrHxf5aQ/dgKB/rAVLAIIhv01LAvh9Mhhdw8T66cyH5ARYGfy0Qyx8yg3UodM
         MPWmlNsx1d/6vzEioTYsBJPi6XxikjlSC1QZj9QaA4/SFK2HoKFdXhxscRMk4+QvijJV
         6IXg==
X-Forwarded-Encrypted: i=1; AJvYcCWa32bqBdbhvb5K/SBoaQprgjEeOI5u2oWdv70GnDuWp2T8D9fhAiMHuilIMYCKqiJ7GKqGLZjHezx6Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRXOkdawvhhZJR6uyKQ8QaMTCUyWW44ZrII5KTCJgU5VmRquy
	+Ka6OnggPG5xPdWPT+mfM6gvaBTZN1JFPwMW4V6g4TBQiZyZ8cCclByvkBFjmpSdHis6dyvU1yy
	kyfgyU+Q8jLB1yoJR6135OvQS/Jb/bfYew0SmMpcB6xpaBFpn1VYjW5/UhRU=
X-Google-Smtp-Source: AGHT+IETNbu3eOKjPmscrnEgUrr/7LrgUZrMKs6SXWb+mggRrPzLkHu7OvPqj9+eAYHEYYZkgpydLHSOr1k9Y09wjPERD6HP9f3p
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c00c:b0:659:9a49:90ac with SMTP id
 006d021491bc7-65d0ea68fc7mr8674122eaf.43.1767279021218; Thu, 01 Jan 2026
 06:50:21 -0800 (PST)
Date: Thu, 01 Jan 2026 06:50:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695689ad.050a0220.a1b6.0340.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_create_qgroup
From: syzbot <syzbot+1a44c3c7940ab3688125@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d58bda580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1bc82c6189c463
dashboard link: https://syzkaller.appspot.com/bug?extid=1a44c3c7940ab3688125
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30bf539e6f28/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2f8b08e342/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7ee6ece11f/bzImage-cc3aa43b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a44c3c7940ab3688125@syzkaller.appspotmail.com

BTRFS info (device loop0): max_inline set to 4096
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.0.2512/16697 is trying to acquire lock:
ffff88802f119990 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}, at: btrfs_create_qgroup+0x55/0x520 fs/btrfs/qgroup.c:1683

but task is already holding lock:
ffff88802f118d30 (&fs_info->reloc_mutex){+.+.}-{4:4}, at: btrfs_commit_transaction+0xf6b/0x3bd0 fs/btrfs/transaction.c:2424

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&fs_info->reloc_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       btrfs_record_root_in_trans+0x14f/0x180 fs/btrfs/transaction.c:505
       start_transaction+0x3a7/0x15f0 fs/btrfs/transaction.c:782
       btrfs_dirty_inode+0x9f/0x190 fs/btrfs/inode.c:6406
       inode_update_time fs/inode.c:2167 [inline]
       file_update_time_flags+0x387/0x4e0 fs/inode.c:2395
       __generic_remap_file_range_prep+0xb11/0xbe0 fs/remap_range.c:362
       generic_remap_file_range_prep+0x3e/0x60 fs/remap_range.c:371
       btrfs_remap_file_range_prep fs/btrfs/reflink.c:850 [inline]
       btrfs_remap_file_range+0x645/0x1320 fs/btrfs/reflink.c:886
       vfs_clone_file_range+0x42c/0x7a0 fs/remap_range.c:403
       ioctl_file_clone fs/ioctl.c:239 [inline]
       ioctl_file_clone_range fs/ioctl.c:257 [inline]
       do_vfs_ioctl+0xd2b/0x1430 fs/ioctl.c:544
       __do_sys_ioctl fs/ioctl.c:595 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x1a4/0xd60 fs/btrfs/transaction.c:323
       start_transaction+0x6ba/0x15f0 fs/btrfs/transaction.c:708
       btrfs_rebuild_free_space_tree+0xad/0x6d0 fs/btrfs/free-space-tree.c:1330
       btrfs_start_pre_rw_mount+0x1299/0x1c30 fs/btrfs/disk-io.c:3018
       open_ctree+0x2b28/0x3d90 fs/btrfs/disk-io.c:3566
       btrfs_fill_super fs/btrfs/super.c:981 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1944 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
       btrfs_get_tree+0x1061/0x1930 fs/btrfs/super.c:2121
       vfs_get_tree+0x92/0x2a0 fs/super.c:1751
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3636 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3712
       do_mount fs/namespace.c:4035 [inline]
       __do_sys_mount fs/namespace.c:4224 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4201
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (btrfs_trans_num_writers){++++}-{0:0}:
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1ab/0x3b0 kernel/locking/lockdep.c:5889
       percpu_up_read include/linux/percpu-rwsem.h:112 [inline]
       __sb_end_write include/linux/fs/super.h:14 [inline]
       sb_end_intwrite+0x26/0x1c0 include/linux/fs/super.h:101
       __btrfs_end_transaction+0x248/0x640 fs/btrfs/transaction.c:1084
       btrfs_dirty_inode+0x14c/0x190 fs/btrfs/inode.c:6420
       inode_update_time fs/inode.c:2167 [inline]
       touch_atime+0x2f9/0x6d0 fs/inode.c:2240
       file_accessed include/linux/fs.h:2255 [inline]
       btrfs_file_mmap_prepare+0x176/0x1f0 fs/btrfs/file.c:2050
       vfs_mmap_prepare include/linux/fs.h:2059 [inline]
       call_mmap_prepare mm/vma.c:2596 [inline]
       __mmap_region mm/vma.c:2692 [inline]
       mmap_region+0xb2b/0x1d10 mm/vma.c:2786
       do_mmap+0xc45/0x10d0 mm/mmap.c:558
       vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:581
       ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1560
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:400
       get_mmap_lock_carefully mm/mmap_lock.c:399 [inline]
       lock_mm_and_find_vma+0x2a8/0x300 mm/mmap_lock.c:450
       do_user_addr_fault+0x331/0x1380 arch/x86/mm/fault.c:1359
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
       filldir+0x2b6/0x6c0 fs/readdir.c:295
       dir_emit include/linux/fs.h:3526 [inline]
       kernfs_fop_readdir+0x537/0x870 fs/kernfs/dir.c:1913
       iterate_dir+0x399/0x570 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:326 [inline]
       __se_sys_getdents+0xe4/0x250 fs/readdir.c:312
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       kernfs_add_one+0x41/0x5c0 fs/kernfs/dir.c:794
       kernfs_create_dir_ns+0xde/0x130 fs/kernfs/dir.c:1096
       sysfs_create_dir_ns+0x123/0x280 fs/sysfs/dir.c:59
       create_dir lib/kobject.c:73 [inline]
       kobject_add_internal+0x6ab/0xcc0 lib/kobject.c:240
       kobject_add_varg lib/kobject.c:374 [inline]
       kobject_init_and_add+0x125/0x190 lib/kobject.c:457
       btrfs_sysfs_add_qgroups+0x111/0x2b0 fs/btrfs/sysfs.c:2643
       btrfs_quota_enable+0x25d/0x2920 fs/btrfs/qgroup.c:1034
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3613
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       btrfs_create_qgroup+0x55/0x520 fs/btrfs/qgroup.c:1683
       create_pending_snapshot+0x86c/0x3270 fs/btrfs/transaction.c:1749
       create_pending_snapshots+0x17c/0x1c0 fs/btrfs/transaction.c:1941
       btrfs_commit_transaction+0xf78/0x3bd0 fs/btrfs/transaction.c:2431
       create_snapshot fs/btrfs/ioctl.c:779 [inline]
       btrfs_mksubvol+0xc75/0x12d0 fs/btrfs/ioctl.c:926
       btrfs_mksnapshot+0xab/0xf0 fs/btrfs/ioctl.c:968
       __btrfs_ioctl_snap_create+0x520/0x740 fs/btrfs/ioctl.c:1232
       btrfs_ioctl_snap_create_v2+0x1f8/0x3b0 fs/btrfs/ioctl.c:1312
       btrfs_ioctl+0xa62/0xd00 fs/btrfs/ioctl.c:-1
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &fs_info->qgroup_ioctl_lock --> btrfs_trans_num_extwriters --> &fs_info->reloc_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->reloc_mutex);
                               lock(btrfs_trans_num_extwriters);
                               lock(&fs_info->reloc_mutex);
  lock(&fs_info->qgroup_ioctl_lock);

 *** DEADLOCK ***

8 locks held by syz.0.2512/16697:
 #0: ffff888054516420 (sb_writers#18){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:543
 #1: ffff8880442e9ed0 (&type->i_mutex_dir_key#11/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2859 [inline]
 #1: ffff8880442e9ed0 (&type->i_mutex_dir_key#11/1){+.+.}-{4:4}, at: start_creating_killable+0xc1/0x120 fs/namei.c:3387
 #2: ffff88802f118c60 (&fs_info->subvol_sem){++++}-{4:4}, at: btrfs_mksubvol+0x4ce/0x12d0 fs/btrfs/ioctl.c:920
 #3: ffff888054516610 (sb_internal#4){.+.+}-{0:0}, at: create_snapshot fs/btrfs/ioctl.c:764 [inline]
 #3: ffff888054516610 (sb_internal#4){.+.+}-{0:0}, at: btrfs_mksubvol+0xaf2/0x12d0 fs/btrfs/ioctl.c:926
 #4: ffff88802f11a5f0 (btrfs_trans_completed){++++}-{0:0}, at: btrfs_commit_transaction+0x178/0x3bd0 fs/btrfs/transaction.c:2207
 #5: ffff88802f11a5c8 (btrfs_trans_super_committed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x178/0x3bd0 fs/btrfs/transaction.c:2207
 #6: ffff88802f11a5a0 (btrfs_trans_unblocked){.+.+}-{0:0}, at: btrfs_commit_transaction+0x178/0x3bd0 fs/btrfs/transaction.c:2207
 #7: ffff88802f118d30 (&fs_info->reloc_mutex){+.+.}-{4:4}, at: btrfs_commit_transaction+0xf6b/0x3bd0 fs/btrfs/transaction.c:2424

stack backtrace:
CPU: 1 UID: 0 PID: 16697 Comm: syz.0.2512 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
 btrfs_create_qgroup+0x55/0x520 fs/btrfs/qgroup.c:1683
 create_pending_snapshot+0x86c/0x3270 fs/btrfs/transaction.c:1749
 create_pending_snapshots+0x17c/0x1c0 fs/btrfs/transaction.c:1941
 btrfs_commit_transaction+0xf78/0x3bd0 fs/btrfs/transaction.c:2431
 create_snapshot fs/btrfs/ioctl.c:779 [inline]
 btrfs_mksubvol+0xc75/0x12d0 fs/btrfs/ioctl.c:926
 btrfs_mksnapshot+0xab/0xf0 fs/btrfs/ioctl.c:968
 __btrfs_ioctl_snap_create+0x520/0x740 fs/btrfs/ioctl.c:1232
 btrfs_ioctl_snap_create_v2+0x1f8/0x3b0 fs/btrfs/ioctl.c:1312
 btrfs_ioctl+0xa62/0xd00 fs/btrfs/ioctl.c:-1
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f732378f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73245df038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f73239e5fa0 RCX: 00007f732378f749
RDX: 0000200000002480 RSI: 0000000050009417 RDI: 0000000000000004
RBP: 00007f7323813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f73239e6038 R14: 00007f73239e5fa0 R15: 00007ffdae0e36b8
 </TASK>
BTRFS info (device loop0): last unmount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d


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

