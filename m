Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E351FC9A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQJR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 05:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgFQJRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 05:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13140AFF5;
        Wed, 17 Jun 2020 09:17:26 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Perform data management operations outside of inode lock
Date:   Wed, 17 Jun 2020 12:10:43 +0300
Message-Id: <20200617091044.27846-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617091044.27846-1-nborisov@suse.com>
References: <20200617091044.27846-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_alloc_data_chunk_ondemand and btrfs_free_reserved_data_space_noquota
don't really use the guts of the inodes being passed to them. This
implies it's not required to call them under extent lock. Move code
around in prealloc_file_extent_cluster to do the heavy, data
alloc/free operations outside of the lock. This also makes the 'out'
label unnecessary, so remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 348985c8a559..020d04035be1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2584,17 +2584,15 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	int ret = 0;
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
-	u64 cur_offset;
+	u64 cur_offset = prealloc_start;
 
 	BUG_ON(cluster->start != cluster->boundary[0]);
-	inode_lock(inode);
-
 	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
 					      prealloc_end + 1 - prealloc_start);
 	if (ret)
-		goto out;
+		return ret;
 
-	cur_offset = prealloc_start;
+	inode_lock(inode);
 	while (nr < cluster->nr) {
 		start = cluster->boundary[nr] - offset;
 		if (nr + 1 < cluster->nr)
@@ -2613,11 +2611,11 @@ int prealloc_file_extent_cluster(struct inode *inode,
 			break;
 		nr++;
 	}
+	inode_unlock(inode);
+
 	if (cur_offset < prealloc_end)
 		btrfs_free_reserved_data_space_noquota(inode,
 					       prealloc_end + 1 - cur_offset);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
-- 
2.17.1

