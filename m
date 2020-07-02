Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D2212519
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgGBNqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgGBNqy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94985AD88;
        Thu,  2 Jul 2020 13:46:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/10] btrfs: Always initialize btrfs_bio::tgtdev_map/raid_map pointers
Date:   Thu,  2 Jul 2020 16:46:41 +0300
Message-Id: <20200702134650.16550-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since btrfs_bio always contains the extra space for the tgtdev_map and
raid_maps it's pointless to make the assignment iff specific conditions
are met. Instead, always assign the pointers to their correct value at
allocation time. To accommodate this change also move code a bit in
__btrfs_map_block so that btrfs_bio::stripes array is always initialized
before the raid_map, subsequently move the call to sort_parity_stripes
in the 'if' building the raid_map, retaining the old behavior.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cb9883c7f8b7..d74d21af77fb 100644
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
 
@@ -6144,8 +6147,16 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-		bbio->tgtdev_map = (int *)(bbio->stripes + num_alloc_stripes);
+
+	for (i = 0; i < num_stripes; i++) {
+		bbio->stripes[i].physical =
+			map->stripes[stripe_index].physical +
+			stripe_offset +
+			stripe_nr * map->stripe_len;
+		bbio->stripes[i].dev =
+			map->stripes[stripe_index].dev;
+		stripe_index++;
+	}
 
 	/* build raid_map */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
@@ -6153,10 +6164,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		u64 tmp;
 		unsigned rot;
 
-		bbio->raid_map = (u64 *)((void *)bbio->stripes +
-				 sizeof(struct btrfs_bio_stripe) *
-				 num_alloc_stripes +
-				 sizeof(int) * tgtdev_indexes);
 
 		/* Work out the disk rotation on this stripe-set */
 		div_u64_rem(stripe_nr, num_stripes, &rot);
@@ -6171,25 +6178,14 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
 			bbio->raid_map[(i+rot+1) % num_stripes] =
 				RAID6_Q_STRIPE;
-	}
-
 
-	for (i = 0; i < num_stripes; i++) {
-		bbio->stripes[i].physical =
-			map->stripes[stripe_index].physical +
-			stripe_offset +
-			stripe_nr * map->stripe_len;
-		bbio->stripes[i].dev =
-			map->stripes[stripe_index].dev;
-		stripe_index++;
+		sort_parity_stripes(bbio, num_stripes);
 	}
 
+
 	if (need_full_stripe(op))
 		max_errors = btrfs_chunk_max_errors(map);
 
-	if (bbio->raid_map)
-		sort_parity_stripes(bbio, num_stripes);
-
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
 		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-- 
2.17.1

