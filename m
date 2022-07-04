Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19D564CE1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiGDE65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiGDE6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8426D0
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910732; x=1688446732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dPMJP16w9Vb71KHsDc9D0IS2u03xDNbO/+hoBnN+Nu4=;
  b=GGTmLPLfOS/mWtCGP91/U2HxikmoaOvEKNArghV12pO4JlBZMTgEfd8h
   D1HtinHeQot3h9bciM9HNkvDApK+5uyjZWyAz5Yby7hztMbyp4emggIPh
   IeY3I0c3ipnTVX+t4Y4JFzj54fL7Qulu5HUGVHfUSyZixhsHFygBdx8Ya
   Y+28gnV8wa/whIW9MFFWz2cI0j50SLQ7gxw+bObYAvzKKRvpqKbazydms
   2wTWkYx/ldWcwMySk/gcMl+BYqCIm/UPnyuDCf+Ifuz9YjRgX+GmdQ/KT
   sJjNdnd+vn54l3Pt7IKY5SDGOHFXvTsswib3iRhLM26kj2NYSjtSdZ6OQ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732408"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:52 +0800
IronPort-SDR: /euiknmKQeduV5zViIvV0DdPnDH/eKwNdK1tiLOajGX7yhFJj0sZnukDYd/lfZ23f4BiFM8oGI
 w7HO00fCzxAOD1zO508v9boV9pWl7kEiivmB2bxGjLeLOp7zBDW1ARWSyJvyUJGh3O/nKvuoCl
 +UuQwSK4AEYdR6QcbAjfLyh+1WBW2UszcR4l+2o97r+XB1jQ+hVxDCSuphWYXOyGN4FosPmxVB
 cYXeGoKxaYdP2qLMnCIq6+pOWQMS3QYFXkxUZe+nbWeZ8E2Y1v+GUPPamenFpOtUVeCemGl+Ik
 2xhfCVBQkbe1EgnjS7EErr+t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:45 -0700
IronPort-SDR: uFXXbNTBppuWZ1W9qgSdSGHoPoXPY/kqHrsE8cZOXhgtyjefHKuZ52jwPvuS1/0/9meFc0rFxn
 Fz+ld5Xkkz73LlTOIBPvoS85wy+7zWza+Qw3QQ0iCbvF9v2oKW2DiSX/oeNEhsFoD6fPwjrPr6
 Nn9zP2MMnvsw1Trij5cjUlV+pwdvYy49GLNxabf0IcNI0ZliWj4I+p/I8SgvhKuokNnCozT88B
 p7jjbHA48TFvtn3jPoBJCbc48l1pBTzY6CbeDUFoUBI+5n6Wc69yY7jPOakq5ZQGsoSuphkxU0
 4g4=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/13] btrfs: zoned: introduce space_info->active_total_bytes
Date:   Mon,  4 Jul 2022 13:58:12 +0900
Message-Id: <b8b9efd1c21d28dbcda5c2da0080c266455f8ae9.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The active_total_bytes, like the total_bytes, accounts for the total bytes
of active block groups in the space_info.

With an introduction of active_total_bytes, we can check if the reserved
bytes can be written to the block groups without activating a new block
group. The check is necessary for metadata allocation on zoned btrfs. We
cannot finish a block group, which may require waiting for the current
transaction, from the metadata allocation context. Instead, we need to
ensure the on-going allocation (reserved bytes) fits in active block
groups.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 12 +++++++++---
 fs/btrfs/space-info.c  | 41 ++++++++++++++++++++++++++++++++---------
 fs/btrfs/space-info.h  |  4 +++-
 fs/btrfs/zoned.c       | 16 ++++++++++++++++
 4 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e930749770ac..51e7c1f1d93f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1051,8 +1051,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
+		WARN_ON(block_group->zone_is_active &&
+			block_group->space_info->active_total_bytes
+			< block_group->length);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
+	if (block_group->zone_is_active)
+		block_group->space_info->active_total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
 	block_group->space_info->bytes_zone_unusable -=
@@ -2107,7 +2112,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
 				cache->used, cache->bytes_super,
-				cache->zone_unusable, &space_info);
+				cache->zone_unusable, cache->zone_is_active,
+				&space_info);
 
 	cache->space_info = space_info;
 
@@ -2177,7 +2183,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, 0, &space_info);
+					0, 0, false, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2558,7 +2564,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
 				cache->bytes_super, cache->zone_unusable,
-				&cache->space_info);
+				cache->zone_is_active, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 62d25112310d..c7a60341b2d2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -295,7 +295,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
 			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     struct btrfs_space_info **space_info)
+			     bool active, struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
 	int factor;
@@ -306,6 +306,8 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += total_bytes;
+	if (active)
+		found->active_total_bytes += total_bytes;
 	found->disk_total += total_bytes * factor;
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
@@ -369,6 +371,22 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	return avail;
 }
 
