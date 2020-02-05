Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80302153749
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBESJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 13:09:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:57618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgBESJr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 13:09:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC0FCACE0;
        Wed,  5 Feb 2020 18:09:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 449F4DA735; Wed,  5 Feb 2020 19:09:33 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/8] btrfs: drop argument tree from btrfs_lock_and_flush_ordered_range
Date:   Wed,  5 Feb 2020 19:09:33 +0100
Message-Id: <21ce9d3caeb6e8f303f3a1322a0728ece99d5bab.1580925977.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580925977.git.dsterba@suse.com>
References: <cover.1580925977.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree pointer can be safely read from the inode so we can drop the
redundant argument from btrfs_lock_and_flush_ordered_range.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c    |  4 ++--
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ordered-data.c | 10 +++-------
 fs/btrfs/ordered-data.h |  3 +--
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e9d116ecf5a1..a0a80a151085 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3294,7 +3294,7 @@ static inline void contiguous_readpages(struct extent_io_tree *tree,
 
 	ASSERT(tree == &inode->io_tree);
 
-	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
 		__do_readpage(tree, pages[index], btrfs_get_extent, em_cached,
@@ -3317,7 +3317,7 @@ static int __extent_read_full_page(struct extent_io_tree *tree,
 
 	ASSERT(tree == &inode->io_tree);
 
-	btrfs_lock_and_flush_ordered_range(tree, inode, start, end, NULL);
+	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = __do_readpage(tree, page, get_extent, NULL, bio, mirror_num,
 			    bio_flags, read_flags, NULL);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 746d569d234e..b03651ea1896 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1560,7 +1560,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	lockend = round_up(pos + *write_bytes,
 			   fs_info->sectorsize) - 1;
 
-	btrfs_lock_and_flush_ordered_range(&inode->io_tree, inode, lockstart,
+	btrfs_lock_and_flush_ordered_range(inode, lockstart,
 					   lockend, NULL);
 
 	num_bytes = lockend - lockstart + 1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5c897d8c9506..29b06c109137 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4611,7 +4611,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 	if (size <= hole_start)
 		return 0;
 
-	btrfs_lock_and_flush_ordered_range(io_tree, BTRFS_I(inode), hole_start,
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), hole_start,
 					   block_end - 1, &cached_state);
 	cur_offset = hole_start;
 	while (1) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ad471a2fba93..d3f2f274e28d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -830,7 +830,6 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
  * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
  * ordered extents in it are run to completion.
  *
- * @tree:         IO tree used for locking out other users of the range
  * @inode:        Inode whose ordered tree is to be searched
  * @start:        Beginning of range to flush
  * @end:          Last byte of range to lock
@@ -840,8 +839,7 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
  * This function always returns with the given range locked, ensuring after it's
  * called no order extent can be pending.
  */
-void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
-					struct btrfs_inode *inode, u64 start,
+void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state)
 {
@@ -849,13 +847,11 @@ void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 	struct extent_state *cache = NULL;
 	struct extent_state **cachedp = &cache;
 
-	ASSERT(tree == &inode->io_tree);
-
 	if (cached_state)
 		cachedp = cached_state;
 
 	while (1) {
-		lock_extent_bits(tree, start, end, cachedp);
+		lock_extent_bits(&inode->io_tree, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -868,7 +864,7 @@ void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
 				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent_cached(tree, start, end, cachedp);
+		unlock_extent_cached(&inode->io_tree, start, end, cachedp);
 		btrfs_start_ordered_extent(&inode->vfs_inode, ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 	}
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index a46f319d9ae0..c01c9698250b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -183,8 +183,7 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			      const u64 range_start, const u64 range_len);
-void btrfs_lock_and_flush_ordered_range(struct extent_io_tree *tree,
-					struct btrfs_inode *inode, u64 start,
+void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
 int __init ordered_data_init(void);
-- 
2.25.0

