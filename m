Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2734B69E934
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBUU5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 15:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBUU5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 15:57:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5A199DF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=um+Xcd6h83pD0emvfVcDH2o8EAKFUyxKjqhwY7kaEw0=; b=0yHN26fHCY0KB3L+e8OZ8wc/A6
        wIAgZPPDBA6PFnG0uZS9MZHHLHPXf6eQaFWFI6LcCjSoYtu5548Is15cp2ovgri5GcbFlq7u3MzU7
        6TzKSJm4c7tCrhu2wpVS2R2iEDh8pfI+w/Zw/zRsQJSF9BhN//QJbVomq7TcD1jkqEwNrGxK5lPis
        /MYdml7cJTGVjCKfln0s3dQwOYHPenBUV3OOooXnjzIvO5Umg4cnGnQxdxVlIU/Y1tLWJAH17+j9G
        0tKmLQ25M3ljdxJB9PB8EQfaatX92caSMZBKQ/THp1J/jg7oM4Hd1P9/Uoniy5RUUWJvgvTK4Fu5q
        NqreGVvg==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUZh8-009lKR-7Y; Tue, 21 Feb 2023 20:57:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Date:   Tue, 21 Feb 2023 12:56:59 -0800
Message-Id: <20230221205659.530284-3-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221205659.530284-1-hch@lst.de>
References: <20230221205659.530284-1-hch@lst.de>
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
instead of recalculating it over and over, remove the now superflous
search_len and reduce variable scope as applicable as well as switch
count to and unsigned type for the unsigned values it holds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file-item.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9df9b91dbc6463..efc914b2e17e08 100644
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
@@ -404,25 +403,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
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
+		u64 search_len = orig_len - bio_offset;
+		u8 *csum_dst = bbio->csum +
+			(bio_offset >> fs_info->sectorsize_bits) * csum_size;
+		u32 count = 0;
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 search_len, csum_dst);
@@ -451,7 +437,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			if (inode->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset = bbio->file_offset +
-					cur_disk_bytenr - orig_disk_bytenr;
+					bio_offset;
 
 				set_extent_bits(&inode->io_tree, file_offset,
 						file_offset + sectorsize - 1,
@@ -462,6 +448,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 				cur_disk_bytenr, cur_disk_bytenr + sectorsize);
 			}
 		}
+		bio_offset += count * sectorsize;
 	}
 
 	btrfs_free_path(path);
-- 
2.39.1

