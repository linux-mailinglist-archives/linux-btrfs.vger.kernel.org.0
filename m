Return-Path: <linux-btrfs+bounces-6201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF99279D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FC6288BB9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696871B012C;
	Thu,  4 Jul 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8m4eWux"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEF1AEFFD
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106325; cv=none; b=fEEm2RLEtN5vPM3OxwLwvXhboFr8pGEUzB/otAK/gSe60Hs5Wo3wLsQj6RkJDA/LUhASTOADat2LG50r8+OmevfGopp9+UbvXyOrxAJ7y3QTKJpqX8SsNJ7zsP1Rjy/eOd0UpHQvM/GhoIaC31sNhlvXjSzxOe8kqgFcPyH6Oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106325; c=relaxed/simple;
	bh=g+ivKv0ueIGJbCquicZrwiuSOp6jGYd63/RL6O5PpEA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=poYbIl2B1xeEXLeMFKEMx3ODJ0X3aR3ktpFWzrp8mFTR7bMO+2xxqKkfOpkNuzBnxiUPSK+ouEspxH9cq4PvSjnikZsTlJ2ccuylyVPuG5Hz3pujxempvOoVg8zNbYX8nSOq0RBvuRomazo4v2qQcaL9uvgf6ayTBiFAMWomsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8m4eWux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B12C3277B
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720106325;
	bh=g+ivKv0ueIGJbCquicZrwiuSOp6jGYd63/RL6O5PpEA=;
	h=From:To:Subject:Date:From;
	b=Y8m4eWuxVeZ8Um0OwK+Oy8HhLAY6ncJV/VpKIAi3HfAsXo9tnekUDwQTRjICn1GGr
	 dTr+vIQdOli7rsae8ZjCyWpkVbIpAuIAwnJ2+7Ce/WAovTcD5GcBzZDpk0Iy92EoDk
	 +E5r2dcw02lEC4vYcRYasQp0Xelbu+5AxdpQ8QjjAEBD8OnNsV0ZcvARHzvNW72XtY
	 J/6OpfOWFUHN3XT2Xazfu2R8ztXw9HCLEbfxTYQbwNZmeCqwvBAqwDMkOVE7jpt57Q
	 1VFRIUOH2kHS5UQ0g/OgXIOj4nhDznivva4OYqWeEJ3hKaBQ1uTeJ4rDFQIYipvgqh
	 8ihy/psJwqFsA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use delayed iput during extent map shrinking
Date: Thu,  4 Jul 2024 16:18:42 +0100
Message-Id: <a13181cccb5b199b9127016bfcc29a2476aba891.1720106304.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When putting an inode during extent map shrinking we're doing a standard
iput() but that may take a long time in case the inode is dirty and we are
doing the final iput that triggers eviction - the VFS will have to wait
for writeback before calling the btrfs evict callback (see
fs/inode.c:evict()).

This slows down the task running the shrinker which may have been
triggered while updating some tree for example, meaning locks are held
as well as an open transaction handle.

Also if the iput() ends up triggering eviction and the inode has no links
anymore, then we trigger item truncation which requires flushing delayed
items, space reservation to start a transaction and that may trigger the
space reclaim task and wait for it, resulting in deadlocks in case the
reclaim task needs for example to commit a transaction and the shrinker
is being triggered from a path holding a transaction handle.

