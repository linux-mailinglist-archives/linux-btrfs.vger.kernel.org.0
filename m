Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74BC260C7B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgIHHxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgIHHxO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 870C2AE67
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/17] btrfs: extent_io: only require sector size alignment for page read
Date:   Tue,  8 Sep 2020 15:52:26 +0800
Message-Id: <20200908075230.86856-14-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're reading partial page, btrfs will warn about this as our
read/write are always done in sector size, which equals page size.

But for the incoming subpage RO support, our data read is only aligned
to sectorsize, which can be smaller than page size.

Thus here we change the warning condition to check it against
sectorsize, thus the behavior is not changed for regular sectorsize ==
PAGE_SIZE case, while won't report error for subpage read.

Also, pass the proper start/end with bv_offset for check_data_csum() to
handle.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 81e43d99feda..a83b63ecc5f8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2819,6 +2819,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		u32 sectorsize = fs_info->sectorsize;
 		bool data_inode = btrfs_ino(BTRFS_I(inode))
 			!= BTRFS_BTREE_INODE_OBJECTID;
 
@@ -2829,13 +2830,17 @@ static void end_bio_extent_readpage(struct bio *bio)
 		tree = &BTRFS_I(inode)->io_tree;
 		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
-		/* We always issue full-page reads, but if some block
+		/*
+		 * We always issue full-sector reads, but if some block
 		 * in a page fails to read, blk_update_request() will
 		 * advance bv_offset and adjust bv_len to compensate.
-		 * Print a warning for nonzero offsets, and an error
-		 * if they don't add up to a full page.  */
-		if (bvec->bv_offset || bvec->bv_len != PAGE_SIZE) {
-			if (bvec->bv_offset + bvec->bv_len != PAGE_SIZE)
+		 * Print a warning for unaligned offsets, and an error
+		 * if they don't add up to a full sector.
+		 */
+		if (!IS_ALIGNED(bvec->bv_offset, sectorsize) ||
+		    !IS_ALIGNED(bvec->bv_offset + bvec->bv_len, sectorsize)) {
+			if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
+					sectorsize))
 				btrfs_err(fs_info,
 					"partial page read in btrfs with offset %u and length %u",
 					bvec->bv_offset, bvec->bv_len);
@@ -2845,8 +2850,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 					bvec->bv_offset, bvec->bv_len);
 		}
 
-		start = page_offset(page);
-		end = start + bvec->bv_offset + bvec->bv_len - 1;
+		start = page_offset(page) + bvec->bv_offset;
+		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
 		mirror = io_bio->mirror_num;
-- 
2.28.0

