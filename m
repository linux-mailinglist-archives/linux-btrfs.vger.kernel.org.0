Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0FE5FB238
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJKMRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJKMR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:17:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3454D175
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ADBDB815B8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C600DC433D7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665490644;
        bh=n7NQYqjf/XaCWN+KPbwJMri/o17Ib5af54YuXqnsps4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=giRsvgZXXRNZcA8hnX1W7HQ+QSoH1ujGNLi+K1YCW2YLczEjc/Ig17MemzSR4LrhK
         0A0r9TG9Lj/JZr102OVioAFNdxk9li7uz6pJj+AOXJQkCkVduGEwg2oIAydzSp1XBH
         QBBrYso+7jMaZigOu5D9jdSljn27m0UUbawkdd2J/nk6kGXVjO1+G6VT6u+RKwD0N9
         qJo9IMQbTc+m6J4QY+gw5dp3QpChoI4+fbQigWXq2O/dg1qRNRVOCjxwaoVvS7fgJh
         xWsl+1y9rvfI+OvaRmdaF2bhyGXZoEcFtVomItLtE0FwyA9zjjP6/PnVlj0b2HjwmH
         PaMcYvAH5Ipzw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/19] btrfs: move ulists to data extent sharedness check context
Date:   Tue, 11 Oct 2022 13:17:03 +0100
Message-Id: <5ac0dbfe0f5e4c33aed93ffd266f536d224c507f.1665490018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
References: <cover.1665490018.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When calling btrfs_is_data_extent_shared() we pass two ulists that were
allocated by the caller. This is because the single caller, fiemap, calls
btrfs_is_data_extent_shared() multiple times and the ulists can be reused,
instead of allocating new ones before each call and freeing them after
each call.

Now that we have a context structure/object that we pass to
btrfs_is_data_extent_shared(), we can move those ulists to it, and hide
their allocation and the context's allocation in a helper function, as
well as the freeing of the ulists and the context object. This allows to
reduce the number of parameters passed to btrfs_is_data_extent_shared(),
the need to pass the ulists from extent_fiemap() to fiemap_process_hole()
and having the caller deal with allocating and releasing the ulists.

Also rename one of the ulists from 'tmp' / 'tmp_ulist' to 'refs', since
that's a much better name as it reflects what the list is used for (and
matching the argument name for find_parent_nodes()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   | 43 ++++++++++++++++++++++++++++++++-----------
 fs/btrfs/backref.h   |  7 ++++++-
 fs/btrfs/extent_io.c | 34 ++++++++++------------------------
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a8879c12f092..80a21783fc1e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1641,6 +1641,30 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
 	}
 }
 
+struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void)
+{
+	struct btrfs_backref_share_check_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ulist_init(&ctx->refs);
+	ulist_init(&ctx->roots);
+
+	return ctx;
+}
+
+void btrfs_free_backref_share_ctx(struct btrfs_backref_share_check_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	ulist_release(&ctx->refs);
+	ulist_release(&ctx->roots);
+	kfree(ctx);
+}
+
 /*
  * Check if a data extent is shared or not.
  *
@@ -1648,8 +1672,6 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
  * @bytenr:      Logical bytenr of the extent we are checking.
  * @extent_gen:  Generation of the extent (file extent item) or 0 if it is
  *               not known.
- * @roots:       List of roots this extent is shared among.
- * @tmp:         Temporary list used for iteration.
  * @ctx:         A backref sharedness check context.
  *
  * btrfs_is_data_extent_shared uses the backref walking code but will short
@@ -1665,7 +1687,6 @@ static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx
  */
 int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
-				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_share_check_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
@@ -1683,8 +1704,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	};
 	int level;
 
-	ulist_init(roots);
-	ulist_init(tmp);
+	ulist_init(&ctx->roots);
+	ulist_init(&ctx->refs);
 
 	trans = btrfs_join_transaction_nostart(root);
 	if (IS_ERR(trans)) {
@@ -1706,8 +1727,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		bool is_shared;
 		bool cached;
 
-		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, tmp,
-					roots, NULL, &shared, false);
+		ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, &ctx->refs,
+					&ctx->roots, NULL, &shared, false);
 		if (ret == BACKREF_FOUND_SHARED) {
 			/* this is the only condition under which we return 1 */
 			ret = 1;
@@ -1746,13 +1767,13 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		 * deal with), we can not use it if we have multiple leaves
 		 * (which implies multiple paths).
 		 */
-		if (level == -1 && tmp->nnodes > 1)
+		if (level == -1 && ctx->refs.nnodes > 1)
 			ctx->use_path_cache = false;
 
 		if (level >= 0)
 			store_backref_shared_cache(ctx, root, bytenr,
 						   level, false);
-		node = ulist_next(tmp, &uiter);
+		node = ulist_next(&ctx->refs, &uiter);
 		if (!node)
 			break;
 		bytenr = node->val;
@@ -1775,8 +1796,8 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		up_read(&fs_info->commit_root_sem);
 	}
 out:
