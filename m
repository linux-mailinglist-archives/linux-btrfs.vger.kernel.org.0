Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46A26BCDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfGQNSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 09:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQNSW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 09:18:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47112B15E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 13:18:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Remove leftover  of in-band dedupe
Date:   Wed, 17 Jul 2019 16:18:17 +0300
Message-Id: <20190717131817.8567-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717131817.8567-1-nborisov@suse.com>
References: <20190717131817.8567-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's unlikely in-band dedupe is going to land so just remove any
leftovers - dedupe.h header as well as the 'dedupe' parameter to
btrfs_set_extent_delalloc.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h             |  2 +-
 fs/btrfs/dedupe.h            | 12 ------------
 fs/btrfs/file.c              |  2 +-
 fs/btrfs/inode.c             | 25 ++++++++++---------------
 fs/btrfs/relocation.c        |  2 +-
 fs/btrfs/tests/inode-tests.c | 12 ++++++------
 6 files changed, 19 insertions(+), 36 deletions(-)
 delete mode 100644 fs/btrfs/dedupe.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c04a23384210..38aab3db5377 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3147,7 +3147,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
 int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
-			      struct extent_state **cached_state, int dedupe);
+			      struct extent_state **cached_state);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
 			     struct btrfs_root *parent_root,
diff --git a/fs/btrfs/dedupe.h b/fs/btrfs/dedupe.h
deleted file mode 100644
index 90281a7a35a8..000000000000
--- a/fs/btrfs/dedupe.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2016 Fujitsu.  All rights reserved.
- */
-
-#ifndef BTRFS_DEDUPE_H
-#define BTRFS_DEDUPE_H
-
-/* later in-band dedupe will expand this struct */
-struct btrfs_dedupe_hash;
-
-#endif
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c043dc9a6e43..7d445c600298 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -559,7 +559,7 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 	}
 
 	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
-					extra_bits, cached, 0);
+					extra_bits, cached);
 	if (err)
 		return err;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6dc06fee3a46..44102c18bbe7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -46,7 +46,6 @@
 #include "backref.h"
 #include "props.h"
 #include "qgroup.h"
-#include "dedupe.h"
 #include "delalloc-space.h"
 
 struct btrfs_iget_args {
@@ -81,8 +80,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 static noinline int cow_file_range(struct inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock,
-				   struct btrfs_dedupe_hash *hash);
+				   unsigned long *nr_written, int unlock);
 static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 				       u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
@@ -741,8 +739,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 					     async_extent->start,
 					     async_extent->start +
 					     async_extent->ram_size - 1,
-					     &page_started, &nr_written, 0,
-					     NULL);
+					     &page_started, &nr_written, 0);
 
 			/* JDM XXX */
 
@@ -927,8 +924,7 @@ static u64 get_extent_allocation_hint(struct inode *inode, u64 start,
 static noinline int cow_file_range(struct inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock,
-				   struct btrfs_dedupe_hash *hash)
+				   unsigned long *nr_written, int unlock)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -1485,8 +1481,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		if (cow_start != (u64)-1) {
 			ret = cow_file_range(inode, locked_page,
 					     cow_start, found_key.offset - 1,
-					     page_started, nr_written, 1,
-					     NULL);
+					     page_started, nr_written, 1);
 			if (ret) {
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
@@ -1565,7 +1560,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
 		ret = cow_file_range(inode, locked_page, cow_start, end,
-				     page_started, nr_written, 1, NULL);
+				     page_started, nr_written, 1);
 		if (ret)
 			goto error;
 	}
@@ -1623,7 +1618,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 					 page_started, 0, nr_written);
 	} else if (!inode_need_compress(inode, start, end)) {
 		ret = cow_file_range(inode, locked_page, start, end,
-				      page_started, nr_written, 1, NULL);
+				      page_started, nr_written, 1);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 			&BTRFS_I(inode)->runtime_flags);
@@ -2058,7 +2053,7 @@ static noinline int add_pending_csums(struct btrfs_trans_handle *trans,
 
 int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
-			      struct extent_state **cached_state, int dedupe)
+			      struct extent_state **cached_state)
 {
 	WARN_ON(PAGE_ALIGNED(end));
 	return set_extent_delalloc(&BTRFS_I(inode)->io_tree, start, end,
@@ -2124,7 +2119,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 }
 
 	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
-					&cached_state, 0);
+					&cached_state);
 	if (ret) {
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
@@ -4919,7 +4914,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			  0, 0, &cached_state);
 
 	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
-					&cached_state, 0);
+					&cached_state);
 	if (ret) {
 		unlock_extent_cached(io_tree, block_start, block_end,
 				     &cached_state);
@@ -9004,7 +8999,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			  0, 0, &cached_state);
 
 	ret2 = btrfs_set_extent_delalloc(inode, page_start, end, 0,
-					&cached_state, 0);
+					&cached_state);
 	if (ret2) {
 		unlock_extent_cached(io_tree, page_start, page_end,
 				     &cached_state);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..7ec632d4d960 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3311,7 +3311,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 
 		ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
-						NULL, 0);
+						NULL);
 		if (ret) {
 			unlock_page(page);
 			put_page(page);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index bc6dbd1b42fd..b363fb990cec 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -957,7 +957,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* [BTRFS_MAX_EXTENT_SIZE] */
 	ret = btrfs_set_extent_delalloc(inode, 0, BTRFS_MAX_EXTENT_SIZE - 1, 0,
-					NULL, 0);
+					NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -972,7 +972,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
 	ret = btrfs_set_extent_delalloc(inode, BTRFS_MAX_EXTENT_SIZE,
 					BTRFS_MAX_EXTENT_SIZE + sectorsize - 1,
-					0, NULL, 0);
+					0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1005,7 +1005,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = btrfs_set_extent_delalloc(inode, BTRFS_MAX_EXTENT_SIZE >> 1,
 					(BTRFS_MAX_EXTENT_SIZE >> 1)
 					+ sectorsize - 1,
-					0, NULL, 0);
+					0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1023,7 +1023,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = btrfs_set_extent_delalloc(inode,
 			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize,
 			(BTRFS_MAX_EXTENT_SIZE << 1) + 3 * sectorsize - 1,
-			0, NULL, 0);
+			0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1040,7 +1040,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	*/
 	ret = btrfs_set_extent_delalloc(inode,
 			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL, 0);
+			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -1075,7 +1075,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	 */
 	ret = btrfs_set_extent_delalloc(inode,
 			BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL, 0);
+			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
-- 
2.17.1