+static inline u64 writable_total_bytes(struct btrfs_fs_info *fs_info,
+				       struct btrfs_space_info *space_info)
+{
+	/*
+	 * On regular btrfs, all total_bytes are always writable. On zoned
+	 * btrfs, there may be a limitation imposed by max_active_zzones. For
+	 * metadata allocation, we cannot finish an existing active block group
+	 * to avoid a deadlock. Thus, we need to consider only the active groups
+	 * to be writable for metadata space.
+	 */
+	if (!btrfs_is_zoned(fs_info) || (space_info->flags & BTRFS_BLOCK_GROUP_DATA))
+		return space_info->total_bytes;
+
+	return space_info->active_total_bytes;
+}
+
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 			 struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush)
@@ -383,7 +401,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 	used = btrfs_space_info_used(space_info, true);
 	avail = calc_available_free_space(fs_info, space_info, flush);
 
-	if (used + bytes < space_info->total_bytes + avail)
+	if (used + bytes < writable_total_bytes(fs_info, space_info) + avail)
 		return 1;
 	return 0;
 }
@@ -419,7 +437,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(head, struct reserve_ticket, list);
 
 		/* Check and see if our ticket can be satisfied now. */
-		if ((used + ticket->bytes <= space_info->total_bytes) ||
+		if ((used + ticket->bytes <= writable_total_bytes(fs_info, space_info)) ||
 		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
 					 flush)) {
 			btrfs_space_info_update_bytes_may_use(fs_info,
@@ -750,6 +768,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
+	u64 total;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -764,8 +783,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	 * space.  If that's the case add in our overage so we make sure to put
 	 * appropriate pressure on the flushing state machine.
 	 */
-	if (space_info->total_bytes + avail < used)
-		to_reclaim += used - (space_info->total_bytes + avail);
+	total = writable_total_bytes(fs_info, space_info);
+	if (total + avail < used)
+		to_reclaim += used - (total + avail);
 
 	return to_reclaim;
 }
@@ -775,9 +795,12 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 {
 	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
 	u64 ordered, delalloc;
-	u64 thresh = div_factor_fine(space_info->total_bytes, 90);
+	u64 total = writable_total_bytes(fs_info, space_info);
+	u64 thresh;
 	u64 used;
 
+	thresh = div_factor_fine(total, 90);
+
 	lockdep_assert_held(&space_info->lock);
 
 	/* If we're just plain full then async reclaim just slows us down. */
@@ -839,8 +862,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	used = space_info->bytes_used + space_info->bytes_reserved +
 	       space_info->bytes_readonly + global_rsv_size;
-	if (used < space_info->total_bytes)
-		thresh += space_info->total_bytes - used;
+	if (used < total)
+		thresh += total - used;
 	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_pinned;
@@ -1557,7 +1580,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	 * can_overcommit() to ensure we can overcommit to continue.
 	 */
 	if (!pending_tickets &&
-	    ((used + orig_bytes <= space_info->total_bytes) ||
+	    ((used + orig_bytes <= writable_total_bytes(fs_info, space_info)) ||
 	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index e7de24a529cf..3cc356a55c53 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -19,6 +19,8 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
+	u64 active_total_bytes;	/* total bytes in the space, but only accounts
+					   active block groups. */
 	u64 bytes_zone_unusable;	/* total bytes that are unusable until
 					   resetting the device zone */
 
@@ -124,7 +126,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
 			     u64 bytes_readonly, u64 bytes_zone_unusable,
-			     struct btrfs_space_info **space_info);
+			     bool active, struct btrfs_space_info **space_info);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4a69e8492177..9cabf088b800 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1838,6 +1838,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
 	u64 physical;
@@ -1849,6 +1850,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	map = block_group->physical_map;
 
+	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (block_group->zone_is_active) {
 		ret = true;
@@ -1877,7 +1879,10 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* Successfully activated all the zones */
 	block_group->zone_is_active = 1;
+	space_info->active_total_bytes += block_group->length;
 	spin_unlock(&block_group->lock);
+	btrfs_try_granting_tickets(fs_info, space_info);
+	spin_unlock(&space_info->lock);
 
 	/* For the active block group list */
 	btrfs_get_block_group(block_group);
@@ -1890,20 +1895,24 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 out_unlock:
 	spin_unlock(&block_group->lock);
+	spin_unlock(&space_info->lock);
 	return ret;
 }
 
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	bool need_zone_finish;
 	int ret = 0;
 	int i;
 
+	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (!block_group->zone_is_active) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 		return 0;
 	}
 
@@ -1912,6 +1921,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
 	    block_group->start + block_group->alloc_offset > block_group->meta_write_pointer) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 		return -EAGAIN;
 	}
 
@@ -1924,6 +1934,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	 */
 	if (!fully_written) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 
 		ret = btrfs_inc_block_group_ro(block_group, false);
 		if (ret)
@@ -1935,6 +1946,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
 					 block_group->length);
 
+		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 
 		/*
@@ -1943,12 +1955,14 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		 */
 		if (!block_group->zone_is_active) {
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return 0;
 		}
 
 		if (block_group->reserved) {
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return -EAGAIN;
 		}
@@ -1965,7 +1979,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
 	btrfs_clear_data_reloc_bg(block_group);
+	space_info->active_total_bytes -= block_group->length;
 	spin_unlock(&block_group->lock);
+	spin_unlock(&space_info->lock);
 
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-- 
2.35.1