-	ulist_release(roots);
-	ulist_release(tmp);
+	ulist_release(&ctx->roots);
+	ulist_release(&ctx->refs);
 	return ret;
 }
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index e3a2b45a76e3..8da0ba6b94a4 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -24,6 +24,9 @@ struct btrfs_backref_shared_cache_entry {
 };
 
 struct btrfs_backref_share_check_ctx {
+	/* Ulists used during backref walking. */
+	struct ulist refs;
+	struct ulist roots;
 	/*
 	 * A path from a root to a leaf that has a file extent item pointing to
 	 * a given data extent should never exceed the maximum b+tree height.
@@ -35,6 +38,9 @@ struct btrfs_backref_share_check_ctx {
 typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
 		void *ctx);
 
+struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void);
+void btrfs_free_backref_share_ctx(struct btrfs_backref_share_check_ctx *ctx);
+
 int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 			struct btrfs_path *path, struct btrfs_key *found_key,
 			u64 *flags);
@@ -79,7 +85,6 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 *found_off);
 int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
-				struct ulist *roots, struct ulist *tmp,
 				struct btrfs_backref_share_check_ctx *ctx);
 
 int __init btrfs_prelim_ref_init(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b502a0d3da90..de62bdf11b33 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3711,7 +3711,6 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 			       struct btrfs_backref_share_check_ctx *backref_ctx,
 			       u64 disk_bytenr, u64 extent_offset,
 			       u64 extent_gen,
-			       struct ulist *roots, struct ulist *tmp_ulist,
 			       u64 start, u64 end)
 {
 	const u64 i_size = i_size_read(&inode->vfs_inode);
@@ -3755,10 +3754,9 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		if (prealloc_len > 0) {
 			if (!checked_extent_shared && fieinfo->fi_extents_max) {
 				ret = btrfs_is_data_extent_shared(inode,
-							  disk_bytenr,
-							  extent_gen, roots,
-							  tmp_ulist,
-							  backref_ctx);
+								  disk_bytenr,
+								  extent_gen,
+								  backref_ctx);
 				if (ret < 0)
 					return ret;
 				else if (ret > 0)
@@ -3806,8 +3804,7 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		if (!checked_extent_shared && fieinfo->fi_extents_max) {
 			ret = btrfs_is_data_extent_shared(inode,
 							  disk_bytenr,
-							  extent_gen, roots,
-							  tmp_ulist,
+							  extent_gen,
 							  backref_ctx);
 			if (ret < 0)
 				return ret;
@@ -3908,8 +3905,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
-	struct ulist *roots;
-	struct ulist *tmp_ulist;
 	u64 last_extent_end;
 	u64 prev_extent_end;
 	u64 lockstart;
@@ -3917,11 +3912,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	bool stopped = false;
 	int ret;
 
-	backref_ctx = kzalloc(sizeof(*backref_ctx), GFP_KERNEL);
+	backref_ctx = btrfs_alloc_backref_share_check_ctx();
 	path = btrfs_alloc_path();
-	roots = ulist_alloc(GFP_KERNEL);
-	tmp_ulist = ulist_alloc(GFP_KERNEL);
-	if (!backref_ctx || !path || !roots || !tmp_ulist) {
+	if (!backref_ctx || !path) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -3982,7 +3975,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  backref_ctx, 0, 0, 0,
-						  roots, tmp_ulist,
 						  prev_extent_end, range_end);
 			if (ret < 0) {
 				goto out_unlock;
@@ -4024,13 +4016,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  backref_ctx,
 						  disk_bytenr, extent_offset,
-						  extent_gen, roots, tmp_ulist,
-						  key.offset, extent_end - 1);
+						  extent_gen, key.offset,
+						  extent_end - 1);
 		} else if (disk_bytenr == 0) {
 			/* We have an explicit hole. */
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  backref_ctx, 0, 0, 0,
-						  roots, tmp_ulist,
 						  key.offset, extent_end - 1);
 		} else {
 			/* We have a regular extent. */
@@ -4038,8 +4029,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 				ret = btrfs_is_data_extent_shared(inode,
 								  disk_bytenr,
 								  extent_gen,
-								  roots,
-								  tmp_ulist,
 								  backref_ctx);
 				if (ret < 0)
 					goto out_unlock;
@@ -4090,8 +4079,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 	if (!stopped && prev_extent_end < lockend) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache, backref_ctx,
-					  0, 0, 0, roots, tmp_ulist,
-					  prev_extent_end, lockend - 1);
+					  0, 0, 0, prev_extent_end, lockend - 1);
 		if (ret < 0)
 			goto out_unlock;
 		prev_extent_end = lockend;
@@ -4122,10 +4110,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 out:
-	kfree(backref_ctx);
+	btrfs_free_backref_share_ctx(backref_ctx);
 	btrfs_free_path(path);
-	ulist_free(roots);
-	ulist_free(tmp_ulist);
 	return ret;
 }
 
-- 
2.35.1

