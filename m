Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51EA2A4677
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgKCNbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgKCNbU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52PEVHe5NA9nd1O3WTbEpQ+2Nwobq4iBy49nMvJqtCs=;
        b=ZUcvzcRe5YLv4/qoQ8kK8BawGcoKqVw9QxQXL+XpDwoJwEYnfCNSSXuIfjcFUaAacFfTen
        poqpxwlWxweDqeKW7Y7D3u6Stam9sai/WVaQf/zuCX8jBQMmR5+oDIFsoFK9EUqWkyI3ix
        e+aTJ6Q55oDpOqDx8i3zWwGohOpXYdU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 743C4ACC0;
        Tue,  3 Nov 2020 13:31:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/32] btrfs: extent_io: remove the extent_start/extent_len for end_bio_extent_readpage()
Date:   Tue,  3 Nov 2020 21:30:37 +0800
Message-Id: <20201103133108.148112-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage() we had a strange dance around
extent_start/extent_len.

Hides behind the strange dance is, it's just calling
endio_readpage_release_extent() on each bvec range.

Here is an example to explain the original work flow:
  Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)

  end_bio_extent_extent_readpage() entered
  |- extent_start = 0;
  |- extent_end = 0;
  |- bio_for_each_segment_all() {
  |  |- /* Got the 1st bvec */
  |  |- start = SZ_1M;
  |  |- end = SZ_1M + SZ_4K - 1;
  |  |- update = 1;
  |  |- if (extent_len == 0) {
  |  |  |- extent_start = start; /* SZ_1M */
  |  |  |- extent_len = end + 1 - start; /* SZ_1M */
  |  |  }
  |  |
  |  |- /* Got the 2nd bvec */
  |  |- start = SZ_1M + 4K;
  |  |- end = SZ_1M + 4K - 1;
  |  |- update = 1;
  |  |- if (extent_start + extent_len == start) {
  |  |  |- extent_len += end + 1 - start; /* SZ_8K */
  |  |  }
  |  } /* All bio vec iterated */
  |
  |- if (extent_len) {
     |- endio_readpage_release_extent(tree, extent_start, extent_len,
				      update);
	/* extent_start == SZ_1M, extent_len == SZ_8K, uptodate = 1 */

As the above flow shows, the existing code in end_bio_extent_readpage()
is just accumulate extent_start/extent_len, and when the contiguous range
breaks, call endio_readpage_release_extent() for the range.

The contiguous range breaks at two locations:
- The total else {} branch
  This means we had a page in a bio where it's not contiguous.
  Currently this branch will never be triggered. As all our bio is
  submitted as contiguous pages.

- After the bio_for_each_segment_all() loop ends
  This is the normal call sites where we iterated all bvecs of a bio,
  and all pages should be contiguous, thus we can call
  endio_readpage_release_extent() on the full range.

The original code has also considered cases like (!uptodate), so it will
mark the uptodate range with EXTENT_UPTODATE.

So this patch will remove the extent_start/extent_len dancing, replace
it with regular endio_readpage_release_extent() call on each bvec.

This brings one behavior change:
- Temporary memory usage increase
  Unlike the old call which only modify the extent tree once, now we
  update the extent tree for each bvec.

  Although the end result is the same, since we may need more extent
  state split/allocation, we need more temporary memory during that
  bvec iteration.

But considering how streamline the new code is, the temporary memory
usage increase should be acceptable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f3515d3c1321..58dc55e1429d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2779,12 +2779,10 @@ static void end_bio_extent_writepage(struct bio *bio)
 	bio_put(bio);
 }
 
-static void
-endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 len,
-			      int uptodate)
+static void endio_readpage_release_extent(struct extent_io_tree *tree, u64 start,
+					  u64 end, int uptodate)
 {
 	struct extent_state *cached = NULL;
-	u64 end = start + len - 1;
 
 	if (uptodate && tree->track_uptodate)
 		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
@@ -2812,8 +2810,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	u64 start;
 	u64 end;
 	u64 len;
-	u64 extent_start = 0;
-	u64 extent_len = 0;
 	int mirror;
 	int ret;
 	struct bvec_iter_all iter_all;
@@ -2922,32 +2918,9 @@ static void end_bio_extent_readpage(struct bio *bio)
 		unlock_page(page);
 		offset += len;
 
-		if (unlikely(!uptodate)) {
-			if (extent_len) {
-				endio_readpage_release_extent(tree,
-							      extent_start,
-							      extent_len, 1);
-				extent_start = 0;
-				extent_len = 0;
-			}
-			endio_readpage_release_extent(tree, start,
-						      end - start + 1, 0);
-		} else if (!extent_len) {
-			extent_start = start;
-			extent_len = end + 1 - start;
-		} else if (extent_start + extent_len == start) {
-			extent_len += end + 1 - start;
-		} else {
-			endio_readpage_release_extent(tree, extent_start,
-						      extent_len, uptodate);
-			extent_start = start;
-			extent_len = end + 1 - start;
-		}
+		endio_readpage_release_extent(tree, start, end, uptodate);
 	}
 
-	if (extent_len)
-		endio_readpage_release_extent(tree, extent_start, extent_len,
-					      uptodate);
 	btrfs_io_bio_free_csum(io_bio);
 	bio_put(bio);
 }
-- 
2.29.2

