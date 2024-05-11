Return-Path: <linux-btrfs+bounces-4915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504178C34B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 01:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BD0B21262
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95023FBA5;
	Sat, 11 May 2024 23:23:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39883A8D8
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715469803; cv=none; b=lqu1FaDxTGy47unuYlZhOZhbxmXLFRCCPYUX2xr7O+7jsxae+Yumsr7x6IE6JSkEIyOylz2gUQGgZ57oeffWKUsAd/NkTQE7CfaqnmHSvV9E1o3ARiRNK1A+yCEf48PtmB18CN1vWlRQqhVVwzVIq4uFjXYGFXFYSpNuVJpbPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715469803; c=relaxed/simple;
	bh=JS4215kjPDtbXdef9CUIj2zBI1xjynIrix/FmD7r108=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ngZGamOEDHcSeETWFm90m/TJ+dSP37TVRxziobs3pTpFVyuo14tY5W58fUbLmM8HruJ2FOykv1C7AHs348avBkvlG0S4+arsqjwenkMKb6ni8TSiWphRu4T3yXAbYtSMR2+etkDLTjdSfTyzvzKiZbFbuvv0NREKzIdLScPXEm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7dabc125bddso397777339f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 16:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715469801; x=1716074601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKxJGMkkf+i67k5jkkv60rT+fw9+CJNE7yf+LfTHndc=;
        b=QByPbUhzdlFHmGYgaDgUna85NX8KDooIWOja1YTzJvzNZxSPZ9eFxTzCfvnF/g8roG
         UYnKZO8Pl4vrbBuCua9KcTWAXSEuupFyr3nCk8FNUNZKe/tpY1mTLS5rVdD5wWBSb8ds
         5Ew6Ga/fTHNEXcBOAvKvz0uFo+Qr0ZgrDYhgiyeIn5PQOa2s2vPwJGLhf7jS76E5FaRi
         7QVN8OlKfHEZQLb0nc08H3z+/IiyU39Vrk9DedqemLHNjkG8zkzyqy69alrRdYw6Syr3
         UMwMkfIsPu8D1mLwNPDxoxBAIGuTc7Fc8apHHt07FmmCZpU4sOMZYLYmZ9z9uaSStopM
         s08A==
X-Forwarded-Encrypted: i=1; AJvYcCUuB5yAkYGysfuXOJAOBdNKxK8QmB3mW7LKR9ZXsJNGiMODKqc0WQt7Ddl/MXJ/Coz0ArR4cw4FMJi/s6PZAJnFIVP6kAjDAoJ37QQ=
X-Gm-Message-State: AOJu0Yywo11Z9RrK5951m+YR633PnxsE/7LKNQgNVutBGRTl4RexYrnQ
	RVmFe38ZmYZI8A+KwjHJBKGYppR9X0DHnJ93N0tsWtA4p+vSKpIzRFz4mbhnNGi64LFqHrW+DAl
	UoaEaIrrSDcJ7O9lVUv1t49sAW0VWMNbF+Poia3lBP14qK1zBZK79Mlk=
X-Google-Smtp-Source: AGHT+IGU9Gp0n8f2tnSejVCkRW2AWmZgvH8JCnxXB3d4CRAhibkFEiKwVTmA27YdkemEq7FzfTEGVuRt5xNT5uZLsKsx/Mgxm9Vx
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:861e:b0:488:59cc:eb4e with SMTP id
 8926c6da1cb9f-4895854473cmr427374173.1.1715469800878; Sat, 11 May 2024
 16:23:20 -0700 (PDT)
Date: Sat, 11 May 2024 16:23:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ac5ea061835f021@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in join_transaction
From: syzbot <syzbot+f7a41568dd5872d6ad52@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad432f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a450595960709c8
dashboard link: https://syzkaller.appspot.com/bug?extid=f7a41568dd5872d6ad52
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/987455e5cf13/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/327c390f753b/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7a41568dd5872d6ad52@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
------------------------------------------------------
kswapd0/110 is trying to acquire lock:
ffff888000c76380 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x430/0xf40 fs/btrfs/transaction.c:290

but task is already holding lock:
ffff88805a236610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_intwrite include/linux/fs.h:1847 [inline]
       start_transaction+0xbc1/0x1a70 fs/btrfs/transaction.c:694
       btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
       btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5307
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3752 [inline]
       slab_alloc_node mm/slub.c:3833 [inline]
       kmalloc_trace+0x51/0x340 mm/slub.c:3998
       kmalloc include/linux/slab.h:628 [inline]
       ulist_alloc+0x77/0x1c0 fs/btrfs/ulist.c:98
       btrfs_quota_enable+0x342/0x1ef0 fs/btrfs/qgroup.c:1031
       btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3765 [inline]
       btrfs_ioctl+0x6af4/0x8290 fs/btrfs/ioctl.c:4762
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1004
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       btrfs_quota_enable+0x3a1/0x1ef0 fs/btrfs/qgroup.c:1066
       btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:3765 [inline]
       btrfs_ioctl+0x6af4/0x8290 fs/btrfs/ioctl.c:4762
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1004
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_create_common+0x18b/0x270 fs/btrfs/inode.c:6583
       btrfs_create+0x114/0x160 fs/btrfs/inode.c:6629
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3497
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x92f/0x2990 fs/namei.c:3796
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_compat_sys_openat fs/open.c:1481 [inline]
       __se_compat_sys_openat fs/open.c:1479 [inline]
       __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1479
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (btrfs_trans_num_writers){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       join_transaction+0x436/0xf40 fs/btrfs/transaction.c:290
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
       btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5307
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  btrfs_trans_num_writers --> fs_reclaim --> sb_internal#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#2);
                               lock(fs_reclaim);
                               lock(
sb_internal#2);
  rlock(btrfs_trans_num_writers);

 *** DEADLOCK ***

3 locks held by kswapd0/110:
 #0: 
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88805a2360e0 (&type->s_umount_key#82){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88805a2360e0 (&type->s_umount_key#82){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196
 #2: ffff88805a236610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275

stack backtrace:
CPU: 3 PID: 110 Comm: kswapd0 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
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
 join_transaction+0x436/0xf40 fs/btrfs/transaction.c:290
 start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
 btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
 btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5307
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

