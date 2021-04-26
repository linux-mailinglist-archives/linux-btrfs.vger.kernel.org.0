Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078E436AC35
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhDZG3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhDZG3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418510; x=1650954510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtamS0SME954htnKEKlGeGhi8XVokKaxWAHG+a7apzU=;
  b=R2I5g95E9/9unmk+dRhNmzxl4WWEoCT5vNrZxoqZ5gdtkFVog4Ddrh5A
   oF/yZq+fqqKasxw69Mwoske+9CswIVX/01CFTjazQy3L66s0AtAcYrMy0
   FTY0Jlj+EWYBL+eLGkr26+Vl+OlzVvwo/UMp3vf8HJvHuxh2j5BeTvRPe
   X5wgT4t25u+hbsSkeGy56Yk8ZKzw5UrSmzOmteoxhoLsdZB05ijbpbc95
   qFKPmj2jlTrgOdbk5A9Qf/9vjAxcUaVVrDHVrUu0RMF3GjJgm2gvTHJ2S
   6DVvAQcPTf+qW02YjjMosrnh/fsX/eQIzmBaG9tDjYF7PzHkcmqA0yePV
   Q==;
IronPort-SDR: i9gajImBpTiLbKBlIr7IlZLeCrXU7G0nFbzwtWP3Sxsj6dj1nsQi5AyKX7sC8i2YE6+RDTcJ36
 RETPbT0k/Yk9BKKYLlB/EEZaoBYlXrYfS4i/Je27nWrM9YC7dKwDtnznlkjuq8MNygFPiTJ6nk
 1kxi6CeuUvPfkiGthky2ZEl2A89rI0fnq5+3TQK4WvWBR6PqNlOF5Hb83q4xwM6drAkUQqIRDG
 zBD8lEDw8o2EmFk42F8uzDTo7m0TXfePap2bi6Yrbrt/CANt7ytVVoMqWErWkG9GZj099gzXqK
 SAA=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788137"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:29 +0800
IronPort-SDR: HwbeA5++HHyuLCYTL5Eh/AgtJaUD6O2bza3JkUhAm3zp00dCuiMWJujNR++JWT+DS/y2nWR3kb
 +jDZtRScS9MC/vqs6OR8RzjEJZwM3uKA5KCcAPhAvcdlaBfdHi7vsYXuyIr0pZ1hxXY9uHOKnE
 TVdAZvgnu79vRpTASr3Gm9Ng1da5iUUVVOHhPF2ZnS2LmMO06iSJoCqalDpZOVV1AC+D+oUF6j
 qsaRfdST94LJm6JxgyOdwjrkc/R9+rkpPKNjkslW+7ffKE/pY32muWXJ+UqwIyJvpDSEVLF9uD
 W1N6BDk9tHr6aF9YEC8wNhaq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:55 -0700
IronPort-SDR: 7kBS1Va1IR8on4TsE/5bkPx7GOI/QFnnv7YRba2JPTnhR1Q7e/Ac9yldaYW7X6Qrxlb3Zk5Dfo
 xdwMSqqtMYHeSGiqIDNZJBy51T+UDjqxgV+NxHs+jPPyTeRqexVydTFg3d1wejJ+T8v10YR9+m
 dLu/ygzXngGyK/vFMEyQ5vXE+bMWthK53hxU2/hBZSBD6dw4Ayc4R0lcqj6H0vzly4KYVn5Df5
 TpNm0kaTUaPsr6oXAO7U7qahjJ4LLbo3kOkeYRtHJW7uqqKB/llMkiCsDLGcJ61/iF3xLmUAhQ
 K/c=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 20/26] btrfs-progs: mkfs: zoned: detect and enable zoned feature flag
Date:   Mon, 26 Apr 2021 15:27:36 +0900
Message-Id: <a59e2aa021d326107b5581f6a748700c7f7c5e8c.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit make mkfs.btrfs aware of the "zoned" feature flag and prepare
the disks for mkfs.btrfs. It automatically detects host-managed zoned
device and enable the future.

It also add "zone_size" to struct btrfs_mkfs_config to track the zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.h |  1 +
 mkfs/main.c   | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.h b/mkfs/common.h
index cc88db7183fb..4d86f5ef4ccc 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -65,6 +65,7 @@ struct btrfs_mkfs_config {
 	u64 num_bytes;
 	/* checksum algorithm to use */
 	enum btrfs_csum_type csum_type;
+	u64 zone_size;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index a903896289fa..42e6e6b58b04 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -37,6 +37,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "common/path-utils.h"
 #include "common/device-utils.h"
@@ -900,6 +901,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int metadata_profile_opt = 0;
 	int discard = 1;
 	int ssd = 0;
+	int zoned = 0;
 	int force_overwrite = 0;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
@@ -1069,6 +1071,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (dev_cnt == 0)
 		print_usage(1);
 
+	zoned = features & BTRFS_FEATURE_INCOMPAT_ZONED;
+
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
 		goto error;
@@ -1109,6 +1113,19 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	file = argv[optind++];
 	ssd = is_ssd(file);
+	if (zoned) {
+		if (!zone_size(file)) {
+			error("zoned: %s: zone size undefined", file);
+			exit(1);
+		}
+	} else if (zoned_model(file) == ZONED_HOST_MANAGED) {
+		if (verbose)
+			printf(
+	"Zoned: %s: host-managed device detected, setting zoned feature\n",
+			       file);
+		zoned = 1;
+		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
+	}
 
 	/*
 	* Set default profiles according to number of added devices.
@@ -1278,7 +1295,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
 			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
 			(discard ? PREP_DEVICE_DISCARD : 0) |
-			(verbose ? PREP_DEVICE_VERBOSE : 0));
+			(verbose ? PREP_DEVICE_VERBOSE : 0) |
+			(zoned ? PREP_DEVICE_ZONED : 0));
 	if (ret)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
@@ -1309,6 +1327,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
 	mkfs_cfg.csum_type = csum_type;
+	mkfs_cfg.zone_size = zone_size(file);
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1391,7 +1410,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				block_count,
 				(verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(zoned ? PREP_DEVICE_ZONED : 0));
 		if (ret) {
 			goto error;
 		}
@@ -1502,6 +1522,10 @@ raid_groups:
 			btrfs_group_profile_str(metadata_profile),
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
+		printf("Zoned device:       %s\n", zoned ? "yes" : "no");
+		if (zoned)
+			printf("Zone size:          %s\n",
+			       pretty_size(fs_info->zone_size));
 		btrfs_parse_fs_features_to_string(features_buf, features);
 		printf("Incompat features:  %s\n", features_buf);
 		btrfs_parse_runtime_features_to_string(features_buf,
-- 
2.31.1

