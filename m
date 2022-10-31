Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8C613E4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 20:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJaTeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJaTeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 15:34:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1728513DD2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 12:34:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA99C1F45B;
        Mon, 31 Oct 2022 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667244840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zp18o8dS0Xo1aVzKUMx7eglgwClxh2bf5j2PWk+68Hs=;
        b=ejZXmrtr1yS2HiQPCftzZ0nYhIXCeFdWdqJ5lIi0dtVB2g5RnaLMjVFoU+2wzKGMBxx3nB
        2lQXvs8olw/2DxX0+LqYVhKGl5IULTZYV/haq77BWd/Xz309tI0SHcJMQKqiuxsU0N+KpJ
        uMJxSAmQgkSapgCspeHmoIrz9m3lOAI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C20212C141;
        Mon, 31 Oct 2022 19:34:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE0C3DA79D; Mon, 31 Oct 2022 20:33:44 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: convert btrfs_block_group::needs_free_space to runtime flag
Date:   Mon, 31 Oct 2022 20:33:44 +0100
Message-Id: <82d96ecea726e51be02a95afb6726faca47727dc.1667244568.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667244567.git.dsterba@suse.com>
References: <cover.1667244567.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already have flags in block group to track various status bits,
convert needs_free_space as well and reduce size of btrfs_block_group.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c                 |  2 +-
 fs/btrfs/block-group.h                 |  8 ++------
 fs/btrfs/free-space-tree.c             | 10 +++++-----
 fs/btrfs/tests/free-space-tree-tests.c |  2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ea5fcb665daa..708d843daa72 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2553,7 +2553,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
 
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		cache->needs_free_space = 1;
+		set_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &cache->runtime_flags);
 
 	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 6c970a486b68..4cee23c11938 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -55,6 +55,8 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
 	BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
 	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+	/* Does the block group need to be added to the free space tree? */
+	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
 };
 
 enum btrfs_caching_type {
@@ -208,12 +210,6 @@ struct btrfs_block_group {
 	/* Lock for free space tree operations. */
 	struct mutex free_space_lock;
 
-	/*
-	 * Does the block group need to be added to the free space tree?
-	 * Protected by free_space_lock.
-	 */
-	int needs_free_space;
-
 	/* Flag indicating this block group is placed on a sequential zone */
 	bool seq_zone;
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 869d062d6765..c667e878ef1a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -808,7 +808,7 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		ret = __add_block_group_free_space(trans, block_group, path);
 		if (ret)
 			return ret;
@@ -1001,7 +1001,7 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
 	u32 flags;
 	int ret;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		ret = __add_block_group_free_space(trans, block_group, path);
 		if (ret)
 			return ret;
@@ -1304,7 +1304,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 {
 	int ret;
 
-	block_group->needs_free_space = 0;
+	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
 	if (ret)
@@ -1326,7 +1326,7 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&block_group->free_space_lock);
-	if (!block_group->needs_free_space)
+	if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags))
 		goto out;
 
 	path = btrfs_alloc_path();
@@ -1359,7 +1359,7 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
 		return 0;
 
-	if (block_group->needs_free_space) {
+	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
 		/* We never added this block group to the free space tree. */
 		return 0;
 	}
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 53a17b1d1744..b61972046feb 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -471,7 +471,7 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	}
 	cache->bitmap_low_thresh = 0;
 	cache->bitmap_high_thresh = (u32)-1;
-	cache->needs_free_space = 1;
+	set_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &cache->runtime_flags);
 	cache->fs_info = root->fs_info;
 
 	btrfs_init_dummy_trans(&trans, root->fs_info);
-- 
2.37.3

