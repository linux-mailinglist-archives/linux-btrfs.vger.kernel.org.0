Return-Path: <linux-btrfs+bounces-18997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F228C5E48C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 070DF4F6AA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007D32ED2C;
	Fri, 14 Nov 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzotxUnu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147932E73B
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136694; cv=none; b=CTqiuu1V/WhOpDg8MzUqJ2KBsa0SHCJlNk5JX4rz3D4v64x/2kNIOuyPpcDtQBFs/1aOzw7ywrPvr3zsQkdPO+Szktn5nnsGDfmVw3cbvDcjqW1lm5ygbGhHWvmbJ2ImLel3+pFLOspaUp3zRKKHtUl4fX+OBxvTMwImlLYCIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136694; c=relaxed/simple;
	bh=QnzjOi+8tiKSZUCqDQt+6jMN0gtC1FqGWjuzh/jyK18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TAA+G98HdhTi7TUaN/wmn21qhowRCzOxpGE/I9B/bJCTO7Zz9a7tPSW1ZBdXWL2DFRHQBTrTkTg8SfkFF6mrdZ3deXPTJQRzNzCVgHXBS5NK7V5X1US9dXlgeB6tgENoSxrqZVM/Avbdrxl8KNB0VcSMaW9sEBuyF8KgU+EQK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzotxUnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA74C19421
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136693;
	bh=QnzjOi+8tiKSZUCqDQt+6jMN0gtC1FqGWjuzh/jyK18=;
	h=From:To:Subject:Date:From;
	b=EzotxUnuHPQ54cw3TGLuTRLivtP+bY8wC/r/ObD2pfeV5KHiQLKYeoD+rp9vfmX2Q
	 IOzpXGWcS2c3Zb49IJS0i6mFIHPTVO6rYQAl3yZbIMokyRnr2SLq8UeZf9QHwovQ5s
	 NSGKlYpOdXeUpAmT36TeDdxTf7DGBZGG0uWS/+w1XXb14vsCralAnRnSqPIegDdgIL
	 ScS/eXScV5TftK4yfSmoja/1Cngr2WOsmEmfnMSaRXg8sgvzeW/gpCi33aL1NzZa9I
	 jSn74fCzoQbTaAisfsiE1MGI1he1iD6XwyuvQQLQDsLeCyxmFVI8YIQv/aaKz4MglL
	 761OLeXu+5UTA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use bool type for btrfs_path members used as booleans
Date: Fri, 14 Nov 2025 16:11:29 +0000
Message-ID: <3a03fb6e8f1d35902220f7e8b7b3d0167f6f1bb2.1763136628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Many fields of struct btrfs_path are used as booleans but their type is
an unsigned int (of one 1 bit width to save space). Change the type to
bool keeping the :1 suffix so that they combine with the previous u8
fields in order to save space. This makes the code more clear by using
explicit true/false and more in line with the preferred style, preserving
the size of the structure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c          | 16 ++++++++--------
 fs/btrfs/block-group.c      |  8 ++++----
 fs/btrfs/ctree.c            | 28 ++++++++++++++--------------
 fs/btrfs/ctree.h            | 16 ++++++++--------
 fs/btrfs/defrag.c           |  4 ++--
 fs/btrfs/dev-replace.c      |  4 ++--
 fs/btrfs/extent-tree.c      |  8 ++++----
 fs/btrfs/file-item.c        | 12 ++++++------
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/free-space-tree.c  |  4 ++--
 fs/btrfs/inode-item.c       |  2 +-
 fs/btrfs/inode.c            |  4 ++--
 fs/btrfs/qgroup.c           |  4 ++--
 fs/btrfs/raid-stripe-tree.c |  4 ++--
 fs/btrfs/relocation.c       |  8 ++++----
 fs/btrfs/scrub.c            | 20 ++++++++++----------
 fs/btrfs/send.c             | 14 +++++++-------
 fs/btrfs/tree-log.c         | 20 ++++++++++----------
 fs/btrfs/volumes.c          |  6 +++---
 fs/btrfs/xattr.c            |  2 +-
 20 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index eff2d388a706..78da47a3d00e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1408,12 +1408,12 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 	if (!path)
 		return -ENOMEM;
 	if (!ctx->trans) {
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path->search_commit_root = true;
+		path->skip_locking = true;
 	}
 
 	if (ctx->time_seq == BTRFS_SEQ_LAST)
