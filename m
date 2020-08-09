Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9023FE23
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Aug 2020 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHIMJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Aug 2020 08:09:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIMJn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Aug 2020 08:09:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EA7BACDB;
        Sun,  9 Aug 2020 12:10:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 2/5] btrfs: extent-tree: Kill BUG_ON() in __btrfs_free_extent() and do better comment
Date:   Sun,  9 Aug 2020 20:09:16 +0800
Message-Id: <20200809120919.85271-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809120919.85271-1-wqu@suse.com>
References: <20200809120919.85271-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__btrfs_free_extent() is one of the best cases to show how optimization
could make a function hard to read.

In fact __btrfs_free_extent() is only doing two major works:
1. Reduce the refs number of an extent backref
   Either it's an inlined extent backref (inside EXTENT/METADATA item) or
   a keyed extent backref (SHARED_* item).
   We only need to locate that backref line, either reduce the number or
   remove the backref line completely.

2. Update the refs count in EXTENT/METADATA_ITEM

But in real world, we do it in a complex but somewhat efficient way.
During step 1), we will try to locate the EXTENT/METADATA_ITEM without
triggering another btrfs_search_slot() as fast path.

Only when we failed to locate that item, we will trigger another
btrfs_search_slot() to get that EXTENT/METADATA_ITEM after we
updated/deleted the backref line.

And we have a lot of restrict check on things like refs_to_drop against
extent refs and special case check for single ref extent.

All of these results:
- 7 BUG_ON()s in a single function
  Although all these BUG_ON() are doing correct check, they're super
  easy to get triggered for fuzzed images.
  It's never a good idea to piss the end user.

- Near 300 lines without much useful comments but a lot of hidden
  conditions
  I believe even the author needs several minutes to recall what the
  code is doing
  Not to mention a lot of BUG_ON() conditions needs to go back tens of
  lines to find out why.

This patch address all these problems by:
- Introduce two examples to show what __btrfs_free_extent() is doing
  One inlined backref case and one keyed case.
  Should cover most cases.

- Kill all BUG_ON()s with proper error message and optional leaf dump

