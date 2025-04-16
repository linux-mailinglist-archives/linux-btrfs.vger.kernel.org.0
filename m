Return-Path: <linux-btrfs+bounces-13064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C902DA8B4DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6287AD14D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7081E2376FE;
	Wed, 16 Apr 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NKSfJxrg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GDDkruWp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F63235348
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794510; cv=none; b=ngb1aL3YWbXdMCbqy8lYQz4uAf+jnJmIMuAo3KG3pEj0LpIc+9xDow7aV34LiELbUnb61EOxrEo1BBnxFH+mE1LFsERlGttfQ/R6fZvvjzuNmhNuI9+nNLSZ88eb6609m98YS/aCc7SXmAuiJkU2XP4BV7jL2x2TC5vxZaALj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794510; c=relaxed/simple;
	bh=UNk3MvLfa+aGso8/+jc1xnU/bHkuGvvJvjmqD//TZu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPIfrAjuFbut4qWlHM+BWZzoolGCceBnjGQo3BGn5E4tKD9I4IgAh4BPjm+NTz+0C/Dng0mYMs3EmdbD8UFp1PobIA4yWJd6Gww+bKBVO/spt0yTfKeJURMGATsIXTNGt8qosz4hhmUKkK1hYCTY2WVbRbWpSyFV4lYTqTe5v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NKSfJxrg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GDDkruWp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF9B2211A5;
	Wed, 16 Apr 2025 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw3JlfJ4YSIoy5oMqusKbKGui3zIgi6Oyt2x2V+zXYE=;
	b=NKSfJxrgJXQ7hT7qZG9/7BzeJdw39G2BdNv9oEJzm2Lqe4w8BAh9N7EWGaxy3jbOsF3dvi
	ZAZog9XNToG94g+CwvoBIEvLEUuWDrnTEIJghLj0gWJvlFSm50blGNLeaQl84Y84KZlDXJ
	HtkZlVc/N3AhhcZ2z4VnfwNvxhZTIi8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw3JlfJ4YSIoy5oMqusKbKGui3zIgi6Oyt2x2V+zXYE=;
	b=GDDkruWpAMLhDwZpdS6gOLzeMiFwZ0GKwM6cHiMh+IgAWUbo8GMMsffy/LBu4aTJYdV7PJ
	ZyUPUD0N8XzuTSyCgrFfuCgUitxZ2hYp+yxzZKxouhQqBpXE+vaZcsjfz5YzayV5nnjn4t
	NvkAEC6ZfPelOZ+H6dRh9F1Mf0Rq0No=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E87BA13976;
	Wed, 16 Apr 2025 09:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EmLAOIZz/2dRbAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Apr 2025 09:08:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: example use of VASSERT() in volumes.c
Date: Wed, 16 Apr 2025 11:08:09 +0200
Message-ID: <91db33e579e3c4dfad499401f2e224fe69987555.1744794336.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744794336.git.dsterba@suse.com>
References: <cover.1744794336.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The file volumes.c has about 40 assertions and half of them are suitable
for VASSERT.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4d5c59083003ff..e8b944aeb2e189 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1640,7 +1640,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	int ret;
 	bool changed = false;
 
-	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+	VASSERT(IS_ALIGNED(*hole_start, zone_size),
+		"hole_start=%llu zone_size=%llu", *hole_start, zone_size);
 
 	while (*hole_size > 0) {
 		pos = btrfs_find_allocatable_zones(device, *hole_start,
@@ -1891,7 +1892,9 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	else
 		ret = 0;
 
-	ASSERT(max_hole_start + max_hole_size <= search_end);
+	VASSERT(max_hole_start + max_hole_size <= search_end,
+		"max_hole_start=%llu max_hole_size=%llu search_end=%llu",
+		max_hole_start, max_hole_size, search_end);
 out:
 	btrfs_free_path(path);
 	*start = max_hole_start;
@@ -2204,7 +2207,7 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace)) {
-		ASSERT(num_devices > 1);
+		VASSERT(num_devices > 1, "num_devices=%llu", num_devices);
 		num_devices--;
 	}
 	up_read(&fs_info->dev_replace.rwsem);
@@ -2408,7 +2411,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 */
 	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
-		ASSERT(cur_devices->opened == 1);
+		VASSERT(cur_devices->opened == 1,
+			"opened=%d", cur_devices->opened);
 		cur_devices->opened--;
 		free_fs_devices(cur_devices);
 	}
@@ -4753,7 +4757,8 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 	}
 
 	spin_lock(&fs_info->super_lock);
-	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+	VASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED,
+		"exclusive_operation=%d", fs_info->exclusive_operation);
 	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
 	spin_unlock(&fs_info->super_lock);
 	/*
@@ -5436,7 +5441,9 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 	 * It should hold because:
 	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
 	 */
-	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
+	VASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min,
+		"ndevs=%d max_avail=%llu dev_extent_min=%llu", ctl->ndevs,
+		devices_info[ctl->ndevs - 1].max_avail, ctl->dev_extent_min);
 
 	ctl->stripe_size = zone_size;
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
@@ -5449,7 +5456,9 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 				     ctl->dev_stripes);
 		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
