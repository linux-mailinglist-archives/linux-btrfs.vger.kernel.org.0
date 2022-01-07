Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7E487354
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 08:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiAGHKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 02:10:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiAGHKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 02:10:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD6851F397
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641539410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1SGuOU/tXTzfayhDzEVl/3jALzdEDQAxEWW1ZJGp9I=;
        b=h9kD9pyomn+uwGsROuNvSzpKZsNbRt0PUF57u+WlNN1FzD6aGfqtk2c7b3b+gCoxWa1c8L
        AHfkdAlOADEOBs3y/pk5YykvutpcSvuIVlvNcSFuVkABvD6xSo8YGMSz6P2MMCXJyIugz7
        DttKDvFxQmF5vWY4d6CDNI3IrdDfqMU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38B8A13CA1
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 07:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KwBAVLn12EnHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jan 2022 07:10:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: refactor scrub_raid56_parity()
Date:   Fri,  7 Jan 2022 15:09:50 +0800
Message-Id: <20220107070951.48246-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107070951.48246-1-wqu@suse.com>
References: <20220107070951.48246-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently scrub_raid56_parity() has a large double loop, handling the
following things at the same time:

- Iterate each data stripe
- Iterate each extent item in one data stripe

Refactor this mess by:

- Introduce a new helper to handle data stripe iteration
  The new helper is scrub_raid56_data_stripe_for_parity(), which
  only has one while() loop handling the extent items inside the
  data stripe.

  The code is still mostly the same as the old code.

- Call cond_resched() for each extent
  Previously we only call cond_resched() under a complex if () check.
  I see no special reason to do that, and for other scrub functions,
  like scrub_simple_mirror() we're already doing the same cond_resched()
  after scrubbing one extent.

- Add extra comments
  To improve the readability

Please note that, this patch is only to address the double loop, there
are incoming patches to do extra cleanup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 347 +++++++++++++++++++++++------------------------
 1 file changed, 166 insertions(+), 181 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9c6954d7f604..572852416b29 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3019,6 +3019,166 @@ static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
 		extent_start + extent_len > boundary_start + boudary_len);
 }
 
