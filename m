Return-Path: <linux-btrfs+bounces-14547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE287AD1550
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 00:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7610A169946
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9C25A2A5;
	Sun,  8 Jun 2025 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taVIA0Ow"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97724254AF3
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422620; cv=none; b=EOR+9yrE5zazkza4BerbDar8Qfl2+H4AWAHZ6hRhAl2r8rRCCtpVjTVRY677q8oXvm4pVeFkiiQZ4hnQgfua9+Pe5v8LtnkjaLR/NXYVW58DNMXoeJlBX+NySpUNEVjPj7pQLAJLV8OPfv1XqyK6s5CMYrMMDVMmyTdjLtLTdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422620; c=relaxed/simple;
	bh=45U79JgdFgYxDKVpZqm0o3cuXignxt+EnDMsziFqxIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS+zGOdznuub0s/8iDhlNZgHGDsuJu6n5wz86G1Gk1rYyvL/XpE92W/XIDBr614M3By3vBnw3D9r/vOqokAneAT2NQD6JWoquHzhf00r9J27+y8BxaVBgcPLANJC8dFK5wcjLm6FKeGgQW5W8g0Dvo5bjhx7BDo0KW5HSPPfCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taVIA0Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A417DC4CEEF
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749422620;
	bh=45U79JgdFgYxDKVpZqm0o3cuXignxt+EnDMsziFqxIA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=taVIA0OwW1224s72H24gCGzI37RUZNhX37zg8Ss/+3McghSERtNe8F0DgI9+xh5Ae
	 asZDohPTaoUmg6mi0yW5UwXS+tHxLmT/Ubad6e3IgaHw+C+ljNdt+sYxzjXy1n3GOt
	 crUSC+8dpIbdMuU4oPpQeuGQbU57UsLNOTb/sHKRncQzZXCfUaAWtM6enSHLKqwkam
	 m0gW0dw2oHzZWeCN0ZOxc+xY0IbQQN9ycsz62kf5CLbpcw1yqFKJWmo1VfZavXckrT
	 MS42WGuL5FJpnM5lEWdhsrsJLn5Z0v1xSd3B7a6MvECcOZAnvQ1NAO4ZMZkfjS9F1n
	 euoNU4jjAGWjw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix failure to rebuild free space tree using multiple transactions
Date: Sun,  8 Jun 2025 23:43:32 +0100
Message-ID: <85176621261cd2403632c2d1addbba4d8321456d.1749421865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1749421865.git.fdmanana@suse.com>
References: <cover.1749421865.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we are rebuilding a free space tree, while modifying the free space
tree we may need to allocate a new metadata block group.
If we end up using multiple transactions for the rebuild, when we call
btrfs_end_transaction() we enter btrfs_create_pending_block_groups()
which calls add_block_group_free_space() to add items to the free space
tree for the block group.

Then later during the free space tree rebuild, at
btrfs_rebuild_free_space_tree(), we may find such new block groups
and call populate_free_space_tree() for them, which fails with -EEXIST
because there are already items in the free space tree. Then we abort the
transaction with -EEXIST at btrfs_rebuild_free_space_tree().
Notice that we say "may find" the new block groups because a new block
group may be inserted in the block groups rbtree, which is being iterated
by the rebuild process, before or after the current node where the rebuild
process is currently at.

