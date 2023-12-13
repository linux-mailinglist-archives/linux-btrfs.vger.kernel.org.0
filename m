Return-Path: <linux-btrfs+bounces-903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC275810CD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF851C20A4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF84E1EB4B;
	Wed, 13 Dec 2023 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+v7+9tI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCBDAC;
	Wed, 13 Dec 2023 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KOXFx/9HdBZDWCya+V7EM00JHK64SSnJ0Yck8gKE+VY=; b=B+v7+9tI8rI6SJOeeIOWu5vk/d
	fb1bmNF1PqnTch/mw+kob+ok/BfNqq3gRQJ+wIuFiNq1rxRP+eWuP/cB+x88Q0tGliGIyt5ewjoBe
	LavDbnHNgM+qGVd5eF9/vKTL9GdlIJj96qRsGsxfI9miaauAHjfTGPGRT3LnB1jHD6AMa7gN88Gco
	0g503PydASF7X2oac+/HV+popb2v5kB4aPy2HKB0ZWQw/qyHk004SdQP9kQbfh74DPD2fpyXQ/jcP
	IMVJQVUr6+A/z4LT+hzSeFmvO/Zej0nCSnT1p9Q0jOpiWlgQNppbihtAPr+KdaMqpC/oyn3ImR/MJ
	Bj68k7pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDL4g-00E5ub-0v;
	Wed, 13 Dec 2023 08:58:38 +0000
Date: Wed, 13 Dec 2023 00:58:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Message-ID: <ZXlyPqtXO+j90vJb@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 12, 2023 at 04:38:09AM -0800, Johannes Thumshirn wrote:
> Open code set_io_stripe() for RAID56, as it a) uses a different method to
> calculate the stripe_index and b) doesn't need to go through raid-stripe-tree
> mapping code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I think raid stripe tree handling also really should move out of
set_io_stripe.  Below is the latest I have, although it probably won't
apply to your tree:

---
From ac208da48d7f9d11eef8a01ac0c6fbf9681665b5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Jun 2023 05:53:13 +0200
Subject: btrfs: move raid-stripe-tree handling out of set_io_stripe

set_io_stripe gets a little too complicated with the raid-stripe-tree
handling.  Move it out into the only callers that actually needs it.

The only reads with more than a single stripe is the parity raid recovery
case thast will need very special handling anyway once implemented.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 61 ++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 30ee5d1670d034..e32eefa242b0a4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6233,22 +6233,12 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 	return U64_MAX;
 }
 
-static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
-		      struct map_lookup *map, u32 stripe_index,
-		      u64 stripe_offset, u64 stripe_nr)
+static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
+			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
 {
 	dst->dev = map->stripes[stripe_index].dev;
-
-	if (op == BTRFS_MAP_READ &&
-	    btrfs_use_raid_stripe_tree(fs_info, map->type))
-		return btrfs_get_raid_extent_offset(fs_info, logical, length,
-						    map->type, stripe_index,
-						    dst);
-
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
-	return 0;
 }
 
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6423,15 +6413,24 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * physical block information on the stack instead of allocating an
 	 * I/O context structure.
 	 */
-	if (smap && num_alloc_stripes == 1 &&
-	    !(btrfs_use_raid_stripe_tree(fs_info, map->type) &&
-	      op != BTRFS_MAP_READ) &&
-	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
-		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
-				    stripe_index, stripe_offset, stripe_nr);
-		*mirror_num_ret = mirror_num;
-		*bioc_ret = NULL;
-		goto out;
+	if (smap && num_alloc_stripes == 1) {
+		if (op == BTRFS_MAP_READ &&
+		    btrfs_use_raid_stripe_tree(fs_info, map->type)) {
+			ret = btrfs_get_raid_extent_offset(fs_info, logical,
+							   length, map->type,
+							   stripe_index, smap);
+			*mirror_num_ret = mirror_num;
+			*bioc_ret = NULL;
+			goto out;
+		} else if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) ||
+			   mirror_num == 0) {
+			set_io_stripe(smap, map, stripe_index, stripe_offset,
+				      stripe_nr);
+			*mirror_num_ret = mirror_num;
+			*bioc_ret = NULL;
+			ret = 0;
+			goto out;
+		}
 	}
 
 	bioc = alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes);
@@ -6448,6 +6447,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 *
 	 * It's still mostly the same as other profiles, just with extra rotation.
 	 */
+	ASSERT(op != BTRFS_MAP_READ ||
+	       btrfs_use_raid_stripe_tree(fs_info, map->type));
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
 	    (op != BTRFS_MAP_READ || mirror_num > 1)) {
 		/*
@@ -6461,29 +6462,21 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		bioc->full_stripe_logical = em->start +
 			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
 		for (i = 0; i < num_stripes; i++)
-			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map,
-					    (i + stripe_nr) % num_stripes,
-					    stripe_offset, stripe_nr);
+			set_io_stripe(&bioc->stripes[i], map,
+				      (i + stripe_nr) % num_stripes,
+				      stripe_offset, stripe_nr);
 	} else {
 		/*
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
 		for (i = 0; i < num_stripes; i++) {
-			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map, stripe_index,
-					    stripe_offset, stripe_nr);
+			set_io_stripe(&bioc->stripes[i], map, stripe_index,
+				      stripe_offset, stripe_nr);
 			stripe_index++;
 		}
 	}
 
-	if (ret) {
-		*bioc_ret = NULL;
-		btrfs_put_bioc(bioc);
-		goto out;
-	}
-
 	if (op != BTRFS_MAP_READ)
 		max_errors = btrfs_chunk_max_errors(map);
 
-- 
2.39.2


