Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6B1554DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGJjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:39:13 -0500
Received: from mail.synology.com ([211.23.38.101]:60882 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGJjM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:12 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581068350; bh=kYzqRcvrE0dZjUBIGqWukkMstMlgohVbSXpdH9J5Tas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mlf78lb/p9PxnNQ+bY3A/kuT1087jFL33zZL1eIUbx3lJpYu8yV1Lc1l8kw0Iv0QL
         u8V5z3SY6ecd3+0fIDJJV/HRgXKKFWvL13WSwF5voWo6OBZArNcPe25z02bf4wH0YL
         B5PJrLDAP2qhJ/9BoCUO1hXggz4PykFpasqd/p9w=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH 4/4] btrfs: backref, use correct count to resolve normal data refs
Date:   Fri,  7 Feb 2020 17:38:18 +0800
Message-Id: <20200207093818.23710-5-ethanwu@synology.com>
In-Reply-To: <20200207093818.23710-1-ethanwu@synology.com>
References: <20200207093818.23710-1-ethanwu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the following patches:
btrfs: backref, only collect file extent items matching backref offset
btrfs: backref, not adding refs from shared block when resolving normal backref
btrfs: backref, only search backref entries from leaves of the same root

we only collect the normal data refs we want, so the imprecise
upper bound total_refs of that EXTENT_ITEM could now be changed
to the count of the normal backref entry we want to search.

Signed-off-by: ethanwu <ethanwu@synology.com>
---
 fs/btrfs/backref.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 7e2e647ec846..46cd6ed1a016 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -415,7 +415,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			   struct ulist *parents,
 			   struct preftrees *preftrees, struct prelim_ref *ref,
 			   int level, u64 time_seq, const u64 *extent_item_pos,
-			   u64 total_refs, bool ignore_offset)
+			   bool ignore_offset)
 {
 	int ret = 0;
 	int slot;
@@ -456,7 +456,7 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			ret = btrfs_next_old_leaf(root, path, time_seq);
 	}
 
-	while (!ret && count < total_refs) {
+	while (!ret && count < ref->count) {
 		eb = path->nodes[0];
 		slot = path->slots[0];
 
@@ -533,8 +533,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, u64 time_seq,
 				struct preftrees *preftrees,
 				struct prelim_ref *ref, struct ulist *parents,
-				const u64 *extent_item_pos, u64 total_refs,
-				bool ignore_offset)
+				const u64 *extent_item_pos, bool ignore_offset)
 {
 	struct btrfs_root *root;
 	struct btrfs_key root_key;
@@ -626,7 +625,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = add_all_parents(root, path, parents, preftrees, ref, level,
-			      time_seq, extent_item_pos, total_refs, ignore_offset);
+			      time_seq, extent_item_pos, ignore_offset);
 out:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
@@ -660,7 +659,7 @@ unode_aux_to_inode_list(struct ulist_node *node)
 static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 				 struct btrfs_path *path, u64 time_seq,
 				 struct preftrees *preftrees,
-				 const u64 *extent_item_pos, u64 total_refs,
+				 const u64 *extent_item_pos,
 				 struct share_check *sc, bool ignore_offset)
 {
 	int err;
@@ -706,7 +705,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 		}
 		err = resolve_indirect_ref(fs_info, path, time_seq, preftrees,
 					   ref, parents, extent_item_pos,
-					   total_refs, ignore_offset);
+					   ignore_offset);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
 		 * and return directly.
@@ -809,8 +808,7 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
  */
 static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			    struct btrfs_delayed_ref_head *head, u64 seq,
-			    struct preftrees *preftrees, u64 *total_refs,
-			    struct share_check *sc)
+			    struct preftrees *preftrees, struct share_check *sc)
 {
 	struct btrfs_delayed_ref_node *node;
 	struct btrfs_delayed_extent_op *extent_op = head->extent_op;
@@ -844,7 +842,6 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 		default:
 			BUG();
 		}
-		*total_refs += count;
 		switch (node->type) {
 		case BTRFS_TREE_BLOCK_REF_KEY: {
 			/* NORMAL INDIRECT METADATA backref */
@@ -927,7 +924,7 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			   struct btrfs_path *path, u64 bytenr,
 			   int *info_level, struct preftrees *preftrees,
-			   u64 *total_refs, struct share_check *sc)
+			   struct share_check *sc)
 {
 	int ret = 0;
 	int slot;
@@ -951,7 +948,6 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 	flags = btrfs_extent_flags(leaf, ei);
-	*total_refs += btrfs_extent_refs(leaf, ei);
 	btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 	ptr = (unsigned long)(ei + 1);
@@ -1176,8 +1172,6 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	struct prelim_ref *ref;
 	struct rb_node *node;
 	struct extent_inode_elem *eie = NULL;
-	/* total of both direct AND indirect refs! */
-	u64 total_refs = 0;
 	struct preftrees preftrees = {
 		.direct = PREFTREE_INIT,
 		.indirect = PREFTREE_INIT,
@@ -1246,7 +1240,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			}
 			spin_unlock(&delayed_refs->lock);
 			ret = add_delayed_refs(fs_info, head, time_seq,
-					       &preftrees, &total_refs, sc);
+					       &preftrees, sc);
 			mutex_unlock(&head->mutex);
 			if (ret)
 				goto out;
@@ -1267,8 +1261,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		    (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		     key.type == BTRFS_METADATA_ITEM_KEY)) {
 			ret = add_inline_refs(fs_info, path, bytenr,
-					      &info_level, &preftrees,
-					      &total_refs, sc);
+					      &info_level, &preftrees, sc);
 			if (ret)
 				goto out;
 			ret = add_keyed_refs(fs_info, path, bytenr, info_level,
@@ -1287,7 +1280,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root));
 
 	ret = resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
-				    extent_item_pos, total_refs, sc, ignore_offset);
+				    extent_item_pos, sc, ignore_offset);
 	if (ret)
 		goto out;
 
-- 
2.17.1

