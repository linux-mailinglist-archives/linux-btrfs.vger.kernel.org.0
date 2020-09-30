Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80FA27DE00
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgI3B4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3B4D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T88ZxgyZASDN2sG2X2N5+Ua2OFyqDTZt0AQSeJsOKSM=;
        b=h8n9ZXAxc6c9Ao1CXjg0+ybP3/FTx0/ovu5M5nCInFNn0DGEsFr1i/AmaPnUDxeXIM+lzO
        lyYCpKNvqXuXp48GuROfgPkestfgJ00zXF+3bLHudJgaDS2WxDCyPYt5LQf6QECh50RYM3
        WZhbmZuk12h/mOeYSTWnSiFNUyUlrfQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F508AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 08/49] btrfs: extent_io: unexport extent_invalidatepage()
Date:   Wed, 30 Sep 2020 09:54:58 +0800
Message-Id: <20200930015539.48867-9-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function extent_invalidatepage() has a single caller,
btree_invalidatepage().

Just unexport this function and move it disk-io.c.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c        | 23 +++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  2 --
 fs/btrfs/extent_io.c      | 24 ------------------------
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b7436ab7bba9..c81b7e53149c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -966,6 +966,29 @@ static int btree_releasepage(struct page *page, gfp_t gfp_flags)
 	return try_release_extent_buffer(page);
 }
 
+/*
+ * basic invalidatepage code, this waits on any locked or writeback
+ * ranges corresponding to the page, and then deletes any extent state
+ * records from the tree
+ */
+static void extent_invalidatepage(struct extent_io_tree *tree,
+				  struct page *page, unsigned long offset)
+{
+	struct extent_state *cached_state = NULL;
+	u64 start = page_offset(page);
+	u64 end = start + PAGE_SIZE - 1;
+	size_t blocksize = page->mapping->host->i_sb->s_blocksize;
+
+	start += ALIGN(offset, blocksize);
+	if (start > end)
+		return;
+
+	lock_extent_bits(tree, start, end, &cached_state);
+	wait_on_page_writeback(page);
+	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
+			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
+}
+
 static void btree_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 960d4a24f13e..5927338c74a2 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -229,8 +229,6 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 			       u64 *start_ret, u64 *end_ret, unsigned bits);
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2980e8384e74..02c3518afa82 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4405,30 +4405,6 @@ void extent_readahead(struct readahead_control *rac)
 	}
 }
 
-/*
- * basic invalidatepage code, this waits on any locked or writeback
- * ranges corresponding to the page, and then deletes any extent state
- * records from the tree
- */
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset)
-{
-	struct extent_state *cached_state = NULL;
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	size_t blocksize = page->mapping->host->i_sb->s_blocksize;
-
-	start += ALIGN(offset, blocksize);
-	if (start > end)
-		return 0;
-
-	lock_extent_bits(tree, start, end, &cached_state);
-	wait_on_page_writeback(page);
-	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
-	return 0;
-}
-
 /*
  * a helper for releasepage, this tests for areas of the page that
  * are locked or under IO and drops the related state bits if it is safe
-- 
2.28.0

