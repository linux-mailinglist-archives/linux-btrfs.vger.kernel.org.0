Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D495F9CAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiJJKW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiJJKWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC596B15B
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D0C60ECC
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0F4C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397353;
        bh=Z5PLXP45KImDpmkd8NILFVagq5MWja+59B03vNdEuSk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eNKyNkjIo+pdgPIm8UDzP4GLEu7W7y2bAbn9B9mQpJqJpz9kjD7E5uY/GT/MW+0t2
         NQUtNl8yhZ9PVjgclXisr7YXNprMnSh15Bw2ltEqMXF66phgr1+MLXNk7VT/X3Ytoz
         Kscsm6jO72d292Z5Bg4Jcsyn190+X3Y0DnDs0Y6d/PiPLTGjoxPfti56ZQRrwCtNAi
         oCdVkfURbLgHmEPqfyerF6QCfD8TsecMKK3P7p6/E1Yx2wGEESgwbogPhRpWtMA0Qe
         k/U64GqarsghB+OEaSZUctCBUEsAYgl/WaeQVgpeH79dixDrAUFhOq3lFmmOmrEBtr
         zHChQ7jfzFmdg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/18] btrfs: turn the backref sharedness check cache into a context object
Date:   Mon, 10 Oct 2022 11:22:13 +0100
Message-Id: <0189681fe561ba8502d7c556bdbb621482b5f1a9.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
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

Right now we are using a struct btrfs_backref_shared_cache to pass state
across multiple btrfs_is_data_extent_shared() calls. The structure's name
closely follows its current purpose, which is to cache previous checks
for the sharedness of metadata extents. However we will start using the
structure for more things other than caching sharedness checks, so rename
it to struct btrfs_backref_share_check_ctx.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   | 32 ++++++++++++++++----------------
 fs/btrfs/backref.h   |  8 ++++----
 fs/btrfs/extent_io.c | 24 ++++++++++++------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8effe318cd0c..36a8bc2971b1 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1515,13 +1515,13 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
  * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
  * snapshot field changing while updating or checking the cache.
  */
