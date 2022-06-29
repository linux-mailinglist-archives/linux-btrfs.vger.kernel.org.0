Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B09560363
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiF2Ole (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiF2Ola (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887E39148
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513689; x=1688049689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQPWYcqzY8jouLyXuoKVAxy/EC9pFthgqLyhTw52EDo=;
  b=XPNumKC3ki0OtEulMc1WI4VvXMv2RuIxoJltVZZ9oKF210DhvJ+IBBU9
   087yUcccKVMFwtYIb0StsGNMKXu0ZANmLMdJMoRZ8JfHAanGkv+nnrFYM
   fNqMtz+fZCrnvW8QcXf3lTsTnvrGvfEV7CfmjelQLFUmO8BYTe5ZrMc+T
   FV2MUSV86rV+eiE2d4nz3grCxm1nkBp0MDskSSC27U1S4RT1q3BkbjLTd
   LWie9FXavHqFGT2Xxc/v3l9bULX34GuT5o4RSFa1ZyBklokHZ6Z58ESdt
   G2/CkxLNJ8umGimRLRJwGWcu2S5qoBjllDMctC+FhdsSASZqvKRttMfiz
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064898"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:29 +0800
IronPort-SDR: e5Yyopki96kKRMuttbefhJGw+V1TeiIST/90p6k0aATatHWv55I9fag0RfRip2TdoUvGrbFoQL
 qqIgMHqMtvphbO2C/EWdEMrju7XejBPQx/taZ8+PVrHV9tDcdf+kJozoQi/wTiGppELT7G891H
 pNY29bOtuRiM8BQYmkCzmvSTvjp6TksRfEpcV7pBgAv0/7hYSoio/LflMHgXQUbLb7icrsm5y0
 aQ2+vT/0E+8dGZCgFGLtatE1QW7UZVbMLh9dp9RcksFPRVfg3P+QNT+ggg5D7yJ3ORmcksjnEL
 XzRS3WT8Y3GkJzP3HcbAJvbL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:08 -0700
IronPort-SDR: y4dTlu9eoBDx2yggsUFwHPysF2dFMzyp+OmS2K/OLmQnDQMVWHXCzwtNtD/83c3gkZGW2KVCbL
 wBheJUSzU/5l9UJgPth5L9Gk+Ef1oIHEPZXhga10Npo2xaj+G2MYz2WB3J4M3v6Fp6x/6u7u7l
 snYxIyrNPdTPmQ9QcH2opLScpoZXh3G5sDxVxHK3rtHbn6+rETVvS4igw/qCsw7E9vCrfiyBR/
 gBcw4JztcjP3xvKTYiWaOy/Wwj8LoYTcM9NvZ5tiapgv2Adq+ADJ8aEs79IUMY/o1svsCHUQ29
 MRg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:29 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 7/8] btrfs: zoned: allow zoned RAID1
Date:   Wed, 29 Jun 2022 07:41:13 -0700
Message-Id: <b8ec3eb22d0bad50b99f2e5f4ceb7318ff1f0abc.1656513331.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656513330.git.johannes.thumshirn@wdc.com>
References: <cover.1656513330.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/zoned.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5cf6abeda588..e51e405342ad 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1463,6 +1463,41 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
+			if (alloc_offsets[i] == WP_MISSING_DEV)
+				continue;
+
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
2.35.3

