Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747D036AC26
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhDZG27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418496; x=1650954496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tUSU1R6uYdSefDdZrLuIvSJhhlRTRNNwQAAC8iniTis=;
  b=a+NpKD0YlJKhvoWub1x5/CMF3t434s8yEmOqed/BMEQ3ofwlP1ihRHyT
   0U7MqOFurMWbDSbmu5hwFlYDOhZkE8C0Iynpoi4eAycyDqXWfZn0jm3A0
   vVFnMfY+r+ENZNr9EAC2V3dGegqsFfYMlKFQ5tNauMz0uFmxwUpqSa2Ie
   5iJNfQ5onF8ltYsyQMShiPfNneFTAZDaeCrTn7X21YwjvO4Wc40uKO9QW
   jzAVyZcYE/tCdH32+StHem//AJnYtd4o39a0cJrGEIAHQQmmJpF9lY8xp
   TYpUr1xIUvaoOjTalw9x5/5Jyi5mNM9jofv1qD+NnWDMuXLGiZT1xmM8h
   w==;
IronPort-SDR: KzJ3k/ZeoG1NXE2RfBjVLDVymh4jY+dNMslXE/OkmQYS1TwcuvzUsUn4177yy2+1HZE2Mw+Ile
 g6kSsdCAU7t1jdcOR/dG3vmU+yYm3mpX2iUNMn18ylYUH/E/JExGUK3avwvazMZt6FDiw5ncmK
 1kt/PRNK0n4NhKjEKp3bHPm2kxRXSjLIrvWBYb7Baq7RfEM1OieGV5XIoyOahjGi5MgvEm5FfR
 LfZGCP3SvmFFJRccWmpQIvuVsJeeEOk4aZgyTrVOCYvkgVvLCt3SzNAOGwW117/RC5I/Pwes5b
 b9M=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788115"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:16 +0800
IronPort-SDR: w5QMKhHu8H4n+Q2tFI9sPFoY3Zgze+AtwKFWQvmcUgkQEotjzSCqILiqRA4dHrwWM+7Er8Hy2U
 WOoF6lCAyGmngyA+JZzseNnRA0xO+YrZB5feqRUUVq0PaXXA9fLPH7M7G5KKRi4DoqOY40EnQe
 Ug0kDy51AKjqILBkCySYZ2alG3HV/T5n9/v+Hpb+leKODg7p0d/I7uppxVPd/JeHdfZ9hbPOni
 QNs3NLssUa5+MDMrLaHCi416YTXmzPNN9r19Bhg2LCSDMD1w6RKEmdeSChw5m8cH2M4jADzQdf
 qdk8CQez0rLvX6k0F9v0rLcZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:41 -0700
IronPort-SDR: VGxuJn/PUjbHuissdAbt6FNywGtxfHPHOVezfbjtV6ecy+llcSQMcuXf80/G7V84A6giqs2raj
 R5P0yPOy37LpgixOLW6C9RtvmpU5RybLPV9fQmeCugEydAiEuu++mlwxq20GyKwdfvJ+r5jDPj
 O507BiWNRq4Hd23UczwkrDf8KH8UDVUVBycL5NYdQi7aV5qiZVMNjRoKVHFhJEMyrX2v3Fn/+/
 yZSxTYIo9XRyjZvGgF2guxL/ZnVUcHNzXPkvhte85qPlNGEVtE6T7xUH5fBXiBachJWR5MDXVE
 mLA=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/26] btrfs-progs: zoned: introduce max_zone_append_size
Date:   Mon, 26 Apr 2021 15:27:23 +0900
Message-Id: <1023703371dbf8239f11f7fe8061b26dde480511.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The zone append write command has a maximum IO size restriction it
accepts. This is because a zone append write command cannot be split, as
we ask the device to place the data into a specific target zone and the
device responds with the actual written location of the data.

Introduce max_zone_append_size to zone_info and fs_info to track the
value, so we can limit all I/O to a zoned block device that we want to
write using the zone append command to the device's limits.

Zone append command is mandatory for zoned btrfs. So, reject a device with
max_zone_append_size == 0.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h |  3 +++
 kernel-shared/zoned.c | 29 +++++++++++++++++++++++++++++
 kernel-shared/zoned.h |  1 +
 3 files changed, 33 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index aab631a44785..5023db474784 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1222,6 +1222,9 @@ struct btrfs_fs_info {
 		u64 zone_size;
 		u64 zoned;
 	};
+
+	/* Max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
 };
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 7cb5262ba481..ee879a57b716 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -58,6 +58,18 @@ u64 zone_size(const char *file)
 	return strtoull((const char *)chunk, NULL, 10) << SECTOR_SHIFT;
 }
 
+u64 max_zone_append_size(const char *file)
+{
+	char chunk[32];
+	int ret;
+
+	ret = queue_param(file, "zone_append_max_bytes", chunk, sizeof(chunk));
+	if (ret <= 0)
+		return 0;
+
+	return strtoull((const char *)chunk, NULL, 10);
+}
+
 #ifdef BTRFS_ZONED
 static int report_zones(int fd, const char *file,
 			struct btrfs_zoned_device_info *zinfo)
@@ -102,9 +114,19 @@ static int report_zones(int fd, const char *file,
 
 	/* Allocate the zone information array */
 	zinfo->zone_size = zone_bytes;
+	zinfo->max_zone_append_size = max_zone_append_size(file);
 	zinfo->nr_zones = device_size / zone_bytes;
 	if (device_size & (zone_bytes - 1))
 		zinfo->nr_zones++;
+
+	if (zoned_model(file) != ZONED_NONE &&
+	    zinfo->max_zone_append_size == 0) {
+		error(
+		"zoned: zoned device %s does not support ZONE_APPEND command",
+		      file);
+		exit(1);
+	}
+
 	zinfo->zones = calloc(zinfo->nr_zones, sizeof(struct blk_zone));
 	if (!zinfo->zones) {
 		error("zoned: no memory for zone information");
@@ -248,6 +270,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
+	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -282,6 +305,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
+			if (!max_zone_append_size ||
+			    (zone_info->max_zone_append_size &&
+			     zone_info->max_zone_append_size < max_zone_append_size))
+				max_zone_append_size =
+					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -321,6 +349,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
+	fs_info->max_zone_append_size = max_zone_append_size;
 
 out:
 	return ret;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index a6134babdf41..fcf2ccf34f26 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -29,6 +29,7 @@ enum btrfs_zoned_model {
 struct btrfs_zoned_device_info {
 	enum btrfs_zoned_model	model;
 	u64			zone_size;
+	u64		        max_zone_append_size;
 	u32			nr_zones;
 	struct blk_zone		*zones;
 };
-- 
2.31.1

