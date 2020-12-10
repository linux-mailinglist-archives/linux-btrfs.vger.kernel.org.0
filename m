Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E2D53FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgLJGk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbgLJGkp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3c7+npsXwevbKox7FM5Ar8W1LpWNlxK+1vJA8k2qtK8=;
        b=GdZNOsmF+PgCW8GzdDrMxYyilfmAToIcnKGM9o0WqV+5VqC4GdCJEVavDlHb0gs1CrJ8vU
        gRbNlAnyXqUZQLzK3Hcp5hVSvlJ3fFC8ZBecGFxi3bPloYxkHmAQgfg3blqgfAaiioIqMy
        7Xdi5Ybmwal58EDHFJIIQ2Le9WV2ECc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B18FAD35
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/18] btrfs: subpage: introduce helper for subpage uptodate status
Date:   Thu, 10 Dec 2020 14:38:56 +0800
Message-Id: <20201210063905.75727-10-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduce the following functions to handle btrfs subpage
uptodate status:
- btrfs_subpage_set_uptodate()
- btrfs_subpage_clear_uptodate()
- btrfs_subpage_test_uptodate()
  Those helpers can only be called when the range is ensured to be
  inside the page.

- btrfs_page_set_uptodate()
- btrfs_page_clear_uptodate()
- btrfs_page_test_uptodate()
  Those helpers can handle both regular sector size and subpage without
  problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.h | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 87b4e028ae18..b3cf9171ec98 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -23,6 +23,7 @@
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
+	u16 uptodate_bitmap;
 	union {
 		/* Structures only used by metadata */
 		struct {
@@ -35,6 +36,17 @@ struct btrfs_subpage {
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 
+static inline void btrfs_subpage_clamp_range(struct page *page,
+					     u64 *start, u32 *len)
+{
+	u64 orig_start = *start;
+	u32 orig_len = *len;
+
+	*start = max_t(u64, page_offset(page), orig_start);
+	*len = min_t(u64, page_offset(page) + PAGE_SIZE,
+		     orig_start + orig_len) - *start;
+}
+
 /*
  * Convert the [start, start + len) range into a u16 bitmap
  *
@@ -96,4 +108,90 @@ static inline bool btrfs_subpage_clear_and_test_tree_block(
 	return last;
 }
 
+static inline void btrfs_subpage_set_uptodate(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->uptodate_bitmap |= tmp;
+	if (subpage->uptodate_bitmap == (u16)-1)
+		SetPageUptodate(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->tree_block_bitmap &= ~tmp;
+	ClearPageUptodate(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+/*
+ * Unlike set/clear which is dependent on each page status, for test all bits
+ * are tested in the same way.
+ */
+#define DECLARE_BTRFS_SUBPAGE_TEST_OP(name)				\
+static inline bool btrfs_subpage_test_##name(struct btrfs_fs_info *fs_info, \
+			struct page *page, u64 start, u32 len)		\
+{									\
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private; \
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len); \
+	unsigned long flags;						\
+	bool ret;							\
+									\
+	spin_lock_irqsave(&subpage->lock, flags);			\
+	ret = ((subpage->name##_bitmap & tmp) == tmp);			\
+	spin_unlock_irqrestore(&subpage->lock, flags);			\
+	return ret;							\
+}
+DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
+
+/*
+ * Note that, in selftest, especially extent-io-tests, we can have empty
+ * fs_info passed in.
+ * Thanfully in selftest, we only test sectorsize == PAGE_SIZE cases so far
+ * thus we can fall back to regular sectorsize branch.
+ */
+#define DECLARE_BTRFS_PAGE_OPS(name, set_page_func, clear_page_func,	\
+			       test_page_func)				\
+static inline void btrfs_page_set_##name(struct btrfs_fs_info *fs_info,	\
+			struct page *page, u64 start, u32 len)		\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		set_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+}									\
+static inline void btrfs_page_clear_##name(struct btrfs_fs_info *fs_info, \
+			struct page *page, u64 start, u32 len)		\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		clear_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+}									\
+static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
+			struct page *page, u64 start, u32 len)		\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+		return test_page_func(page);				\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+}
+DECLARE_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
+			PageUptodate);
+
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.29.2

