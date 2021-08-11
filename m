Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07DE3E9385
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhHKOVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35972 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhHKOVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691649; x=1660227649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIQ2V+kIMZeT6Kqo8vrdRnKidRkC521Ht60fnLVbg7U=;
  b=UQZriHF/kCnd+z7xwpgiE0ks8sRjfJPVQt57TSewT5UtIdt/X6IOoJRu
   SgmmemhOtj6un80tCnfTbmWBVkB1e5RGVOdO0F4aswfFQ+U13eovJjcko
   ud5kEhceE0vj1ajslyFEOSfQ+KJHti56ITsKplKgEGkk0kw4Ys3W6QXFB
   vWpChgZyVYwuTaW9BD+XRgf4A6zS/F1DnFEF+b+Y7Zlomyak414BlRWEq
   ovkbwl1zIE58a+yMxcyDZOmXQ7w6lQfPV6hCJRKOVz62l6qc1frH1Bsyi
   Cf1glwW8cb/IaA8o0+jBjK9qb7sCSu4XFzi+fIzaocDxV4puV+1pxL8Fu
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937875"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:49 +0800
IronPort-SDR: fpISgMWddRjb8OmuzCetRkau/N13w3CHZvT+ptLOxzoFgvBpPfVoZkhS+O219sq8RBeQSkulqf
 fc8eVtYgVmWMVLQngrp8UqI2CjBxq1NmFRAQSSSFoaj5D486cJAiXQFszuRvZQoK3hzLDkPgI1
 5p/Nht2XfqIK15oBlZZx6OAG+Wz6UUboyQ9dW/z4ee6oCVqYPP+UqbsVfkgeCGVvk/izVvINRG
 8FCszyFDde7hq5LtCLwCjg7XFflpE/+lLu9Fblpr8LQ108EnyEWjAEBGwwGe4zLSp00s2w33vu
 cY3bwhVwxKevTwriZBZrLDm4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:20 -0700
IronPort-SDR: RhHIt+mTxBfPvws7NOQJskRIcrzjJ5qza187noV7/lhKuvVaqQBjNlGTSDZ+7NGuENSC+jtue3
 J01ZbGUUH1LP0TkYrvumSd3UVH2Mxhh9Kvw68AqxI6o/iBTmjYIlRvFLnCghVcinxsfbJkCkvc
 ab5Cg5aVOxW+IkBGi9ojTLeJ7s4fu15MAmICyq2iF0cVAy0oLWzmCiVpFMa2t9qNRs2FPUUaEo
 ZQvphHZjKK9OZZy81FKYOdpq/Z7dP3StoxXxbm+9Sd2NdzIe1KKPSEUSPn4sZv1R5WmQmqkuCM
 NQY=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 04/17] btrfs: zoned: tweak reclaim threshold for zone capacity
Date:   Wed, 11 Aug 2021 23:16:28 +0900
Message-Id: <940fa7fa954f507bfc3c401a32257c08e7fe8c7c.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the introduction of zone capacity, bytes [capacity, length] are always
zone unusable. Counting this region as a reclaim target will cause
reclaiming too early. Reclaim block groups based on bytes that can be
usable after resetting.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index bb2536c745cd..772485c39e45 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2540,6 +2540,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 to_free, to_unusable;
 	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
 	bool initial = (size == block_group->length);
+	u64 reclaimable_unusable;
 
 	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 
@@ -2570,12 +2571,15 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		spin_unlock(&block_group->lock);
 	}
 
+	reclaimable_unusable = block_group->zone_unusable -
+		(block_group->length - block_group->zone_capacity);
 	/* All the region is now unusable. Mark it as unused and reclaim */
 	if (block_group->zone_unusable == block_group->length) {
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
-		   block_group->zone_unusable >=
-		   div_factor_fine(block_group->length, bg_reclaim_threshold)) {
+		   reclaimable_unusable >=
+		   div_factor_fine(block_group->zone_capacity,
+				   bg_reclaim_threshold)) {
 		btrfs_mark_bg_to_reclaim(block_group);
 	}
 
-- 
2.32.0

