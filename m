Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08BE3B503
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfFJM25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:28:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389001AbfFJM24 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:28:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0982AE9A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:28:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E15F9DAC82; Mon, 10 Jun 2019 14:29:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/6] btrfs: add mask for all RAID1 types
Date:   Mon, 10 Jun 2019 14:29:43 +0200
Message-Id: <c0eab73c257e399c8e902196e8bba0892195e05a.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparatory patch for additional RAID1 profiles with more copies. The
mask will contain 3-copy and 4-copy, most of the checks for plain RAID1
work the same for the other profiles.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c          | 8 ++++----
 fs/btrfs/scrub.c                | 2 +-
 fs/btrfs/volumes.c              | 8 ++++----
 include/uapi/linux/btrfs_tree.h | 2 ++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 96628eb4b389..3413f78a3032 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7873,7 +7873,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		 */
 		if (!block_group_bits(block_group, flags)) {
 			u64 extra = BTRFS_BLOCK_GROUP_DUP |
-				BTRFS_BLOCK_GROUP_RAID1 |
+				BTRFS_BLOCK_GROUP_RAID1_MASK |
 				BTRFS_BLOCK_GROUP_RAID5 |
 				BTRFS_BLOCK_GROUP_RAID6 |
 				BTRFS_BLOCK_GROUP_RAID10;
@@ -9564,7 +9564,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 
 	stripped = BTRFS_BLOCK_GROUP_RAID0 |
 		BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
-		BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_RAID10;
+		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
 
 	if (num_devices == 1) {
 		stripped |= BTRFS_BLOCK_GROUP_DUP;
@@ -9575,7 +9575,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 			return stripped;
 
 		/* turn mirroring into duplication */
-		if (flags & (BTRFS_BLOCK_GROUP_RAID1 |
+		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
 			     BTRFS_BLOCK_GROUP_RAID10))
 			return stripped | BTRFS_BLOCK_GROUP_DUP;
 	} else {
@@ -10445,7 +10445,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
 		if (!(get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
-		       BTRFS_BLOCK_GROUP_RAID1 |
+		       BTRFS_BLOCK_GROUP_RAID1_MASK |
 		       BTRFS_BLOCK_GROUP_RAID5 |
 		       BTRFS_BLOCK_GROUP_RAID6 |
 		       BTRFS_BLOCK_GROUP_DUP)))
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9f0297d529d4..0c99cf9fb595 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3091,7 +3091,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		offset = map->stripe_len * (num / map->sub_stripes);
 		increment = map->stripe_len * factor;
 		mirror_num = num % map->sub_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		increment = map->stripe_len;
 		mirror_num = num % map->num_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 776f5c7ca7c5..9e5167a0e406 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5400,7 +5400,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		return 1;
 
 	map = em->map_lookup;
-	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1))
+	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MASK))
 		ret = map->num_stripes;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		ret = map->sub_stripes;
@@ -5474,7 +5474,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	struct btrfs_device *srcdev;
 
 	ASSERT((map->type &
-		 (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_RAID10)));
+		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = map->sub_stripes;
@@ -5663,7 +5663,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 					      &remaining_stripes);
 		div_u64_rem(stripe_nr_end - 1, factor, &last_stripe);
 		last_stripe *= sub_stripes;
-	} else if (map->type & (BTRFS_BLOCK_GROUP_RAID1 |
+	} else if (map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK |
 				BTRFS_BLOCK_GROUP_DUP)) {
 		num_stripes = map->num_stripes;
 	} else {
@@ -6035,7 +6035,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 				&stripe_index);
 		if (!need_full_stripe(op))
 			mirror_num = 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		if (need_full_stripe(op))
 			num_stripes = map->num_stripes;
 		else if (mirror_num)
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 421239b98db2..34d5b34286fa 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -866,6 +866,8 @@ enum btrfs_raid_types {
 #define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6)
 
+#define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1)
+
 /*
  * We need a bit for restriper to be able to tell when chunks of type
  * SINGLE are available.  This "extended" profile format is used in
-- 
2.21.0

