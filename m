Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF8333859
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhCJJJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:34704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232675AbhCJJIv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2sH71xxrWtEve7LTYGh3FTltdFbEiC/Dhq0Gk/5nAE=;
        b=M23Kmxe5seXXZbownmEp2t4UWAecLzl5Gw5t3sOzPzIwqqgZFKaoMMDwGsz3PNLb/xlPZI
        L+MiMONDUKNlYh6iDsCvpZHrihyOMmqiIiRangLY9ETozxAVoLwpdjgwFi1zHV3JUeBDtI
        cJEBD9WMmQY4n22mUYZp7lsT1tNpZyA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DF9CAD74
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/15] btrfs: introduce helpers for subpage writeback status
Date:   Wed, 10 Mar 2021 17:08:23 +0800
Message-Id: <20210310090833.105015-6-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces the following functions to handle btrfs subpage
writeback status:
- btrfs_subpage_set_writeback()
- btrfs_subpage_clear_writeback()
- btrfs_subpage_test_writeback()
  Those helpers can only be called when the range is ensured to be
  inside the page.

- btrfs_page_set_writeback()
- btrfs_page_clear_writeback()
- btrfs_page_test_writeback()
  Those helpers can handle both regular sector size and subpage without
  problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 183925902031..2a326d6385ed 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -260,6 +260,33 @@ void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
 		clear_page_dirty_for_io(page);
 }
 
+void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->writeback_bitmap |= tmp;
+	set_page_writeback(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->writeback_bitmap &= ~tmp;
+	if (subpage->writeback_bitmap == 0)
+		end_page_writeback(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -281,6 +308,7 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -319,3 +347,5 @@ IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 IMPLEMENT_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
 IMPLEMENT_BTRFS_PAGE_OPS(dirty, set_page_dirty, clear_page_dirty_for_io,
 			 PageDirty);
+IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
+			PageWriteback);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index adaece5ce294..fe43267e31f3 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -21,6 +21,7 @@ struct btrfs_subpage {
 	u16 uptodate_bitmap;
 	u16 error_bitmap;
 	u16 dirty_bitmap;
+	u16 writeback_bitmap;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -89,6 +90,7 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(error);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
+DECLARE_BTRFS_SUBPAGE_OPS(writeback);
 
 /*
  * Extra clear_and_test function for subpage dirty bitmap.
-- 
2.30.1

