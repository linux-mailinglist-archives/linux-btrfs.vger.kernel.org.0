Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA81EA707
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgFAPh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgFAPhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC4B4B230;
        Mon,  1 Jun 2020 15:37:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 29/46] btrfs: Make btrfs_run_delalloc_range take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:27 +0300
Message-Id: <20200601153744.31891-30-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All children now take btrfs_inode so convert it to taking it as a parameter
as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c |  6 ++++--
 fs/btrfs/inode.c     | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bd69e912e8d6..e6f47bdf6f0a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2927,7 +2927,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 				    struct btrfs_trans_handle *trans, int mode,
 				    u64 start, u64 num_bytes, u64 min_size,
 				    loff_t actual_len, u64 *alloc_hint);
-int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
+int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4d19cb930d57..e2a033e77b25 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3444,8 +3444,10 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
-		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-				delalloc_end, &page_started, nr_written, wbc);
+		ret = btrfs_run_delalloc_range(BTRFS_I(inode), page,
+					       delalloc_start,
+					       delalloc_end, &page_started,
+					       nr_written, wbc);
 		if (ret) {
 			SetPageError(page);
 			/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 709253e2470a..54e291c94214 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1795,31 +1795,31 @@ static inline int need_force_cow(struct btrfs_inode *inode, u64 start, u64 end)
  * Function to process delayed allocation (create CoW) for ranges which are
  * being touched for the first time.
  */
-int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
+int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc)
 {
 	int ret;
-	int force_cow = need_force_cow(BTRFS_I(inode), start, end);
+	int force_cow = need_force_cow(inode, start, end);

-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW && !force_cow) {
-		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
+	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
-	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
-		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
+	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(BTRFS_I(inode)) ||
-		   !inode_need_compress(BTRFS_I(inode), start, end)) {
-		ret = cow_file_range(BTRFS_I(inode), locked_page, start, end,
-				      page_started, nr_written, 1);
+	} else if (!inode_can_compress(inode) ||
+		   !inode_need_compress(inode, start, end)) {
+		ret = cow_file_range(inode, locked_page, start, end,
+				     page_started, nr_written, 1);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-			&BTRFS_I(inode)->runtime_flags);
-		ret = cow_file_range_async(BTRFS_I(inode), wbc, locked_page, start, end,
+			&inode->runtime_flags);
+		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
 					   page_started, nr_written);
 	}
 	if (ret)
-		btrfs_cleanup_ordered_extents(BTRFS_I(inode), locked_page, start,
+		btrfs_cleanup_ordered_extents(inode, locked_page, start,
 					      end - start + 1);
 	return ret;
 }
--
2.17.1

