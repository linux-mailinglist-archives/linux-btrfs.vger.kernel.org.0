Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF34395774
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEaIxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhEaIxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0P9eP9VVzvDT5zBbQnUO2984IzvLtOxsrJz+dZKvT0=;
        b=rw0aoreHrPeaFpThHB8L4WEhiQ99o7LiX3yVjkrRY9Bza7UZiiN8J6vhh7VOHMCr4r4Hhb
        BDTsyerDKpaUBBuZdIlAm64jPEw3jt+aDzAuF1NIKFWbN9hRaBTu0s/rnJAOF7ycUDUh0J
        rtnWMLgBNBm4E1GHNEUEQHYOyKs35Xc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCD0AB3E8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 13/30] btrfs: make btrfs_set_range_writeback() subpage compatible
Date:   Mon, 31 May 2021 16:50:49 +0800
Message-Id: <20210531085106.259490-14-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_set_range_writeback() currently just set the page
writeback unconditionally.

Change it to call the subpage helper so that we can handle both cases
well.

Since the subpage helpers needs btrfs_info, also change the parameter to
accept btrfs_inode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c |  3 +--
 fs/btrfs/inode.c     | 12 ++++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 677d612dcdcb..45798e68331a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3146,7 +3146,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
-void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
+void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
 void btrfs_evict_inode(struct inode *inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 00f62f0f866e..439aace2f5e0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3800,7 +3800,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3879,7 +3878,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		btrfs_set_range_writeback(tree, cur, cur + iosize - 1);
+		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
 				   "page %lu not writeback, cur %llu end %llu",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6be83d30ad43..7bf6ed4b4530 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10205,17 +10205,21 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	return ret;
 }
 
-void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
+void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 {
-	struct inode *inode = tree->private_data;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
 	struct page *page;
+	u32 len;
 
+	ASSERT(end + 1 - start <= U32_MAX);
+	len = end + 1 - start;
 	while (index <= end_index) {
-		page = find_get_page(inode->i_mapping, index);
+		page = find_get_page(inode->vfs_inode.i_mapping, index);
 		ASSERT(page); /* Pages should be in the extent_io_tree */
-		set_page_writeback(page);
+
+		btrfs_page_set_writeback(fs_info, page, start, len);
 		put_page(page);
 		index++;
 	}
-- 
2.31.1