- Add comment to show the overall workflow

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202819
[ The report triggers one BUG_ON() in __btrfs_free_extent() ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 144 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fa7d83051587..8e86e3524861 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2930,6 +2930,53 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
+/*
+ * Real work happens here to drop one or more refs of @node.
+ *
+ * The work is mostly done in two parts:
+ * 1. Locate the extent refs.
+ *    It's either inlined in EXTENT/METADATA_ITEM or in keyed SHARED_* item.
+ *    Locate it then reduces the refs number or remove the ref line completely.
+ *
+ * 2. Update the refs count in EXTENT/METADATA_ITEM
+ *
+ * Due to the above two operations and possible optimizations, the function
+ * is a little hard to read, but with the following examples, the result
+ * of this function should be pretty easy to get.
+ *
+ * Example:
+ * *** Inlined backref case ***
+ * In extent tree we have:
+ * 	item 0 key (13631488 EXTENT_ITEM 1048576) itemoff 16201 itemsize 82
+ *		refs 2 gen 6 flags DATA
+ *		extent data backref root FS_TREE objectid 258 offset 0 count 1
+ *		extent data backref root FS_TREE objectid 257 offset 0 count 1
+ *
+ * This function get called with
+ *  node->bytenr = 13631488, node->num_bytes = 1048576
+ *  root_objectid = FS_TREE, owner_objectid = 257, owner_offset = 0,
+ *  refs_to_drop = 1
+ * Then we should get some like:
+ * 	item 0 key (13631488 EXTENT_ITEM 1048576) itemoff 16201 itemsize 82
+ *		refs 1 gen 6 flags DATA
+ *		extent data backref root FS_TREE objectid 258 offset 0 count 1
+ *
+ * *** Keyed backref case ***
+ * In extent tree we have:
+ *	item 0 key (13631488 EXTENT_ITEM 1048576) itemoff 3971 itemsize 24
+ *		refs 754 gen 6 flags DATA
+ *	[...]
+ *	item 2 key (13631488 EXTENT_DATA_REF <HASH>) itemoff 3915 itemsize 28
+ *		extent data backref root FS_TREE objectid 866 offset 0 count 1
+ * This function get called with
+ *  node->bytenr = 13631488, node->num_bytes = 1048576
+ *  root_objectid = FS_TREE, owner_objectid = 866, owner_offset = 0,
+ *  refs_to_drop = 1
+ * Then we should get some like:
+ *	item 0 key (13631488 EXTENT_ITEM 1048576) itemoff 3971 itemsize 24
+ *		refs 753 gen 6 flags DATA
+ * And that (13631488 EXTENT_DATA_REF <HASH>) get removed.
+ */
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
 			       u64 root_objectid, u64 owner_objectid,
@@ -2962,7 +3009,15 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	path->leave_spinning = 1;
 
 	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
-	BUG_ON(!is_data && refs_to_drop != 1);
+
+	if (unlikely(!is_data && refs_to_drop != 1)) {
+		btrfs_crit(info,
+"invalid refs_to_drop, dropping more than 1 refs for tree block %llu refs_to_drop %u",
+			   node->bytenr, refs_to_drop);
+		ret = -EINVAL;
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
 
 	if (is_data)
 		skinny_metadata = false;
@@ -2971,6 +3026,13 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				    parent, root_objectid, owner_objectid,
 				    owner_offset);
 	if (ret == 0) {
+		/*
+		 * Either the inline backref or the SHARED_DATA_REF/
+		 * SHARED_BLOCK_REF is found
+		 *
+		 * Here is a quick path to locate EXTENT/METADATA_ITEM.
+		 * It's possible the EXTENT/METADATA_ITEM is near current slot.
+		 */
 		extent_slot = path->slots[0];
 		while (extent_slot >= 0) {
 			btrfs_item_key_to_cpu(path->nodes[0], &key,
@@ -2987,13 +3049,20 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				found_extent = 1;
 				break;
 			}
+
+			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
 			if (path->slots[0] - extent_slot > 5)
 				break;
 			extent_slot--;
 		}
 
 		if (!found_extent) {
-			BUG_ON(iref);
+			if (unlikely(iref)) {
+				btrfs_crit(info,
+"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent ref");
+				goto err_dump_abort;
+			}
+			/* Must be SHARED_* item, remove the backref first */
 			ret = remove_extent_backref(trans, path, NULL,
 						    refs_to_drop,
 						    is_data, &last_ref);
@@ -3004,6 +3073,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			btrfs_release_path(path);
 			path->leave_spinning = 1;
 
+
+			/* Slow path to locate EXTENT/METADATA_ITEM */
 			key.objectid = bytenr;
 			key.type = BTRFS_EXTENT_ITEM_KEY;
 			key.offset = num_bytes;
@@ -3078,19 +3149,24 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	if (owner_objectid < BTRFS_FIRST_FREE_OBJECTID &&
 	    key.type == BTRFS_EXTENT_ITEM_KEY) {
 		struct btrfs_tree_block_info *bi;
-		BUG_ON(item_size < sizeof(*ei) + sizeof(*bi));
+		if (unlikely(item_size < sizeof(*ei) + sizeof(*bi))) {
+			btrfs_crit(info,
+"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %lu",
+				   key.objectid, key.type, key.offset,
+				   owner_objectid, item_size,
+				   sizeof(*ei) + sizeof(*bi));
+			goto err_dump_abort;
+		}
 		bi = (struct btrfs_tree_block_info *)(ei + 1);
 		WARN_ON(owner_objectid != btrfs_tree_block_level(leaf, bi));
 	}
 
 	refs = btrfs_extent_refs(leaf, ei);
 	if (refs < refs_to_drop) {
-		btrfs_err(info,
-			  "trying to drop %d refs but we only have %Lu for bytenr %Lu",
+		btrfs_crit(info,
+		"trying to drop %d refs but we only have %Lu for bytenr %Lu",
 			  refs_to_drop, refs, bytenr);
-		ret = -EINVAL;
-		btrfs_abort_transaction(trans, ret);
-		goto out;
+		goto err_dump_abort;
 	}
 	refs -= refs_to_drop;
 
@@ -3102,7 +3178,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		 * be updated by remove_extent_backref
 		 */
 		if (iref) {
-			BUG_ON(!found_extent);
+			if (unlikely(!found_extent)) {
+				btrfs_crit(info,
+"invalid iref, got inlined extent ref but no EXTENT/METADATA_ITEM found");
+				goto err_dump_abort;
+			}
 		} else {
 			btrfs_set_extent_refs(leaf, ei, refs);
 			btrfs_mark_buffer_dirty(leaf);
@@ -3117,13 +3197,36 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 	} else {
+		/* In this branch refs == 1 */
 		if (found_extent) {
-			BUG_ON(is_data && refs_to_drop !=
-			       extent_data_ref_count(path, iref));
+			if (is_data && refs_to_drop !=
+			    extent_data_ref_count(path, iref)) {
+				btrfs_crit(info,
+		"invalid refs_to_drop, current refs %u refs_to_drop %u",
+					   extent_data_ref_count(path, iref),
+					   refs_to_drop);
+				goto err_dump_abort;
+			}
 			if (iref) {
-				BUG_ON(path->slots[0] != extent_slot);
+				if (path->slots[0] != extent_slot) {
+					btrfs_crit(info,
+"invalid iref, extent item key (%llu %u %llu) doesn't has wanted iref",
+						   key.objectid, key.type,
+						   key.offset);
+					goto err_dump_abort;
+				}
 			} else {
-				BUG_ON(path->slots[0] != extent_slot + 1);
+				/*
+				 * No inline ref, we must at SHARED_* item,
+				 * And it's single ref, it must be:
+				 * |	extent_slot	  ||extent_slot + 1|
+				 * [ EXTENT/METADATA_ITEM ][ SHARED_* ITEM ]
+				 */
+				if (path->slots[0] != extent_slot + 1) {
+					btrfs_crit(info,
+	"invalid SHARED_* item, previous item is not EXTENT/METADATA_ITEM");
+					goto err_dump_abort;
+				}
 				path->slots[0] = extent_slot;
 				num_to_del = 2;
 			}
@@ -3164,6 +3267,21 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(path);
 	return ret;
+err_dump_abort:
+	/*
+	 * Leaf dump can take up a lot of dmesg buffer since default nodesize
+	 * is already 16K.
+	 * So we only do full leaf dump for debug build.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+		btrfs_crit(info, "path->slots[0]=%d extent_slot=%d",
+			   path->slots[0], extent_slot);
+		btrfs_print_leaf(path->nodes[0]);
+	}
+
+	btrfs_abort_transaction(trans, -EUCLEAN);
+	btrfs_free_path(path);
+	return -EUCLEAN;
 }
 
 /*
-- 
2.28.0

