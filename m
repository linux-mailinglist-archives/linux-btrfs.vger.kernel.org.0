Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F431023D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKSMGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:06:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:49312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbfKSMGC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:06:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70A0CB14B;
        Tue, 19 Nov 2019 12:06:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: Refactor btrfs_rmap_block to improve readability
Date:   Tue, 19 Nov 2019 14:05:53 +0200
Message-Id: <20191119120555.6465-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119120555.6465-1-nborisov@suse.com>
References: <20191119120555.6465-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move variables to appropriate scope. Remove last BUG_ON in the function
and rework error handling accordingly. Make the duplicate detection code
more straightforward. Use in_range macro. And give variables more
descriptive name by explicitly distinguishing between IO stripe size
(size recorded in the chunk item) and data stripe size (the size of
an actual stripe, constituting a logical chunk/block group).

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 902c246a9d38..c3b1f304bc70 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1536,34 +1536,41 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	struct map_lookup *map;
 	u64 *buf;
 	u64 bytenr;
-	u64 length;
-	u64 stripe_nr;
-	u64 rmap_len;
-	int i, j, nr = 0;
+	u64 data_stripe_length;
+	u64 io_stripe_size;
+	int i, nr = 0;
+	int ret = 0;
 
 	em = btrfs_get_chunk_map(fs_info, chunk_start, 1);
 	if (IS_ERR(em))
 		return -EIO;
 
 	map = em->map_lookup;
-	length = em->len;
-	rmap_len = map->stripe_len;
+	data_stripe_length = em->len;
+	io_stripe_size = map->stripe_len;
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
-		length = div_u64(length, map->num_stripes / map->sub_stripes);
+		data_stripe_length = div_u64(data_stripe_length, map->num_stripes / map->sub_stripes);
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
-		length = div_u64(length, map->num_stripes);
+		data_stripe_length = div_u64(data_stripe_length, map->num_stripes);
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		length = div_u64(length, nr_data_stripes(map));
-		rmap_len = map->stripe_len * nr_data_stripes(map);
+		data_stripe_length = div_u64(data_stripe_length, nr_data_stripes(map));
+		io_stripe_size = map->stripe_len * nr_data_stripes(map);
 	}
 
 	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
-	BUG_ON(!buf); /* -ENOMEM */
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		if (map->stripes[i].physical > physical ||
-		    map->stripes[i].physical + length <= physical)
+		bool already_inserted = false;
+		u64 stripe_nr;
+		int j;
+
+		if (!in_range(physical, map->stripes[i].physical,
+			      data_stripe_length))
 			continue;
 
 		stripe_nr = physical - map->stripes[i].physical;
@@ -1575,25 +1582,27 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		} else if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
 		} /* else if RAID[56], multiply by nr_data_stripes().
-		   * Alternatively, just use rmap_len below instead of
+		   * Alternatively, just use io_stripe_size below instead of
 		   * map->stripe_len */
 
-		bytenr = chunk_start + stripe_nr * rmap_len;
-		WARN_ON(nr >= map->num_stripes);
+		bytenr = chunk_start + stripe_nr * io_stripe_size;
+
+		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
-			if (buf[j] == bytenr)
+			if (buf[j] == bytenr) {
+				already_inserted = true;
 				break;
+			}
 		}
-		if (j == nr) {
-			WARN_ON(nr >= map->num_stripes);
+
+		if (!already_inserted)
 			buf[nr++] = bytenr;
-		}
 	}
 
 	*logical = buf;
 	*naddrs = nr;
-	*stripe_len = rmap_len;
-
+	*stripe_len = io_stripe_size;
+out:
 	free_extent_map(em);
 	return 0;
 }
-- 
2.17.1

