Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324871018B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjEXXKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9592899
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2912421D38;
        Wed, 24 May 2023 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdEIp3d/yehcGhqnOXN6fh/Zx624MjTaa/UotDuUALU=;
        b=dGDl26j9RYDXEdj4zYPFleEPKxBwP10BlgM+W9RHSJ/KnqRVkvTjOByZcwoNUiCCk6uwfM
        uAlRLwZ6q7lLIZHnx952VtlDf+lMZv4u8lk3lbFG/gy8Z9nvxnjXmypXctS43G5xDhb7O/
        oCIe/Lc2I70O6xzFGIxrJFKhgdjAKEo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 199A32C141;
        Wed, 24 May 2023 23:10:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B227BDA85B; Thu, 25 May 2023 01:04:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/9] btrfs: open code set_extent_bits
Date:   Thu, 25 May 2023 01:04:32 +0200
Message-Id: <016d0db9c71e15f4c39ea866ce82a425db55cf07.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This helper calls set_extent_bit with two more parameters set to default
values, but otherwise it's purpose is not clear.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c           |  4 ++--
 fs/btrfs/extent-io-tree.h        |  6 ------
 fs/btrfs/extent-tree.c           | 10 +++++-----
 fs/btrfs/file-item.c             | 10 +++++-----
 fs/btrfs/relocation.c            | 11 ++++++-----
 fs/btrfs/tests/extent-io-tests.c | 11 ++++++-----
 6 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 78696d331639..3a0fc57d5db9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -795,8 +795,8 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 	while (!find_first_extent_bit(&srcdev->alloc_state, start,
 				      &found_start, &found_end,
 				      CHUNK_ALLOCATED, &cached_state)) {
-		ret = set_extent_bits(&tgtdev->alloc_state, found_start,
-				      found_end, CHUNK_ALLOCATED);
+		ret = set_extent_bit(&tgtdev->alloc_state, found_start,
+				     found_end, CHUNK_ALLOCATED, NULL, GFP_NOFS);
 		if (ret)
 			break;
 		start = found_end + 1;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ef9d54cdee5c..5a53a4558366 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -156,12 +156,6 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, struct extent_state **cached_state, gfp_t mask);
 
-static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
-		u64 end, u32 bits)
-{
-	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
-}
-
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47cfb694cdbf..03b2a7c508b9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -73,8 +73,8 @@ int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes)
 {
 	u64 end = start + num_bytes - 1;
-	set_extent_bits(&fs_info->excluded_extents, start, end,
-			EXTENT_UPTODATE);
+	set_extent_bit(&fs_info->excluded_extents, start, end,
+		       EXTENT_UPTODATE, NULL, GFP_NOFS);
 	return 0;
 }
 
@@ -5981,9 +5981,9 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		ret = btrfs_issue_discard(device->bdev, start, len,
 					  &bytes);
 		if (!ret)
-			set_extent_bits(&device->alloc_state, start,
-					start + bytes - 1,
-					CHUNK_TRIMMED);
+			set_extent_bit(&device->alloc_state, start,
+				       start + bytes - 1,
+				       CHUNK_TRIMMED, NULL, GFP_NOFS);
 		mutex_unlock(&fs_info->chunk_mutex);
 
 		if (ret)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e74b9804bcde..1e364a7b74aa 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -94,8 +94,8 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
-	return set_extent_bits(&inode->file_extent_tree, start, start + len - 1,
-			       EXTENT_DIRTY);
+	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1,
+			      EXTENT_DIRTY, NULL, GFP_NOFS);
 }
 
 /*
@@ -438,9 +438,9 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset = bbio->file_offset + bio_offset;
 
-				set_extent_bits(&inode->io_tree, file_offset,
-						file_offset + sectorsize - 1,
-						EXTENT_NODATASUM);
+				set_extent_bit(&inode->io_tree, file_offset,
+					       file_offset + sectorsize - 1,
+					       EXTENT_NODATASUM, NULL, GFP_NOFS);
 			} else {
 				btrfs_warn_rl(fs_info,
 			"csum hole found for disk bytenr range [%llu, %llu)",
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 38cfbd38a819..1ed8b132fe2a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -174,8 +174,9 @@ static void mark_block_processed(struct reloc_control *rc,
 	    in_range(node->bytenr, rc->block_group->start,
 		     rc->block_group->length)) {
 		blocksize = rc->extent_root->fs_info->nodesize;
-		set_extent_bits(&rc->processed_blocks, node->bytenr,
-				node->bytenr + blocksize - 1, EXTENT_DIRTY);
+		set_extent_bit(&rc->processed_blocks, node->bytenr,
+			       node->bytenr + blocksize - 1, EXTENT_DIRTY,
+			       NULL, GFP_NOFS);
 	}
 	node->processed = 1;
 }
@@ -3051,9 +3052,9 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			u64 boundary_end = boundary_start +
 					   fs_info->sectorsize - 1;
 
-			set_extent_bits(&BTRFS_I(inode)->io_tree,
-					boundary_start, boundary_end,
-					EXTENT_BOUNDARY);
+			set_extent_bit(&BTRFS_I(inode)->io_tree,
+				       boundary_start, boundary_end,
+				       EXTENT_BOUNDARY, NULL, GFP_NOFS);
 		}
 		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
 			      &cached_state);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index b9de94a50868..acaaddf7181a 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -503,8 +503,8 @@ static int test_find_first_clear_extent_bit(void)
 	 * Set 1M-4M alloc/discard and 32M-64M thus leaving a hole between
 	 * 4M-32M
 	 */
-	set_extent_bits(&tree, SZ_1M, SZ_4M - 1,
-			CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
+		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
 
 	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
@@ -516,8 +516,8 @@ static int test_find_first_clear_extent_bit(void)
 	}
 
 	/* Now add 32M-64M so that we have a hole between 4M-32M */
-	set_extent_bits(&tree, SZ_32M, SZ_64M - 1,
-			CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	set_extent_bit(&tree, SZ_32M, SZ_64M - 1,
+		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
 
 	/*
 	 * Request first hole starting at 12M, we should get 4M-32M
@@ -548,7 +548,8 @@ static int test_find_first_clear_extent_bit(void)
 	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED flag
 	 * being unset in this range, we should get the entry in range 64M-72M
 	 */
-	set_extent_bits(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED);
+	set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL,
+		       GFP_NOFS);
 	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
 				    CHUNK_TRIMMED);
 
-- 
2.40.0

