Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4912360169
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhDOFGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhDOFGF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBwTIVpBZ/Va3eI0hRj69nWeUTlW8BsCZd/WU+eOdpo=;
        b=Gvbdi7UyUow4tNTOdnfv2MZleOZw6y7GTHiXNIqPUCVrsJapyJdMRuSr/ibndCGsCLs1oE
        5ooDii0TWEwAXm0FfsbUKgkk6efE5azps8tEBJh4MttnRTR46Aj4O2uLRE+J1dp2kyJ9W/
        KiiejeBvhIxPUE1AnbU+sGR1GdMH5Gg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FF12AF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 26/42] btrfs: make btrfs_set_range_writeback() subpage compatible
Date:   Thu, 15 Apr 2021 13:04:32 +0800
Message-Id: <20210415050448.267306-27-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
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
index 903fdcb6ecd0..f8d1e495deda 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3136,7 +3136,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
 bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
 				      unsigned int size);
-void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
+void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
 void btrfs_evict_inode(struct inode *inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7dc1b367bf35..c593071fa8c1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3745,7 +3745,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *tree = &inode->io_tree;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3824,7 +3823,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		btrfs_set_range_writeback(tree, cur, cur + iosize - 1);
+		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(inode->root->fs_info,
 				   "page %lu not writeback, cur %llu end %llu",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 566431d7b257..da73fd51d232 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10195,17 +10195,21 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
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

