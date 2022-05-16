Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9691528715
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiEPOcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbiEPObx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1527B02
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711512; x=1684247512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYsfZZk8FBwWUzYsUg1xtmfXBXttqN6OV0mvgf/mw1w=;
  b=TfMSCyV1eu5X+qXhVG3pXe4rI1mYMuECaPHirk34FPWfjRVJY9Td+sWK
   leNL1V3K9laSDGONEIjxPxIxfNx/A4+zW4bFHg6OS8ClPQG6wPn/Lb6uM
   g+ReLQxUFs5iRajMqTpqwQAHPEC+U0kpDcUL8VXty30/OG+Cv/OQ+QFrl
   f8NSZAvk0dExThsKybU1PAIHSHnQZldn0WTXZLvNw0POi8PeDQYSPuTce
   01bp1hiQ/WfusRoFEWIKzbPfim3g2YSiIr0VxgoH4A+3QnUM3n60sPxr+
   pIj753SS2256etVBT2ybtJMN+ZK9PWVUUbw14nLd8miAGMKiBphhPYdmM
   A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309218"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:51 +0800
IronPort-SDR: gpjBlLpN8r2j0OaQcomdmOH0JAGS4Db4uTtlgdKIFv5yp6Jf4ZYQiNMlWRW9pHXVe4FKztGZAx
 /MB4+LlMVm5zhTevfUuFd9dPlsZoqAix0m7ms7S9aMdBmnA3jjQQQw4b2ooyxTF2LYOR79Hq9z
 E5hVy6OM4dMjGwsepdRt4XZN4C2EDT9MmLnbYFlR3Js4phcITKUumEgsf5RrHht+kE0Wup62k7
 RFbqhT/AiX7owYjUivB1NiueGO/4jeXwyJLOC8lc8CFCfSINRPY3eNYRbVPU1KRcgRP7zaz5JI
 tw+0IE1euh96DIHMC4LMj/6D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:33 -0700
IronPort-SDR: mn55gsO18ZOncTEF+vABpIIuhAF3ScOiN9z77yjCYnIPnMOoLa/5/UCnXh6T1KOCjgx0BTHRll
 HKBxSQDMo4pAkqXW4anlLuFVVQ4ewIjPgSVdR5sv1r+NocNzpsqMR4O7juoUGMF45RTtwCa2+H
 owgxKLiL2vj9rOP2Xt0oi8H3E+pG/iUCtiDAvkQWSXc2XrCdWceq5M6SSnZnTNb6EAv7WxYpIy
 S41bBmS/+P7b/6ij2ioNZbMiB/wpnsBnRKBd0EfTU811xUaxV73kXZe6f7l7nG+Qmv+L5dHAsd
 FAw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 7/8] btrfs: zoned: allow zoned RAID1
Date:   Mon, 16 May 2022 07:31:42 -0700
Message-Id: <c4fddf1d5978115c8a1542c88c0eadeb71fa8ef6.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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

When we have a raid-stripe-tree, we can do RAID1 on zoned devices for data
block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b1b310c3c51..d817a3349595 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1455,6 +1455,45 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !fs_info->stripe_root) {
+			btrfs_err(fs_info,
+				  "zoned: data RAID1 needs stripe_root");
+			ret = -EIO;
+			goto out;
+
+		}
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				btrfs_err(fs_info,
+					  "zoned: cannot recover write pointer for zone %llu",
+					  physical[0]);
+				ret = -EIO;
+				goto out;
+			}
+			if (i == 0)
+				continue;
+
+			if (alloc_offsets[0] != alloc_offsets[i]) {
+				btrfs_err(fs_info,
+					  "zoned: write pointer offset mismatch of zones in RAID profile");
+				ret = -EIO;
+				goto out;
+			}
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			}
+			cache->zone_capacity = min(caps[0], caps[i]);
+		}
+		cache->zone_is_active = test_bit(0, active);
+		cache->alloc_offset = alloc_offsets[0];
+		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
 	case BTRFS_BLOCK_GROUP_RAID5:
-- 
2.35.1

