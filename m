Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3975EA6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGXETE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXETB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A6183
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172340; x=1721708340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMLoMloQswD5Su5jdSIOAyVbWdMn4f5JbcoU9G0vHBs=;
  b=S0kd6vEYydY3Xgzki6pYnYqyhQtLoP0s/4JZRXiNiSH4NwtA9mLtCp42
   lgI9q5XfDDxCrL7BzflecqeIy79euSoF7RbaYp6yYx2U4czElgoGBcmxY
   9KA57d8YOAC3Br7zZVeYk4wq1PZJntN7EwxsIIdfyRiV098GS11y84yfi
   naZwWcN2s6zpmHtp5eyw3Jj1kk7SodMFR7P5Jl4auKt2EpIVi1INx7g7H
   V4mrMqXL9iS4H4HdsVP6LFapQFMmt2PzsIqjl1G7hhz4UI05SEkZJkR4t
   x3AmAM6K+H+HLGMkKFIUwY25iIwx4rPxYsHk/cHBYxuUCf+qcvLxAY2lW
   A==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524374"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:19:00 +0800
IronPort-SDR: 3dRolEoKdQF3bhjTwYgKoIngJVmYGvl1CBqTTr3BFII8sKYCpfVEB/eUNguJFDxkuU+oMKpOyc
 urIy2qVjtbyzB/CAKu7xcrYlU2E+1St2QT4v7d6y118eF+aR2+uNB23UEK4ZONRIzJg11JrRf0
 F1kN3mNjmieSpe0sW2kZ4pqUb9hRAU/0+QVEx+k03X0ZP/4PNsHpbIESBWWbSV+0zFfQRqiCRv
 PluIzXKtvYYSmRvufR/MoMPeDjOU7xWmDJWtjLi6HK5Ex/ymciDRXPCAbZ+TeujvyKjPyRU1uR
 oxo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:05 -0700
IronPort-SDR: c4GtxJJEPRyQTCruKndXEVbR8hSvbrxdEpUPOstJPdEjTB9NN8y0jeug0tzf3QV/xsJcUAuMpW
 7iLRcjae+IGmLIafaXjCFW2Ebf3+o1qIqAq3aEjLIqrbjvDu44ZCaqEWrj0q+XQYd9th2kMiEb
 qnSTgF2iHXnSibrR4/GD8WoLbSgl7KXDGlmTORbftlifaAniSDhRBpazfT0YigCS6PKk/NzK6l
 rNGVWqSLX7Xdts8wUtP2Rrc6YtPcqRdYpHlBZx7o7+aYVk6AXqaRLodcvyIW2yRKykSuaB/+zN
 bqw=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/8] btrfs: zoned: reserve zones for an active metadata/system block group
Date:   Mon, 24 Jul 2023 13:18:33 +0900
Message-ID: <df9fa11d7d8299b04b99d7276a764bfa318f5734.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
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

Ensure a metadata and system block group can be activated on write time, by
leaving a certain number of active zones when trying to activate a data
block group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dd86f1858c88..dbfa49c70c1a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1867,6 +1867,35 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
 }
 
+/*
+ * Number of active zones reserved for one metadata block group and one
+ * system block group.
+ */
+static int reserved_zones(struct btrfs_fs_info *fs_info)
+{
+	const u64 flags[] = {BTRFS_BLOCK_GROUP_METADATA, BTRFS_BLOCK_GROUP_SYSTEM};
+	int reserved = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+		u64 profile = btrfs_get_alloc_profile(fs_info, flags[i]);
+
+		switch (profile) {
+		case 0: /* single */
+			reserved += 1;
+			break;
+		case BTRFS_BLOCK_GROUP_DUP:
+			reserved += 2;
+			break;
+		default:
+			ASSERT(0);
+			break;
+		}
+	}
+
+	return reserved;
+}
+
 /*
  * Activate block group and underlying device zones
  *
@@ -1880,6 +1909,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	struct btrfs_device *device;
+	const int reserved = (block_group->flags & BTRFS_BLOCK_GROUP_DATA) ?
+		reserved_zones(fs_info) : 0;
 	u64 physical;
 	bool ret;
 	int i;
@@ -1909,6 +1940,15 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
+		/*
+		 * For the data block group, leave active zones for one
+		 * metadata block group and one system block group.
+		 */
+		if (atomic_read(&device->zone_info->active_zones_left) <= reserved) {
+			ret = false;
+			goto out_unlock;
+		}
+
 		if (!btrfs_dev_set_active_zone(device, physical)) {
 			/* Cannot activate the zone */
 			ret = false;
@@ -2103,6 +2143,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
 	struct btrfs_device *device;
+	const int reserved = (flags & BTRFS_BLOCK_GROUP_DATA) ?
+		reserved_zones(fs_info) : 0;
 	bool ret = false;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -2123,10 +2165,10 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 
 		switch (flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		case 0: /* single */
-			ret = (atomic_read(&zinfo->active_zones_left) >= 1);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (1 + reserved));
 			break;
 		case BTRFS_BLOCK_GROUP_DUP:
-			ret = (atomic_read(&zinfo->active_zones_left) >= 2);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (2 + reserved));
 			break;
 		}
 		if (ret)
-- 
2.41.0

