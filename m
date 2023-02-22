Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BD69F99A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjBVRHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 12:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjBVRHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 12:07:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23E3B0EE
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kLRngY/vG6sxCRAjnJGUJGRdWEW5XoOIjThP7k7n/ng=; b=j5x5dkCrBFyT4cNlfKf90YgWZQ
        k2UfWaQDGNUE6UOKr8FXLl1Izw2I/m5Lv/uuZ57QarCm7/SDpH6t8dZke8Q8BMYIz/L/WxxR3zXQ5
        rVy3LHHpLhWuH2SOfuXUZgdJV2xkAkOyUwnMcD3PORoR226Nln4Vn8ciNcL3iN6IbbUFRW2dnelI/
        Z4A86z9PNHjtaxh3NivTdys5VFk2hLUJBtAwKIwVWzOoNRoa0lMRsUugTRH7UogHGBP0CZC2CPqYd
        GamZiADp3etzapZ73BMbR9OL9iN47vLvaX/Ap2rt7FKJADCdCD2PdPO4oRbsKR+pkTHWCKn6PWnzF
        7RjhSUuw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUsa8-00D9OO-87; Wed, 22 Feb 2023 17:07:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: remove search_file_offset_in_bio
Date:   Wed, 22 Feb 2023 09:07:01 -0800
Message-Id: <20230222170702.713521-2-hch@lst.de>
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

There is no need to search for a file offset in a bio, it is now
always provided in bbio->file_offset.  Just use that with the
offset into the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/file-item.c | 52 +++-----------------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index fff09e5635e5f2..9df9b91dbc6463 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -335,48 +335,6 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-/*
- * Locate the file_offset of @cur_disk_bytenr of a @bio.
- *
- * Bio of btrfs represents read range of
- * [bi_sector << 9, bi_sector << 9 + bi_size).
- * Knowing this, we can iterate through each bvec to locate the page belong to
- * @cur_disk_bytenr and get the file offset.
- *
- * @inode is used to determine if the bvec page really belongs to @inode.
- *
- * Return false if we can't find the file offset
- * Return true if we find the file offset and restore it to @file_offset_ret
- */
-static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
-				     u64 disk_bytenr, u64 *file_offset_ret)
-{
-	struct bvec_iter iter;
-	struct bio_vec bvec;
-	u64 cur = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	bool ret = false;
-
-	bio_for_each_segment(bvec, bio, iter) {
-		struct page *page = bvec.bv_page;
-
-		if (cur > disk_bytenr)
-			break;
-		if (cur + bvec.bv_len <= disk_bytenr) {
-			cur += bvec.bv_len;
-			continue;
-		}
-		ASSERT(in_range(disk_bytenr, cur, bvec.bv_len));
-		if (page->mapping && page->mapping->host &&
-		    page->mapping->host == inode) {
-			ret = true;
-			*file_offset_ret = page_offset(page) + bvec.bv_offset +
-					   disk_bytenr - cur;
-			break;
-		}
-	}
-	return ret;
-}
-
 /*
  * Lookup the checksum for the read bio in csum tree.
  *
@@ -386,7 +344,6 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct bio *bio = &bbio->bio;
 	struct btrfs_path *path;
 	const u32 sectorsize = fs_info->sectorsize;
@@ -493,13 +450,10 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 
 			if (inode->root->root_key.objectid ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
-				u64 file_offset;
+				u64 file_offset = bbio->file_offset +
+					cur_disk_bytenr - orig_disk_bytenr;
 
-				if (search_file_offset_in_bio(bio,
-							      &inode->vfs_inode,
-							      cur_disk_bytenr,
-							      &file_offset))
-					set_extent_bits(io_tree, file_offset,
+				set_extent_bits(&inode->io_tree, file_offset,
 						file_offset + sectorsize - 1,
 						EXTENT_NODATASUM);
 			} else {
-- 
2.39.1

