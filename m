Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1A1F4A81
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFJA6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 20:58:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgFJA6H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 20:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9E44ACF2;
        Wed, 10 Jun 2020 00:58:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 4/5] btrfs: change the timing for qgroup reserved space for ordered extents to fix reserved space leak
Date:   Wed, 10 Jun 2020 08:57:50 +0800
Message-Id: <20200610005751.10645-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610005751.10645-1-wqu@suse.com>
References: <20200610005751.10645-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following simple workload from fsstress can lead to qgroup reserved
data space leakage:
  0/0: creat f0 x:0 0 0
  0/0: creat add id=0,parent=-1
  0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
  0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return 25, fallback to stat()
  0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0

This would cause btrfs qgroup to leak 20480 bytes for data reserved
space.
If btrfs qgroup limit is enabled, such leakage can lead to unexpected
early EDQUOT and unusable space.

[CAUSE]
When doing direct IO, kernel will try to writeback existing buffered
page cache, then invalidate them:
  iomap_dio_rw()
  |- filemap_write_and_wait_range();
  |- invalidate_inode_pages2_range();

However for btrfs, the bi_end_io hook doesn't finish all its heavy work
right after bio ends.
In fact, it delays its work further:
  submit_extent_page(end_io_func=end_bio_extent_writepage);
  end_bio_extent_writepage()
  |- btrfs_writepage_endio_finish_ordered()
     |- btrfs_init_work(finish_ordered_fn);

  <<< Work queue execution >>>
  finish_ordered_fn()
  |- btrfs_finish_ordered_io();
     |- Clear qgroup bits

This means, when filemap_write_and_wait_range() returns,
btrfs_finish_ordered_io() is not ensured to be executed, thus the
qgroup bits for related range is not cleared.

Now into how the leakage happens, this will only focus on the
overlapping part of buffered and direct IO part.

1. After buffered write
   The inode had the following range with QGROUP_RESERVED bit:
   	596		616K
	|///////////////|
   Qgroup reserved data space: 20K

2. Writeback part for range [596K, 616K)
   Write back finished, but btrfs_finish_ordered_io() not get called
   yet.
   So we still have:
   	596K		616K
	|///////////////|
   Qgroup reserved data space: 20K

3. Pages for range [596K, 616K) get released
   This will clear all qgroup bits, but don't update the reserved data
   space.
   So we have:
   	596K		616K
	|		|
   Qgroup reserved data space: 20K
   That number doesn't match with the qgroup bit range anymore.

4. Dio prepare space for range [596K, 700K)
   Qgroup reserved data space for that range, we got:
   	596K		616K			700K
	|///////////////|///////////////////////|
   Qgroup reserved data space: 20K + 104K = 124K

5. btrfs_finish_ordered_range() get executed for range [596K, 616K)
   Qgroup free reserved space for that range, we got:
   	596K		616K			700K
	|		|///////////////////////|
   We need to free that range of reserved space.
   Qgroup reserved data space: 124K - 20K = 104K

6. btrfs_finish_ordered_range() get executed for range [596K, 700K)
   However qgroup bit for range [596K, 616K) is already cleared in
   previous step, so we only free 84K for qgroup reserved space.
   	596K		616K			700K
	|		|			|
   We need to free that range of reserved space.
   Qgroup reserved data space: 104K - 84K = 20K

   Now there is no way to release that 20K unless disabling qgroup or
   unmount the fs.

[FIX]
This patch will change the timing when btrfs_qgroup_release/free_data()
get called.
Here uses buffered CoW write as an example.

	The new timing			|	The old timing
