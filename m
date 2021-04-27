Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0836CF26
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhD0XF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XF1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7uHDQ0tuO4ti9z0qd6jdj244EylIrHRmcBtlkjc9Js=;
        b=WdEMHPK49xtGpNxeFkpqtBxwr2rKQ1QfO5Fx07eu37WTgQJ8pEzx9fN+xk0FI3yaRMoX1K
        5djqCgxwKs6nVqOYlOtN25FC0+l8u/GZtsHlycUwtC8ycGQrb8B+HQwDUk8feUbdtzz/aI
        g66lFCoetQEO+NEZ6b5/3iQGfHhJNwE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75477ABED;
        Tue, 27 Apr 2021 23:04:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 21/42] btrfs: make process_one_page() to handle subpage locking
Date:   Wed, 28 Apr 2021 07:03:28 +0800
Message-Id: <20210427230349.369603-22-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new data inodes specific subpage member, writers, to record
how many sectors are under page lock for delalloc writing.

This member acts pretty much the same as readers, except it's only for
delalloc writes.

This is important for delalloc code to trace which page can really be
freed, as we have cases like run_delalloc_nocow() where we may exit
processing nocow range inside a page, but need to exit to do cow half
way.
In that case, we need a way to determine if we can really unlock a full
page.

With the new btrfs_subpage::writers, there is a new requirement:
- Page locked by process_one_page() must be unlocked by
  process_one_page()
  There are still tons of call sites manually lock and unlock a page,
  without updating btrfs_subpage::writers.
  So if we lock a page through process_one_page() then it must be
  unlocked by process_one_page() to keep btrfs_subpage::writers
  consistent.

  This will be handled in next patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 10 +++--
 fs/btrfs/subpage.c   | 89 ++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/subpage.h   | 10 +++++
 3 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fc69ed998b9d..006ac1ffb9a4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1841,14 +1841,18 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 	if (page_ops & PAGE_END_WRITEBACK)
 		btrfs_page_clamp_clear_writeback(fs_info, page, start, len);
 	if (page_ops & PAGE_LOCK) {
-		lock_page(page);
+		int ret;
+
+		ret = btrfs_page_start_writer_lock(fs_info, page, start, len);
+		if (ret)
+			return ret;
 		if (!PageDirty(page) || page->mapping != mapping) {
-			unlock_page(page);
+			btrfs_page_end_writer_lock(fs_info, page, start, len);
 			return -EAGAIN;
 		}
 	}
 	if (page_ops & PAGE_UNLOCK)
-		unlock_page(page);
+		btrfs_page_end_writer_lock(fs_info, page, start, len);
 	return 0;
 }
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index a6cf1776f3f9..f728e5009487 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -110,10 +110,12 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	if (!*ret)
 		return -ENOMEM;
 	spin_lock_init(&(*ret)->lock);
-	if (type == BTRFS_SUBPAGE_METADATA)
+	if (type == BTRFS_SUBPAGE_METADATA) {
 		atomic_set(&(*ret)->eb_refs, 0);
-	else
+	} else {
 		atomic_set(&(*ret)->readers, 0);
+		atomic_set(&(*ret)->writers, 0);
+	}
 	return 0;
 }
 
@@ -203,6 +205,79 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 		unlock_page(page);
 }
 
+static void btrfs_subpage_clamp_range(struct page *page, u64 *start, u32 *len)
+{
+	u64 orig_start = *start;
+	u32 orig_len = *len;
+
+	*start = max_t(u64, page_offset(page), orig_start);
+	*len = min_t(u64, page_offset(page) + PAGE_SIZE,
+		     orig_start + orig_len) - *start;
+}
+
+void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	int nbits = len >> fs_info->sectorsize_bits;
+	int ret;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+
+	ASSERT(atomic_read(&subpage->readers) == 0);
+	ret = atomic_add_return(nbits, &subpage->writers);
+	ASSERT(ret == nbits);
+}
+
+bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	int nbits = len >> fs_info->sectorsize_bits;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+
+	ASSERT(atomic_read(&subpage->writers) >= nbits);
+	return atomic_sub_and_test(nbits, &subpage->writers);
+}
+
+/*
+ * To lock a page for delalloc page writeback.
+ *
+ * Return -EAGAIN if the page is not properly initialized.
+ * Return 0 with the page locked, and writer counter updated.
+ *
+ * Even with 0 returned, the page still need extra check to make sure
+ * it's really the correct page, as the caller is using
+ * find_get_pages_contig(), which can race with page invalidating.
+ */
+int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {
+		lock_page(page);
+		return 0;
+	}
+	lock_page(page);
+	if (!PagePrivate(page) || !page->private) {
+		unlock_page(page);
+		return -EAGAIN;
+	}
+	btrfs_subpage_clamp_range(page, &start, &len);
+	btrfs_subpage_start_writer(fs_info, page, start, len);
+	return 0;
+}
+
+void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)
+		return unlock_page(page);
+	btrfs_subpage_clamp_range(page, &start, &len);
+	if (btrfs_subpage_end_and_test_writer(fs_info, page, start, len))
+		unlock_page(page);
+}
+
 /*
  * Convert the [start, start + len) range into a u16 bitmap
  *
@@ -354,16 +429,6 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-static void btrfs_subpage_clamp_range(struct page *page, u64 *start, u32 *len)
-{
-	u64 orig_start = *start;
-	u32 orig_len = *len;
-
-	*start = max_t(u64, page_offset(page), orig_start);
-	*len = min_t(u64, page_offset(page) + PAGE_SIZE,
-		     orig_start + orig_len) - *start;
-}
-
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 291cb1932f27..9d087ab3244e 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -33,6 +33,7 @@ struct btrfs_subpage {
 		/* Structures only used by data */
 		struct {
 			atomic_t readers;
+			atomic_t writers;
 		};
 	};
 };
@@ -63,6 +64,15 @@ void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len);
 
+void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len);
+bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len);
+int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len);
+void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len);
+
 /*
  * Template for subpage related operations.
  *
-- 
2.31.1

