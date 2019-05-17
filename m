Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC70821676
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfEQJms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJms (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DEDDAECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF778DA871; Fri, 17 May 2019 11:43:45 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 15/15] btrfs: read number of data stripes from map only once
Date:   Fri, 17 May 2019 11:43:45 +0200
Message-Id: <b270801c4817785eca161eb218c2ea9b33da2ee3.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several places that call nr_data_stripes, but this value does
not change.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c   |  8 ++++----
 fs/btrfs/volumes.c | 17 +++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0827bdf4faf1..e51929a55af4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2660,18 +2660,18 @@ static int get_raid56_logic_offset(u64 physical, int num,
 	u64 last_offset;
 	u32 stripe_index;
 	u32 rot;
+	const int data_stripes = nr_data_stripes(map);
 
-	last_offset = (physical - map->stripes[num].physical) *
-		      nr_data_stripes(map);
+	last_offset = (physical - map->stripes[num].physical) * data_stripes;
 	if (stripe_start)
 		*stripe_start = last_offset;
 
 	*offset = last_offset;
-	for (i = 0; i < nr_data_stripes(map); i++) {
+	for (i = 0; i < data_stripes; i++) {
 		*offset = last_offset + i * map->stripe_len;
 
 		stripe_nr = div64_u64(*offset, map->stripe_len);
-		stripe_nr = div_u64(stripe_nr, nr_data_stripes(map));
+		stripe_nr = div_u64(stripe_nr, data_stripes);
 
 		/* Work out the disk rotation on this stripe-set */
 		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes, &rot);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a8bf76d5f8e6..77a9dcfe3087 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5918,6 +5918,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	u64 stripe_nr;
 	u64 stripe_len;
 	u32 stripe_index;
+	int data_stripes;
 	int i;
 	int ret = 0;
 	int num_stripes;
@@ -5949,6 +5950,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	 * to get to this block
 	 */
 	stripe_nr = div64_u64(stripe_nr, stripe_len);
+	data_stripes = nr_data_stripes(map);
 
 	stripe_offset = stripe_nr * stripe_len;
 	if (offset < stripe_offset) {
@@ -5965,7 +5967,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	/* if we're here for raid56, we need to know the stripe aligned start */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		unsigned long full_stripe_len = stripe_len * nr_data_stripes(map);
+		unsigned long full_stripe_len = stripe_len * data_stripes;
 		raid56_full_stripe_start = offset;
 
 		/* allow a write of a full stripe, but make sure we don't
@@ -5983,7 +5985,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		   stripe (on a single disk). */
 		if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 		    (op == BTRFS_MAP_WRITE)) {
-			max_len = stripe_len * nr_data_stripes(map) -
+			max_len = stripe_len * data_stripes -
 				(offset - raid56_full_stripe_start);
 		} else {
 			/* we limit the length of each bio to what fits in a stripe */
@@ -6073,7 +6075,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
 			/* push stripe_nr back to the start of the full stripe */
 			stripe_nr = div64_u64(raid56_full_stripe_start,
-					stripe_len * nr_data_stripes(map));
+					stripe_len * data_stripes);
 
 			/* RAID[56] write or recovery. Return all stripes */
 			num_stripes = map->num_stripes;
@@ -6089,10 +6091,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			 * Mirror #3 is RAID6 Q block.
 			 */
 			stripe_nr = div_u64_rem(stripe_nr,
-					nr_data_stripes(map), &stripe_index);
+					data_stripes, &stripe_index);
 			if (mirror_num > 1)
-				stripe_index = nr_data_stripes(map) +
-						mirror_num - 2;
+				stripe_index = data_stripes + mirror_num - 2;
 
 			/* We distribute the parity blocks across stripes */
 			div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
@@ -6150,8 +6151,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		div_u64_rem(stripe_nr, num_stripes, &rot);
 
 		/* Fill in the logical address of each stripe */
-		tmp = stripe_nr * nr_data_stripes(map);
-		for (i = 0; i < nr_data_stripes(map); i++)
+		tmp = stripe_nr * data_stripes;
+		for (i = 0; i < data_stripes; i++)
 			bbio->raid_map[(i+rot) % num_stripes] =
 				em->start + (tmp + i) * map->stripe_len;
 
-- 
2.21.0