Syzbot recently reported such case which produces a trace like the
following:

   ------------[ cut here ]------------
   BTRFS: Transaction aborted (error -17)
   WARNING: CPU: 1 PID: 7626 at fs/btrfs/free-space-tree.c:1341 btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
   Modules linked in:
   CPU: 1 UID: 0 PID: 7626 Comm: syz.2.25 Not tainted 6.15.0-rc7-syzkaller-00085-gd7fa1af5b33e-dirty #0 PREEMPT
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
   lr : btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341
   sp : ffff80009c4f7740
   x29: ffff80009c4f77b0 x28: ffff0000d4c3f400 x27: 0000000000000000
   x26: dfff800000000000 x25: ffff70001389eee8 x24: 0000000000000003
   x23: 1fffe000182b6e7b x22: 0000000000000000 x21: ffff0000c15b73d8
   x20: 00000000ffffffef x19: ffff0000c15b7378 x18: 1fffe0003386f276
   x17: ffff80008f31e000 x16: ffff80008adbe98c x15: 0000000000000001
   x14: 1fffe0001b281550 x13: 0000000000000000 x12: 0000000000000000
   x11: ffff60001b281551 x10: 0000000000000003 x9 : 1c8922000a902c00
   x8 : 1c8922000a902c00 x7 : ffff800080485878 x6 : 0000000000000000
   x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008047843c
   x2 : 0000000000000001 x1 : ffff80008b3ebc40 x0 : 0000000000000001
   Call trace:
    btrfs_rebuild_free_space_tree+0x470/0x54c fs/btrfs/free-space-tree.c:1341 (P)
    btrfs_start_pre_rw_mount+0xa78/0xe10 fs/btrfs/disk-io.c:3074
    btrfs_remount_rw fs/btrfs/super.c:1319 [inline]
    btrfs_reconfigure+0x828/0x2418 fs/btrfs/super.c:1543
    reconfigure_super+0x1d4/0x6f0 fs/super.c:1083
    do_remount fs/namespace.c:3365 [inline]
    path_mount+0xb34/0xde0 fs/namespace.c:4200
    do_mount fs/namespace.c:4221 [inline]
    __do_sys_mount fs/namespace.c:4432 [inline]
    __se_sys_mount fs/namespace.c:4409 [inline]
    __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4409
    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
    invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
    el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
    el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
    el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
   irq event stamp: 330
   hardirqs last  enabled at (329): [<ffff80008048590c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1525 [inline]
   hardirqs last  enabled at (329): [<ffff80008048590c>] finish_lock_switch+0xb0/0x1c0 kernel/sched/core.c:5130
   hardirqs last disabled at (330): [<ffff80008adb9e60>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
   softirqs last  enabled at (10): [<ffff8000801fbf10>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
   softirqs last disabled at (8): [<ffff8000801fbedc>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
   ---[ end trace 0000000000000000 ]---

Fix this by flagging new block groups which had their free space tree
entries already added and then skip them in the rebuild process. Also,
since the rebuild may be triggered when doing a remount, make sure that
when we clear an existing free space tree that we clear such flag from
every existing block group, otherwise we would skip those block groups
during the rebuild.

Reported-by: syzbot+d0014fb0fc39c5487ae5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/68460a54.050a0220.daf97.0af5.GAE@google.com/
Fixes: 882af9f13e83 ("btrfs: handle free space tree rebuild in multiple transactions")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.h     |  2 ++
 fs/btrfs/free-space-tree.c | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9de356bcb411..aa176cc9a324 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -83,6 +83,8 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 	/* Does the block group need to be added to the free space tree? */
 	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+	/* Set after we add a new block group to the free space tree. */
+	BLOCK_GROUP_FLAG_FREE_SPACE_ADDED,
 	/* Indicate that the block group is placed on a sequential zone */
 	BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE,
 	/*
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 15721b9bbfe2..9eb9858e8e99 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1241,6 +1241,7 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 {
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
+	struct rb_node *node;
 	int nr;
 	int ret;
 
@@ -1269,6 +1270,16 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	}
 
+	node = rb_first_cached(&trans->fs_info->block_group_cache_tree);
+	while (node) {
+		struct btrfs_block_group *bg;
+
+		bg = rb_entry(node, struct btrfs_block_group, cache_node);
+		clear_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &bg->runtime_flags);
+		node = rb_next(node);
+		cond_resched();
+	}
+
 	return 0;
 }
 
@@ -1358,12 +1369,18 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
+
+		if (test_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED,
+			     &block_group->runtime_flags))
+			goto next;
+
 		ret = populate_free_space_tree(trans, block_group);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			btrfs_end_transaction(trans);
 			return ret;
 		}
+next:
 		if (btrfs_should_end_transaction(trans)) {
 			btrfs_end_transaction(trans);
 			trans = btrfs_start_transaction(free_space_root, 1);
@@ -1390,6 +1407,29 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 
 	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
 
+	/*
+	 * While rebuilding the free space tree we may allocate new metadata
+	 * block groups while modifying the free space tree.
+	 *
+	 * Because during the rebuild (at btrfs_rebuild_free_space_tree()) we
+	 * can use multiple transactions, every time btrfs_end_transaction() is
+	 * called at btrfs_rebuild_free_space_tree() we finish the creation of
+	 * new block groups by calling btrfs_create_pending_block_groups(), and
+	 * that in turn calls us, through add_block_group_free_space(), to add
+	 * a free space info item and a free space extent item for the block
+	 * group.
+	 *
+	 * Then later btrfs_rebuild_free_space_tree() may find such new block
+	 * groups and processes them with populate_free_space_tree(), which can
+	 * fail with EEXIST since there are already items for the block group in
+	 * the free space tree. Notice that we say "may find" because a new
+	 * block group may be added to the block groups rbtree in a node before
+	 * or after the block group currently being processed by the rebuild
+	 * process. So signal the rebuild process to skip such new block groups
+	 * if it finds them.
+	 */
+	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
+
 	ret = add_new_free_space_info(trans, block_group, path);
 	if (ret)
 		return ret;
-- 
2.47.2


