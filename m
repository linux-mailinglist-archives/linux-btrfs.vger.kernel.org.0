Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854431E3EB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgE0KLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:11:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgE0KLH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:11:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B0D5AB5C;
        Wed, 27 May 2020 10:11:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove BTRFS_INODE_IN_DELALLOC_LIST flag
Date:   Wed, 27 May 2020 13:11:04 +0300
Message-Id: <20200527101104.7441-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The flag simply replicates whether btrfs_inode::delallocs_inodes list
is empty or not. Just defer this check to the list management functions
(btrfs_add_delalloc_inodes/__btrfs_del_delalloc_inode) which are
always called under btrfs_root::delalloc_lock.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/btrfs_inode.h |  1 -
 fs/btrfs/inode.c       | 11 ++---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index aeff56a0e105..da6743c70412 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -27,7 +27,6 @@ enum {
 	BTRFS_INODE_HAS_ASYNC_EXTENT,
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
-	BTRFS_INODE_IN_DELALLOC_LIST,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
 };
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d2f6e55a234..3e87a6644e09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1865,8 +1865,6 @@ static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
 	if (list_empty(&BTRFS_I(inode)->delalloc_inodes)) {
 		list_add_tail(&BTRFS_I(inode)->delalloc_inodes,
 			      &root->delalloc_inodes);
-		set_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-			&BTRFS_I(inode)->runtime_flags);
 		root->nr_delalloc_inodes++;
 		if (root->nr_delalloc_inodes == 1) {
 			spin_lock(&fs_info->delalloc_root_lock);
@@ -1887,8 +1885,6 @@ void __btrfs_del_delalloc_inode(struct btrfs_root *root,

 	if (!list_empty(&inode->delalloc_inodes)) {
 		list_del_init(&inode->delalloc_inodes);
-		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-			  &inode->runtime_flags);
 		root->nr_delalloc_inodes--;
 		if (!root->nr_delalloc_inodes) {
 			ASSERT(list_empty(&root->delalloc_inodes));
@@ -1944,8 +1940,7 @@ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 		BTRFS_I(inode)->delalloc_bytes += len;
 		if (*bits & EXTENT_DEFRAG)
 			BTRFS_I(inode)->defrag_bytes += len;
-		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-					 &BTRFS_I(inode)->runtime_flags))
+		if (do_list)
 			btrfs_add_delalloc_inodes(root, inode);
 		spin_unlock(&BTRFS_I(inode)->lock);
 	}
@@ -2014,9 +2009,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 					 fs_info->delalloc_batch);
 		spin_lock(&inode->lock);
 		inode->delalloc_bytes -= len;
-		if (do_list && inode->delalloc_bytes == 0 &&
-		    test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-					&inode->runtime_flags))
+		if (do_list && inode->delalloc_bytes == 0)
 			btrfs_del_delalloc_inode(root, inode);
 		spin_unlock(&inode->lock);
 	}
--
2.17.1

