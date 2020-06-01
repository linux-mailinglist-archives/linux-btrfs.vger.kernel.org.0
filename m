Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460F1EA715
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgFAPiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgFAPhz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3665DB215;
        Mon,  1 Jun 2020 15:37:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 35/46] btrfs: Make btrfs_set_extent_delalloc take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:33 +0300
Message-Id: <20200601153744.31891-36-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation to make btrfs_dirty_pages take btrfs_inode as parameter.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h             |  2 +-
 fs/btrfs/file.c              |  4 ++--
 fs/btrfs/inode.c             | 12 ++++++------
 fs/btrfs/reflink.c           |  3 ++-
 fs/btrfs/relocation.c        |  4 ++--
 fs/btrfs/tests/inode-tests.c | 14 +++++++-------
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e6f47bdf6f0a..05a7cef660fc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2874,7 +2874,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,

 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
-int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
+int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 01745c0651cb..aa43d77bfd98 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -546,8 +546,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 		}
 	}

-	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
-					extra_bits, cached);
+	err = btrfs_set_extent_delalloc(BTRFS_I(inode), start_pos,
+					end_of_last_block, extra_bits, cached);
 	if (err)
 		return err;

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 331a576170c0..ed9ecb46208f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2243,13 +2243,13 @@ static noinline int add_pending_csums(struct btrfs_trans_handle *trans,
 	return 0;
 }

-int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
+int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state)
 {
 	WARN_ON(PAGE_ALIGNED(end));
-	return set_extent_delalloc(&BTRFS_I(inode)->io_tree, start, end,
-				   extra_bits, cached_state);
+	return set_extent_delalloc(&inode->io_tree, start, end, extra_bits,
+				   cached_state);
 }

 /* see btrfs_writepage_start_hook for details on why this is required */
@@ -2346,7 +2346,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		goto again;
 	}

-	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, page_end, 0,
 					&cached_state);
 	if (ret)
 		goto out_reserved;
@@ -4551,7 +4551,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, &cached_state);

-	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), block_start, block_end, 0,
 					&cached_state);
 	if (ret) {
 		unlock_extent_cached(io_tree, block_start, block_end,
@@ -8162,7 +8162,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			  EXTENT_DEFRAG, 0, 0, &cached_state);

-	ret2 = btrfs_set_extent_delalloc(inode, page_start, end, 0,
+	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
 	if (ret2) {
 		unlock_extent_cached(io_tree, page_start, page_end,
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 040009d1cc31..fe3e05b51691 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -84,7 +84,8 @@ static int copy_inline_to_page(struct inode *inode,
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, file_offset, range_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, NULL);
-	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), file_offset, range_end,
+					0, NULL);
 	if (ret)
 		goto out_unlock;

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3d708a929b04..fb1a4af8d307 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2762,8 +2762,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 			nr++;
 		}

-		ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
-						NULL);
+		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start,
+						page_end, 0, NULL);
 		if (ret) {
 			unlock_page(page);
 			put_page(page);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 24a8c714f56c..894a63a92236 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -954,8 +954,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	btrfs_test_inode_set_ops(inode);

 	/* [BTRFS_MAX_EXTENT_SIZE] */
-	ret = btrfs_set_extent_delalloc(inode, 0, BTRFS_MAX_EXTENT_SIZE - 1, 0,
-					NULL);
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), 0,
+					BTRFS_MAX_EXTENT_SIZE - 1, 0, NULL);
 	if (ret) {
 		test_err("btrfs_set_extent_delalloc returned %d", ret);
 		goto out;
@@ -968,7 +968,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}

 	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
-	ret = btrfs_set_extent_delalloc(inode, BTRFS_MAX_EXTENT_SIZE,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE,
 					BTRFS_MAX_EXTENT_SIZE + sectorsize - 1,
 					0, NULL);
 	if (ret) {
@@ -999,7 +999,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}

 	/* [BTRFS_MAX_EXTENT_SIZE][sectorsize] */
-	ret = btrfs_set_extent_delalloc(inode, BTRFS_MAX_EXTENT_SIZE >> 1,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), BTRFS_MAX_EXTENT_SIZE >> 1,
 					(BTRFS_MAX_EXTENT_SIZE >> 1)
 					+ sectorsize - 1,
 					0, NULL);
@@ -1017,7 +1017,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	/*
 	 * [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize HOLE][BTRFS_MAX_EXTENT_SIZE+sectorsize]
 	 */
-	ret = btrfs_set_extent_delalloc(inode,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
 			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize,
 			(BTRFS_MAX_EXTENT_SIZE << 1) + 3 * sectorsize - 1,
 			0, NULL);
@@ -1035,7 +1035,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	/*
 	* [BTRFS_MAX_EXTENT_SIZE+sectorsize][sectorsize][BTRFS_MAX_EXTENT_SIZE+sectorsize]
 	*/
-	ret = btrfs_set_extent_delalloc(inode,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
 			BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
@@ -1069,7 +1069,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	 * Refill the hole again just for good measure, because I thought it
 	 * might fail and I'd rather satisfy my paranoia at this point.
 	 */
-	ret = btrfs_set_extent_delalloc(inode,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode),
 			BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1, 0, NULL);
 	if (ret) {
--
2.17.1

