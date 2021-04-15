Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2B360159
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDOFFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhDOFFe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uDwLgmNiiBgHlwac4KTMfGpcZ/pprxhCsznxewl6Po=;
        b=Za90kkg9qh6bytZilZICE6uL1uaxKYqbUY0nofaL8LPGiTc5k5/YzWF4Eeyg3BYccE5DSO
        yaLSQXC0OHH58ZbN3bkcfQKYqoPz3cuEYdFPvhHm125r2Wdfy9ZhcIhjvDjbjMhQEDxJbN
        9AH0hcHG2RDm8TakU89xhs1VauNBG0M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77546AFC9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/42] btrfs: update the comments in btrfs_invalidatepage()
Date:   Thu, 15 Apr 2021 13:04:16 +0800
Message-Id: <20210415050448.267306-11-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The existing comments in btrfs_invalidatepage() don't really get to the
point, especially for what Private2 is really representing and how the
race avoidance is done.

The truth is, there are only three entrances to do ordered extent
accounting:
- btrfs_writepage_endio_finish_ordered()
- __endio_write_update_ordered()
  Those two entrance are just endio functions for dio and buffered
  write.

- btrfs_invalidatepage()

But there is a pitfall, in endio functions there is no check on whether
the ordered extent is already accounted.
They just blindly clear the Private2 bit and do the accounting.

So it's all btrfs_invalidatepage()'s responsibility to make sure we
won't do double account on the same sector.

That's why in btrfs_invalidatepage() we have to wait page writeback,
this will ensure all submitted bios has finished, thus their endio
functions have finished the accounting on the ordered extent.

Then we also check page Private2 to ensure that, we only run ordered
extent accounting on pages who has no bio submitted.

This patch will rework related comments to make it more clear on the
race and how we use wait_on_page_writeback() and Private2 to prevent
double accounting on ordered extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 645097bff5a0..4c894de2e813 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8331,11 +8331,16 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	bool completed_ordered = false;
 
 	/*
-	 * we have the page locked, so new writeback can't start,
-	 * and the dirty bit won't be cleared while we are here.
+	 * We have page locked so no new ordered extent can be created on
+	 * this page, nor bio can be submitted for this page.
 	 *
-	 * Wait for IO on this page so that we can safely clear
-	 * the PagePrivate2 bit and do ordered accounting
+	 * But already submitted bio can still be finished on this page.
+	 * Furthermore, endio function won't skip page which has Private2
+	 * already cleared, so it's possible for endio and invalidatepage
+	 * to do the same ordered extent accounting twice on one page.
+	 *
+	 * So here we wait any submitted bios to finish, so that we won't
+	 * do double ordered extent accounting on the same page.
 	 */
 	wait_on_page_writeback(page);
 
@@ -8365,8 +8370,12 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, 1, 0, &cached_state);
 		/*
-		 * whoever cleared the private bit is responsible
-		 * for the finish_ordered_io
+		 * A page with Private2 bit means no bio has submitted covering
+		 * the page, thus we have to manually do the ordered extent
+		 * accounting.
+		 *
+		 * For page without Private2, the ordered extent accounting is
+		 * done in its endio function of the submitted bio.
 		 */
 		if (TestClearPagePrivate2(page)) {
 			spin_lock_irq(&inode->ordered_tree.lock);
-- 
2.31.1

