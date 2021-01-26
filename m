Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1491E30464F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbhAZRYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:24:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbhAZIgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ExtfIxzdAvr58YWQEokJ7rKUMowPaIaiMQRo187Oyg=;
        b=cTedgh+KVQ96/US22KrOzOp7u7CV4fYaJlspsPC4XES2ljNN9nSbSP+lvIkk8bKTEDA2hR
        kCsLZNpB8TC/bygZJe101v5h83hPe+EtGdKDD2F3XnTdAGJc9NVPKuBifcGYeNfI3kR6W/
        hcx/xPokGnojV0dJ+OCAjOWiXgAOnWs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEF7AAF59;
        Tue, 26 Jan 2021 08:34:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 08/18] btrfs: introduce helpers for subpage uptodate status
Date:   Tue, 26 Jan 2021 16:33:52 +0800
Message-Id: <20210126083402.142577-9-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce the following functions to handle subpage uptodate status:

- btrfs_subpage_set_uptodate()
- btrfs_subpage_clear_uptodate()
- btrfs_subpage_test_uptodate()
  These helpers can only be called when the page has subpage attached
  and the range is ensured to be inside the page.

- btrfs_page_set_uptodate()
- btrfs_page_clear_uptodate()
- btrfs_page_test_uptodate()
  These helpers can handle both regular sector size and subpage.
  Although caller should still ensure that the range is inside the page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/subpage.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h |  28 +++++++++++
 2 files changed, 142 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index a2a21fa0ea35..50b56e58ca93 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -101,3 +101,117 @@ void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
 	ASSERT(atomic_read(&subpage->eb_refs));
 	atomic_dec(&subpage->eb_refs);
 }
+
+/*
+ * Convert the [start, start + len) range into a u16 bitmap
+ *
+ * For example: if start == page_offset() + 16K, len = 16K, we get 0x00f0.
+ */
+static inline u16 btrfs_subpage_calc_bitmap(
+		const struct btrfs_fs_info *fs_info, struct page *page,
+		u64 start, u32 len)
+{
+	const int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
+	const int nbits = len >> fs_info->sectorsize_bits;
+
+	/* Basic checks */
+	ASSERT(PagePrivate(page) && page->private);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
+
+	/*
+	 * The range check only works for mapped page, we can still have
+	 * unampped page like dummy extent buffer pages.
+	 */
+	if (page->mapping)
+		ASSERT(page_offset(page) <= start &&
+			start + len <= page_offset(page) + PAGE_SIZE);
+	/*
+	 * Here nbits can be 16, thus can go beyond u16 range. We make the
+	 * first left shift to be calculate in unsigned long (at least u32),
+	 * then truncate the result to u16.
+	 */
+	return (u16)(((1UL << nbits) - 1) << bit_start);
+}
+
+void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->uptodate_bitmap |= tmp;
+	if (subpage->uptodate_bitmap == U16_MAX)
+		SetPageUptodate(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
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
+#define IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(name)				\
+bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private; \
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len); \
+	unsigned long flags;						\
+	bool ret;							\
+									\
+	spin_lock_irqsave(&subpage->lock, flags);			\
+	ret = ((subpage->name##_bitmap & tmp) == tmp);			\
+	spin_unlock_irqrestore(&subpage->lock, flags);			\
+	return ret;							\
+}
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
+
+/*
+ * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
+ * in.  We only test sectorsize == PAGE_SIZE cases so far, thus we can fall
+ * back to regular sectorsize branch.
+ */
+#define IMPLEMENT_BTRFS_PAGE_OPS(name, set_page_func, clear_page_func,	\
+			       test_page_func)				\
+void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		set_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+}									\
+void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		clear_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+}									\
+bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+		return test_page_func(page);				\
+	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+}
+IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
+			 PageUptodate);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index eef2ecae77e0..1dee4eb1c5c1 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -19,6 +19,7 @@
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
+	u16 uptodate_bitmap;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -51,4 +52,31 @@ void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
 			    struct page *page);
 void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
 			    struct page *page);
+
+/*
+ * Template for subpage related operations.
+ *
+ * btrfs_subpage_*() are for call sites where the page has subpage attached and
+ * the range is ensured to be inside the page.
+ *
+ * btrfs_page_*() are for call sites where the page can either be subpage
+ * specific or regular page. The function will handle both cases.
+ * But the range still needs to be inside the page.
+ */
+#define DECLARE_BTRFS_SUBPAGE_OPS(name)					\
+void btrfs_subpage_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+void btrfs_subpage_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
+		struct page *page, u64 start, u32 len);			\
+void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);
+
+DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
+
 #endif
-- 
2.30.0

