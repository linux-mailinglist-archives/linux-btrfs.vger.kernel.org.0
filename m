Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996A91F37DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgFIKT4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgFIKT4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 06:19:56 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E8E62078D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591697995;
        bh=FarDqpTkFNNCri/dendFQbIjF9YUV54s+Jdw7jZro9M=;
        h=From:To:Subject:Date:From;
        b=QMrLO0ZhezF8uhNoN+aSXOwgz6nc8btEItJQGabFWuWoIxFkvHL0ZH8FWc7yk3/nE
         tKGunxcpg7EVNjNwJV57I+k3no6dgj/yaqqA6aLsYoB2zThVZHcaQ00vqrY7P2/dWH
         pqIpn+fClveVNrX91c4MlVJEWddCexNNIaYx2vW4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] Btrfs: only allocate necessary space when relocating a data block group
Date:   Tue,  9 Jun 2020 11:19:53 +0100
Message-Id: <20200609101953.29559-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When relocating a data block group we group extents from the block group
into a cluster and when the cluster reaches a certain number of extents
we do the relocation.

The first step is reserving data space and we try to reserve more space
than we need if the block group is not full, when there are gaps between
the collected extents. What happens is we attempt to reserve an amount of
space that corresponds to the different between the end offset of the last
extent and the start offset of the first extent. This can cause us to fail
with -ENOSPC even when we have enough free space for relocating all the
extents. We should skip space reservation for any gaps which always exist
for block groups that are not full. Non full block groups are the ones
which are useful to relocate, therefore a common use case.

So fix this by tracking the total number of bytes used for all the extents
in the cluster and then reserving an amount of space that matches exactly
the sum of the sizes of all the collected extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 11d156995446..7ec75229d86f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -108,6 +108,7 @@ struct tree_block {
 struct file_extent_cluster {
 	u64 start;
 	u64 end;
+	u64 total_bytes;
 	u64 boundary[MAX_EXTENTS];
 	unsigned int nr;
 };
@@ -2583,14 +2584,14 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	int nr = 0;
 	int ret = 0;
 	u64 prealloc_start = cluster->start - offset;
-	u64 prealloc_end = cluster->end - offset;
 	u64 cur_offset;
+	u64 allocated = 0;
 
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	inode_lock(inode);
 
 	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
-					      prealloc_end + 1 - prealloc_start);
+					      cluster->total_bytes);
 	if (ret)
 		goto out;
 
@@ -2604,21 +2605,19 @@ int prealloc_file_extent_cluster(struct inode *inode,
 
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		num_bytes = end + 1 - start;
-		if (cur_offset < start)
-			btrfs_free_reserved_data_space_noquota(inode,
-						       start - cur_offset);
 		ret = btrfs_prealloc_file_range(inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
+		allocated += num_bytes;
 		unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		if (ret)
 			break;
 		nr++;
 	}
-	if (cur_offset < prealloc_end)
+	if (allocated < cluster->total_bytes)
 		btrfs_free_reserved_data_space_noquota(inode,
-					       prealloc_end + 1 - cur_offset);
+				       cluster->total_bytes - allocated);
 out:
 	inode_unlock(inode);
 	return ret;
@@ -2809,6 +2808,7 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 		if (ret)
 			return ret;
 		cluster->nr = 0;
+		cluster->total_bytes = 0;
 	}
 
 	if (!cluster->nr)
@@ -2818,12 +2818,14 @@ int relocate_data_extent(struct inode *inode, struct btrfs_key *extent_key,
 	cluster->end = extent_key->objectid + extent_key->offset - 1;
 	cluster->boundary[cluster->nr] = extent_key->objectid;
 	cluster->nr++;
+	cluster->total_bytes += extent_key->offset;
 
 	if (cluster->nr >= MAX_EXTENTS) {
 		ret = relocate_file_extent_cluster(inode, cluster);
 		if (ret)
 			return ret;
 		cluster->nr = 0;
+		cluster->total_bytes = 0;
 	}
 	return 0;
 }
-- 
2.11.0

