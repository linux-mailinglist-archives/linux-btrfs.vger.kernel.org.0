Return-Path: <linux-btrfs+bounces-14927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B69AE69BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA12A1C28363
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771B2E11D8;
	Tue, 24 Jun 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIWwVbZc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA272E11B5
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776157; cv=none; b=MOWMZJT3WluDtig2v2pYMrkgg4OFOay3hBff1FSYrIiJ+JOfuNNb1fm9WQqvYazqCwQeyTMUgBb/qCn6B0EqHnci6gB0S0q8TFwyj9BbpdYvMTwfdASJnejaNGjMgNqYlXKMpOMrreOewJdaIHJmQSSaTX89Zz2+EX5bJM1WvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776157; c=relaxed/simple;
	bh=aiM8PF3hwDcKZe+jI+T3XGcVQF6MgBX8W8nWdDg0X84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on8JlNrB8ORK95JUfG/wl8PAk4EAlEi+PEXfOBc6Ji98qSt+yHsPicFYGqsmZtcfsAX8WRu50uiZ7ExT7PowzGvFWI6w9OOBlBQIJA/zosL0eJh2Lzcfax26ypXRHiJkOryVkyyISuxcrKywjFQ7DvorXEYbskYgIIaqkmon+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIWwVbZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBBAC4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776157;
	bh=aiM8PF3hwDcKZe+jI+T3XGcVQF6MgBX8W8nWdDg0X84=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZIWwVbZcEP6a9Z5SGKZ4jdN7/YDG2x0ZbpC4h/rP76T0QLznnmduIDNu0Sn3WAZi0
	 rxJDGqdP44nL/gBcESMVLooJX9yavYXlXofd/Vh7qlRxD5jvegrPhUGm8qUU4VUSK0
	 fZ5ZqUiOomvf/YZJ6yMY7EwqsAAqZUKTp2mjhBIYYi6XvVWDX04UCUTN30SVfoPJ2U
	 Y5DP6u4vXwBOVlXXc2gvjfYPb/7rFr4jMNbLuIHJbUnh4ZUogpX/mGEpCey/1ELOw9
	 SL8UGgg5R8seGF3Yc/y/qQIoT07CbDY7bpUKWKupGe+uYvaScQCR77vjWoM8czdinJ
	 XO/x0Jci7tCWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: add btrfs prefix to is_fsstree() and make it return bool
Date: Tue, 24 Jun 2025 15:42:21 +0100
Message-ID: <a209c328621538b027a9c68e473303eea3f30ccc.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This is an exported function and therefore it should have a 'btrfs_'
prefix, to make it clear it's btrfs specific, avoid future name collisions
with code outside btrfs, and make its naming consistent with most other
btrfs exported functions.

So add a 'btrfs_' prefix to it and make it return bool instead of int,
since all we need is to return true or false.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h        |  6 +++---
 fs/btrfs/delayed-ref.c  | 10 +++++-----
 fs/btrfs/disk-io.c      |  8 ++++----
 fs/btrfs/extent-tree.c  |  6 +++---
 fs/btrfs/extent_map.c   |  6 +++---
 fs/btrfs/ioctl.c        |  4 ++--
 fs/btrfs/qgroup.c       | 25 +++++++++++++------------
 fs/btrfs/relocation.c   |  2 +-
 fs/btrfs/tree-checker.c | 12 ++++++------
 fs/btrfs/tree-log.c     |  2 +-
 10 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a54a0b6e502..d51cc692f2c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -721,13 +721,13 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 }
 int btrfs_leaf_free_space(const struct extent_buffer *leaf);
 
-static inline int is_fstree(u64 rootid)
+static inline bool btrfs_is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
 	    ((s64)rootid >= (s64)BTRFS_FIRST_FREE_OBJECTID &&
 	      !btrfs_qgroup_level(rootid)))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 739c9e29aaa3..ca382c5b186f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -928,7 +928,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	if (action == BTRFS_ADD_DELAYED_EXTENT)
 		action = BTRFS_ADD_DELAYED_REF;
 
