Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8982F8C01
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAPHRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbhAPHRT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuRHCjMv7e8q3orOfqgdyxwEpoXwto5U/KOfeFagjxQ=;
        b=jlKYPc92e9fCiQLaJEdKwz2xfVCwajCiBMYJOZ+II3kFKpBfpvtMZwT7glTCfkk5efm+oY
        iK7afIFXChyT1AF9cAIasA1LRmny8pDK7l56lbvX1Y1aQlIh4QRW4wSncXhWuIn2CztmdR
        wJiWnwmGiA4j86NENguNSw569aGgklw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73C10B900
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:16:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 09/18] btrfs: introduce helper for subpage error status
Date:   Sat, 16 Jan 2021 15:15:24 +0800
Message-Id: <20210116071533.105780-10-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
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
index 3373ef4ffec1..5da5441c08cb 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -24,6 +24,7 @@ struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
 	u16 uptodate_bitmap;
+	u16 error_bitmap;
 	union {
 		/* Structures only used by metadata */
 		bool under_alloc;
@@ -137,6 +138,35 @@ static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *fs_info,
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
@@ -156,6 +186,7 @@ static inline bool btrfs_subpage_test_##name(struct btrfs_fs_info *fs_info, \
 	return ret;							\
 }
 DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
+DECLARE_BTRFS_SUBPAGE_TEST_OP(error);
 
 /*
  * Note that, in selftest, especially extent-io-tests, we can have empty
@@ -192,5 +223,6 @@ static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
 }
 DECLARE_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			PageUptodate);
+DECLARE_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
 
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.30.0

