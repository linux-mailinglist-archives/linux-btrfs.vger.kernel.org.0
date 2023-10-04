Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5C7B792A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjJDH4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241603AbjJDH42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 03:56:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1555A7;
        Wed,  4 Oct 2023 00:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696406184; x=1727942184;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oOaBzvLzYxk5pgsPN1ktOBI6k/bFMn2voCQvb+dd7HM=;
  b=mSiSv6G4Uxc67gEh4KVdZ192IRd6d5eQc73+4UN8ImmAgoAAMUtwYISB
   cyR5d8HM/N+8kWcQ3khZheRrtpuJLAjkJ2ZIiBnO+reuDaCbGBJZU5A/0
   tSFLpQED/+LRRcGaxxJRwDu2zD2kXrBKRi5JRJO2w21gXY42OhmgoqHu9
   nn7f7ImZiqtXFmLScYpz4R7maJd+i7Qgg8qrVgiu8l/JMFBXY5Zcyo5PG
   YCUcc3vdbBNs9J3p68yDZkXCZrwHNoHTC67jSBYIELD3g3BezKN1s+Wjn
   PtLQyoGKKgNFjcPRi+v8ddDcBQ/DTM7yDjPwQ3sT0yEjKcfMoxjYRwvh5
   Q==;
X-CSE-ConnectionGUID: BecG0bTiR/KGmWHVRZ7o4g==
X-CSE-MsgGUID: MhwPEGn7SBe0/es3kUKmEA==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="351024162"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 15:56:23 +0800
IronPort-SDR: h/ICLCPZSui84k7Wty79D/LTga+m2qaYXQBU+oswB2rWBa5ztf9AlJThZUlM2bQBsBfL4mCB4g
 478GcvUDhWW2MlAvHBXJwsoBZW1SbpapEcrWxN504O4zikW6GIf6u0M+GqpANg26XT7HtwUEJY
 4rhoGxdDo7iyiuSmp9GodgQ+1TALdhuAls4ssnG0x8zFckyd9JtSE2+C8UQUz+HzQB6kNuLf0p
 EHejaiu8cvyouAsUr1naiIVCf5yF/hiRxEW8lbP+f95fAkAuq53StLMTqiOTa6y2t5FKk2Nizo
 6p0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 00:03:01 -0700
IronPort-SDR: Bfe0qnoJ6OwQ3odKOmUXUgIgEH+Bk+4VDuKjaRMWwP5iRTw2BQSVf2MgJdNScI+8kesMPvoqjK
 sY939ms9htlVEQ2wutdMAfPUoBDJf2eBxIfise6hnKYkSZvFx1lRqMcBVdchQE56k9FWTuk/lV
 9iSUctWLCNtxvE1Kk+2JKsH8jTbFXDWdvCqAPaYyDe1zANHPLOUZabxR3jek33fG4Gtkne9sL0
 g4lEAGDtmk7NLBoWT7spsMuQQDoCWYeRVx+L4vGF1KykpzBRY4zakbhkRxQkCpbM/8mueLdpAZ
 2Dw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2023 00:56:23 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 04 Oct 2023 00:56:16 -0700
Subject: [PATCH v3 1/4] btrfs: change RST write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-rst-updates-v3-1-7729c4474ade@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696406180; l=6579;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=oOaBzvLzYxk5pgsPN1ktOBI6k/bFMn2voCQvb+dd7HM=;
 b=4odRZdfbn24hd6VqjX85IQeOKsxFxDe1OKzkyhb2LUgii50StBOu5f35vRzt+MB7xRjxBaeG3
 OzDug3jhT1wCafx5VEivIGndBQ9szzW+B65s1nmLXgzKUfJJG0UvfUj
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 165 ++------------------------------------------
 1 file changed, 5 insertions(+), 160 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 8a38f07a3246..248e048810d3 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -75,12 +75,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 }
 
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
-					int num_stripes,
 					struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key stripe_key;
 	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	const int num_stripes = btrfs_bg_type_to_factor(bioc->map_type);
 	u8 encoding = btrfs_bg_flags_to_raid_index(bioc->map_type);
 	struct btrfs_stripe_extent *stripe_extent;
 	const size_t item_size = struct_size(stripe_extent, strides, num_stripes);
@@ -107,7 +107,6 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
 		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
-		btrfs_set_stack_raid_stride_length(raid_stride, length);
 	}
 
 	stripe_key.objectid = bioc->logical;
