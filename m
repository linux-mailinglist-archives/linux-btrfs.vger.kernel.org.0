Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A998E1FC9A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFQJR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 05:17:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgFQJRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 05:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D2FEB020;
        Wed, 17 Jun 2020 09:17:26 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Use for loop in prealloc_file_extent_cluster
Date:   Wed, 17 Jun 2020 12:10:44 +0300
Message-Id: <20200617091044.27846-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617091044.27846-1-nborisov@suse.com>
References: <20200617091044.27846-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function iterates all extents in the extent cluster, make this
intention obvious by using a for loop. No functional chanes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 020d04035be1..8972aa574a05 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2580,7 +2580,7 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	u64 end;
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	u64 num_bytes;
-	int nr = 0;
+	int nr;
 	int ret = 0;
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
@@ -2593,7 +2593,7 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		return ret;
 
 	inode_lock(inode);
-	while (nr < cluster->nr) {
+	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
 		if (nr + 1 < cluster->nr)
 			end = cluster->boundary[nr + 1] - 1 - offset;
@@ -2609,7 +2609,6 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		if (ret)
 			break;
-		nr++;
 	}
 	inode_unlock(inode);
 
-- 
2.17.1