-static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
+static bool lookup_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
 					struct btrfs_root *root,
 					u64 bytenr, int level, bool *is_shared)
 {
 	struct btrfs_backref_shared_cache_entry *entry;
 
-	if (!cache->use_cache)
+	if (!ctx->use_path_cache)
 		return false;
 
 	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
@@ -1535,7 +1535,7 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache
 	 */
 	ASSERT(level >= 0);
 
-	entry = &cache->entries[level];
+	entry = &ctx->path_cache_entries[level];
 
 	/* Unused cache entry or being used for some other extent buffer. */
 	if (entry->bytenr != bytenr)
@@ -1568,8 +1568,8 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache
 	 */
 	if (*is_shared) {
 		for (int i = 0; i < level; i++) {
-			cache->entries[i].is_shared = true;
-			cache->entries[i].gen = entry->gen;
+			ctx->path_cache_entries[i].is_shared = true;
+			ctx->path_cache_entries[i].gen = entry->gen;
 		}
 	}
 
@@ -1581,14 +1581,14 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache
  * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
  * snapshot field changing while updating or checking the cache.
  */
-static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
+static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
 				       struct btrfs_root *root,
 				       u64 bytenr, int level, bool is_shared)
 {
 	struct btrfs_backref_shared_cache_entry *entry;
 	u64 gen;
 
-	if (!cache->use_cache)
+	if (!ctx->use_path_cache)
 		return;
 
 	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
@@ -1607,7 +1607,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 	else
 		gen = btrfs_root_last_snapshot(&root->root_item);
 
-	entry = &cache->entries[level];
+	entry = &ctx->path_cache_entries[level];
 	entry->bytenr = bytenr;
 	entry->is_shared = is_shared;
 	entry->gen = gen;
@@ -1621,7 +1621,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 	 */
 	if (is_shared) {
 		for (int i = 0; i < level; i++) {
-			entry = &cache->entries[i];
+			entry = &ctx->path_cache_entries[i];
 			entry->is_shared = is_shared;
 			entry->gen = gen;
 		}
@@ -1637,7 +1637,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
  *               not known.
  * @roots:       List of roots this extent is shared among.
  * @tmp:         Temporary list used for iteration.
- * @cache:       A backref lookup result cache.
+ * @ctx:         A backref sharedness check context.
  *
  * btrfs_is_data_extent_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
@@ -1653,7 +1653,7 @@ static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
 int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
-				struct btrfs_backref_shared_cache *cache)
+				struct btrfs_backref_share_check_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1687,7 +1687,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	/* -1 means we are in the bytenr of the data extent. */
 	level = -1;
 	ULIST_ITER_INIT(&uiter);
-	cache->use_cache = true;
+	ctx->use_path_cache = true;
 	while (1) {
 		bool is_shared;
 		bool cached;
@@ -1698,7 +1698,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 			/* this is the only condition under which we return 1 */
 			ret = 1;
 			if (level >= 0)
-				store_backref_shared_cache(cache, root, bytenr,
+				store_backref_shared_cache(ctx, root, bytenr,
 							   level, true);
 			break;
 		}
@@ -1733,17 +1733,17 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		 * (which implies multiple paths).
 		 */
 		if (level == -1 && tmp->nnodes > 1)
-			cache->use_cache = false;
+			ctx->use_path_cache = false;
 
 		if (level >= 0)
-			store_backref_shared_cache(cache, root, bytenr,
+			store_backref_shared_cache(ctx, root, bytenr,
 						   level, false);
 		node = ulist_next(tmp, &uiter);
 		if (!node)
 			break;
 		bytenr = node->val;
 		level++;
-		cached = lookup_backref_shared_cache(cache, root, bytenr, level,
+		cached = lookup_backref_shared_cache(ctx, root, bytenr, level,
 						     &is_shared);
 		if (cached) {
 			ret = (is_shared ? 1 : 0);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index c846fa2bdf93..e3a2b45a76e3 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -23,13 +23,13 @@ struct btrfs_backref_shared_cache_entry {
 	bool is_shared;
 };
 
-struct btrfs_backref_shared_cache {
+struct btrfs_backref_share_check_ctx {
 	/*
 	 * A path from a root to a leaf that has a file extent item pointing to
 	 * a given data extent should never exceed the maximum b+tree height.
 	 */
-	struct btrfs_backref_shared_cache_entry entries[BTRFS_MAX_LEVEL];
-	bool use_cache;
+	struct btrfs_backref_shared_cache_entry path_cache_entries[BTRFS_MAX_LEVEL];
+	bool use_path_cache;
 };
 
 typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
@@ -80,7 +80,7 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 				u64 extent_gen,
 				struct ulist *roots, struct ulist *tmp,
-				struct btrfs_backref_shared_cache *cache);
+				struct btrfs_backref_share_check_ctx *ctx);
 
 int __init btrfs_prelim_ref_init(void);
 void __cold btrfs_prelim_ref_exit(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 01feeb215bd9..b502a0d3da90 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3708,7 +3708,7 @@ static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path
 static int fiemap_process_hole(struct btrfs_inode *inode,
 			       struct fiemap_extent_info *fieinfo,
 			       struct fiemap_cache *cache,
-			       struct btrfs_backref_shared_cache *backref_cache,
+			       struct btrfs_backref_share_check_ctx *backref_ctx,
 			       u64 disk_bytenr, u64 extent_offset,
 			       u64 extent_gen,
 			       struct ulist *roots, struct ulist *tmp_ulist,
@@ -3758,7 +3758,7 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 							  disk_bytenr,
 							  extent_gen, roots,
 							  tmp_ulist,
-							  backref_cache);
+							  backref_ctx);
 				if (ret < 0)
 					return ret;
 				else if (ret > 0)
@@ -3808,7 +3808,7 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 							  disk_bytenr,
 							  extent_gen, roots,
 							  tmp_ulist,
-							  backref_cache);
+							  backref_ctx);
 			if (ret < 0)
 				return ret;
 			else if (ret > 0)
@@ -3907,7 +3907,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
-	struct btrfs_backref_shared_cache *backref_cache;
+	struct btrfs_backref_share_check_ctx *backref_ctx;
 	struct ulist *roots;
 	struct ulist *tmp_ulist;
 	u64 last_extent_end;
@@ -3917,11 +3917,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	bool stopped = false;
 	int ret;
 
-	backref_cache = kzalloc(sizeof(*backref_cache), GFP_KERNEL);
+	backref_ctx = kzalloc(sizeof(*backref_ctx), GFP_KERNEL);
 	path = btrfs_alloc_path();
 	roots = ulist_alloc(GFP_KERNEL);
 	tmp_ulist = ulist_alloc(GFP_KERNEL);
-	if (!backref_cache || !path || !roots || !tmp_ulist) {
+	if (!backref_ctx || !path || !roots || !tmp_ulist) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -3981,7 +3981,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			const u64 range_end = min(key.offset, lockend) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  backref_cache, 0, 0, 0,
+						  backref_ctx, 0, 0, 0,
 						  roots, tmp_ulist,
 						  prev_extent_end, range_end);
 			if (ret < 0) {
@@ -4022,14 +4022,14 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						 extent_len, flags);
 		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  backref_cache,
+						  backref_ctx,
 						  disk_bytenr, extent_offset,
 						  extent_gen, roots, tmp_ulist,
 						  key.offset, extent_end - 1);
 		} else if (disk_bytenr == 0) {
 			/* We have an explicit hole. */
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  backref_cache, 0, 0, 0,
+						  backref_ctx, 0, 0, 0,
 						  roots, tmp_ulist,
 						  key.offset, extent_end - 1);
 		} else {
@@ -4040,7 +4040,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  extent_gen,
 								  roots,
 								  tmp_ulist,
-								  backref_cache);
+								  backref_ctx);
 				if (ret < 0)
 					goto out_unlock;
 				else if (ret > 0)
@@ -4089,7 +4089,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	path = NULL;
 
 	if (!stopped && prev_extent_end < lockend) {
-		ret = fiemap_process_hole(inode, fieinfo, &cache, backref_cache,
+		ret = fiemap_process_hole(inode, fieinfo, &cache, backref_ctx,
 					  0, 0, 0, roots, tmp_ulist,
 					  prev_extent_end, lockend - 1);
 		if (ret < 0)
@@ -4122,7 +4122,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 out:
-	kfree(backref_cache);
+	kfree(backref_ctx);
 	btrfs_free_path(path);
 	ulist_free(roots);
 	ulist_free(tmp_ulist);
-- 
2.35.1

