Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10B51EC921
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFCF4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgFCF4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:56:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 858A0B004;
        Wed,  3 Jun 2020 05:56:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 40/46] btrfs: Make btrfs_delalloc_release_space take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:40 +0300
Message-Id: <20200603055546.3889-41-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It needs btrfs_inode so take it as a parameter directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c |  6 +++---
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/file.c           |  5 +++--
 fs/btrfs/inode.c          | 28 +++++++++++++++-------------
 fs/btrfs/ioctl.c          |  4 ++--
 fs/btrfs/reflink.c        |  4 ++--
 6 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bf5420ad3af5..776e671902bf 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -582,10 +582,10 @@ int btrfs_delalloc_reserve_space(struct inode *inode,
  * list if there are no delalloc bytes left.
  * Also it will handle the qgroup reserved space.
  */
-void btrfs_delalloc_release_space(struct inode *inode,
+void btrfs_delalloc_release_space(struct btrfs_inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free)
 {
-	btrfs_delalloc_release_metadata(BTRFS_I(inode), len, qgroup_free);
-	btrfs_free_reserved_data_space(BTRFS_I(inode), reserved, start, len);
+	btrfs_delalloc_release_metadata(inode, len, qgroup_free);
+	btrfs_free_reserved_data_space(inode, reserved, start, len);
 }
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 16a6f9320e39..853a9ac3de35 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -10,7 +10,7 @@ int btrfs_check_data_free_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
 void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len);
-void btrfs_delalloc_release_space(struct inode *inode,
+void btrfs_delalloc_release_space(struct btrfs_inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
 void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 71e055800609..3a8b8bda9824 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1732,7 +1732,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 				__pos = round_down(pos,
 						   fs_info->sectorsize) +
 					(dirty_pages << PAGE_SHIFT);
-				btrfs_delalloc_release_space(inode,
+				btrfs_delalloc_release_space(BTRFS_I(inode),
 						data_reserved, __pos,
 						release_bytes, true);
 			}
@@ -1800,7 +1800,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
-			btrfs_delalloc_release_space(inode, data_reserved,
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					data_reserved,
 					round_down(pos, fs_info->sectorsize),
 					release_bytes, true);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7c9fc5b0f894..687b06458f1a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2312,7 +2312,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		if (!ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       PAGE_SIZE);
-			btrfs_delalloc_release_space(inode, data_reserved,
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+						     data_reserved,
 						     page_start, PAGE_SIZE,
 						     true);
 		}
@@ -2362,8 +2363,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 out_reserved:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	if (free_delalloc_space)
-		btrfs_delalloc_release_space(inode, data_reserved, page_start,
-					     PAGE_SIZE, true);
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
+					     page_start, PAGE_SIZE, true);
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			     &cached_state);
 out_page:
@@ -4510,7 +4511,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 again:
 	page = find_or_create_page(mapping, index, mask);
 	if (!page) {
-		btrfs_delalloc_release_space(inode, data_reserved,
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
 					     block_start, blocksize, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
 		ret = -ENOMEM;
@@ -4577,8 +4578,8 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,

 out_unlock:
 	if (ret)
-		btrfs_delalloc_release_space(inode, data_reserved, block_start,
-					     blocksize, true);
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
+					     block_start, blocksize, true);
 	btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
 	unlock_page(page);
 	put_page(page);
@@ -7393,8 +7394,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 			     &cached_state);
 err:
 	if (dio_data) {
-		btrfs_delalloc_release_space(inode, dio_data->data_reserved,
-				start, dio_data->reserve, true);
+		btrfs_delalloc_release_space(BTRFS_I(inode),
+					     dio_data->data_reserved,
+					     start, dio_data->reserve, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->reserve);
 		extent_changeset_free(dio_data->data_reserved);
 		kfree(dio_data);
@@ -7430,7 +7432,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,

 	if (write) {
 		if (dio_data->reserve)
-			btrfs_delalloc_release_space(inode,
+			btrfs_delalloc_release_space(BTRFS_I(inode),
 					dio_data->data_reserved, pos,
 					dio_data->reserve, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), dio_data->length);
@@ -8144,9 +8146,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 					  fs_info->sectorsize);
 		if (reserved_space < PAGE_SIZE) {
 			end = page_start + reserved_space - 1;
-			btrfs_delalloc_release_space(inode, data_reserved,
-					page_start, PAGE_SIZE - reserved_space,
-					true);
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					data_reserved, page_start,
+					PAGE_SIZE - reserved_space, true);
 		}
 	}

@@ -8201,7 +8203,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	unlock_page(page);
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-	btrfs_delalloc_release_space(inode, data_reserved, page_start,
+	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
 				     reserved_space, (ret != 0));
 out_noreserve:
 	sb_end_pagefault(inode->i_sb);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4dc308048d8c..37072628149d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1333,7 +1333,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		spin_lock(&BTRFS_I(inode)->lock);
 		btrfs_mod_outstanding_extents(BTRFS_I(inode), 1);
 		spin_unlock(&BTRFS_I(inode)->lock);
-		btrfs_delalloc_release_space(inode, data_reserved,
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
 				start_index << PAGE_SHIFT,
 				(page_cnt - i_done) << PAGE_SHIFT, true);
 	}
@@ -1361,7 +1361,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		unlock_page(pages[i]);
 		put_page(pages[i]);
 	}
-	btrfs_delalloc_release_space(inode, data_reserved,
+	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
 			start_index << PAGE_SHIFT,
 			page_cnt << PAGE_SHIFT, true);
 	btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_SHIFT);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index fe3e05b51691..9da0f101548f 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -134,8 +134,8 @@ static int copy_inline_to_page(struct inode *inode,
 		put_page(page);
 	}
 	if (ret)
-		btrfs_delalloc_release_space(inode, data_reserved, file_offset,
-					     block_size, true);
+		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
+					     file_offset, block_size, true);
 	btrfs_delalloc_release_extents(BTRFS_I(inode), block_size);
 out:
 	extent_changeset_free(data_reserved);
--
2.17.1

