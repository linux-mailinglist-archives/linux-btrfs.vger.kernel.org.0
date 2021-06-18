Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC6F3AC4EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFRH1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 03:27:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhFRH1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 03:27:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9939B21AAE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 07:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624001097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MtW7fDiqZi+Ilwd9tRJJYJnwIQ4GhCf7/s6n0wLxUY=;
        b=baVLCCzzEoPQbnaEcB1PlRlosGdxaOmwn6LMIVwRGpZyvCKiqZ8VrIhts9q/C8Mr6xKmmp
        8OpMw9AhHJYmM/u7C4/IpZN+6vzs8WcneV6ck2PSmrBHtK3eCZ7+jsY6GH28Z0RMP4pPCF
        5a0HrbfP0IuthXAwE8fW4QOWBtwQClw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 532E4A3B9E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 07:24:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 02/11] btrfs: make relocate_one_page() to handle subpage case
Date:   Fri, 18 Jun 2021 15:24:28 +0800
Message-Id: <20210618072437.207550-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618072437.207550-1-wqu@suse.com>
References: <20210618072437.207550-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, one page of data reloc inode can contain several file
extents, like this:

|<--- File extent A --->| FE B | FE C |<--- File extent D -->|
		|<--------- Page --------->|

We can no longer use PAGE_SIZE directly for various operations.

This patch will relocate_one_page() to handle subpage case by:
- Iterating through all extents of a cluster when marking pages
  When marking pages dirty and delalloc, we need to check the cluster
  extent boundary.
  Now we introduce a loop to go extent by extent of a page, until we
  either finished the last extent, or reach the page end.

  By this, regular sectorsize == PAGE_SIZE can still work as usual, since
  we will do that loop only once.

- Iteration start from max(page_start, extent_start)
  Since we can have the following case:
			| FE B | FE C |<--- File extent D -->|
		|<--------- Page --------->|
  Thus we can't always start from page_start, but do a
  max(page_start, extent_start)

- Iteration end when the cluster is exhausted
  Similar to previous case, the last file extent can end before the page
  end:
|<--- File extent A --->| FE B | FE C |
		|<--------- Page --------->|
  In this case, we need to manually exit the loop after we have finished
  the last extent of the cluster.

- Reserve metadata space for each extent range
  Since now we can hit multiple ranges in one page, we should reserve
  metadata for each range, not simply PAGE_SIZE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 108 ++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e0011155454c..af4bd2e9665f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -24,6 +24,7 @@
 #include "block-group.h"
 #include "backref.h"
 #include "misc.h"
+#include "subpage.h"
 
 /*
  * Relocation overview
@@ -2886,6 +2887,17 @@ noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
+static u64 get_cluster_boundary_end(struct file_extent_cluster *cluster,
+				    int cluster_nr)
+{
+	/* Last extent, use cluster end directly */
+	if (cluster_nr >= cluster->nr - 1)
+		return cluster->end;
+
+	/* Use next boundary start*/
+	return cluster->boundary[cluster_nr + 1] - 1;
+}
+
 static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			     struct file_extent_cluster *cluster,
 			     int *cluster_nr, unsigned long page_index)
@@ -2897,22 +2909,17 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	struct page *page;
 	u64 page_start;
 	u64 page_end;
+	u64 cur;
 	int ret;
 
 	ASSERT(page_index <= last_index);
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), PAGE_SIZE);
-	if (ret)
-		return ret;
-
 	page = find_lock_page(inode->i_mapping, page_index);
 	if (!page) {
 		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
 				page_index, last_index + 1 - page_index);
 		page = find_or_create_page(inode->i_mapping, page_index, mask);
-		if (!page) {
-			ret = -ENOMEM;
-			goto release_delalloc;
-		}
+		if (!page)
+			return -ENOMEM;
 	}
 	ret = set_page_extent_mapped(page);
 	if (ret < 0)
@@ -2934,30 +2941,76 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	page_start = page_offset(page);
 	page_end = page_start + PAGE_SIZE - 1;
 
-	lock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
-
-	if (*cluster_nr < cluster->nr &&
-	    page_start + offset == cluster->boundary[*cluster_nr]) {
-		set_extent_bits(&BTRFS_I(inode)->io_tree, page_start, page_end,
-				EXTENT_BOUNDARY);
-		(*cluster_nr)++;
-	}
+	/*
+	 * Start from the cluster, as for subpage case, the cluster can start
+	 * inside the page.
+	 */
+	cur = max(page_start, cluster->boundary[*cluster_nr] - offset);
+	while (cur <= page_end) {
+		u64 extent_start = cluster->boundary[*cluster_nr] - offset;
+		u64 extent_end = get_cluster_boundary_end(cluster,
+						*cluster_nr) - offset;
+		u64 clamped_start = max(page_start, extent_start);
+		u64 clamped_end = min(page_end, extent_end);
+		u32 clamped_len = clamped_end + 1 - clamped_start;
+
+		/* Reserve metadata for this range */
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
+						      clamped_len);
+		if (ret)
+			goto release_page;
 
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, page_end,
-					0, NULL);
-	if (ret) {
-		clear_extent_bits(&BTRFS_I(inode)->io_tree, page_start,
-				  page_end, EXTENT_LOCKED | EXTENT_BOUNDARY);
-		goto release_page;
+		/* Mark the range delalloc and dirty for later writeback */
+		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start,
+				clamped_end);
+		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
+				clamped_end, 0, NULL);
+		if (ret) {
+			clear_extent_bits(&BTRFS_I(inode)->io_tree,
+					clamped_start, clamped_end,
+					EXTENT_LOCKED | EXTENT_BOUNDARY);
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+							clamped_len, true);
+			btrfs_delalloc_release_extents(BTRFS_I(inode),
+							clamped_len);
+			goto release_page;
+		}
+		btrfs_page_set_dirty(fs_info, page, clamped_start, clamped_len);
 
+		/*
+		 * Set the boundary if it's inside the page.
+		 * Data relocation requires the destination extents have the
+		 * same size as the source.
+		 * EXTENT_BOUNDARY bit prevent current extent from being merged
+		 * with previous extent.
+		 */
+		if (in_range(cluster->boundary[*cluster_nr] - offset,
+			     page_start, PAGE_SIZE)) {
+			u64 boundary_start = cluster->boundary[*cluster_nr] -
+						offset;
+			u64 boundary_end = boundary_start +
+					   fs_info->sectorsize - 1;
+
+			set_extent_bits(&BTRFS_I(inode)->io_tree,
+					boundary_start, boundary_end,
+					EXTENT_BOUNDARY);
+		}
+		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start,
+			      clamped_end);
+		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
+		cur += clamped_len;
+
+		/* Crossed extent end, go to next extent */
+		if (cur >= extent_end) {
+			(*cluster_nr)++;
+			/* Just finished the last extent of the cluster, exit. */
+			if (*cluster_nr >= cluster->nr)
+				break;
+		}
 	}
-	set_page_dirty(page);
-
-	unlock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
 	unlock_page(page);
 	put_page(page);
 
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	balance_dirty_pages_ratelimited(inode->i_mapping);
 	btrfs_throttle(fs_info);
 	if (btrfs_should_cancel_balance(fs_info))
@@ -2967,9 +3020,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 release_page:
 	unlock_page(page);
 	put_page(page);
-release_delalloc:
-	btrfs_delalloc_release_metadata(BTRFS_I(inode), PAGE_SIZE, true);
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	return ret;
 }
 
-- 
2.32.0

