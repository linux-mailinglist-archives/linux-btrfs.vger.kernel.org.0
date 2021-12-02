Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC1466177
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356993AbhLBKeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356985AbhLBKeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E62C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 02:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D129B82219
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85696C00446
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441047;
        bh=FvoYpk+g3WC6lnf7SHkCyzcHU/We+QkiqLRltYHZHeQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fllKlrfiY4TodEo5tsDjAdmsEJ9LasP6C0RUiwfDJuZ4bq3P1A2JFuAxosPUznH71
         fSTSe+CfpqU7Ieek+6lTRhW0Ut5QMzHroyus3lP+lRVJy4sm+raGBzE+r89HffHj8t
         LL8e2DR6GTaR8mS7mbFjtYZtboozXe1PKaKLCePduPV3JHL7WDpJDkN2qBXMGGdeuy
         HsKa6TaRFkcxNoFlkRBLayx9tMnxhsqsuIoWOjPVAPfn2Ih9wB+7mwmwVG9Nh+EoRp
         AwpLMq/QhhVuIH9Q06vr8GRHGDGJ5R4eEt57qNRyBu1fohODRLIkr16BcBVv7sqeya
         69yHvjQ1uo1og==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: move leaf search logic out of btrfs_search_slot()
Date:   Thu,  2 Dec 2021 10:30:38 +0000
Message-Id: <adf3c7a943f6e053d87378f1ab0aa6e2e39d4ce3.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's quite a significant amount of code for doing the key search for a
leaf at btrfs_search_slot(), with a couple labels and gotos in it, plus
btrfs_search_slot() is already big enough.

So move the logic that does the key search on a leaf into a new helper
function. This makes it better organized, removing the need for the labels
and the gotos, as well as reducing the indentation level and the size of
btrfs_search_slot().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 244 +++++++++++++++++++++++++----------------------
 1 file changed, 128 insertions(+), 116 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 9439c8606835..15357274a0c4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1700,6 +1700,132 @@ static inline int search_for_key_slot(struct extent_buffer *eb,
 	return generic_bin_search(eb, search_low_slot, key, slot);
 }
 
