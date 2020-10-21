Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C179C294828
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440734AbgJUG02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440725AbgJUG01 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Sct496M1vc0JrFl6TRtnbRDLnUxfT7e2s6vXQodJyM=;
        b=BZMbBVoVNKlM12CjESGHU2KOptCpgiOlHZ6Yv7n2+g8yZtFUlc0qjl+wMdag9/v9buBydv
        dAxe0IZN6E4CbPAaTlb4uGHssi1PkP3SY52g2EXErdctbjMB4LZQneDrSAH8rrbkN80SdJ
        NN/YICu91XoKShbZPIDPqKWTORXALPk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70F34AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 12/68] btrfs: extent_io: only require sector size alignment for page read
Date:   Wed, 21 Oct 2020 14:24:58 +0800
Message-Id: <20201021062554.68132-13-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're reading partial page, btrfs will warn about this as our
read/write are always done in sector size, which equals page size.

But for the incoming subpage RO support, our data read is only aligned
to sectorsize, which can be smaller than page size.

Thus here we change the warning condition to check it against
sectorsize, thus the behavior is not changed for regular sectorsize ==
PAGE_SIZE case, and won't report error for subpage read.

Also, pass the proper start/end with bv_offset for check_data_csum() to
handle.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f20b8e886724..ce5b23169e47 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2834,6 +2834,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		u32 sectorsize = fs_info->sectorsize;
 		bool data_inode = btrfs_ino(BTRFS_I(inode))
 			!= BTRFS_BTREE_INODE_OBJECTID;
 
@@ -2844,24 +2845,25 @@ static void end_bio_extent_readpage(struct bio *bio)
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
-				btrfs_err(fs_info,
-					"partial page read in btrfs with offset %u and length %u",
-					bvec->bv_offset, bvec->bv_len);
-			else
-				btrfs_info(fs_info,
-					"incomplete page read in btrfs with offset %u and length %u",
-					bvec->bv_offset, bvec->bv_len);
-		}
-
-		start = page_offset(page);
-		end = start + bvec->bv_offset + bvec->bv_len - 1;
+		 * Print a warning for unaligned offsets, and an error
+		 * if they don't add up to a full sector.
+		 */
+		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+			btrfs_err(fs_info,
+		"partial page read in btrfs with offset %u and length %u",
+				  bvec->bv_offset, bvec->bv_len);
+		else if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
+				     sectorsize))
+			btrfs_info(fs_info,
+		"incomplete page read in btrfs with offset %u and length %u",
+				   bvec->bv_offset, bvec->bv_len);
+
+		start = page_offset(page) + bvec->bv_offset;
+		end = start + bvec->bv_len - 1;
 		len = bvec->bv_len;
 
 		mirror = io_bio->mirror_num;
-- 
2.28.0

