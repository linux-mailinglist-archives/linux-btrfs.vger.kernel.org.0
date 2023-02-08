Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE53D68ED69
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBHK6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHK6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:06 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD931350E
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853884; x=1707389884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oh3KNTXYN5CoEVcuSykxoAqYMbfvM/Ya1AGBLL/lGNE=;
  b=eyFQVgz3/gBQqYIJqHUh/wTWphye+rnYqVn8KhNPfwi87IalcPF/QtT3
   i3EmmY0KBdXdS6DaUywgleqBhjWOdkmp0NG1iRBiXHFtXzOgHggjkNNGS
   aq3dgw9lF1r7RZ+DprYTBzvGefRRqapWCed6YfU+jJCbNR2bKN6iumacM
   dH1LpTp6ClWDRe4dq0K0CGrv5zbDo1SBuY3IeyWMeo8Mkpsc7U6hWmn5T
   7xbqIQpecc6JOf+HKd+S5GXCUW+Ot+o1lGZ9ezv3y4LA6QmGXGnvJt3JE
   LTHA+98AwUEl5gwL3o/bLf+u+8xHKP5M7MCSvJbc7y8cu70x3ZP0jEkWs
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115649"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:04 +0800
IronPort-SDR: t2u/Ll4yiTp6szkrMji2SNZXqd86l7rGf5wzKevrzjXzksDCYiPKHc6jMY9Z47IeFGB88RbEXx
 ShGo4M3fUvJuAQOZEzTRpQlEago1jsh3uGMK9F3A074PUk1DC0aXcI4f3DApvl/bkta6kCiPWu
 WMqDC8uCbXK66dh3slB6DAuO27UlBqrJJwWDZjfwEh4xGA/QFRem7id0P9nO0me+cKzcTgS6Az
 HKxtCaqqq8m3TnQ+9XrW5JWt1g2AjjlmHk9WHiZLLgq2dGDxBIy8hd29O7YlAgXSOEotFX2iE4
 szs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:19 -0800
IronPort-SDR: XLgaSVOg5XvCTxAKltyWRm4Biuvl3thLsBhMEzOUhy/3WOssA/SeTV0uFhhY5Ampi2yhDSb3wn
 r2oxk+or5x3EQaQj7k3uzpSqfLjqkUpxX4S55gica30EkzSPbZln9ChHQFR9aDS1jLaJm7OxsU
 QRbCkkmdOlmWf+zcl+PsDFRuZBFQrh1Az1Gq8BF/7CjGG+Lp7bjaZ6t0nmjxNPepDcPtEGoEcB
 Vs/HFXz5x1NjSQR4DOSHvan0djdU9kNOs+AhTlRtubUD8BhBOIYQWxNe5nzemC8skcnpCaZUVr
 268=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:04 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 12/13] btrfs: consult raid-stripe-tree when scrubbing
Date:   Wed,  8 Feb 2023 02:57:49 -0800
Message-Id: <ed868bb9e41d77fab138d2cf7b18728358526b82.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a5d026041be4..d456dda8c5b0 100644
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

