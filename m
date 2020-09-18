Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865EA26FE9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIRNen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIRNen (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uf3/cxuMREhuYZiRBGs+x/biWMU9I95orcNVsgV/3Tc=;
        b=MGqfV1/ac8eROggDfUHh4iXcqcQIb5eXtpsaaqFvXclNUAH6x56db+KMFn+UfCdyPgseFL
        GNy5DdWQd3EC0vjKHineKyI7UqAJJj7b/53Uk8iOarhM4bjSnY32/GxcciKS+wZgVXZCDE
        EdNnS5E32hdZHXPJFSjPec9djBc2RG8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAC6FAFB8;
        Fri, 18 Sep 2020 13:35:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree inode
Date:   Fri, 18 Sep 2020 16:34:33 +0300
Message-Id: <20200918133439.23187-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of relying on indirect calls to implement metadata buffer
validation simply check if the inode whose page we are processing equals
the btree inode. If it does call the necessary function.

This is an improvement in 2 directions:
1. We aren't paying the penalty of indirect calls in a post-speculation
   attacks world.

2. The function is now named more explicitly so it's obvious what's
   going on

This is in preparation to removing struct extent_io_ops altogether.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h     | 2 ++
 fs/btrfs/disk-io.c   | 8 ++++----
 fs/btrfs/disk-io.h   | 4 +++-
 fs/btrfs/extent_io.c | 9 ++++++---
 fs/btrfs/inode.c     | 7 +++----
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e667b0565e0..0c58d96b9fb3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2962,6 +2962,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode,
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
+int btrfs_check_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+		     struct page *page, u64 start, u64 end, int mirror);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 160b485d2cc0..5ad11c38230f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -524,9 +524,9 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 	return 1;
 }
 
-static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
-				      u64 phy_offset, struct page *page,
-				      u64 start, u64 end, int mirror)
+int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
+				   struct page *page, u64 start, u64 end,
+				   int mirror)
 {
 	u64 found_start;
 	int found_level;
@@ -4639,5 +4639,5 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 static const struct extent_io_ops btree_extent_io_ops = {
 	/* mandatory callbacks */
 	.submit_bio_hook = btree_submit_bio_hook,
-	.readpage_end_io_hook = btree_readpage_end_io_hook,
+	.readpage_end_io_hook = NULL
 };
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 89b6a709a184..bc2e49246199 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -76,7 +76,9 @@ void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
-
+int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
+				   struct page *page, u64 start, u64 end,
+				   int mirror);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index afac70ef0cc5..5e47606f7786 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2851,9 +2851,12 @@ static void end_bio_extent_readpage(struct bio *bio)
 
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
-			ret = tree->ops->readpage_end_io_hook(io_bio, offset,
-							      page, start, end,
-							      mirror);
+			if (data_inode)
+				ret = btrfs_check_csum(io_bio, offset, page,
+						       start, end, mirror);
+			else
+				ret = btrfs_validate_metadata_buffer(io_bio,
+					offset, page, start, end, mirror);
 			if (ret)
 				uptodate = 0;
 			else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb3fdd0798c6..23ac09aa813e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2817,9 +2817,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * if there's a match, we allow the bio to finish.  If not, the code in
  * extent_io.c will try to find good copies for us.
  */
-static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
-				      u64 phy_offset, struct page *page,
-				      u64 start, u64 end, int mirror)
+int btrfs_check_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+		     struct page *page, u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
 	struct inode *inode = page->mapping->host;
@@ -10249,7 +10248,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 static const struct extent_io_ops btrfs_extent_io_ops = {
 	/* mandatory callbacks */
 	.submit_bio_hook = btrfs_submit_bio_hook,
-	.readpage_end_io_hook = btrfs_readpage_end_io_hook,
+	.readpage_end_io_hook = NULL
 };
 
 /*
-- 
2.17.1

