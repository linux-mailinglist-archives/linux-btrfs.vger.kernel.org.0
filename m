Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A41F54E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFJMdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgFJMdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792401; x=1623328401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjdGgV/iUg9JxZsGLsOUpeBmloXD5kGKiFkSnh5FCc4=;
  b=Y9V+fFDM4qC7LMS4osyOMkXywWlhNfEmWWYypmfBZMSv9GjI4n7+GafO
   wSF02/4pKB8Q6UWthOrU67txCTEsWd5qwj94Bt1k0J2atsRSqEmuPG246
   k34KS4XGKM+gtC1nyOpOZQL6tAz+yuP+3El9KW0WbrlgTo+taaE3oMuJ2
   Oq+C723JJy/hPy9UV5mhYO5uGihVWoWCxxJRkwdX+51aQ3EdVhA74IWVC
   FFvlF5LOWKi6bzoJcYuzFuXI2v1h2zHsFtoZWlPmzV9iykKApD+pH3f1j
   Pjh5em0yZPDkqh5OjTcZDIl5ZuSGht4IYcitkUown2eGDLexAAfEn9FvJ
   Q==;
IronPort-SDR: PeslH6MbR5XRkE9pN9fE2DQ/AXHgjGnY/nAwASJYtdYzBAN6sOY+pQ6YfWuyV1oHAu5Qkqb2+x
 QSeJcK+mPtSRoMThL5DyYXegBcBFgoHpNtWSS6sj9sfWGLlzSx1ojENTOGvv5G7NslgOoER2tB
 syBR2byWy2hK0ABmPp2QjGGSGtwm61YnHnWwLwVwtpGl90nPoVXXKI5AeI/PW73OkKs1H3ZyRi
 a1rGDor1ZMPjZ3n9e3MC+sJPXMxkVib6NBizTVrdlE02NyoXT4xmkC5LaHDcIDO3/IMQR5DE0d
 sPE=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632684"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:05 +0800
IronPort-SDR: gwxkbQDThKmd00SgvgOsuPBr/8WwrrwXLst5PwFYvlmFnLU8hn6Yoyfkdm2A/NAjov7Ehf0wQT
 hWL5gxQH+zQRjMUcHT9jppJFNGxbGzYB8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:32 -0700
IronPort-SDR: Xp/O7BPACJrmB+8loD5lVqdovcOGxUmfaYthqtbvp2er8qOUSxhAqrUqu1p4UbVpj2yb6LacZJ
 RtcEyTrRYXpw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/15] btrfs-progs: simplify minimal stripe number checking
Date:   Wed, 10 Jun 2020 21:32:44 +0900
Message-Id: <20200610123258.12382-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_alloc_chunk_ctrl() we have a recurring pattern, first we assign
num stripes, then we test if num_stripes is smaller than a hardcoded
boundary and after that we set min_stripes to this magic value.

Reverse the logic by first assigning min_stripes and then testing
num_stripes against min_stripes.

This will help further refactoring.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/volumes.c b/volumes.c
index 7f84fbbaa742..089363f66473 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1054,25 +1054,25 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		}
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1) {
-		num_stripes = min_t(u64, 2,
+		min_stripes = 2;
+		num_stripes = min_t(u64, min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < 2)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
-		min_stripes = 2;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C3) {
-		num_stripes = min_t(u64, 3,
+		min_stripes = 3;
+		num_stripes = min_t(u64, min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < 3)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
-		min_stripes = 3;
 	}
 	if (type & BTRFS_BLOCK_GROUP_RAID1C4) {
-		num_stripes = min_t(u64, 4,
+		min_stripes = 4;
+		num_stripes = min_t(u64, min_stripes,
 				  btrfs_super_num_devices(info->super_copy));
-		if (num_stripes < 4)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
-		min_stripes = 4;
 	}
 	if (type & BTRFS_BLOCK_GROUP_DUP) {
 		num_stripes = 2;
@@ -1085,32 +1085,32 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		min_stripes = 2;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
+		min_stripes = 4;
 		num_stripes = btrfs_super_num_devices(info->super_copy);
 		if (num_stripes > max_stripes)
 			num_stripes = max_stripes;
-		if (num_stripes < 4)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
 		num_stripes &= ~(u32)1;
 		sub_stripes = 2;
-		min_stripes = 4;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
+		min_stripes = 2;
 		num_stripes = btrfs_super_num_devices(info->super_copy);
 		if (num_stripes > max_stripes)
 			num_stripes = max_stripes;
-		if (num_stripes < 2)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
-		min_stripes = 2;
 		stripe_len = find_raid56_stripe_len(num_stripes - 1,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID6)) {
+		min_stripes = 3;
 		num_stripes = btrfs_super_num_devices(info->super_copy);
 		if (num_stripes > max_stripes)
 			num_stripes = max_stripes;
-		if (num_stripes < 3)
+		if (num_stripes < min_stripes)
 			return -ENOSPC;
-		min_stripes = 3;
 		stripe_len = find_raid56_stripe_len(num_stripes - 2,
 				    btrfs_super_stripesize(info->super_copy));
 	}
-- 
2.26.2

