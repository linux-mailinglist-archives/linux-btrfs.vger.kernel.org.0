Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA64CECEC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfJGThc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728971AbfJGThc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F41DAD7F;
        Mon,  7 Oct 2019 19:37:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A3DFDA7FB; Mon,  7 Oct 2019 21:37:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: remove extent_map::bdev
Date:   Mon,  7 Oct 2019 21:37:46 +0200
Message-Id: <5ab96a614a5a5e41d5ab5273a4bbb399f2f6ec16.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can now remove the bdev from extent_map. Previous patches made sure
that bio_set_dev is correctly in all places and that we don't need to
grab it from latest_bdev or pass it around inside the extent map.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c    |  3 ---
 fs/btrfs/extent_io.c  |  2 --
 fs/btrfs/extent_map.c |  3 ---
 fs/btrfs/extent_map.h | 11 ++---------
 fs/btrfs/file-item.c  |  1 -
 fs/btrfs/file.c       |  3 ---
 fs/btrfs/inode.c      |  8 --------
 fs/btrfs/relocation.c |  2 --
 8 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 16dc60b4966d..7a7e59baa0d6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -205,7 +205,6 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 		struct page *page, size_t pg_offset, u64 start, u64 len,
 		int create)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	int ret;
@@ -213,7 +212,6 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
 	if (em) {
-		em->bdev = fs_info->fs_devices->latest_bdev;
 		read_unlock(&em_tree->lock);
 		goto out;
 	}
@@ -228,7 +226,6 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
 	em->block_start = 0;
-	em->bdev = fs_info->fs_devices->latest_bdev;
 
 	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5baade1bc1e1..d3dda8388f93 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3150,7 +3150,6 @@ static int __do_readpage(struct extent_io_tree *tree,
 			offset = em->block_start + extent_offset;
 			disk_io_size = iosize;
 		}
-		bdev = em->bdev;
 		block_start = em->block_start;
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			block_start = EXTENT_MAP_HOLE;
@@ -3486,7 +3485,6 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 		iosize = min(em_end - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
 		offset = em->block_start + extent_offset;
-		bdev = em->bdev;
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		free_extent_map(em);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 9f99dccbc3ca..6f417ff68980 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -218,9 +218,6 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 		ASSERT(test_bit(EXTENT_FLAG_FS_MAPPING, &prev->flags) &&
 		       test_bit(EXTENT_FLAG_FS_MAPPING, &next->flags));
 
-	if (prev->bdev || next->bdev)
-		ASSERT(prev->bdev == next->bdev);
-
 	if (extent_map_end(prev) == next->start &&
 	    prev->flags == next->flags &&
 	    prev->map_lookup == next->map_lookup &&
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 3eb9c596b445..8e217337dff9 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -42,15 +42,8 @@ struct extent_map {
 	u64 block_len;
 	u64 generation;
 	unsigned long flags;
-	struct {
-		struct block_device *bdev;
-
-		/*
-		 * used for chunk mappings
-		 * flags & EXTENT_FLAG_FS_MAPPING must be set
-		 */
-		struct map_lookup *map_lookup;
-	};
+	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
+	struct map_lookup *map_lookup;
 	refcount_t refs;
 	unsigned int compress_type;
 	struct list_head list;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1a599f50837b..3270a40b0777 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -945,7 +945,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
 
-	em->bdev = fs_info->fs_devices->latest_bdev;
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3d151f788177..888871fb7aa3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -667,7 +667,6 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			}
 
 			split->generation = gen;
-			split->bdev = em->bdev;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
 			replace_extent_mapping(em_tree, em, split, modified);
@@ -680,7 +679,6 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 
 			split->start = start + len;
 			split->len = em->start + em->len - (start + len);
-			split->bdev = em->bdev;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
 			split->generation = gen;
@@ -2363,7 +2361,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
 		hole_em->orig_block_len = 0;
-		hole_em->bdev = fs_info->fs_devices->latest_bdev;
 		hole_em->compress_type = BTRFS_COMPRESS_NONE;
 		hole_em->generation = trans->transid;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e085d21c3c5..23178fef4fc6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5132,7 +5132,6 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 			hole_em->block_len = 0;
 			hole_em->orig_block_len = 0;
 			hole_em->ram_bytes = hole_size;
-			hole_em->bdev = fs_info->fs_devices->latest_bdev;
 			hole_em->compress_type = BTRFS_COMPRESS_NONE;
 			hole_em->generation = fs_info->generation;
 
@@ -6910,8 +6909,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
-	if (em)
-		em->bdev = fs_info->fs_devices->latest_bdev;
 	read_unlock(&em_tree->lock);
 
 	if (em) {
@@ -6927,7 +6924,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		err = -ENOMEM;
 		goto out;
 	}
-	em->bdev = fs_info->fs_devices->latest_bdev;
 	em->start = EXTENT_MAP_HOLE;
 	em->orig_start = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
@@ -7186,7 +7182,6 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 			err = -ENOMEM;
 			goto out;
 		}
-		em->bdev = NULL;
 
 		ASSERT(hole_em);
 		/*
@@ -7546,7 +7541,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 {
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret;
 
 	ASSERT(type == BTRFS_ORDERED_PREALLOC ||
@@ -7564,7 +7558,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
-	em->bdev = root->fs_info->fs_devices->latest_bdev;
 	em->orig_block_len = orig_block_len;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
@@ -10410,7 +10403,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->block_len = ins.offset;
 		em->orig_block_len = ins.offset;
 		em->ram_bytes = ins.offset;
-		em->bdev = fs_info->fs_devices->latest_bdev;
 		set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		em->generation = trans->transid;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 00504657b602..ad9d8d99c651 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3195,7 +3195,6 @@ static noinline_for_stack
 int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 			 u64 block_start)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
 	int ret = 0;
@@ -3208,7 +3207,6 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 	em->len = end + 1 - start;
 	em->block_len = em->len;
 	em->block_start = block_start;
-	em->bdev = fs_info->fs_devices->latest_bdev;
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 
 	lock_extent(&BTRFS_I(inode)->io_tree, start, end);
-- 
2.23.0

