Return-Path: <linux-btrfs+bounces-5739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C40908D16
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB32A1F246C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899DBA50;
	Fri, 14 Jun 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+hcUQV7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A38489
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374493; cv=none; b=f4+9YIWVoKtnne+ioUSFQkrTgeJQK+Xc8U7Sm6Cy5/cTDe8vkoFOOG8RMKX99PZ3Uzr6zOmovx0VrOL16TjAzUc/sXWlcDgA+DyFW2sQ3nOtZg/22KqiTSKRlUY8KyhRAsS0+kNpeNDCfspRgm1GeVz7/FmDbZ5lHRRWUjaPK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374493; c=relaxed/simple;
	bh=jUN/XCCKCcW/4dsNGd9BEPjg0LTy3vb+OiIba7WvlfQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MQ5ey3TjAdM4miD3HCMJhVFkPQsh3E5CeeqNw7qgLOsvnZCmceAoX5x3SGlde4BLAVQ0fC0gB96VE+CQK9WoHVqQqHDm/XUIPZtws4JJkYU8nutrfSDKg7QcJ/Se8jHUhB5xmb6MEGBZIeGpdI76VERGp7PDI8kD5Fysr6KTkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+hcUQV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9BBC2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718374493;
	bh=jUN/XCCKCcW/4dsNGd9BEPjg0LTy3vb+OiIba7WvlfQ=;
	h=From:To:Subject:Date:From;
	b=d+hcUQV7ZYstMm6UlGuDamOKvXO5FuP1FiE/jmDhFcY55K/xeDUjp0Oz31/Qh+vvJ
	 2W27eUTA9VJXjnTDRIAdOyjGYOKVxSyzvoGkg6nPcL6OCOoQ47bi56CUAk0YfU2fZd
	 y3r9jTDnbrAV/XhCANT9VxO6LbW2+sdRZxfQM0iAGY50aIgX7kEA0KYA6x5X7XGH89
	 cA0aa47FHzzYVxTnui6NHTVr9VjHCHHqtCbP8KUIWMw5tXOaMjONziGXPD7SsNzdg5
	 MERRZ0ivquZwI1uFrihVqV6L9qrMQDE5RO68ZGSW/Q5iWqyQI6/aoUPxWUcBVbz0Gx
	 jDMAVjqwDdiGw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON() when freeing tree block after error
Date: Fri, 14 Jun 2024 15:14:46 +0100
Message-Id: <eeb993f33bd03c3aff2b4ec7d6f4385dbc601d84.1718374143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When freeing a tree block, at btrfs_free_tree_block(), if we fail to
create a delayed reference we don't deal with the error and just do a
BUG_ON(). The error most likely to happen is -ENOMEM, and we have a
comment mentioning that only -ENOMEM can happen, but that is not true,
because in case qgroups are enabled any error returned from
btrfs_qgroup_trace_extent_post() (can be -EUCLEAN or anything returned
from btrfs_search_slot() for example) can be propagated back to
btrfs_free_tree_block().

So stop doing a BUG_ON() and return the error to the callers and make
them abort the transaction to prevent leaking space. Syzbot was
triggering this, likely due to memory allocation failure injection.

Reported-by: syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000fcba1e05e998263c@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c           | 53 ++++++++++++++++++++++++++++++--------
 fs/btrfs/extent-tree.c     | 24 ++++++++++-------
 fs/btrfs/extent-tree.h     |  8 +++---
 fs/btrfs/free-space-tree.c | 10 ++++---
 fs/btrfs/ioctl.c           |  6 ++++-
 fs/btrfs/qgroup.c          |  7 ++---
 6 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 48aa14046343..a155dbc0bffa 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -620,10 +620,16 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
@@ -648,8 +654,14 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 				return ret;
 			}
 		}
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
@@ -983,9 +995,13 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		free_extent_buffer(mid);
 
 		root_sub_used_bytes(root);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 		return 0;
 	}
 	if (btrfs_header_nritems(mid) >
@@ -1053,10 +1069,14 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			root_sub_used_bytes(root);
-			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
-					      0, 1);
+			ret = btrfs_free_tree_block(trans, btrfs_root_id(root),
+						    right, 0, 1);
 			free_extent_buffer_stale(right);
 			right = NULL;
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		} else {
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
@@ -1111,9 +1131,13 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 		root_sub_used_bytes(root);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	} else {
 		/* update the parent key to reflect our changes */
 		struct btrfs_disk_key mid_key;
@@ -2878,7 +2902,11 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	old = root->node;
 	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
 	if (ret < 0) {
-		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		int ret2;
+
+		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		btrfs_tree_unlock(c);
 		free_extent_buffer(c);
 		return ret;
@@ -4447,9 +4475,12 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	root_sub_used_bytes(root);
 
 	atomic_inc(&leaf->refs);
-	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
-	return 0;
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+
+	return ret;
 }
 /*
  * delete the item at the leaf level in path.  If that empties
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index eda424192164..58a72a57414a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3419,10 +3419,10 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref)
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *bg;
@@ -3449,11 +3449,12 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf), 0, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret < 0)
+			return ret;
 	}
 
 	if (!last_ref)
-		return;
+		return 0;
 
 	if (btrfs_header_generation(buf) != trans->transid)
 		goto out;
@@ -3510,6 +3511,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	 * matter anymore.
 	 */
 	clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
+	return 0;
 }
 
 /* Can return -ENOMEM */
@@ -5754,7 +5756,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret = 0;
 	int level = wc->level;
 	struct extent_buffer *eb = path->nodes[level];
 	u64 parent = 0;
@@ -5849,12 +5851,14 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			goto owner_mismatch;
 	}
 
-	btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
-			      wc->refs[level] == 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
+				    wc->refs[level] == 1);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 out:
 	wc->refs[level] = 0;
 	wc->flags[level] = 0;
-	return 0;
+	return ret;
 
 owner_mismatch:
 	btrfs_err_rl(fs_info, "unexpected tree owner, have %llu expect %llu",
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index af9f8800d5ac..2ad51130c037 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -127,10 +127,10 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     u64 empty_size,
 					     u64 reloc_src_root,
 					     enum btrfs_lock_nesting nest);
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref);
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref);
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root, u64 owner,
 				     u64 offset, u64 ram_bytes,
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 90f2938bd743..7ba50e133921 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1300,10 +1300,14 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(free_space_root->node);
 	btrfs_clear_buffer_dirty(trans, free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
-			      free_space_root->node, 0, 1);
-
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
+				    free_space_root->node, 0, 1);
 	btrfs_put_root(free_space_root);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	return btrfs_commit_transaction(trans);
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 06447ee6d7ce..d28ebabe3720 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -714,6 +714,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
 	if (ret) {
+		int ret2;
+
 		/*
 		 * Since we don't abort the transaction in this case, free the
 		 * tree block so that we don't leak space and leave the
@@ -724,7 +726,9 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		btrfs_tree_lock(leaf);
 		btrfs_clear_buffer_dirty(trans, leaf);
 		btrfs_tree_unlock(leaf);
-		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		ret2 = btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		free_extent_buffer(leaf);
 		goto out;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index dfe79534139e..3edbe5bb19c6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1441,9 +1441,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clear_buffer_dirty(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
-			      quota_root->node, 0, 1);
-
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
+				    quota_root->node, 0, 1);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 	btrfs_put_root(quota_root);
 
 out:
-- 
2.43.0


