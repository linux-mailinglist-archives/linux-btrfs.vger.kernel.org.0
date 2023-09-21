Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99DB7AA24E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjIUVP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjIUVP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB835BF
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695316075; x=1726852075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vasGLwgoYXJvxXL1rzped5+j/MRuskCR7hT393b/Ym8=;
  b=iVaoQnUh/HR8QDKzQHXeDMRJu0hSQANh4WZAgmWC8GNZ3XnjeDwHy3wT
   Z1AjEy8bT3tAkXPQD44sAP1DaCOKSLwYbwYkSjHEtzddlYw93DjhPpORA
   b8NhyMn+Nl8Y0P0JtOPT5ljOi0P9ZVK2DwWorRfx2c/KDiamLxmq8mNuy
   l+Lwc482bKM3zHGLXseLHqz9F0NPEgpSTIBzdmL6t9c/hNmYTIf689HAx
   JyeADh7GJuoOOtytECRW+JSy9pqxcwkxfy5HuVoOs+VlV00U7fHCwWeGS
   svME5l82/jzNopZbqws+va+GF1TqA3XlsC6hTviBHQyrHGur1XZaYs5ad
   g==;
X-CSE-ConnectionGUID: qETgISLXSwuuL6Cl1aPB5Q==
X-CSE-MsgGUID: FxeyBZkVQIajhXx0x0q7UQ==
X-IronPort-AV: E=Sophos;i="6.03,165,1694707200"; 
   d="scan'208";a="356612877"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 18:55:48 +0800
IronPort-SDR: WAGv6a9bfu/yPgQRvFMZ7elWSJKQleiVDtzdG/IOjvIK6rBtV+qxsRXTlFzZJuE/QN/t7xTslZ
 aM86Lrix9czM0DtAj7/4GME+xOYoH0ojzec0sw7n6Pu1FfA22Mjl6MA5nb4B6bMzgcQ4QHdPgC
 hvqhf0VXhoa3ldm28/9i4s6fOQbXromNQ5Ibs86O04bFFmc3MUFAP8Pw7Lr22bJqxk2u3oS+yw
 3VYPAY7b6EZ421lwZcJNOzNohAy3wmQRmMnY8WSO8xG3yoaNa8ft3LrpmAcYuLyV9hkP4jw9xM
 ELw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 03:08:22 -0700
IronPort-SDR: jQyHhrbHHH064os/C7otDQYACkNcbBL+TVbB7w9bAUEURnMskXpiB8EqNYLMKahlDeRKuD2DCy
 me1ySje7oNHI/Tb+j05vKxI//8Z3BSokt5+bvp5WZ1GodMNl0PnMaWRYyAxKwKYGE6vUKlnWhx
 NMkJWVoHw82L1ZGJxhlFJFonKaly6QNwacORu0hwGVHGQGJtVxAZkxbuUSKWYEF6zhnfMQpcu3
 CIRRkuoMwFB0YHwGIH2YJBO42NHZlod8xoAFHNm2+fiaCie+a4VHyQssQyeuntVvtCMQcivlrO
 nWo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Sep 2023 03:55:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix RAID10 writing
Date:   Thu, 21 Sep 2023 03:55:43 -0700
Message-ID: <a2cecda31933ba147591d3b8017e09acf9605681.1695293696.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix out of bounds write uncovered by fsstress testing RAID10.

Fixes: 341908a5aaa0 ("btrfs: add support for inserting raid stripe extents")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 7b968eaf9e58..a3407c6a756c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -158,6 +158,7 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 	int ret = 0;
 	u64 stripe_end;
 	u64 prev_end;
+	int stripe;
 
 	if (nstripes == 1)
 		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
@@ -173,11 +174,11 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 	stripe_end = rbioc->logical;
 	prev_end = stripe_end;
 	i = 0;
+	stripe = 0;
 	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
 		rbioc->size += bioc->size;
 		for (int j = 0; j < substripes; j++) {
-			int stripe = i + j;
-
+			stripe = i + j;
 			rbioc->stripes[stripe].dev = bioc->stripes[j].dev;
 			rbioc->stripes[stripe].physical = bioc->stripes[j].physical;
 			rbioc->stripes[stripe].length = bioc->size;
@@ -186,12 +187,15 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 		stripe_end += rbioc->size;
 		if (i >= nstripes ||
 		    (stripe_end - prev_end >= max_stripes * BTRFS_STRIPE_LEN)) {
-			ret = btrfs_insert_one_raid_extent(trans, nstripes * substripes,
+			ret = btrfs_insert_one_raid_extent(trans, stripe + 1,
 							   rbioc);
 			if (ret)
 				goto out;
 
-			left -= nstripes;
+			left -= stripe + 1;
+			if (left <= 0)
+				break;
+
 			i = 0;
 			rbioc->logical += rbioc->size;
 			rbioc->size = 0;
@@ -201,7 +205,7 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 		}
 	}
 
-	if (left) {
+	if (left > 0) {
 		bioc = list_prev_entry(bioc, rst_ordered_entry);
 		ret = btrfs_insert_one_raid_extent(trans, substripes, bioc);
 	}
-- 
2.41.0

