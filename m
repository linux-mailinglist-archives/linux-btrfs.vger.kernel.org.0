Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D506E2EB765
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAFBDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbhAFBDq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJPXmJiFmLPdDZ0HBs8y8UuKqernRptf0nL55f7j3nk=;
        b=GI5kCqZUE39IR9rzgtCs1SKzX1VVCqE7b9Avg9hruOmcMuERoj9CBS9Q/ugS21Ks0c5CGU
        1D6tD89N4F892cNdlZm+LQtoDsM4fs0MSC91xgU1dMtMNth7e98iieHddkuyNisW1PYnhj
        nj6mTfwl/D+aqilte6R207rtXz83Hf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47479AF58
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 13/22] btrfs: subpage: introduce helper for subpage error status
Date:   Wed,  6 Jan 2021 09:01:52 +0800
Message-Id: <20210106010201.37864-14-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduce the following functions to handle btrfs subpage
error status:
- btrfs_subpage_set_error()
- btrfs_subpage_clear_error()
- btrfs_subpage_test_error()
  Those helpers can only be called when the range is ensured to be
  inside the page.

- btrfs_page_set_error()
- btrfs_page_clear_error()
- btrfs_page_test_error()
  Those helpers can handle both regular sector size and subpage without
  problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 2b2d25cc6cba..25f6d0cd1a1e 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -24,6 +24,7 @@ struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
 	u16 uptodate_bitmap;
+	u16 error_bitmap;
 	union {
 		/* Structures only used by metadata */
 		struct {
@@ -130,6 +131,35 @@ static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+static inline void btrfs_subpage_set_error(struct btrfs_fs_info *fs_info,
+					   struct page *page, u64 start,
+					   u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->error_bitmap |= tmp;
+	SetPageError(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+static inline void btrfs_subpage_clear_error(struct btrfs_fs_info *fs_info,
+					   struct page *page, u64 start,
+					   u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->error_bitmap &= ~tmp;
+	if (subpage->error_bitmap == 0)
+		ClearPageError(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -149,6 +179,7 @@ static inline bool btrfs_subpage_test_##name(struct btrfs_fs_info *fs_info, \
 	return ret;							\
 }
 DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
+DECLARE_BTRFS_SUBPAGE_TEST_OP(error);
 
 /*
  * Note that, in selftest, especially extent-io-tests, we can have empty
@@ -185,5 +216,6 @@ static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
 }
 DECLARE_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			PageUptodate);
+DECLARE_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
 
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.29.2

