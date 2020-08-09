Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDD23FE26
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Aug 2020 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHIMKE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Aug 2020 08:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIMKD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Aug 2020 08:10:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC8D9ACDB;
        Sun,  9 Aug 2020 12:10:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 5/5] btrfs: ctree: Checking key orders before merged tree blocks
Date:   Sun,  9 Aug 2020 20:09:19 +0800
Message-Id: <20200809120919.85271-6-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809120919.85271-1-wqu@suse.com>
References: <20200809120919.85271-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With crafted image, btrfs can panic at btrfs_del_csums().
  kernel BUG at fs/btrfs/ctree.c:3188!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 0 PID: 1156 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
  RIP: 0010:btrfs_set_item_key_safe+0x16c/0x180
  Code: b7 48 8d 7d bf 4c 89 fe 48 89 45 c8 0f b6 45 b6 88 45 c7 48 8b 45 ae 48 89 45 bf e8 ce f2 ff ff 85 c0 0f 8f 48 ff ff ff 0f 0b <0f> 0b e8 dd 8d be ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66
  RSP: 0018:ffff976141257ab8 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffff898a6b890930 RCX: 0000000004b70000
  RDX: 0000000000000000 RSI: ffff976141257bae RDI: ffff976141257acf
  RBP: ffff976141257b10 R08: 0000000000001000 R09: ffff9761412579a8
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff976141257abe
  R13: 0000000000000003 R14: ffff898a6a8be578 R15: ffff976141257bae
  FS: 0000000000000000(0000) GS:ffff898a77a00000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f779d9cd624 CR3: 000000022b2b4006 CR4: 00000000000206f0
  Call Trace:
  truncate_one_csum+0xac/0xf0
  btrfs_del_csums+0x24f/0x3a0
  __btrfs_free_extent.isra.72+0x5a7/0xbe0
  __btrfs_run_delayed_refs+0x539/0x1120
  btrfs_run_delayed_refs+0xdb/0x1b0
  btrfs_commit_transaction+0x52/0x950
  ? start_transaction+0x94/0x450
  transaction_kthread+0x163/0x190
  kthread+0x105/0x140
  ? btrfs_cleanup_transaction+0x560/0x560
  ? kthread_destroy_worker+0x50/0x50
  ret_from_fork+0x35/0x40
  Modules linked in:
  ---[ end trace 93bf9db00e6c374e ]---

[CAUSE]
This crafted image has a very tricky key order corruption:

  checksum tree key (CSUM_TREE ROOT_ITEM 0)
  node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
          ...
          key (EXTENT_CSUM EXTENT_CSUM 73785344) block 29757440 gen 19
          key (EXTENT_CSUM EXTENT_CSUM 77594624) block 29753344 gen 19
          ...

  leaf 29757440 items 5 free space 150 generation 19 owner CSUM_TREE
          item 0 key (EXTENT_CSUM EXTENT_CSUM 73785344) itemoff 2323 itemsize 1672
                  range start 73785344 end 75497472 length 1712128
          item 1 key (EXTENT_CSUM EXTENT_CSUM 75497472) itemoff 2319 itemsize 4
                  range start 75497472 end 75501568 length 4096
          item 2 key (EXTENT_CSUM EXTENT_CSUM 75501568) itemoff 579 itemsize 1740
                  range start 75501568 end 77283328 length 1781760
          item 3 key (EXTENT_CSUM EXTENT_CSUM 77283328) itemoff 575 itemsize 4
                  range start 77283328 end 77287424 length 4096
          item 4 key (EXTENT_CSUM EXTENT_CSUM 4120596480) itemoff 275 itemsize 300 <<<
                  range start 4120596480 end 4120903680 length 307200
  leaf 29753344 items 3 free space 1936 generation 19 owner CSUM_TREE
          item 0 key (18446744073457893366 EXTENT_CSUM 77594624) itemoff 2323 itemsize 1672
                  range start 77594624 end 79306752 length 1712128
          ...

