Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501D71EC903
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCFzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:42380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgFCFzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E983CAE96;
        Wed,  3 Jun 2020 05:55:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/46] btrfs: Make __btrfs_add_ordered_extent take struct btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:01 +0300
Message-Id: <20200603055546.3889-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is internal btrfs function what really needs the vfs_inode only for
igrab and a tracepoint.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ordered-data.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e13b3d28c063..7bf7edbb994c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -157,18 +157,17 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
  * The tree is given a single reference on the ordered extent that was
  * inserted.
  */
-static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
+static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 				      u64 disk_bytenr, u64 num_bytes,
 				      u64 disk_num_bytes, int type, int dio,
 				      int compress_type)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ordered_inode_tree *tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry;

-	tree = &BTRFS_I(inode)->ordered_tree;
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry)
 		return -ENOMEM;
@@ -178,7 +177,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	entry->num_bytes = num_bytes;
 	entry->disk_num_bytes = disk_num_bytes;
 	entry->bytes_left = num_bytes;
-	entry->inode = igrab(inode);
+	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
@@ -200,7 +199,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	INIT_LIST_HEAD(&entry->log_list);
 	INIT_LIST_HEAD(&entry->trans_list);

-	trace_btrfs_ordered_extent_add(inode, entry);
+	trace_btrfs_ordered_extent_add(&inode->vfs_inode, entry);

 	spin_lock_irq(&tree->lock);
 	node = tree_insert(&tree->tree, file_offset,
@@ -228,9 +227,9 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	 * that work has been done at higher layers, so this is truly the
 	 * smallest the extent is going to get.
 	 */
-	spin_lock(&BTRFS_I(inode)->lock);
-	btrfs_mod_outstanding_extents(BTRFS_I(inode), 1);
-	spin_unlock(&BTRFS_I(inode)->lock);
+	spin_lock(&inode->lock);
+	btrfs_mod_outstanding_extents(inode, 1);
+	spin_unlock(&inode->lock);

 	return 0;
 }
@@ -239,7 +238,7 @@ int btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 0,
 					  BTRFS_COMPRESS_NONE);
 }
@@ -248,7 +247,7 @@ int btrfs_add_ordered_extent_dio(struct inode *inode, u64 file_offset,
 				 u64 disk_bytenr, u64 num_bytes,
 				 u64 disk_num_bytes, int type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 1,
 					  BTRFS_COMPRESS_NONE);
 }
@@ -258,7 +257,7 @@ int btrfs_add_ordered_extent_compress(struct inode *inode, u64 file_offset,
 				      u64 disk_num_bytes, int type,
 				      int compress_type)
 {
-	return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr,
+	return __btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, disk_bytenr,
 					  num_bytes, disk_num_bytes, type, 0,
 					  compress_type);
 }
--
2.17.1

