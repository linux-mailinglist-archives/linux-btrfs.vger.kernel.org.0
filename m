Return-Path: <linux-btrfs+bounces-13120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5127CA9177B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01637AB63E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE622422F;
	Thu, 17 Apr 2025 09:17:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D833FD
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881451; cv=none; b=MilQ6a4fESmRDV/ZtK7+t6qcbyA4xI7NTyl8pFOLGiN7a/rVOpVwhZGF5OFOCqyNR46/FLwMfk79V/yatXnu1rXLXNhl/m+mp9U1Zc3h7k38GgCrO8WenUh+pJp+/elO0iY4Vox0ZqDDeVZUyTpdbiE+Se9HSPEn/d/2S24SOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881451; c=relaxed/simple;
	bh=NKlFNxE6ytHU5QA7xxR3dp2cmaC5BQcmavIvVlTqDB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cId2BlKKI/v6Vfl52eT8tlfWVcBea8yZZOZ2Lo6BrwLvGpkw+Lki5WWrhZAcCgeA1l6+ihpM6ci0Iikwl11OCPvZ/wA0dSWUdsTfzZf6hSEW1mZDYKHlo2YKgZL5p5vnUhzhxrqoGXUXwxQeenbPl+197/wX2/RqgO0E5l1uMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE82D1F391;
	Thu, 17 Apr 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7D1E137CF;
	Thu, 17 Apr 2025 09:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PmOXOB7HAGi7cQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:17:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/5] btrfs: example use of enhanced ASSERT() in volumes.c
Date: Thu, 17 Apr 2025 11:17:00 +0200
Message-ID: <d8bd6803b3f93f1157d026e197ea14acde88e4f6.1744881160.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744881159.git.dsterba@suse.com>
References: <cover.1744881159.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: EE82D1F391
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The file volumes.c has about 40 assertions and half of them are suitable
for ASSERT() with additional data.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 55 +++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4d5c59083003ff..934006af4b4254 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1640,7 +1640,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	int ret;
 	bool changed = false;
 
-	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+	ASSERT(IS_ALIGNED(*hole_start, zone_size),
+	       "hole_start=%llu zone_size=%llu", *hole_start, zone_size);
 
 	while (*hole_size > 0) {
 		pos = btrfs_find_allocatable_zones(device, *hole_start,
@@ -1891,7 +1892,9 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	else
 		ret = 0;
 
-	ASSERT(max_hole_start + max_hole_size <= search_end);
+	ASSERT(max_hole_start + max_hole_size <= search_end,
+	       "max_hole_start=%llu max_hole_size=%llu search_end=%llu",
+	       max_hole_start, max_hole_size, search_end);
 out:
 	btrfs_free_path(path);
 	*start = max_hole_start;
@@ -2204,7 +2207,7 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace)) {
-		ASSERT(num_devices > 1);
+		ASSERT(num_devices > 1, "num_devices=%llu", num_devices);
 		num_devices--;
 	}
 	up_read(&fs_info->dev_replace.rwsem);
@@ -2408,7 +2411,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		ASSERT(cur_devices->opened == 1);
+		ASSERT(cur_devices->opened == 1, "opened=%d", cur_devices->opened);
 		cur_devices->opened--;
 		free_fs_devices(cur_devices);
 	}
@@ -4753,7 +4756,8 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 	}
 
 	spin_lock(&fs_info->super_lock);
-	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED,
+	       "exclusive_operation=%d", fs_info->exclusive_operation);
 	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
 	spin_unlock(&fs_info->super_lock);
 	/*
@@ -5436,7 +5440,9 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 	 * It should hold because:
 	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
 	 */
-	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
+	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min,
+	       "ndevs=%d max_avail=%llu dev_extent_min=%llu", ctl->ndevs,
+	       devices_info[ctl->ndevs - 1].max_avail, ctl->dev_extent_min);
 
 	ctl->stripe_size = zone_size;
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
@@ -5449,7 +5455,9 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 				     ctl->dev_stripes);
 		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
-		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
+		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size,
+		       "stripe_size=%llu data_stripes=%d max_chunk_size=%llu",
+		       ctl->stripe_size, data_stripes, ctl->max_chunk_size);
 	}
 
 	ctl->chunk_size = ctl->stripe_size * data_stripes;
@@ -6055,8 +6063,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	int tolerance;
 	struct btrfs_device *srcdev;
 