@@ -124,173 +123,19 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_insert_mirrored_raid_extents(struct btrfs_trans_handle *trans,
-					      struct btrfs_ordered_extent *ordered,
-					      u64 map_type)
-{
-	int num_stripes = btrfs_bg_type_to_factor(map_type);
-	struct btrfs_io_context *bioc;
-	int ret;
-
-	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
-		ret = btrfs_insert_one_raid_extent(trans, num_stripes, bioc);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int btrfs_insert_striped_mirrored_raid_extents(
-				      struct btrfs_trans_handle *trans,
-				      struct btrfs_ordered_extent *ordered,
-				      u64 map_type)
-{
-	struct btrfs_io_context *bioc;
-	struct btrfs_io_context *rbioc;
-	const size_t nstripes = list_count_nodes(&ordered->bioc_list);
-	const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
-	const int substripes = btrfs_raid_array[index].sub_stripes;
-	const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices,
-					substripes);
-	int left = nstripes;
-	int i;
-	int ret = 0;
-	u64 stripe_end;
-	u64 prev_end;
-	int stripe;
-
-	if (nstripes == 1)
-		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
-
-	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes * substripes), GFP_NOFS);
-	if (!rbioc)
-		return -ENOMEM;
-
-	rbioc->map_type = map_type;
-	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
-					  rst_ordered_entry)->logical;
-
-	stripe_end = rbioc->logical;
-	prev_end = stripe_end;
-	i = 0;
-	stripe = 0;
-	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
-		rbioc->size += bioc->size;
-		for (int j = 0; j < substripes; j++) {
-			stripe = i + j;
-			rbioc->stripes[stripe].dev = bioc->stripes[j].dev;
-			rbioc->stripes[stripe].physical = bioc->stripes[j].physical;
-			rbioc->stripes[stripe].length = bioc->size;
-		}
-
-		stripe_end += rbioc->size;
-		if (i >= nstripes ||
-		    (stripe_end - prev_end >= max_stripes * BTRFS_STRIPE_LEN)) {
-			ret = btrfs_insert_one_raid_extent(trans, stripe + 1, rbioc);
-			if (ret)
-				goto out;
-
-			left -= stripe + 1;
-			if (left <= 0)
-				break;
-
-			i = 0;
-			rbioc->logical += rbioc->size;
-			rbioc->size = 0;
-		} else {
-			i += substripes;
-			prev_end = stripe_end;
-		}
-	}
-
-	if (left > 0) {
-		bioc = list_prev_entry(bioc, rst_ordered_entry);
-		ret = btrfs_insert_one_raid_extent(trans, substripes, bioc);
-	}
-
-out:
-	kfree(rbioc);
-	return ret;
-}
-
-static int btrfs_insert_striped_raid_extents(struct btrfs_trans_handle *trans,
-				     struct btrfs_ordered_extent *ordered,
-				     u64 map_type)
-{
-	struct btrfs_io_context *bioc;
-	struct btrfs_io_context *rbioc;
-	const size_t nstripes = list_count_nodes(&ordered->bioc_list);
-	int i;
-	int ret = 0;
-
-	rbioc = kzalloc(struct_size(rbioc, stripes, nstripes), GFP_NOFS);
-	if (!rbioc)
-		return -ENOMEM;
-	rbioc->map_type = map_type;
-	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
-					  rst_ordered_entry)->logical;
-
-	i = 0;
-	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
-		rbioc->size += bioc->size;
-		rbioc->stripes[i].dev = bioc->stripes[0].dev;
-		rbioc->stripes[i].physical = bioc->stripes[0].physical;
-		rbioc->stripes[i].length = bioc->size;
-
-		if (i == nstripes - 1) {
-			ret = btrfs_insert_one_raid_extent(trans, nstripes, rbioc);
-			if (ret)
-				goto out;
-
-			i = 0;
-			rbioc->logical += rbioc->size;
-			rbioc->size = 0;
-		} else {
-			i++;
-		}
-	}
-
-	if (i && i < nstripes - 1)
-		ret = btrfs_insert_one_raid_extent(trans, i, rbioc);
-
-out:
-	kfree(rbioc);
-	return ret;
-}
-
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent)
 {
 	struct btrfs_io_context *bioc;
-	u64 map_type;
 	int ret;
 
 	if (!btrfs_fs_incompat(trans->fs_info, RAID_STRIPE_TREE))
 		return 0;
 
-	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),
-				    rst_ordered_entry)->map_type;
-
-	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-	case BTRFS_BLOCK_GROUP_DUP:
-	case BTRFS_BLOCK_GROUP_RAID1:
-	case BTRFS_BLOCK_GROUP_RAID1C3:
-	case BTRFS_BLOCK_GROUP_RAID1C4:
-		ret = btrfs_insert_mirrored_raid_extents(trans, ordered_extent, map_type);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID0:
-		ret = btrfs_insert_striped_raid_extents(trans, ordered_extent, map_type);
-		break;
-	case BTRFS_BLOCK_GROUP_RAID10:
-		ret = btrfs_insert_striped_mirrored_raid_extents(trans, ordered_extent,
-								 map_type);
-		break;
-	default:
-		btrfs_err(trans->fs_info, "trying to insert unknown block group profile %lld",
-			  map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
-		ret = -EINVAL;
-		break;
+	list_for_each_entry(bioc, &ordered_extent->bioc_list, rst_ordered_entry) {
+		ret = btrfs_insert_one_raid_extent(trans, bioc);
+		if (ret)
+			return ret;
 	}
 
 	while (!list_empty(&ordered_extent->bioc_list)) {

-- 
2.41.0

