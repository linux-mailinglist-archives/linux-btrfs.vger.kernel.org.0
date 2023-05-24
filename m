Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062771018E
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjEXXKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E88399
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB7861FE3A;
        Wed, 24 May 2023 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGYoxR0fU8FFW0p5bXaZvk6/Avne3p5vFYZb7lNzP/g=;
        b=n6a4fuRzL+ivuB7tdIL464nTJ9c+oGy36oQ2vhSw+4UbMcLzu2tB1+KIrQpG+4tZNg+L+H
        Hbu3Dfuvu4ZUxhB77Fag8kdQJN6trBSJQpW8wbDeVg2IJl9fZw5LDOgakXk+BwjAuEA4oH
        kyIUCieQsW+5GlxKX87GTsv/KEj8M5M=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A687C2C141;
        Wed, 24 May 2023 23:10:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46EA3DA85B; Thu, 25 May 2023 01:04:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 9/9] btrfs: drop gfp from parameter extent state helpers
Date:   Thu, 25 May 2023 01:04:39 +0200
Message-Id: <9a337d17ae2670fe059e1b934eea027021bf59c4.1684967924.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all extent state bit helpers effectively take the GFP_NOFS mask
(and GFP_NOWAIT is encoded in the bits) we can remove the parameter.
This reduces stack consumption in many functions and simplifies a lot of
code.

Net effect on module on a release build:

   text    data     bss     dec     hex filename
1250432   20985   16088 1287505  13a551 pre/btrfs.ko
1247074   20985   16088 1284147  139833 post/btrfs.ko

DELTA: -3358

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c           |  2 +-
 fs/btrfs/defrag.c                |  3 +--
 fs/btrfs/dev-replace.c           |  2 +-
 fs/btrfs/extent-io-tree.c        | 25 +++++++++++++------------
 fs/btrfs/extent-io-tree.h        | 12 +++++-------
 fs/btrfs/extent-tree.c           | 14 ++++++--------
 fs/btrfs/extent_io.c             |  3 +--
 fs/btrfs/extent_map.c            |  4 ++--
 fs/btrfs/file-item.c             |  4 ++--
 fs/btrfs/inode.c                 |  7 +++----
 fs/btrfs/relocation.c            |  5 ++---
 fs/btrfs/tests/extent-io-tests.c | 13 ++++++-------
 fs/btrfs/zoned.c                 |  2 +-
 13 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 202e2aa949c5..618ba7670e66 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3523,7 +3523,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 
 			set_extent_bit(&trans->transaction->pinned_extents,
 				       bytenr, bytenr + num_bytes - 1,
-				       EXTENT_DIRTY, NULL, GFP_NOFS);
+				       EXTENT_DIRTY, NULL);
 		}
 
 		spin_lock(&trans->transaction->dirty_bgs_lock);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 4e7a1e0a0441..f2ff4cbe8656 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1041,8 +1041,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			 EXTENT_DEFRAG, cached_state);
 	set_extent_bit(&inode->io_tree, start, start + len - 1,
-		       EXTENT_DELALLOC | EXTENT_DEFRAG,
-		       cached_state, GFP_NOFS);
+		       EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 3a0fc57d5db9..dc3f30c79320 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -796,7 +796,7 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 				      &found_start, &found_end,
 				      CHUNK_ALLOCATED, &cached_state)) {
 		ret = set_extent_bit(&tgtdev->alloc_state, found_start,
-				     found_end, CHUNK_ALLOCATED, NULL, GFP_NOFS);
+				     found_end, CHUNK_ALLOCATED, NULL);
 		if (ret)
 			break;
 		start = found_end + 1;
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 83e40c02f62e..a2315a4b8b75 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -556,7 +556,7 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
  */
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		       u32 bits, struct extent_state **cached_state,
-		       gfp_t mask, struct extent_changeset *changeset)
+		       struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *cached;
@@ -566,6 +566,7 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	int clear = 0;
 	int wake;
 	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
+	gfp_t mask;
 
 	set_gfp_mask_from_bits(&bits, &mask);
 	btrfs_debug_check_extent_io_range(tree, start, end);
