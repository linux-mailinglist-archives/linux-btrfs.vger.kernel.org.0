Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB64614F05
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiKAQQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKAQQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A51C93C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B23611DA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA0C43470
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319372;
        bh=6epLISEFfyI08/+Qeoi+bykpHG6wNUweJJcKWNKrMV8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Aq6XvGB7eki/Gi1YyXrxaAKg2293RoZl91ZLylvSgn2miqP0MCc+knnEkCYGUmnAN
         gid6x7MA20OcjNZ7XqIYh8LWmfYZ6gjC35Tffq3G4nYvzcBOQls/AEn42AnomyRsJS
         xkzyEL2mwe1qH6IVqpQoUu+6iH5+IBdVcalz4CzlhHT/qY3MsDPjVSd41kT8d/pBTQ
         3PoSudwNTuKfbdf6WFzKsr2W3sgGSPWQZIPEdzsHJjDMpMh/SzLU1fBxizdp6Axh7C
         5i6O2WY/5ebXwoMMFBr2IGG/xBgr/9D+jz4w+xJBs5F/bFBPtyjdyr6+ia8hQ/JsmI
         RaMLCCZo5FVxg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/18] btrfs: send: avoid double extent tree search when finding clone source
Date:   Tue,  1 Nov 2022 16:15:52 +0000
Message-Id: <62dff1edae3e169e7f7095a65a3af87bb6c4099c.1667315100.git.fdmanana@suse.com>
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

At find_extent_clone() we search twice for the extent item corresponding
to the data extent that the current file extent items points to:

1) Once with a call to extent_from_logical();

2) Once again during backref walking, through iterate_extent_inodes()
   which eventually leads to find_parent_nodes() where we will search
   again the extent tree for the same extent item.

The extent tree can be huge, so doing this one extra search for every
extent we want to send adds up and it's expensive.

The first call is there since the send code was introduced and it
accomplishes two things:

1) Check that the extent is flagged as a data extent in the extent tree.
   But it can not be anything else, otherwise we wouldn't have a file
   extent item in the send root pointing to it.
   This was probably added to catch bugs in the early days where send was
   yet too young and the interaction with everything else was far from
   perfect;

2) Check how many direct references there are on the extent, and if
   there's too many (more than SEND_MAX_EXTENT_REFS), avoid doing the
   backred walking as it may take too long and slowdown send.

So improve on this by having a callback in the backref walking code that
is called when it finds the extent item in the extent tree, and have those
checks done in the callback. When the callback returns anything different
from 0, it stops the backref walking code. This way we do a single search
on the extent tree for the extent item of our data extent.

Also, before this change we were only checking the number of references on
the data extent against SEND_MAX_EXTENT_REFS, but after starting backref
walking we will end up resolving backrefs for extent buffers in the path
from a leaf having a file extent item pointing to our data extent, up to
roots of trees from which the extent buffer is accessible from, due to
shared subtrees resulting from snapshoting. We were therefore allowing for
the possibility for send taking too long due to some node in the path from
the leaf to a root node being shared too many times. After this change we
check for reference counts being greater than SEND_MAX_EXTENT_REFS for
both data extents and metadata extents.

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
 fs/btrfs/backref.c |  31 ++++++++------
 fs/btrfs/backref.h |   9 +++-
 fs/btrfs/send.c    | 103 +++++++++++++++++++++------------------------
 3 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index bb59ba68d7ee..33056c4c0528 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1003,8 +1003,8 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
  *
  * Returns 0 on success, <0 on error, or BACKREF_FOUND_SHARED.
  */
