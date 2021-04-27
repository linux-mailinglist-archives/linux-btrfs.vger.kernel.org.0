Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA836CF27
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhD0XF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XF3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDn4VMTjdSk8A06e4ZuQlZmj6wRQRHg6TgqgNAVFEgU=;
        b=UkFVBfHLQAoo8QyvuJQd7kJXYTFgfdDpH1ZcpI4QeBzYYjwlPL/FJ3i9z3vVxM2FZtUfLo
        XEITBvtfuynPxGTAu/k8sc1vsXMGBNinSAGWBaGufN8/htx0MFfg2aA2gbZTwrZjo0fniL
        VVbyzPJ0JTyYQ37vfnJf7PiCVipDHgc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98021ABED
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 22/42] btrfs: introduce helpers for subpage ordered status
Date:   Wed, 28 Apr 2021 07:03:29 +0800
Message-Id: <20210427230349.369603-23-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces the following functions to handle btrfs subpage
ordered (private2) status:
- btrfs_subpage_set_ordered()
- btrfs_subpage_clear_ordered()
- btrfs_subpage_test_ordered()
  Those helpers can only be called when the range is ensured to be
  inside the page.

- btrfs_page_set_ordered()
- btrfs_page_clear_ordered()
- btrfs_page_test_ordered()
  Those helpers can handle both regular sector size and subpage without
  problem.

Those functions are here to coordinate btrfs_invalidatepage() with
btrfs_writepage_endio_finish_ordered(), to make sure only one of those
functions can finish the ordered extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 29 +++++++++++++++++++++++++++++
 fs/btrfs/subpage.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index f728e5009487..516e0b3f2ed9 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -429,6 +429,32 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->ordered_bitmap |= tmp;
+	SetPageOrdered(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->ordered_bitmap &= ~tmp;
+	if (subpage->ordered_bitmap == 0)
+		ClearPageOrdered(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -451,6 +477,7 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(ordered);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -519,3 +546,5 @@ IMPLEMENT_BTRFS_PAGE_OPS(dirty, set_page_dirty, clear_page_dirty_for_io,
 			 PageDirty);
 IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
 			 PageWriteback);
+IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
+			 PageOrdered);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 9d087ab3244e..3419b152c00f 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -34,6 +34,9 @@ struct btrfs_subpage {
 		struct {
 			atomic_t readers;
 			atomic_t writers;
+
+			/* If a sector has pending ordered extent */
+			u16 ordered_bitmap;
 		};
 	};
 };
@@ -111,6 +114,7 @@ DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(error);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
 DECLARE_BTRFS_SUBPAGE_OPS(writeback);
+DECLARE_BTRFS_SUBPAGE_OPS(ordered);
 
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len);
-- 
2.31.1