Syzbot reported such a case with the following stack traces:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.10.0-rc2-syzkaller-00010-g2ab795141095 #0 Not tainted
   ------------------------------------------------------
   kswapd0/111 is trying to acquire lock:
   ffff88801eae4610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275

   but task is already holding lock:
   ffffffff8dd3a9a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xa88/0x1970 mm/vmscan.c:6924

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #3 (fs_reclaim){+.+.}-{0:0}:
          __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
          fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
          might_alloc include/linux/sched/mm.h:334 [inline]
          slab_pre_alloc_hook mm/slub.c:3890 [inline]
          slab_alloc_node mm/slub.c:3980 [inline]
          kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4019
          btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
          alloc_inode+0x5d/0x230 fs/inode.c:261
          iget5_locked fs/inode.c:1235 [inline]
          iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
          btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
          btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
          btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
          create_reloc_inode+0x403/0x820 fs/btrfs/relocation.c:3911
          btrfs_relocate_block_group+0x471/0xe60 fs/btrfs/relocation.c:4114
          btrfs_relocate_chunk+0x143/0x450 fs/btrfs/volumes.c:3373
          __btrfs_balance fs/btrfs/volumes.c:4157 [inline]
          btrfs_balance+0x211a/0x3f00 fs/btrfs/volumes.c:4534
          btrfs_ioctl_balance fs/btrfs/ioctl.c:3675 [inline]
          btrfs_ioctl+0x12ed/0x8290 fs/btrfs/ioctl.c:4742
          __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
          do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
          __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
          do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
          entry_SYSENTER_compat_after_hwframe+0x84/0x8e

   -> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
          join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
          start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
          btrfs_rebuild_free_space_tree+0xaa/0x480 fs/btrfs/free-space-tree.c:1323
          btrfs_start_pre_rw_mount+0x218/0xf60 fs/btrfs/disk-io.c:2999
          open_ctree+0x41ab/0x52e0 fs/btrfs/disk-io.c:3554
          btrfs_fill_super fs/btrfs/super.c:946 [inline]
          btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
          btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
          vfs_get_tree+0x8f/0x380 fs/super.c:1780
          fc_mount+0x16/0xc0 fs/namespace.c:1125
          btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
          btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
          vfs_get_tree+0x8f/0x380 fs/super.c:1780
          do_new_mount fs/namespace.c:3352 [inline]
          path_mount+0x6e1/0x1f10 fs/namespace.c:3679
          do_mount fs/namespace.c:3692 [inline]
          __do_sys_mount fs/namespace.c:3898 [inline]
          __se_sys_mount fs/namespace.c:3875 [inline]
          __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
          do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
          __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
          do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
          entry_SYSENTER_compat_after_hwframe+0x84/0x8e

   -> #1 (btrfs_trans_num_writers){++++}-{0:0}:
          join_transaction+0x148/0xf40 fs/btrfs/transaction.c:314
          start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
          btrfs_rebuild_free_space_tree+0xaa/0x480 fs/btrfs/free-space-tree.c:1323
          btrfs_start_pre_rw_mount+0x218/0xf60 fs/btrfs/disk-io.c:2999
          open_ctree+0x41ab/0x52e0 fs/btrfs/disk-io.c:3554
          btrfs_fill_super fs/btrfs/super.c:946 [inline]
          btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
          btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
          vfs_get_tree+0x8f/0x380 fs/super.c:1780
          fc_mount+0x16/0xc0 fs/namespace.c:1125
          btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
          btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
          vfs_get_tree+0x8f/0x380 fs/super.c:1780
          do_new_mount fs/namespace.c:3352 [inline]
          path_mount+0x6e1/0x1f10 fs/namespace.c:3679
          do_mount fs/namespace.c:3692 [inline]
          __do_sys_mount fs/namespace.c:3898 [inline]
          __se_sys_mount fs/namespace.c:3875 [inline]
          __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
          do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
          __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
          do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
          entry_SYSENTER_compat_after_hwframe+0x84/0x8e

   -> #0 (sb_internal#3){.+.+}-{0:0}:
          check_prev_add kernel/locking/lockdep.c:3134 [inline]
          check_prevs_add kernel/locking/lockdep.c:3253 [inline]
          validate_chain kernel/locking/lockdep.c:3869 [inline]
          __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
          lock_acquire kernel/locking/lockdep.c:5754 [inline]
          lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
          percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
          __sb_start_write include/linux/fs.h:1655 [inline]
          sb_start_intwrite include/linux/fs.h:1838 [inline]
          start_transaction+0xbc1/0x1a70 fs/btrfs/transaction.c:694
          btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
          btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
          evict+0x2ed/0x6c0 fs/inode.c:667
          iput_final fs/inode.c:1741 [inline]
          iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
          iput+0x5c/0x80 fs/inode.c:1757
          btrfs_scan_root fs/btrfs/extent_map.c:1118 [inline]
          btrfs_free_extent_maps+0xbd3/0x1320 fs/btrfs/extent_map.c:1189
          super_cache_scan+0x409/0x550 fs/super.c:227
          do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
          shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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

   other info that might help us debug this:

   Chain exists of:
     sb_internal#3 --> btrfs_trans_num_extwriters --> fs_reclaim

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(fs_reclaim);
                                  lock(btrfs_trans_num_extwriters);
                                  lock(fs_reclaim);
     rlock(sb_internal#3);

    *** DEADLOCK ***

   2 locks held by kswapd0/111:
    #0: ffffffff8dd3a9a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xa88/0x1970 mm/vmscan.c:6924
    #1: ffff88801eae40e0 (&type->s_umount_key#62){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
    #1: ffff88801eae40e0 (&type->s_umount_key#62){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

   stack backtrace:
   CPU: 0 PID: 111 Comm: kswapd0 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
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
    percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
    __sb_start_write include/linux/fs.h:1655 [inline]
    sb_start_intwrite include/linux/fs.h:1838 [inline]
    start_transaction+0xbc1/0x1a70 fs/btrfs/transaction.c:694
    btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
    btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
    evict+0x2ed/0x6c0 fs/inode.c:667
    iput_final fs/inode.c:1741 [inline]
    iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
    iput+0x5c/0x80 fs/inode.c:1757
    btrfs_scan_root fs/btrfs/extent_map.c:1118 [inline]
    btrfs_free_extent_maps+0xbd3/0x1320 fs/btrfs/extent_map.c:1189
    super_cache_scan+0x409/0x550 fs/super.c:227
    do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
    shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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
    </TASK>

So fix this by using btrfs_add_delayed_iput() so that the final iput is
delegated to the cleaner kthread.

Link: https://lore.kernel.org/linux-btrfs/000000000000892280061a344581@google.com/
Reported-by: syzbot+3dad89b3993a4b275e72@syzkaller.appspotmail.com
Fixes: 956a17d9d050 ("btrfs: add a shrinker for extent maps")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 54e3a52f2280..7c03016441ab 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1211,7 +1211,7 @@ static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_s
 
 		min_ino = btrfs_ino(inode) + 1;
 		fs_info->extent_map_shrinker_last_ino = btrfs_ino(inode);
-		iput(&inode->vfs_inode);
+		btrfs_add_delayed_iput(inode);
 
 		if (*scanned >= nr_to_scan)
 			break;
-- 
2.43.0


