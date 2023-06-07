Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA007269B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjFGTZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjFGTYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136671FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B2D636CF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DEC4339B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165893;
        bh=rjUCCV1HaWN7sBC6U0UU4EZ6j/mOoXuFkg4EabJzqEs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XmEG3QFS+w2W5hxZO8y0nLhrXqJwevJ54McR7GLq51hvphmuNTJWv5qkRWOsPvh8e
         xA4ft9TniYE/ByM6hW5oZsEX6jnAwfUH9OysQQCKetM6F2JjiRLwPbpenUql7sHNOx
         5gmfArdrOFRBhEdISAqPLvsIOA+ImrHS/Nn9wTWesCqIug0fw3OgBDz0wFkaPgw7L2
         R4yxBfcdp/Pf9FM8/serh2d01yKrAIVnSAPs2DQWjFFXMp9TNdw1pUnwAT77Kc9EqI
         Xll+TgUIN6Ti4HyqJfchtTh/p6XRceFPJ99G3X1/vgzL01GKOGUurAmo6nQo/1zjJZ
         PeSHOBRMaNQjA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/13] btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()
Date:   Wed,  7 Jun 2023 20:24:37 +0100
Message-Id: <7890b37a787a3dd59a6eadf0ae78092c46a7f9ca.1686164823.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 fs/btrfs/ctree.c | 46 +++++++++++++++++++++++++++++++++-------------
 fs/btrfs/ctree.h |  4 ++--
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f1fa89ae1184..7220c8736218 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1135,7 +1135,9 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (btrfs_header_nritems(right) == 0) {
 			btrfs_clear_buffer_dirty(trans, right);
 			btrfs_tree_unlock(right);
-			btrfs_del_ptr(root, path, level + 1, pslot + 1);
+			ret = btrfs_del_ptr(trans, root, path, level + 1, pslot + 1);
+			if (ret < 0)
+				goto out;
 			root_sub_used(root, right->len);
 			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
@@ -1184,7 +1186,9 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (btrfs_header_nritems(mid) == 0) {
 		btrfs_clear_buffer_dirty(trans, mid);
 		btrfs_tree_unlock(mid);
-		btrfs_del_ptr(root, path, level + 1, pslot);
+		ret = btrfs_del_ptr(trans, root, path, level + 1, pslot);
+		if (ret < 0)
+			goto out;
 		root_sub_used(root, mid->len);
 		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
@@ -4429,8 +4433,8 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
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
@@ -4441,7 +4445,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
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
@@ -4451,7 +4458,10 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
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
@@ -4467,6 +4477,7 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
 		fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
+	return 0;
 }
 
 /*
@@ -4479,13 +4490,17 @@ void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
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
@@ -4498,6 +4513,7 @@ static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	atomic_inc(&leaf->refs);
 	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
+	return 0;
 }
 /*
  * delete the item at the leaf level in path.  If that empties
@@ -4547,7 +4563,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
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
@@ -4608,7 +4626,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
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

