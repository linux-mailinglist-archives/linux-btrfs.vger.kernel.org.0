Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA24DB22E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354106AbiCPOKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354903AbiCPOKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 10:10:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F964ECDD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647439766; x=1678975766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGGA3WV+ACAzE/i4Wh0P3/Zt9F2O8ZlzJG8QRg4M+vI=;
  b=cNQ9dHjWM4DiJTuqacPVzJyf4mlgwoSW3qqurDgTZWII2dX+997GnZAe
   Qgv1yPoLWIlb5NlXmQfpIr0QlvjaMDnRzarEJ0ixb5tJBGIkXs5UsXEbN
   wYDJxrbFNj/C8UbAs5wTtVldZG8aL2z4Ub2xMMcvfqrfXHC90BzDfMycC
   mYkJbC0IXwKBNsjRcSG3LKoDZJnkzBTyY1CQt8ErpwFQ4sSsUYreOEdq4
   CcBxIN5DH7DsddBEx5BVr7zzZ2Tk1Nwx0y9VCit1poded4b4V4Tu14VU4
   tiqiqNQam6p0neda5NgLXnVUiWC10iQu8gvLj8A/eny2seju5or7SZ2/I
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="196448088"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 22:09:24 +0800
IronPort-SDR: GVvM7i21KL4PL8P1Vilr7y9dz6/GFucEcTBQ8tbUkRXTYNrzNqkVJbl+EFbqGtvYY2aJSfKUZN
 npXRrhmfJu1DZwqilOLH5yHz69S+evqf1E9U/3XIuRkqvj55NhdEyAq/5FVfqrf3MFG6baMZO2
 tYrahDhGRJ/jKFFLyE97eFcfXTWdLMAY83GGtohpj0CZD41P45aJASse/i3rOtaDdHi2Fpamz2
 AToL9mmLnM4D7vQ+xmCZj+oYXsRqxEMLTpM5VuFh5CTHowlQ+p94Z4GHLtvCtcYB/QGDy9m0uh
 pPbs6uQuJj6X0oovZNc16cHd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:40:28 -0700
IronPort-SDR: ecWt+dxxtw9A0afd3Crn1e8R4/JeBd7FHKqzH4V74vCn2SatjlTssCEgS7L4KlCtT5k5aRdBFM
 w13/N14BXUuoZpp9AKgMtjyMV+SRWvLfaUJCPUZBsCJMD1NyMtPejHTXmROCy2Jxe+Tk58+05m
 tr3l8yrxnoGpmLGnoEVeNqWRVmkQccp9iysKPor3vvlufPGuIe8FMyXPiNDSIY8wVqM5j0iZEr
 CZnEESz5T00EaHdl3FYMO+x+LB9lHtliKWnsLyJIzvX3dpHAO3I1z6ZD8mXcvVcjx5uSV681mk
 LIo=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 07:09:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: activate block group only for extent allocation
Date:   Wed, 16 Mar 2022 23:09:12 +0900
Message-Id: <186ca14c007ed18db3221bb883df19d3f0fcd8e8.1647437890.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647437890.git.naohiro.aota@wdc.com>
References: <cover.1647437890.git.naohiro.aota@wdc.com>
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

In btrfs_make_block_group(), we activate the allocated block group,
expecting that the block group is soon used for allocation. However, the
chunk allocation from flush_space() context broke the assumption. There can
be a large time gap between the chunk allocation time and the extent
allocation time from the chunk.

Activating the empty block groups pre-allocated from flush_space() context
can exhaust the active zone counter of a device. Once we use all the active
zone counts for empty pre-allocated BGs, we cannot activate new BG for the
other things: metadata, tree-log, or data relocation BG. That failure
results in a fake -ENOSPC.

This patch introduces CHUNK_ALLOC_FORCE_FOR_EXTENT to distinguish the chunk
allocation from find_free_extent(). Now, the new block group is activated
only in that context.

Fixes: eb66a010d518 ("btrfs: zoned: activate new block group")
Cc: stable@vger.kernel.org # 5.16+: c7d1b9109dd0: btrfs: return allocated block group from do_chunk_alloc()
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 24 ++++++++++++++++--------
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d4ac1c76f539..6caa86c8eb12 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2481,12 +2481,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
-	/*
-	 * New block group is likely to be used soon. Try to activate it now.
-	 * Failure is OK for now.
-	 */
-	btrfs_zone_activate(cache);
-
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
@@ -3642,8 +3636,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
+	bool from_extent_allocation = false;
 	int ret = 0;
 
+	if (force == CHUNK_ALLOC_FORCE_FOR_EXTENT) {
+		from_extent_allocation = true;
+		force = CHUNK_ALLOC_FORCE;
+	}
+
 	/* Don't re-enter if we're already allocating a chunk */
 	if (trans->allocating_chunk)
 		return -ENOSPC;
@@ -3736,9 +3736,17 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	ret_bg = do_chunk_alloc(trans, flags);
 	trans->allocating_chunk = false;
 
-	if (IS_ERR(ret_bg))
+	if (IS_ERR(ret_bg)) {
 		ret = PTR_ERR(ret_bg);
-	else
+	} else if (!from_extent_allocation) {
+		/*
+		 * New block group is likely to be used soon. Try to activate
+		 * it now. Failure is OK for now.
+		 */
+		btrfs_zone_activate(ret_bg);
+	}
+
+	if (!ret)
 		btrfs_put_block_group(ret_bg);
 
 	spin_lock(&space_info->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 93aabc68bb6a..9c822367c432 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -40,6 +40,7 @@ enum btrfs_chunk_alloc_enum {
 	CHUNK_ALLOC_NO_FORCE,
 	CHUNK_ALLOC_LIMITED,
 	CHUNK_ALLOC_FORCE,
+	CHUNK_ALLOC_FORCE_FOR_EXTENT,
 };
 
 struct btrfs_caching_control {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac2..6aa92f84f465 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4082,7 +4082,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			}
 
 			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
-						CHUNK_ALLOC_FORCE);
+						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
 			if (ret == -ENOSPC)
-- 
2.35.1

