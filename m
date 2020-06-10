Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B431F54EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgFJMde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgFJMda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792410; x=1623328410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=47UTAKtRn8tdX1PlPox61BbXGfDryG3zyq36HRS9mDo=;
  b=NTtOUFxEyvjOVJQ034pKGswePyhTTJ1YYcXZqqa+75ThzeDtBcf95aiD
   yJLs8EXx53EY9GPYkOXmux3qbojw2/YeJvLOy3jRgNK0OUzTuUbKV7pnj
   wE6EBA5g5z5nNGupbMLi1jNL25tnzAr94nOCsjKLEcKnH15dUBPDr/Iux
   m/rXJcKW8EQHTmPuhU1D1BAOkk3Cop3fqLrzw7PYEnVaKsujTz6OUA78E
   uJ+tb1760t5683Un+YXw0P3XjYyVA4QQxrwsm7bQbrzNOGnX1P7BIcdYW
   ORAehXTrqM7aonc0uhWLuWKT6D4pPALTDpr//KmW9RQo/s3QpOnxBB3se
   Q==;
IronPort-SDR: rSv5vbuiSObE1XqSI4QGmbPfwPnsfeUYsU8y72buOAhjnVl4jTf4LN/p5fCBjmTaNEDi8Bwzsy
 JCb1iWIoTtlo8rhvJy5DccKspm45WgwKQPNrjmddbYGOnSiG1trLLW58MZ7J4alpIenymsM6rv
 tKeF98hp3tCzJxdTAE4SarnAZ2a0bM1RY/IFNaSuum2ilc/0XzyzJjeQmm3LkB/JWC5fl+r2ZF
 NwxyAEaBj9lfnfdVOjYfJ182Cfzh0FSmqhwI0QLvU9SKf+iYv8+ffrL+rI5dasQYDszcIKSoaH
 zOE=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632713"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:14 +0800
IronPort-SDR: 9Bio1VDlhtR3tXP+pPmR7ohXi45EStB69rQfJzhaaKZnYHUeNoTqMkfrEcIrases0yYSHQuTFd
 A7CKdJTT52KAP0t4BXzxPryqWW4pv6Yig=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:41 -0700
IronPort-SDR: AESf7B3qjLzsktX1dMUCimJOvDKVrWOyR2dxeobAUY/J/SuTDgeWMD37HT306Ybgnq/iatSG0m
 l3fGGqmVqlsA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:14 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 13/15] btrfs-progs: introduce init_alloc_chunk_ctl
Date:   Wed, 10 Jun 2020 21:32:56 +0900
Message-Id: <20200610123258.12382-14-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out setting of alloc_chuk_ctl fileds in a separate function
init_alloc_chunk_ctl.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 70 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/volumes.c b/volumes.c
index 57d0db5463ef..aacff6e0656b 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1067,6 +1067,44 @@ static const struct btrfs_raid_profile {
 	},
 };
 
+static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
+				 struct alloc_chunk_ctl *ctl)
+{
+	int type = ctl->type;
+
+	ctl->num_stripes = btrfs_raid_profile_table[type].num_stripes;
+	ctl->min_stripes = btrfs_raid_profile_table[type].min_stripes;
+	ctl->sub_stripes = btrfs_raid_profile_table[type].sub_stripes;
+	ctl->stripe_len = BTRFS_STRIPE_LEN;
+
+	switch (type) {
+	case BTRFS_RAID_RAID1:
+	case BTRFS_RAID_RAID1C3:
+	case BTRFS_RAID_RAID1C4:
+		ctl->num_stripes = min(ctl->min_stripes, ctl->total_devs);
+		break;
+	case BTRFS_RAID_RAID0:
+		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
+		break;
+	case BTRFS_RAID_RAID10:
+		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
+		ctl->num_stripes &= ~(u32)1;
+		break;
+	case BTRFS_RAID_RAID5:
+		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
+		ctl->stripe_len = find_raid56_stripe_len(ctl->num_stripes - 1,
+				    btrfs_super_stripesize(info->super_copy));
+		break;
+	case BTRFS_RAID_RAID6:
+		ctl->num_stripes = min(ctl->max_stripes, ctl->total_devs);
+		ctl->stripe_len = find_raid56_stripe_len(ctl->num_stripes - 2,
+				    btrfs_super_stripesize(info->super_copy));
+		break;
+	default:
+		break;
+	}
+}
+
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *info, u64 *start,
 		      u64 *num_bytes, u64 type)
@@ -1100,11 +1138,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	ctl.type = btrfs_bg_flags_to_raid_index(type);
-	ctl.num_stripes = btrfs_raid_profile_table[ctl.type].num_stripes;
 	ctl.max_stripes = 0;
-	ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-	ctl.sub_stripes = btrfs_raid_profile_table[ctl.type].sub_stripes;
-	ctl.stripe_len = BTRFS_STRIPE_LEN;
 	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
 
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -1129,32 +1163,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
-	switch (ctl.type) {
-	case BTRFS_RAID_RAID1:
-	case BTRFS_RAID_RAID1C3:
-	case BTRFS_RAID_RAID1C4:
-		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
-		break;
-	case BTRFS_RAID_RAID0:
-		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		break;
-	case BTRFS_RAID_RAID10:
-		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		ctl.num_stripes &= ~(u32)1;
-		break;
-	case BTRFS_RAID_RAID5:
-		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
-				    btrfs_super_stripesize(info->super_copy));
-		break;
-	case BTRFS_RAID_RAID6:
-		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 2,
-				    btrfs_super_stripesize(info->super_copy));
-		break;
-	default:
-		break;
-	}
+
+	init_alloc_chunk_ctl(info, &ctl);
 	if (ctl.num_stripes < ctl.min_stripes)
 		return -ENOSPC;
 
-- 
2.26.2