-		path->skip_locking = 1;
+		path->skip_locking = true;
 
 again:
 	head = NULL;
@@ -1560,7 +1560,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 
 	btrfs_release_path(path);
 
-	ret = add_missing_keys(ctx->fs_info, &preftrees, path->skip_locking == 0);
+	ret = add_missing_keys(ctx->fs_info, &preftrees, !path->skip_locking);
 	if (ret)
 		goto out;
 
@@ -2825,8 +2825,8 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_inf
 	}
 
 	/* Current backref iterator only supports iteration in commit root */
-	ret->path->search_commit_root = 1;
-	ret->path->skip_locking = 1;
+	ret->path->search_commit_root = true;
+	ret->path->skip_locking = true;
 	ret->fs_info = fs_info;
 
 	return ret;
@@ -3299,8 +3299,8 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 	level = cur->level + 1;
 
 	/* Search the tree to find parent blocks referring to the block */
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 	path->lowest_level = level;
 	ret = btrfs_search_slot(NULL, root, tree_key, path, 0, 0);
 	path->lowest_level = 0;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b964eacc1610..ebbf04501782 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -613,8 +613,8 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
 						       BTRFS_SUPER_INFO_OFFSET));
 
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
+	path->skip_locking = true;
+	path->search_commit_root = true;
 	path->reada = READA_FORWARD;
 
 	search_offset = index * div_u64(block_group->length, max_index);
@@ -744,8 +744,8 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	 * root to add free space.  So we skip locking and search the commit
 	 * root, since its read-only
 	 */
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
+	path->skip_locking = true;
+	path->search_commit_root = true;
 	path->reada = READA_FORWARD;
 
 	key.objectid = last;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 46262939e873..51dc8e0bc9c1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1709,9 +1709,9 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
-		 * p->search_commit_root = 1.
+		 * p->search_commit_root is true.
 		 */
-		ASSERT(p->skip_locking == 1);
+		ASSERT(p->skip_locking);
 
 		goto out;
 	}
@@ -3860,10 +3860,10 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
-	path->keep_locks = 1;
-	path->search_for_split = 1;
+	path->keep_locks = true;
+	path->search_for_split = true;
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
-	path->search_for_split = 0;
+	path->search_for_split = false;
 	if (ret > 0)
 		ret = -EAGAIN;
 	if (ret < 0)
@@ -3890,11 +3890,11 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto err;
 
-	path->keep_locks = 0;
+	path->keep_locks = false;
 	btrfs_unlock_up_safe(path, 1);
 	return 0;
 err:
-	path->keep_locks = 0;
+	path->keep_locks = false;
 	return ret;
 }
 
@@ -4610,11 +4610,11 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	u32 nritems;
 	int level;
 	int ret = 1;
-	int keep_locks = path->keep_locks;
+	const bool keep_locks = path->keep_locks;
 
 	ASSERT(!path->nowait);
 	ASSERT(path->lowest_level == 0);
-	path->keep_locks = 1;
+	path->keep_locks = true;
 again:
 	cur = btrfs_read_lock_root_node(root);
 	level = btrfs_header_level(cur);
@@ -4704,7 +4704,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
  * 0 is returned if another key is found, < 0 if there are any errors
  * and 1 is returned if there are no higher keys in the tree
  *
- * path->keep_locks should be set to 1 on the search made before
+ * path->keep_locks should be set to true on the search made before
  * calling this function.
  */
 int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
@@ -4803,13 +4803,13 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	next = NULL;
 	btrfs_release_path(path);
 
