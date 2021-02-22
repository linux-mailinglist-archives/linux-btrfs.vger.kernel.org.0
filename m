Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E23210DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhBVGe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:34:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVGe6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:34:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey9yUxBVthR1KRIXXv4cpz056bkrd8cNuTD0/sJQ98M=;
        b=hcWWR6+btpFRc2UIMQKCqNW+CGSC0dND+TYPZUFm09ejvDVf3YFEzwXNTjvUg/f1Clf1cN
        vmEc2BEWYHSWmChuD0G6e+L++XE+PrkvVfDu+tl915EYWi148FBVV3IwqQF6v2Ux1Z5hw6
        umBdWtLUu6ZS1YLc6tr8xAFQh2AgcBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51405B11B
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: subpage: introduce helper for subpage dirty status
Date:   Mon, 22 Feb 2021 14:33:46 +0800
Message-Id: <20210222063357.92930-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduce the following functions to handle btrfs subpage
dirty status:
- btrfs_subpage_set_dirty()
- btrfs_subpage_clear_dirty()
- btrfs_subpage_test_dirty()
  Those helpers can only be called when the range is ensured to be
  inside the page.

- btrfs_page_set_dirty()
- btrfs_page_clear_dirty()
- btrfs_page_test_dirty()
  Those helpers can handle both regular sector size and subpage without
  problem.
  Thus those would be used to replace PageDirty() related calls in
  later commits.

There is one special point to note here, just like set_page_dirty() and
clear_page_dirty_for_io(), btrfs_*page_set_dirty() and
btrfs_*page_clear_dirty() must be called with page locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h | 15 +++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index c69049e7daa9..16dd6fcd258d 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -220,6 +220,45 @@ void btrfs_subpage_clear_error(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->dirty_bitmap |= tmp;
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	set_page_dirty(page);
+}
+
+bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+	bool last = false;
+
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->dirty_bitmap &= ~tmp;
+	if (subpage->dirty_bitmap == 0)
+		last = true;
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return last;
+}
+
+void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	bool last;
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, start, len);
+	if (last)
+		clear_page_dirty_for_io(page);
+}
+
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -240,6 +279,7 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 }
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -276,3 +316,5 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			 PageUptodate);
 IMPLEMENT_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
+IMPLEMENT_BTRFS_PAGE_OPS(dirty, set_page_dirty, clear_page_dirty_for_io,
+			 PageDirty);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index b86a4881475d..adaece5ce294 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -20,6 +20,7 @@ struct btrfs_subpage {
 	spinlock_t lock;
 	u16 uptodate_bitmap;
 	u16 error_bitmap;
+	u16 dirty_bitmap;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -87,5 +88,19 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(error);
+DECLARE_BTRFS_SUBPAGE_OPS(dirty);
+
+/*
+ * Extra clear_and_test function for subpage dirty bitmap.
+ *
+ * Return true if we're the last bits in the dirty_bitmap and clear the
+ * dirty_bitmap.
+ * Return false otherwise.
+ *
+ * NOTE: Callers should manually clear page dirty for true case, as we have
+ * extra handling for tree blocks.
+ */
+bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len);
 
 #endif
-- 
2.30.0

