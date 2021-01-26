Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9A303580
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 06:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbhAZFoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:44:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732990AbhAZBYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 20:24:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611621349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oBXHXc7lbEszSRQf2EXXx0E75Oso1AStvYzCxGZFvdY=;
        b=meXn0ncy4x5RocLqGR8+p64Rdm5+t0w3qdNs+MNgkuwmMi5NO4+GiQSldtziIQnE0P17qL
        ndPkZF1PiajhgWcCWb2qYc6nbuMPjCdcPvqiGD/hYGU5TxlHhrIUMF/a+HZtwVv6WETw+u
        PwslSsxku8/YDOVwSfwJ6dV0E7qyJ9s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77C5BADC4;
        Tue, 26 Jan 2021 00:35:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: rework the order of btrfs_ordered_extent::flags
Date:   Tue, 26 Jan 2021 08:35:45 +0800
Message-Id: <20210126003545.8885-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a long existing bug in the last parameter of
btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
compressed writeback and reads") back to 2008.

In that ancient commit btrfs_add_ordered_extent() expects the @type
parameter to be one of the following:
- BTRFS_ORDERED_REGULAR
- BTRFS_ORDERED_NOCOW
- BTRFS_ORDERED_PREALLOC
- BTRFS_ORDERED_COMPRESSED

But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.

Ironically extra check in __btrfs_add_ordered_extent() won't set the bit
if we're seeing (type == IO_DONE || type == IO_COMPLETE), and avoid any
obvious bug.

But this still leads to regular COW ordered extent having no bit to
indicate its type in various trace events, rendering REGULAR bit
useless.

[FIX]
This patch will change the following aspects to avoid such problem:
- Reorder btrfs_ordered_extent::flags
  Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
  DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.

- Add extra ASSERT() for btrfs_add_ordered_extent_*()

- Remove @type parameter for btrfs_add_ordered_extent_compress()
  As the only valid @type here is BTRFS_ORDERED_COMPRESSED.

- Remove the unnecessary special check for IO_DONE/COMPLETE in
  __btrfs_add_ordered_extent()
  This is just to make the code work, with extra ASSERT(), there are
  limited values can be passed in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Put ASSERT() on type check to separate line for each condition
- Unify DirectIO/DIO to "direct IO"
- Update comment on ordered extent type bits
---
 fs/btrfs/inode.c             |  4 ++--
 fs/btrfs/ordered-data.c      | 21 +++++++++++++++-----
 fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++-------------
 include/trace/events/btrfs.h |  7 ++++---
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef6cb7b620d0..ea9056cc5559 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 						ins.objectid,
 						async_extent->ram_size,
 						ins.offset,
-						BTRFS_ORDERED_COMPRESSED,
 						async_extent->compress_type);
 		if (ret) {
 			btrfs_drop_extent_cache(inode, async_extent->start,
@@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
-					       ram_size, cur_alloc_size, 0);
+					       ram_size, cur_alloc_size,
+					       BTRFS_ORDERED_REGULAR);
 		if (ret)
 			goto out_drop_extent_cache;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index d5d326c674b1..b4e6500548a2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,8 +199,12 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
-	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
-		set_bit(type, &entry->flags);
+
+	ASSERT(type == BTRFS_ORDERED_REGULAR ||
+	       type == BTRFS_ORDERED_NOCOW ||
+	       type == BTRFS_ORDERED_PREALLOC ||
+	       type == BTRFS_ORDERED_COMPRESSED);
+	set_bit(type, &entry->flags);
 
 	if (dio) {
 		percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
@@ -256,6 +260,9 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type)
 {
+	ASSERT(type == BTRFS_ORDERED_REGULAR ||
+	       type == BTRFS_ORDERED_NOCOW ||
+	       type == BTRFS_ORDERED_PREALLOC);
 	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 0,
 					  BTRFS_COMPRESS_NONE);
@@ -265,6 +272,9 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
 				 u64 disk_bytenr, u64 num_bytes,
 				 u64 disk_num_bytes, int type)
 {
+	ASSERT(type == BTRFS_ORDERED_REGULAR ||
+	       type == BTRFS_ORDERED_NOCOW ||
+	       type == BTRFS_ORDERED_PREALLOC);
 	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 1,
 					  BTRFS_COMPRESS_NONE);
@@ -272,11 +282,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
 
 int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
 				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type,
