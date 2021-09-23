Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A816415E9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhIWMn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 08:43:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8127 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbhIWMn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632400943; x=1663936943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtfAxFEJOn+1RF26g8q9VJJzCjCvyAhOBh8q3n+KqWc=;
  b=AIc85OS+PgnRAJrkJJbgf7A3fJUteEvSHLR4NkzyLAZdHI0mPgcQGXAz
   OqhyHa7vsj2BKhwV20r77hwbUk4VEHB4l8H39tcbzKea6+Q/FDTrhZFpf
   HqvTtbJBspHWKtMGv5hfirq4iVBhP5GFPd8x2Ay/TpSPijWo00bSI6LYB
   qgQFB9XVo2XBtal3JmdBYjmvvqiL5Esgj9LqAZVs5/W7bjWpiZFgQa/tx
   vcyjuxoFwujtE4Rg47AAZg4vwubNRw+8iSmMb/Tb9ByFCuStegmIaICDD
   IQES6d2EI+D/qxH6dXAjF3KwPAEgTB1f4i1tvFk6Fv1Zzq5Oyyy8FBCCT
   g==;
X-IronPort-AV: E=Sophos;i="5.85,316,1624291200"; 
   d="scan'208";a="185547013"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2021 20:42:23 +0800
IronPort-SDR: fKNq0EYx0Elg08odOfoTJKDs7qSLP8Q7MI+MNduJCkeIokdzJxJt/4qQThVPivhJCJFnR8cyFZ
 /ZVwynh3ptAx/dIQe2bCcSd4ksru9UHSJB7mZOTXS9ZqgooKAoOg4aE+CeiXcpG6cdsKGsbaUJ
 uaocD/99CWD05AxtFxaB9kw68KXjjdh7LpxZe/0SS/nMkES/gYeOd9J3P1lOUETOJol6LjEeAQ
 0kd2Hki3RCVoV2Uc7i8r5bjjJyZCUS5g007jZC4pIQCretzv/AxRlA4FuD+g0Wn4UvU+OfSRCz
 /Oxb5RbXPOZourpgJp1QuKFL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 05:18:35 -0700
IronPort-SDR: 1v10TTMslMN7xgjK9jS08zJEU5JkprValPjkg5kTQzJof35xYZsDO799H/Sk+2SscE0jY1NhHp
 0amBgbFIVC75wNFyp1A6JFJ/TnXb806RQBYA9QlALImW0zUW173IQ1iSAQq4lfiyQm48S5QqSC
 ffkQlwb/di/69Xu9/ox55i5/mLmzdA0+ZQR9pbEO5OzQyZrIxX0DzaQ12CiFSLA3+YxLL7U3bH
 DP3hhF29mLZb5zzBKCKPliqzCoXN9fCyQL9drFGthdqXeMCxmwZze/VG3/2mOOHf56uMt9uvYu
 TkQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2021 05:42:23 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: remove max_zone_append_size logic
Date:   Thu, 23 Sep 2021 21:42:21 +0900
Message-Id: <20210923124221.14530-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

max_zone_append_size is unused and can as well be removed just like we did
on the kernel side.

Keep one sanity check though, so we're not adding devices to a zoned FS
that aren't supporting zone append.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h |  3 ---
 kernel-shared/zoned.c | 10 +---------
 kernel-shared/zoned.h |  1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index e79b1e4ced60..8d8521b9d021 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1238,9 +1238,6 @@ struct btrfs_fs_info {
 		u64 zone_size;
 		u64 zoned;
 	};
-
-	/* Max size to emit ZONE_APPEND write command */
-	u64 max_zone_append_size;
 };
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index c245e59249af..2475e7b097ce 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -303,13 +303,12 @@ static int report_zones(int fd, const char *file,
 
 	/* Allocate the zone information array */
 	zinfo->zone_size = zone_bytes;
-	zinfo->max_zone_append_size = max_zone_append_size(file);
 	zinfo->nr_zones = device_size / zone_bytes;
 	if (device_size & (zone_bytes - 1))
 		zinfo->nr_zones++;
 
 	if (zoned_model(file) != ZONED_NONE &&
-	    zinfo->max_zone_append_size == 0) {
+	    max_zone_append_size(file) == 0) {
 		error(
 		"zoned: device %s does not support ZONE_APPEND command", file);
 		exit(1);
@@ -1106,7 +1105,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -1141,11 +1139,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
-			if (!max_zone_append_size ||
-			    (zone_info->max_zone_append_size &&
-			     zone_info->max_zone_append_size < max_zone_append_size))
-				max_zone_append_size =
-					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -1191,7 +1184,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = max_zone_append_size;
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 out:
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 99f8e9a2faac..1e4956475db9 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -51,7 +51,6 @@ enum btrfs_zoned_model {
 struct btrfs_zoned_device_info {
 	enum btrfs_zoned_model	model;
 	u64			zone_size;
-	u64		        max_zone_append_size;
 	u32			nr_zones;
 	struct blk_zone		*zones;
 };
-- 
2.32.0