+static int search_leaf(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root,
+		       const struct btrfs_key *key,
+		       struct btrfs_path *path,
+		       int ins_len,
+		       int prev_cmp)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	int leaf_free_space = -1;
+	int search_low_slot = 0;
+	int ret;
+	bool do_bin_search = true;
+
+	/*
+	 * If we are doing an insertion, the leaf has enough free space and the
+	 * destination slot for the key is not slot 0, then we can unlock our
+	 * write lock on the parent, and any other upper nodes, before doing the
+	 * binary search on the leaf (with search_for_key_slot()), allowing other
+	 * tasks to lock the parent and any other upper nodes.
+	 */
+	if (ins_len > 0) {
+		/*
+		 * Cache the leaf free space, since we will need it later and it
+		 * will not change until then.
+		 */
+		leaf_free_space = btrfs_leaf_free_space(leaf);
+
+		/*
+		 * !path->locks[1] means we have a single node tree, the leaf is
+		 * the root of the tree.
+		 */
+		if (path->locks[1] && leaf_free_space >= ins_len) {
+			struct btrfs_disk_key first_key;
+
+			ASSERT(btrfs_header_nritems(leaf) > 0);
+			btrfs_item_key(leaf, &first_key, 0);
+
+			/*
+			 * Doing the extra comparison with the first key is cheap,
+			 * taking into account that the first key is very likely
+			 * already in a cache line because it immediattely follows
+			 * the extent buffer's header and we have recently accessed
+			 * the header's level field.
+			 */
+			ret = comp_keys(&first_key, key);
+			if (ret < 0) {
+				/*
+				 * The first key is smaller than the key we want
+				 * to insert, so we are safe to unlock all upper
+				 * nodes and we have to do the binary search.
+				 *
+				 * We do use btrfs_unlock_up_safe() and not
+				 * unlock_up() because the later does not unlock
+				 * nodes with a slot of 0 - we can safely unlock
+				 * any node even if its slot is 0 since in this
+				 * case the key does not end up at slot 0 of the
+				 * leaf and there's no need to split the leaf.
+				 */
+				btrfs_unlock_up_safe(path, 1);
+				search_low_slot = 1;
+			} else {
+				/*
+				 * The first key is >= then the key we want to
+				 * insert, so we can skip the binary search as
+				 * the target key will be at slot 0.
+				 *
+				 * We can not unlock upper nodes when the key is
+				 * less than the first key, because we will need
+				 * to update the key at slot 0 of the parent node
+				 * and possibly of other upper nodes too.
+				 * If the key matches the first key, then we can
+				 * unlock all the upper nodes, using
+				 * btrfs_unlock_up_safe() instead of unlock_up()
+				 * as stated above.
+				 */
+				if (ret == 0)
+					btrfs_unlock_up_safe(path, 1);
+				/*
+				 * ret is already 0 or 1, matching the result of
+				 * a btrfs_bin_search() call, so there is no need
+				 * to adjust it.
+				 */
+				do_bin_search = false;
+				path->slots[0] = 0;
+			}
+		}
+	}
+
+	if (do_bin_search) {
+		ret = search_for_key_slot(leaf, search_low_slot, key,
+					  prev_cmp, &path->slots[0]);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (ins_len > 0) {
+		/*
+		 * Item key already exists. In this case, if we are allowed to
+		 * insert the item (for example, in dir_item case, item key
+		 * collision is allowed), it will be merged with the original
+		 * item. Only the item size grows, no new btrfs item will be
+		 * added. If search_for_extension is not set, ins_len already
+		 * accounts the size btrfs_item, deduct it here so leaf space
+		 * check will be correct.
+		 */
+		if (ret == 0 && !path->search_for_extension) {
+			ASSERT(ins_len >= sizeof(struct btrfs_item));
+			ins_len -= sizeof(struct btrfs_item);
+		}
+
+		ASSERT(leaf_free_space >= 0);
+
+		if (leaf_free_space < ins_len) {
+			int err;
+
+			err = split_leaf(trans, root, key, path, ins_len,
+					 (ret == 0));
+			BUG_ON(err > 0);
+			if (err)
+				ret = err;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * btrfs_search_slot - look for a key in a tree and perform necessary
  * modifications to preserve tree invariants.
@@ -1861,124 +1987,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		if (level == 0) {
-			int leaf_free_space = 0;
-			int search_low_slot = 0;
-
-			/*
-			 * If we are doing an insertion, the leaf has enough free
-			 * space and the destination slot for the key is not slot
-			 * 0, then we can unlock our write lock on the parent, and
-			 * any other upper nodes, before doing the binary search
-			 * on the leaf (with search_for_key_slot()), allowing other
-			 * tasks to lock the parent and any other upper nodes.
-			 */
-			if (ins_len > 0) {
-				struct btrfs_disk_key first_key;
-
-				/*
-				 * Cache the leaf free space, since we will need it
-				 * later and it will not change until then.
-				 */
-				leaf_free_space = btrfs_leaf_free_space(b);
-
-				/*
-				 * !p->locks[1] means we have a single node tree,
-				 * the leaf is the root of the tree.
-				 */
-				if (!p->locks[1] || leaf_free_space < ins_len)
-					goto leaf_search;
-
-				ASSERT(btrfs_header_nritems(b) > 0);
-				btrfs_item_key(b, &first_key, 0);
-
-				/*
-				 * Doing the extra comparison with the first key
-				 * is cheap, taking into account that the first
-				 * key is very likely already in a cache line
-				 * because it immediattely follows the extent
-				 * buffer's header and we have recently accessed
-				 * the header's level field.
-				 */
-				ret = comp_keys(&first_key, key);
-				if (ret < 0) {
-					/*
-					 * The first key is smaller than the key
-					 * we want to insert, so we are safe to
-					 * unlock all upper nodes and we have to
-					 * do the binary search.
-					 *
-					 * We do use btrfs_unlock_up_safe() and
-					 * not unlock_up() because the later does
-					 * not unlock nodes with a slot of 0.
-					 * We can safely unlock any node even if
-					 * its slot is 0 since in this case the
-					 * key does not end up at slot 0 of the
-					 * leaf and there's also no need to split
-					 * the leaf.
-					 */
-					btrfs_unlock_up_safe(p, 1);
-					search_low_slot = 1;
-				} else {
-					/*
-					 * The first key is >= then the key we
-					 * want to insert, so we can skip the
-					 * binary search as the target key will
-					 * be at slot 0.
-					 *
-					 * We can not unlock upper nodes when
-					 * the key is less than the first key,
-					 * because we will need to update the key
-					 * at slot 0 of the parent node and
-					 * possibly of other upper nodes too.
-					 * If the key matches the first key, then
-					 * we can unlock all the upper nodes,
-					 * using btrfs_unlock_up_safe() instead
-					 * of unlock_up() as stated above.
-					 */
-					if (ret == 0)
-						btrfs_unlock_up_safe(p, 1);
-					slot = 0;
-					/*
-					 * ret is already 0 or 1, matching the
-					 * result of a btrfs_bin_search() call,
-					 * so there is no need to adjust it.
-					 */
-					goto skip_leaf_search;
-				}
-			}
-leaf_search:
-			ret = search_for_key_slot(b, search_low_slot, key,
-						  prev_cmp, &slot);
-			if (ret < 0)
-				goto done;
-skip_leaf_search:
-			p->slots[level] = slot;
-			/*
-			 * Item key already exists. In this case, if we are
-			 * allowed to insert the item (for example, in dir_item
-			 * case, item key collision is allowed), it will be
-			 * merged with the original item. Only the item size
-			 * grows, no new btrfs item will be added. If
-			 * search_for_extension is not set, ins_len already
-			 * accounts the size btrfs_item, deduct it here so leaf
-			 * space check will be correct.
-			 */
-			if (ret == 0 && ins_len > 0 && !p->search_for_extension) {
-				ASSERT(ins_len >= sizeof(struct btrfs_item));
-				ins_len -= sizeof(struct btrfs_item);
-			}
-			if (ins_len > 0 && leaf_free_space < ins_len) {
+			if (ins_len > 0)
 				ASSERT(write_lock_level >= 1);
 
-				err = split_leaf(trans, root, key,
-						 p, ins_len, ret == 0);
-
-				BUG_ON(err > 0);
-				if (err) {
-					ret = err;
-					goto done;
-				}
-			}
+			ret = search_leaf(trans, root, key, p, ins_len, prev_cmp);
 			if (!p->search_for_split)
 				unlock_up(p, level, lowest_unlock,
 					  min_write_lock_level, NULL);
-- 
2.33.0

