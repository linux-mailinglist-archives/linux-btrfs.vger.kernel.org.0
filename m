Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF33872DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346956AbhERHLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 03:11:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:32870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237714AbhERHLH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 03:11:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621321788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtkltulNSSPGu70dqFccTkzG++nB1ZlnDEtJmm9/X7w=;
        b=acQ38PO4AF1yIKYtOOIrT3FGvKO9yVyCyEqGGiUyfyeEspA4P3myI5LdCtre4LL2XbqX+w
        HSovYuOwL/51hH13Oq9xvarE8groYUfrV+bY3mm185TmS8PXwmqFsXbECGenIoeddvjeot
        aWKetaoYZ8vxiLVAuaTYfqXnzvtODhw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92AF9B10B
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 07:09:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: fix the fs hang when run_delalloc_range() failed
Date:   Tue, 18 May 2021 15:09:41 +0800
Message-Id: <20210518070942.206846-2-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518070942.206846-1-wqu@suse.com>
References: <20210518070942.206846-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running subpage preparation patches on x86, btrfs/125 will hang
forever with one ordered extent never finished.

[CAUSE]
The test case btrfs/125 itself will always fail as the fix is never merged.

When the test fails at balance, btrfs needs to cleanup the ordered
extent in btrfs_cleanup_ordered_extents() for data reloc inode.

The problem is in the sequence how we cleanup the page Order bit.

Currently it works like:

  btrfs_cleanup_ordered_extents()
  |- find_get_page();
  |- btrfs_page_clear_ordered(page);
  |  Now the page doesn't have Ordered bit anymore.
  |  !!! This also includes the first (locked) page !!!
  |
  |- offset += PAGE_SIZE
  |  This is to skip the first page
  |- __endio_write_update_ordered()
     |- btrfs_mark_ordered_io_finished(NULL)
        Except the first page, all ordered extent is finished.

Then the locked page is cleaned up in __extent_writepage():

  __extent_writepage()
  |- If (PageError(page))
  |- end_extent_writepage()
     |- btrfs_mark_ordered_io_finished(page)
        |- if (btrfs_test_page_ordered(page))
        |-  !!! The page get skipped !!!
            The ordered extent is not decreased as the page doesn't
            have ordered bit anymore.

This leaves the ordered extent with bytes_left == sectorsize, thus never
finish.

[FIX]
The fix is to ensure we never clear page Ordered bit without running the
ordered extent accounting.

Here we choose to skip the locked page in
btrfs_cleanup_ordered_extents() so that later end_extent_writepage() can
properly finish the ordered extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 48bcb351aad6..83b014c40d42 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -166,10 +166,31 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 	struct page *page;
 
 	while (index <= end_index) {
+		/*
+		 * For locked page, we will call end_extent_writepage() on it
+		 * in run_delalloc_range() for the error handling.
+		 * That end_extent_writepage() function will call
+		 * btrfs_mark_ordered_io_finished() to clear page Ordered and
+		 * run the ordered extent accounting.
+		 *
+		 * Here we can't just clear the Ordered bit, or
+		 * btrfs_mark_ordered_io_finished() will skip the accounting
+		 * for the page range, and the ordered extent will never finish.
+		 */
+		if (index == (page_offset(locked_page) >> PAGE_SHIFT)) {
+			index++;
+			continue;
+		}
 		page = find_get_page(inode->vfs_inode.i_mapping, index);
 		index++;
 		if (!page)
 			continue;
+
+		/*
+		 * Here we just clear all Ordered bit for every page in the
+		 * range, then __endio_write_update_ordered() will handle
+		 * the ordered extent accounting for the range.
+		 */
 		ClearPageOrdered(page);
 		put_page(page);
 	}
-- 
2.31.1

