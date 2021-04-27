Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166AB36CF22
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbhD0XFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239185AbhD0XFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYFhnmKqCb2iWU6QJhdS+JZXcv2hCGlkFMbYKLs0nig=;
        b=LZFF7wVIrz0AvFidtMmh+29iHj7i3GzS2rhZ0/YSMe5vn5f/YQfvQ1cf+4AM9Id7kz9lJ0
        0FTnmUPXI57W9tuSCr4Uuqz/QVv868QvXvWhE9Sk50aRbff92w0wRuNl7imyrppIs2Hcdz
        u7FgwP3aFjR5WS8tUVZycY808yMum84=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07E61ABED
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 17/42] btrfs: only require sector size alignment for end_bio_extent_writepage()
Date:   Wed, 28 Apr 2021 07:03:24 +0800
Message-Id: <20210427230349.369603-18-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index e0cef1b1546c..a99b59504e72 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2782,25 +2782,20 @@ static void end_bio_extent_writepage(struct bio *bio)
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

