Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D651EC930
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCF4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgFCFzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6547CAF8D;
        Wed,  3 Jun 2020 05:55:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/46] btrfs: Make btrfs_lookup_ordered_extent take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:03 +0300
Message-Id: <20200603055546.3889-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It doesn't use the generic vfs inode for anything use btrfs_inode directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file-item.c    | 5 +++--
 fs/btrfs/inode.c        | 2 +-
 fs/btrfs/ioctl.c        | 2 +-
 fs/btrfs/ordered-data.c | 6 +++---
 fs/btrfs/ordered-data.h | 2 +-
 fs/btrfs/relocation.c   | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 706a3128e192..9d311e834b20 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -522,10 +522,11 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  *		 means this bio can contains potentially discontigous bio vecs
  *		 so the logical offset of each should be calculated separately.
  */
-blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
+blk_status_t btrfs_csum_one_bio(struct inode *vfsinode, struct bio *bio,
 		       u64 file_start, int contig)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *inode = BTRFS_I(vfsinode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bc94051e3b4a..09a0c6a9a73a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4543,7 +4543,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
 	set_page_extent_mapped(page);

-	ordered = btrfs_lookup_ordered_extent(inode, block_start);
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), block_start);
 	if (ordered) {
 		unlock_extent_cached(io_tree, block_start, block_end,
 				     &cached_state);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 168deb8ef68a..4dc308048d8c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1265,7 +1265,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		while (1) {
 			lock_extent_bits(tree, page_start, page_end,
 					 &cached_state);
-			ordered = btrfs_lookup_ordered_extent(inode,
+			ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
 							      page_start);
 			unlock_extent_cached(tree, page_start, page_end,
 					     &cached_state);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 7bf7edbb994c..4139de966c74 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -697,14 +697,14 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
  * find an ordered extent corresponding to file_offset.  return NULL if
  * nothing is found, otherwise take a reference on the extent and return it
  */
-struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct inode *inode,
+struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset)
 {
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;

-	tree = &BTRFS_I(inode)->ordered_tree;
+	tree = &inode->ordered_tree;
 	spin_lock_irq(&tree->lock);
 	node = tree_search(tree, file_offset);
 	if (!node)
@@ -802,7 +802,7 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;

-	ordered = btrfs_lookup_ordered_extent(inode, offset);
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), offset);
 	if (!ordered)
 		return 0;

diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c01c9698250b..6afa9d98e84e 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -166,7 +166,7 @@ int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
 				      int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
-struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct inode *inode,
+struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset);
 void btrfs_start_ordered_extent(struct inode *inode,
 				struct btrfs_ordered_extent *entry, int wait);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3bbae80c752f..2a49115ee4c6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3882,7 +3882,7 @@ int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
 	u64 new_bytenr;
 	LIST_HEAD(list);

-	ordered = btrfs_lookup_ordered_extent(inode, file_pos);
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_pos);
 	BUG_ON(ordered->file_offset != file_pos || ordered->num_bytes != len);

 	disk_bytenr = file_pos + BTRFS_I(inode)->index_cnt;
--
2.17.1

