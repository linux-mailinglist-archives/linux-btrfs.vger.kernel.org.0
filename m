Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD16643CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbjAJO50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjAJO4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D322186FC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BDCB61573
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F95BC433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362610;
        bh=BBBFzTrpnDebmd6EX4SjM5G8MR6bdZ/y2JiGO7iI+94=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J0dthHL8lGqx+iwtQUpOtpph5yqvgcIK3rqRCxbv/psa8+eOCJYbG9pXzMUlgxfNq
         uu5HPkiWe9Yrq/7ueK3CbFKKqQMClEXtSm0A6zLr7EmJpsi/P8gOJ7K6XUtJ+3Q5a7
         LZRDcD3xxQzHTLuFYINzGMLzwfu2LRmLm07euBEKPdk2brJA2PdiN8c4kCPwEtfUYQ
         f/FXEnDaXvBRPIth5QwoRmGyshCH1A0JohCCYYG7KRy02ae5Fpk1Nh2BndJ6Bi0SVT
         S5TXGePYrP0W/gu9U4FsXWLmVG3a9XSpr1tuzgy0MnWB4qd3o2YYrAIhV2Kx6CFiYT
         fR6V8fejX/Wsg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: simplify update of last_dir_index_offset when logging a directory
Date:   Tue, 10 Jan 2023 14:56:39 +0000
Message-Id: <ff77f41924e197d99e62ef323f03467c87ef43a0.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
References: <cover.1673361215.git.fdmanana@suse.com>
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

When logging a directory, we always set the inode's last_dir_index_offset
to the offset of the last dir index item we found. This is using an extra
field in the log context structure, and it makes more sense to update it
only after we insert dir index items, and we could directly update the
inode's last_dir_index_offset field instead.

So make this simpler by updating the inode's last_dir_index_offset only
when we actually insert dir index keys in the log tree, and getting rid
of the last_dir_item_offset field in the log context structure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 23 +++++++++++++++++------
 fs/btrfs/tree-log.h |  2 --
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d43261545264..58599189bd18 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3576,17 +3576,19 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
 }
 
 static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *log,
+				 struct btrfs_inode *inode,
 				 struct extent_buffer *src,
 				 struct btrfs_path *dst_path,
 				 int start_slot,
 				 int count)
 {
+	struct btrfs_root *log = inode->root->log_root;
 	char *ins_data = NULL;
 	struct btrfs_item_batch batch;
 	struct extent_buffer *dst;
 	unsigned long src_offset;
 	unsigned long dst_offset;
+	u64 last_index;
 	struct btrfs_key key;
 	u32 item_size;
 	int ret;
@@ -3644,6 +3646,19 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 	src_offset = btrfs_item_ptr_offset(src, start_slot + count - 1);
 	copy_extent_buffer(dst, src, dst_offset, src_offset, batch.total_data_size);
 	btrfs_release_path(dst_path);
+
+	last_index = batch.keys[count - 1].offset;
+	ASSERT(last_index > inode->last_dir_index_offset);
+
+	/*
+	 * If for some unexpected reason the last item's index is not greater
+	 * than the last index we logged, warn and return an error to fallback
+	 * to a transaction commit.
+	 */
+	if (WARN_ON(last_index <= inode->last_dir_index_offset))
+		ret = -EUCLEAN;
+	else
+		inode->last_dir_index_offset = last_index;
 out:
 	kfree(ins_data);
 
@@ -3693,7 +3708,6 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 		}
 
 		di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
-		ctx->last_dir_item_offset = key.offset;
 
 		/*
 		 * Skip ranges of items that consist only of dir item keys created
@@ -3756,7 +3770,7 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	if (batch_size > 0) {
 		int ret;
 
-		ret = flush_dir_items_batch(trans, log, src, dst_path,
+		ret = flush_dir_items_batch(trans, inode, src, dst_path,
 					    batch_start, batch_size);
 		if (ret < 0)
 			return ret;
@@ -4044,7 +4058,6 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 
 	min_key = BTRFS_DIR_START_INDEX;
 	max_key = 0;
-	ctx->last_dir_item_offset = inode->last_dir_index_offset;
 
 	while (1) {
 		ret = log_dir_items(trans, inode, path, dst_path,
@@ -4056,8 +4069,6 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 		min_key = max_key + 1;
 	}
 
-	inode->last_dir_index_offset = ctx->last_dir_item_offset;
-
 	return 0;
 }
 
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 85b43075ac58..85cd24cb0540 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -24,8 +24,6 @@ struct btrfs_log_ctx {
 	bool logging_new_delayed_dentries;
 	/* Indicate if the inode being logged was logged before. */
 	bool logged_before;
-	/* Tracks the last logged dir item/index key offset. */
-	u64 last_dir_item_offset;
 	struct inode *inode;
 	struct list_head list;
 	/* Only used for fast fsyncs. */
-- 
2.35.1

