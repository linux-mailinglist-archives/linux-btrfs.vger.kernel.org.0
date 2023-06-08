Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1098D727CCC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjFHK2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjFHK2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413541FFA
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2201464BED
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A2C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220085;
        bh=17EQX+yCZTeHNIWaHAZTlycKIuRI/POEayqZUFLiBak=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jKkMyoVuhfEo3tTWT9bPUbFF9C3ySduesLdGrebqU+77dU0P+QrXcw9sN/y73n5z3
         NAoZoRY0vr9HjAMsWcg4CxyYIG+JSzMUjbYVhZAQU3mc0exAkZdwI094pxbH1KAOdf
         NZP8jwumj+LUlwek88y2CkMBc/y1gBRAaqWYivXnYcJc3D9va3NvM8F+xaHHJrfheE
         LhqmcQyKlt6ajUgkRWY+3vX1Vhwfv7QZDsfebTO7+ezWp1i0XpYiaGr86qLor5bQRt
         RDzhFZlIBWCVbRErWWIvwwv1OENJ1LTXh5bgaUc2DM1umWW4TSpJKslL0iJofzpS6R
         MbPxukivNLA3w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/13] btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()
Date:   Thu,  8 Jun 2023 11:27:49 +0100
Message-Id: <a48727b926b88fc790a90c8e69008d4d87035ea6.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_del_ptr(), instead of doing a BUG_ON() in case we fail to record
tree mod log operations, do a transaction abort and return the error to
the callers. There's really no need for the BUG_ON() as we can release all
resources in the context of all callers, and we have to abort because other
future tree searches that use the tree mod log (btrfs_search_old_slot())
may get inconsistent results if other operations modify the tree after
that failure and before the tree mod log based search.

This implies btrfs_del_ptr() return an int instead of void, and making all
callers check for returned errors.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 52 ++++++++++++++++++++++++++++++++++++------------
 fs/btrfs/ctree.h |  4 ++--
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0188cf6e30bf..29c5fa252eb1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1139,7 +1139,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (btrfs_header_nritems(right) == 0) {
 			btrfs_clear_buffer_dirty(trans, right);
 			btrfs_tree_unlock(right);
-			btrfs_del_ptr(root, path, level + 1, pslot + 1);
+			ret = btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
+			if (ret < 0) {
+				free_extent_buffer_stale(right);
+				right = NULL;
+				goto out;
+			}
 			root_sub_used(root, right->len);
 			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
@@ -1192,7 +1197,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (btrfs_header_nritems(mid) == 0) {
 		btrfs_clear_buffer_dirty(trans, mid);
 		btrfs_tree_unlock(mid);
-		btrfs_del_ptr(root, path, level + 1, pslot);
+		ret = btrfs_del_ptr(trans, root, path, level + 1, pslot);
+		if (ret < 0) {
+			free_extent_buffer_stale(mid);
+			mid = NULL;
+			goto out;
+		}
 		root_sub_used(root, mid->len);
 		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
@@ -4440,8 +4450,8 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
  *
  * This is exported for use inside btrfs-progs, don't un-export it.
  */
-void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
-		   int slot)
+int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct btrfs_path *path, int level, int slot)
 {
 	struct extent_buffer *parent = path->nodes[level];
 	u32 nritems;
@@ -4452,7 +4462,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
 		if (level) {
 			ret = btrfs_tree_mod_log_insert_move(parent, slot,
 					slot + 1, nritems - slot - 1);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 		}
 		memmove_extent_buffer(parent,
 			      btrfs_node_key_ptr_offset(parent, slot),
@@ -4462,7 +4475,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
 	} else if (level) {
 		ret = btrfs_tree_mod_log_insert_key(parent, slot,
 						    BTRFS_MOD_LOG_KEY_REMOVE);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 
 	nritems--;
@@ -4478,6 +4494,7 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
+	return 0;
 }
 
 /*
@@ -4490,13 +4507,17 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
  * The path must have already been setup for deleting the leaf, including
  * all the proper balancing.  path->nodes[1] must be locked.
  */
-static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
-				    struct btrfs_root *root,
-				    struct btrfs_path *path,
-				    struct extent_buffer *leaf)
+static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
+				   struct btrfs_root *root,
+				   struct btrfs_path *path,
+				   struct extent_buffer *leaf)
 {
+	int ret;
+
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	btrfs_del_ptr(root, path, 1, path->slots[1]);
+	ret = btrfs_del_ptr(trans, root, path, 1, path->slots[1]);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * btrfs_free_extent is expensive, we want to make sure we
@@ -4509,6 +4530,7 @@ static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	atomic_inc(&leaf->refs);
 	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
+	return 0;
 }
 /*
  * delete the item at the leaf level in path.  If that empties
@@ -4558,7 +4580,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_header_level(leaf, 0);
 		} else {
 			btrfs_clear_buffer_dirty(trans, leaf);
-			btrfs_del_leaf(trans, root, path, leaf);
+			ret = btrfs_del_leaf(trans, root, path, leaf);
+			if (ret < 0)
+				return ret;
 		}
 	} else {
 		int used = leaf_space_used(leaf, 0, nritems);
@@ -4619,7 +4643,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 			if (btrfs_header_nritems(leaf) == 0) {
 				path->slots[1] = slot;
-				btrfs_del_leaf(trans, root, path, leaf);
+				ret = btrfs_del_leaf(trans, root, path, leaf);
+				if (ret < 0)
+					return ret;
 				free_extent_buffer(leaf);
 				ret = 0;
 			} else {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5af61480dde6..f2d2b313bde5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -541,8 +541,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
 int btrfs_block_can_be_shared(struct btrfs_root *root,
 			      struct extent_buffer *buf);
-void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
-		   int slot);
+int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct btrfs_path *path, int level, int slot);
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
-- 
2.34.1