+static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
+					       struct scrub_parity *sparity,
+					       struct map_lookup *map,
+					       struct btrfs_device *sdev,
+					       struct btrfs_path *path,
+					       u64 logical)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
+	struct btrfs_key key;
+	int ret;
+
+	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+
+	/* Path should not be populated */
+	ASSERT(!path->nodes[0]);
+
+	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
+		key.type = BTRFS_METADATA_ITEM_KEY;
+	else
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.objectid = logical;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0) {
+		ret = btrfs_previous_extent_item(extent_root, path, 0);
+		if (ret < 0)
+			return ret;
+		if (ret > 0) {
+			btrfs_release_path(path);
+			ret = btrfs_search_slot(NULL, extent_root, &key, path,
+						0, 0);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	while (1) {
+		struct btrfs_io_context *bioc = NULL;
+		struct btrfs_device *extent_dev;
+		struct btrfs_extent_item *ei;
+		struct extent_buffer *l;
+		int slot;
+		u64 mapped_length;
+		u64 extent_size;
+		u64 extent_flags;
+		u64 extent_gen;
+		u64 extent_start;
+		u64 extent_physical;
+		u64 extent_mirror_num;
+
+		l = path->nodes[0];
+		slot = path->slots[0];
+		if (slot >= btrfs_header_nritems(l)) {
+			ret = btrfs_next_leaf(extent_root, path);
+			if (ret == 0)
+				continue;
+
+			/* No more extent items or error, exit */
+			break;
+		}
+		btrfs_item_key_to_cpu(l, &key, slot);
+
+		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
+		    key.type != BTRFS_METADATA_ITEM_KEY)
+			goto next;
+
+		if (key.type == BTRFS_METADATA_ITEM_KEY)
+			extent_size = fs_info->nodesize;
+		else
+			extent_size = key.offset;
+
+		if (key.objectid + extent_size <= logical)
+			goto next;
+
+		/* Beyond this data stripe */
+		if (key.objectid >= logical + map->stripe_len)
+			break;
+
+		ei = btrfs_item_ptr(l, slot, struct btrfs_extent_item);
+		extent_flags = btrfs_extent_flags(l, ei);
+		extent_gen = btrfs_extent_generation(l, ei);
+
+		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
+		    (key.objectid < logical || key.objectid + extent_size >
+		     logical + map->stripe_len)) {
+			btrfs_err(fs_info,
+				  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
+				  key.objectid, logical);
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.uncorrectable_errors++;
+			spin_unlock(&sctx->stat_lock);
+			goto next;
+		}
+
+		extent_start = key.objectid;
+		ASSERT(extent_size <= U32_MAX);
+
+		/* Truncate the range inside the data stripe */
+		if (extent_start < logical) {
+			extent_size -= logical - extent_start;
+			extent_start = logical;
+		}
+		if (extent_start + extent_size > logical + map->stripe_len)
+			extent_size = logical + map->stripe_len - extent_start;
+
+		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
+
+		mapped_length = extent_size;
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_start,
+				      &mapped_length, &bioc, 0);
+		if (!ret) {
+			if (!bioc || mapped_length < extent_size)
+				ret = -EIO;
+		}
+		if (ret) {
+			btrfs_put_bioc(bioc);
+			scrub_parity_mark_sectors_error(sparity, extent_start,
+							extent_size);
+			break;
+		}
+		extent_physical = bioc->stripes[0].physical;
+		extent_mirror_num = bioc->mirror_num;
+		extent_dev = bioc->stripes[0].dev;
+		btrfs_put_bioc(bioc);
+
+		ret = btrfs_lookup_csums_range(csum_root, extent_start,
+					       extent_start + extent_size - 1,
+					       &sctx->csum_list, 1);
+		if (ret) {
+			scrub_parity_mark_sectors_error(sparity, extent_start,
+							extent_size);
+			break;
+		}
+
+		ret = scrub_extent_for_parity(sparity, extent_start,
+					      extent_size, extent_physical,
+					      extent_dev, extent_flags,
+					      extent_gen, extent_mirror_num);
+		scrub_free_csums(sctx);
+
+		if (ret) {
+			scrub_parity_mark_sectors_error(sparity, extent_start,
+							extent_size);
+			break;
+		}
+
+		cond_resched();
+next:
+		path->slots[0]++;
+	}
+	btrfs_release_path(path);
+	return ret;
+}
+
 static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  struct map_lookup *map,
 						  struct btrfs_device *sdev,
@@ -3026,28 +3186,12 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  u64 logic_end)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, logic_start);
-	struct btrfs_root *csum_root;
-	struct btrfs_extent_item *extent;
-	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_path *path;
-	u64 flags;
+	u64 cur_logical;
 	int ret;
-	int slot;
-	struct extent_buffer *l;
-	struct btrfs_key key;
-	u64 generation;
-	u64 extent_logical;
-	u64 extent_physical;
-	/* Check the comment in scrub_stripe() for why u32 is enough here */
-	u32 extent_len;
-	u64 mapped_length;
-	struct btrfs_device *extent_dev;
 	struct scrub_parity *sparity;
 	int nsectors;
 	int bitmap_len;
-	int extent_mirror_num;
-	int stop_loop = 0;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -3085,173 +3229,14 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	sparity->ebitmap = (void *)sparity->bitmap + bitmap_len;
 
 	ret = 0;
