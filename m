Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE594F5AD2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiDFKFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiDFKEk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 06:04:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FE2DD3A5
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209429; x=1680745429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1w6wnSgfWk7aRR5DChrrbID1bDVYX1evttk/zngMFc=;
  b=HzH/Mhwi4MoUgBIcAcBG++AKZUgtDZdLESwEsdnjXmD4tcgEmfY2Brsd
   0Y0f8/ULZsAjpVTaB/hiD7p2PRTWjhS1l8iKZ3ZkY3mS53c7Fk19PEIF3
   V7eJ4rKZZOsV75qnkKmfaF78i2O4hL2uXxhM2t29/Joq/XCKUUnJLdtoW
   yVPZ966mKY2bT4blkGGyimB5zkdzkGRLvCwHqpl6mA8bFWLt9yRBLQqa8
   sAukxSAotrAiOi+fRjFunJSQFhf5GXqbzuNiELfYlrYkThySWLwAlPJKU
   9CSUhBYToYzDHV0JrbdxKN2BRuXtP8nw8udtkto4JdiSFagnA0bAChJKF
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="309153502"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:43:47 +0800
IronPort-SDR: Qcx+HmMU/Vfw16+iK4NdO7gt6xUeWYmnj9G/J1HyHY7EHXs0wUA2M6XhJQjUoReU2mGmOSddse
 5K/Ndyrm3T7EAIXNAgl34dzbILNEN/1TcskwdVQWfOVCDfXvCeqH1oyAoJEORmQVp8jIrd3W6m
 MAIAY+hDGeRyZNfs5s18Qi7hY+3OiIWx7ERYBlWEy6wEORmHfsIweuzhH3zob/616EXTkCE4gT
 K6BaKA7RF9DGySOiSSrjY7ajIxyqVPHTYqUw/2KDvDV9+1xYonwhARBeKbbnPuZqZwyTDFvQwz
 zBnkyVUuf5zvJZYb0+l8qFGq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:14:30 -0700
IronPort-SDR: x6K0rF8u15lwowP0kSB+G4IS4zvNqrnoUFIUYnQBlg0GrJA/nh0Lf7oPDe86BUactF/GV7tUVc
 TpnKVTiYhdMuZ64HOF/WbiUMgEJ3ZJK87D86Ol9xeECha3SMdW09tFqSMJbCXcWfRZTrdacQDo
 GhAKfgjdbITgKSNzSKkTg5c0zBzZEMHCFoWdk4Q4Od/QtVPIENIbEgmBVsh0y027UU00cyTvL4
 A22lJWAzY/OHFRnXuS8P7brQj0sOD8BbrD57LpBdjAEVgOMOmYk2KVPUbr81VRfQgR4IVfH3aj
 MUI=
WDCIronportException: Internal
Received: from 5cg2012qdx.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Apr 2022 18:43:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] btrfs-progs: zoned: export sb_zone_number() and related constants
Date:   Wed,  6 Apr 2022 10:43:10 +0900
Message-Id: <20220406014313.993961-2-naohiro.aota@wdc.com>
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

Move sb_zone_number() and related constants from zoned.c to the
corresponding header for later use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 33 ---------------------------------
 kernel-shared/zoned.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 2a11a1d723aa..396b74f0d906 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -33,20 +33,6 @@
 /* Pseudo write pointer value for conventional zone */
 #define WP_CONVENTIONAL			((u64)-2)
 
-/*
- * Location of the first zone of superblock logging zone pairs.
- *
- * - primary superblock:    0B (zone 0)
- * - first copy:          512G (zone starting at that offset)
- * - second copy:           4T (zone starting at that offset)
- */
-#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
-#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
-#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
-
-#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
-#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
-
 #define EMULATED_ZONE_SIZE		SZ_256M
 
 static int btrfs_get_dev_zone_info(struct btrfs_device *device);
@@ -220,25 +206,6 @@ static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
 	return 0;
 }
 
-/*
- * Get the first zone number of the superblock mirror
- */
-static inline u32 sb_zone_number(int shift, int mirror)
-{
-	u64 zone = 0;
-
-	ASSERT(0 <= mirror && mirror < BTRFS_SUPER_MIRROR_MAX);
-	switch (mirror) {
-	case 0: zone = 0; break;
-	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
-	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
-	}
-
-	ASSERT(zone <= U32_MAX);
-
-	return (u32)zone;
-}
-
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
 {
 	struct blk_zone_range range;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 75327610e537..cc0d6b6f166d 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -36,6 +36,20 @@ struct blk_zone {
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES		2
 
+/*
+ * Location of the first zone of superblock logging zone pairs.
+ *
+ * - primary superblock:    0B (zone 0)
+ * - first copy:          512G (zone starting at that offset)
+ * - second copy:           4T (zone starting at that offset)
+ */
+#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
+#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
+#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
+
+#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
+#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
+
 /*
  * Zoned block device models
  */
@@ -206,6 +220,25 @@ static inline bool zoned_profile_supported(u64 map_type)
 
 #endif /* BTRFS_ZONED */
 
+/*
+ * Get the first zone number of the superblock mirror
+ */
+static inline u32 sb_zone_number(int shift, int mirror)
+{
+	u64 zone = 0;
+
+	ASSERT(0 <= mirror && mirror < BTRFS_SUPER_MIRROR_MAX);
+	switch (mirror) {
+	case 0: zone = 0; break;
+	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
+	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	}
+
+	ASSERT(zone <= U32_MAX);
+
+	return (u32)zone;
+}
+
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
 	return zone_is_sequential(device->zone_info, pos);
-- 
2.35.1

