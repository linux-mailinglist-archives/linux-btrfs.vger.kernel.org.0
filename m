Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34DE20D7FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgF2Tei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 15:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733153AbgF2Tb0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4172AD04;
        Mon, 29 Jun 2020 14:16:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Always initialize btrfs_bio::tgtdev_map/raid_map pointers
Date:   Mon, 29 Jun 2020 17:16:39 +0300
Message-Id: <20200629141639.7580-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since btrfs_bio always contains the extra space for the tgtdev_map and
raid_maps it's pointless to make the assignment iff specific conditions
are met. Instead, always assign the pointers to their correct value at
allocation time.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cb9883c7f8b7..1b1fc1485a41 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5522,6 +5522,9 @@ static struct btrfs_bio *alloc_btrfs_bio(int total_stripes, int real_stripes)
 	atomic_set(&bbio->error, 0);
 	refcount_set(&bbio->refs, 1);
 
+	bbio->tgtdev_map = (int *)(bbio->stripes + total_stripes);
+	bbio->raid_map = (u64 *)(bbio->tgtdev_map + real_stripes);
+
 	return bbio;
 }
 
@@ -6144,8 +6147,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-		bbio->tgtdev_map = (int *)(bbio->stripes + num_alloc_stripes);
 
 	/* build raid_map */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
@@ -6153,10 +6154,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		u64 tmp;
 		unsigned rot;
 
-		bbio->raid_map = (u64 *)((void *)bbio->stripes +
-				 sizeof(struct btrfs_bio_stripe) *
-				 num_alloc_stripes +
-				 sizeof(int) * tgtdev_indexes);
 
 		/* Work out the disk rotation on this stripe-set */
 		div_u64_rem(stripe_nr, num_stripes, &rot);
-- 
2.17.1