-static int add_inline_refs(const struct btrfs_fs_info *fs_info,
-			   struct btrfs_path *path, u64 bytenr,
+static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
+			   struct btrfs_path *path,
 			   int *info_level, struct preftrees *preftrees,
 			   struct share_check *sc)
 {
@@ -1029,6 +1029,13 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+
+	if (ctx->check_extent_item) {
+		ret = ctx->check_extent_item(ctx->bytenr, ei, leaf, ctx->user_ctx);
+		if (ret)
+			return ret;
+	}
+
 	flags = btrfs_extent_flags(leaf, ei);
 	btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
@@ -1064,9 +1071,9 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 
 		switch (type) {
 		case BTRFS_SHARED_BLOCK_REF_KEY:
-			ret = add_direct_ref(fs_info, preftrees,
+			ret = add_direct_ref(ctx->fs_info, preftrees,
 					     *info_level + 1, offset,
-					     bytenr, 1, NULL, GFP_NOFS);
+					     ctx->bytenr, 1, NULL, GFP_NOFS);
 			break;
 		case BTRFS_SHARED_DATA_REF_KEY: {
 			struct btrfs_shared_data_ref *sdref;
@@ -1075,14 +1082,14 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 			sdref = (struct btrfs_shared_data_ref *)(iref + 1);
 			count = btrfs_shared_data_ref_count(leaf, sdref);
 
-			ret = add_direct_ref(fs_info, preftrees, 0, offset,
-					     bytenr, count, sc, GFP_NOFS);
+			ret = add_direct_ref(ctx->fs_info, preftrees, 0, offset,
+					     ctx->bytenr, count, sc, GFP_NOFS);
 			break;
 		}
 		case BTRFS_TREE_BLOCK_REF_KEY:
-			ret = add_indirect_ref(fs_info, preftrees, offset,
+			ret = add_indirect_ref(ctx->fs_info, preftrees, offset,
 					       NULL, *info_level + 1,
-					       bytenr, 1, NULL, GFP_NOFS);
+					       ctx->bytenr, 1, NULL, GFP_NOFS);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY: {
 			struct btrfs_extent_data_ref *dref;
@@ -1104,8 +1111,8 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 
 			root = btrfs_extent_data_ref_root(leaf, dref);
 
-			ret = add_indirect_ref(fs_info, preftrees, root,
-					       &key, 0, bytenr, count,
+			ret = add_indirect_ref(ctx->fs_info, preftrees, root,
+					       &key, 0, ctx->bytenr, count,
 					       sc, GFP_NOFS);
 
 			break;
@@ -1455,8 +1462,8 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 		if (key.objectid == ctx->bytenr &&
 		    (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		     key.type == BTRFS_METADATA_ITEM_KEY)) {
-			ret = add_inline_refs(ctx->fs_info, path, ctx->bytenr,
-					      &info_level, &preftrees, sc);
+			ret = add_inline_refs(ctx, path, &info_level,
+					      &preftrees, sc);
 			if (ret)
 				goto out;
 			ret = add_keyed_refs(root, path, ctx->bytenr, info_level,
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index a80d1e8be718..1bd5a15c7f9e 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -109,9 +109,14 @@ struct btrfs_backref_walk_ctx {
 	 */
 	iterate_extent_inodes_t *indirect_ref_iterator;
 	/*
-	 * Context object to pass to the @cache_lookup, @cache_store and
-	 * @indirect_ref_iterator callbacks.
+	 * If this is not NULL, then the backref walking code will call this for
+	 * each extent item it's meant to process before it actually starts
+	 * processing it. If this returns anything other than 0, then it stops
+	 * the backref walking code immediately.
 	 */
+	int (*check_extent_item)(u64 bytenr, const struct btrfs_extent_item *ei,
+				 const struct extent_buffer *leaf, void *user_ctx);
+	/* Context object to pass to the callbacks defined above. */
 	void *user_ctx;
 };
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 67f82793315c..f91cc95a0a3b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1281,6 +1281,9 @@ struct backref_ctx {
 
 	/* may be truncated in case it's the last extent in a file */
 	u64 extent_len;
+
+	/* The bytenr the file extent item we are processing refers to. */
+	u64 bytenr;
 };
 
 static int __clone_root_cmp_bsearch(const void *key, const void *elt)
@@ -1518,6 +1521,43 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	sctx->backref_cache.size++;
 }
 
+static int check_extent_item(u64 bytenr, const struct btrfs_extent_item *ei,
+			     const struct extent_buffer *leaf, void *ctx)
+{
+	const u64 refs = btrfs_extent_refs(leaf, ei);
+	const struct backref_ctx *bctx = ctx;
+	const struct send_ctx *sctx = bctx->sctx;
+
+	if (bytenr == bctx->bytenr) {
+		const u64 flags = btrfs_extent_flags(leaf, ei);
+
+		if (WARN_ON(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
+			return -EUCLEAN;
+
+		/*
+		 * If we have only one reference and only the send root as a
+		 * clone source - meaning no clone roots were given in the
+		 * struct btrfs_ioctl_send_args passed to the send ioctl - then
+		 * it's our reference and there's no point in doing backref
+		 * walking which is expensive, so exit early.
+		 */
+		if (refs == 1 && sctx->clone_roots_cnt == 1)
+			return -ENOENT;
+	}
+
+	/*
+	 * Backreference walking (iterate_extent_inodes() below) is currently
+	 * too expensive when an extent has a large number of references, both
+	 * in time spent and used memory. So for now just fallback to write
+	 * operations instead of clone operations when an extent has more than
+	 * a certain amount of references.
+	 */
+	if (refs > SEND_MAX_EXTENT_REFS)
+		return -ENOENT;
+
+	return 0;
+}
+
 /*
  * Given an inode, offset and extent item, it finds a good clone for a clone
  * instruction. Returns -ENOENT when none could be found. The function makes
@@ -1539,16 +1579,11 @@ static int find_extent_clone(struct send_ctx *sctx,
 	u64 logical;
 	u64 disk_byte;
 	u64 num_bytes;
-	u64 extent_refs;
-	u64 flags = 0;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = path->nodes[0];
 	struct backref_ctx backref_ctx = { 0 };
 	struct btrfs_backref_walk_ctx backref_walk_ctx = { 0 };
 	struct clone_root *cur_clone_root;
-	struct btrfs_key found_key;
-	struct btrfs_path *tmp_path;
-	struct btrfs_extent_item *ei;
 	int compressed;
 	u32 i;
 
@@ -1574,48 +1609,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 	num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 	logical = disk_byte + btrfs_file_extent_offset(eb, fi);
 
-	tmp_path = alloc_path_for_send();
-	if (!tmp_path)
-		return -ENOMEM;
-
-	/* We only use this path under the commit sem */
-	tmp_path->need_commit_sem = 0;
-
-	down_read(&fs_info->commit_root_sem);
-	ret = extent_from_logical(fs_info, disk_byte, tmp_path,
-				  &found_key, &flags);
-	up_read(&fs_info->commit_root_sem);
-
-	if (ret < 0)
-		goto out;
-	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-		ret = -EIO;
-		goto out;
-	}
-
-	ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
-			    struct btrfs_extent_item);
-	extent_refs = btrfs_extent_refs(tmp_path->nodes[0], ei);
-	/*
-	 * Backreference walking (iterate_extent_inodes() below) is currently
-	 * too expensive when an extent has a large number of references, both
-	 * in time spent and used memory. So for now just fallback to write
-	 * operations instead of clone operations when an extent has more than
-	 * a certain amount of references.
-	 *
-	 * Also, if we have only one reference and only the send root as a clone
-	 * source - meaning no clone roots were given in the struct
-	 * btrfs_ioctl_send_args passed to the send ioctl - then it's our
-	 * reference and there's no point in doing backref walking which is
-	 * expensive, so exit early.
-	 */
-	if ((extent_refs == 1 && sctx->clone_roots_cnt == 1) ||
-	    extent_refs > SEND_MAX_EXTENT_REFS) {
-		ret = -ENOENT;
-		goto out;
-	}
-	btrfs_release_path(tmp_path);
-
 	/*
 	 * Setup the clone roots.
 	 */
@@ -1630,6 +1623,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	backref_ctx.sctx = sctx;
 	backref_ctx.cur_objectid = ino;
 	backref_ctx.cur_offset = data_offset;
+	backref_ctx.bytenr = disk_byte;
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
@@ -1644,19 +1638,20 @@ static int find_extent_clone(struct send_ctx *sctx,
 	/*
 	 * Now collect all backrefs.
 	 */
-	backref_walk_ctx.bytenr = found_key.objectid;
+	backref_walk_ctx.bytenr = disk_byte;
 	if (compressed == BTRFS_COMPRESS_NONE)
-		backref_walk_ctx.extent_item_pos = logical - found_key.objectid;
+		backref_walk_ctx.extent_item_pos = btrfs_file_extent_offset(eb, fi);
 	backref_walk_ctx.fs_info = fs_info;
 	backref_walk_ctx.cache_lookup = lookup_backref_cache;
 	backref_walk_ctx.cache_store = store_backref_cache;
 	backref_walk_ctx.indirect_ref_iterator = iterate_backrefs;
+	backref_walk_ctx.check_extent_item = check_extent_item;
 	backref_walk_ctx.user_ctx = &backref_ctx;
 
 	ret = iterate_extent_inodes(&backref_walk_ctx, true, iterate_backrefs,
 				    &backref_ctx);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	down_read(&fs_info->commit_root_sem);
 	if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
@@ -1673,8 +1668,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 		 * was already reallocated after the relocation.
 		 */
 		up_read(&fs_info->commit_root_sem);
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 	up_read(&fs_info->commit_root_sem);
 
@@ -1684,8 +1678,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 
 	if (!backref_ctx.found) {
 		btrfs_debug(fs_info, "no clones found");
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	cur_clone_root = NULL;
@@ -1720,8 +1713,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 		ret = -ENOENT;
 	}
 
-out:
-	btrfs_free_path(tmp_path);
 	return ret;
 }
 
-- 
2.35.1

