Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004AE10D358
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfK2JiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 04:38:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:47024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2JiQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 04:38:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62CFFACA5;
        Fri, 29 Nov 2019 09:38:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Opencode ordered_data_tree_panic
Date:   Fri, 29 Nov 2019 11:38:13 +0200
Message-Id: <20191129093813.574-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a simple wrapper over btrfs_panic and is called only once. Just
open code it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c  |  5 +----
 fs/btrfs/ordered-data.c | 10 +---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f68b38f44f0b..ab99ec6e188b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4172,11 +4172,8 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group *cache;
 
 	cache = btrfs_lookup_block_group(fs_info, start);
-	if (!cache) {
-		btrfs_err(fs_info, "Unable to find block group for %llu",
-			  start);
+	if (!cache)
 		return -ENOSPC;
-	}
 
 	btrfs_add_free_space(cache, start, len);
 	btrfs_free_reserved_bytes(cache, len, delalloc);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index fb09bc2f8e4d..ddba2dc34b5a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -52,14 +52,6 @@ static struct rb_node *tree_insert(struct rb_root *root, u64 file_offset,
 	return NULL;
 }
 
-static void ordered_data_tree_panic(struct inode *inode, int errno,
-					       u64 offset)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	btrfs_panic(fs_info, errno,
-		    "Inconsistency in ordered tree at offset %llu", offset);
-}
-
 /*
  * look for a given offset in the tree, and if it can't be found return the
  * first lesser offset
@@ -219,7 +211,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 	node = tree_insert(&tree->tree, file_offset,
 			   &entry->rb_node);
 	if (node)
-		ordered_data_tree_panic(inode, -EEXIST, file_offset);
+		btrfs_panic(fs_info, -EEXIST, "Inconsistency in ordered tree at offset %llu",offset);
 	spin_unlock_irq(&tree->lock);
 
 	spin_lock(&root->ordered_extent_lock);
-- 
2.17.1