Note the item 4 key of leaf 29757440, which is obviously too large, and
even larger than the first key of the next leaf.

However it still follows the key order in that tree block, thus tree
checker is unable to detect it at read time, since tree checker can only
work inside a leaf, thus such complex corruption can't be rejected in
advance.

[FIX]
The next timing to detect such problem is at tree block merge time,
which is in push_node_left(), balance_node_right(), push_leaf_left() and
push_leaf_right().

Now we check if the key order of the right most key of the left node is
larger than the left most key of the right node.

By this we don't need to call the full tree-check, while still keeps the
key order correct as key order in each node is already checked by tree
checker thus we only need to check the above two slots.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202833
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 70e49d8d4f6c..497abb397ea1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3159,6 +3159,52 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 		fixup_low_keys(path, &disk_key, 1);
 }
 
+/*
+ * Check the cross tree block key ordering.
+ *
+ * Tree-checker only works inside one tree block, thus the following
+ * corruption can not be rejected by tree-checker:
+ * Leaf @left			| Leaf @right
+ * --------------------------------------------------------------
+ * | 1 | 2 | 3 | 4 | 5 | f6 |   | 7 | 8 |
+ *
+ * Key f6 in leaf @left itself is valid, but not valid when the next
+ * key in leaf @right is 7.
+ * This can only be checked at tree block merge time.
+ * And since tree checker has ensured all key order in each tree block
+ * is correct, we only need to bother the last key of @left and the first
+ * key of @right.
+ */
+static bool valid_cross_tree_key_order(struct extent_buffer *left,
+				       struct extent_buffer *right)
+{
+	struct btrfs_key left_last;
+	struct btrfs_key right_first;
+	int level = btrfs_header_level(left);
+	int nr_left = btrfs_header_nritems(left);
+	int nr_right = btrfs_header_nritems(right);
+
+	/* No key to check in one of the tree blocks */
+	if (!nr_left || !nr_right)
+		return true;
+	if (level) {
+		btrfs_node_key_to_cpu(left, &left_last, nr_left - 1);
+		btrfs_node_key_to_cpu(right, &right_first, 0);
+	} else {
+		btrfs_item_key_to_cpu(left, &left_last, nr_left - 1);
+		btrfs_item_key_to_cpu(right, &right_first, 0);
+	}
+	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
+		btrfs_crit(left->fs_info,
+"bad key order cross tree blocks, left last (%llu %u %llu) right first (%llu %u %llu",
+			   left_last.objectid, left_last.type,
+			   left_last.offset, right_first.objectid,
+			   right_first.type, right_first.offset);
+		return false;
+	}
+	return true;
+}
+
 /*
  * try to push data from one node into the next node left in the
  * tree.
@@ -3203,6 +3249,12 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 	} else
 		push_items = min(src_nritems - 8, push_items);
 
+	/* dst is the left eb, src is the middle eb */
+	if (!valid_cross_tree_key_order(dst, src)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 	ret = tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -3271,6 +3323,12 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	if (max_push < push_items)
 		push_items = max_push;
 
+	/* dst is the right eb, src is the middle eb */
+	if (!valid_cross_tree_key_order(src, dst)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 	ret = tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
 	BUG_ON(ret < 0);
 	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
@@ -3747,6 +3805,12 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (left_nritems == 0)
 		goto out_unlock;
 
+	if (!valid_cross_tree_key_order(left, right)) {
+		ret = -EUCLEAN;
+		btrfs_tree_unlock(right);
+		free_extent_buffer(right);
+		return ret;
+	}
 	if (path->slots[0] == left_nritems && !empty) {
 		/* Key greater than all keys in the leaf, right neighbor has
 		 * enough room for it and we're not emptying our leaf to delete
@@ -3984,6 +4048,10 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		goto out;
 	}
 
+	if (!valid_cross_tree_key_order(left, right)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
 	return __push_leaf_left(path, min_data_size,
 			       empty, left, free_space, right_nritems,
 			       max_slot);
-- 
2.28.0

