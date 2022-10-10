Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6795F9CB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJJKXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiJJKWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0566B163
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DED560EC9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642D6C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397357;
        bh=h6zog3RQEke90JQcSjx/mwsCneNlC2/aILgaCxXAeNI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SV2PYRgCSxlMRrq49xMVxI597DYNlP0PEWs2U2WGfXf6pvhOicP3/G/4naaVHiwEU
         iEyCMdpcUqT83Mfu/MISZYKOeK/vfPQkf4S56T4OPY6jtkPE0cdQ5/pkS+l+up0usD
         EYjJvT6HUITZnIesatVGFt0VrWkjrpE5vJ/K8Cz4lNtZPvDT8Ebw0ei49u7sBC9ryd
         PgyhCIb5oCHCLytJnIQ7Wu8cGiRaO2uOMWtwD0lLHBtrh0ag7tnufKIC/iKX87HX8g
         l0R4n7uiZ8dgyIt8xPrNnDwqxaM9pSDvihp0xQfzUROccth+/M+vu+qm4zJ8AJxBze
         WlL5Ulh7THuLA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/18] btrfs: move up backref sharedness cache store and lookup functions
Date:   Mon, 10 Oct 2022 11:22:18 +0100
Message-Id: <4feb670d89ca1506088d461df2db30fbb40d689e.1665396437.git.fdmanana@suse.com>
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

Move the static functions to lookup and store sharedness check of an
extent buffer to a location above find_all_parents(), because in the
next patch the lookup function will be used by find_all_parents().
The store function is also moved just because it's the counter part
to the lookup function and it's best to have their definitions close
together.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 236 ++++++++++++++++++++++-----------------------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8d4e7ddbefb4..977f07903156 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1167,6 +1167,124 @@ static int add_keyed_refs(struct btrfs_root *extent_root,
 	return ret;
 }
 
