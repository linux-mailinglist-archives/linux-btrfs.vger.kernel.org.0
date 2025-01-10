Return-Path: <linux-btrfs+bounces-10907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AAEA097E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C288E16B117
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE38213242;
	Fri, 10 Jan 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBAfJ0VN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F97212B02
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527948; cv=none; b=TQqG7Mtf4rckoAtY0QC4fBJYkXq9487lppT3TPtq1V/wqM6keXrQAQvJhOhm8INtZDWT3U7fUqdqqi58ADVjLC4fSl7hfUeJcrNTWUwqiNopAVkpP0K9wKh85nQ2RN2wmZZQMTQYoWQ7KBtA116toF9un4mzIiiyYKsVFKWs95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527948; c=relaxed/simple;
	bh=dupxk+1NUDY3shuTI6+kbTfl8kxMApSP6rKV1ggVr3E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VDcVsQNErad8iZ53I1nd73vJen4OhApF2FdoNjwD1tQEMRVpvNXeSd3TV0Kw33S62PIvWggqcN6ZxKelIyqJ2zFf4eLR+o3myl0WYbf1y1RyJjnb9YB8ra9o8FI46JGuNOit2TtBsYDKRHe9LN6cxlr5QH2NonCyknyhPVIg59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBAfJ0VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E7BC4CED6
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527948;
	bh=dupxk+1NUDY3shuTI6+kbTfl8kxMApSP6rKV1ggVr3E=;
	h=From:To:Subject:Date:From;
	b=SBAfJ0VNY/zNOFcRvxF3delzpPpDLmYkl79VZXksp/glwYPsqVp6GjfPe7KpxtfEn
	 FgLdzRk1pzzYJgd2gIdCwWHR1rPE8M5RvpK2LJKeDlf/4LsMPZ84AQaLD9Qrog/DVc
	 IQ3JzFeZU8ZFmdrDcTHqhlufVVGMCfOFeNsDJ7OBquV/iWcO3r3u82YDPYLaLD+ZJX
	 9jql12hrDufrf83phEnqZ9VoREuSJD8exUBTTdWpAHeCEcOUjWXweEgpbfKx5qWszz
	 YrbgiaDypphk52sLUAmqafqWVsJFdK9QYvw+/ahVWrqshDJ7blP+TInbTTFz1w2Cc9
	 UYMokWhOtmVSQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lockdep splat while merging a relocation root
Date: Fri, 10 Jan 2025 16:52:24 +0000
Message-Id: <79e35a242bceafc9cb6d88e336ddfee5115a3ba5.1736524334.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When COWing a relocation tree path, at relocation.c:replace_path(), we
can trigger a lockdep splat while we are in the btrfs_search_slot() call
against the relocation root. This happens in that callchain at
ctree.c:read_block_for_search() when we happen to find a child extent
buffer already loaded through the fs tree with a lockdep class set to
the fs tree. So when we attempt to lock that extent buffer through a
relocation tree we have to reset the lockdep class to the class for a
relocation tree, since a relocation tree has extent buffers that used
to belong to a fs tree and may currently be already loaded (we swap
extent buffers between the two trees at the end of replace_path()).

However we are missing calls to btrfs_maybe_reset_lockdep_class() to reset
the lockdep class at ctree.c:read_block_for_search() before we read lock
an extent buffer, just like we did for btrfs_search_slot() in commit
b40130b23ca4 ("btrfs: fix lockdep splat with reloc root extent buffers").

So add the missing btrfs_maybe_reset_lockdep_class() calls before the
attempts to read lock an extent buffer at ctree.c:read_block_for_search().

