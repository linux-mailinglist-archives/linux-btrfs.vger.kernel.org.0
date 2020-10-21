Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E9294829
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440736AbgJUG03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440733AbgJUG02 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xs3+0yW28lA5Gb5G7SsbaX6OiwE0YoaOmCrHiObhQbg=;
        b=OpF+nhVMNh+ipETvQeEGHl/zWBsMLs9Mn9W4VVezWjnpuIQCqsyDyPgwd9HOaqy0f5Pj7o
        90rAprFbDOj0nIeMDt6G9MTQnY+AgUEf48tT+OsfCqQ0Z6hS+eWR+3UTMeIOS1WLayyb6D
        wqbGZ/GTDIt4ERYAWgAeFudUjROGI9Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C535AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 13/68] btrfs: extent_io: remove the extent_start/extent_len for end_bio_extent_readpage()
Date:   Wed, 21 Oct 2020 14:24:59 +0800
Message-Id: <20201021062554.68132-14-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_bio_extent_readpage() we had a strange dance around
extent_start/extent_len.

The truth is, no matter what we're doing using those two variable, the
end result is just the same, clear the EXTENT_LOCKED bit and if needed
set the EXTENT_UPTODATE bit for the io_tree.

This doesn't need the complex dance, we can do it pretty easily by just
calling endio_readpage_release_extent() for each bvec.

This greatly streamlines the code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ce5b23169e47..3819bf7505e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2791,11 +2791,10 @@ static void end_bio_extent_writepage(struct bio *bio)
 }
 
 static void
-endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 len,
+endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 end,
 			      int uptodate)
 {
 	struct extent_state *cached = NULL;
-	u64 end = start + len - 1;
 
 	if (uptodate && tree->track_uptodate)
 		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
@@ -2823,8 +2822,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	u64 start;
 	u64 end;
 	u64 len;
-	u64 extent_start = 0;
-	u64 extent_len = 0;
 	int mirror;
 	int ret;
 	struct bvec_iter_all iter_all;
@@ -2932,32 +2929,9 @@ static void end_bio_extent_readpage(struct bio *bio)
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
2.28.0

