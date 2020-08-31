Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94622578C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHaLyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgHaLxz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CD46B8D7;
        Mon, 31 Aug 2020 11:53:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/12] btrfs: Convert btrfs_inode_sectorsize to take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:42 +0300
Message-Id: <20200831114249.8360-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's counterinutitive to have a function named btrfs_inode_xxx which
takes a generic inode. Also move the function to btrfs_inode.h so othat
it has access to the definition of struct btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/btrfs_inode.h  |  5 +++++
 fs/btrfs/ctree.h        |  4 ----
 fs/btrfs/extent_io.c    |  6 +++---
 fs/btrfs/file.c         | 10 +++++-----
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/reflink.c      |  2 +-
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 00f7831d0902..6fdb46d58299 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -217,6 +217,11 @@ struct btrfs_inode {
 	struct inode vfs_inode;
 };
 
+static inline u32 btrfs_inode_sectorsize(const struct btrfs_inode *inode)
+{
+	return inode->root->fs_info->sectorsize;
+}
+
 static inline struct btrfs_inode *BTRFS_I(const struct inode *inode)
 {
 	return container_of(inode, struct btrfs_inode, vfs_inode);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f9d4e0958e2e..4e5441e02498 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1196,10 +1196,6 @@ struct btrfs_file_private {
 	void *filldir_buf;
 };
 
-static inline u32 btrfs_inode_sectorsize(const struct inode *inode)
-{
-	return btrfs_sb(inode->i_sb)->sectorsize;
-}
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
 {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a28d442d65b5..3b8df647c0dc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4555,7 +4555,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 static struct extent_map *get_extent_skip_holes(struct inode *inode,
 						u64 offset, u64 last)
 {
-	u64 sectorsize = btrfs_inode_sectorsize(inode);
+	u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	struct extent_map *em;
 	u64 len;
 
@@ -4736,8 +4736,8 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out_free_ulist;
 	}
 
-	start = round_down(start, btrfs_inode_sectorsize(inode));
-	len = round_up(max, btrfs_inode_sectorsize(inode)) - start;
+	start = round_down(start, btrfs_inode_sectorsize(BTRFS_I(inode)));
+	len = round_up(max, btrfs_inode_sectorsize(BTRFS_I(inode))) - start;
 
 	/*
 	 * lookup the last file extent.  We're not using i_size here
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8a3bf5fec655..09f21ea64ecb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2868,9 +2868,9 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out_only_mutex;
 	}
 
-	lockstart = round_up(offset, btrfs_inode_sectorsize(inode));
+	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
 	lockend = round_down(offset + len,
-			     btrfs_inode_sectorsize(inode)) - 1;
+			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
 	same_block = (BTRFS_BYTES_TO_BLKS(fs_info, offset))
 		== (BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1));
 	/*
@@ -3075,7 +3075,7 @@ enum {
 static int btrfs_zero_range_check_range_boundary(struct inode *inode,
 						 u64 offset)
 {
-	const u64 sectorsize = btrfs_inode_sectorsize(inode);
+	const u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	struct extent_map *em;
 	int ret;
 
@@ -3105,7 +3105,7 @@ static int btrfs_zero_range(struct inode *inode,
 	struct extent_changeset *data_reserved = NULL;
 	int ret;
 	u64 alloc_hint = 0;
-	const u64 sectorsize = btrfs_inode_sectorsize(inode);
+	const u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	u64 alloc_start = round_down(offset, sectorsize);
 	u64 alloc_end = round_up(offset + len, sectorsize);
 	u64 bytes_to_reserve = 0;
@@ -3286,7 +3286,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	u64 locked_end;
 	u64 actual_end = 0;
 	struct extent_map *em;
-	int blocksize = btrfs_inode_sectorsize(inode);
+	int blocksize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	int ret;
 
 	alloc_start = round_down(offset, blocksize);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 168a5edd939d..d39a0fe4c463 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -870,7 +870,7 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	u32 sectorsize = btrfs_inode_sectorsize(inode);
+	u32 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5cd02514cf4d..7126f94cf216 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -52,7 +52,7 @@ static int copy_inline_to_page(struct inode *inode,
 			       const u64 datal,
 			       const u8 comp_type)
 {
-	const u64 block_size = btrfs_inode_sectorsize(inode);
+	const u64 block_size = btrfs_inode_sectorsize(BTRFS_I(inode));
 	const u64 range_end = file_offset + block_size - 1;
 	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
 	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
-- 
2.17.1

