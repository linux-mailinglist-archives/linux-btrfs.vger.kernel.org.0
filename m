Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023BD395782
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEaIxt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhEaIxj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeiAvREcQeDs6BK4tWGZo5cC3c31w9Ba/tkTpG8NtP0=;
        b=r5ukLMyShJ2tPQd9IC7KVTIGxjQoMd6vHbw6IOyMwUJ3/umYftt3bsyXm+gm/H4ohBLPqN
        cNC1wGF6CW9CQwgi1BiIceoatpAhhbWWVIIbwi3ulZe0T9OQfxTMCjcmuAhzStTWJrdLmk
        EIYPe6rY3E4RqOfaWcCROYlngAOZMwM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E990B3E8;
        Mon, 31 May 2021 08:51:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v4 27/30] btrfs: fix a use-after-free bug in writeback subpage helper
Date:   Mon, 31 May 2021 16:51:03 +0800
Message-Id: <20210531085106.259490-28-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a possible use-after-free bug when running generic/095.

 BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
 Faulting instruction address: 0xc000000000283654
 c000000000283078 do_raw_spin_unlock+0x88/0x230
 c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
 c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
 c0000000009e0458 end_bio_extent_writepage+0x158/0x270
 c000000000b6fd14 bio_endio+0x254/0x270
 c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
 c000000000b6fd14 bio_endio+0x254/0x270
 c000000000b781fc blk_update_request+0x46c/0x670
 c000000000b8b394 blk_mq_end_request+0x34/0x1d0
 c000000000d82d1c lo_complete_rq+0x11c/0x140
 c000000000b880a4 blk_complete_reqs+0x84/0xb0
 c0000000012b2ca4 __do_softirq+0x334/0x680
 c0000000001dd878 irq_exit+0x148/0x1d0
 c000000000016f4c do_IRQ+0x20c/0x240
 c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0

[CAUSE]
There is very small race window like the following in generic/095.

	Thread 1		|		Thread 2
--------------------------------+------------------------------------
  end_bio_extent_writepage()	| btrfs_releasepage()
  |- spin_lock_irqsave()	| |
  |- end_page_writeback()	| |
  |				| |- if (PageWriteback() ||...)
  |				| |- clear_page_extent_mapped()
  |				|    |- kfree(subpage);
  |- spin_unlock_irqrestore().

The race can also happen between writeback and btrfs_invalidatepage(),
although that would be much harder as btrfs_invalidatepage() has much
more work to do before the clear_page_extent_mapped() call.

[FIX]
Here we "wait" for the subapge spinlock to be released before we detach
subpage structure.
So this patch will introduce a new function, wait_subpage_spinlock(), to
do the "wait" by acquiring the spinlock and release it.

Since the caller has ensured the page is not dirty nor writeback, and
page is already locked, the only way to hold the subpage spinlock is
from endio function.
Thus we only need to acquire the spinlock to wait for any existing
holder.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c   | 40 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/subpage.c |  4 +++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4918a7ef273b..d3c67411f683 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8308,11 +8308,48 @@ static void btrfs_readahead(struct readahead_control *rac)
 	extent_readahead(rac);
 }
 
+/*
+ * For releasepage() and invalidatepage() we have a race window where
+ * end_page_writeback() is called but the subpage spinlock is not yet
+ * released.
+ * If we continue to release/invalidate the page, we could cause
+ * use-after-free for subpage spinlock.
+ * So this function is to spin wait for subpage spinlock.
+ */
+static void wait_subpage_spinlock(struct page *page)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_subpage *subpage;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->private);
+	subpage = (struct btrfs_subpage *)page->private;
+
+	/*
+	 * This may look insane as we just acquire the spinlock and release it,
+	 * without doing anything.
+	 * But we just want to make sure no one is still holding the subpage
+	 * spinlock.
+	 * And since the page is not dirty nor writeback, and we have page
+	 * locked, the only possible way to hold a spinlock is from the endio
+	 * function to clear page writeback.
+	 *
+	 * Here we just acquire the spinlock so that all existing callers
+	 * should exit and we're safe to release/invalidate the page.
+	 */
+	spin_lock_irq(&subpage->lock);
+	spin_unlock_irq(&subpage->lock);
+}
+
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1)
+	if (ret == 1) {
+		wait_subpage_spinlock(page);
 		clear_page_extent_mapped(page);
+	}
 	return ret;
 }
 
@@ -8376,6 +8413,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 * do double ordered extent accounting on the same page.
 	 */
 	wait_on_page_writeback(page);
+	wait_subpage_spinlock(page);
 
 	/*
 	 * For subpage case, we have call sites like
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 696485ab68a2..552410fba0bd 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -424,8 +424,10 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	subpage->writeback_bitmap &= ~tmp;
-	if (subpage->writeback_bitmap == 0)
+	if (subpage->writeback_bitmap == 0) {
+		ASSERT(PageWriteback(page));
 		end_page_writeback(page);
+	}
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-- 
2.31.1

