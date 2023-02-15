Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF697697E78
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBOOeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBOOeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD970392A8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471647; x=1708007647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48mzuJkCCBR9M4lhSSUdkDKYB5vx32qICyN3uBfqRf0=;
  b=LVOjkkzxJAEx8nEcCewl+7aGFftdAn6vDS4KsFuwE2W+dM9bxbGVaSvj
   iEaqtBHu5K5BDJWCzYDr4WfVa4eHUVHh894q7mmI3fd1P6kozXK4Eq3db
   qvWOgL5Amej3FXKu0U2WjGQt0rRREkTofP5AzCApINS+AbAMNYceLsRXn
   XF7a94glldFkLiHbtdaUy6n8AhVFDiTX7mPdQ4wkPc9TOe4/XFJ6ypzIN
   Rye7LnwA1UswTD1K59QhQzl7OAmZlTZzugYNMqcOaF0bXZKLmhkVSIYWx
   Xh3eGGXbfkrl3mejRrmxdvrm9ERO/fqF0qkHoCOCfh7E+RTNl4GgPP5jH
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394078"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:49 +0800
IronPort-SDR: O55iF9tfXuXttAuyA4R6xH+jvyaPuhbVN/KP47gfXLmr553rdqWatbOZuUB/wRgYzbA7OyXpp4
 wCfygMBPOAGBMWD15zFkbTzHxoSCE8u5FXmpsT8XsKCXIMNRRiYDNuSeEr9+MRXNQguLxne7vE
 S4S8taAVEJhkk/yFmv65BAbDZZynOqGt8yvQq36bwdoJ3uVXYuYYrctDQfdENl9ijpplxWf67L
 l0oOIDDp52BBvyK4wWsMAzRIi+/ugpj/N+8H8ZaAGgoCzftxyDCl+VzNh3L/MBpOJdGSuQlMxU
 1no=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:11 -0800
IronPort-SDR: pX3cthX8QpMDKgJ/ADxx6weDjj5SMUTssH+2mGE96RDVrtapmmoUP9AlifBV0ILqsu/Hj9ohaf
 qeqs+MFAuhfnAErMM3uqPBCq9SRPvJls5w38Bz3EpmMqNWcKBp3CTDhiT0Xfl7Dm4GK3enOwrO
 0Lz3HL9y+uI4kjuXSrKCOn4G6jBIdxg8e2RBitrFs+MJ5LpfNPbdPqeH4rr/G3UlpTFyvEf3hH
 MgbGybK9iypdbkOzQYF/+m3fSxV5A4fWNnUAWTRpjzwwCeB/GaX2xh1yVqEha6L6JhYHwOfT9s
 l1o=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:49 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 12/13] btrfs: consult raid-stripe-tree when scrubbing
Date:   Wed, 15 Feb 2023 06:33:33 -0800
Message-Id: <2f2e8602e56431fe0032c0f234ac3ab77ece2c86.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When scrubbing a filesystem which uses the raid-stripe-tree for logical to
physical address translation, consult the RST to perform the address
translation instead of relying on fixed block group offsets.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 69c93ae333f6..0fe529c3f5bc 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -24,6 +24,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "raid-stripe-tree.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -2719,6 +2720,21 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	int ret;
 	u8 csum[BTRFS_CSUM_SIZE];
 	u32 blocksize;
+	struct btrfs_io_stripe stripe;
+	const bool stripe_update =
+		btrfs_need_stripe_tree_update(sctx->fs_info, map->type);
+
+	if (stripe_update) {
+		stripe.dev = src_dev;
+		ret = btrfs_get_raid_extent_offset(sctx->fs_info, logical,
+						   (u64 *)&len,
+						   map->type, mirror_num,
+						   &stripe);
+		if (ret)
+			return ret;
+
+		src_physical = stripe.physical;
+	}
 
 	if (flags & BTRFS_EXTENT_FLAG_DATA) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -2772,8 +2788,21 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 			return ret;
 		len -= l;
 		logical += l;
-		physical += l;
-		src_physical += l;
+		if (stripe_update && len) {
+
+			ret = btrfs_get_raid_extent_offset(sctx->fs_info,
+							   logical, (u64 *)&len,
+							   map->type, mirror_num,
+							   &stripe);
+			if (ret)
+				return ret;
+
+			src_physical = stripe.physical;
+			physical = stripe.physical;
+		} else {
+			physical += l;
+			src_physical += l;
+		}
 	}
 	return 0;
 }
-- 
2.39.0