-	if (is_fstree(generic_ref->ref_root))
+	if (btrfs_is_fstree(generic_ref->ref_root))
 		seq = atomic64_read(&fs_info->tree_mod_seq);
 
 	refcount_set(&ref->refs, 1);
@@ -958,8 +958,8 @@ void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
 #endif
 	generic_ref->tree_ref.level = level;
 	generic_ref->type = BTRFS_REF_METADATA;
-	if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
-			     (!mod_root || is_fstree(mod_root))))
+	if (skip_qgroup || !(btrfs_is_fstree(generic_ref->ref_root) &&
+			     (!mod_root || btrfs_is_fstree(mod_root))))
 		generic_ref->skip_qgroup = true;
 	else
 		generic_ref->skip_qgroup = false;
@@ -976,8 +976,8 @@ void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 	generic_ref->data_ref.objectid = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
-	if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
-			     (!mod_root || is_fstree(mod_root))))
+	if (skip_qgroup || !(btrfs_is_fstree(generic_ref->ref_root) &&
+			     (!mod_root || btrfs_is_fstree(mod_root))))
 		generic_ref->skip_qgroup = true;
 	else
 		generic_ref->skip_qgroup = false;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ee3cdd7035cc..859e49b57edf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -884,7 +884,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_root_used(&root->root_item, leaf->len);
 	btrfs_set_root_last_snapshot(&root->root_item, 0);
 	btrfs_set_root_dirid(&root->root_item, 0);
-	if (is_fstree(objectid))
+	if (btrfs_is_fstree(objectid))
 		generate_random_guid(root->root_item.uuid);
 	else
 		export_guid(root->root_item.uuid, &guid_null);
@@ -1104,7 +1104,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 
 	if (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
 	    !btrfs_is_data_reloc_root(root) &&
-	    is_fstree(btrfs_root_id(root))) {
+	    btrfs_is_fstree(btrfs_root_id(root))) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
@@ -1113,7 +1113,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	 * Don't assign anonymous block device to roots that are not exposed to
 	 * userspace, the id pool is limited to 1M
 	 */
