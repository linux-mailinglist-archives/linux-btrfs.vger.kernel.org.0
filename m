Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B259BDE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiHVKwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiHVKv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B63123B
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6B960FDE
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0009C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165517;
        bh=uWFjkSweqpukcNVlBHQgWovsAmfMSnyZa1doTzB9Tno=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FokF+2o2UFsIe3liJH/21rD4we90A3QjqR0To9Y3UK+DUaq+BmkPYewuYRn9qmLcH
         y1Ek8J7S6fU60J8mAiD3ZOcZPlWR4bXCF7WAjIVZSGed8Ju5x/n+xR0sRaO7+e5rn0
         py3PKCVRVO7cApmC6BkqsiciuVejWfWKIT3A2Q1iHLRUfhu2ud5bC30TPQuifuW5K8
         kOntQ2/I0CLdeufjRXt9o/kXvxSkyVvpGS22CXjfYKwiRp7QcVyojlpmc2PiAP4/rP
         yoSb+HSyCKbfVHxN8sLg1P1Uxzvw4ga4VxUYNQntUITWb70TgqEwlQGfCJx4f9Or6n
         XWANdd3yxzYlQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/15] btrfs: search for last logged dir index if it's not cached in the inode
Date:   Mon, 22 Aug 2022 11:51:39 +0100
Message-Id: <2476d5a5d1f34d2646c93f9b765f7e4df520ba9a.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
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

The key offset of the last dir index item that was logged is stored in
the inode's last_dir_index_offset field. However that field is not
persisted in the inode item or elsewhere, so if the inode gets evicted
and reloaded, it gets a value of (u64)-1, so that when we are logging
dir index items we check if they were logged before, to avoid attempts
to insert duplicated keys and fallback to a transaction commit.

Improve on this by searching for the last dir index that was logged when
we start logging a directory if the inode's last_dir_index_offset is not
set (has a value of (u64)-1) and it was logged before. This avoids
checking if each dir index item we find was already logged before, and
simplifies the logging of dir index items (process_dir_items_leaf()).

This will also be needed for an incoming change where we start logging
delayed items directly, without flushing them first.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 119 +++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 94026098bb68..1cfbd4503822 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3735,6 +3735,11 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 			*last_old_dentry_offset = key.offset;
 			continue;
 		}
+
+		/* If we logged this dir index item before, we can skip it. */
+		if (key.offset <= inode->last_dir_index_offset)
+			continue;
+
 		/*
 		 * We must make sure that when we log a directory entry, the
 		 * corresponding inode, after log replay, has a matching link
@@ -3765,51 +3770,6 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 				ctx->log_new_dentries = true;
 		}
 
-		if (!ctx->logged_before)
-			goto add_to_batch;
-
-		/*
-		 * If we were logged before and have logged dir items, we can skip
-		 * checking if any item with a key offset larger than the last one
-		 * we logged is in the log tree, saving time and avoiding adding
-		 * contention on the log tree. We can only rely on the value of
-		 * last_dir_index_offset when we know for sure that the inode was
-		 * previously logged in the current transaction.
-		 */
-		if (key.offset > inode->last_dir_index_offset)
-			goto add_to_batch;
-		/*
-		 * Check if the key was already logged before. If not we can add
-		 * it to a batch for bulk insertion.
-		 */
-		ret = btrfs_search_slot(NULL, log, &key, dst_path, 0, 0);
-		if (ret < 0) {
-			return ret;
-		} else if (ret > 0) {
-			btrfs_release_path(dst_path);
-			goto add_to_batch;
-		}
-
-		/*
-		 * Item exists in the log. Overwrite the item in the log if it
-		 * has different content or do nothing if it has exactly the same
-		 * content. And then flush the current batch if any - do it after
-		 * overwriting the current item, or we would deadlock otherwise,
-		 * since we are holding a path for the existing item.
-		 */
-		ret = do_overwrite_item(trans, log, dst_path, src, i, &key);
-		if (ret < 0)
-			return ret;
-
-		if (batch_size > 0) {
-			ret = flush_dir_items_batch(trans, log, src, dst_path,
-						    batch_start, batch_size);
-			if (ret < 0)
-				return ret;
-			batch_size = 0;
-		}
-		continue;
-add_to_batch:
 		if (batch_size == 0)
 			batch_start = i;
 		batch_size++;
@@ -3995,6 +3955,71 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	return err;
 }
 
+/*
+ * If the inode was logged before and it was evicted, then its
+ * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * key offset. If that's the case, search for it and update the inode. This
+ * is to avoid lookups in the log tree every time we try to insert a dir index
+ * key from a leaf changed in the current transaction, and to allow us to always
+ * do batch insertions of dir index keys.
+ */
+static int update_last_dir_index_offset(struct btrfs_inode *inode,
+					struct btrfs_path *path,
+					const struct btrfs_log_ctx *ctx)
+{
+	const u64 ino = btrfs_ino(inode);
+	struct btrfs_key key;
+	int ret;
+
+	lockdep_assert_held(&inode->log_mutex);
+
+	if (inode->last_dir_index_offset != (u64)-1)
+		return 0;
+
+	if (!ctx->logged_before) {
+		inode->last_dir_index_offset = BTRFS_DIR_START_INDEX - 1;
+		return 0;
+	}
+
+	key.objectid = ino;
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, inode->root->log_root, &key, path, 0, 0);
+	/*
+	 * An error happened or we actually have an index key with an offset
+	 * value of (u64)-1. Bail out, we're done.
+	 */
+	if (ret <= 0)
+		goto out;
+
+	ret = 0;
+	inode->last_dir_index_offset = BTRFS_DIR_START_INDEX - 1;
+
+	/*
+	 * No dir index items, bail out and leave last_dir_index_offset with
+	 * the value right before the first valid index value.
+	 */
+	if (path->slots[0] == 0)
+		goto out;
+
+	/*
+	 * btrfs_search_slot() left us at one slot beyond the slot with the last
+	 * index key, or beyond the last key of the directory that is not an
+	 * index key. If we have an index key before, set last_dir_index_offset
+	 * to its offset value, otherwise leave it with a value right before the
+	 * first valid index value, as it means we have an empty directory.
+	 */
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
+	if (key.objectid == ino && key.type == BTRFS_DIR_INDEX_KEY)
+		inode->last_dir_index_offset = key.offset;
+
+out:
+	btrfs_release_path(path);
+
+	return ret;
+}
+
 /*
  * logging directories is very similar to logging inodes, We find all the items
  * from the current transaction and write them to the log.
@@ -4017,6 +4042,10 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	u64 max_key;
 	int ret;
 
+	ret = update_last_dir_index_offset(inode, path, ctx);
+	if (ret)
+		return ret;
+
 	min_key = BTRFS_DIR_START_INDEX;
 	max_key = 0;
 	ctx->last_dir_item_offset = inode->last_dir_index_offset;
-- 
2.35.1

