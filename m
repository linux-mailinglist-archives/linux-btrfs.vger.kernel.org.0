Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24D727CC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjFHK2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbjFHK17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D64272D
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9584A60ABF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC6EC4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220076;
        bh=TQkwbf/t/gDCAkVEbdrtP0rI/xJNhPmssnvJfri110k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GaP+Iko+BFrTzEBC/CebIUam8gyMl4kfmjqA6r3u4gMx+skduCRMkJnzQOwS3U5kw
         +yT0p/mN4/TswJr3opsD7GdU1xY1fSwoJSS7WhLW7wBC07HImg+IgpGi/mCQIOcWyl
         6ASfea7AuJwZqx+r5ePsx9py+oeY0BhM9D8NYAN258t4TqMzfs3oY9wApngjOiZXF3
         R1akuHdx6jTfIIeEDa0tuGWqvwo1jE9ilOU6v168zoGXPTCgE2GdlIEzAf3nReMOr0
         8PfO5U+TdKwcaIU36QJc7DSmTGtj6qzgTQrJnC5HY1gGhWj9TKsq8GH0bC8zeSxRmS
         MXGvN4c1USzKg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/13] btrfs: avoid tree mod log ENOMEM failures when we don't need to log
Date:   Thu,  8 Jun 2023 11:27:39 +0100
Message-Id: <05effd0ef554b9911824b8c21630865bfc10137b.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging tree mod log operations we start by checking, in a lockless
manner, if we need to log - if we don't, we just return and do nothing,
otherwise we will allocate one or more tree mod log operations and then
check again if we need to log. This second check will take the tree mod
log lock in write mode if we need to log, otherwise it will do nothing
and we just free the allocated memory and return success.

We can improve on this by not returning an error in case the memory
allocations fail, unless the second check tells us that we actually need
to log. That is, if we fail to allocate memory and the second check tells
use that we don't need to log, we can just return success and avoid
returning -ENOMEM to the caller. Currently tree mod log failures are
dealt with either a BUG_ON() or a transaction abort, as tree mod log
operations are logged in code paths that modify a b+tree.