-		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
+		VASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size,
+			"stripe_size=%llu data_stripes=%d max_chunk_size=%llu",
+			ctl->stripe_size, data_stripes, ctl->max_chunk_size);
 	}
 
 	ctl->chunk_size = ctl->stripe_size * data_stripes;
@@ -6055,8 +6064,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	int tolerance;
 	struct btrfs_device *srcdev;
 
-	ASSERT((map->type &
-		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
+	VASSERT((map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)),
+		"type=%llu", map->type);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
 		num_stripes = map->sub_stripes;
@@ -6357,7 +6366,7 @@ static void handle_ops_on_dev_replace(struct btrfs_io_context *bioc,
 	}
 
 	/* We can only have at most 2 extra nr_stripes (for DUP). */
-	ASSERT(nr_extra_stripes <= 2);
+	VASSERT(nr_extra_stripes <= 2, "nr_extra_stripes=%d", nr_extra_stripes);
 	/*
 	 * For GET_READ_MIRRORS, we can only return at most 1 extra stripe for
 	 * replace.
@@ -6368,7 +6377,8 @@ static void handle_ops_on_dev_replace(struct btrfs_io_context *bioc,
 		struct btrfs_io_stripe *second = &bioc->stripes[num_stripes + 1];
 
 		/* Only DUP can have two extra stripes. */
-		ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_DUP);
+		VASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_DUP,
+			"map_type=%llu", bioc->map_type);
 
 		/*
 		 * Swap the last stripe stripes and reduce @nr_extra_stripes.
@@ -6395,7 +6405,8 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, u64 offset,
 	 */
 	io_geom->stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
 	io_geom->stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
-	ASSERT(io_geom->stripe_offset < U32_MAX);
+	VASSERT(io_geom->stripe_offset < U32_MAX,
+		"stripe_offset=%llu", io_geom->stripe_offset);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		unsigned long full_stripe_len =
@@ -6413,8 +6424,12 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, u64 offset,
 		io_geom->raid56_full_stripe_start = btrfs_stripe_nr_to_offset(
 			rounddown(io_geom->stripe_nr, nr_data_stripes(map)));
 
-		ASSERT(io_geom->raid56_full_stripe_start + full_stripe_len > offset);
-		ASSERT(io_geom->raid56_full_stripe_start <= offset);
+		VASSERT(io_geom->raid56_full_stripe_start + full_stripe_len > offset,
+			"raid56_full_stripe_start=%llu full_stripe_len=%lu offset=%llu",
+			io_geom->raid56_full_stripe_start, full_stripe_len, offset);
+		VASSERT(io_geom->raid56_full_stripe_start <= offset,
+			"raid56_full_stripe_start=%llu offset=%llu",
+			io_geom->raid56_full_stripe_start, offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
@@ -6580,7 +6595,7 @@ static void map_blocks_raid56_read(struct btrfs_chunk_map *map,
 {
 	int data_stripes = nr_data_stripes(map);
 
-	ASSERT(io_geom->mirror_num <= 1);
+	VASSERT(io_geom->mirror_num <= 1, "mirror_num=%d", io_geom->mirror_num);
 	/* Just grab the data stripe directly. */
 	io_geom->stripe_index = io_geom->stripe_nr % data_stripes;
 	io_geom->stripe_nr /= data_stripes;
@@ -7925,7 +7940,7 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans)
 {
 	struct btrfs_device *curr, *next;
 
-	ASSERT(trans->state == TRANS_STATE_COMMIT_DOING);
+	VASSERT(trans->state == TRANS_STATE_COMMIT_DOING, "state=%d" , trans->state);
 
 	if (list_empty(&trans->dev_update_list))
 		return;
@@ -8299,7 +8314,7 @@ static void map_raid56_repair_block(struct btrfs_io_context *bioc,
 		    logical < stripe_start + BTRFS_STRIPE_LEN)
 			break;
 	}
-	ASSERT(i < data_stripes);
+	VASSERT(i < data_stripes, "i=%d data_stripes=%d", i, data_stripes);
 	smap->dev = bioc->stripes[i].dev;
 	smap->physical = bioc->stripes[i].physical +
 			((logical - bioc->full_stripe_logical) &
@@ -8328,7 +8343,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 	int mirror_ret = mirror_num;
 	int ret;
 
-	ASSERT(mirror_num > 0);
+	VASSERT(mirror_num > 0, "mirror_num=%d", mirror_num);
 
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
 			      &bioc, smap, &mirror_ret);
@@ -8336,7 +8351,8 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	/* The map range should not cross stripe boundary. */
-	ASSERT(map_length >= length);
+	VASSERT(map_length >= length,
+		"map_length=%llu length=%u", map_length, length);
 
 	/* Already mapped to single stripe. */
 	if (!bioc)
@@ -8348,7 +8364,8 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	ASSERT(mirror_num <= bioc->num_stripes);
+	VASSERT(mirror_num <= bioc->num_stripes,
+		"mirror_num=%d num_stripes=%d", mirror_num,  bioc->num_stripes);
 	smap->dev = bioc->stripes[mirror_num - 1].dev;
 	smap->physical = bioc->stripes[mirror_num - 1].physical;
 out:
-- 
2.49.0


