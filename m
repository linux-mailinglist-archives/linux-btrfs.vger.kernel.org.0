Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F502DCBCE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgLQE6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 23:58:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgLQE6n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 23:58:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608181077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bg7/go/jMGzZ5wJabTn1S8oc65Tfq3OwjltPc9Aaft0=;
        b=K1uB0QcKru0FYVEzrRPnYW+sUctWQ/GVaCqV08Z1I6LTm6YfNFbpKM4J8KeAw2QTQJvnrc
        1xoXFJFVWDaRtYFQ378lLyGnZTS1PrUc/ZDb0VhhBEqpBdiXQC36oAUj5P1LOl62toyvw6
        la/FAfg7CAF2vhvTQcX2TnV+CR1YATE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D91CAD07
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 04:57:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/4] btrfs: inode: make btrfs_invalidatepage() to be subpage compatible
Date:   Thu, 17 Dec 2020 12:57:37 +0800
Message-Id: <20201217045737.48100-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217045737.48100-1-wqu@suse.com>
References: <20201217045737.48100-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With current subpage RW patchset, the following script can lead to
filesystem hang:
  # mkfs.btrfs -f -s 4k $dev
  # mount $dev -o nospace_cache $mnt
  # fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt

The file system will hang at wait_event() of
btrfs_start_ordered_extent().

[CAUSE]
The root cause is, btrfs_invalidatepage() is freeing page::private which
still has subpage dirty bit set.

The offending situation happens like this:
btrfs_fllocate()
|- btrfs_zero_range()
   |- btrfs_punch_hole_lock_range()
      |- truncate_pagecache_range()
         |- btrfs_invalidatepage()

The involved range looks like:

0	32K	64K	96K	128K
	|///////||//////|
	| Range to drop |

For the [32K, 64K) range, since the offset is 32K, the page won't be
invalidated.

But for the [64K, 96K) range, the offset is 0, current
btrfs_invalidatepage() will call clear_page_extent_mapped() which will
detach page::private, making the subpage dirty bitmap being cleared.

This prevents later __extent_writepage_io() to locate any range to
write, thus no way to wake up the ordered extents.

[FIX]
To fix the problem this patch will:
- Only clear page status and detach page private when the full page
  is invalidated

- Change how we handle unfinished ordered extent
  If there is any ordered extent unfinished in the page range, we can't
  call clear_extent_bit() with delete == true.

[REASON FOR RFC]
There is still uncertainty around the btrfs_releasepage() call.

1. Why we need btrfs_releasepage() call for non-full-page condition?
   Other fs (aka. xfs) just exit without doing special handling if
   invalidatepage() is called with part of the page.

   Thus I didn't completely understand why btrfs_releasepage() here is
   needed for non-full page call.

2. Why "if (offset)" is not causing problem for current code?
   This existing if (offset) call can be skipped for cases like
   offset == 0 length == 2K.
   As MM layer can call invalidatepage() with unaligned offset/length,
   for cases like truncate_inode_pages_range().
   This will make btrfs_invalidatepage() to truncate the whole page when
   we only need to zero part of the page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb493fbb65f9..872c5309b4ca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8180,7 +8180,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
 	bool cleared_private2;
 	bool found_ordered = false;
-	bool completed_ordered = false;
+	bool incompleted_ordered = false;
 
 	/*
 	 * we have the page locked, so new writeback can't start,
@@ -8191,7 +8191,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 */
 	wait_on_page_writeback(page);
 
-	if (offset) {
+	/*
+	 * The range doesn't cover the full page, just let btrfs_releasepage() to
+	 * check if we can release the extent mapping.
+	 * Any locked/pinned/logged extent map would prevent us freeing the
+	 * extent mapping.
+	 */
+	if (!(offset == 0 && length == PAGE_SIZE)) {
 		btrfs_releasepage(page, GFP_NOFS);
 		return;
 	}
@@ -8208,9 +8214,10 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		end = min(page_end,
 			  ordered->file_offset + ordered->num_bytes - 1);
 		/*
-		 * IO on this page will never be started, so we need to account
-		 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
-		 * here, must leave that up for the ordered extent completion.
+		 * IO on this ordered extent will never be started, so we need
+		 * to account for any ordered extents now. Don't clear
+		 * EXTENT_DELALLOC_NEW here, must leave that up for the
+		 * ordered extent completion.
 		 */
 		if (!inode_evicting)
 			clear_extent_bit(tree, start, end,
@@ -8234,7 +8241,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 							   start,
 							   end - start + 1, 1)) {
 				btrfs_finish_ordered_io(ordered);
-				completed_ordered = true;
+			} else {
+				incompleted_ordered = true;
 			}
 		}
 
@@ -8276,7 +8284,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		 * is cleared if we don't delete, otherwise it can lead to
 		 * corruptions if the i_size is extented later.
 		 */
-		if (found_ordered && !completed_ordered)
+		if (found_ordered && incompleted_ordered)
 			delete = false;
 		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
@@ -8286,6 +8294,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		__btrfs_releasepage(page, GFP_NOFS);
 	}
 
+	ClearPagePrivate2(page);
 	ClearPageChecked(page);
 	clear_page_extent_mapped(page);
 }
-- 
2.29.2