The lockdep splat was reported by syzbot and it looks like this:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.13.0-rc5-syzkaller-00163-gab75170520d4 #0 Not tainted
   ------------------------------------------------------
   syz.0.0/5335 is trying to acquire lock:
   ffff8880545dbc38 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146

   but task is already holding lock:
   ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #2 (btrfs-treloc-02/1){+.+.}-{4:4}:
          reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5374
          __lock_release kernel/locking/lockdep.c:5563 [inline]
          lock_release+0x396/0xa30 kernel/locking/lockdep.c:5870
          up_write+0x79/0x590 kernel/locking/rwsem.c:1629
          btrfs_force_cow_block+0x14b3/0x1fd0 fs/btrfs/ctree.c:660
          btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
          btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
          replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
          merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
          merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
          relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
          btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
          btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
          __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
          btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
          btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
          vfs_ioctl fs/ioctl.c:51 [inline]
          __do_sys_ioctl fs/ioctl.c:906 [inline]
          __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
          do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
          entry_SYSCALL_64_after_hwframe+0x77/0x7f

   -> #1 (btrfs-tree-01/1){+.+.}-{4:4}:
          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
          down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
          btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
          btrfs_init_new_buffer fs/btrfs/extent-tree.c:5052 [inline]
          btrfs_alloc_tree_block+0x41c/0x1440 fs/btrfs/extent-tree.c:5132
          btrfs_force_cow_block+0x526/0x1fd0 fs/btrfs/ctree.c:573
          btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
          btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
          btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4351
          btrfs_insert_empty_item fs/btrfs/ctree.h:688 [inline]
          btrfs_insert_inode_ref+0x2bb/0xf80 fs/btrfs/inode-item.c:330
          btrfs_rename_exchange fs/btrfs/inode.c:7990 [inline]
          btrfs_rename2+0xcb7/0x2b90 fs/btrfs/inode.c:8374
          vfs_rename+0xbdb/0xf00 fs/namei.c:5067
          do_renameat2+0xd94/0x13f0 fs/namei.c:5224
          __do_sys_renameat2 fs/namei.c:5258 [inline]
          __se_sys_renameat2 fs/namei.c:5255 [inline]
          __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5255
          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
          do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
          entry_SYSCALL_64_after_hwframe+0x77/0x7f

   -> #0 (btrfs-tree-01){++++}-{4:4}:
          check_prev_add kernel/locking/lockdep.c:3161 [inline]
          check_prevs_add kernel/locking/lockdep.c:3280 [inline]
          validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
          __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
          down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
          btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
          btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
          read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
          btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
          replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
          merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
          merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
          relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
          btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
          btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
          __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
          btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
          btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
          vfs_ioctl fs/ioctl.c:51 [inline]
          __do_sys_ioctl fs/ioctl.c:906 [inline]
          __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
          do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
          entry_SYSCALL_64_after_hwframe+0x77/0x7f

   other info that might help us debug this:

   Chain exists of:
     btrfs-tree-01 --> btrfs-tree-01/1 --> btrfs-treloc-02/1

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(btrfs-treloc-02/1);
                                  lock(btrfs-tree-01/1);
                                  lock(btrfs-treloc-02/1);
     rlock(btrfs-tree-01);

    *** DEADLOCK ***

   8 locks held by syz.0.0/5335:
    #0: ffff88801e3ae420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write_file+0x5e/0x200 fs/namespace.c:559
    #1: ffff888052c760d0 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: __btrfs_balance+0x4c2/0x26b0 fs/btrfs/volumes.c:4183
    #2: ffff888052c74850 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_relocate_block_group+0x775/0xd90 fs/btrfs/relocation.c:4086
    #3: ffff88801e3ae610 (sb_internal#2){.+.+}-{0:0}, at: merge_reloc_root+0xf11/0x1ad0 fs/btrfs/relocation.c:1659
    #4: ffff888052c76470 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
    #5: ffff888052c76498 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
    #6: ffff8880545db878 (btrfs-tree-01/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
    #7: ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189

   stack backtrace:
   CPU: 0 UID: 0 PID: 5335 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
    btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
    read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
    btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
    replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
    merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
    merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
    relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
    btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
    btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
    __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
    btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
    btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:906 [inline]
    __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f1ac6985d29
   Code: ff ff c3 (...)
   RSP: 002b:00007f1ac63fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 00007f1ac6b76160 RCX: 00007f1ac6985d29
   RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000007
   RBP: 00007f1ac6a01b08 R08: 0000000000000000 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
   R13: 0000000000000001 R14: 00007f1ac6b76160 R15: 00007fffda145a88
    </TASK>

Reported-by: syzbot+63913e558c084f7f8fdc@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/677b3014.050a0220.3b53b0.0064.GAE@google.com/
Fixes: 99785998ed1c ("btrfs: reduce lock contention when eb cache miss for btree search")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c93f52a30a16..094273cd0d33 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1496,6 +1496,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 
 		if (!p->skip_locking) {
 			btrfs_unlock_up_safe(p, parent_level + 1);
+			btrfs_maybe_reset_lockdep_class(root, tmp);
 			tmp_locked = true;
 			btrfs_tree_read_lock(tmp);
 			btrfs_release_path(p);
@@ -1539,6 +1540,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 
 	if (!p->skip_locking) {
 		ASSERT(ret == -EAGAIN);
+		btrfs_maybe_reset_lockdep_class(root, tmp);
 		tmp_locked = true;
 		btrfs_tree_read_lock(tmp);
 		btrfs_release_path(p);
-- 
2.45.2