-				      int compress_type)
+				      u64 disk_num_bytes, int compress_type)
 {
+	ASSERT(compress_type != BTRFS_COMPRESS_NONE);
 	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
-					  num_bytes, disk_num_bytes, type, 0,
+					  num_bytes, disk_num_bytes,
+					  BTRFS_ORDERED_COMPRESSED, 0,
 					  compress_type);
 }
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 46194c2c05d4..673a030714a8 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
 };
 
 /*
- * bits for the flags field:
+ * Bits for btrfs_ordered_extent::flags.
  *
  * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
  * It is used to make sure metadata is inserted into the tree only once
@@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
  * IO is done and any metadata is inserted into the tree.
  */
 enum {
+	/*
+	 * Different types for ordered extent, one and only one of the 4 types
+	 * can be set when creating ordered extent.
+	 *
+	 * REGULAR:	For regular non-compressed COW write
+	 * NOCOW:	For NOCOW write into existing non-hole extent
+	 * PREALLOC:	For NOCOW write into preallocated extent
+	 * COMPRESSED:	For compressed COW write
+	 */
+	BTRFS_ORDERED_REGULAR,
+	BTRFS_ORDERED_NOCOW,
+	BTRFS_ORDERED_PREALLOC,
+	BTRFS_ORDERED_COMPRESSED,
+
+	/*
+	 * Extra bit for direct IO, can only be set for
+	 * REGULAR/NOCOW/PREALLOC. No direct IO for compressed extent.
+	 */
+	BTRFS_ORDERED_DIRECT,
+
+	/* Extra status bits for ordered extents */
+
 	/* set when all the pages are written */
 	BTRFS_ORDERED_IO_DONE,
 	/* set when removed from the tree */
 	BTRFS_ORDERED_COMPLETE,
-	/* set when we want to write in place */
-	BTRFS_ORDERED_NOCOW,
-	/* writing a zlib compressed extent */
-	BTRFS_ORDERED_COMPRESSED,
-	/* set when writing to preallocated extent */
-	BTRFS_ORDERED_PREALLOC,
-	/* set when we're doing DIO with this extent */
-	BTRFS_ORDERED_DIRECT,
 	/* We had an io error when writing this out */
 	BTRFS_ORDERED_IOERR,
 	/* Set when we have to truncate an extent */
 	BTRFS_ORDERED_TRUNCATED,
-	/* Regular IO for COW */
-	BTRFS_ORDERED_REGULAR,
 	/* Used during fsync to track already logged extents */
 	BTRFS_ORDERED_LOGGED,
 	/* We have already logged all the csums of the ordered extent */
@@ -167,8 +179,7 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *inode, u64 file_offset,
 				 u64 disk_num_bytes, int type);
 int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 file_offset,
 				      u64 disk_bytenr, u64 num_bytes,
-				      u64 disk_num_bytes, int type,
-				      int compress_type);
+				      u64 disk_num_bytes, int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ecd24c719de4..b9896fc06160 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -499,12 +499,13 @@ DEFINE_EVENT(
 
 #define show_ordered_flags(flags)					   \
 	__print_flags(flags, "|",					   \
-		{ (1 << BTRFS_ORDERED_IO_DONE), 	"IO_DONE" 	}, \
-		{ (1 << BTRFS_ORDERED_COMPLETE), 	"COMPLETE" 	}, \
+		{ (1 << BTRFS_ORDERED_REGULAR), 	"REGULAR" 	}, \
 		{ (1 << BTRFS_ORDERED_NOCOW), 		"NOCOW" 	}, \
-		{ (1 << BTRFS_ORDERED_COMPRESSED), 	"COMPRESSED" 	}, \
 		{ (1 << BTRFS_ORDERED_PREALLOC), 	"PREALLOC" 	}, \
+		{ (1 << BTRFS_ORDERED_COMPRESSED), 	"COMPRESSED" 	}, \
 		{ (1 << BTRFS_ORDERED_DIRECT),	 	"DIRECT" 	}, \
+		{ (1 << BTRFS_ORDERED_IO_DONE), 	"IO_DONE" 	}, \
+		{ (1 << BTRFS_ORDERED_COMPLETE), 	"COMPLETE" 	}, \
 		{ (1 << BTRFS_ORDERED_IOERR), 		"IOERR" 	}, \
 		{ (1 << BTRFS_ORDERED_TRUNCATED), 	"TRUNCATED"	})
 
-- 
2.30.0