+/*
+ * The caller has joined a transaction or is holding a read lock on the
+ * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
+ * snapshot field changing while updating or checking the cache.
+ */
+static bool lookup_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
+					struct btrfs_root *root,
+					u64 bytenr, int level, bool *is_shared)
+{
+	struct btrfs_backref_shared_cache_entry *entry;
+
+	if (!ctx->use_path_cache)
+		return false;
+
+	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
+		return false;
+
+	/*
+	 * Level -1 is used for the data extent, which is not reliable to cache
+	 * because its reference count can increase or decrease without us
+	 * realizing. We cache results only for extent buffers that lead from
+	 * the root node down to the leaf with the file extent item.
+	 */
+	ASSERT(level >= 0);
+
+	entry = &ctx->path_cache_entries[level];
+
+	/* Unused cache entry or being used for some other extent buffer. */
+	if (entry->bytenr != bytenr)
+		return false;
+
+	/*
+	 * We cached a false result, but the last snapshot generation of the
+	 * root changed, so we now have a snapshot. Don't trust the result.
+	 */
+	if (!entry->is_shared &&
+	    entry->gen != btrfs_root_last_snapshot(&root->root_item))
+		return false;
+
+	/*
+	 * If we cached a true result and the last generation used for dropping
+	 * a root changed, we can not trust the result, because the dropped root
+	 * could be a snapshot sharing this extent buffer.
+	 */
+	if (entry->is_shared &&
+	    entry->gen != btrfs_get_last_root_drop_gen(root->fs_info))
+		return false;
+
+	*is_shared = entry->is_shared;
+	/*
+	 * If the node at this level is shared, than all nodes below are also
+	 * shared. Currently some of the nodes below may be marked as not shared
+	 * because we have just switched from one leaf to another, and switched
+	 * also other nodes above the leaf and below the current level, so mark
+	 * them as shared.
+	 */
+	if (*is_shared) {
+		for (int i = 0; i < level; i++) {
+			ctx->path_cache_entries[i].is_shared = true;
+			ctx->path_cache_entries[i].gen = entry->gen;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * The caller has joined a transaction or is holding a read lock on the
+ * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
+ * snapshot field changing while updating or checking the cache.
+ */
+static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
+				       struct btrfs_root *root,
+				       u64 bytenr, int level, bool is_shared)
+{
+	struct btrfs_backref_shared_cache_entry *entry;
+	u64 gen;
+
+	if (!ctx->use_path_cache)
+		return;
+
+	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
+		return;
+
+	/*
+	 * Level -1 is used for the data extent, which is not reliable to cache
+	 * because its reference count can increase or decrease without us
+	 * realizing. We cache results only for extent buffers that lead from
+	 * the root node down to the leaf with the file extent item.
+	 */
+	ASSERT(level >= 0);
+
+	if (is_shared)
+		gen = btrfs_get_last_root_drop_gen(root->fs_info);
+	else
+		gen = btrfs_root_last_snapshot(&root->root_item);
+
+	entry = &ctx->path_cache_entries[level];
+	entry->bytenr = bytenr;
+	entry->is_shared = is_shared;
+	entry->gen = gen;
+
+	/*
+	 * If we found an extent buffer is shared, set the cache result for all
+	 * extent buffers below it to true. As nodes in the path are COWed,
+	 * their sharedness is moved to their children, and if a leaf is COWed,
+	 * then the sharedness of a data extent becomes direct, the refcount of
+	 * data extent is increased in the extent item at the extent tree.
+	 */
+	if (is_shared) {
+		for (int i = 0; i < level; i++) {
+			entry = &ctx->path_cache_entries[i];
+			entry->is_shared = is_shared;
+			entry->gen = gen;
+		}
+	}
+}
+
 /*
  * this adds all existing backrefs (inline backrefs, backrefs and delayed
  * refs) for the given bytenr to the refs list, merges duplicates and resolves
@@ -1546,124 +1664,6 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * The caller has joined a transaction or is holding a read lock on the
- * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
- * snapshot field changing while updating or checking the cache.
- */
-static bool lookup_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
-					struct btrfs_root *root,
-					u64 bytenr, int level, bool *is_shared)
-{
-	struct btrfs_backref_shared_cache_entry *entry;
-
-	if (!ctx->use_path_cache)
-		return false;
-
-	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
-		return false;
-
-	/*
-	 * Level -1 is used for the data extent, which is not reliable to cache
-	 * because its reference count can increase or decrease without us
-	 * realizing. We cache results only for extent buffers that lead from
-	 * the root node down to the leaf with the file extent item.
-	 */
-	ASSERT(level >= 0);
-
-	entry = &ctx->path_cache_entries[level];
-
-	/* Unused cache entry or being used for some other extent buffer. */
-	if (entry->bytenr != bytenr)
-		return false;
-
-	/*
-	 * We cached a false result, but the last snapshot generation of the
-	 * root changed, so we now have a snapshot. Don't trust the result.
-	 */
-	if (!entry->is_shared &&
-	    entry->gen != btrfs_root_last_snapshot(&root->root_item))
-		return false;
-
-	/*
-	 * If we cached a true result and the last generation used for dropping
-	 * a root changed, we can not trust the result, because the dropped root
-	 * could be a snapshot sharing this extent buffer.
-	 */
-	if (entry->is_shared &&
-	    entry->gen != btrfs_get_last_root_drop_gen(root->fs_info))
-		return false;
-
-	*is_shared = entry->is_shared;
-	/*
-	 * If the node at this level is shared, than all nodes below are also
-	 * shared. Currently some of the nodes below may be marked as not shared
-	 * because we have just switched from one leaf to another, and switched
-	 * also other nodes above the leaf and below the current level, so mark
-	 * them as shared.
-	 */
-	if (*is_shared) {
-		for (int i = 0; i < level; i++) {
-			ctx->path_cache_entries[i].is_shared = true;
-			ctx->path_cache_entries[i].gen = entry->gen;
-		}
-	}
-
-	return true;
-}
-
-/*
- * The caller has joined a transaction or is holding a read lock on the
- * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
- * snapshot field changing while updating or checking the cache.
- */
-static void store_backref_shared_cache(struct btrfs_backref_share_check_ctx *ctx,
-				       struct btrfs_root *root,
-				       u64 bytenr, int level, bool is_shared)
-{
-	struct btrfs_backref_shared_cache_entry *entry;
-	u64 gen;
-
-	if (!ctx->use_path_cache)
-		return;
-
-	if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
-		return;
-
-	/*
-	 * Level -1 is used for the data extent, which is not reliable to cache
-	 * because its reference count can increase or decrease without us
-	 * realizing. We cache results only for extent buffers that lead from
-	 * the root node down to the leaf with the file extent item.
-	 */
-	ASSERT(level >= 0);
-
-	if (is_shared)
-		gen = btrfs_get_last_root_drop_gen(root->fs_info);
-	else
-		gen = btrfs_root_last_snapshot(&root->root_item);
-
-	entry = &ctx->path_cache_entries[level];
-	entry->bytenr = bytenr;
-	entry->is_shared = is_shared;
-	entry->gen = gen;
-
-	/*
-	 * If we found an extent buffer is shared, set the cache result for all
-	 * extent buffers below it to true. As nodes in the path are COWed,
-	 * their sharedness is moved to their children, and if a leaf is COWed,
-	 * then the sharedness of a data extent becomes direct, the refcount of
-	 * data extent is increased in the extent item at the extent tree.
-	 */
-	if (is_shared) {
-		for (int i = 0; i < level; i++) {
-			entry = &ctx->path_cache_entries[i];
-			entry->is_shared = is_shared;
-			entry->gen = gen;
-		}
-	}
-}
-
 struct btrfs_backref_share_check_ctx *btrfs_alloc_backref_share_check_ctx(void)
 {
 	struct btrfs_backref_share_check_ctx *ctx;
-- 
2.35.1

