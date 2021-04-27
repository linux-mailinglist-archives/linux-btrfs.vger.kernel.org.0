Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A133836CF2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhD0XFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:37270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XFi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eFXx1rqwDo8dd9BJ8rqFYnyKXAWBRTPhHq2rFthMu4=;
        b=U01L60KvKX7sL/LRSVNpJtpx60MICGisx2YjbOK3RRRtuiHG4F245GS83TOfWfOZN+fLDu
        /YdyGgsUMDa3ATDbcC97VUkKm9w17EIVnTp+RGGl+QjGSlv5GX7ld9FBzXzn/QbqXXBCNJ
        5fNx43RzHQRrgj6F3FChen6Z1DMA5qE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52640AC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 26/42] btrfs: make btrfs_set_range_writeback() subpage compatible
Date:   Wed, 28 Apr 2021 07:03:33 +0800
Message-Id: <20210427230349.369603-27-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index 5d352f6b61f4..80670a631714 100644
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
index f8cda3c2988a..209576a3f182 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3804,7 +3804,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3883,7 +3882,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		btrfs_set_range_writeback(tree, cur, cur + iosize - 1);
+		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
 				   "page %lu not writeback, cur %llu end %llu",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a49d1ecfe62c..a997d041e1ee 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10167,17 +10167,21 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
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