-	ASSERT((map->type &
-		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
+	ASSERT((map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)),
+	       "type=%llu", map->type);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = map->sub_stripes;
@@ -6357,7 +6365,7 @@ static void handle_ops_on_dev_replace(struct btrfs_io_context *bioc,
 	}
 
 	/* We can only have at most 2 extra nr_stripes (for DUP). */
-	ASSERT(nr_extra_stripes <= 2);
+	ASSERT(nr_extra_stripes <= 2, "nr_extra_stripes=%d", nr_extra_stripes);
 	/*
 	 * For GET_READ_MIRRORS, we can only return at most 1 extra stripe for
 	 * replace.
@@ -6368,7 +6376,8 @@ static void handle_ops_on_dev_replace(struct btrfs_io_context *bioc,
 		struct btrfs_io_stripe *second = &bioc->stripes[num_stripes + 1];
 
 		/* Only DUP can have two extra stripes. */
-		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_DUP);
+		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_DUP,
+		       "map_type=%llu", bioc->map_type);
 
 		/*
 		 * Swap the last stripe stripes and reduce @nr_extra_stripes.
@@ -6395,7 +6404,8 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, u64 offset,
 	 */
 	io_geom->stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
 	io_geom->stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
-	ASSERT(io_geom->stripe_offset < U32_MAX);
+	ASSERT(io_geom->stripe_offset < U32_MAX,
+	       "stripe_offset=%llu", io_geom->stripe_offset);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		unsigned long full_stripe_len =
@@ -6413,8 +6423,12 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, u64 offset,
 		io_geom->raid56_full_stripe_start = btrfs_stripe_nr_to_offset(
 			rounddown(io_geom->stripe_nr, nr_data_stripes(map)));
 
-		ASSERT(io_geom->raid56_full_stripe_start + full_stripe_len > offset);
-		ASSERT(io_geom->raid56_full_stripe_start <= offset);
+		ASSERT(io_geom->raid56_full_stripe_start + full_stripe_len > offset,
+		       "raid56_full_stripe_start=%llu full_stripe_len=%lu offset=%llu",
+		       io_geom->raid56_full_stripe_start, full_stripe_len, offset);
+		ASSERT(io_geom->raid56_full_stripe_start <= offset,
+		       "raid56_full_stripe_start=%llu offset=%llu",
+		       io_geom->raid56_full_stripe_start, offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
@@ -6580,7 +6594,7 @@ static void map_blocks_raid56_read(struct btrfs_chunk_map *map,
 {
 	int data_stripes = nr_data_stripes(map);
 
-	ASSERT(io_geom->mirror_num <= 1);
+	ASSERT(io_geom->mirror_num <= 1, "mirror_num=%d", io_geom->mirror_num);
 	/* Just grab the data stripe directly. */
 	io_geom->stripe_index = io_geom->stripe_nr % data_stripes;
 	io_geom->stripe_nr /= data_stripes;
@@ -7925,7 +7939,7 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans)
 {
 	struct btrfs_device *curr, *next;
 
-	ASSERT(trans->state == TRANS_STATE_COMMIT_DOING);
+	ASSERT(trans->state == TRANS_STATE_COMMIT_DOING, "state=%d" , trans->state);
 
 	if (list_empty(&trans->dev_update_list))
 		return;
@@ -8299,7 +8313,7 @@ static void map_raid56_repair_block(struct btrfs_io_context *bioc,
 		    logical < stripe_start + BTRFS_STRIPE_LEN)
 			break;
 	}
-	ASSERT(i < data_stripes);
+	ASSERT(i < data_stripes, "i=%d data_stripes=%d", i, data_stripes);
 	smap->dev = bioc->stripes[i].dev;
 	smap->physical = bioc->stripes[i].physical +
 			((logical - bioc->full_stripe_logical) &
@@ -8328,7 +8342,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 	int mirror_ret = mirror_num;
 	int ret;
 
-	ASSERT(mirror_num > 0);
+	ASSERT(mirror_num > 0, "mirror_num=%d", mirror_num);
 
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
 			      &bioc, smap, &mirror_ret);
@@ -8336,7 +8350,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	/* The map range should not cross stripe boundary. */
-	ASSERT(map_length >= length);
+	ASSERT(map_length >= length, "map_length=%llu length=%u", map_length, length);
 
 	/* Already mapped to single stripe. */
 	if (!bioc)
@@ -8348,7 +8362,8 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	ASSERT(mirror_num <= bioc->num_stripes);
+	ASSERT(mirror_num <= bioc->num_stripes,
+	       "mirror_num=%d num_stripes=%d", mirror_num,  bioc->num_stripes);
 	smap->dev = bioc->stripes[mirror_num - 1].dev;
 	smap->physical = bioc->stripes[mirror_num - 1].physical;
 out:
-- 
2.49.0


