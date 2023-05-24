Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CDB70F9AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjEXPEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbjEXPED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:04:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034CF9C
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4nRpOV/h8560eJR/M3FAVD53LuAX1/UseMhCqopXnRo=; b=RDiI9EaATw+9obSp8HXEaZv+ZY
        poxl+Ji2rA5qFZl+5U8B6hhfMGsCLU4JFREwDzdVU0dQLrAv7bq5fEtpThyFPvMGChfH/QTga/Xxt
        gwqoikPGd8ZEYBdhM1Pqu3rUcmGNIiBYa7m0Mq9hEsaMb/GoT4r55VmsLWo/QnNgm3dxNFgbRIdVT
        DdoE5YzEUYyrtQ0h6+idMkqBG0S7dVfK2uUNxPBcgHxRs9tWs3uszjEE+/adVV2LgPLUpjtrsJse9
        EtcNmPHsLTaGZLp4iQo/mw07w9Gjwv1pnHd7j4dKWLM8HvyluVepHe36lQjK0pob35Nnw1gYuJ/QB
        KdeDAPlw==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1v-00DmhQ-0r;
        Wed, 24 May 2023 15:03:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs: defer splitting of ordered extents until I/O completion
Date:   Wed, 24 May 2023 17:03:16 +0200
Message-Id: <20230524150317.1767981-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs zoned completion code currently needs an ordered_extent and
extent_map per bio so that it can account for the non-predictable
write location from Zone Append.  To archive that it currently splits
the ordered_extent and extent_map at I/O submission time, and then
records the actual physical address in the ->physical field of the
ordered_extent.

This patch instead switches to record the "original" physical address
that the btrfs allocator assigned in spare space in the btrfs_bio,
and then rewrites the logical address in the btrfs_ordered_sum
structure at I/O completion time.  This allows the ordered extent
completion handler to simply walk the list of ordered csums and
split the ordered extent as needed.  This removes an extra ordered
extent and extent_map lookup and manipulation during the I/O
submission path, and instead batches it in the I/O completion path
where we need to touch these anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c          | 17 ------------
 fs/btrfs/btrfs_inode.h  |  2 --
 fs/btrfs/inode.c        | 18 ++++++++-----
 fs/btrfs/ordered-data.h |  1 +
 fs/btrfs/zoned.c        | 57 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/zoned.h        |  6 ++---
 6 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8a4d3b707dd1b2..ae6345668d2d01 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -61,20 +61,6 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
-static blk_status_t btrfs_bio_extract_ordered_extent(struct btrfs_bio *bbio)
-{
-	struct btrfs_ordered_extent *ordered;
-	int ret;
-
-	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
-	ret = btrfs_extract_ordered_extent(bbio, ordered);
-	btrfs_put_ordered_extent(ordered);
-
-	return errno_to_blk_status(ret);
-}
-
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length, bool use_append)
@@ -667,9 +653,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_bio_extract_ordered_extent(bbio);
-			if (ret)
-				goto fail_put_bio;
 		}
 
 		/*
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 08c99602339408..8abf96cfea8fae 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -410,8 +410,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
-				 struct btrfs_ordered_extent *ordered);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cee71eaec7cff9..eee4eefb279780 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2714,8 +2714,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
-				 struct btrfs_ordered_extent *ordered)
+static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
+					struct btrfs_ordered_extent *ordered)
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
@@ -3180,7 +3180,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  * an ordered extent if the range of bytes in the file it covers are
  * fully written.
  */
-void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
+void btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
 	struct btrfs_root *root = inode->root;
@@ -3215,11 +3215,9 @@ void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (btrfs_is_zoned(fs_info)) {
-		btrfs_rewrite_logical_zoned(ordered_extent);
+	if (btrfs_is_zoned(fs_info))
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
-	}
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
@@ -3385,6 +3383,14 @@ void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	btrfs_put_ordered_extent(ordered_extent);
 }
 
+void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
+{
+	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
+	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
+		btrfs_finish_ordered_zoned(ordered);
+	btrfs_finish_one_ordered(ordered);
+}
+
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 2c6efebd043c04..6d1de157792741 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -161,6 +161,7 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 	t->last = NULL;
 }
 
+void btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent);
 void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e838c2037634c2..92363fafc3a648 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "super.h"
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
@@ -1665,16 +1666,11 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 		sum->logical += physical - bbio->orig_physical;
 }
 
-void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
+static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
+					u64 logical)
 {
 	struct extent_map_tree *em_tree = &BTRFS_I(ordered->inode)->extent_tree;
 	struct extent_map *em;
-	struct btrfs_ordered_sum *sum =
-		list_first_entry(&ordered->list, typeof(*sum), list);
-	u64 logical = sum->logical;
-
-	if (ordered->disk_bytenr == logical)
-		return;
 
 	ordered->disk_bytenr = logical;
 
@@ -1686,6 +1682,53 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	write_unlock(&em_tree->lock);
 }
 
+static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
+				      u64 logical, u64 len)
+{
+	struct btrfs_ordered_extent *new;
+
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags) &&
+	    split_extent_map(BTRFS_I(ordered->inode), ordered->file_offset,
+			     ordered->num_bytes, len))
+		return false;
+
+	new = btrfs_split_ordered_extent(ordered, len);
+	if (IS_ERR(new))
+		return false;
+
+	if (new->disk_bytenr != logical)
+		btrfs_rewrite_logical_zoned(new, logical);
+	btrfs_finish_one_ordered(new);
+	return true;
+}
+
+void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ordered->inode->i_sb);
+	struct btrfs_ordered_sum *sum =
+		list_first_entry(&ordered->list, typeof(*sum), list);
+	u64 logical = sum->logical;
+	u64 len = sum->len;
+
+	while (len < ordered->disk_num_bytes) {
+		sum = list_next_entry(sum, list);
+		if (sum->logical == logical + len) {
+			len += sum->len;
+			continue;
+		}
+		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
+			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
+			btrfs_err(fs_info, "failed to split ordered extent\n");
+			return;
+		}
+		logical = sum->logical;
+		len = sum->len;
+	}
+
+	if (ordered->disk_bytenr != logical)
+		btrfs_rewrite_logical_zoned(ordered, logical);
+}
+
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 3058ef559c9813..27322b926038c2 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -30,6 +30,8 @@ struct btrfs_zoned_device_info {
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
+void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
@@ -56,7 +58,6 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
-void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret);
@@ -188,9 +189,6 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-static inline void btrfs_rewrite_logical_zoned(
-				struct btrfs_ordered_extent *ordered) { }
-
 static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 			       struct extent_buffer *eb,
 			       struct btrfs_block_group **cache_ret)
-- 
2.39.2

