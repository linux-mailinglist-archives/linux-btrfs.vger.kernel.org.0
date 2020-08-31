Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF252578C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgHaLyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgHaLx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82BF8B8DE;
        Mon, 31 Aug 2020 11:53:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/12] btrfs: Make btrfs_find_ordered_sum take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:46 +0300
Message-Id: <20200831114249.8360-10-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file-item.c    |  4 ++--
 fs/btrfs/ordered-data.c | 19 +++++++++----------
 fs/btrfs/ordered-data.h |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7d5ec71615b8..8f4f2bd6d9b9 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -318,8 +318,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 
 		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
-					       csum, nblocks);
+		count = btrfs_find_ordered_sum(BTRFS_I(inode), offset,
+					       disk_bytenr, csum, nblocks);
 		if (count)
 			goto found;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index d39a0fe4c463..c8a13d143877 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -861,20 +861,21 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
  * try to find a checksum.  This is used because we allow pages to
  * be reclaimed before their checksum is actually put into the btree
  */
-int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len)
+int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
+			   u64 disk_bytenr, u8 *sum, int len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_sum *ordered_sum;
 	struct btrfs_ordered_extent *ordered;
-	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	u32 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
+	u32 sectorsize = btrfs_inode_sectorsize(inode);
+	const u8 blocksize_bits = inode->vfs_inode.i_sb->s_blocksize_bits;
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;
 
-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), offset);
+	ordered = btrfs_lookup_ordered_extent(inode, offset);
 	if (!ordered)
 		return 0;
 
@@ -882,10 +883,8 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 	list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
 		if (disk_bytenr >= ordered_sum->bytenr &&
 		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
-			i = (disk_bytenr - ordered_sum->bytenr) >>
-			    inode->i_sb->s_blocksize_bits;
-			num_sectors = ordered_sum->len >>
-				      inode->i_sb->s_blocksize_bits;
+			i = (disk_bytenr - ordered_sum->bytenr) >> blocksize_bits;
+			num_sectors = ordered_sum->len >> blocksize_bits;
 			num_sectors = min_t(int, len - index, num_sectors - i);
 			memcpy(sum + index, ordered_sum->sums + i * csum_size,
 			       num_sectors * csum_size);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 1610195c6097..6a1d5bf5aee3 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -185,8 +185,8 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		u64 len);
 void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 					   struct list_head *list);
-int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len);
+int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
+			   u64 disk_bytenr, u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-- 
2.17.1

