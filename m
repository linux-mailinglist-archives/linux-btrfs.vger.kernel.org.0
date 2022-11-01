Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22C614EFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiKAQQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiKAQQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701411C909
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A147B81E25
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DCAC433C1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319368;
        bh=iSyxUGwEWB16etuwUo0C5aZdvGPQe5EuB0rQR4yO10g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VqAiimckiyThB5Q26RjEYTbnnhHChm3Etduht6P0tvhhyMGxKeP1lu/KsA2sygY78
         NICs0qoX1gbfFcZ78OF44WZPi7L9a/zbUohzWvhY4YMQqU2HRb2g8qVs+zqDum3kuM
         uh7DBimKRlZLh2UxCrwLxG5j+WmXQsA+VsdOMSJJEBiTqSeFox/HzbV7ygh9j9nKQB
         yCvD+mRCIis/vNNOFZTZZS7uy0xthSl7ZLOot8zQiTUXpXh4MQqsP52Yfv+Hd7xCUn
         MwAOOR9NM3i5sM/N2VQjO7qLK5P957qjpeOMGZi30uwmAn23qSd5gksbmwi9OtGOJN
         /udnNk5W0sEWA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/18] btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
Date:   Tue,  1 Nov 2022 16:15:48 +0000
Message-Id: <d5cc4e67f439b02572fa5899b95a08c6f83967f0.1667315100.git.fdmanana@suse.com>
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

At iterate_extent_inodes() we collect a ulist of leaves for a given extent
with a call to btrfs_find_all_leafs() and then we enter a loop where we
iterate over all the collected leaves. Each iteration of that loop does a
call to btrfs_find_all_roots_safe(), to determine all roots from which a
leaf is accessible, and that results in allocating and releasing a ulist
to store the root IDs.

Instead of allocating and releasing the roots ulist on every iteration,
allocate a ulist before entering the loop and keep using it on each
iteration, reinitializing the ulist at the end of each iteration.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a1a00a7bdba5..dc276ce3afe0 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1674,32 +1674,36 @@ int btrfs_find_all_leafs(struct btrfs_backref_walk_ctx *ctx)
  * the current while iterating. The process stops when we reach the end of the
  * list.
  *
- * Found roots are added to @ctx->roots, which is allocated by this function and
- * @ctx->roots should be NULL when calling this function. This function also
- * requires @ctx->refs to be NULL, as it uses it for allocating a ulist to do
- * temporary work, and frees it before returning.
+ * Found roots are added to @ctx->roots, which is allocated by this function if
+ * it points to NULL, in which case the caller is responsible for freeing it
+ * after it's not needed anymore.
+ * This function requires @ctx->refs to be NULL, as it uses it for allocating a
+ * ulist to do temporary work, and frees it before returning.
  *
- * Returns 0 on success, < 0 on error. On error @ctx->roots is always NULL.
+ * Returns 0 on success, < 0 on error.
  */
 static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 {
 	const u64 orig_bytenr = ctx->bytenr;
 	const bool orig_ignore_extent_item_pos = ctx->ignore_extent_item_pos;
+	bool roots_ulist_allocated = false;
 	struct ulist_iterator uiter;
 	int ret = 0;
 
 	ASSERT(ctx->refs == NULL);
-	ASSERT(ctx->roots == NULL);
 
 	ctx->refs = ulist_alloc(GFP_NOFS);
 	if (!ctx->refs)
 		return -ENOMEM;
 
-	ctx->roots = ulist_alloc(GFP_NOFS);
 	if (!ctx->roots) {
-		ulist_free(ctx->refs);
-		ctx->refs = NULL;
-		return -ENOMEM;
+		ctx->roots = ulist_alloc(GFP_NOFS);
+		if (!ctx->roots) {
+			ulist_free(ctx->refs);
+			ctx->refs = NULL;
+			return -ENOMEM;
+		}
+		roots_ulist_allocated = true;
 	}
 
 	ctx->ignore_extent_item_pos = true;
@@ -1710,8 +1714,10 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 
 		ret = find_parent_nodes(ctx, NULL);
 		if (ret < 0 && ret != -ENOENT) {
-			ulist_free(ctx->roots);
-			ctx->roots = NULL;
+			if (roots_ulist_allocated) {
+				ulist_free(ctx->roots);
+				ctx->roots = NULL;
+			}
 			break;
 		}
 		ret = 0;
@@ -2295,6 +2301,11 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 		    ctx->bytenr);
 
 	ASSERT(ctx->trans == NULL);
+	ASSERT(ctx->roots == NULL);
+
+	ctx->roots = ulist_alloc(GFP_NOFS);
+	if (!ctx->roots)
+		return -ENOMEM;
 
 	if (!search_commit_root) {
 		struct btrfs_trans_handle *trans;
@@ -2302,8 +2313,11 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 		trans = btrfs_attach_transaction(ctx->fs_info->tree_root);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT &&
-			    PTR_ERR(trans) != -EROFS)
+			    PTR_ERR(trans) != -EROFS) {
+				ulist_free(ctx->roots);
+				ctx->roots = NULL;
 				return PTR_ERR(trans);
+			}
 			trans = NULL;
 		}
 		ctx->trans = trans;
@@ -2344,8 +2358,7 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 						root_node->val, ctx->bytenr,
 						iterate, user_ctx);
 		}
-		ulist_free(ctx->roots);
-		ctx->roots = NULL;
+		ulist_reinit(ctx->roots);
 	}
 
 	free_leaf_list(refs);
@@ -2358,6 +2371,9 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 		up_read(&ctx->fs_info->commit_root_sem);
 	}
 
+	ulist_free(ctx->roots);
+	ctx->roots = NULL;
+
 	return ret;
 }
 
-- 
2.35.1

