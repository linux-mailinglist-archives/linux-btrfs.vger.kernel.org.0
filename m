Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2728829482A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440739AbgJUG0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440738AbgJUG0a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8J86bq7GsmfMIy3AGHqzxW7QwXQBwnFu65/lrhid9w=;
        b=lHxhjbFDYzvRLJWwuMoKrOchkyw6hoNN89MDSHU6qr2yX1j7oOEIWUeHhXZsxyXd2PZ1Sq
        WyZwooTAsTySdzZDho5jsD/Aw9rWvxcM8aCkWwwEh5IF2cYn8/DuBjZ+5vfAfBzZOEVDNb
        UtjRLXgnf3Q5lubC1/Txs9V/HjuYF1Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7147AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 14/68] btrfs: extent_io: integrate page status update into endio_readpage_release_extent()
Date:   Wed, 21 Oct 2020 14:25:00 +0800
Message-Id: <20201021062554.68132-15-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage(), we set page uptodate or error according to
the bio status.
However that assumes all submitted read are in page size.

To support case like subpage read, we should only set the whole page
uptodate if all data in the page has been read from disk.

This patch will integrate the page status update into
endio_readpage_release_extent() for end_bio_extent_readpage().

Now in endio_readpage_release_extent() we will set the page uptodate if
either:
- start/end covers the full page
  This is the existing behavior already.

- all the page range is already uptodate
  This adds the support for subpage read.

And for the error path, we always clear the page uptodate and set the
page error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3819bf7505e3..ec0f1fb01a0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2791,13 +2791,36 @@ static void end_bio_extent_writepage(struct bio *bio)
 }
 
 static void
-endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 end,
-			      int uptodate)
+endio_readpage_release_extent(struct extent_io_tree *tree, struct page *page,
+			      u64 start, u64 end, int uptodate)
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
+			set_extent_uptodate(tree, start, end, &cached,
+					    GFP_NOFS);
+			check_page_uptodate(tree, page);
+		} else if ((start <= page_start && end >= page_end)) {
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
 
@@ -2921,15 +2944,11 @@ static void end_bio_extent_readpage(struct bio *bio)
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
2.28.0

