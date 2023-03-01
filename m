Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809396A6D44
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCANmx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCANms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0A3E09A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CtZvM4WQevpoY4iKsUeGFvTCHCdJrVnxGtLwUiNxEYw=; b=xVzpPklEyjFAx27kv36FLvON4X
        CTp5SCbfHgZSnRP52S25VKoGo8ohdZXlPx4gUqoeTEAbjEm21Y7wdHnau1SxvREuHp6FtmiMqmOZI
        59asEc2Udfr/FZiUuDXXD8SjE63+auMiuku/iGLUN/t3oYX1+TnKy29U5ZgyDHUdIaggF80w5GzfN
        vVNmTL90EhHCw1QzLgCzd/5vpQT00UEtNCu1lrs13es3eXeyCEOo2m4K78sW72GhTM4DB4fXHPoLQ
        g2l9v4LzAIx16WoiC92yfTUkv8cNHSk47AwZZcVohIiLgEXGcnZqu5FkzOysD8cKZjLKXpQ7SVKX4
        FtnjhV+g==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjG-00GN82-38; Wed, 01 Mar 2023 13:42:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10]  btrfs: store a pointer to a btrfs_bio in struct btrfs_bio_ctrl
Date:   Wed,  1 Mar 2023 06:42:41 -0700
Message-Id: <20230301134244.1378533-9-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
References: <20230301134244.1378533-1-hch@lst.de>
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

The bio in struct btrfs_bio_ctrl must be a btrfs_bio, so store a pointer
to the btrfs_bio for better type checking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 05b96a77fba104..df143c5267e61b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -97,7 +97,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
  * how many bytes are there before stripe/ordered extent boundary.
  */
 struct btrfs_bio_ctrl {
-	struct bio *bio;
+	struct btrfs_bio *bbio;
 	int mirror_num;
 	enum btrfs_compression_type compress_type;
 	u32 len_to_oe_boundary;
@@ -123,37 +123,37 @@ struct btrfs_bio_ctrl {
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct bio *bio = bio_ctrl->bio;
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
 	int mirror_num = bio_ctrl->mirror_num;
 
-	if (!bio)
+	if (!bbio)
 		return;
 
 	/* Caller should ensure the bio has at least some range added */
-	ASSERT(bio->bi_iter.bi_size);
+	ASSERT(bbio->bio.bi_iter.bi_size);
 
-	if (!is_data_inode(&btrfs_bio(bio)->inode->vfs_inode)) {
-		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
+	if (!is_data_inode(&bbio->inode->vfs_inode)) {
+		if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE) {
 			/*
 			 * For metadata read, we should have the parent_check,
 			 * and copy it to bbio for metadata verification.
 			 */
 			ASSERT(bio_ctrl->parent_check);
-			memcpy(&btrfs_bio(bio)->parent_check,
+			memcpy(&bbio->parent_check,
 			       bio_ctrl->parent_check,
 			       sizeof(struct btrfs_tree_parent_check));
 		}
-		bio->bi_opf |= REQ_META;
+		bbio->bio.bi_opf |= REQ_META;
 	}
 
-	if (btrfs_op(bio) == BTRFS_MAP_READ &&
+	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(btrfs_bio(bio), mirror_num);
+		btrfs_submit_compressed_read(bbio, mirror_num);
 	else
-		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
+		btrfs_submit_bio(bbio, mirror_num);
 
 	/* The bio is owned by the end_io handler now */
-	bio_ctrl->bio = NULL;
+	bio_ctrl->bbio = NULL;
 }
 
 /*
@@ -161,16 +161,16 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
  */
 static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
 {
-	struct bio *bio = bio_ctrl->bio;
+	struct btrfs_bio *bbio = bio_ctrl->bbio;
 
-	if (!bio)
+	if (!bbio)
 		return;
 
 	if (ret) {
 		ASSERT(ret < 0);
-		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+		btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
 		/* The bio is owned by the end_io handler now */
-		bio_ctrl->bio = NULL;
+		bio_ctrl->bbio = NULL;
 	} else {
 		submit_one_bio(bio_ctrl);
 	}
@@ -863,7 +863,7 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 				struct page *page, u64 disk_bytenr,
 				unsigned int pg_offset)
 {
-	struct bio *bio = bio_ctrl->bio;
+	struct bio *bio = &bio_ctrl->bbio->bio;
 	struct bio_vec *bvec = bio_last_bvec_all(bio);
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 
@@ -902,7 +902,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			      bio_ctrl->end_io_func, NULL);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	btrfs_bio(bio)->file_offset = file_offset;
-	bio_ctrl->bio = bio;
+	bio_ctrl->bbio = btrfs_bio(bio);
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
 
 	/*
@@ -942,8 +942,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
  *
- * The will either add the page into the existing @bio_ctrl->bio, or allocate a
- * new one in @bio_ctrl->bio.
+ * The will either add the page into the existing @bio_ctrl->bbio, or allocate a
+ * new one in @bio_ctrl->bbio.
  * The mirror number for this IO should already be initizlied in
  * @bio_ctrl->mirror_num.
  */
@@ -956,7 +956,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(pg_offset + size <= PAGE_SIZE);
 	ASSERT(bio_ctrl->end_io_func);
 
-	if (bio_ctrl->bio &&
+	if (bio_ctrl->bbio &&
 	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
 		submit_one_bio(bio_ctrl);
 
@@ -964,7 +964,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		u32 len = size;
 
 		/* Allocate new bio if needed */
-		if (!bio_ctrl->bio) {
+		if (!bio_ctrl->bbio) {
 			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
 				      page_offset(page) + pg_offset);
 		}
@@ -976,7 +976,8 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			len = bio_ctrl->len_to_oe_boundary;
 		}
 
-		if (bio_add_page(bio_ctrl->bio, page, len, pg_offset) != len) {
+		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) !=
+				len) {
 			/* bio full: move on to a new one */
 			submit_one_bio(bio_ctrl);
 			continue;
-- 
2.39.1

