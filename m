Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E016539C437
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFEAQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 20:16:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEAQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 20:16:20 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 78D4A1FD30
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Jun 2021 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622852072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N4cJGmHIS8uCYZXgN4s7tkMgTNzWsFgg4vZ52V7cpDs=;
        b=ny0vJVtXRhaBSPv8U6oCwp5LPHzC0eCaohQV9Wko+n0toxCyR8cBU2Gs5EKF/5r/63fpEp
        46XGU4PC21qAjrhU+Um0yz6ReEyWXjtYEQoadcdXvYvzDEd6zBg1q+7/CcBN6wmr4ml5nS
        hSVrv6acOr9//Y/t3MdMOiSvxq3VzFE=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 315AFA3B8C;
        Sat,  5 Jun 2021 00:14:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH] btrfs: fix embarrassing bugs in find_next_dirty_byte()
Date:   Sat,  5 Jun 2021 08:14:28 +0800
Message-Id: <20210605001428.26072-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several bugs in find_next_dirty_byte():

- Wrong right shift
  int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize;

  This makes nbits to be always 0, thus find_next_dirty_byte() doesn't
  really check any range, but bit by bit check.

  This mask all other bugs in the same function.

- Wrong @first_bit_zero calculation
  The real @first_bit_zero we want should be after @first_bit_set.

All these bit dancing with tons of ASSERT() is really a waste of time.
The only reason I didn't go bitmap operations is they require unsigned
long.

But considering how many bugs there are just in this small function,
bitmap_next_set_region() should be the correct way to go.

Fix all these mess by using unsigned long for the local bitmap, and call
bitmap_next_set_region() to end all these stupid bugs.

Thankfully, this bug can be easily verify by any short fsstress/fsx run.

Please fold this fix into "btrfs: make __extent_writepage_io() only submit dirty range for subpage".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d6a12f7e36d9..77b59ca93419 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3877,11 +3877,12 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	u64 orig_start = *start;
-	u16 dirty_bitmap;
+	/* Declare as unsigned long so we can use bitmap ops */
+	unsigned long dirty_bitmap;
 	unsigned long flags;
-	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize;
-	int first_bit_set;
-	int first_bit_zero;
+	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize_bits;
+	int range_start_bit = nbits;
+	int range_end_bit;
 
 	/*
 	 * For regular sector size == page size case, since one page only
@@ -3898,31 +3899,10 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 	dirty_bitmap = subpage->dirty_bitmap;
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
-	/* Set bits lower than @nbits with 0 */
-	dirty_bitmap &= ~((1 << nbits) - 1);
-
-	first_bit_set = ffs(dirty_bitmap);
-	/* No dirty range found */
-	if (first_bit_set == 0) {
-		*start = page_offset(page) + PAGE_SIZE;
-		return;
-	}
-
-	ASSERT(first_bit_set > 0 && first_bit_set <= BTRFS_SUBPAGE_BITMAP_SIZE);
-	*start = page_offset(page) + (first_bit_set - 1) * fs_info->sectorsize;
-
-	/* Set all bits lower than @nbits to 1 for ffz() */
-	dirty_bitmap |= ((1 << nbits) - 1);
-
-	first_bit_zero = ffz(dirty_bitmap);
-	if (first_bit_zero == 0 || first_bit_zero > BTRFS_SUBPAGE_BITMAP_SIZE) {
-		*end = page_offset(page) + PAGE_SIZE;
-		return;
-	}
-	ASSERT(first_bit_zero > 0 &&
-	       first_bit_zero <= BTRFS_SUBPAGE_BITMAP_SIZE);
-	*end = page_offset(page) + first_bit_zero * fs_info->sectorsize;
-	ASSERT(*end > *start);
+	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bit,
+			       BTRFS_SUBPAGE_BITMAP_SIZE);
+	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
+	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;
 }
 
 /*
-- 
2.31.1

