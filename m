Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5339576B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhEaIw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:52:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:40690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhEaIw6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:52:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEomdVu04kBShrSjhMnNnBFZj1xhRDJa8qxyzsQKZdo=;
        b=mUgLHzWP+6LMrFvdMjIQUBScOTQKJLX1cpk1qhrlSrZT6JNIAt6Z/SwvhPeP54vuCKMlAO
        47hEozGrsbn5gcbpEZ3ds/T32KqfODYzYuETzx8BtsSyR4FFxOlUq+v2X8bQlxrOxJ9+YM
        5And4hu8d/pnS30i4Ueu6G8IZK2ciOE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08C00B31C
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 04/30] btrfs: only require sector size alignment for end_bio_extent_writepage()
Date:   Mon, 31 May 2021 16:50:40 +0800
Message-Id: <20210531085106.259490-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like read page, for subpage support we only require sector size
alignment.

So change the error message condition to only require sector alignment.

This should not affect existing code, as for regular sectorsize ==
PAGE_SIZE case, we are still requiring page alignment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 201e68d858ea..9ad8bc454107 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2824,25 +2824,20 @@ static void end_bio_extent_writepage(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		const u32 sectorsize = fs_info->sectorsize;
 
-		/* We always issue full-page reads, but if some block
-		 * in a page fails to read, blk_update_request() will
-		 * advance bv_offset and adjust bv_len to compensate.
-		 * Print a warning for nonzero offsets, and an error
-		 * if they don't add up to a full page.  */
-		if (bvec->bv_offset || bvec->bv_len != PAGE_SIZE) {
-			if (bvec->bv_offset + bvec->bv_len != PAGE_SIZE)
-				btrfs_err(fs_info,
-				   "partial page write in btrfs with offset %u and length %u",
-					bvec->bv_offset, bvec->bv_len);
-			else
-				btrfs_info(fs_info,
-				   "incomplete page write in btrfs with offset %u and length %u",
-					bvec->bv_offset, bvec->bv_len);
-		}
+		/* Btrfs read write should always be sector aligned. */
+		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+			btrfs_err(fs_info,
+		"partial page write in btrfs with offset %u and length %u",
+				  bvec->bv_offset, bvec->bv_len);
+		else if (!IS_ALIGNED(bvec->bv_len, sectorsize))
+			btrfs_info(fs_info,
+		"incomplete page write with offset %u and length %u",
+				   bvec->bv_offset, bvec->bv_len);
 
-		start = page_offset(page);
-		end = start + bvec->bv_offset + bvec->bv_len - 1;
+		start = page_offset(page) + bvec->bv_offset;
+		end = start + bvec->bv_len - 1;
 
 		if (first_bvec) {
 			btrfs_record_physical_zoned(inode, start, bio);
-- 
2.31.1