So just avoid failing with -ENOMEM if we fail to allocate a tree mod log
operation unless we actually need to log the operations, that is, if
tree_mod_dont_log() returns true.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-mod-log.c | 148 +++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 07c086f9e35e..3df6153d5d5a 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -226,21 +226,32 @@ int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op)
 {
 	struct tree_mod_elem *tm;
-	int ret;
+	int ret = 0;
 
 	if (!tree_mod_need_log(eb->fs_info, eb))
 		return 0;
 
 	tm = alloc_tree_mod_elem(eb, slot, op);
 	if (!tm)
-		return -ENOMEM;
+		ret = -ENOMEM;
 
 	if (tree_mod_dont_log(eb->fs_info, eb)) {
 		kfree(tm);
+		/*
+		 * Don't error if we failed to allocate memory because we don't
+		 * need to log.
+		 */
 		return 0;
+	} else if (ret != 0) {
+		/*
+		 * We previously failed to allocate memory and we need to log,
+		 * so we have to fail.
+		 */
+		goto out_unlock;
 	}
 
 	ret = tree_mod_log_insert(eb->fs_info, tm);
+out_unlock:
 	write_unlock(&eb->fs_info->tree_mod_log_lock);
 	if (ret)
 		kfree(tm);
@@ -282,14 +293,16 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 		return 0;
 
 	tm_list = kcalloc(nr_items, sizeof(struct tree_mod_elem *), GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
+	if (!tm_list) {
+		ret = -ENOMEM;
+		goto lock;
+	}
 
 	tm = tree_mod_log_alloc_move(eb, dst_slot, src_slot, nr_items);
 	if (IS_ERR(tm)) {
 		ret = PTR_ERR(tm);
 		tm = NULL;
-		goto free_tms;
+		goto lock;
 	}
 
 	for (i = 0; i + dst_slot < src_slot && i < nr_items; i++) {
@@ -297,14 +310,28 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 				BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING);
 		if (!tm_list[i]) {
 			ret = -ENOMEM;
-			goto free_tms;
+			goto lock;
 		}
 	}
 
-	if (tree_mod_dont_log(eb->fs_info, eb))
+lock:
+	if (tree_mod_dont_log(eb->fs_info, eb)) {
+		/*
+		 * Don't error if we failed to allocate memory because we don't
+		 * need to log.
+		 */
+		ret = 0;
 		goto free_tms;
+	}
 	locked = true;
 
+	/*
+	 * We previously failed to allocate memory and we need to log, so we
+	 * have to fail.
+	 */
+	if (ret != 0)
+		goto free_tms;
+
 	/*
 	 * When we override something during the move, we log these removals.
 	 * This can only happen when we move towards the beginning of the
@@ -325,10 +352,12 @@ int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 	return 0;
 
 free_tms:
-	for (i = 0; i < nr_items; i++) {
-		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
-			rb_erase(&tm_list[i]->node, &eb->fs_info->tree_mod_log);
-		kfree(tm_list[i]);
+	if (tm_list) {
+		for (i = 0; i < nr_items; i++) {
+			if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
+				rb_erase(&tm_list[i]->node, &eb->fs_info->tree_mod_log);
+			kfree(tm_list[i]);
+		}
 	}
 	if (locked)
 		write_unlock(&eb->fs_info->tree_mod_log_lock);
@@ -378,14 +407,14 @@ int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 				  GFP_NOFS);
 		if (!tm_list) {
 			ret = -ENOMEM;
-			goto free_tms;
+			goto lock;
 		}
 		for (i = 0; i < nritems; i++) {
 			tm_list[i] = alloc_tree_mod_elem(old_root, i,
 			    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING);
 			if (!tm_list[i]) {
 				ret = -ENOMEM;
-				goto free_tms;
+				goto lock;
 			}
 		}
 	}
@@ -393,7 +422,7 @@ int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 	tm = kzalloc(sizeof(*tm), GFP_NOFS);
 	if (!tm) {
 		ret = -ENOMEM;
-		goto free_tms;
+		goto lock;
 	}
 
 	tm->logical = new_root->start;
@@ -402,14 +431,28 @@ int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
 	tm->generation = btrfs_header_generation(old_root);
 	tm->op = BTRFS_MOD_LOG_ROOT_REPLACE;
 
-	if (tree_mod_dont_log(fs_info, NULL))
+lock:
+	if (tree_mod_dont_log(fs_info, NULL)) {
+		/*
+		 * Don't error if we failed to allocate memory because we don't
+		 * need to log.
+		 */
+		ret = 0;
 		goto free_tms;
+	} else if (ret != 0) {
+		/*
+		 * We previously failed to allocate memory and we need to log,
+		 * so we have to fail.
+		 */
+		goto out_unlock;
+	}
 
 	if (tm_list)
 		ret = tree_mod_log_free_eb(fs_info, tm_list, nritems);
 	if (!ret)
 		ret = tree_mod_log_insert(fs_info, tm);
 
+out_unlock:
 	write_unlock(&fs_info->tree_mod_log_lock);
 	if (ret)
 		goto free_tms;
@@ -501,7 +544,8 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	struct btrfs_fs_info *fs_info = dst->fs_info;
 	int ret = 0;
 	struct tree_mod_elem **tm_list = NULL;
-	struct tree_mod_elem **tm_list_add, **tm_list_rem;
+	struct tree_mod_elem **tm_list_add = NULL;
+	struct tree_mod_elem **tm_list_rem = NULL;
 	int i;
 	bool locked = false;
 	struct tree_mod_elem *dst_move_tm = NULL;
