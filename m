Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39C676470
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 07:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAUGvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 01:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAUGvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A466ECB;
        Fri, 20 Jan 2023 22:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9irODL+AQiJBVDSFPL6vUOHki77ls49Kqx2CWPfSUYM=; b=vFofCLFFou0e/yReSNCm4hyCBs
        6qkJw6f2PYHvLUKA8zZ07eJL1ssRfaZMObOjhyvAtVcZjuhRKPF8i+O9G+c2T08CiGpsjQvuY6FR6
        Xwmo+/YZ6mhYYjJh3MPJ3bwLJCKjVtQELXfSbCTpuZudiKrmZ4FJHEHS6B1Etz2Z37mjyBavyaNL0
        HHHqiitHydGGoCCgchADdBpTQaFO8vlEPvo8hscBcPmDK5O/EgpmPxcMsus90reqQvbz/yZsM8ghV
        FmKuMdgwx/nWSXB4U/jGoSdcDA/ZuiPdXRZkBJCoYIkpGw8Nr9CcpAxnHIV/9fiVau8FZk70qTc38
        pF9Nfi4w==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7ij-00DRWd-JT; Sat, 21 Jan 2023 06:51:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/34] btrfs: remove the submit_bio_start helpers
Date:   Sat, 21 Jan 2023 07:50:15 +0100
Message-Id: <20230121065031.1139353-19-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just call btrfs_csum_one_bio and btree_csum_one_bio directly.

Note that btree_csum_one_bio has to be moved up in the file a bit
to avoid a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/btrfs_inode.h |  4 ----
 fs/btrfs/disk-io.c     | 54 ++++++++++++++++++------------------------
 fs/btrfs/disk-io.h     |  1 -
 fs/btrfs/inode.c       | 20 ----------------
 4 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 78c7979b8dcac7..ba5f023aaf5573 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -408,10 +408,6 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
-blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
-					      struct bio *bio,
-					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a8ca6a518cf62..d89ba4d0f898e5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "file-item.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -455,6 +456,24 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return csum_one_extent_buffer(eb);
 }
 
+static blk_status_t btree_csum_one_bio(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct btrfs_root *root;
+	int ret = 0;
+	struct bvec_iter_all iter_all;
+
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
+		ret = csum_dirty_buffer(root->fs_info, bvec);
+		if (ret)
+			break;
+	}
+
+	return errno_to_blk_status(ret);
+}
+
 static int check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -708,14 +727,14 @@ static void run_one_async_start(struct btrfs_work *work)
 	async = container_of(work, struct  async_submit_bio, work);
 	switch (async->submit_cmd) {
 	case WQ_SUBMIT_METADATA:
-		ret = btree_submit_bio_start(async->bio);
+		ret = btree_csum_one_bio(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_submit_bio_start(async->inode, async->bio);
+		ret = btrfs_csum_one_bio(async->inode, async->bio, (u64)-1, false);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_submit_bio_start_direct_io(async->inode,
-				async->bio, async->dio_file_offset);
+		ret = btrfs_csum_one_bio(async->inode, async->bio,
+					 async->dio_file_offset, false);
 		break;
 	default:
 		/* Can't happen so return something that would prevent the IO. */
@@ -800,33 +819,6 @@ bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_
 	return true;
 }
 
-static blk_status_t btree_csum_one_bio(struct bio *bio)
-{
-	struct bio_vec *bvec;
-	struct btrfs_root *root;
-	int ret = 0;
-	struct bvec_iter_all iter_all;
-
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
-		if (ret)
-			break;
-	}
-
-	return errno_to_blk_status(ret);
-}
-
-blk_status_t btree_submit_bio_start(struct bio *bio)
-{
-	/*
-	 * when we're called for a write, we're already in the async
-	 * submission context.  Just jump into btrfs_submit_bio.
-	 */
-	return btree_csum_one_bio(bio);
-}
-
 static bool should_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f2f295eb6103da..5898beb648484a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -122,7 +122,6 @@ enum btrfs_wq_submit_cmd {
 
 bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
-blk_status_t btree_submit_bio_start(struct bio *bio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 190c5ba92f9320..014cd6a4544132 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2532,19 +2532,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-/*
- * in order to insert checksums into the metadata in large chunks,
- * we wait until bio submission time.   All the pages in the bio are
- * checksummed and sums are attached onto the ordered extent record.
- *
- * At IO completion time the cums attached on the ordered extent record
- * are inserted into the btree
- */
-blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio)
-{
-	return btrfs_csum_one_bio(inode, bio, (u64)-1, false);
-}
-
 /*
  * Split an extent_map at [start, start + len]
  *
@@ -7835,13 +7822,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
-					      struct bio *bio,
-					      u64 dio_file_offset)
-{
-	return btrfs_csum_one_bio(inode, bio, dio_file_offset, false);
-}
-
 static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 {
 	struct btrfs_dio_private *dip = bbio->private;
-- 
2.39.0

