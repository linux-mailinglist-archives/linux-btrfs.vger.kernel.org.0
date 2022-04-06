Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5944F65D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiDFQbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiDFQah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 12:30:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD632DE168
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209429; x=1680745429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GG+ZeDHCHx9HkO26a6Cm2XY2cf8ReqgI9BCe1pJ1iOQ=;
  b=dcng/1Zx0evjP76YSPI/J9dtSVvcxfqIOmqFki+uZuWaoWCjYnPcizXS
   KuifbE1/BCup9UwBzywJ1dClbYLkf79UEeJQbnYxIQHR7KDD3lOyab69z
   Z2VWoi2m3kly9WCNq6NXtgLNlUhWtHFgJXW8kEQ7eZRqK7DTaxPW1A4I7
   Dkfcz39/vNLt/JH5E6sVgeokRXxCswjYBswdpUMNJ8PhAIc6jxDhB7HkA
   deKnGPAyPrGTk6RfRx3GcNeh1A6jSJKeTOMzxUMzWtmL0R6HgiQS+PtEZ
   KA55XqMNHQwjrchDCaxXrcU2NXB31jUn5DNZpOQ91pTuEV1w5n/62TcH9
   g==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="309153504"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:43:48 +0800
IronPort-SDR: yms9kpj29l6FjSxheedTcDVGMA3KuqVk7Env/PiVxz6PwBXt9vtbNOSWRab0YdgvDxISY4foSA
 ZDAgx0O2swRiDemiDgJc2gYYfHGUNoBz5PY22UZWtzinch1KbeLf8DcHSnr2gj+6AIJ8REtsQL
 iDrskX6lOowKZk6P46E7dt4Rjnb2pljvcKQXH3SYwa8SeCugkekT4bAHR/JgREqwptrPJBEG02
 BVN5PJbyx7WmzIJi4SrryBTFHD7OT9zGv8LQPZN3nhlFSitbXiR0js09yeelQBxNVvKB1ycZcZ
 3CbQb0XmS20w7QchGPqIUvbX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:14:31 -0700
IronPort-SDR: t5YFejW2KnwkerNwtEOojzMEzGOFOJ6OMDq1MmbmYu7HnNTLZkbmVZsFrppn4uGhaEykRv2Aeu
 Dtb9JRkP7B85u7/5byvYRx+7hitRREwNs0jaX4YPrWpn055x79ovB5EhaXAm2VyzH6Ukhh5dKm
 2ZXArvjSRduCkDAiVWIRR3BQL4r0a9Mr7IljU9uB336zikmXUDHAYK2gSot64NvHT5oepbUVSr
 BgzAoMvmbPkwytx+00v0djtnl7f5OHCG99PlqiW4YBfWBPlWLfyclsyorGxGkvq+Uv5bNqlLli
 6/s=
WDCIronportException: Internal
Received: from 5cg2012qdx.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Apr 2022 18:43:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs-progs: zoned: fix initial system BG location
Date:   Wed,  6 Apr 2022 10:43:11 +0900
Message-Id: <20220406014313.993961-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406014313.993961-1-naohiro.aota@wdc.com>
References: <20220406014313.993961-1-naohiro.aota@wdc.com>
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

Currently, we create the initial system block group in the zone 2. That
will create the BG at 64MB when the zone size is 32 MB, which collides with
the regular superblock location. It results in mount failure with:

  BTRFS info (device nullb0): zoned mode enabled with zone size 33554432
  BTRFS error (device nullb0): zoned: block group 67108864 must not contain super block
  BTRFS error (device nullb0): failed to read block groups: -117
  BTRFS error (device nullb0): open_ctree failed

Fix that by calculating the proper location of the initial system BG. It
avoids using zones reserved for zoned superblock logging and the zones
where a regular superblock resides.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 75680d032d30..218854491c14 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -232,6 +232,34 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 	return 0;
 }
 
+static u64 zoned_system_group_offset(u64 zone_size)
+{
+	const int zone_shift = ilog2(zone_size);
+	u32 zone_num = BTRFS_NR_SB_LOG_ZONES;
+	u64 start = (u64)zone_num * zone_size;
+	u32 sb_zones[BTRFS_SUPER_MIRROR_MAX];
+	int i;
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++)
+		sb_zones[i] = sb_zone_number(zone_shift, i);
+
+	for (;;) {
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			if (zone_num == sb_zones[i] ||
+			    !(btrfs_sb_offset(i) + BTRFS_SUPER_INFO_SIZE <= start ||
+			      start + zone_size <= btrfs_sb_offset(i)))
+				goto next;
+		}
+
+		return start;
+next:
+		zone_num++;
+		start += zone_size;
+	}
+
+	__builtin_unreachable();
+}
+
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
  *
@@ -298,7 +326,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	}
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
-		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
+		system_group_offset = zoned_system_group_offset(cfg->zone_size);
 		system_group_size = cfg->zone_size;
 	}
 
-- 
2.35.1

