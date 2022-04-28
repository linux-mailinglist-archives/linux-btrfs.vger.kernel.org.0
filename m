Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342B5137A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbiD1PFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiD1PFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:05:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE4B3C73
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651158146; x=1682694146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ars0dbGK5yV6UY9VSIWcAYeT1hi5xBWcXDHPP3vCVHs=;
  b=dmym7YMTpC38ZLmtx2aMtjERiyPMvmr/Z2WApW7kCmVVUI3+ymD+MLJ7
   IdLFTEHdBk+63HcV7pWybS7NfwzX/mrN5oJnNtNCB4IZ29xsYhf8j2dWW
   FWwH6Jcl/R6R3vM/6kdQr47gacoQEhtx9FD/qvGoaJ8pdgSs/HQwBH5Sg
   HDHckka7h8DWr73QxcsoxARiIgdRJnwrAZpqh8aWZtcQPC54xzo2M+dHG
   h1mVsafspfxtoR9zlHopLyGJf+mOjU20OadOtAWlg1dyJJQPWGOzUD0Z/
   HJ+nJ7KvRwJjAN45Au0Tcv4Vn+5ZXc9dZaCC3Bk6arpFVkxb9mjq3iapO
   g==;
X-IronPort-AV: E=Sophos;i="5.91,295,1647273600"; 
   d="scan'208";a="303279897"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 23:02:24 +0800
IronPort-SDR: qKxGQdj8gUeKxBv4vuyDiFG/vZrG5MZYVgOcUEjzZMGqEJ0KNgQ2lRDUh+Vf/KWFSB8jO89unN
 3S4SdLpOCmZYfZySjnxUGePzMLXMngPqDR98KBtozkib+OtAKSVq4qQvaEb+fwHY71oxC6cxKH
 emEKhO9i1adrU69o51f9z1l/kZUzgvj5WOLMN7CNhoLZqzPmCsc0xgv3dOIfRR1OEG6M6TMPpk
 sewiTpFiWR4Oy4EknTgkSysYjsqjRmWKLmWEupoT+jJd+XPNlg/iMKZXK1ZpusFGHkn6LbxbJi
 YtVByPjPvL2vQ2XtZNHlLKKa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 07:32:33 -0700
IronPort-SDR: bu4pzD/cp0/LlnGkvb/bLzMlrSpOUbmeBicbgRlq/eRV98Tt5W03wsWodKirFFlbbK/d0JYJEN
 KQxinUU3/XQhTIwDykQqdPF7ba8YaJAAgOWCMtzBSghTW6sk0zT7i6iIdRiT0G9b+jHLH/Icfp
 153m+RetGXhWZFdJqKmYnTShqHRMpsBh2Yf5Wl8Hu+HR7WRcJ/iqf4D6iV2YtHLsQcB5DiHEL1
 CxwQcDBPwOoUwL0yY70RAjO+7uavHAaokJBSqkpNXRdakMbfB0vxfVfggDwsivMsvlQ5X6r3N0
 4jI=
WDCIronportException: Internal
Received: from fd6v5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2022 08:02:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs: zoned: finish BG when there are no more allocatable bytes left
Date:   Fri, 29 Apr 2022 00:02:16 +0900
Message-Id: <42758829d8696a471a27f7aaeab5468f60b1565d.1651157034.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651157034.git.naohiro.aota@wdc.com>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
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

Currently, btrfs_zone_finish_endio() finishes a block group only when the
written region reaches the end of the block group. We can also finish the
block group when no more allocation is possible.

Cc: stable@vger.kernel.org # 5.16+
Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9cddafe78fb1..0f6ca3587c3b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2017,6 +2017,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
 {
 	struct btrfs_block_group *block_group;
+	u64 min_use;
 
 	if (!btrfs_is_zoned(fs_info))
 		return;
@@ -2024,7 +2025,14 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 	block_group = btrfs_lookup_block_group(fs_info, logical);
 	ASSERT(block_group);
 
-	if (logical + length < block_group->start + block_group->zone_capacity)
+	/* No MIXED BG on zoned btrfs. */
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
+		min_use = fs_info->sectorsize;
+	else
+		min_use = fs_info->nodesize;
+
+	/* Bail out if we can allocate more data from this BG. */
+	if (logical + length + min_use <= block_group->start + block_group->zone_capacity)
 		goto out;
 
 	__btrfs_zone_finish(block_group, true);
-- 
2.35.1

