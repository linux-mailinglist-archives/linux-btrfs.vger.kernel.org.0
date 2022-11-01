Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE533614F07
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKAQQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKAQQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDE1C92F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D343FB81E25
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F9C433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319371;
        bh=H+BsPAqv3KDCz5W1k+HIjPia0EjPq3Y9u6nC6xSaVE8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ueQwz8UgvQDvug9yhN+UVXEpFOzMd91PiOHX9xdLG9t4CZ11j17ercoOH0XGBRtvD
         loAmsYc66hYpZaC46YT1VXPHiM1Hz4jA4GMfP9XIya0w3T98Ed8b1p2MtdXIyeBiKw
         F5BF2Kn+ZYT5IjlIV1BQh8wvP4uZ0W4W/17JewXVlHO1wxyYr7qyhYsSJJf7oRAsKb
         Bih8eEc0me/DnQd3Y5Zwx2+jxXD1YkkyHPBZ9L+C7VTTU1w25SkAyLaf8UwEAYEN1O
         JW6VprYIu3y3mxzLcVX7Iyj8zd5U2ZOJOdIi8Djy4shYga170XI+TjT3QUDBZp7gYv
         yJUXggXcjKhkQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/18] btrfs: send: skip unnecessary backref iterations
Date:   Tue,  1 Nov 2022 16:15:51 +0000
Message-Id: <9bb6ab50fe0cd7c0f7c5837c386dbedee54ff3a8.1667315100.git.fdmanana@suse.com>
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

When looking for a clone source for an extent, we are iterating over all
the backreferences for an extent. This is often a waste of time, because
once we find a good clone source we could stop immediately instead of
continuing backref walking, which is expensive.

Basically what happens currently is this:

1) Call iterate_extent_inodes() to iterate over all the backreferences;

2) It calls btrfs_find_all_leafs() which in turn calls the main function
   to walk over backrefs and collect them - find_parent_nodes();

3) Then we collect all the references for our target data extent from the
   extent tree (and delayed refs if any), add them to the rb trees,
   resolve all the indirect backreferences and search for all the file
   extent items in fs trees, building a list of inodes for each one of
   them (struct extent_inode_elem);

4) Then back at iterate_extent_inodes() we find all the roots associated
   to each found leaf, and call the callback __iterate_backrefs defined
   at send.c for each inode in the inode list associated to each leaf.

Some times one the first backreferences we find in a fs tree is optimal
to satisfy the clone operation that send wants to perform, and in that
case we could stop immediately and avoid resolving all the remaining
indirect backreferences (search fs trees for the respective file extent
items, etc). This possibly if when we find a fs tree leaf with a file
extent item we are able to know what are all the roots that can lead to
the leaf - this is now possible after the previous patch in the series
that adds a cache that maps leaves to a list of roots. So we can now
shortcircuit backref walking during send, by having the callback we
pass to iterate_extent_inodes() to be called when we find a file extent
item for an indirect backreference, and have it return a special value
when it found a suitable backreference and it does not need to look for
more backreferences. This change does that.

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
 fs/btrfs/backref.c | 73 ++++++++++++++++++++++++++++-------------
 fs/btrfs/backref.h | 44 +++++++++++++++++++++----
 fs/btrfs/send.c    | 81 +++++++++++++++++++++++-----------------------
 3 files changed, 128 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9dacf487017d..bb59ba68d7ee 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -31,15 +31,18 @@ struct extent_inode_elem {
 	struct extent_inode_elem *next;
 };
 
-static int check_extent_in_eb(const struct btrfs_key *key,
+static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
+			      const struct btrfs_key *key,
 			      const struct extent_buffer *eb,
 			      const struct btrfs_file_extent_item *fi,
-			      u64 extent_item_pos,
 			      struct extent_inode_elem **eie)
 {
 	const u64 data_len = btrfs_file_extent_num_bytes(eb, fi);
-	u64 offset = 0;
+	u64 offset = key->offset;
 	struct extent_inode_elem *e;
+	const u64 *root_ids;
+	int root_count;
+	bool cached;
 
 	if (!btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
@@ -48,19 +51,38 @@ static int check_extent_in_eb(const struct btrfs_key *key,
 
 		data_offset = btrfs_file_extent_offset(eb, fi);
 
-		if (extent_item_pos < data_offset ||
-		    extent_item_pos >= data_offset + data_len)
+		if (ctx->extent_item_pos < data_offset ||
+		    ctx->extent_item_pos >= data_offset + data_len)
 			return 1;
-		offset = extent_item_pos - data_offset;
+		offset += ctx->extent_item_pos - data_offset;
+	}
+
+	if (!ctx->indirect_ref_iterator || !ctx->cache_lookup)
+		goto add_inode_elem;
+
+	cached = ctx->cache_lookup(eb->start, ctx->user_ctx, &root_ids,
+				   &root_count);
+	if (!cached)
+		goto add_inode_elem;
+
+	for (int i = 0; i < root_count; i++) {
+		int ret;
+
+		ret = ctx->indirect_ref_iterator(key->objectid, offset,
+						 data_len, root_ids[i],
+						 ctx->user_ctx);
+		if (ret)
+			return ret;
 	}
 
+add_inode_elem:
 	e = kmalloc(sizeof(*e), GFP_NOFS);
 	if (!e)
 		return -ENOMEM;
 
 	e->next = *eie;
 	e->inum = key->objectid;
-	e->offset = key->offset + offset;
+	e->offset = offset;
 	e->num_bytes = data_len;
 	*eie = e;
 
@@ -77,8 +99,8 @@ static void free_inode_elem_list(struct extent_inode_elem *eie)
 	}
 }
 
