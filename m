Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416AB699A31
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBPQfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBPQfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4AD4ECF1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sgqdu/c2CG9K7hmsXmFfhSzw51pkrPXVUvx0oxzJVrw=; b=rWI6T4pyoU/yfcGX+OSqZgLux5
        CMqyCEwe9kNVEEwxGQpa/hGjtDTU44o4jLv6BtlRBYOt43xT2i9VgsBWLOXuaoWn6/2rQloG4093c
        f5PTVMLEQqJVKPXP89WFMqgXON/kTo4Mh2RGRKRtBD00UeSW4hQwyM9Mfrd92w/syYIMNVRUlbWuJ
        qCRcA0DJaGEyXIljPFKvpdjAnqbtJdZe7eDZLMX1JCKxeaVbbTuMhD1UWdoHvoH+mJj/Fj20OhW4O
        mVRJtk+SRdMRdj8fEsYeV0qR93rOf1oIABptSq/HYnMY3KCLqbOSly6bCgMV9qTNr+227mt4VlClp
        UCb+1rig==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDw-00BD5g-O3; Thu, 16 Feb 2023 16:35:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: check for contiguity in submit_extent_page
Date:   Thu, 16 Feb 2023 17:34:36 +0100
Message-Id: <20230216163437.2370948-12-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
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

Different loop iterations in btrfs_bio_add_page not only have
the same contiguity parameters, but also any non-initial operation
operates on a fresh bio anyway.

Factor out the contiguity check into a new btrfs_bio_is_contig and
only call it once in submit_extent_page before descending into the
bio_add_page loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 68 +++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b493f4ee5b2c1..65b2e0328e87a5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -866,6 +866,37 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 	return 0;
 }
 
+static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
+				struct page *page, u64 disk_bytenr,
+				unsigned int pg_offset)
+{
+	struct bio *bio = bio_ctrl->bio;
+	struct bio_vec *bvec = bio_last_bvec_all(bio);
+	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
+
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
+		/*
+		 * For compression, all IO should have its logical bytenr
+		 * set to the starting bytenr of the compressed extent.
+		 */
+		return bio->bi_iter.bi_sector == sector;
+	}
+
+	/*
+	 * The contig check requires the following conditions to be met:
+	 * 1) The pages are belonging to the same inode
+	 *    This is implied by the call chain.
+	 *
+	 * 2) The range has adjacent logical bytenr
+	 *
+	 * 3) The range has adjacent file offset
+	 *    This is required for the usage of btrfs_bio->file_offset.
+	 */
+	return bio_end_sector(bio) == sector &&
+		page_offset(bvec->bv_page) + bvec->bv_offset + bvec->bv_len ==
+		page_offset(page) + pg_offset;
+}
+
 /*
  * Attempt to add a page to bio.
  *
@@ -890,44 +921,11 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
 	u32 real_size;
-	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
-	bool contig = false;
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary);
 
-	if (bio->bi_iter.bi_size == 0) {
-		/* We can always add a page into an empty bio. */
-		contig = true;
-	} else if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
-		struct bio_vec *bvec = bio_last_bvec_all(bio);
-
-		/*
-		 * The contig check requires the following conditions to be met:
-		 * 1) The pages are belonging to the same inode
-		 *    This is implied by the call chain.
-		 *
-		 * 2) The range has adjacent logical bytenr
-		 *
-		 * 3) The range has adjacent file offset
-		 *    This is required for the usage of btrfs_bio->file_offset.
-		 */
-		if (bio_end_sector(bio) == sector &&
-		    page_offset(bvec->bv_page) + bvec->bv_offset +
-		    bvec->bv_len == page_offset(page) + pg_offset)
-			contig = true;
-	} else {
-		/*
-		 * For compression, all IO should have its logical bytenr
-		 * set to the starting bytenr of the compressed extent.
-		 */
-		contig = bio->bi_iter.bi_sector == sector;
-	}
-
-	if (!contig)
-		return 0;
-
 	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
 
 	/*
@@ -1024,6 +1022,10 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	ASSERT(bio_ctrl->end_io_func);
 
+	if (bio_ctrl->bio &&
+	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
+		submit_one_bio(bio_ctrl);
+
 	while (cur < pg_offset + size) {
 		u32 offset = cur - pg_offset;
 		int added;
-- 
2.39.1