----------------------------------------+---------------------------------------
 btrfs_buffered_write()			| btrfs_buffered_write()
 |- btrfs_qgroup_reserve_data() 	| |- btrfs_qgroup_reserve_data()
					|
 btrfs_run_delalloc_range()		| btrfs_run_delalloc_range()
 |- btrfs_add_ordered_extent()  	|
    |- btrfs_qgroup_release_data()	|
       The reserved is passed into	|
       btrfs_ordered_extent structure	|
					|
 btrfs_finish_ordered_io()		| btrfs_finish_ordered_io()
 |- The reserved space is passed to 	| |- btrfs_qgroup_release_data()
    btrfs_qgroup_record			|    The resereved space is passed
					|    to btrfs_qgroup_recrod
					|
 btrfs_qgroup_account_extents()		| btrfs_qgroup_account_extents()
 |- btrfs_qgroup_free_refroot()		| |- btrfs_qgroup_free_refroot()

The point of such change is to ensure, when ordered extents are
submitted, the qgroup reserved space is already release, to keep the
timing aligned with file_write_and_wait_range().

So that qgroup data reserved space is all bound to btrfs_ordered_extent
and solve the timing mismatch.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Fixes: f695fdcef83a ("btrfs: qgroup: Introduce functions to release/free qgroup reserve data space")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c        | 15 +--------------
 fs/btrfs/ordered-data.c | 22 +++++++++++++++++++++-
 fs/btrfs/ordered-data.h |  3 +++
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09e1724d620a..094926cc4982 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2543,7 +2543,6 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_file_extent_item stack_fi;
 	u64 logical_len;
-	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
@@ -2559,11 +2558,8 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
 	/* Encryption and other encoding is reserved and all 0 */
 
-	ret = btrfs_qgroup_release_data(inode, oe->file_offset, logical_len);
-	if (ret < 0)
-		return ret;
 	return insert_reserved_file_extent(trans, inode, oe->file_offset,
-					   &stack_fi, ret);
+					   &stack_fi, oe->qgroup_rsv);
 }
 
 /*
@@ -2618,13 +2614,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		BUG_ON(!list_empty(&ordered_extent->list)); /* Logic error */
 
-		/*
-		 * For mwrite(mmap + memset to write) case, we still reserve
-		 * space for NOCOW range.
-		 * As NOCOW won't cause a new delayed ref, just free the space
-		 */
-		btrfs_qgroup_free_data(inode, NULL, start,
-				       ordered_extent->num_bytes);
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
 			trans = btrfs_join_transaction_spacecache(root);
@@ -2661,8 +2650,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 		BUG_ON(compress_type);
-		btrfs_qgroup_free_data(inode, NULL, start,
-				       ordered_extent->num_bytes);
 		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e13b3d28c063..c8bd7a4e67bb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -15,6 +15,7 @@
 #include "disk-io.h"
 #include "compression.h"
 #include "delalloc-space.h"
+#include "qgroup.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
@@ -152,7 +153,8 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	return ret;
 }
 
-/* allocate and add a new ordered_extent into the per-inode tree.
+/*
+ * Allocate and add a new ordered_extent into the per-inode tree.
  *
  * The tree is given a single reference on the ordered extent that was
  * inserted.
@@ -167,7 +169,24 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry;
+	int ret;
 
+	if (type == BTRFS_ORDERED_NOCOW || type == BTRFS_ORDERED_PREALLOC) {
+		/* For nocow write, we can release the qgroup rsv right now */
+		ret = btrfs_qgroup_free_data(inode, NULL, file_offset,
+					     num_bytes);
+		if (ret < 0)
+			return ret;
+		ret = 0;
+	} else {
+		/*
+		 * The ordered extent has reserved qgroup space, release now
+		 * and pass the reserved number for qgroup_record to free.
+		 */
+		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
+		if (ret < 0)
+			return ret;
+	}
 	tree = &BTRFS_I(inode)->ordered_tree;
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry)
@@ -181,6 +200,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	entry->inode = igrab(inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
+	entry->qgroup_rsv = ret;
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
 		set_bit(type, &entry->flags);
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c01c9698250b..4a506c5598f8 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -92,6 +92,9 @@ struct btrfs_ordered_extent {
 	/* compression algorithm */
 	int compress_type;
 
+	/* Qgroup reserved space */
+	int qgroup_rsv;
+
 	/* reference count */
 	refcount_t refs;
 
-- 
2.26.2