@@ -964,7 +965,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 
 /*
  * Set some bits on a range in the tree.  This may require allocations or
- * sleeping, so the gfp mask is used to indicate what is allowed.
+ * sleeping. By default all allocations use GFP_NOFS, use EXTENT_NOWAIT for
+ * GFP_NOWAIT.
  *
  * If any of the exclusive bits are set, this will fail with -EEXIST if some
  * part of the range already has the desired bits set.  The extent_state of the
@@ -979,7 +981,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			    u32 bits, u64 *failed_start,
 			    struct extent_state **failed_state,
 			    struct extent_state **cached_state,
-			    struct extent_changeset *changeset, gfp_t mask)
+			    struct extent_changeset *changeset)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -989,6 +991,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 last_start;
 	u64 last_end;
 	u32 exclusive_bits = (bits & EXTENT_LOCKED);
+	gfp_t mask;
 
 	set_gfp_mask_from_bits(&bits, &mask);
 	btrfs_debug_check_extent_io_range(tree, start, end);
@@ -1200,10 +1203,10 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 }
 
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state, gfp_t mask)
+		   u32 bits, struct extent_state **cached_state)
 {
 	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
-				cached_state, NULL, mask);
+				cached_state, NULL);
 }
 
 /*
@@ -1699,8 +1702,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL,
-				changeset, GFP_NOFS);
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL, changeset);
 }
 
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1712,8 +1714,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 */
 	ASSERT(!(bits & EXTENT_LOCKED));
 
-	return __clear_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
-				  changeset);
+	return __clear_extent_bit(tree, start, end, bits, NULL, changeset);
 }
 
 int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
@@ -1723,7 +1724,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			       NULL, cached, NULL, GFP_NOFS);
+			       NULL, cached, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1745,7 +1746,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	u64 failed_start;
 
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			       &failed_state, cached_state, NULL, GFP_NOFS);
+			       &failed_state, cached_state, NULL);
 	while (err == -EEXIST) {
 		if (failed_start != start)
 			clear_extent_bit(tree, start, failed_start - 1,
@@ -1755,7 +1756,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				&failed_state);
 		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
 				       &failed_start, &failed_state,
-				       cached_state, NULL, GFP_NOFS);
+				       cached_state, NULL);
 	}
 	return err;
 }
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d7f5afeb5ce7..fbd3b275ab1c 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -136,22 +136,20 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, struct extent_state **cached, gfp_t mask,
+		       u32 bits, struct extent_state **cached,
 		       struct extent_changeset *changeset);
 
 static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				   u64 end, u32 bits,
 				   struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, bits, cached,
-				  GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, start, end, bits, cached, NULL);
 }
 
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				struct extent_state **cached)
 {
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
-				  GFP_NOFS, NULL);
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached, NULL);
 }
 
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
@@ -163,13 +161,13 @@ static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset);
 int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, struct extent_state **cached_state, gfp_t mask);
+		   u32 bits, struct extent_state **cached_state);
 
 static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
 		u64 end, struct extent_state **cached_state)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
-				  cached_state, GFP_NOFS, NULL);
+				  cached_state, NULL);
 }
 
 static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6e319100e3a3..71aaf28fafc9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -74,7 +74,7 @@ int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 {
 	u64 end = start + num_bytes - 1;
 	set_extent_bit(&fs_info->excluded_extents, start, end,
-		       EXTENT_UPTODATE, NULL, GFP_NOFS);
+		       EXTENT_UPTODATE, NULL);
 	return 0;
 }
 
@@ -2508,7 +2508,7 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->space_info->lock);
 
 	set_extent_bit(&trans->transaction->pinned_extents, bytenr,
-		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL, GFP_NOFS);
+		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
 	return 0;
 }
 
@@ -4831,16 +4831,15 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (buf->log_index == 0)
 			set_extent_bit(&root->dirty_log_pages, buf->start,
 				       buf->start + buf->len - 1,
-				       EXTENT_DIRTY, NULL, GFP_NOFS);
+				       EXTENT_DIRTY, NULL);
 		else
 			set_extent_bit(&root->dirty_log_pages, buf->start,
 				       buf->start + buf->len - 1,
-				       EXTENT_NEW, NULL, GFP_NOFS);
+				       EXTENT_NEW, NULL);
 	} else {
 		buf->log_index = -1;
 		set_extent_bit(&trans->transaction->dirty_pages, buf->start,
-			       buf->start + buf->len - 1, EXTENT_DIRTY, NULL,
-			       GFP_NOFS);
+			       buf->start + buf->len - 1, EXTENT_DIRTY, NULL);
 	}
 	/* this returns a buffer locked for blocking */
 	return buf;
@@ -5981,8 +5980,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 					  &bytes);
 		if (!ret)
 			set_extent_bit(&device->alloc_state, start,
-				       start + bytes - 1,
-				       CHUNK_TRIMMED, NULL, GFP_NOFS);
+				       start + bytes - 1, CHUNK_TRIMMED, NULL);
 		mutex_unlock(&fs_info->chunk_mutex);
 
 		if (ret)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e592df58df4..fcd0563f7a15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2452,8 +2452,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL,
