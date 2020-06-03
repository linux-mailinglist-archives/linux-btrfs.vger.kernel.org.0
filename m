Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCED1EC913
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCFz7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgFCFz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2AA5BB011;
        Wed,  3 Jun 2020 05:55:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/46] btrfs: Make btrfs_qgroup_free_data take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:11 +0300
Message-Id: <20200603055546.3889-12-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It passes btrfs_inode to its callee so change the interface.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/inode.c          | 12 +++++++-----
 fs/btrfs/qgroup.c         |  4 ++--
 fs/btrfs/qgroup.h         |  6 +++---
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1245739a3a6e..0ee25dde18d3 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -304,7 +304,7 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 	start = round_down(start, root->fs_info->sectorsize);

 	btrfs_free_reserved_data_space_noquota(inode, start, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
+	btrfs_qgroup_free_data(BTRFS_I(inode), reserved, start, len);
 }

 /**
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 810065cd38a2..70ed320cd1fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -353,7 +353,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(BTRFS_I(inode), NULL, 0, PAGE_SIZE);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -2613,7 +2613,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		 * space for NOCOW range.
 		 * As NOCOW won't cause a new delayed ref, just free the space
 		 */
-		btrfs_qgroup_free_data(inode, NULL, start,
+		btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
 				       ordered_extent->num_bytes);
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
@@ -2651,7 +2651,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 		BUG_ON(compress_type);
-		btrfs_qgroup_free_data(inode, NULL, start,
+		btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
 				       ordered_extent->num_bytes);
 		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
 						ordered_extent->file_offset,
@@ -4948,7 +4948,8 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		 * Note, end is the bytenr of last byte, so we need + 1 here.
 		 */
 		if (state_flags & EXTENT_DELALLOC)
-			btrfs_qgroup_free_data(inode, NULL, start, end - start + 1);
+			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
+					       end - start + 1);

 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_LOCKED | EXTENT_DELALLOC |
@@ -8036,7 +8037,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 *    free the entire extent.
 	 */
 	if (PageDirty(page))
-		btrfs_qgroup_free_data(inode, NULL, page_start, PAGE_SIZE);
+		btrfs_qgroup_free_data(BTRFS_I(inode), NULL, page_start,
+				       PAGE_SIZE);
 	if (!inode_evicting) {
 		clear_extent_bit(tree, page_start, page_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 008e44446bd6..4a09aa2fd975 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3549,10 +3549,10 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
  *
  * NOTE: This function may sleep for memory allocation.
  */
-int btrfs_qgroup_free_data(struct inode *inode,
+int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
-	return __btrfs_qgroup_release_data(BTRFS_I(inode), reserved, start, len, 1);
+	return __btrfs_qgroup_release_data(inode, reserved, start, len, 1);
 }

 /*
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 1bc654459469..a40ea1c187d7 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -347,9 +347,9 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 int btrfs_qgroup_reserve_data(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
 int btrfs_qgroup_release_data(struct inode *inode, u64 start, u64 len);
-int btrfs_qgroup_free_data(struct inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len);
-
+int btrfs_qgroup_free_data(struct btrfs_inode *inode,
+			   struct extent_changeset *reserved, u64 start,
+			   u64 len);
 int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 				enum btrfs_qgroup_rsv_type type, bool enforce);
 /* Reserve metadata space for pertrans and prealloc type */
--
2.17.1

