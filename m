Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417421F37DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgFIKTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgFIKTp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 06:19:45 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB6B2078D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591697984;
        bh=3MDnqAr51iuvNKy3uecVl00sTH63DkdXgEN4DPDNWQA=;
        h=From:To:Subject:Date:From;
        b=FW1RrUrsSM9E3WRWIqhHKLm09bF9qYNfn7kMQeOcRKAAM61AvJAlosdaXnWnCNoPI
         H88TvDQe8xIfGwsaT2N/CorelCvCbjKSvtbZ3S8+Xm9iG3wx3i7uslLlFQ+9poGP6p
         CATD770TaFqIEH0uBgfnWDyLBkCKQ6wyXTCBP+m8=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] Btrfs: use btrfs_alloc_data_chunk_ondemand() when allocating space for relocation
Date:   Tue,  9 Jun 2020 11:19:42 +0100
Message-Id: <20200609101942.29509-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We currently use btrfs_check_data_free_space() when allocating space for
relocating data extents, but that is not necessary because that function
combines btrfs_alloc_data_chunk_ondemand(), which does the actual space
reservation, and btrfs_qgroup_reserve_data().

We can use btrfs_alloc_data_chunk_ondemand() directly because we know we
do not need to reserve qgroup space since we are dealing with a relocation
tree, which can never have qgroups (btrfs_qgroup_reserve_data() does
nothing as is_fstree() returns false for a relocation tree).

Conversely we can use btrfs_free_reserved_data_space_noquota() directly
instead of btrfs_free_reserved_data_space(), since we had no qgroup
reservation when allocating space.

This change is preparatory work for another patch in this series that
makes relocation reserve the exact amount of space it needs to relocate
a data block group. The function btrfs_check_data_free_space() has
the incovenient of requiring a start offset argument and we will want to
be able to allocate space for multiple ranges, which are not consecutive,
at once.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3bbae80c752f..11d156995446 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2585,13 +2585,12 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
 	u64 cur_offset;
-	struct extent_changeset *data_reserved = NULL;
 
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	inode_lock(inode);
 
-	ret = btrfs_check_data_free_space(inode, &data_reserved, prealloc_start,
-					  prealloc_end + 1 - prealloc_start);
+	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
+					      prealloc_end + 1 - prealloc_start);
 	if (ret)
 		goto out;
 
@@ -2606,8 +2605,8 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		num_bytes = end + 1 - start;
 		if (cur_offset < start)
-			btrfs_free_reserved_data_space(inode, data_reserved,
-					cur_offset, start - cur_offset);
+			btrfs_free_reserved_data_space_noquota(inode,
+						       start - cur_offset);
 		ret = btrfs_prealloc_file_range(inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
@@ -2618,11 +2617,10 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		nr++;
 	}
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space(inode, data_reserved,
-				cur_offset, prealloc_end + 1 - cur_offset);
+		btrfs_free_reserved_data_space_noquota(inode,
+					       prealloc_end + 1 - cur_offset);
 out:
 	inode_unlock(inode);
-	extent_changeset_free(data_reserved);
 	return ret;
 }
 
-- 
2.11.0

