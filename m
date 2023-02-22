Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082F69F99B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjBVRHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 12:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjBVRHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 12:07:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981573CE27
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HYCETIibdzdHjfePTfY/9l6TwWa3Izre6TlifKGHQPE=; b=tvS1rGJp68Q/7tRI9wQED6p3Bm
        K4pHoufPIgyuTG8TYWqvOz6uizLgIVGtDI/G4sykqHvj421BFDa58hyJvHnDvadF/tn1v58Xn4qQo
        8lc/FahBqaRN6zm88zsFhn2FzMn1x9bx8A/X4UWi5CxvFVX3+uNHYkCS0Xf/q0qQD3cesDYqE8ha/
        b2oS77nkcjRNVpJMZPQTRxl+MQGTPHa0RXJ4GzMuLa7m+DFFCPHZfPowgzhDSKhD4aeLAnPxUdoDn
        5W/+TapkJuAUNCilNPkwlLQLvDhbZAwrUglSriOpZdbMrtDlqfea8ArcaCQDkQfcvn0q5dDgrYLw0
        HGm2pgxg==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUsa8-00D9Ou-Si; Wed, 22 Feb 2023 17:07:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Date:   Wed, 22 Feb 2023 09:07:02 -0800
Message-Id: <20230222170702.713521-3-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222170702.713521-1-hch@lst.de>
References: <20230222170702.713521-1-hch@lst.de>
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

Introduce a bio_offset variable for the current offset into the bio
instead of recalculating it over and over.   Remove the now only
used once search_len and sector_offset variables, and reduce the
scope for count and cur_disk_bytenr.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file-item.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9df9b91dbc6463..3e0995ce7a2c83 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -350,10 +350,9 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	const u32 csum_size = fs_info->csum_size;
 	u32 orig_len = bio->bi_iter.bi_size;
 	u64 orig_disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 cur_disk_bytenr;
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
-	int count = 0;
 	blk_status_t ret = BLK_STS_OK;
+	u32 bio_offset = 0;
 
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
@@ -404,28 +403,14 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		path->skip_locking = 1;
 	}
 
-	for (cur_disk_bytenr = orig_disk_bytenr;
-	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
-	     cur_disk_bytenr += (count * sectorsize)) {
-		u64 search_len = orig_disk_bytenr + orig_len - cur_disk_bytenr;
-		unsigned int sector_offset;
-		u8 *csum_dst;
-
-		/*
-		 * Although both cur_disk_bytenr and orig_disk_bytenr is u64,
-		 * we're calculating the offset to the bio start.
-		 *
-		 * Bio size is limited to UINT_MAX, thus unsigned int is large
-		 * enough to contain the raw result, not to mention the right
-		 * shifted result.
-		 */
-		ASSERT(cur_disk_bytenr - orig_disk_bytenr < UINT_MAX);
-		sector_offset = (cur_disk_bytenr - orig_disk_bytenr) >>
-				fs_info->sectorsize_bits;
-		csum_dst = bbio->csum + sector_offset * csum_size;
+	while (bio_offset < orig_len) {
+		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;
+		u8 *csum_dst = bbio->csum +
+			(bio_offset >> fs_info->sectorsize_bits) * csum_size;
+		int count;
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
-					 search_len, csum_dst);
+					 orig_len - bio_offset, csum_dst);
 		if (count < 0) {
 			ret = errno_to_blk_status(count);
 			if (bbio->csum != bbio->csum_inline)
@@ -451,7 +436,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			if (inode->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset = bbio->file_offset +
-					cur_disk_bytenr - orig_disk_bytenr;
+					bio_offset;
 
 				set_extent_bits(&inode->io_tree, file_offset,
 						file_offset + sectorsize - 1,
@@ -462,6 +447,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 				cur_disk_bytenr, cur_disk_bytenr + sectorsize);
 			}
 		}
+		bio_offset += count * sectorsize;
 	}
 
 	btrfs_free_path(path);
-- 
2.39.1

