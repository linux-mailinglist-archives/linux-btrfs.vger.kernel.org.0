Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA070614F03
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKAQQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKAQQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB01C92F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3841F61668
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B00C43470
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319370;
        bh=nDVWlKOx6XfmieL9u0wV9XrPdsLzAadVK+5xFdL7KpE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZLhSFcsmzqTOfUsTxOQfm/aS16mBOiV67s0AFeECBVGwIhZoZx3OXtZjCsEd/ED1q
         B3fjxiij94xxGRDGmB4gyIk8rlfkJ/LwCGl6jTOiMotRPb9Q+Cho3V5bbWjcHA1Arg
         5jAfXOg2MFRGnnewaNWjgFV4Rs3dJWVCKu2o+sZI8MoYCiehcKiSCDYMV4rwvSFC7r
         emfROnEFAb4izCe67PynfYFXDwPQoV+V3QVuM0VmwHFR+8WLd+fQ4/P8Q3va4rbbPp
         6VGzAZJszcD6bw+epPrZJUXYiQcrgTfGQ1VAhh2JNkxtIy9ZvfNfOispJ6leUmIJPl
         neWv76KK2WKTA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/18] btrfs: send: cache leaf to roots mapping during backref walking
Date:   Tue,  1 Nov 2022 16:15:50 +0000
Message-Id: <cec6914acefc1f4bf30753ea34809a66ca0913b6.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a send operation, when doing backref walking to determine which
inodes/offsets/roots we can clone from, the most repetitive and expensive
step is to map each leaf that has file extent items pointing to the target
data extent to the IDs of the roots from which the leaves are accessible,
which happens at iterate_extent_inodes(). That step requires finding every
parent node of a leaf, then the parent of each parent, and so on until we
reach a root node. So it's a naturally expensive operation, and repetitive
because each leaf can have hundreds of file extent items (for a nodesize
of 16K, that can be slightly over 200 file extent items). There's also
temporal locality, as we process all file extent items from a leave before
moving the next leaf.

This change caches the mapping of leaves to root IDs, to avoid repeating
those computations over and over again. The cache is limited to a maximum
of 128 entries, with each entry being a struct with a size of 128 bytes,
so the maximum cache size is 16K plus any nodes internally allocated by
the maple tree that is used to index pointers to those structs. The cache
is invalidated whenever we detect relocation happened since we started
filling the cache, because if relocation happened then extent buffers for
leaves and nodes of the trees used by a send operation may have been
reallocated.

This cache also allows for another important optimization that is
introduced in the next patch in the series.

This change is part of a patchset comprised of the following patches:

  01/17 btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
  02/17 btrfs: fix inode list leak during backref walking at find_parent_nodes()
  03/17 btrfs: fix ulist leaks in error paths of qgroup self tests
  04/17 btrfs: remove pointless and double ulist frees in error paths of qgroup tests
  05/17 btrfs: send: avoid unnecessary path allocations when finding extent clone
  06/17 btrfs: send: update comment at find_extent_clone()
  07/17 btrfs: send: drop unnecessary backref context field initializations
  08/17 btrfs: send: avoid unnecessary backref lookups when finding clone source
  09/17 btrfs: send: optimize clone detection to increase extent sharing
  10/17 btrfs: use a single argument for extent offset in backref walking functions
  11/17 btrfs: use a structure to pass arguments to backref walking functions
  12/17 btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
  13/17 btrfs: constify ulist parameter of ulist_next()
  14/17 btrfs: send: cache leaf to roots mapping during backref walking
  15/17 btrfs: send: skip unnecessary backref iterations
  16/17 btrfs: send: avoid double extent tree search when finding clone source
  17/17 btrfs: send: skip resolution of our own backref when finding clone source

Performance test results are in the changelog of patch 17/17.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c |  52 ++++++++++---
 fs/btrfs/backref.h |  11 +++
 fs/btrfs/send.c    | 185 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index dc276ce3afe0..9dacf487017d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2303,21 +2303,14 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 	ASSERT(ctx->trans == NULL);
 	ASSERT(ctx->roots == NULL);
 
