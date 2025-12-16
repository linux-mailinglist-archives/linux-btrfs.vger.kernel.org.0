Return-Path: <linux-btrfs+bounces-19780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6ACC19C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5898303DD1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77022335564;
	Tue, 16 Dec 2025 08:38:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5803148B6
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874326; cv=none; b=pgvYejczO+aGyRSfzXO0hIGn7JawyrgiFy22hoU9G68orHgTz72Nxbr/ujxCnZ/xdNbTtJh9mnSc0r8oMAcLCSGlO5i+tp8YthzpUnWyTD12scRW0rSGGouQsVBexS6J8+QO2Qlfhsz1fLp79X0/UZAlt+7zSLD3uxqgDA6pY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874326; c=relaxed/simple;
	bh=C8NnBwvj222slVN1XAkyH9M5bswpHrSMpd7D4aCuwqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A+D27TY4w5S9bw2Wkvp2EXVGQhcasQUWhBNVr4Jxn3RY48W+eWVTjidtaZOH6Ajbty+i1zU+5PAZdcpkjE555S2zqKjq6dBODpzMZrAlsAXbCZtJ9xHCTJNkyyQovUJV3SJmeBUtouxrujtfrmz6oAU2QqjOqWLmrHD13Kp7vOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c7046514a2so4323547a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 00:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874316; x=1766479116;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7O1m8i3UHIaylNnK352xVJRrlNk3NA55OY2mHQBq8U=;
        b=T1fuAwKgyKYR75CJYdkNpcwLQUnO6m9vn/u2Dd4nzNBPNBDchqb+wxWkzb3rH5lJP4
         YKAfuTIxHWGAqs3h38z4oKr6mRXR6ZLoJlVELsyCYBobywDzjVjwa2Pq/qOZI3NE4jIS
         MiSBQOMytouY9/4/0xAAHfYJzFIKAjzJ+e6cJTBloLvTVz7xNm2qGc2HrJCCmHbWkwyE
         S5B+aqVXXXMx3CMFWlbs1uFJ3fVghaxjYg896yUF4FWOvzjNwiSS1YLxhduZy8TYkhLk
         GjscCJcI8OZ+8/7fL+VO3mQ0d4IBX6KclHDwOXuPLg3mX56NIC0qQrGk+h/2ocJbGNdW
         rrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVjGX60oVTNlmXybd5Px5oeF54CtDToVueeRHOYMSSH8A3F0RsoRIw7LHCYO2CnrAfhUEh/OAyPZBW+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRyBBdsFTtuuH9gG8MAFMSDShojcLQB9wKD9FsAjbrvuyTefa
	VEdE7TjltQ1riJFpUovGk4rXurqiUgBPm4Hr4OS0YUvjQ9iaevkwReNN6SDezKTieUlCJVVdnoy
	xROGLDQ1xClkco60k3Yc8U99Q7PXslwJ+GzNdTlvR6o9d8G9f5YobgSNTs1g=
X-Google-Smtp-Source: AGHT+IGHMPq5S12nE0pQpIMT7ThJK239rRVMuxyDEw2I595pEIllunDoopeU2vDoLZsmDKvOgwKMhtyOUiPcwlTUqH8Tp1H30oj9
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c1:b0:659:9a49:8ddb with SMTP id
 006d021491bc7-65b45171733mr4868303eaf.29.1765874316295; Tue, 16 Dec 2025
 00:38:36 -0800 (PST)
Date: Tue, 16 Dec 2025 00:38:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69411a8c.a70a0220.33cd7b.0136.GAE@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_commit_inode_delayed_inode
 (2)
