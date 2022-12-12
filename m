Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C364999C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiLLHhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiLLHhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D52B6
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BRXLbrUTGO4IESfi+Dj5Cd6/whGZVlGR1rlfCWBzv0g=; b=HvytvH/w7pC6FOE25v99FVds0q
        iuml0Wk5wAh5XLMKfML8vDOGQrVGuWXYwdNYrcH2wNbeOS9FlcirPYOtZ5iw4BuwtMUy9Zn6GoWof
        tJtSLEqo/PrPGlVqoddjnIH8eojShsG6D3sHKbIRLLk5aW7fBluw2a1LxyR6Udu6vg32bqa2XF/Eh
        k7MlU17j7z67tMRctLqa0+T+U3PGVPe8yv7ztAqufZGO3Kyp0h597kSCHzEJG6sDGdsSt6Nm5BRR5
        U1kSoQjmXY1s5tK5xRDea3/n2c75+OcT2CAYAfs1kanPn3oIABZnsulkMAq1Ci+VJ3c7apMm3vyJO
        +DyB1aQg==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNU-009WLW-OG; Mon, 12 Dec 2022 07:37:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs; rename the disk_bytenr in strut btrfs_ordered_extent
Date:   Mon, 12 Dec 2022 08:37:19 +0100
Message-Id: <20221212073724.12637-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rename the disk_bytenr field to logical to make it clear it holds
a btrfs logical address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c             | 18 +++++++++---------
 fs/btrfs/ordered-data.c      | 10 +++++-----
 fs/btrfs/ordered-data.h      |  2 +-
 fs/btrfs/relocation.c        |  2 +-
 fs/btrfs/zoned.c             |  4 ++--
 include/trace/events/btrfs.h |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 373b7281f5c7dd..3a3a3e0e9484c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2667,9 +2667,9 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
+	ordered_end = ordered->logical + ordered->disk_num_bytes;
 	/* bio must be in one ordered extent */
-	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
+	if (WARN_ON_ONCE(start < ordered->logical || end > ordered_end)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2681,7 +2681,7 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	}
 
 	file_len = ordered->num_bytes;
-	pre = start - ordered->disk_bytenr;
+	pre = start - ordered->logical;
 	post = ordered_end - end;
 
 	ret = btrfs_split_ordered_extent(ordered, pre, post);
@@ -3094,7 +3094,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
+	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->logical);
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
 	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
@@ -3165,7 +3165,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	/* A valid bdev implies a write on a sequential zone */
 	if (ordered_extent->bdev) {
 		btrfs_rewrite_logical_zoned(ordered_extent);
-		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+		btrfs_zone_finish_endio(fs_info, ordered_extent->logical,
 					ordered_extent->disk_num_bytes);
 	}
 
@@ -3220,7 +3220,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
 						logical_len);
-		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_bytenr,
+		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->logical,
 						  ordered_extent->disk_num_bytes);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
@@ -3228,7 +3228,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		if (!ret) {
 			clear_reserved_extent = false;
 			btrfs_release_delalloc_bytes(fs_info,
-						ordered_extent->disk_bytenr,
+						ordered_extent->logical,
 						ordered_extent->disk_num_bytes);
 		}
 	}
@@ -3312,11 +3312,11 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			 */
 			if (ret && btrfs_test_opt(fs_info, DISCARD_SYNC))
 				btrfs_discard_extent(fs_info,
-						ordered_extent->disk_bytenr,
+						ordered_extent->logical,
 						ordered_extent->disk_num_bytes,
 						NULL);
 			btrfs_free_reserved_extent(fs_info,
-					ordered_extent->disk_bytenr,
+					ordered_extent->logical,
 					ordered_extent->disk_num_bytes, 1);
 		}
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4bed0839b64033..72e1acd4624169 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,7 +199,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
 	entry->ram_bytes = ram_bytes;
-	entry->disk_bytenr = disk_bytenr;
+	entry->logical = disk_bytenr;
 	entry->disk_num_bytes = disk_num_bytes;
 	entry->offset = offset;
 	entry->bytes_left = num_bytes;
@@ -642,8 +642,8 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		ordered = list_first_entry(&splice, struct btrfs_ordered_extent,
 					   root_extent_list);
 
-		if (range_end <= ordered->disk_bytenr ||
-		    ordered->disk_bytenr + ordered->disk_num_bytes <= range_start) {
+		if (range_end <= ordered->logical ||
+		    ordered->logical + ordered->disk_num_bytes <= range_start) {
 			list_move_tail(&ordered->root_extent_list, &skipped);
 			cond_resched_lock(&root->ordered_extent_lock);
 			continue;
@@ -1098,7 +1098,7 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
 	struct inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	u64 file_offset = ordered->file_offset + pos;
-	u64 disk_bytenr = ordered->disk_bytenr + pos;
+	u64 disk_bytenr = ordered->logical + pos;
 	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
 
 	/*
@@ -1133,7 +1133,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 		tree->last = NULL;
 
 	ordered->file_offset += pre;
-	ordered->disk_bytenr += pre;
+	ordered->logical += pre;
 	ordered->num_bytes -= (pre + post);
 	ordered->disk_num_bytes -= (pre + post);
 	ordered->bytes_left -= (pre + post);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 89f82b78f590f3..71f200b14a9369 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -96,7 +96,7 @@ struct btrfs_ordered_extent {
 	 */
 	u64 num_bytes;
 	u64 ram_bytes;
-	u64 disk_bytenr;
+	u64 logical;
 	u64 disk_num_bytes;
 	u64 offset;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 31ec4a7658ce6f..798e0e01490dd8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4379,7 +4379,7 @@ int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 		 * disk_len vs real len like with real inodes since it's all
 		 * disk length.
 		 */
-		new_bytenr = ordered->disk_bytenr + sums->bytenr - disk_bytenr;
+		new_bytenr = ordered->logical + sums->bytenr - disk_bytenr;
 		sums->bytenr = new_bytenr;
 
 		btrfs_add_ordered_sum(ordered, sums);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0b769dc8bcdac0..e8681615324dcb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1678,7 +1678,7 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_ordered_sum *sum;
-	u64 orig_logical = ordered->disk_bytenr;
+	u64 orig_logical = ordered->logical;
 	u64 *logical = NULL;
 	int nr, stripe_len;
 
@@ -1697,7 +1697,7 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	if (orig_logical == *logical)
 		goto out;
 
-	ordered->disk_bytenr = *logical;
+	ordered->logical = *logical;
 
 	em_tree = &inode->extent_tree;
 	write_lock(&em_tree->lock);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0bce0b4ff2faf3..58ea7be57b010e 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -536,7 +536,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 	TP_fast_assign_btrfs(inode->root->fs_info,
 		__entry->ino 		= btrfs_ino(inode);
 		__entry->file_offset	= ordered->file_offset;
-		__entry->start		= ordered->disk_bytenr;
+		__entry->start		= ordered->logical;
 		__entry->len		= ordered->num_bytes;
 		__entry->disk_len	= ordered->disk_num_bytes;
 		__entry->bytes_left	= ordered->bytes_left;
-- 
2.35.1

