Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EB7269B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFGTZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjFGTYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84D1FDA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CC7639BC
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF55C433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165892;
        bh=1vGMwudYE5TbOgY4R2qIJRhrh5xmYyOVn2lF2VdmbO4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U4WAgtEraxn1HYfER5lth5u0c/hVb5IbLSzuRh+vjyF5QGIzUYB43iHpbiPbnQjjL
         qUiTfeICTsDLx7cSN5VRh4k6+rG3BcZ2HWgmr0mfVDWF78XvKM3jeqMnFzVrmQ63Ov
         4bUMo7JSqEUzzkuL6e6TVKv3EhueAXFKL+FE2RItVnyvlSRhNe1HaHlzqYMywAfTXQ
         8jVXEX0bhDxg/E8+BXZfBANxEC/6hFAqNuCK7erN9a5NlzR9bNsmI2PEQL+LozXegF
         66N8cjSqYTooS7IhCnLkvfyJC72HFTsAWdln60StH/du9UPLFhcxFVx9JKgnLRDL6l
         K5EcRGyptrmsQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/13] btrfs: do not BUG_ON() on tree mod log failures at insert_ptr()
Date:   Wed,  7 Jun 2023 20:24:36 +0100
Message-Id: <bd2831e141daa59bfba8b0dc24d839090b63d87f.1686164822.git.fdmanana@suse.com>
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

At insert_ptr(), instead of doing a BUG_ON() in case we fail to record
tree mod log operations, do a transaction abort and return the error to
the callers. There's really no need for the BUG_ON() as we can release all
resources in the context of all callers, and we have to abort because other
future tree searches that use the tree mod log (btrfs_search_old_slot())
may get inconsistent results if other operations modify the tree after
that failure and before the tree mod log based search.

This implies making insert_ptr() return an int instead of void, and making
all callers check for returned errors.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6e59343034d6..f1fa89ae1184 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2982,10 +2982,10 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
  * slot and level indicate where you want the key to go, and
  * blocknr is the block the key points to.
  */
-static void insert_ptr(struct btrfs_trans_handle *trans,
-		       struct btrfs_path *path,
-		       struct btrfs_disk_key *key, u64 bytenr,
-		       int slot, int level)
+static int insert_ptr(struct btrfs_trans_handle *trans,
+		      struct btrfs_path *path,
+		      struct btrfs_disk_key *key, u64 bytenr,
+		      int slot, int level)
 {
 	struct extent_buffer *lower;
 	int nritems;
@@ -3001,7 +3001,10 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 		if (level) {
 			ret = btrfs_tree_mod_log_insert_move(lower, slot + 1,
 					slot, nritems - slot);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 		}
 		memmove_extent_buffer(lower,
 			      btrfs_node_key_ptr_offset(lower, slot + 1),
@@ -3011,7 +3014,10 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 	if (level) {
 		ret = btrfs_tree_mod_log_insert_key(lower, slot,
 						    BTRFS_MOD_LOG_KEY_ADD);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 	btrfs_set_node_key(lower, key, slot);
 	btrfs_set_node_blockptr(lower, slot, bytenr);
@@ -3019,6 +3025,8 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 	btrfs_set_node_ptr_generation(lower, slot, trans->transid);
 	btrfs_set_header_nritems(lower, nritems + 1);
 	btrfs_mark_buffer_dirty(lower);
+
+	return 0;
 }
 
 /*
@@ -3098,8 +3106,13 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(c);
 	btrfs_mark_buffer_dirty(split);
 
-	insert_ptr(trans, path, &disk_key, split->start,
-		   path->slots[level + 1] + 1, level + 1);
+	ret = insert_ptr(trans, path, &disk_key, split->start,
+			 path->slots[level + 1] + 1, level + 1);
+	if (ret < 0) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
+		return ret;
+	}
 
 	if (path->slots[level] >= mid) {
 		path->slots[level] -= mid;
@@ -3576,16 +3589,17 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
  * split the path's leaf in two, making sure there is at least data_size
  * available for the resulting leaf level of the path.
  */
-static noinline void copy_for_split(struct btrfs_trans_handle *trans,
-				    struct btrfs_path *path,
-				    struct extent_buffer *l,
-				    struct extent_buffer *right,
-				    int slot, int mid, int nritems)
+static noinline int copy_for_split(struct btrfs_trans_handle *trans,
+				   struct btrfs_path *path,
+				   struct extent_buffer *l,
+				   struct extent_buffer *right,
+				   int slot, int mid, int nritems)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int data_copy_size;
 	int rt_data_off;
 	int i;
+	int ret;
 	struct btrfs_disk_key disk_key;
 	struct btrfs_map_token token;
 
@@ -3610,7 +3624,9 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 
 	btrfs_set_header_nritems(l, mid);
 	btrfs_item_key(right, &disk_key, 0);
-	insert_ptr(trans, path, &disk_key, right->start, path->slots[1] + 1, 1);
+	ret = insert_ptr(trans, path, &disk_key, right->start, path->slots[1] + 1, 1);
+	if (ret < 0)
+		return ret;
 
 	btrfs_mark_buffer_dirty(right);
 	btrfs_mark_buffer_dirty(l);
@@ -3628,6 +3644,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	}
 
 	BUG_ON(path->slots[0] < 0);
+
+	return 0;
 }
 
 /*
@@ -3826,8 +3844,13 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	if (split == 0) {
 		if (mid <= slot) {
 			btrfs_set_header_nritems(right, 0);
-			insert_ptr(trans, path, &disk_key,
-				   right->start, path->slots[1] + 1, 1);
+			ret = insert_ptr(trans, path, &disk_key,
+					 right->start, path->slots[1] + 1, 1);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				return ret;
+			}
 			btrfs_tree_unlock(path->nodes[0]);
 			free_extent_buffer(path->nodes[0]);
 			path->nodes[0] = right;
@@ -3835,8 +3858,13 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 			path->slots[1] += 1;
 		} else {
 			btrfs_set_header_nritems(right, 0);
-			insert_ptr(trans, path, &disk_key,
-				   right->start, path->slots[1], 1);
+			ret = insert_ptr(trans, path, &disk_key,
+					 right->start, path->slots[1], 1);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				return ret;
+			}
 			btrfs_tree_unlock(path->nodes[0]);
 			free_extent_buffer(path->nodes[0]);
 			path->nodes[0] = right;
@@ -3852,7 +3880,9 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	copy_for_split(trans, path, l, right, slot, mid, nritems);
+	ret = copy_for_split(trans, path, l, right, slot, mid, nritems);
+	if (ret < 0)
+		return ret;
 
 	if (split == 2) {
 		BUG_ON(num_doubles != 0);
-- 
2.34.1

