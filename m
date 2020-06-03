Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0971ECD48
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFCKLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgFCKLT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 06:11:19 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4602067B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591179078;
        bh=Ogbq92mtFKJM2S18B9DkiEULx+4sDO10TAtZJRT0SsQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kLFaIdZRj8lsOHpckARL7c7bc/eJKMvog2b0W8Zg6/J9Uc3WO2p2MU5aY3TX6cPEY
         bfEI6rqaRUqRLv1m0e6Ozs6ZgwRv3uQtaJ/d7z5CaZRpvm2dd0+R4zZErMmS1TU8kW
         P4vLHZmme6zXY8gHH5leiuPhfqPNZfVEYSohMrbA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] Btrfs: fix a block group ref counter leak after failure to remove block group
Date:   Wed,  3 Jun 2020 11:11:12 +0100
Message-Id: <20200603101112.23369-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601181206.24852-1-fdmanana@kernel.org>
References: <20200601181206.24852-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When removing a block group, if we fail to delete the block group's item
from the extent tree, we jump to the 'out' label and end up decrementing
the block group's reference count once only (by 1), resulting in a counter
leak because the block group at that point was already removed from the
block group cache rbtree - so we have to decrement the reference count
twice, once for the rbtree and once for our lookup at the start of the
function.

There is a second bug where if removing the free space tree entries (the
call to remove_block_group_free_space()) fails we end up jumping to the
'out_put_group' label but end up decrementing the reference count only
once, when we should have done it twice, since we have already removed
the block group from the block group cache rbtree. This happens because
the reference count decrement for the rbtree reference happens after
attempting to remove the free space tree entries, which is far away from
the place where we remove the block group from the rbtree.

To make things less error prone, decrement the reference count for the
rbtree immediately after removing the block group from it. This also
eleminates the need for two different exit labels on error, renaming
'out_put_label' to just 'out' and removing the old 'out'.

Fixes: f6033c5e333238 ("btrfs: fix block group leak when removing fails")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Updated changelog to describe a second bug the patch fixes, pointed
    out by Nikolay.

 fs/btrfs/block-group.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 176e8a292fd1..5bb76a437f5b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -940,7 +940,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-		goto out_put_group;
+		goto out;
 	}
 
 	/*
@@ -978,7 +978,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 		if (ret) {
 			btrfs_add_delayed_iput(inode);
-			goto out_put_group;
+			goto out;
 		}
 		clear_nlink(inode);
 		/* One for the block groups ref */
@@ -1001,13 +1001,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out_put_group;
+		goto out;
 	if (ret > 0)
 		btrfs_release_path(path);
 	if (ret == 0) {
 		ret = btrfs_del_item(trans, tree_root, path);
 		if (ret)
-			goto out_put_group;
+			goto out;
 		btrfs_release_path(path);
 	}
 
@@ -1016,6 +1016,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		 &fs_info->block_group_cache_tree);
 	RB_CLEAR_NODE(&block_group->cache_node);
 
+	/* Once for the block groups rbtree. */
+	btrfs_put_block_group(block_group);
+
 	if (fs_info->first_logical_byte == block_group->start)
 		fs_info->first_logical_byte = (u64)-1;
 	spin_unlock(&fs_info->block_group_cache_lock);
@@ -1125,10 +1128,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	ret = remove_block_group_free_space(trans, block_group);
 	if (ret)
-		goto out_put_group;
-
-	/* Once for the block groups rbtree */
-	btrfs_put_block_group(block_group);
+		goto out;
 
 	ret = remove_block_group_item(trans, path, block_group);
 	if (ret < 0)
@@ -1145,10 +1145,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		free_extent_map(em);
 	}
 
-out_put_group:
+out:
 	/* Once for the lookup reference */
 	btrfs_put_block_group(block_group);
-out:
 	if (remove_rsv)
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
 	btrfs_free_path(path);
-- 
2.11.0