-	path->keep_locks = 1;
+	path->keep_locks = true;
 
 	if (time_seq) {
 		ret = btrfs_search_old_slot(root, &key, path, time_seq);
 	} else {
 		if (path->need_commit_sem) {
-			path->need_commit_sem = 0;
+			path->need_commit_sem = false;
 			need_commit_sem = true;
 			if (path->nowait) {
 				if (!down_read_trylock(&fs_info->commit_root_sem)) {
@@ -4822,7 +4822,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	}
-	path->keep_locks = 0;
+	path->keep_locks = false;
 
 	if (ret < 0)
 		goto done;
@@ -4961,7 +4961,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	if (need_commit_sem) {
 		int ret2;
 
-		path->need_commit_sem = 1;
+		path->need_commit_sem = true;
 		ret2 = finish_need_commit_sem_search(path);
 		up_read(&fs_info->commit_root_sem);
 		if (ret2)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 16dd11c48531..692370fc07b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -65,21 +65,21 @@ struct btrfs_path {
 	 * set by btrfs_split_item, tells search_slot to keep all locks
 	 * and to force calls to keep space in the nodes
 	 */
-	unsigned int search_for_split:1;
+	bool search_for_split:1;
 	/* Keep some upper locks as we walk down. */
-	unsigned int keep_locks:1;
-	unsigned int skip_locking:1;
-	unsigned int search_commit_root:1;
-	unsigned int need_commit_sem:1;
-	unsigned int skip_release_on_error:1;
+	bool keep_locks:1;
+	bool skip_locking:1;
+	bool search_commit_root:1;
+	bool need_commit_sem:1;
+	bool skip_release_on_error:1;
 	/*
 	 * Indicate that new item (btrfs_search_slot) is extending already
 	 * existing item and ins_len contains only the data size and not item
 	 * header (ie. sizeof(struct btrfs_item) is not included).
 	 */
-	unsigned int search_for_extension:1;
+	bool search_for_extension:1;
 	/* Stop search if any locks need to be taken (for read) */
-	unsigned int nowait:1;
+	bool nowait:1;
 };
 
 #define BTRFS_PATH_AUTO_FREE(path_name)					\
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index a4cc1bc63562..2e3c011d410a 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -472,7 +472,7 @@ static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		memcpy(&key, &root->defrag_progress, sizeof(key));
 	}
 
-	path->keep_locks = 1;
+	path->keep_locks = true;
 
 	ret = btrfs_search_forward(root, &key, path, BTRFS_OLDEST_GENERATION);
 	if (ret < 0)
@@ -515,7 +515,7 @@ static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 	/*
 	 * Now that we reallocated the node we can find the next key. Note that
 	 * btrfs_find_next_key() can release our path and do another search
-	 * without COWing, this is because even with path->keep_locks = 1,
+	 * without COWing, this is because even with path->keep_locks == true,
 	 * btrfs_search_slot() / ctree.c:unlock_up() does not keeps a lock on a
 	 * node when path->slots[node_level - 1] does not point to the last
 	 * item or a slot beyond the last item (ctree.c:unlock_up()). Therefore
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index a4eaef60549e..b6c7da8e1bc8 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -489,8 +489,8 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	}
 
 	path->reada = READA_FORWARD;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 86004b8daa96..819e0a15e8e7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -789,7 +789,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	want = extent_ref_type(parent, owner);
 	if (insert) {
 		extra_size = btrfs_extent_inline_ref_size(want);
-		path->search_for_extension = 1;
+		path->search_for_extension = true;
 	} else
 		extra_size = -1;
 
@@ -955,7 +955,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 
 		if (!path->keep_locks) {
 			btrfs_release_path(path);
-			path->keep_locks = 1;
+			path->keep_locks = true;
 			goto again;
 		}
 
@@ -976,11 +976,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
 out:
 	if (path->keep_locks) {
-		path->keep_locks = 0;
+		path->keep_locks = false;
 		btrfs_unlock_up_safe(path, 1);
 	}
 	if (insert)
-		path->search_for_extension = 0;
+		path->search_for_extension = false;
 	return ret;
 }
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e7c219e83ff0..b17632ea085f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -394,8 +394,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	 * between reading the free space cache and updating the csum tree.
 	 */
 	if (btrfs_is_free_space_inode(inode)) {
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path->search_commit_root = true;
+		path->skip_locking = true;
 	}
 
 	/*
@@ -423,8 +423,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	 * from across transactions.
 	 */
 	if (bbio->csum_search_commit_root) {
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path->search_commit_root = true;
+		path->skip_locking = true;
 		down_read(&fs_info->commit_root_sem);
 	}
 
@@ -1177,10 +1177,10 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_release_path(path);
-	path->search_for_extension = 1;
+	path->search_for_extension = true;
 	ret = btrfs_search_slot(trans, root, &file_key, path,
 				csum_size, 1);
-	path->search_for_extension = 0;
+	path->search_for_extension = false;
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6ccb492eae8e..f0f72850fab2 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -968,8 +968,8 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 	path = btrfs_alloc_path();
 	if (!path)
 		return 0;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	/*
 	 * We must pass a path with search_commit_root set to btrfs_iget in
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 26eae347739f..47745ae23c7d 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1694,8 +1694,8 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	 * Just like caching_thread() doesn't want to deadlock on the extent
 	 * tree, we don't want to deadlock on the free space tree.
 	 */
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
+	path->skip_locking = true;
+	path->search_commit_root = true;
 	path->reada = READA_FORWARD;
 
 	info = btrfs_search_free_space_info(NULL, block_group, path, 0);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 1bd73b80f9fa..98dacfd03234 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -312,7 +312,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->skip_release_on_error = 1;
+	path->skip_release_on_error = true;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      ins_len);
 	if (ret == -EEXIST) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a0c380ef464..fc0f0c46ab22 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7111,8 +7111,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	 * point the commit_root has everything we need.
 	 */
 	if (btrfs_is_free_space_inode(inode)) {
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path->search_commit_root = true;
+		path->skip_locking = true;
 	}
 
 	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1956e4bf2302..58fb55644be5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3834,8 +3834,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	 * Rescan should only search for commit root, and any later difference
 	 * should be recorded by qgroup
 	 */
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	while (!ret && !(stopped = rescan_should_stop(fs_info))) {
 		trans = btrfs_start_transaction(fs_info->fs_root, 0);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index f5c616115254..2987cb7c686e 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -388,8 +388,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	if (stripe->rst_search_commit_root) {
-		path->skip_locking = 1;
-		path->search_commit_root = 1;
+		path->skip_locking = true;
+		path->search_commit_root = true;
 	}
 
 	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 739fca944296..5bfefc3e9c06 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3165,8 +3165,8 @@ static int __add_tree_block(struct reloc_control *rc,
 		key.offset = blocksize;
 	}
 
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
@@ -3358,8 +3358,8 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = 0;
 
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
+		path->search_commit_root = true;
+		path->skip_locking = true;
 		ret = btrfs_search_slot(NULL, rc->extent_root, &key, path,
 					0, 0);
 		if (ret < 0)
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 660a8cd7ee0d..b6d33bf184ea 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -463,10 +463,10 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
 	sctx->fs_info = fs_info;
-	sctx->extent_path.search_commit_root = 1;
-	sctx->extent_path.skip_locking = 1;
-	sctx->csum_path.search_commit_root = 1;
-	sctx->csum_path.skip_locking = 1;
+	sctx->extent_path.search_commit_root = true;
+	sctx->extent_path.skip_locking = true;
+	sctx->csum_path.search_commit_root = true;
+	sctx->csum_path.skip_locking = true;
 	for (i = 0; i < SCRUB_TOTAL_STRIPES; i++) {
 		int ret;
 
@@ -2202,10 +2202,10 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	 * as the data stripe bytenr may be smaller than previous extent.  Thus
 	 * we have to use our own extent/csum paths.
 	 */
-	extent_path.search_commit_root = 1;
-	extent_path.skip_locking = 1;
-	csum_path.search_commit_root = 1;
-	csum_path.skip_locking = 1;
+	extent_path.search_commit_root = true;
+	extent_path.skip_locking = true;
+	csum_path.search_commit_root = true;
+	csum_path.skip_locking = true;
 
 	for (int i = 0; i < data_stripes; i++) {
 		int stripe_index;
@@ -2688,8 +2688,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		return -ENOMEM;
 
 	path->reada = READA_FORWARD;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	key.objectid = scrub_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index fa94105e139a..3d437024e8bc 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -633,9 +633,9 @@ static struct btrfs_path *alloc_path_for_send(void)
 	path = btrfs_alloc_path();
 	if (!path)
 		return NULL;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-	path->need_commit_sem = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
+	path->need_commit_sem = true;
 	return path;
 }
 
@@ -7622,10 +7622,10 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		goto out;
 	}
 
-	left_path->search_commit_root = 1;
-	left_path->skip_locking = 1;
-	right_path->search_commit_root = 1;
-	right_path->skip_locking = 1;
+	left_path->search_commit_root = true;
+	left_path->skip_locking = true;
+	right_path->search_commit_root = true;
+	right_path->skip_locking = true;
 
 	/*
 	 * Strategy: Go to the first items of both trees. Then do
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e40e1d746381..cc27f87c4904 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -602,9 +602,9 @@ static int overwrite_item(struct walk_control *wc)
 insert:
 	btrfs_release_path(wc->subvol_path);
 	/* try to insert the key into the destination tree */
-	wc->subvol_path->skip_release_on_error = 1;
+	wc->subvol_path->skip_release_on_error = true;
 	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path, &wc->log_key, item_size);
-	wc->subvol_path->skip_release_on_error = 0;
+	wc->subvol_path->skip_release_on_error = false;
 
 	dst_eb = wc->subvol_path->nodes[0];
 	dst_slot = wc->subvol_path->slots[0];
@@ -5706,8 +5706,8 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	search_path = btrfs_alloc_path();
 	if (!search_path)
 		return -ENOMEM;
-	search_path->search_commit_root = 1;
-	search_path->skip_locking = 1;
+	search_path->search_commit_root = true;
+	search_path->skip_locking = true;
 
 	while (cur_offset < item_size) {
 		u64 parent;
@@ -6026,8 +6026,8 @@ static int conflicting_inode_is_dir(struct btrfs_root *root, u64 ino,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (WARN_ON_ONCE(ret > 0)) {
@@ -6047,8 +6047,8 @@ static int conflicting_inode_is_dir(struct btrfs_root *root, u64 ino,
 	}
 
 	btrfs_release_path(path);
-	path->search_commit_root = 0;
-	path->skip_locking = 0;
+	path->search_commit_root = false;
+	path->skip_locking = false;
 
 	return ret;
 }
@@ -7169,8 +7169,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->skip_locking = 1;
-	path->search_commit_root = 1;
+	path->skip_locking = true;
+	path->search_commit_root = true;
 
 	key.objectid = ino;
 	key.type = BTRFS_INODE_REF_KEY;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 75a34ed95c74..e6a3f3ceb74b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1710,8 +1710,8 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	}
 
 	path->reada = READA_FORWARD;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
+	path->search_commit_root = true;
+	path->skip_locking = true;
 
 	key.objectid = device->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
@@ -7448,7 +7448,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * chunk tree, to keep it simple, just skip locking on the chunk tree.
 	 */
 	ASSERT(!test_bit(BTRFS_FS_OPEN, &fs_info->flags));
-	path->skip_locking = 1;
+	path->skip_locking = true;
 
 	/*
 	 * Read all device items, and then all the chunk items. All
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3d27eb1e2f74..98d6aa3b7d6a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -85,7 +85,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->skip_release_on_error = 1;
+	path->skip_release_on_error = true;
 
 	if (!value) {
 		di = btrfs_lookup_xattr(trans, root, path,
-- 
2.47.2


