Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0737B294825
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440726AbgJUG0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440723AbgJUG0V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XugAJXTVbcMduxwoky4Xcurh78SnufiC6dAqK5DT3wY=;
        b=GXf9blHICbI2b7RNXRSNZdkjQxI1t8An3LqJw807UXFGUjgsKayizBrb14/PaG5irLAxcZ
        sV0er9Zgk9N3DAXhpxQ8tWxhnrvrmkGBXLfD4Zg2yhCz1P1oEtfv+poCd+ZLzkbPGkOmap
        FF54x407iIZvl9LT33OiFBLWEOcB65I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFF12AC48
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 09/68] btrfs: extent_io: unexport extent_invalidatepage()
Date:   Wed, 21 Oct 2020 14:24:55 +0800
Message-Id: <20201021062554.68132-10-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index 92caa1190ca8..3aaf83376797 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -227,8 +227,6 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 			       u64 *start_ret, u64 *end_ret, unsigned bits);
-int extent_invalidatepage(struct extent_io_tree *tree,
-			  struct page *page, unsigned long offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca219c42ddc6..3f95c67f0c92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4409,30 +4409,6 @@ void extent_readahead(struct readahead_control *rac)
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

