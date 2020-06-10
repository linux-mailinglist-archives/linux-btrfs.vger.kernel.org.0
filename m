Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870301F54EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgFJMdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgFJMd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792406; x=1623328406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mc3RDYS7H1E2/ipsAUwmgH4rpoWOdtnog/4ZkZS5VKI=;
  b=YEkJuKPEHI9thOr/JQ0uEnBoAkrU4HVv+WBu1hxR6QXcGQTL2QhbCi9M
   CMONdFpXz1SXN+lZ+IiFcwWCVs5JJpBWSmyj2DbUfAsrxN/SKK0paQFl7
   jVfuhsRxTx1PuQJT08lmO9b0uLPL+AEBYg+L3gZIIKb7s2bJWxiMmo8el
   08vyHR0oWRhBRiNpnPapzY8VTNeCvgDXqrqIj52qx3fRkDkoaSUav8027
   yA2QGlqnUsMQyBwMVyJzNdk+OCADYaG+ZZVXanV4cIEtb5S4okpWITF+k
   U+Ii6vSAogo1f9AhRzx/XtyzL9G4Ci67q38TjJaXqjYDOI/CpSdRYzP/S
   w==;
IronPort-SDR: zxubRt6qLDeyxtcDgg7XLGgvGnyfdY9ANHY1ItGJd97zCKBdDk+hfOTUSVj++FiD+Xu9TypXvq
 rQIX2/KPX/UXbCRHLsD9JMIn15T4tqmZuxEB4EaJ3mctAmNAYA2vX7udB5Nq7ZzOC+F+KRWOE4
 RwarfI85QTQajl/8aeNvHzJnw6VEIlTEiqs5UAsiVqUQEdGnq0cKvAQMwrjJJTnqLrOtaQshjZ
 yJjP4Iw2LoG+AawchW0Kk70UaVwwSN/Z/5n9KMH3S7vKksquwwZAqeekeM4jayAWIJxv7JLGNR
 Ijc=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632697"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:07 +0800
IronPort-SDR: ilr5aXJgqReXOwR/hm2y6JfMTtp01j90ZixzHMljIP9U+zyM0dFyI4UUNdSbIWP0/pcSidfjrl
 F3FVy7sq1YedSunBwiQf7kQd5/bAmipBE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:34 -0700
IronPort-SDR: lsrjuN+CvB6WCBbmtH5qLrHlhtVJ2xGtHNL1PHXl3nw85V4AbiiI4cXkEQPfu+iYyj0/c8TKRj
 LUkJX+Y4ih5Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/15] btrfs-progs: cache number of devices for chunk allocation
Date:   Wed, 10 Jun 2020 21:32:47 +0900
Message-Id: <20200610123258.12382-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cache the total number of devices usable for chunk allocation in
alloc_chunk_ctl instread of reading it from the super-block over and over
again.

As it's a) unlikely to have more than 4 billion devices and the result of
the max_t() gets truncated to int anyways, change the max_t calls to
simple max(), while we're at it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/volumes.c b/volumes.c
index ea3e105859da..539c3d8648c6 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1042,6 +1042,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	ctl.min_stripes = 1;
 	ctl.sub_stripes = 1;
 	ctl.stripe_len = BTRFS_STRIPE_LEN;
+	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
 
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -1067,22 +1068,19 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1) {
 		ctl.min_stripes = 2;
-		ctl.num_stripes = min_t(u64, ctl.min_stripes,
-				  btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
 		ctl.min_stripes = 3;
-		ctl.num_stripes = min_t(u64, ctl.min_stripes,
-				  btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
 		ctl.min_stripes = 4;
-		ctl.num_stripes = min_t(u64, ctl.min_stripes,
-				  btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.min_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 	}
@@ -1091,14 +1089,12 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		ctl.min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID0)) {
-		ctl.num_stripes = min_t(u64, ctl.max_stripes,
-				    btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		ctl.min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
 		ctl.min_stripes = 4;
-		ctl.num_stripes = min_t(u64, ctl.max_stripes,
-				    btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.num_stripes &= ~(u32)1;
@@ -1106,8 +1102,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
 		ctl.min_stripes = 2;
-		ctl.num_stripes = min_t(u64, ctl.max_stripes,
-				    btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 1,
@@ -1115,8 +1110,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
 		ctl.min_stripes = 3;
-		ctl.num_stripes = min_t(u64, ctl.max_stripes,
-				    btrfs_super_num_devices(info->super_copy));
+		ctl.num_stripes = min(ctl.max_stripes, ctl.total_devs);
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.stripe_len = find_raid56_stripe_len(ctl.num_stripes - 2,
-- 
2.26.2

