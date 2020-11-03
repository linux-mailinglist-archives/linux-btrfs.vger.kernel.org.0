Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE02A4678
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKCNbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgKCNbX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWq7WaOSbqQfefQsr88YRjfzAKnV2r3c7D1xyOuCAGY=;
        b=pDIeWgzkCZzHN9SPvrf5qAPCsHzilIOY2vhw4aoXKTStgE7BUWMGJeONy1pnEmoKnSI6Ab
        hA9LfmDcuJRnqQ/WqpC6M8B/PhmhgN/qYASvImSeKUmYLKMlykB6MfGy/jJ7QW+MRcf+1T
        5I8ISHrvyzLVZSGCQXXicYEYs0gZUiU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18790ABF4;
        Tue,  3 Nov 2020 13:31:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/32] btrfs: extent_io: integrate page status update into endio_readpage_release_extent()
Date:   Tue,  3 Nov 2020 21:30:38 +0800
Message-Id: <20201103133108.148112-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage(), we set page uptodate or error according to
the bio status.  However that assumes all submitted reads are in page
size.

To support case like subpage read, we should only set the whole page
uptodate if all data in the page have been read from disk.

This patch will integrate the page status update into
endio_readpage_release_extent() for end_bio_extent_readpage().

Now in endio_readpage_release_extent() we will set the page uptodate if:

- start/end range covers the full page
  This is the existing behavior already.

- the whole page range is already uptodate
  This adds the support for subpage read.

And for the error path, we always clear the page uptodate and set the
page error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 58dc55e1429d..228bf0c5f7a0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2779,13 +2779,35 @@ static void end_bio_extent_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
-static void endio_readpage_release_extent(struct extent_io_tree *tree, u64 start,
-					  u64 end, int uptodate)
+static void endio_readpage_release_extent(struct extent_io_tree *tree,
+		struct page *page, u64 start, u64 end, int uptodate)
 {
 	struct extent_state *cached = NULL;
 
-	if (uptodate && tree->track_uptodate)
-		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
+	if (uptodate) {
+		u64 page_start = page_offset(page);
+		u64 page_end = page_offset(page) + PAGE_SIZE - 1;
+
+		if (tree->track_uptodate) {
+			/*
+			 * The tree has EXTENT_UPTODATE bit tracking, update
+			 * extent io tree, and use it to update the page if
+			 * needed.
+			 */
+			set_extent_uptodate(tree, start, end, &cached, GFP_NOFS);
+			check_page_uptodate(tree, page);
+		} else if (start <= page_start && end >= page_end) {
+			/* We have covered the full page, set it uptodate */
+			SetPageUptodate(page);
+		}
+	} else if (!uptodate){
+		if (tree->track_uptodate)
+			clear_extent_uptodate(tree, start, end, &cached);
+
+		/* Any error in the page range would invalid the uptodate bit */
+		ClearPageUptodate(page);
+		SetPageError(page);
+	}
 	unlock_extent_cached_atomic(tree, start, end, &cached);
 }
 
@@ -2910,15 +2932,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 			off = offset_in_page(i_size);
 			if (page->index == end_index && off)
 				zero_user_segment(page, off, PAGE_SIZE);
-			SetPageUptodate(page);
-		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
 		}
-		unlock_page(page);
 		offset += len;
 
-		endio_readpage_release_extent(tree, start, end, uptodate);
+		endio_readpage_release_extent(tree, page, start, end, uptodate);
+		unlock_page(page);
 	}
 
 	btrfs_io_bio_free_csum(io_bio);
-- 
2.29.2

