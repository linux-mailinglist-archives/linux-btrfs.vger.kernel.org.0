Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E7743E34
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjF3PEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjF3PED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F703583
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E89A6176F
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19555C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137440;
        bh=3d/wJHSEWiE7WGrzCMwJqMT4xZVK+8Bb9S2y7VyJXaw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h43WsgmJZDSa5xoqTK928oSk6sl3m1P/deeOAbzd2oVIDC9/gy7aDka5w5QH7vrgu
         B9ggq61kXVsEBE7wh/MMMA408LITBzNuDgRbDxlDGWQQS2H/e638nLFvTNyIv+B/7g
         hfs8R4VKa6/Jur32K0PldgM59hmb5l6PIIRWZ4n3Y4ARXZJCGGffgA1Zbnnh+JYO7C
         /IcKOYvfORIuCoWth5vRUyTP2/X1Ctvj70YHVPQK2OGG4gThyp8EZyS2j2ofMF6AqM
         JxCr9wq5z39kgEz3xdNaRIf5nPr/1y7sHi8kQY6PpsZcO7QXDU1az1nzp6Sn/HY9BR
         dhgDC/DF+Ojuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: make find_first_extent_bit() return a boolean
Date:   Fri, 30 Jun 2023 16:03:49 +0100
Message-Id: <61b7fb261a56bf95c0137c55b933754cf6608dc8.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
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

