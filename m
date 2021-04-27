Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD436CF3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhD0XGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:06:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239299AbhD0XGK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:06:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2xKcre2OQdmeRynSIoHWSyGNN3f1sqL40jk/gDyUeA=;
        b=EdLfVxuqFTOFCaxLTgsAtL+PvNy5Um3lG50R2/UIoAls0xrdGQXWfbGHAiWo3KMhy3WWrV
        JkT8LIL0gIvBQKl0nC64CQ1G1O9lkjekVAf+vd4FE0n/qvYl/q3QXTMqOulQaoTE80L8UQ
        27JPNEE4xbcOmLtLB6GEIKBAuNyC6Yo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70993B168;
        Tue, 27 Apr 2021 23:05:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback subpage helper
Date:   Wed, 28 Apr 2021 07:03:48 +0800
Message-Id: <20210427230349.369603-42-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
For btrfs_subpage_clear_writeback(), we don't really need to put
end_page_writepage() call into the spinlock critical section.

By just checking the bitmap in the critical section and call
end_page_writeback() outside of the critical section, we can avoid such
use-after-free bug.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 696485ab68a2..c5abf9745c10 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	bool finished = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	subpage->writeback_bitmap &= ~tmp;
 	if (subpage->writeback_bitmap == 0)
-		end_page_writeback(page);
+		finished = true;
 	spin_unlock_irqrestore(&subpage->lock, flags);
+	if (finished)
+		end_page_writeback(page);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
-- 
2.31.1

