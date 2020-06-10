Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F511F54E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgFJMd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12387 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgFJMdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792402; x=1623328402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L8BYYhaHvR8L94NHP6LD6IUYo11rykcnRkK/lj/vwuY=;
  b=NkFj5KZuxCd2q7P2m2NxNa+W1UsX0X4eJcrNm2oVCOCKzX/XMtdiQ2n1
   hmEMT7IXt1QqLPhUi05wuud4abB67QtYpG/D+gTVo1PfvLj7nZ82EKrPd
   XB/NmqcDa3bc0Js+TSfK33fNeSam5S2IY7iqtj2OlIh9KB1xuZX7tFhfR
   BN/KE08FkY7OTCokWDv7nlj9IpkqjG5bPCcm+tTjTHEJ8bXwjByC9mGUy
   79ubGCT2VRBWw/IjHXzxh4i4cvNRd4dRnp0ip4W4sfe/N9nT87UkrTPWg
   cMYRT6RMPR2zcPZ9fhwH2OWyFLlQEoHhVJH6rz/eSHk9rRaJnIK03FV9A
   A==;
IronPort-SDR: BLPwshydLYdUWlRR8ro4BK5qYQPWhkGziJJIZdlRIbk4wpqhNny4GPtwdnRpKe8JEOwEabhWtc
 70JZwXCMHukv+m2e6UOGTUTo2yVFO8N1Wp+dti2b4TnfX/O3N/gAEFUXXGsY6EE9mqC5WsI5Eg
 x0hqcYkQM/YWXs27FWSgSORt9gIyz8jEBQ+G/RBzYSrofsBbuIIqbTAhafrLZRf1rQlN7kitNn
 M7pfS26/7qVq3WjUHmcf8NUKo0scd4kHj3nslNQhah/QFO7UZsfMnwkw81Hd9DSX/GEFj4+Bex
 gNw=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632700"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:09 +0800
IronPort-SDR: J6QPrcS/eJ2t6bP0b9AM/5WTuhz8c8NLGg7MuOEkB21Bu3Yjz1n5JOOgF1SIktY5ra3Mj98ohU
 4g7hrzpyvhLvgC05j1iKS8389QzOP7V1s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:36 -0700
IronPort-SDR: tWRTpkOLqqYAQUqiqSrhp78rD1kECHyt/Eip1yt3ee0qaHJJDX6QDV2Eva6Me/0+Qz1TjwYk7Y
 I52BqAd8hIWg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/15] btrfs-progs: introduce raid profile table for chunk allocation
Date:   Wed, 10 Jun 2020 21:32:49 +0900
Message-Id: <20200610123258.12382-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a table holding the paramenters for chunk allocation per RAID
profile.

Also convert all assignments of hardcoded numbers to table lookups in this
process. Further changes will reduce code duplication even more.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 95 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 16 deletions(-)

diff --git a/volumes.c b/volumes.c
index 04bc3d19a025..fc14283db2bb 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1005,6 +1005,68 @@ error:
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
+static const struct btrfs_raid_profile {
+	int	num_stripes;
+	int	max_stripes;
+	int	min_stripes;
+	int	sub_stripes;
+} btrfs_raid_profile_table[BTRFS_NR_RAID_TYPES] = {
+	[BTRFS_RAID_RAID10] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 4,
+		.sub_stripes = 2,
+	},
+	[BTRFS_RAID_RAID1] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 2,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_RAID1C3] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 3,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_RAID1C4] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 4,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_DUP] = {
+		.num_stripes = 2,
+		.max_stripes = 0,
+		.min_stripes = 2,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_RAID0] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 2,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_SINGLE] = {
+		.num_stripes = 1,
+		.max_stripes = 0,
+		.min_stripes = 1,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_RAID5] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 2,
+		.sub_stripes = 1,
+	},
+	[BTRFS_RAID_RAID6] = {
+		.num_stripes = 0,
+		.max_stripes = 0,
+		.min_stripes = 3,
+		.sub_stripes = 1,
+	},
+};
+
 int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *info, u64 *start,
 		      u64 *num_bytes, u64 type)
@@ -1037,6 +1099,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	ctl.type = btrfs_bg_flags_to_raid_index(type);
 	ctl.num_stripes = 1;
 	ctl.max_stripes = 0;
 	ctl.min_stripes = 1;
@@ -1066,50 +1129,50 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			ctl.max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
-	if (type & BTRFS_BLOCK_GROUP_RAID1) {
-		ctl.min_stripes = 2;
+	if (ctl.type == BTRFS_RAID_RAID1) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
-	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
-		ctl.min_stripes = 3;
+	if (ctl.type == BTRFS_RAID_RAID1C3) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
-	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
-		ctl.min_stripes = 4;
+	if (ctl.type == BTRFS_RAID_RAID1C4) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
-	if (type & BTRFS_BLOCK_GROUP_DUP) {
+	if (ctl.type == BTRFS_RAID_DUP) {
 		ctl.num_stripes = 2;
-		ctl.min_stripes = 2;
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	}
-	if (type & (BTRFS_BLOCK_GROUP_RAID0)) {
+	if (ctl.type == BTRFS_RAID_RAID0) {
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
-		ctl.min_stripes = 2;
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 	}
-	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
-		ctl.min_stripes = 4;
+	if (ctl.type == BTRFS_RAID_RAID10) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.num_stripes &= ~(u32)1;
 		ctl.sub_stripes = 2;
 	}
-	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
-		ctl.min_stripes = 2;
+	if (ctl.type == BTRFS_RAID_RAID5) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
 				    btrfs_super_stripesize(info->super_copy));
 	}
-	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
-		ctl.min_stripes = 3;
+	if (ctl.type == BTRFS_RAID_RAID6) {
+		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
 		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
-- 
2.26.2

