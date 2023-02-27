Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A666A45C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjB0PRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjB0PRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923F227A4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=c7H8fNnVmpUCzEmHv9F1XDpxPe5blDfmcW1bDZi0xoI=; b=mpjRsJXv3y8mb7k/inwvLXE902
        WVi8oMZgp2TTu1DsQf9x7MVwth+hLT3PGlqPzgwciclFQDAXyqrLZikGWTxTT35QHaoaRxwkhn6Av
        LjPhT/0p0U1nQfwWKn8onT7SLNt571iMK7g1kC/GbhB2fqWlbvSHywVX5WBBGret3SWjyvhA/qNSQ
        giM1r5ljNtVXULfgkH1hcOIrjoMkQ9IyEyuY81ydiiRR9wASYq7ouoAvLrC2aISLayCj4ea4CJQKz
        8p4+AskdhUPKOL4GSnVRrr7/e+c4FLNIKRKzu9B2SicDmMyVVUV2t3DR8VNBaPu+19z4GUFvXqgx/
        TE/UJUcQ==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFT-00AAt3-7w; Mon, 27 Feb 2023 15:17:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: move the compress_type check out of btrfs_bio_add_page
Date:   Mon, 27 Feb 2023 08:16:58 -0700
Message-Id: <20230227151704.1224688-7-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
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

The compress_type can only change on a per-extent basis.  So instead of
checking it for every page in btrfs_bio_add_page, do the check once in
btrfs_do_readpage, which is the only caller of btrfs_bio_add_page and
submit_extent_page that deals with compressed extents.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1de56abd7308c7..eac31f212069a0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -875,7 +875,6 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
  *                  a contiguous page to the previous one
  * @size:	    portion of page that we want to write
  * @pg_offset:	    starting offset in the page
- * @compress_type:  compression type of the current bio to see if we can merge them
  *
  * Attempt to add a page to bio considering stripe alignment etc.
  *
@@ -886,8 +885,7 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 			      struct page *page,
 			      u64 disk_bytenr, unsigned int size,
-			      unsigned int pg_offset,
-			      enum btrfs_compression_type compress_type)
+			      unsigned int pg_offset)
 {
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
@@ -898,9 +896,6 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary);
-	if (bio_ctrl->compress_type != compress_type)
-		return 0;
-
 
 	if (bio->bi_iter.bi_size == 0) {
 		/* We can always add a page into an empty bio. */
@@ -1049,12 +1044,11 @@ static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		 */
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
-					size - offset, pg_offset + offset,
-					compress_type);
+					size - offset, pg_offset + offset);
 		else
 			added = btrfs_bio_add_page(bio_ctrl, page,
 					disk_bytenr + offset, size - offset,
-					pg_offset + offset, compress_type);
+					pg_offset + offset);
 
 		/* Metadata page range should never be split */
 		if (!is_data_inode(&inode->vfs_inode))
@@ -1320,6 +1314,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			continue;
 		}
 
+		if (bio_ctrl->compress_type != this_bio_flag)
+			submit_one_bio(bio_ctrl);
+
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
 		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-- 
2.39.1

