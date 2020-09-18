Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B426F908
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIRJP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 05:15:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIRJP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 05:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600420554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=p26KxgAozUJ4aNI1BBG7rBkmuXxqTPOnvo64za1y54o=;
        b=QnO4zliGXcZ6b1Z9iGE4MNLtVNXP8sUNFtl2zVgRfflKrS9PUZskrpe+8tgMTpjrDZY7iy
        nQUb+uQufUziQfM0R5iMxU4WB/DTGDHnPWCr4aRpc3/YKVJpLtTvGMqS2BONvW3CHooZhu
        9bq/MaqtjgSs8Jc4ak5kiypWoXAovVo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D669FACBF;
        Fri, 18 Sep 2020 09:16:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/5] btrfs: Clean BTRFS_I usage in btrfs_destroy_inode
Date:   Fri, 18 Sep 2020 12:15:49 +0300
Message-Id: <20200918091553.29584-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918091553.29584-1-nborisov@suse.com>
References: <20200918091553.29584-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 55f3b5dd06f3..6054a80a07bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8642,21 +8642,22 @@ void btrfs_free_inode(struct inode *inode)
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 
-void btrfs_destroy_inode(struct inode *inode)
+void btrfs_destroy_inode(struct inode *vfs_inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_extent *ordered;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	WARN_ON(!hlist_empty(&inode->i_dentry));
-	WARN_ON(inode->i_data.nrpages);
-	WARN_ON(BTRFS_I(inode)->block_rsv.reserved);
-	WARN_ON(BTRFS_I(inode)->block_rsv.size);
-	WARN_ON(BTRFS_I(inode)->outstanding_extents);
-	WARN_ON(BTRFS_I(inode)->delalloc_bytes);
-	WARN_ON(BTRFS_I(inode)->new_delalloc_bytes);
-	WARN_ON(BTRFS_I(inode)->csum_bytes);
-	WARN_ON(BTRFS_I(inode)->defrag_bytes);
+	WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
+	WARN_ON(vfs_inode->i_data.nrpages);
+	WARN_ON(inode->block_rsv.reserved);
+	WARN_ON(inode->block_rsv.size);
+	WARN_ON(inode->outstanding_extents);
+	WARN_ON(inode->delalloc_bytes);
+	WARN_ON(inode->new_delalloc_bytes);
+	WARN_ON(inode->csum_bytes);
+	WARN_ON(inode->defrag_bytes);
 
 	/*
 	 * This can happen where we create an inode, but somebody else also
@@ -8667,24 +8668,23 @@ void btrfs_destroy_inode(struct inode *inode)
 		return;
 
 	while (1) {
-		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
-							    (u64)-1);
+		ordered = btrfs_lookup_first_ordered_extent(inode, (u64)-1);
 		if (!ordered)
 			break;
 		else {
 			btrfs_err(fs_info,
 				  "found ordered extent %llu %llu on inode cleanup",
 				  ordered->file_offset, ordered->num_bytes);
-			btrfs_remove_ordered_extent(inode, ordered);
+			btrfs_remove_ordered_extent(vfs_inode, ordered);
 			btrfs_put_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 		}
 	}
-	btrfs_qgroup_check_reserved_leak(BTRFS_I(inode));
-	inode_tree_del(BTRFS_I(inode));
-	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
-	btrfs_inode_clear_file_extent_range(BTRFS_I(inode), 0, (u64)-1);
-	btrfs_put_root(BTRFS_I(inode)->root);
+	btrfs_qgroup_check_reserved_leak(inode);
+	inode_tree_del(inode);
+	btrfs_drop_extent_cache(inode, 0, (u64)-1, 0);
+	btrfs_inode_clear_file_extent_range(inode, 0, (u64)-1);
+	btrfs_put_root(inode->root);
 }
 
 int btrfs_drop_inode(struct inode *inode)
-- 
2.17.1

