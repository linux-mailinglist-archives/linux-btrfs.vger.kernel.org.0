Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219031E7B82
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2LS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 07:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2LS1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 07:18:27 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00160207D4
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590751106;
        bh=crxyfdt6rnGfp9wFioD3r5foO1ugTwziMi7RU4hS2os=;
        h=From:To:Subject:Date:From;
        b=FfZyiNmBE+L7Fz27tm3g0PnNBlm0gB6+4CQ+wPlV4HgleGv5R8nWiNZVzBY3Q6L2H
         gWruEecFNj4iExpsOYqYOlpewh94sDNIDv5UG5okxBBtkOG2KOD528/G1zK+l0HMJW
         m3tb2PzFb8hVEdktIiyKlKxBEPmQSD59rxKp9jjs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] Btrfs: fix race between block group removal and block group creation
Date:   Fri, 29 May 2020 12:18:23 +0100
Message-Id: <20200529111823.12510-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There is a race between block group removal and block group creation
when the removal is completed by a task running fitrim or scrub. When
this happens we end up failing the block group creation with an error
-EEXIST since we attempt to insert a duplicate block group item key
in the extent tree. That results in a transaction abort.

The race happens like this:

1) Task A is doing a fitrim, and at btrfs_trim_block_group() it freezes
   block group X with btrfs_freeze_block_group() (until very recently
   that was named btrfs_get_block_group_trimming());

2) Task B starts removing block group X, either because it's now unused
   or due to relocation for example. So at btrfs_remove_block_group(),
   while holding the chunk mutex and the block group's lock, it sets
   the 'removed' flag of the block group and it sets the local variable
   'remove_em' to false, because the block group is currently frozen
   (its 'frozen' counter is > 0, until very recently this counter was
   named 'trimming');

3) Task B unlocks the block group and the chunk mutex;

4) Task A is done trimming the block group and unfreezes the block group
   by calling btrfs_unfreeze_block_group() (until very recently this was
   named btrfs_put_block_group_trimming()). In this function we lock the
   block group and set the local variable 'cleanup' to true because we
   were able to decrement the block group's 'frozen' counter down to 0 and
   the flag 'removed' is set in the block group.

   Since 'cleanup' is set to true, it locks the chunk mutex and removes
   the extent mapping representing the block group from the mapping tree;

5) Task C allocates a new block group Y and it picks up the logical address
   that block group X had as the logical address for Y, because X was the
   block group with the highest logical address and now the second block
   group with the highest logical address, the last in the fs mapping tree,
   ends at an offset corresponding to block group X's logical address (this
   logical address selection is done at volumes.c:find_next_chunk()).

   At this point the new block group Y does not have yet its item added
   to the extent tree (nor the corresponding device extent items and
   chunk item in the device and chunk trees). The new group Y is added to
   the list of pending block groups in the transaction handle;

6) Before task B proceeds to removing the block group item for block
   group X from the extent tree, which has a key matching:

   (X logical offset, BTRFS_BLOCK_GROUP_ITEM_KEY, length)

   task C while ending its transaction handle calls
   btrfs_create_pending_block_groups(), which finds block group Y and
   tries to insert the block group item for Y into the exten tree, which
   fails with -EEXIST since logical offset is the same that X had and
   task B hasn't yet deleted the key from the extent tree.
   This failure results in a transaction abort, producing a stack like
   the following:

------------[ cut here ]------------
 BTRFS: Transaction aborted (error -17)
 WARNING: CPU: 2 PID: 19736 at fs/btrfs/block-group.c:2074 btrfs_create_pending_block_groups+0x1eb/0x260 [btrfs]
 Modules linked in: btrfs blake2b_generic xor raid6_pq (...)
 CPU: 2 PID: 19736 Comm: fsstress Tainted: G        W         5.6.0-rc7-btrfs-next-58 #5
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
 RIP: 0010:btrfs_create_pending_block_groups+0x1eb/0x260 [btrfs]
 Code: ff ff ff 48 8b 55 50 f0 48 (...)
 RSP: 0018:ffffa4160a1c7d58 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffff961581909d98 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffb3d63990 RDI: 0000000000000001
 RBP: ffff9614f3356a58 R08: 0000000000000000 R09: 0000000000000001
 R10: ffff9615b65b0040 R11: 0000000000000000 R12: ffff961581909c10
 R13: ffff9615b0c32000 R14: ffff9614f3356ab0 R15: ffff9614be779000
 FS:  00007f2ce2841e80(0000) GS:ffff9615bae00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000555f18780000 CR3: 0000000131d34005 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  btrfs_start_dirty_block_groups+0x398/0x4e0 [btrfs]
  btrfs_commit_transaction+0xd0/0xc50 [btrfs]
  ? btrfs_attach_transaction_barrier+0x1e/0x50 [btrfs]
  ? __ia32_sys_fdatasync+0x20/0x20
  iterate_supers+0xdb/0x180
  ksys_sync+0x60/0xb0
  __ia32_sys_sync+0xa/0x10
  do_syscall_64+0x5c/0x280
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7f2ce1d4d5b7
 Code: 83 c4 08 48 3d 01 (...)
 RSP: 002b:00007ffd8b558c58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
 RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00007f2ce1d4d5b7
 RDX: 00000000ffffffff RSI: 00000000186ba07b RDI: 000000000000002c
 RBP: 0000555f17b9e520 R08: 0000000000000012 R09: 000000000000ce00
 R10: 0000000000000078 R11: 0000000000000202 R12: 0000000000000032
 R13: 0000000051eb851f R14: 00007ffd8b558cd0 R15: 0000555f1798ec20
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
 softirqs last  enabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace bd7c03622e0b0a9c ]---

Fix this simply by making btrfs_remove_block_group() remove the block
group's item from the extent tree before it flags the block group as
removed. Also make the free space deletion from the free space tree
before flagging the block group as removed, to avoid a similar race
with adding and removing free space entries for the free space tree.

Fixes: 04216820fe83d5 ("Btrfs: fix race between fs trimming and block group remove/allocation")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 33a61f95916a..5e0e994c87bb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1065,10 +1065,35 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	spin_unlock(&block_group->space_info->lock);
 
+	/*
+	 * Remove the free space for the block group from the free space tree
+	 * and the block group's item from the extent tree before marking the
+	 * block group as removed. This is to prevent races with tasks that
+	 * freeze and unfreeze a block group, this task and another task
+	 * allocating a new block group - the unfreeze task ends up removing
+	 * the block group's extent map before the task calling this function
+	 * deletes the block group item from the extent tree, allowing for
+	 * another task to attempt to create another block group with the same
+	 * item key (and failing with -EEXIST and a transaction abort).
+	 */
+	ret = remove_block_group_free_space(trans, block_group);
+	if (ret)
+		goto out_put_group;
+
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
 
+	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret > 0)
+		ret = -EIO;
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_del_item(trans, root, path);
+	if (ret)
+		goto out;
+
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&block_group->lock);
 	block_group->removed = 1;
@@ -1103,23 +1128,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	mutex_unlock(&fs_info->chunk_mutex);
 
-	ret = remove_block_group_free_space(trans, block_group);
-	if (ret)
-		goto out_put_group;
-
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret > 0)
-		ret = -EIO;
-	if (ret < 0)
-		goto out;
-
-	ret = btrfs_del_item(trans, root, path);
-	if (ret)
-		goto out;
-
 	if (remove_em) {
 		struct extent_map_tree *em_tree;
 
-- 
2.11.0

