Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53AA7C702F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbjJLOTn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjJLOTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 10:19:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD70BA
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697120381; x=1728656381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoLweWyMWYBz60ru2iB27n0VKdhO6VUKQujrZeBIajU=;
  b=h3Pa2ip/yMJL9MF0GGdQRbD9uzQH8Pd/G5xrp95dUXNWNxMBPI/1owXm
   qV2WLazIRLslNKCywAc1zOuOOJhv5zmCfN+YDScId4xUwnpy86+dT8Vri
   ajTveh3K7dePO+w7PYUrjS7qN4IuMyi/znTaKhxh/TlZxI0l57jv1O0hO
   qXlncg1guWP+fW02YuaWguR+G6CdigpH4icQnMNAY1VJPBHnkZW5RpSNe
   Ag5pCtQF/QjCwmY26Rsk7k3u/6/S4PqGdJlt0XGWb7HMrs95T63O7lbVt
   i3L+9QNtUzZrEVddreTplrNW9PcnmHYiXNYwYUFNbfjZAKTAQ4c2xzFaQ
   Q==;
X-CSE-ConnectionGUID: gTnHrBlmQXezrka5U8zBsQ==
X-CSE-MsgGUID: /g2RFl4aTsidHjFcwUVlBw==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351743178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 22:19:40 +0800
IronPort-SDR: STV5o+S00/w3dhPFsn6wG+TBIgFCJYnFXdD2sifpxU8PmuSLaDiYWBakv0A8XARXA2YacMNEPH
 apNAgkdw5dHszbI04Wm5JXZWttdpsaWAI1zgfkLr6zvTk8Hmk/3AQ9gfCyBY4B0U3fRvhFuWHE
 Ti8rydcmiHlAkugMtzOB/8yRwD9iI8FSX8h95QD9f0Ktk8d1MJgi6qLQf7VMjU2bDzCwjekg1I
 FVMbZfByG+tqjij65F40/boRO3zPzkxWUuEQIPoCqhQ+WMHx+961SRDi3v5kcFjP3dP4r871z1
 zeU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 06:31:48 -0700
IronPort-SDR: Jhc+wyCKveDs4QcglYOvg7TOgSjDfs4TXIFR6SEa2K2IdA0wOq1Gei9HG0IuyRbJkkOrydfy8Z
 SmwV7JIlqwbmPJziQckKhDvxMkzfDFqGhUX7ftyU1b3NiSMt5Gi6noN+b4mWb9RoDtRRTSE1Ja
 XQq33ZmsRu8gb8pht7lgpQGT1DPWCjhCuv1ZShMLlX8NhiouoIXcAu5DfGn88ZgCZRlNLMFrfX
 MdMZiItCpxc1ETIZHtFOpxgJWSUxHWGwRByhaw1opM4dbm041HZ3zGhiH6vbDqVrSX3/F77CvB
 DqI=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.25])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Oct 2023 07:19:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs-progs: zoned: check SB zone existence properly
Date:   Thu, 12 Oct 2023 23:19:30 +0900
Message-ID: <5162f065fa9b020c2a3cf1906327fae7c0a16913.1697104952.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697104952.git.naohiro.aota@wdc.com>
References: <cover.1697104952.git.naohiro.aota@wdc.com>
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

Currently, write_dev_supers() compares the superblock location vs the size
of the device to check if it can write the superblock. This is not correct
for a zoned device, whose superblock location is different than a regular
device.

Introduce check_sb_location() to check if the superblock zone exists for
the zoned case.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/disk-io.c | 9 ++++++++-
 kernel-shared/zoned.c   | 8 ++++++++
 kernel-shared/zoned.h   | 6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 1b1531c52ad7..a056f2ca0560 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1998,6 +1998,13 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 	return transid > 0 ? 0 : -1;
 }
 
+static bool check_sb_location(struct btrfs_device *device, u64 bytenr)
+{
+	if (!device->zone_info)
+		return bytenr + BTRFS_SUPER_INFO_SIZE <= device->total_bytes;
+	return btrfs_sb_zone_exists(device, bytenr);
+}
+
 static int write_dev_supers(struct btrfs_fs_info *fs_info,
 			    struct btrfs_super_block *sb,
 			    struct btrfs_device *device)
@@ -2048,7 +2055,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		if (bytenr + BTRFS_SUPER_INFO_SIZE > device->total_bytes)
+		if (!check_sb_location(device, bytenr))
 			break;
 
 		btrfs_set_super_bytenr(sb, bytenr);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 206ad906c985..491d52eab942 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -1175,3 +1175,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 out:
 	return ret;
 }
+
+bool btrfs_sb_zone_exists(struct btrfs_device *device, u64 bytenr)
+{
+	u32 zone_num = sb_bytenr_to_sb_zone(bytenr,
+					    ilog2(device->zone_info->zone_size));
+
+	return zone_num + 1 <= device->zone_info->nr_zones - 1;
+}
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index f4b0d5d06301..6eba86d266bf 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -153,6 +153,7 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 		     size_t len);
 int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
+bool btrfs_sb_zone_exists(struct btrfs_device *device, u64 bytenr);
 
 #else
 
@@ -225,6 +226,11 @@ static inline bool zoned_profile_supported(u64 map_type, bool rst)
 	return false;
 }
 
+static inline bool btrfs_sb_zone_exists(struct btrfs_device *device, u64 bytenr)
+{
+	return true;
+}
+
 #endif /* BTRFS_ZONED */
 
 /*
-- 
2.42.0

