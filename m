Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB8A269DE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIOFgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIOFgI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F593AD52
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/19] btrfs: extent_io: only require sector size alignment for page read
Date:   Tue, 15 Sep 2020 13:35:25 +0800
Message-Id: <20200915053532.63279-13-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
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
index 9d4a81997738..f4ab59b3ce3c 100644
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