-static int find_extent_in_eb(const struct extent_buffer *eb,
-			     u64 wanted_disk_byte, u64 extent_item_pos,
+static int find_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
+			     const struct extent_buffer *eb,
 			     struct extent_inode_elem **eie)
 {
 	u64 disk_byte;
@@ -105,11 +127,11 @@ static int find_extent_in_eb(const struct extent_buffer *eb,
 			continue;
 		/* don't skip BTRFS_FILE_EXTENT_PREALLOC, we can handle that */
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
-		if (disk_byte != wanted_disk_byte)
+		if (disk_byte != ctx->bytenr)
 			continue;
 
-		ret = check_extent_in_eb(&key, eb, fi, extent_item_pos, eie);
-		if (ret < 0)
+		ret = check_extent_in_eb(ctx, &key, eb, fi, eie);
+		if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
 			return ret;
 	}
 
@@ -526,9 +548,9 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 			else
 				goto next;
 			if (!ctx->ignore_extent_item_pos) {
-				ret = check_extent_in_eb(&key, eb, fi,
-							 ctx->extent_item_pos, &eie);
-				if (ret < 0)
+				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
+				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
+				    ret < 0)
 					break;
 			}
 			if (ret > 0)
@@ -551,10 +573,11 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
 			ret = btrfs_next_old_item(root, path, ctx->time_seq);
 	}
 
-	if (ret > 0)
-		ret = 0;
-	else if (ret < 0)
+	if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
 		free_inode_elem_list(eie);
+	else if (ret > 0)
+		ret = 0;
+
 	return ret;
 }
 
@@ -1570,12 +1593,12 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 
 				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
-				ret = find_extent_in_eb(eb, ctx->bytenr,
-							ctx->extent_item_pos, &eie);
+				ret = find_extent_in_eb(ctx, eb, &eie);
 				if (!path->skip_locking)
 					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
-				if (ret < 0)
+				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
+				    ret < 0)
 					goto out;
 				ref->inode_list = eie;
 				/*
@@ -1628,7 +1651,7 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 	prelim_release(&preftrees.indirect);
 	prelim_release(&preftrees.indirect_missing_keys);
 
-	if (ret < 0)
+	if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
 		free_inode_elem_list(eie);
 	return ret;
 }
@@ -1654,7 +1677,8 @@ int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx)
 		return -ENOMEM;
 
 	ret = find_parent_nodes(ctx, NULL);
-	if (ret < 0 && ret != -ENOENT) {
+	if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
+	    (ret < 0 && ret != -ENOENT)) {
 		free_leaf_list(ctx->refs);
 		ctx->refs = NULL;
 		return ret;
@@ -2402,6 +2426,9 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 	ulist_free(ctx->roots);
 	ctx->roots = NULL;
 
+	if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP)
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5005f579f235..a80d1e8be718 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -12,6 +12,25 @@
 #include "disk-io.h"
 #include "extent_io.h"
 
+/*
+ * Used by implementations of iterate_extent_inodes_t (see definition below) to
+ * signal that backref iteration can stop immediately and no error happened.
+ * The value must be non-negative and must not be 0, 1 (which is a common return
+ * value from things like btrfs_search_slot() and used internally in the backref
+ * walking code) and different from BACKREF_FOUND_SHARED and
+ * BACKREF_FOUND_NOT_SHARED
+ */
+#define BTRFS_ITERATE_EXTENT_INODES_STOP 5
+
+/*
+ * Should return 0 if no errors happened and iteration of backrefs should
+ * continue. Can return BTRFS_ITERATE_EXTENT_INODES_STOP or any other non-zero
+ * value to immediately stop iteration and possibly signal an error back to
+ * the caller.
+ */
+typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_bytes,
+				      u64 root, void *ctx);
+
 /*
  * Context and arguments for backref walking functions. Some of the fields are
  * to be filled by the caller of such functions while other are filled by the
@@ -70,15 +89,29 @@ struct btrfs_backref_walk_ctx {
 	 */
 	struct ulist *roots;
 	/*
-	 * Used by iterate_extent_inodes(). Lookup and store functions for an
-	 * optional cache which maps the logical address (bytenr) of leaves
-	 * to an array of root IDs.
+	 * Used by iterate_extent_inodes() and the main backref walk code
+	 * (find_parent_nodes()). Lookup and store functions for an optional
+	 * cache which maps the logical address (bytenr) of leaves to an array
+	 * of root IDs.
 	 */
 	bool (*cache_lookup)(u64 leaf_bytenr, void *user_ctx,
 			     const u64 **root_ids_ret, int *root_count_ret);
 	void (*cache_store)(u64 leaf_bytenr, const struct ulist *root_ids,
 			    void *user_ctx);