-	if (is_fstree(btrfs_root_id(root)) &&
+	if (btrfs_is_fstree(btrfs_root_id(root)) &&
 	    btrfs_root_refs(&root->root_item) > 0) {
 		if (!anon_dev) {
 			ret = get_anon_bdev(&root->anon_dev);
@@ -1315,7 +1315,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	 * This is namely for free-space-tree and quota tree, which can change
 	 * at runtime and should only be grabbed from fs_info.
 	 */
-	if (!is_fstree(objectid) && objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
+	if (!btrfs_is_fstree(objectid) && objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
 		return ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 10f50c725313..85833bf216de 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1545,7 +1545,7 @@ static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
 	 * where it has already been unset.
 	 */
 	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE ||
-	    !href->is_data || !is_fstree(root))
+	    !href->is_data || !btrfs_is_fstree(root))
 		return;
 
 	btrfs_qgroup_free_refroot(fs_info, root, href->reserved_bytes,
@@ -4963,7 +4963,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 	ASSERT(generic_ref.ref_root != BTRFS_TREE_LOG_OBJECTID);
 
-	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
+	if (btrfs_is_data_reloc_root(root) && btrfs_is_fstree(root->relocation_src_root))
 		generic_ref.owning_root = root->relocation_src_root;
 
 	btrfs_init_data_ref(&generic_ref, owner, offset, 0, false);
@@ -5887,7 +5887,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 					return ret;
 				}
 			}
-			if (is_fstree(btrfs_root_id(root))) {
+			if (btrfs_is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
 					btrfs_err_rl(fs_info,
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 02bfdb976e40..57f52585a6dd 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -84,7 +84,7 @@ static void remove_em(struct btrfs_inode *inode, struct extent_map *em)
 	rb_erase(&em->rb_node, &inode->extent_tree.root);
 	RB_CLEAR_NODE(&em->rb_node);
 
-	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->root)))
+	if (!btrfs_is_testing(fs_info) && btrfs_is_fstree(btrfs_root_id(inode->root)))
 		percpu_counter_dec(&fs_info->evictable_extent_maps);
 }
 
@@ -502,7 +502,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 
 	setup_extent_mapping(inode, em, modified);
 
-	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
+	if (!btrfs_is_testing(fs_info) && btrfs_is_fstree(btrfs_root_id(root)))
 		percpu_counter_inc(&fs_info->evictable_extent_maps);
 
 	return 0;
@@ -1337,7 +1337,7 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 		if (!root)
 			continue;
 
-		if (is_fstree(btrfs_root_id(root)))
+		if (btrfs_is_fstree(btrfs_root_id(root)))
 			nr_dropped += btrfs_scan_root(root, &ctx);
 
 		btrfs_put_root(root);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index aa8cefadf423..c28db44cb5c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2889,7 +2889,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!is_fstree(btrfs_root_id(new_root))) {
+	if (!btrfs_is_fstree(btrfs_root_id(new_root))) {
 		ret = -ENOENT;
 		goto out_free;
 	}
@@ -3832,7 +3832,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
-	if (sa->create && is_fstree(sa->qgroupid)) {
+	if (sa->create && btrfs_is_fstree(sa->qgroupid)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7791000dcefc..e38272ac808d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -482,7 +482,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			 * during mount before we start doing things like creating
 			 * subvolumes.
 			 */
-			if (is_fstree(qgroup->qgroupid) &&
+			if (btrfs_is_fstree(qgroup->qgroupid) &&
 			    qgroup->qgroupid > tree_root->free_objectid)
 				/*
 				 * Don't need to check against BTRFS_LAST_FREE_OBJECTID,
@@ -1878,7 +1878,8 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info, u64 su
 	struct btrfs_trans_handle *trans;
 	int ret;
 
-	if (!is_fstree(subvolid) || !btrfs_qgroup_enabled(fs_info) || !fs_info->quota_root)
+	if (!btrfs_is_fstree(subvolid) || !btrfs_qgroup_enabled(fs_info) ||
+	    !fs_info->quota_root)
 		return 0;
 
 	/*
@@ -2932,7 +2933,7 @@ static int maybe_fs_roots(struct ulist *roots)
 	 * trees.
 	 * If it contains a non-fs tree, it won't be shared with fs/subvol trees.
 	 */
-	return is_fstree(unode->val);
+	return btrfs_is_fstree(unode->val);
 }
 
 int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
@@ -3591,7 +3592,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 	int ret = 0;
 	LIST_HEAD(qgroup_list);
 
-	if (!is_fstree(ref_root))
+	if (!btrfs_is_fstree(ref_root))
 		return 0;
 
 	if (num_bytes == 0)
@@ -3651,7 +3652,7 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup *qgroup;
 	LIST_HEAD(qgroup_list);
 
-	if (!is_fstree(ref_root))
+	if (!btrfs_is_fstree(ref_root))
 		return;
 
 	if (num_bytes == 0)
@@ -4219,7 +4220,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	int ret;
 
 	if (btrfs_qgroup_mode(root->fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(btrfs_root_id(root)) || len == 0)
+	    !btrfs_is_fstree(btrfs_root_id(root)) || len == 0)
 		return 0;
 
 	/* @reserved parameter is mandatory for qgroup */
@@ -4472,7 +4473,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	int ret;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(btrfs_root_id(root)) || num_bytes == 0)
+	    !btrfs_is_fstree(btrfs_root_id(root)) || num_bytes == 0)
 		return 0;
 
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
@@ -4517,7 +4518,7 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(btrfs_root_id(root)))
+	    !btrfs_is_fstree(btrfs_root_id(root)))
 		return;
 
 	/* TODO: Update trace point to handle such free */