-	ctx->roots = ulist_alloc(GFP_NOFS);
-	if (!ctx->roots)
-		return -ENOMEM;
-
 	if (!search_commit_root) {
 		struct btrfs_trans_handle *trans;
 
 		trans = btrfs_attach_transaction(ctx->fs_info->tree_root);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT &&
-			    PTR_ERR(trans) != -EROFS) {
-				ulist_free(ctx->roots);
-				ctx->roots = NULL;
+			    PTR_ERR(trans) != -EROFS)
 				return PTR_ERR(trans);
-			}
 			trans = NULL;
 		}
 		ctx->trans = trans;
@@ -2338,23 +2331,58 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 
 	ULIST_ITER_INIT(&ref_uiter);
 	while (!ret && (ref_node = ulist_next(refs, &ref_uiter))) {
+		const u64 leaf_bytenr = ref_node->val;
 		struct ulist_node *root_node;
 		struct ulist_iterator root_uiter;
+		struct extent_inode_elem *inode_list;
+
+		inode_list = (struct extent_inode_elem *)(uintptr_t)ref_node->aux;
+
+		if (ctx->cache_lookup) {
+			const u64 *root_ids;
+			int root_count;
+			bool cached;
+
+			cached = ctx->cache_lookup(leaf_bytenr, ctx->user_ctx,
+						   &root_ids, &root_count);
+			if (cached) {
+				for (int i = 0; i < root_count; i++) {
+					ret = iterate_leaf_refs(ctx->fs_info,
+								inode_list,
+								root_ids[i],
+								leaf_bytenr,
+								iterate,
+								user_ctx);
+					if (ret)
+						break;
+				}
+				continue;
+			}
+		}
+
+		if (!ctx->roots) {
+			ctx->roots = ulist_alloc(GFP_NOFS);
+			if (!ctx->roots) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 
-		ctx->bytenr = ref_node->val;
+		ctx->bytenr = leaf_bytenr;
 		ret = btrfs_find_all_roots_safe(ctx);
 		if (ret)
 			break;
 
+		if (ctx->cache_store)
+			ctx->cache_store(leaf_bytenr, ctx->roots, ctx->user_ctx);
+
 		ULIST_ITER_INIT(&root_uiter);
 		while (!ret && (root_node = ulist_next(ctx->roots, &root_uiter))) {
 			btrfs_debug(ctx->fs_info,
 				    "root %llu references leaf %llu, data list %#llx",
 				    root_node->val, ref_node->val,
 				    ref_node->aux);
-			ret = iterate_leaf_refs(ctx->fs_info,
-						(struct extent_inode_elem *)
-						(uintptr_t)ref_node->aux,
+			ret = iterate_leaf_refs(ctx->fs_info, inode_list,
 						root_node->val, ctx->bytenr,
 						iterate, user_ctx);
 		}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ce700dfcc016..5005f579f235 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -69,6 +69,17 @@ struct btrfs_backref_walk_ctx {
 	 * about collecting root IDs.
 	 */
 	struct ulist *roots;
+	/*
+	 * Used by iterate_extent_inodes(). Lookup and store functions for an
+	 * optional cache which maps the logical address (bytenr) of leaves
+	 * to an array of root IDs.
+	 */
+	bool (*cache_lookup)(u64 leaf_bytenr, void *user_ctx,
+			     const u64 **root_ids_ret, int *root_count_ret);
+	void (*cache_store)(u64 leaf_bytenr, const struct ulist *root_ids,
+			    void *user_ctx);
+	/* Context object to pass to @cache_lookup and @cache_store. */
+	void *user_ctx;
 };
 
 struct inode_fs_paths {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 95eaa9ce190b..4b79d52d74a4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -83,6 +83,39 @@ struct clone_root {
 #define SEND_CTX_MAX_NAME_CACHE_SIZE 128
 #define SEND_CTX_NAME_CACHE_CLEAN_SIZE (SEND_CTX_MAX_NAME_CACHE_SIZE * 2)
 
+/*
+ * Limit the root_ids array of struct backref_cache_entry to 12 elements.
+ * This makes the size of a cache entry to be exactly 128 bytes on x86_64.
+ * The most common case is to have a single root for cloning, which corresponds
+ * to the send root. Having the user specify more than 11 clone roots is not
+ * common, and in such rare cases we simply don't use caching if the number of
+ * cloning roots that lead down to a leaf is more than 12.
+ */
+#define SEND_MAX_BACKREF_CACHE_ROOTS 12
+
+/*
+ * Max number of entries in the cache.
+ * With SEND_MAX_BACKREF_CACHE_ROOTS as 12, the size in bytes, excluding
+ * maple tree's internal nodes, is 16K.
+ */
+#define SEND_MAX_BACKREF_CACHE_SIZE 128
+
+/*
+ * A backref cache entry maps a leaf to a list of IDs of roots from which the
+ * leaf is accessible and we can use for clone operations.
+ * With SEND_MAX_BACKREF_CACHE_ROOTS as 12, each cache entry is 128 bytes (on
+ * x86_64).
+ */
+struct backref_cache_entry {
+	/* List to link to the cache's lru list. */
+	struct list_head list;
+	/* The key for this entry in the cache. */
+	u64 key;
+	u64 root_ids[SEND_MAX_BACKREF_CACHE_ROOTS];
+	/* Number of valid elements in the root_ids array. */
+	int num_roots;
+};
+
 struct send_ctx {
 	struct file *send_filp;
 	loff_t send_off;
@@ -251,6 +284,14 @@ struct send_ctx {
 
 	struct rb_root rbtree_new_refs;
 	struct rb_root rbtree_deleted_refs;
+
+	struct {
+		u64 last_reloc_trans;
+		struct list_head lru_list;
+		struct maple_tree entries;
+		/* Number of entries stored in the cache. */
+		int size;
+	} backref_cache;
 };
 
 struct pending_dir_move {
@@ -1335,6 +1376,142 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root,
 	return 0;
 }
 
+static void empty_backref_cache(struct send_ctx *sctx)
+{
+	struct backref_cache_entry *entry;
+	struct backref_cache_entry *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &sctx->backref_cache.lru_list, list)
+		kfree(entry);
+
+	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
+	mtree_destroy(&sctx->backref_cache.entries);
+	sctx->backref_cache.size = 0;
+}
+
+static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
+				 const u64 **root_ids_ret, int *root_count_ret)
+{
+	struct send_ctx *sctx = ctx;
+	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
+	const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
+	struct backref_cache_entry *entry;
+
+	if (sctx->backref_cache.size == 0)
+		return false;
+
+	/*
+	 * If relocation happened since we first filled the cache, then we must
+	 * empty the cache and can not use it, because even though we operate on
+	 * read-only roots, their leaves and nodes may have been reallocated and
+	 * now be used for different nodes/leaves of the same tree or some other
+	 * tree.
+	 *
+	 * We are called from iterate_extent_inodes() while either holding a
+	 * transaction handle or holding fs_info->commit_root_sem, so no need
+	 * to take any lock here.
+	 */
+	if (fs_info->last_reloc_trans > sctx->backref_cache.last_reloc_trans) {
+		empty_backref_cache(sctx);
+		return false;
+	}
+
+	entry = mtree_load(&sctx->backref_cache.entries, key);
+	if (!entry)
+		return false;
+
+	*root_ids_ret = entry->root_ids;
+	*root_count_ret = entry->num_roots;
+	list_move_tail(&entry->list, &sctx->backref_cache.lru_list);
+
+	return true;
+}
+
+static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
+				void *ctx)
+{
+	struct send_ctx *sctx = ctx;
+	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
+	struct backref_cache_entry *new_entry;
+	struct ulist_iterator uiter;
+	struct ulist_node *node;
+	int ret;
+
+	/*
+	 * We're called while holding a transaction handle or while holding
+	 * fs_info->commit_root_sem (at iterate_extent_inodes()), so must do a
+	 * NOFS allocation.
+	 */
+	new_entry = kmalloc(sizeof(struct backref_cache_entry), GFP_NOFS);
+	/* No worries, cache is optional. */
+	if (!new_entry)
+		return;
+
+	new_entry->key = leaf_bytenr >> fs_info->sectorsize_bits;
+	new_entry->num_roots = 0;
+	ULIST_ITER_INIT(&uiter);
+	while ((node = ulist_next(root_ids, &uiter)) != NULL) {
+		const u64 root_id = node->val;
+		struct clone_root *root;
+
+		root = bsearch((void *)(uintptr_t)root_id, sctx->clone_roots,
+			       sctx->clone_roots_cnt, sizeof(struct clone_root),
+			       __clone_root_cmp_bsearch);
+		if (!root)
+			continue;
+
+		/* Too many roots, just exit, no worries as caching is optional. */
+		if (new_entry->num_roots >= SEND_MAX_BACKREF_CACHE_ROOTS) {
+			kfree(new_entry);
+			return;
+		}
+
+		new_entry->root_ids[new_entry->num_roots] = root_id;
+		new_entry->num_roots++;
+	}
+
+	/*
+	 * We may have not added any roots to the new cache entry, which means
+	 * none of the roots is part of the list of roots from which we are
+	 * allowed to clone. Cache the new entry as it's still useful to avoid
+	 * backref walking to determine which roots have a path to the leaf.
+	 */
+
+	if (sctx->backref_cache.size >= SEND_MAX_BACKREF_CACHE_SIZE) {
+		struct backref_cache_entry *lru_entry;
+		struct backref_cache_entry *mt_entry;
+
+		lru_entry = list_first_entry(&sctx->backref_cache.lru_list,
+					     struct backref_cache_entry, list);
+		mt_entry = mtree_erase(&sctx->backref_cache.entries, lru_entry->key);
+		ASSERT(mt_entry == lru_entry);
+		list_del(&mt_entry->list);
+		kfree(mt_entry);
+		sctx->backref_cache.size--;
+	}
+
+	ret = mtree_insert(&sctx->backref_cache.entries, new_entry->key,
+			   new_entry, GFP_NOFS);
+	ASSERT(ret == 0 || ret == -ENOMEM);
+	if (ret) {
+		/* Caching is optional, no worries. */
+		kfree(new_entry);
+		return;
+	}
+
+	list_add_tail(&new_entry->list, &sctx->backref_cache.lru_list);
+
+	/*
+	 * We are called from iterate_extent_inodes() while either holding a
+	 * transaction handle or holding fs_info->commit_root_sem, so no need
+	 * to take any lock here.
+	 */
+	if (sctx->backref_cache.size == 0)
+		sctx->backref_cache.last_reloc_trans = fs_info->last_reloc_trans;
+
+	sctx->backref_cache.size++;
+}
+
 /*
  * Given an inode, offset and extent item, it finds a good clone for a clone
  * instruction. Returns -ENOENT when none could be found. The function makes
@@ -1465,6 +1642,9 @@ static int find_extent_clone(struct send_ctx *sctx,
 	if (compressed == BTRFS_COMPRESS_NONE)
 		backref_walk_ctx.extent_item_pos = logical - found_key.objectid;
 	backref_walk_ctx.fs_info = fs_info;
+	backref_walk_ctx.cache_lookup = lookup_backref_cache;
+	backref_walk_ctx.cache_store = store_backref_cache;
+	backref_walk_ctx.user_ctx = sctx;
 
 	ret = iterate_extent_inodes(&backref_walk_ctx, true, __iterate_backrefs,
 				    &backref_ctx);
@@ -7940,6 +8120,9 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->rbtree_new_refs = RB_ROOT;
 	sctx->rbtree_deleted_refs = RB_ROOT;
 
+	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
+	mt_init(&sctx->backref_cache.entries);
+
 	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
 				     arg->clone_sources_count + 1,
 				     GFP_KERNEL);
@@ -8131,6 +8314,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 		close_current_inode(sctx);
 
+		empty_backref_cache(sctx);
+
 		kfree(sctx);
 	}
 
-- 
2.35.1

