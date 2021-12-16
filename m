Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC610476ACB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhLPHIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 02:08:18 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52018 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhLPHIS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 02:08:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-nd84H_1639638494;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-nd84H_1639638494)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 15:08:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] btrfs: Fix kernel-doc formatting issues
Date:   Thu, 16 Dec 2021 15:08:13 +0800
Message-Id: <20211216070813.28183-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add function names to the kernel-doc of some functions and upgrade
descriptions of some parameters in it.

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/btrfs/delalloc-space.c |  6 +++---
 fs/btrfs/extent_io.c      | 15 ++++++++-------
 fs/btrfs/space-info.c     | 10 +++++-----
 fs/btrfs/zoned.c          |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index fb46a28f5065..1ca5f96fce66 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -194,7 +194,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 }
 
 /**
- * Release any excessive reservation
+ * btrfs_inode_rsv_release() - Release any excessive reservation
  *
  * @inode:       the inode we need to release from
  * @qgroup_free: free or convert qgroup meta. Unlike normal operation, qgroup
@@ -366,7 +366,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 }
 
 /**
- * Release a metadata reservation for an inode
+ * btrfs_delalloc_release_metadata() - Release a metadata reservation for an inode
  *
  * @inode: the inode to release the reservation for.
  * @num_bytes: the number of bytes we are releasing.
@@ -464,7 +464,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 }
 
 /**
- * Release data and metadata space for delalloc
+ * btrfs_delalloc_release_space() - Release data and metadata space for delalloc
  *
  * @inode:       inode we're releasing space for
  * @reserved:    list of changed/reserved ranges
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9234d96a7fd5..1b38c7e6c900 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -399,7 +399,7 @@ static struct rb_node *tree_insert(struct rb_root *root,
 }
 
 /**
- * Search @tree for an entry that contains @offset. Such entry would have
+ * __etree_search() - Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
  *
  * @tree:       the tree to search
@@ -1598,7 +1598,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 }
 
 /**
- * Find a contiguous area of bits
+ * find_contiguous_extent_bit() - Find a contiguous area of bits
  *
  * @tree:      io tree to check
  * @start:     offset to start the search from
@@ -1636,7 +1636,8 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 }
 
 /**
- * Find the first range that has @bits not set. This range could start before
+ * find_first_clear_extent_bit() - Find the first range that has @bits not set.
+ *				   This range could start before.
  * @start.
  *
  * @tree:      the tree to search
@@ -3185,15 +3186,14 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 }
 
 /**
- * Attempt to add a page to bio
+ * btrfs_bio_add_page() - Attempt to add a page to bio
  *
- * @bio:	destination bio
+ * @bio_ctrl:	record both the bio, and its bio_flags
  * @page:	page to add to the bio
  * @disk_bytenr:  offset of the new bio or to check whether we are adding
  *                a contiguous page to the previous one
  * @pg_offset:	starting offset in the page
  * @size:	portion of page that we want to write
- * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
  * @bio_flags:	flags of the current bio to see if we can merge them
  *
  * Attempt to add a page to bio considering stripe alignment etc.
@@ -4933,7 +4933,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 }
 
 /**
- * Walk the list of dirty pages of the given address space and write all of them.
+ * extent_write_cache_pages() - Walk the list of dirty pages of the given
+ *				address space and write all of them.
  *
  * @mapping: address space structure to write
  * @wbc:     subtract the number of written pages from *@wbc->nr_to_write
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index dbf8bfb8fcb3..86da4310a07a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1362,7 +1362,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * Do the appropriate flushing and waiting for a ticket
+ * handle_reserve_ticket() - Do the appropriate flushing and waiting for a ticket
  *
  * @fs_info:    the filesystem
  * @space_info: space info for the reservation
@@ -1455,7 +1455,7 @@ static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
 }
 
 /**
- * Try to reserve bytes from the block_rsv's space
+ * __reserve_bytes() - Try to reserve bytes from the block_rsv's space
  *
  * @fs_info:    the filesystem
  * @space_info: space info we want to allocate from
@@ -1581,9 +1581,9 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * Trye to reserve metadata bytes from the block_rsv's space
+ * btrfs_reserve_metadata_bytes() - Trye to reserve metadata bytes from the block_rsv's space
  *
- * @root:       the root we're allocating for
+ * @fs_info:    the filesystem
  * @block_rsv:  block_rsv we're allocating for
  * @orig_bytes: number of bytes we want
  * @flush:      whether or not we can flush to make our reservation
@@ -1616,7 +1616,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * Try to reserve data bytes for an allocation
+ * btrfs_reserve_data_bytes() - Try to reserve data bytes for an allocation
  *
  * @fs_info: the filesystem
  * @bytes:   number of bytes we need
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6b3d7b65368b..cdc952bcfb9d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1781,7 +1781,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 }
 
 /**
- * Activate block group and underlying device zones
+ * btrfs_zone_activate() - Activate block group and underlying device zones
  *
  * @block_group: the block group to activate
  *
-- 
2.20.1.7.g153144c