-					 mask, NULL);
+		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4c8c87524d62..4d86d4739217 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -366,7 +366,7 @@ static void extent_map_device_set_bits(struct extent_map *em, unsigned bits)
 
 		set_extent_bit(&device->alloc_state, stripe->physical,
 			       stripe->physical + stripe_size - 1,
-			       bits | EXTENT_NOWAIT, NULL, GFP_NOWAIT);
+			       bits | EXTENT_NOWAIT, NULL);
 	}
 }
 
@@ -383,7 +383,7 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
 		__clear_extent_bit(&device->alloc_state, stripe->physical,
 				   stripe->physical + stripe_size - 1,
 				   bits | EXTENT_NOWAIT,
-				   NULL, GFP_NOWAIT, NULL);
+				   NULL, NULL);
 	}
 }
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1e364a7b74aa..594b69d94241 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -95,7 +95,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
 	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1,
-			      EXTENT_DIRTY, NULL, GFP_NOFS);
+			      EXTENT_DIRTY, NULL);
 }
 
 /*
@@ -440,7 +440,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 
 				set_extent_bit(&inode->io_tree, file_offset,
 					       file_offset + sectorsize - 1,
-					       EXTENT_NODATASUM, NULL, GFP_NOFS);
+					       EXTENT_NODATASUM, NULL);
 			} else {
 				btrfs_warn_rl(fs_info,
 			"csum hole found for disk bytenr range [%llu, %llu)",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6144a2b89db2..d730d883d41a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2888,8 +2888,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 
 		ret = set_extent_bit(&inode->io_tree, search_start,
 				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, cached_state,
-				     GFP_NOFS);
+				     EXTENT_DELALLOC_NEW, cached_state);
 next:
 		search_start = extent_map_end(em);
 		free_extent_map(em);
@@ -2923,7 +2922,7 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 	}
 
 	return set_extent_bit(&inode->io_tree, start, end,
-			      EXTENT_DELALLOC | extra_bits, cached_state, GFP_NOFS);
+			      EXTENT_DELALLOC | extra_bits, cached_state);
 }
 
 /* see btrfs_writepage_start_hook for details on why this is required */
@@ -5000,7 +4999,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_NORESERVE, NULL, GFP_NOFS);
+			       EXTENT_NORESERVE, NULL);
 
 out_unlock:
 	if (ret) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1ed8b132fe2a..0bda67ad349e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -175,8 +175,7 @@ static void mark_block_processed(struct reloc_control *rc,
 		     rc->block_group->length)) {
 		blocksize = rc->extent_root->fs_info->nodesize;
 		set_extent_bit(&rc->processed_blocks, node->bytenr,
-			       node->bytenr + blocksize - 1, EXTENT_DIRTY,
-			       NULL, GFP_NOFS);
+			       node->bytenr + blocksize - 1, EXTENT_DIRTY, NULL);
 	}
 	node->processed = 1;
 }
@@ -3054,7 +3053,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 			set_extent_bit(&BTRFS_I(inode)->io_tree,
 				       boundary_start, boundary_end,
-				       EXTENT_BOUNDARY, NULL, GFP_NOFS);
+				       EXTENT_BOUNDARY, NULL);
 		}
 		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
 			      &cached_state);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index acaaddf7181a..f6bc6d738555 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -159,7 +159,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 * |--- delalloc ---|
 	 * |---  search  ---|
 	 */
-	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
+	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
@@ -190,7 +190,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("couldn't find the locked page");
 		goto out_bits;
 	}
-	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
+	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
@@ -245,7 +245,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 *
 	 * We are re-using our test_start from above since it works out well.
 	 */
-	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
+	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
@@ -504,7 +504,7 @@ static int test_find_first_clear_extent_bit(void)
 	 * 4M-32M
 	 */
 	set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
-		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
+		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
 	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
@@ -517,7 +517,7 @@ static int test_find_first_clear_extent_bit(void)
 
 	/* Now add 32M-64M so that we have a hole between 4M-32M */
 	set_extent_bit(&tree, SZ_32M, SZ_64M - 1,
-		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
+		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL);
 
 	/*
 	 * Request first hole starting at 12M, we should get 4M-32M
@@ -548,8 +548,7 @@ static int test_find_first_clear_extent_bit(void)
 	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED flag
 	 * being unset in this range, we should get the entry in range 64M-72M
 	 */
-	set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL,
-		       GFP_NOFS);
+	set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NULL);
 	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
 				    CHUNK_TRIMMED);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fb90e2b20614..98d6b8cc3874 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1612,7 +1612,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
-			EXTENT_DIRTY | EXTENT_NOWAIT, NULL, GFP_NOWAIT);
+			EXTENT_DIRTY | EXTENT_NOWAIT, NULL);
 }
 
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
-- 
2.40.0