-	/* Context object to pass to @cache_lookup and @cache_store. */
+	/*
+	 * If this is not NULL, then the backref walking code will call this
+	 * for each indirect data extent reference as soon as it finds one,
+	 * before collecting all the remaining backrefs and before resolving
+	 * indirect backrefs. This allows for the caller to terminate backref
+	 * walking as soon as it finds one backref that matches some specific
+	 * criteria. The @cache_lookup and @cache_store callbacks should not
+	 * be NULL in order to use this callback.
+	 */
+	iterate_extent_inodes_t *indirect_ref_iterator;
+	/*
+	 * Context object to pass to the @cache_lookup, @cache_store and
+	 * @indirect_ref_iterator callbacks.
+	 */
 	void *user_ctx;
 };
 
@@ -145,9 +178,6 @@ struct btrfs_backref_share_check_ctx {
 	int prev_extents_cache_slot;
 };
 
-typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_bytes,
-				      u64 root, void *ctx);
-
 struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void);
 void btrfs_free_backref_share_ctx(struct btrfs_backref_share_check_ctx *ctx);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4b79d52d74a4..67f82793315c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -77,7 +77,7 @@ struct clone_root {
 	u64 ino;
 	u64 offset;
 	u64 num_bytes;
-	u64 found_refs;
+	bool found_ref;
 };
 
 #define SEND_CTX_MAX_NAME_CACHE_SIZE 128
@@ -1281,9 +1281,6 @@ struct backref_ctx {
 
 	/* may be truncated in case it's the last extent in a file */
 	u64 extent_len;
-
-	/* Just to check for bugs in backref resolving */
-	int found_itself;
 };
 
 static int __clone_root_cmp_bsearch(const void *key, const void *elt)
@@ -1312,33 +1309,33 @@ static int __clone_root_cmp_sort(const void *e1, const void *e2)
 
 /*
  * Called for every backref that is found for the current extent.
- * Results are collected in sctx->clone_roots->ino/offset/found_refs
+ * Results are collected in sctx->clone_roots->ino/offset.
  */
