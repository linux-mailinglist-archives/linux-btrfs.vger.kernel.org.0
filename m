Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE375F844
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGXN11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGXN1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ACF188
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vr90lnDriW/R2EKnp/6tlr92hiSFQal6c/cwWDPPJmM=; b=es/B40Kb6rk6qCVMq0fKaNtmmi
        G+Y3KTOjgGmiBk9jjTKxslYs5+kZ77cNs6cIgQVqiS4n/2Hf+RO3tcJ95N4Ea/58gslLqg1857Atp
        sNqhLxXFIXqYZJuIhITIV3jseOeq8/EQWd5Tbc7679y62zlHWbOUqigTP7v0FvJzxKtYU5Tyg/8Y7
        yYJOuIe3iQgqDpzmi31VEGbvQPeAwp0cmV3P4p0mlFFqvAaiGkDak4+b9fppXUlWkJomiNSakKDmm
        mEjENNz7bktZg/Rp+rGwofhwWkKyE6Llr3dlBe6qirwRvPyyf7WkWPRLdL9c/BMoB1ccpwU0oLLUW
        R0vEKb9g==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaZ-004RM9-0f;
        Mon, 24 Jul 2023 13:27:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: fix a race in clearing the writeback bit for sub-page I/O
Date:   Mon, 24 Jul 2023 06:26:59 -0700
Message-Id: <20230724132701.816771-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For sub-page I/O, a fast I/O completion can clear the page writeback bit
in the I/O completion handler before subsequent bios were submitted.
Use a trick from iomap and defer submission of bios until we're reached
the end of the page to avoid this race.

Fixes: c5ef5c6c733a ("btrfs: make __extent_writepage_io() only submit dirty range for subpage")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 54 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fada7a1931b130..48a49c57daa6fd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -105,7 +105,8 @@ struct btrfs_bio_ctrl {
 	struct writeback_control *wbc;
 };
 
-static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
+static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl,
+			   struct bio_list *bio_list)
 {
 	struct btrfs_bio *bbio = bio_ctrl->bbio;
 
@@ -118,6 +119,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
+	else if (bio_list)
+		bio_list_add(bio_list, &bbio->bio);
 	else
 		btrfs_submit_bio(bbio, 0);
 
@@ -141,7 +144,22 @@ static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
 		/* The bio is owned by the end_io handler now */
 		bio_ctrl->bbio = NULL;
 	} else {
-		submit_one_bio(bio_ctrl);
+		submit_one_bio(bio_ctrl, NULL);
+	}
+}
+
+static void btrfs_submit_pending_bios(struct bio_list *bio_list, int ret)
+{
+	struct bio *bio;
+
+	if (ret) {
+		blk_status_t status = errno_to_blk_status(ret);
+
+		while ((bio = bio_list_pop(bio_list)))
+			btrfs_bio_end_io(btrfs_bio(bio), status);
+	} else {
+		while ((bio = bio_list_pop(bio_list)))
+			btrfs_submit_bio(btrfs_bio(bio), 0);
 	}
 }
 
@@ -791,7 +809,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  */
 static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			       u64 disk_bytenr, struct page *page,
-			       size_t size, unsigned long pg_offset)
+			       size_t size, unsigned long pg_offset,
+			       struct bio_list *bio_list)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 
@@ -800,7 +819,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	if (bio_ctrl->bbio &&
 	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
-		submit_one_bio(bio_ctrl);
+		submit_one_bio(bio_ctrl, bio_list);
 
 	do {
 		u32 len = size;
@@ -820,7 +839,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {
 			/* bio full: move on to a new one */
-			submit_one_bio(bio_ctrl);
+			submit_one_bio(bio_ctrl, bio_list);
 			continue;
 		}
 
@@ -834,7 +853,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 		/* Ordered extent boundary: move on to a new bio. */
 		if (bio_ctrl->len_to_oe_boundary == 0)
-			submit_one_bio(bio_ctrl);
+			submit_one_bio(bio_ctrl, bio_list);
 	} while (size);
 }
 
@@ -1082,14 +1101,14 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		if (bio_ctrl->compress_type != compress_type) {
-			submit_one_bio(bio_ctrl);
+			submit_one_bio(bio_ctrl, NULL);
 			bio_ctrl->compress_type = compress_type;
 		}
 
 		if (force_bio_submit)
-			submit_one_bio(bio_ctrl);
+			submit_one_bio(bio_ctrl, NULL);
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-				   pg_offset);
+				   pg_offset, NULL);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
@@ -1113,7 +1132,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
 	 * bio to do the cleanup.
 	 */
-	submit_one_bio(&bio_ctrl);
+	submit_one_bio(&bio_ctrl, NULL);
 	return ret;
 }
 
@@ -1287,6 +1306,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	u64 extent_offset;
 	u64 block_start;
 	struct extent_map *em;
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	int ret = 0;
 	int nr = 0;
 
@@ -1365,7 +1385,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-				   cur - page_offset(page));
+				   cur - page_offset(page), &bio_list);
 		cur += iosize;
 		nr++;
 	}
@@ -1378,6 +1398,16 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
+
+	/*
+	 * Submit all bios we queued up for this page.
+	 *
+	 * The bios are not submitted directly after building them as otherwise
+	 * a very fast I/O completion on an earlier bio could clear the page
+	 * writeback bit before the subsequent bios are even submitted.
+	 */
+	btrfs_submit_pending_bios(&bio_list, ret);
+
 	if (ret) {
 		u32 remaining = end + 1 - cur;
 
@@ -2243,7 +2273,7 @@ void extent_readahead(struct readahead_control *rac)
 
 	if (em_cached)
 		free_extent_map(em_cached);
-	submit_one_bio(&bio_ctrl);
+	submit_one_bio(&bio_ctrl, NULL);
 }
 
 /*
-- 
2.39.2

