Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD04C36015F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhDOFFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhDOFFq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60AFE5qGFRU6fO3srYnPePuxzM0NBJ49DkBDZN4uY8o=;
        b=PB7PJ/DJstMY0TvUU6RHOkY8s6T7fkVcRhCVad4Ik/O4NhVMkMG3ZavNNVWP83JpsszmAS
        KZqit+YS9UM/UmQn3QLLuMIH3XjZrskrubRtaOIfDM+BViFLJr8ONz3loObB2UuD04pkxv
        e5IPDdFHP4/3hdWOmLPQdgi8pybkc0M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C133CAF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/42] btrfs: provide btrfs_page_clamp_*() helpers
Date:   Thu, 15 Apr 2021 13:04:22 +0800
Message-Id: <20210415050448.267306-17-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the coming subpage RW supports, there are a lot of page status update
calls which need to be converted to subpage compatible version, which
needs @start and @len.

Some call sites already have such @start/@len and are already in
page range, like various endio functions.

But there are also call sites which need to clamp the range for subpage
case, like btrfs_dirty_pagse() and __process_contig_pages().

Here we introduce new helpers, btrfs_page_clamp_*(), to do and only do the
clamp for subpage version.

Although in theory all existing btrfs_page_*() calls can be converted to
use btrfs_page_clamp_*() directly, but that would make us to do
unnecessary clamp operations.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 2d19089ab625..a6cf1776f3f9 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -354,6 +354,16 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
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
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -408,6 +418,34 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
 		return test_page_func(page);				\
 	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+}									\
+void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		set_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+}									\
+void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+		clear_page_func(page);					\
+		return;							\
+	}								\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+}									\
+bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len)			\
+{									\
+	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+		return test_page_func(page);				\
+	btrfs_subpage_clamp_range(page, &start, &len);			\
+	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			 PageUptodate);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index bfd626e955be..291cb1932f27 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -72,6 +72,10 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
  * btrfs_page_*() are for call sites where the page can either be subpage
  * specific or regular page. The function will handle both cases.
  * But the range still needs to be inside the page.
+ *
+ * btrfs_page_clamp_*() are similar to btrfs_page_*(), except the range doesn't
+ * need to be inside the page. Those functions will truncate the range
+ * automatically.
  */
 #define DECLARE_BTRFS_SUBPAGE_OPS(name)					\
 void btrfs_subpage_set_##name(const struct btrfs_fs_info *fs_info,	\
@@ -85,6 +89,12 @@ void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
 void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len);			\
 bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct page *page, u64 start, u32 len);			\
+bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len);
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
-- 
2.31.1