Currently find_first_extent_bit() returns a 0 if it found a range in the
given io tree and 1 if it didn't find any. There's no need to return any
errors, so make the return value a boolean and invert the logic to make
more sense: return true if it found a range and false if it didn't find
any range.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c      |  9 ++++-----
 fs/btrfs/dev-replace.c      |  6 +++---
 fs/btrfs/disk-io.c          | 10 +++++-----
 fs/btrfs/extent-io-tree.c   | 14 +++++++-------
 fs/btrfs/extent-io-tree.h   |  6 +++---
 fs/btrfs/extent-tree.c      |  5 ++---
 fs/btrfs/free-space-cache.c |  7 +++----
 fs/btrfs/relocation.c       | 10 ++++++----
 fs/btrfs/transaction.c      |  8 ++++----
 fs/btrfs/volumes.c          |  6 +++---
 10 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ac098d62169d..ba4e66de3372 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -517,11 +517,10 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
 		*total_added_ret = 0;
 
 	while (start < end) {
-		ret = find_first_extent_bit(&info->excluded_extents, start,
-					    &extent_start, &extent_end,
-					    EXTENT_DIRTY | EXTENT_UPTODATE,
-					    NULL);
-		if (ret)
+		if (!find_first_extent_bit(&info->excluded_extents, start,
+					   &extent_start, &extent_end,
+					   EXTENT_DIRTY | EXTENT_UPTODATE,
+					   NULL))
 			break;
 
 		if (extent_start <= start) {
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5e86bea0a950..661f02c8c038 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -792,9 +792,9 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 
 	lockdep_assert_held(&srcdev->fs_info->chunk_mutex);
 
-	while (!find_first_extent_bit(&srcdev->alloc_state, start,
-				      &found_start, &found_end,
-				      CHUNK_ALLOCATED, &cached_state)) {
+	while (find_first_extent_bit(&srcdev->alloc_state, start,
+				     &found_start, &found_end,
+				     CHUNK_ALLOCATED, &cached_state)) {
 		ret = set_extent_bit(&tgtdev->alloc_state, found_start,
 				     found_end, CHUNK_ALLOCATED, NULL);
 		if (ret)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 894096d42efc..fd84906a6ea4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4212,7 +4212,7 @@ static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
 		u64 found_end;
 
 		found = true;
-		while (!find_first_extent_bit(&trans->dirty_pages, cur,
+		while (find_first_extent_bit(&trans->dirty_pages, cur,
 			&found_start, &found_end, EXTENT_DIRTY, &cached)) {
 			dirty_bytes += found_end + 1 - found_start;
 			cur = found_end + 1;
@@ -4708,8 +4708,8 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
-				      mark, NULL)) {
+	while (find_first_extent_bit(dirty_pages, start, &start, &end,
+				     mark, NULL)) {
 		clear_extent_bits(dirty_pages, start, end, mark);
 		while (start <= end) {
 			eb = find_extent_buffer(fs_info, start);
@@ -4743,8 +4743,8 @@ static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		 * the same extent range.
 		 */
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		if (find_first_extent_bit(unpin, 0, &start, &end,
-					  EXTENT_DIRTY, &cached_state)) {
+		if (!find_first_extent_bit(unpin, 0, &start, &end,
+					   EXTENT_DIRTY, &cached_state)) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index a2315a4b8b75..ff8e117a1ace 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -831,15 +831,15 @@ static struct extent_state *find_first_extent_bit_state(struct extent_io_tree *t
  *
  * Note: If there are multiple bits set in @bits, any of them will match.
  *
- * Return 0 if we find something, and update @start_ret and @end_ret.
- * Return 1 if we found nothing.
+ * Return true if we find something, and update @start_ret and @end_ret.
+ * Return false if we found nothing.
  */
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, u32 bits,
-			  struct extent_state **cached_state)
+bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			   u64 *start_ret, u64 *end_ret, u32 bits,
+			   struct extent_state **cached_state)
 {
 	struct extent_state *state;
-	int ret = 1;
+	bool ret = false;
 
 	spin_lock(&tree->lock);
 	if (cached_state && *cached_state) {
@@ -863,7 +863,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 		cache_state_if_flags(state, cached_state, 0);
 		*start_ret = state->start;
 		*end_ret = state->end;
-		ret = 0;
+		ret = true;
 	}
 out:
 	spin_unlock(&tree->lock);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index fbd3b275ab1c..28c23a23d121 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -182,9 +182,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state);
 
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, u32 bits,
-			  struct extent_state **cached_state);
+bool find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			   u64 *start_ret, u64 *end_ret, u32 bits,
+			   struct extent_state **cached_state);
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a6efbfd7b24c..4c140636b456 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2740,9 +2740,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		struct extent_state *cached_state = NULL;
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		ret = find_first_extent_bit(unpin, 0, &start, &end,
-					    EXTENT_DIRTY, &cached_state);
-		if (ret) {
+		if (!find_first_extent_bit(unpin, 0, &start, &end,
+					   EXTENT_DIRTY, &cached_state)) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 880800418075..bfc01352351c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1219,10 +1219,9 @@ static noinline_for_stack int write_pinned_extent_entries(
 	start = block_group->start;
 
 	while (start < block_group->start + block_group->length) {
-		ret = find_first_extent_bit(unpin, start,
-					    &extent_start, &extent_end,
-					    EXTENT_DIRTY, NULL);
-		if (ret)
+		if (!find_first_extent_bit(unpin, start,
+					   &extent_start, &extent_end,
+					   EXTENT_DIRTY, NULL))
 			return 0;
 
 		/* This pinned extent is out of our range */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 25a3361caedc..9db2e6fa2cb2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3469,6 +3469,8 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 
 	last = rc->block_group->start + rc->block_group->length;
 	while (1) {
+		bool block_found;
+
 		cond_resched();
 		if (rc->search_start >= last) {
 			ret = 1;
@@ -3519,11 +3521,11 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 			goto next;
 		}
 
-		ret = find_first_extent_bit(&rc->processed_blocks,
-					    key.objectid, &start, &end,
-					    EXTENT_DIRTY, NULL);
+		block_found = find_first_extent_bit(&rc->processed_blocks,
+						    key.objectid, &start, &end,
+						    EXTENT_DIRTY, NULL);
 
-		if (ret == 0 && start <= key.objectid) {
+		if (block_found && start <= key.objectid) {
 			btrfs_release_path(path);
 			rc->search_start = end + 1;
 		} else {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cf306351b148..4743882fa94b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1054,8 +1054,8 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
-				      mark, &cached_state)) {
+	while (find_first_extent_bit(dirty_pages, start, &start, &end,
+				     mark, &cached_state)) {
 		bool wait_writeback = false;
 
 		err = convert_extent_bit(dirty_pages, start, end,
@@ -1108,8 +1108,8 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 start = 0;
 	u64 end;
 
-	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
-				      EXTENT_NEED_WAIT, &cached_state)) {
+	while (find_first_extent_bit(dirty_pages, start, &start, &end,
+				     EXTENT_NEED_WAIT, &cached_state)) {
 		/*
 		 * Ignore -ENOMEM errors returned by clear_extent_bit().
 		 * When committing the transaction, we'll remove any entries
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8137c04f31c9..2e2c01de8188 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1427,9 +1427,9 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 	lockdep_assert_held(&device->fs_info->chunk_mutex);
 
-	if (!find_first_extent_bit(&device->alloc_state, *start,
-				   &physical_start, &physical_end,
-				   CHUNK_ALLOCATED, NULL)) {
+	if (find_first_extent_bit(&device->alloc_state, *start,
+				  &physical_start, &physical_end,
+				  CHUNK_ALLOCATED, NULL)) {
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-- 
2.34.1

