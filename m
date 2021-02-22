Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0C3210DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBVGfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:48652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVGfA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isxCZDriwNbADVw9hMWR1mBXxpw/F1Tb19jjrH4/NDU=;
        b=Bh08+17RIucRkQlgH/uz8pOTgYKWnoihQQi/lqVH4et6gCThmIPaWVmrXMcLWmpJbxPIIa
        7dYT+0pt2LRjmmVzcdwJuIGsML0KH0JDQMaPe4Lduu9Z8Hp1p80/PM24nKnqJuATuGSMPr
        HGVs8rXZx2J6LXgzDejWLcDmf99nMWU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A1E8B11D
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: subpage: introduce helper for subpage writeback status
Date:   Mon, 22 Feb 2021 14:33:47 +0800
Message-Id: <20210222063357.92930-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduce the following functions to handle btrfs subpage
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
index 16dd6fcd258d..9bc212d16d3c 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -259,6 +259,33 @@ void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
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
@@ -280,6 +307,7 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -318,3 +346,5 @@ IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
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
2.30.0

