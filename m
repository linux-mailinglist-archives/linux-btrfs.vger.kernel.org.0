Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2707A502BFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354569AbiDOOgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354559AbiDOOgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F6A997D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=go+HMlX5p3x80R1VwZ6BYYtHcxG2opakQ2mqB+8f0BM=; b=t6pryM8HnvHKD/x9h3OPehfRlA
        XVTfKAltYGg6+wvZch9Cnft+jNi8wFIdK3V+SY9td49VfVr3UGCnlPG9kXfHHVok83ydCIt3OD5Fs
        jYLUDtwAT4tFvK1EG343VlHMfZVS0Ikdbj9Pby4iWuO/iXCrjoK+HL7qz61LSbHkGkhEknmR2Z2tR
        K+SdZbrTWs9WUx6sxZB5t6NnH9YU1c4HIubucPP+Zn9kASPoLV5+mU0KNahHEqLCn+IRUK8c3N/3A
        rh/YR1bO4FoHzbtpC5kkiqcw+IssU8UvPAMGqcTG7tPGSS5EWNjsmmB5OfUF/HZqZgEmbhwRbjqGm
        Bcx8D71w==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN14-00AMvf-Lp; Fri, 15 Apr 2022 14:33:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: do not return errors from submit_bio_hook_t instances
Date:   Fri, 15 Apr 2022 16:33:28 +0200
Message-Id: <20220415143328.349010-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
References: <20220415143328.349010-1-hch@lst.de>
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

Both btrfs_repair_one_sector and submit_bio_one as the direct caller of
one of the instances ignore errors as they expect the methods themselves
to call ->bi_end_io on error.  Remove the unused and dangerous return
value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h     |  4 ++--
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 23 ++++++++---------------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0fd3a21cd5a89..67e169ba55e87 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3249,8 +3249,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
-blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-				   int mirror_num, unsigned long bio_flags);
+void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
+			   int mirror_num, unsigned long bio_flags);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c94df8e2ab9d6..b390ec79f9a86 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -71,7 +71,7 @@ struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
 
-typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
+typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 int mirror_num,
 					 unsigned long bio_flags);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 414156c0ac38a..a37da2decf958 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2581,9 +2581,8 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
  *
  *    c-3) otherwise:			async submit
  */
-blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-				   int mirror_num, unsigned long bio_flags)
-
+void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
+			   int mirror_num, unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -2620,7 +2619,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			 */
 			btrfs_submit_compressed_read(inode, bio, mirror_num,
 						     bio_flags);
-			return BLK_STS_OK;
+			return;
 		} else {
 			/*
 			 * Lookup bio sums does extra checks around whether we
@@ -2654,7 +2653,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		bio->bi_status = ret;
 		bio_endio(bio);
 	}
-	return ret;
 }
 
 /*
@@ -7798,25 +7796,20 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	kfree(dip);
 }
 
-static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-					  int mirror_num,
-					  unsigned long bio_flags)
+static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
+				  int mirror_num, unsigned long bio_flags)
 {
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	blk_status_t ret;
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
+	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
+		return;
 
 	refcount_inc(&dip->refs);
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	if (ret)
+	if (btrfs_map_bio(fs_info, bio, mirror_num))
 		refcount_dec(&dip->refs);
-	return ret;
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
-- 
2.30.2

