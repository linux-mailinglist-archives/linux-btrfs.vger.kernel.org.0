Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103C81EA6FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFAPhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgFAPht (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57D06B20D;
        Mon,  1 Jun 2020 15:37:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/46] btrfs: Make btrfs_reloc_clone_csums take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:02 +0300
Message-Id: <20200601153744.31891-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It really wants btrfs_inode and not a vfs inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h      | 2 +-
 fs/btrfs/inode.c      | 4 ++--
 fs/btrfs/relocation.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..3e8063f9b30a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3380,7 +3380,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 int btrfs_recover_relocation(struct btrfs_root *root);
-int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len);
+int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, struct extent_buffer *buf,
 			  struct extent_buffer *cow);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09a0c6a9a73a..56015fdd46c9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1067,7 +1067,7 @@ static noinline int cow_file_range(struct inode *inode,

 		if (root->root_key.objectid ==
 		    BTRFS_DATA_RELOC_TREE_OBJECTID) {
-			ret = btrfs_reloc_clone_csums(inode, start,
+			ret = btrfs_reloc_clone_csums(BTRFS_I(inode), start,
 						      cur_alloc_size);
 			/*
 			 * Only drop cache here, and process as normal.
@@ -1725,7 +1725,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			 * extent_clear_unlock_delalloc() in error handler
 			 * from freeing metadata of created ordered extent.
 			 */
-			ret = btrfs_reloc_clone_csums(inode, cur_offset,
+			ret = btrfs_reloc_clone_csums(BTRFS_I(inode), cur_offset,
 						      num_bytes);

 		extent_clear_unlock_delalloc(inode, cur_offset,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2a49115ee4c6..3d708a929b04 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3872,9 +3872,9 @@ int btrfs_recover_relocation(struct btrfs_root *root)
  * cloning checksum properly handles the nodatasum extents.
  * it also saves CPU time to re-calculate the checksum.
  */
-int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
+int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered;
 	int ret;
@@ -3882,10 +3882,10 @@ int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
 	u64 new_bytenr;
 	LIST_HEAD(list);

-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_pos);
+	ordered = btrfs_lookup_ordered_extent(inode, file_pos);
 	BUG_ON(ordered->file_offset != file_pos || ordered->num_bytes != len);

-	disk_bytenr = file_pos + BTRFS_I(inode)->index_cnt;
+	disk_bytenr = file_pos + inode->index_cnt;
 	ret = btrfs_lookup_csums_range(fs_info->csum_root, disk_bytenr,
 				       disk_bytenr + len - 1, &list, 0);
 	if (ret)
--
2.17.1