-static int __iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root,
-			      void *ctx_)
+static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root_id,
+			    void *ctx_)
 {
 	struct backref_ctx *bctx = ctx_;
-	struct clone_root *found;
+	struct clone_root *clone_root;
 
 	/* First check if the root is in the list of accepted clone sources */
-	found = bsearch((void *)(uintptr_t)root, bctx->sctx->clone_roots,
-			bctx->sctx->clone_roots_cnt,
-			sizeof(struct clone_root),
-			__clone_root_cmp_bsearch);
-	if (!found)
+	clone_root = bsearch((void *)(uintptr_t)root_id, bctx->sctx->clone_roots,
+			     bctx->sctx->clone_roots_cnt,
+			     sizeof(struct clone_root),
+			     __clone_root_cmp_bsearch);
+	if (!clone_root)
 		return 0;
 
-	if (found->root == bctx->sctx->send_root &&
+	/* This is our own reference, bail out as we can't clone from it. */
+	if (clone_root->root == bctx->sctx->send_root &&
 	    ino == bctx->cur_objectid &&
-	    offset == bctx->cur_offset) {
-		bctx->found_itself = 1;
-	}
+	    offset == bctx->cur_offset)
+		return 0;
 
 	/*
 	 * Make sure we don't consider clones from send_root that are
 	 * behind the current inode/offset.
 	 */
-	if (found->root == bctx->sctx->send_root) {
+	if (clone_root->root == bctx->sctx->send_root) {
 		/*
 		 * If the source inode was not yet processed we can't issue a
 		 * clone operation, as the source extent does not exist yet at
@@ -1359,7 +1356,7 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root,
 	}
 
 	bctx->found++;
-	found->found_refs++;
+	clone_root->found_ref = true;
 
 	/*
 	 * If the given backref refers to a file extent item with a larger
@@ -1367,10 +1364,17 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root,
 	 * we clone more optimally and end up doing less writes and getting
 	 * less exclusive, non-shared extents at the destination.
 	 */
-	if (num_bytes > found->num_bytes) {
-		found->ino = ino;
-		found->offset = offset;
-		found->num_bytes = num_bytes;
+	if (num_bytes > clone_root->num_bytes) {
+		clone_root->ino = ino;
+		clone_root->offset = offset;
+		clone_root->num_bytes = num_bytes;
+
+		/*
+		 * Found a perfect candidate, so there's no need to continue
+		 * backref walking.
+		 */
+		if (num_bytes >= bctx->extent_len)
+			return BTRFS_ITERATE_EXTENT_INODES_STOP;
 	}
 
 	return 0;
@@ -1392,7 +1396,8 @@ static void empty_backref_cache(struct send_ctx *sctx)
 static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 				 const u64 **root_ids_ret, int *root_count_ret)
 {
-	struct send_ctx *sctx = ctx;
+	struct backref_ctx *bctx = ctx;
+	struct send_ctx *sctx = bctx->sctx;
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
 	struct backref_cache_entry *entry;
@@ -1430,7 +1435,8 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 				void *ctx)
 {
-	struct send_ctx *sctx = ctx;
+	struct backref_ctx *bctx = ctx;
+	struct send_ctx *sctx = bctx->sctx;
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	struct backref_cache_entry *new_entry;
 	struct ulist_iterator uiter;
@@ -1618,7 +1624,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 		cur_clone_root->ino = (u64)-1;
 		cur_clone_root->offset = 0;
 		cur_clone_root->num_bytes = 0;
-		cur_clone_root->found_refs = 0;
+		cur_clone_root->found_ref = false;
 	}
 
 	backref_ctx.sctx = sctx;
@@ -1628,7 +1634,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	/*
 	 * The last extent of a file may be too large due to page alignment.
 	 * We need to adjust extent_len in this case so that the checks in
-	 * __iterate_backrefs work.
+	 * iterate_backrefs() work.
 	 */
 	if (data_offset + num_bytes >= ino_size)
 		backref_ctx.extent_len = ino_size - data_offset;
@@ -1644,9 +1650,10 @@ static int find_extent_clone(struct send_ctx *sctx,
 	backref_walk_ctx.fs_info = fs_info;
 	backref_walk_ctx.cache_lookup = lookup_backref_cache;
 	backref_walk_ctx.cache_store = store_backref_cache;
-	backref_walk_ctx.user_ctx = sctx;
+	backref_walk_ctx.indirect_ref_iterator = iterate_backrefs;
+	backref_walk_ctx.user_ctx = &backref_ctx;
 
-	ret = iterate_extent_inodes(&backref_walk_ctx, true, __iterate_backrefs,
+	ret = iterate_extent_inodes(&backref_walk_ctx, true, iterate_backrefs,
 				    &backref_ctx);
 	if (ret < 0)
 		goto out;
@@ -1671,27 +1678,21 @@ static int find_extent_clone(struct send_ctx *sctx,
 	}
 	up_read(&fs_info->commit_root_sem);
 
-	if (!backref_ctx.found_itself) {
-		/* found a bug in backref code? */
-		ret = -EIO;
-		btrfs_err(fs_info,
-			  "did not find backref in send_root. inode=%llu, offset=%llu, disk_byte=%llu found extent=%llu",
-			  ino, data_offset, disk_byte, found_key.objectid);
-		goto out;
-	}
-
 	btrfs_debug(fs_info,
 		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
 		    data_offset, ino, num_bytes, logical);
 
-	if (!backref_ctx.found)
+	if (!backref_ctx.found) {
 		btrfs_debug(fs_info, "no clones found");
+		ret = -ENOENT;
+		goto out;
+	}
 
 	cur_clone_root = NULL;
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
 		struct clone_root *clone_root = &sctx->clone_roots[i];
 
-		if (clone_root->found_refs == 0)
+		if (!clone_root->found_ref)
 			continue;
 
 		/*
-- 
2.35.1