-	while (logic_start < logic_end) {
-		if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
-			key.type = BTRFS_METADATA_ITEM_KEY;
-		else
-			key.type = BTRFS_EXTENT_ITEM_KEY;
-		key.objectid = logic_start;
-		key.offset = (u64)-1;
-
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	for (cur_logical = logic_start; cur_logical < logic_end;
+	     cur_logical += map->stripe_len) {
+		ret = scrub_raid56_data_stripe_for_parity(sctx, sparity, map,
+							  sdev, path, cur_logical);
 		if (ret < 0)
-			goto out;
-
-		if (ret > 0) {
-			ret = btrfs_previous_extent_item(root, path, 0);
-			if (ret < 0)
-				goto out;
-			if (ret > 0) {
-				btrfs_release_path(path);
-				ret = btrfs_search_slot(NULL, root, &key,
-							path, 0, 0);
-				if (ret < 0)
-					goto out;
-			}
-		}
-
-		stop_loop = 0;
-		while (1) {
-			u64 bytes;
-
-			l = path->nodes[0];
-			slot = path->slots[0];
-			if (slot >= btrfs_header_nritems(l)) {
-				ret = btrfs_next_leaf(root, path);
-				if (ret == 0)
-					continue;
-				if (ret < 0)
-					goto out;
-
-				stop_loop = 1;
-				break;
-			}
-			btrfs_item_key_to_cpu(l, &key, slot);
-
-			if (key.type != BTRFS_EXTENT_ITEM_KEY &&
-			    key.type != BTRFS_METADATA_ITEM_KEY)
-				goto next;
-
-			if (key.type == BTRFS_METADATA_ITEM_KEY)
-				bytes = fs_info->nodesize;
-			else
-				bytes = key.offset;
-
-			if (key.objectid + bytes <= logic_start)
-				goto next;
-
-			if (key.objectid >= logic_end) {
-				stop_loop = 1;
-				break;
-			}
-
-			while (key.objectid >= logic_start + map->stripe_len)
-				logic_start += map->stripe_len;
-
-			extent = btrfs_item_ptr(l, slot,
-						struct btrfs_extent_item);
-			flags = btrfs_extent_flags(l, extent);
-			generation = btrfs_extent_generation(l, extent);
-
-			if ((flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
-			    (key.objectid < logic_start ||
-			     key.objectid + bytes >
-			     logic_start + map->stripe_len)) {
-				btrfs_err(fs_info,
-					  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
-					  key.objectid, logic_start);
-				spin_lock(&sctx->stat_lock);
-				sctx->stat.uncorrectable_errors++;
-				spin_unlock(&sctx->stat_lock);
-				goto next;
-			}
-again:
-			extent_logical = key.objectid;
-			ASSERT(bytes <= U32_MAX);
-			extent_len = bytes;
-
-			if (extent_logical < logic_start) {
-				extent_len -= logic_start - extent_logical;
-				extent_logical = logic_start;
-			}
-
-			if (extent_logical + extent_len >
-			    logic_start + map->stripe_len)
-				extent_len = logic_start + map->stripe_len -
-					     extent_logical;
-
-			scrub_parity_mark_sectors_data(sparity, extent_logical,
-						       extent_len);
-
-			mapped_length = extent_len;
-			bioc = NULL;
-			ret = btrfs_map_block(fs_info, BTRFS_MAP_READ,
-					extent_logical, &mapped_length, &bioc,
-					0);
-			if (!ret) {
-				if (!bioc || mapped_length < extent_len)
-					ret = -EIO;
-			}
-			if (ret) {
-				btrfs_put_bioc(bioc);
-				goto out;
-			}
-			extent_physical = bioc->stripes[0].physical;
-			extent_mirror_num = bioc->mirror_num;
-			extent_dev = bioc->stripes[0].dev;
-			btrfs_put_bioc(bioc);
-
-			csum_root = btrfs_csum_root(fs_info, extent_logical);
-			ret = btrfs_lookup_csums_range(csum_root,
-						extent_logical,
-						extent_logical + extent_len - 1,
-						&sctx->csum_list, 1);
-			if (ret)
-				goto out;
-
-			ret = scrub_extent_for_parity(sparity, extent_logical,
-						      extent_len,
-						      extent_physical,
-						      extent_dev, flags,
-						      generation,
-						      extent_mirror_num);
-
-			scrub_free_csums(sctx);
-
-			if (ret)
-				goto out;
-
-			if (extent_logical + extent_len <
-			    key.objectid + bytes) {
-				logic_start += map->stripe_len;
-
-				if (logic_start >= logic_end) {
-					stop_loop = 1;
-					break;
-				}
-
-				if (logic_start < key.objectid + bytes) {
-					cond_resched();
-					goto again;
-				}
-			}
-next:
-			path->slots[0]++;
-		}
-
-		btrfs_release_path(path);
-
-		if (stop_loop)
 			break;
-
-		logic_start += map->stripe_len;
-	}
-out:
-	if (ret < 0) {
-		ASSERT(logic_end - logic_start <= U32_MAX);
-		scrub_parity_mark_sectors_error(sparity, logic_start,
-						logic_end - logic_start);
 	}
+
 	scrub_parity_put(sparity);
 	scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
-- 
2.34.1

