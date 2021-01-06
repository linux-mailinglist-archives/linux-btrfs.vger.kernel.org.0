Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7432EB763
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAFBDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbhAFBDo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DaTqi4VSZzjhw7Gg1bRwuSzc4/Wx9SdMiAklBntXuBo=;
        b=FYgtqb2fUp9pRVM2SFG+LtM86d01TNdVbhWEVpSvS3ZNeONYuLZX8BZh7P7q6Y7wo8EDkr
        viNDZalCoo/WRL3fq7qlrpWTuvgGAq5Mx877cEib3fGkkX/98GG4/a9Y3aCBOHmzwWYEN2
        qXlaqI5Nm1dJfgKJ2b3yJtPIJiPk6DE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8724DAF49
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 12/22] btrfs: subpage: introduce helper for subpage uptodate status
Date:   Wed,  6 Jan 2021 09:01:51 +0800
Message-Id: <20210106010201.37864-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
  Although caller should still ensure that the range is inside the page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index c1556b3b68f3..2b2d25cc6cba 100644
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
@@ -102,4 +103,87 @@ static inline bool btrfs_subpage_clear_and_test_tree_block(
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
+	if (subpage->uptodate_bitmap == U16_MAX)
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
+	subpage->uptodate_bitmap &= ~tmp;
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
+ * Thankfully in selftest, we only test sectorsize == PAGE_SIZE cases so far,
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
+	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+}									\
+static inline void btrfs_page_clear_##name(struct btrfs_fs_info *fs_info, \
+			struct page *page, u64 start, u32 len)		\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		clear_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+}									\
+static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
+			struct page *page, u64 start, u32 len)		\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+		return test_page_func(page);				\
+	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+}
+DECLARE_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
+			PageUptodate);
+
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.29.2

