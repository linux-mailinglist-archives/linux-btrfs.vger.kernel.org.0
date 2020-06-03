Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0D1EC91E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCF4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgFCF4D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:56:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6245EAEBE;
        Wed,  3 Jun 2020 05:56:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 44/46] btrfs: Make prealloc_file_extent_cluster take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:44 +0300
Message-Id: <20200603055546.3889-45-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The vfs inode is only used for a pair of inode_lock/unlock calls all other uses
call for btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fd8710837430..b48a8e9c844e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2572,13 +2572,13 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 }

 static noinline_for_stack
-int prealloc_file_extent_cluster(struct inode *inode,
+int prealloc_file_extent_cluster(struct btrfs_inode *inode,
 				 struct file_extent_cluster *cluster)
 {
 	u64 alloc_hint = 0;
 	u64 start;
 	u64 end;
-	u64 offset = BTRFS_I(inode)->index_cnt;
+	u64 offset = inode->index_cnt;
 	u64 num_bytes;
 	int nr = 0;
 	int ret = 0;
@@ -2588,10 +2588,9 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	struct extent_changeset *data_reserved = NULL;

 	BUG_ON(cluster->start != cluster->boundary[0]);
-	inode_lock(inode);
+	inode_lock(&inode->vfs_inode);

-	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
-					  prealloc_start,
+	ret = btrfs_check_data_free_space(inode, &data_reserved, prealloc_start,
 					  prealloc_end + 1 - prealloc_start);
 	if (ret)
 		goto out;
@@ -2604,26 +2603,25 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		else
 			end = cluster->end - offset;

-		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
+		lock_extent(&inode->io_tree, start, end);
 		num_bytes = end + 1 - start;
 		if (cur_offset < start)
-			btrfs_free_reserved_data_space(BTRFS_I(inode),
-					data_reserved, cur_offset,
-					start - cur_offset);
-		ret = btrfs_prealloc_file_range(inode, 0, start,
+			btrfs_free_reserved_data_space(inode, data_reserved,
+						cur_offset, start - cur_offset);
+		ret = btrfs_prealloc_file_range(&inode->vfs_inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
-		unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
+		unlock_extent(&inode->io_tree, start, end);
 		if (ret)
 			break;
 		nr++;
 	}
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
-				cur_offset, prealloc_end + 1 - cur_offset);
+		btrfs_free_reserved_data_space(inode, data_reserved, cur_offset,
+					       prealloc_end + 1 - cur_offset);
 out:
-	inode_unlock(inode);
+	inode_unlock(&inode->vfs_inode);
 	extent_changeset_free(data_reserved);
 	return ret;
 }
@@ -2692,7 +2690,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	if (!ra)
 		return -ENOMEM;

-	ret = prealloc_file_extent_cluster(inode, cluster);
+	ret = prealloc_file_extent_cluster(BTRFS_I(inode), cluster);
 	if (ret)
 		goto out;

--
2.17.1

