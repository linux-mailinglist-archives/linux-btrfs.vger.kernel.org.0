Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432761EA703
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgFAPhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BD1EB21D;
        Mon,  1 Jun 2020 15:37:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 14/46] btrfs: Make cow_file_range take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:12 +0300
Message-Id: <20200601153744.31891-15-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All its children functions take btrfs_inode so convert it to taking btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 52 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b04e27306058..2ec372c4499c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -79,7 +79,7 @@ struct kmem_cache *btrfs_free_space_bitmap_cachep;
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct inode *inode, bool skip_writeback);
 static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
-static noinline int cow_file_range(struct inode *inode,
+static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
 				   unsigned long *nr_written, int unlock);
@@ -788,7 +788,8 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			unsigned long nr_written = 0;

 			/* allocate blocks */
-			ret = cow_file_range(inode, async_chunk->locked_page,
+			ret = cow_file_range(BTRFS_I(inode),
+					     async_chunk->locked_page,
 					     async_extent->start,
 					     async_extent->start +
 					     async_extent->ram_size - 1,
@@ -975,13 +976,13 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * required to start IO on it.  It may be clean and already done with
  * IO when we return.
  */
-static noinline int cow_file_range(struct inode *inode,
+static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
 				   unsigned long *nr_written, int unlock)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 alloc_hint = 0;
 	u64 num_bytes;
 	unsigned long ram_size;
@@ -994,7 +995,7 @@ static noinline int cow_file_range(struct inode *inode,
 	bool extent_reserved = false;
 	int ret = 0;

-	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
+	if (btrfs_is_free_space_inode(inode)) {
 		WARN_ON_ONCE(1);
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1004,11 +1005,11 @@ static noinline int cow_file_range(struct inode *inode,
 	num_bytes = max(blocksize,  num_bytes);
 	ASSERT(num_bytes <= btrfs_super_total_bytes(fs_info->super_copy));

-	inode_should_defrag(BTRFS_I(inode), start, end, num_bytes, SZ_64K);
+	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);

 	if (start == 0) {
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(BTRFS_I(inode), start, end, 0,
+		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL);
 		if (ret == 0) {
 			/*
@@ -1017,8 +1018,7 @@ static noinline int cow_file_range(struct inode *inode,
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
-				     NULL,
+			extent_clear_unlock_delalloc(inode, start, end, NULL,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1033,10 +1033,8 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 	}

-	alloc_hint = get_extent_allocation_hint(BTRFS_I(inode), start,
-						num_bytes);
-	btrfs_drop_extent_cache(BTRFS_I(inode), start,
-			start + num_bytes - 1, 0);
+	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
+	btrfs_drop_extent_cache(inode, start, start + num_bytes - 1, 0);

 	while (num_bytes > 0) {
 		cur_alloc_size = num_bytes;
@@ -1049,7 +1047,7 @@ static noinline int cow_file_range(struct inode *inode,
 		extent_reserved = true;

 		ram_size = ins.offset;
-		em = create_io_em(BTRFS_I(inode), start, ins.offset, /* len */
+		em = create_io_em(inode, start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
@@ -1063,15 +1061,14 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 		free_extent_map(em);

-		ret = btrfs_add_ordered_extent(BTRFS_I(inode), start,
-					       ins.objectid, ram_size,
-					       cur_alloc_size, 0);
+		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
+					       ram_size, cur_alloc_size, 0);
 		if (ret)
 			goto out_drop_extent_cache;

 		if (root->root_key.objectid ==
 		    BTRFS_DATA_RELOC_TREE_OBJECTID) {
-			ret = btrfs_reloc_clone_csums(BTRFS_I(inode), start,
+			ret = btrfs_reloc_clone_csums(inode, start,
 						      cur_alloc_size);
 			/*
 			 * Only drop cache here, and process as normal.
@@ -1085,7 +1082,7 @@ static noinline int cow_file_range(struct inode *inode,
 			 * skip current ordered extent.
 			 */
 			if (ret)
-				btrfs_drop_extent_cache(BTRFS_I(inode), start,
+				btrfs_drop_extent_cache(inode, start,
 						start + ram_size - 1, 0);
 		}

@@ -1101,8 +1098,7 @@ static noinline int cow_file_range(struct inode *inode,
 		page_ops = unlock ? PAGE_UNLOCK : 0;
 		page_ops |= PAGE_SET_PRIVATE2;

-		extent_clear_unlock_delalloc(BTRFS_I(inode), start,
-					     start + ram_size - 1,
+		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
 					     locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
@@ -1126,7 +1122,7 @@ static noinline int cow_file_range(struct inode *inode,
 	return ret;

 out_drop_extent_cache:
-	btrfs_drop_extent_cache(BTRFS_I(inode), start, start + ram_size - 1, 0);
+	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
 out_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
@@ -1146,7 +1142,7 @@ static noinline int cow_file_range(struct inode *inode,
 	 * it the flag EXTENT_CLEAR_DATA_RESV.
 	 */
 	if (extent_reserved) {
-		extent_clear_unlock_delalloc(BTRFS_I(inode), start,
+		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
 					     locked_page,
 					     clear_bits,
@@ -1155,7 +1151,7 @@ static noinline int cow_file_range(struct inode *inode,
 		if (start >= end)
 			goto out;
 	}
-	extent_clear_unlock_delalloc(BTRFS_I(inode), start, end, locked_page,
+	extent_clear_unlock_delalloc(inode, start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
 	goto out;
@@ -1416,8 +1412,8 @@ static int fallback_to_cow(struct inode *inode, struct page *locked_page,
 					 0, 0, NULL);
 	}

-	return cow_file_range(inode, locked_page, start, end, page_started,
-			      nr_written, 1);
+	return cow_file_range(BTRFS_I(inode), locked_page, start, end,
+			      page_started, nr_written, 1);
 }

 /*
@@ -1820,7 +1816,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 					 page_started, 0, nr_written);
 	} else if (!inode_can_compress(inode) ||
 		   !inode_need_compress(inode, start, end)) {
-		ret = cow_file_range(inode, locked_page, start, end,
+		ret = cow_file_range(BTRFS_I(inode), locked_page, start, end,
 				      page_started, nr_written, 1);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
--
2.17.1