From: syzbot <syzbot+854bcfe4b16484489a66@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1711661a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=854bcfe4b16484489a66
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fa1d04c1a85/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9b253146e36/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+854bcfe4b16484489a66@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff888042458610 (sb_internal#2){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x117/0x2b0 fs/btrfs/delayed-inode.c:1279

but task is already holding lock:
ffffffff8e251780 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6973 [inline]
ffffffff8e251780 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x92a/0x2820 mm/vmscan.c:7352

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4301 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4315
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4904 [inline]
       slab_alloc_node mm/slub.c:5239 [inline]
       __kmalloc_cache_noprof+0x40/0x700 mm/slub.c:5771
       kmalloc_noprof include/linux/slab.h:957 [inline]
       kzalloc_noprof include/linux/slab.h:1094 [inline]
       btrfs_sysfs_add_qgroups+0xcd/0x2b0 fs/btrfs/sysfs.c:2693
       btrfs_quota_enable+0x25b/0x2900 fs/btrfs/qgroup.c:1002
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3613
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&fs_info->qgroup_ioctl_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       btrfs_quota_enable+0x29d/0x2900 fs/btrfs/qgroup.c:1031
       btrfs_ioctl_quota_ctl+0x183/0x1c0 fs/btrfs/ioctl.c:3613
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x1a4/0xd60 fs/btrfs/transaction.c:323
       start_transaction+0x6b7/0x15f0 fs/btrfs/transaction.c:707
       btrfs_rebuild_free_space_tree+0xad/0x6c0 fs/btrfs/free-space-tree.c:1330
       btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3052
       open_ctree+0x2b11/0x3d20 fs/btrfs/disk-io.c:3603
       btrfs_fill_super fs/btrfs/super.c:983 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1946 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2089 [inline]
       btrfs_get_tree+0x1061/0x1920 fs/btrfs/super.c:2123
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

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       join_transaction+0x182/0xd60 fs/btrfs/transaction.c:322
       start_transaction+0x6b7/0x15f0 fs/btrfs/transaction.c:707
       btrfs_rebuild_free_space_tree+0xad/0x6c0 fs/btrfs/free-space-tree.c:1330
       btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3052
       open_ctree+0x2b11/0x3d20 fs/btrfs/disk-io.c:3603
       btrfs_fill_super fs/btrfs/super.c:983 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1946 [inline]
       btrfs_get_tree_subvol fs/btrfs/super.c:2089 [inline]
       btrfs_get_tree+0x1061/0x1920 fs/btrfs/super.c:2123
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

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_intwrite include/linux/fs/super.h:177 [inline]
       start_transaction+0x56f/0x15f0 fs/btrfs/transaction.c:701
       btrfs_commit_inode_delayed_inode+0x117/0x2b0 fs/btrfs/delayed-inode.c:1279
       btrfs_evict_inode+0x94c/0x1050 fs/btrfs/inode.c:5564
       evict+0x5f4/0xae0 fs/inode.c:837
       __dentry_kill+0x209/0x660 fs/dcache.c:670
       finish_dput+0xc9/0x480 fs/dcache.c:879
       ovl_stack_put+0x6a/0xa0 fs/overlayfs/util.c:133
       ovl_destroy_inode+0xaa/0x150 fs/overlayfs/super.c:218
       destroy_inode fs/inode.c:396 [inline]
       evict+0x8aa/0xae0 fs/inode.c:861
       __dentry_kill+0x209/0x660 fs/dcache.c:670
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1137
       shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1164
       prune_dcache_sb+0x10e/0x180 fs/dcache.c:1246
       super_cache_scan+0x369/0x4b0 fs/super.c:222
       do_shrink_slab+0x6df/0x10d0 mm/shrinker.c:437
       shrink_slab_memcg mm/shrinker.c:550 [inline]
       shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
       shrink_one+0x2d9/0x720 mm/vmscan.c:4919
       shrink_many mm/vmscan.c:4980 [inline]
       lru_gen_shrink_node mm/vmscan.c:5058 [inline]
       shrink_node+0x2f7d/0x35b0 mm/vmscan.c:6045
       kswapd_shrink_node mm/vmscan.c:6899 [inline]
       balance_pgdat mm/vmscan.c:7082 [inline]
       kswapd+0x145a/0x2820 mm/vmscan.c:7352
       kthread+0x711/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

other info that might help us debug this:

Chain exists of:
  sb_internal#2 --> &fs_info->qgroup_ioctl_lock --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&fs_info->qgroup_ioctl_lock);
                               lock(fs_reclaim);
  rlock(sb_internal#2);

 *** DEADLOCK ***

2 locks held by kswapd0/78:
 #0: ffffffff8e251780 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6973 [inline]
 #0: ffffffff8e251780 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x92a/0x2820 mm/vmscan.c:7352
 #1: ffff88801236e0e0 (&type->s_umount_key#53){.+.+}-{4:4}, at: super_trylock_shared fs/super.c:563 [inline]
 #1: ffff88801236e0e0 (&type->s_umount_key#53){.+.+}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197

stack backtrace:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_intwrite include/linux/fs/super.h:177 [inline]
 start_transaction+0x56f/0x15f0 fs/btrfs/transaction.c:701
 btrfs_commit_inode_delayed_inode+0x117/0x2b0 fs/btrfs/delayed-inode.c:1279
 btrfs_evict_inode+0x94c/0x1050 fs/btrfs/inode.c:5564
 evict+0x5f4/0xae0 fs/inode.c:837
 __dentry_kill+0x209/0x660 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 ovl_stack_put+0x6a/0xa0 fs/overlayfs/util.c:133
 ovl_destroy_inode+0xaa/0x150 fs/overlayfs/super.c:218
 destroy_inode fs/inode.c:396 [inline]
 evict+0x8aa/0xae0 fs/inode.c:861
 __dentry_kill+0x209/0x660 fs/dcache.c:670
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1137
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1164
 prune_dcache_sb+0x10e/0x180 fs/dcache.c:1246
 super_cache_scan+0x369/0x4b0 fs/super.c:222
 do_shrink_slab+0x6df/0x10d0 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x2d9/0x720 mm/vmscan.c:4919
 shrink_many mm/vmscan.c:4980 [inline]
 lru_gen_shrink_node mm/vmscan.c:5058 [inline]
 shrink_node+0x2f7d/0x35b0 mm/vmscan.c:6045
 kswapd_shrink_node mm/vmscan.c:6899 [inline]
 balance_pgdat mm/vmscan.c:7082 [inline]
 kswapd+0x145a/0x2820 mm/vmscan.c:7352
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