@@ -4533,7 +4534,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(btrfs_root_id(root)))
+	    !btrfs_is_fstree(btrfs_root_id(root)))
 		return;
 
 	/*
@@ -4592,7 +4593,7 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(btrfs_root_id(root)))
+	    !btrfs_is_fstree(btrfs_root_id(root)))
 		return;
 	/* Same as btrfs_qgroup_free_meta_prealloc() */
 	num_bytes = sub_root_meta_rsv(root, num_bytes,
@@ -4818,7 +4819,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
-	if (!is_fstree(btrfs_root_id(root)) || !root->reloc_root)
+	if (!btrfs_is_fstree(btrfs_root_id(root)) || !root->reloc_root)
 		return 0;
 
 	spin_lock(&blocks->lock);
@@ -4902,7 +4903,7 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
 		return 0;
 
-	if (!is_fstree(root))
+	if (!btrfs_is_fstree(root))
 		return 0;
 
 	/* If the extent predates enabling quotas, don't count it. */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d7ec1d72821c..2670c0eb3cda 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2625,7 +2625,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		 * tree.
 		 */
 		if (block->owner &&
-		    (!is_fstree(block->owner) ||
+		    (!btrfs_is_fstree(block->owner) ||
 		     block->owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
 			ret = relocate_cowonly_block(trans, rc, block, path);
 			if (ret)
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8f4703b488b7..0f556f4de3f9 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -191,7 +191,7 @@ static bool check_prev_ino(struct extent_buffer *leaf,
 	 * Only subvolume trees along with their reloc trees need this check.
 	 * Things like log tree doesn't follow this ino requirement.
 	 */
-	if (!is_fstree(btrfs_header_owner(leaf)))
+	if (!btrfs_is_fstree(btrfs_header_owner(leaf)))
 		return true;
 
 	if (key->objectid == prev_key->objectid)
@@ -475,7 +475,7 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	 * to be COWed to be relocated.
 	 */
 	if (unlikely(is_root_item && key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
-		     !is_fstree(key->offset))) {
+		     !btrfs_is_fstree(key->offset))) {
 		generic_err(leaf, slot,
 		"invalid reloc tree for root %lld, root id is not a subvolume tree",
 			    key->offset);
@@ -493,7 +493,7 @@ static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* DIR_ITEM/INDEX/INODE_REF is not allowed to point to non-fs trees */
-	if (unlikely(!is_fstree(key->objectid) && !is_root_item)) {
+	if (unlikely(!btrfs_is_fstree(key->objectid) && !is_root_item)) {
 		dir_item_err(leaf, slot,
 		"invalid location key objectid, have %llu expect [%llu, %llu]",
 				key->objectid, BTRFS_FIRST_FREE_OBJECTID,
@@ -1311,7 +1311,7 @@ static bool is_valid_dref_root(u64 rootid)
 	 * - tree root
 	 *   For v1 space cache
 	 */
-	return is_fstree(rootid) || rootid == BTRFS_DATA_RELOC_TREE_OBJECTID ||
+	return btrfs_is_fstree(rootid) || rootid == BTRFS_DATA_RELOC_TREE_OBJECTID ||
 	       rootid == BTRFS_ROOT_TREE_OBJECTID;
 }
 
@@ -2167,7 +2167,7 @@ ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
 
 int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
 {
-	const bool is_subvol = is_fstree(root_owner);
+	const bool is_subvol = btrfs_is_fstree(root_owner);
 	const u64 eb_owner = btrfs_header_owner(eb);
 
 	/*
@@ -2209,7 +2209,7 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
 	 * For subvolume trees, owners can mismatch, but they should all belong
 	 * to subvolume trees.
 	 */
-	if (unlikely(is_subvol != is_fstree(eb_owner))) {
+	if (unlikely(is_subvol != btrfs_is_fstree(eb_owner))) {
 		btrfs_crit(eb->fs_info,
 "corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect [%llu, %llu]",
 			btrfs_header_level(eb) == 0 ? "leaf" : "node",
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 82664bb79d36..97ed11788b47 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -144,7 +144,7 @@ static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *r
 	struct btrfs_inode *inode;
 
 	/* Only meant to be called for subvolume roots and not for log roots. */
-	ASSERT(is_fstree(btrfs_root_id(root)));
+	ASSERT(btrfs_is_fstree(btrfs_root_id(root)));
 
 	/*
 	 * We're holding a transaction handle whether we are logging or
-- 
2.47.2


