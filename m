Return-Path: <linux-btrfs+bounces-14507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C3ACF88E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0267D3B01F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224281FE474;
	Thu,  5 Jun 2025 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXNdj+Y3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1E1FC0FC
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153907; cv=none; b=VHnSYlznFKR799KgcjnsjmChkvfxw+mq6az/X3dNCZJBUxPJTrJvdwBW/c/dFw98pztUcX55UqxWLfATd5e4W0utIKoulyiNNLMU02Vjn5rS+AnejMYd7TGq1fNVpSrn9/h+gWs54StF93CbZho2jA5VZN1eSiVE6vBHuZ70omc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153907; c=relaxed/simple;
	bh=QbSEV2p7SfJ+DL9G1cqAPFlu3zV51OHTDt/UIACmevI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IvTsvcnPu9nSZKUuj4qPxc45lySqkMDhSw8K+ZwwsOB+B5eVdNDvbJgN4K5up84L8SA0h7I5mMGGMVTxMuwzkaXO1v+eDG0Hpz7fAZmY49Gutf1HQSW3OW65CoxU5PwUjXUCkVfZjNUre+VxPhbXwYyBn7dFsj5LT4SFbhc/oFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXNdj+Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE55C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153906;
	bh=QbSEV2p7SfJ+DL9G1cqAPFlu3zV51OHTDt/UIACmevI=;
	h=From:To:Subject:Date:From;
	b=DXNdj+Y3GyJX1wF+ywTR/Bc1ABjiZeVq4PwksfIbQPmXTStVA1WHic+0cBmyzAvbb
	 mn6bJOwCwU8HQN6hb9nj2m87jYiiKBtHh9DR/X1oHefE2Z53EflKbztGoCgkLwFW7E
	 zuKr8u6Cv3fOW/LEJeZbIEc6UCCkbf25iFsZ1nftkZ+0Sb/uV5PIvs1ToZhkfbvClc
	 0VrfVqVAWRufmorn9qi9+Zxs8ZGO59s/otdm84CVK0zJGDVENMgvEZKfbh2UM9UFBw
	 XXYo2iWmI9bRZbuHI6UeTjXgnttdqPXuIN1WVIREXLr/U00wB04qiUTIHFetmgBXY9
	 3vzk+G7ZA1/zA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix assertion when building free space tree
Date: Thu,  5 Jun 2025 21:05:03 +0100
Message-ID: <f60761dc5dd7376ac91d0a645bd2c3a59a68cee7.1749153697.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When building the free space tree with the block group tree feature
enabled, we can hit an assertion failure like this:

   BTRFS info (device loop0 state M): rebuilding free space tree
   assertion failed: ret == 0, in fs/btrfs/free-space-tree.c:1102
   ------------[ cut here ]------------
   kernel BUG at fs/btrfs/free-space-tree.c:1102!
   Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
   Modules linked in:
   CPU: 1 UID: 0 PID: 6592 Comm: syz-executor322 Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
   lr : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
   sp : ffff8000a4ce7600
   x29: ffff8000a4ce76e0 x28: ffff0000c9bc6000 x27: ffff0000ddfff3d8
   x26: ffff0000ddfff378 x25: dfff800000000000 x24: 0000000000000001
   x23: ffff8000a4ce7660 x22: ffff70001499cecc x21: ffff0000e1d8c160
   x20: ffff0000e1cb7800 x19: ffff0000e1d8c0b0 x18: 00000000ffffffff
   x17: ffff800092f39000 x16: ffff80008ad27e48 x15: ffff700011e740c0
   x14: 1ffff00011e740c0 x13: 0000000000000004 x12: ffffffffffffffff
   x11: ffff700011e740c0 x10: 0000000000ff0100 x9 : 94ef24f55d2dbc00
   x8 : 94ef24f55d2dbc00 x7 : 0000000000000001 x6 : 0000000000000001
   x5 : ffff8000a4ce6f98 x4 : ffff80008f415ba0 x3 : ffff800080548ef0
   x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003e
   Call trace:
    populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102 (P)
    btrfs_rebuild_free_space_tree+0x14c/0x54c fs/btrfs/free-space-tree.c:1337
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
   Code: f0047182 91178042 528089c3 9771d47b (d4210000)
   ---[ end trace 0000000000000000 ]---

This happens because we are processing an empty block group, which has
no extents allocated from it, there are no items for this block group,
including the block group item since block group items are stored in a
dedicated tree when using the block group tree feature. It also means
this is the block group with the highest start offset, so there are no
higher keys in the extent root, hence btrfs_search_slot_for_read()
returns 1 (no higher key found).

Fix this by asserting 'ret' is 0 only if the block group tree feature
is not enabled, in which case we should find a block group item for
the block group since it's stored in the extent root and block group
item keys are greater than extent item keys (the value for
BTRFS_BLOCK_GROUP_ITEM_KEY is 192 and for BTRFS_EXTENT_ITEM_KEY and
BTRFS_METADATA_ITEM_KEY the values are 168 and 169 respectively).
In case 'ret' is 1, we just need to add a record to the free space
tree which spans the whole block group, and we can achieve this by
making 'ret == 0' as the while loop's condition.

Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6841dca8.a00a0220.d4325.0020.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index af51cf784a5b..15721b9bbfe2 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1115,11 +1115,21 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
-	ASSERT(ret == 0);
+	/*
+	 * If ret is 1 (no key found), it means this is an empty block group,
+	 * without any extents allocated from it and there's no block group
+	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
+	 * because we are using the block group tree feature, so block group
+	 * items are stored in the block group tree. It also means there are no
+	 * extents allocated for block groups with a start offset beyond this
+	 * block group's end offset (this is the last, highest, block group).
+	 */
+	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
+		ASSERT(ret == 0);
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-	while (1) {
+	while (ret == 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -1149,8 +1159,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		ret = btrfs_next_item(extent_root, path);
 		if (ret < 0)
 			goto out_locked;
-		if (ret)
-			break;
 	}
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
-- 
2.47.2