@@ -517,8 +561,10 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 
 	tm_list = kcalloc(nr_items * 2, sizeof(struct tree_mod_elem *),
 			  GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
+	if (!tm_list) {
+		ret = -ENOMEM;
+		goto lock;
+	}
 
 	if (dst_move_nr_items) {
 		dst_move_tm = tree_mod_log_alloc_move(dst, dst_offset + nr_items,
@@ -526,7 +572,7 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 		if (IS_ERR(dst_move_tm)) {
 			ret = PTR_ERR(dst_move_tm);
 			dst_move_tm = NULL;
-			goto free_tms;
+			goto lock;
 		}
 	}
 	if (src_move_nr_items) {
@@ -536,7 +582,7 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 		if (IS_ERR(src_move_tm)) {
 			ret = PTR_ERR(src_move_tm);
 			src_move_tm = NULL;
-			goto free_tms;
+			goto lock;
 		}
 	}
 
@@ -547,21 +593,35 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 						     BTRFS_MOD_LOG_KEY_REMOVE);
 		if (!tm_list_rem[i]) {
 			ret = -ENOMEM;
-			goto free_tms;
+			goto lock;
 		}
 
 		tm_list_add[i] = alloc_tree_mod_elem(dst, i + dst_offset,
 						     BTRFS_MOD_LOG_KEY_ADD);
 		if (!tm_list_add[i]) {
 			ret = -ENOMEM;
-			goto free_tms;
+			goto lock;
 		}
 	}
 
-	if (tree_mod_dont_log(fs_info, NULL))
+lock:
+	if (tree_mod_dont_log(fs_info, NULL)) {
+		/*
+		 * Don't error if we failed to allocate memory because we don't
+		 * need to log.
+		 */
+		ret = 0;
 		goto free_tms;
+	}
 	locked = true;
 
+	/*
+	 * We previously failed to allocate memory and we need to log, so we
+	 * have to fail.
+	 */
+	if (ret != 0)
+		goto free_tms;
+
 	if (dst_move_tm) {
 		ret = tree_mod_log_insert(fs_info, dst_move_tm);
 		if (ret)
@@ -593,10 +653,12 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 	if (src_move_tm && !RB_EMPTY_NODE(&src_move_tm->node))
 		rb_erase(&src_move_tm->node, &fs_info->tree_mod_log);
 	kfree(src_move_tm);
-	for (i = 0; i < nr_items * 2; i++) {
-		if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
-			rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);
-		kfree(tm_list[i]);
+	if (tm_list) {
+		for (i = 0; i < nr_items * 2; i++) {
+			if (tm_list[i] && !RB_EMPTY_NODE(&tm_list[i]->node))
+				rb_erase(&tm_list[i]->node, &fs_info->tree_mod_log);
+			kfree(tm_list[i]);
+		}
 	}
 	if (locked)
 		write_unlock(&fs_info->tree_mod_log_lock);
@@ -617,22 +679,38 @@ int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb)
 
 	nritems = btrfs_header_nritems(eb);
 	tm_list = kcalloc(nritems, sizeof(struct tree_mod_elem *), GFP_NOFS);
-	if (!tm_list)
-		return -ENOMEM;
+	if (!tm_list) {
+		ret = -ENOMEM;
+		goto lock;
+	}
 
 	for (i = 0; i < nritems; i++) {
 		tm_list[i] = alloc_tree_mod_elem(eb, i,
 				    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING);
 		if (!tm_list[i]) {
 			ret = -ENOMEM;
-			goto free_tms;
+			goto lock;
 		}
 	}
 
-	if (tree_mod_dont_log(eb->fs_info, eb))
+lock:
+	if (tree_mod_dont_log(eb->fs_info, eb)) {
+		/*
+		 * Don't error if we failed to allocate memory because we don't
+		 * need to log.
+		 */
+		ret = 0;
 		goto free_tms;
+	} else if (ret != 0) {
+		/*
+		 * We previously failed to allocate memory and we need to log,
+		 * so we have to fail.
+		 */
+		goto out_unlock;
+	}
 
 	ret = tree_mod_log_free_eb(eb->fs_info, tm_list, nritems);
+out_unlock:
 	write_unlock(&eb->fs_info->tree_mod_log_lock);
 	if (ret)
 		goto free_tms;
@@ -641,9 +719,11 @@ int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb)
 	return 0;
 
 free_tms:
-	for (i = 0; i < nritems; i++)
-		kfree(tm_list[i]);
-	kfree(tm_list);
+	if (tm_list) {
+		for (i = 0; i < nritems; i++)
+			kfree(tm_list[i]);
+		kfree(tm_list);
+	}
 
 	return ret;
 }
-- 
2.34.1

