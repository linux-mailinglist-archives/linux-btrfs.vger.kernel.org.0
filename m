Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458C5386F80
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 03:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbhERBnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 21:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346075AbhERBnQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 21:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621302118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L63Cz7IqZCjZnNOXIi6eTaWHA0BBtwuqlONiGJP2w80=;
        b=HoOXXmUgYRHt8+85WOSccHls5ejk3SY8a5ykf+xB2eHCHcwQpVh4AH7BSiTIjx1nYk1w7M
        zA2IV3bsPkMf/3KLfCz3QS5CRdrar3zEMzPYq+DdT0Y41UPhIkVI9j7sDJISw9En7ltkFz
        bknw2EX7jQ4VhsqJh0SdSqNGqbA5V5k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91D7DB125
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 01:41:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix the never finishing ordered extent when it get cleaned up
Date:   Tue, 18 May 2021 09:41:51 +0800
Message-Id: <20210518014152.77203-2-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518014152.77203-1-wqu@suse.com>
References: <20210518014152.77203-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running subpage preparation patches on x86, btrfs/125 will hang
forever with one ordered extent never finished:

[CAUSE]
The test case btrfs/125 itself will always fail as the fix is never merged.

When the test fails at balance, btrfs needs to cleanup the ordered
extent in btrfs_cleanup_ordered_extents().

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

Then the first page is cleaned up in __extent_writepage():

  __extent_writepage()
  |- If (PageError(page))
  |- end_extent_writepage()
     |- btrfs_mark_ordered_io_finished(page)
        |- if (btrfs_test_page_ordered(page))
        |-  !!! The page get skipped !!!
            The ordered extent is not decreased as the page doesn't
            have ordered bit anymore.

This leaving the ordered extent with bytes_left == sectorsize, thus never
finish.

[FIX]
The proper fix is to ensure the one cleaning up the locked page to clear
page Ordered and finish ordered io range at the same time.

This patch choose to do it in btrfs_cleanup_ordered_extents().

Also since we're here, fix a problem in
btrfs_cleanup_ordered_extents() where it always cleanup all sectors
inside the page, which is not subpage friendly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 48bcb351aad6..c974a2827da7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -144,6 +144,8 @@ void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags)
 		inode_unlock(inode);
 }
 
+static void finish_ordered_fn(struct btrfs_work *work);
+
 /*
  * Cleanup all submitted ordered extents in specified range to handle errors
  * from the btrfs_run_delalloc_range() callback.
@@ -166,10 +168,28 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 	struct page *page;
 
 	while (index <= end_index) {
+		u64 range_start;
+		u64 range_len;
+
 		page = find_get_page(inode->vfs_inode.i_mapping, index);
 		index++;
 		if (!page)
 			continue;
+
+		range_start = max_t(u64, page_offset(page), offset);
+		range_len = min(offset + bytes, page_offset(page) + PAGE_SIZE) -
+			    range_start;
+		/*
+		 * Clear page Ordered and its ordered range manually.
+		 *
+		 * We used to clear page Ordered first, but since Ordered bit
+		 * indicates whether we have ordered extent, if it get cleared
+		 * without finishing the ordered io range, the ordered extent
+		 * will hang forever, as later btrfs_mark_ordered_io_finished()
+		 * will just skip the range.
+		 */
+		btrfs_mark_ordered_io_finished(inode, page, range_start,
+				range_len, finish_ordered_fn, false);
 		ClearPageOrdered(page);
 		put_page(page);
 	}
-- 
2.31.1

