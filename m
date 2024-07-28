Return-Path: <linux-btrfs+bounces-6800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97893E2AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4829BB23D09
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DB12BEBE;
	Sun, 28 Jul 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OopgkabS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC57193096;
	Sun, 28 Jul 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128067; cv=none; b=dlR49j+buTBfw6/BERE91os5J2vnhGqFhYz+KNXot6wpEQOAfLiv0/R8nI4tAYRu+mgylcG61cES5Nw1J5DUEVvu/wJlN5qj8VNnQbM6RJnPAY1L0uJCGREJnHHeIFH1l/zY+0vhS8lUwfiabTaIKza6t1KHvNtgrfDYWe4L57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128067; c=relaxed/simple;
	bh=QFOGvERfL/hlSthVGWTVqwcjRe/8YVLlbFIBvlpLAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH1pRnwgubbE/z1yLCW0Sl+CUPnyB1XncTH9EemG8zuaZCbGI8cXdpQhHF88yG8Qtz7MUPIj1dACOhdv8gtzlz6rdkOnjKqetFL4tZDNBQz+ox6aeOuQRCkzQ7QPPYq7ZWxRtIjvUVo6zCBq0OufRlF0OAua2cS2ZpbQLs8QfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OopgkabS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B333AC4AF07;
	Sun, 28 Jul 2024 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128066;
	bh=QFOGvERfL/hlSthVGWTVqwcjRe/8YVLlbFIBvlpLAqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OopgkabSRkhofQ0QAdSsaWcq5Hh6ZXm6r/PFMWJM8eW5YrWKxzpvBuYJRjCw+ZbNO
	 VperRIOSzAqNN98ezS92xoaZxC/wwJtmcxbLAPfnBIPTHNjxjZXQuTDbYhjUu+mCtf
	 MbNl5XT+zxIr4ty9CTyiHw71aMNP+dGswvm7RO0/ud9uM2XwEIl8be6I5kM49qhLfO
	 yWHA3DnML3NwGnlqbfOgCXdxsXzHvR2Go9ojoARJ+1tZEmxL2zrT+wv7ZX0CHpv+G3
	 kIqekdQxstIO0NhljWEZagnaP5gSJTP/nYVAwdfj8OIwiwG/3ryf/TMN/LoKntcKbZ
	 Zp60cWx8ybI/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 22/27] btrfs: do not BUG_ON() when freeing tree block after error
Date: Sat, 27 Jul 2024 20:53:05 -0400
Message-ID: <20240728005329.1723272-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit bb3868033a4cccff7be57e9145f2117cbdc91c11 ]

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
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c           | 53 ++++++++++++++++++++++++++++++--------
 fs/btrfs/extent-tree.c     | 24 ++++++++++-------
 fs/btrfs/extent-tree.h     |  8 +++---
 fs/btrfs/free-space-tree.c | 10 ++++---
 fs/btrfs/ioctl.c           |  6 ++++-
 fs/btrfs/qgroup.c          |  6 +++--
 6 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a49b92329908..ca372068226d5 100644
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
@@ -2883,7 +2907,11 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
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
@@ -4452,9 +4480,12 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
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
index 3774c191e36dc..41db538e4959e 100644
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
@@ -5643,7 +5645,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret = 0;
 	int level = wc->level;
 	struct extent_buffer *eb = path->nodes[level];
 	u64 parent = 0;
@@ -5730,12 +5732,14 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
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
index af9f8800d5aca..2ad51130c037e 100644
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
index 90f2938bd743d..7ba50e133921a 100644
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
index efd5d6e9589e0..c1b0556e40368 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -719,6 +719,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
 	if (ret) {
+		int ret2;
+
 		/*
 		 * Since we don't abort the transaction in this case, free the
 		 * tree block so that we don't leak space and leave the
@@ -729,7 +731,9 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
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
index 39a15cca58ca9..29d6ca3b874ec 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1446,9 +1446,11 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clear_buffer_dirty(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
-			      quota_root->node, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
+				    quota_root->node, 0, 1);
 
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_put_root(quota_root);
-- 
2.43.0


