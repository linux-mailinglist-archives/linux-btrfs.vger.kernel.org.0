Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7AC6A7E73
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCBJqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCBJqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:39 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675A3E614
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750384; x=1709286384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/cZhscpJ/cvgZUU0wWafl5CJk5PJAiE+H5UNDPMTUk=;
  b=Xf+vMuh554UDQJg1X+oGaDHgyvh4MkEkC9LVPma2DO13THiUDKTbZJ3Y
   ex36F+Upb5ugwQSt15HLhrH+7wdTDKB7eSueAYW/AlSgJZpo4fUc191BQ
   DCiBzb7hXUrMVEDxVzQMIYI2m+3f791Z1nJ/uSMb6PM3rpV8LMCtPkvP9
   9XkEfj/nXbJjmRqPq2WnzEwwHaP0HFmWB6Pcs2dteuYD9G5e3069SznY7
   gtpv4nPRMYYzOpCrPoF5RxL47Wx7yjFKhz6CBE7xFZdIZauF5O2tpY0nr
   nuoU+I9CUbks1avCmKBDSdHoM/pCQZ7PU8T+lHh16JvW4o9FjjotxLcvN
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939205"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:50 +0800
IronPort-SDR: eoIqCjsogaRF0rdqHsrRq7wd+D6ECdjSB2Iqry22moQ8by4Z0mWRTHLF4QDkX7siOsOBzwE/HZ
 JOuy65qEXtyECpZvgIhBpoFZCzHJVHuyi1Si3LShWkNfLcgMDojQI3pVMTOpqQLZixdQZ9c3ZD
 brgGapcn+IhqPtyBQSFHWZ7xbdD6ce4dfHu8gvDUi3+i2RrYKO7ZJ/9V6lqlcqJ4/YLs0fBSZh
 u8OkTLbWCEHuY++Oo0sH9lH2X0nZlxnNmfm11FFnXjeU4HnscLY8n5AGARX0dGyO+cj+ZTP5Kp
 EmQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:55 -0800
IronPort-SDR: vca9Cj5M+mxPFNX+lmjz6wofED6pfdDF5mhF98vPhn2H/RQcPERri2KlC3O4Dat0kjoLRrh6IN
 E4K2hEWmVZ1R2fMOaSIHnLzr5scloRGxSBywKnmt2sY3jDjJkLm8vvccfp+ke0bnqLqw3Ga3rF
 2bIzyKMfRXH5zr6R4teGvV9vW2uj9UpMDc4o1/aeBN0Yzb/ojO8S/6EYwirwdvrRIdioTxPq+E
 2Nn5Y5fJ1s8jj1VY8M9j9vJbvJkpTFWQ1d8M5fjB3XOSJaLx+/tjv6ZX8iinafVDEeTzbcS55U
 cLk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:51 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 12/13] btrfs: consult raid-stripe-tree when scrubbing
Date:   Thu,  2 Mar 2023 01:45:34 -0800
Message-Id: <4f1616ea9843b785f498d52a18cd4c8d5690c442.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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
index c83ac6b80c2f..86e3374d49b0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -24,6 +24,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "raid-stripe-tree.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -2821,6 +2822,21 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
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
@@ -2872,8 +2888,21 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
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
2.39.1

