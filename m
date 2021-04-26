Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0851C36AC3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhDZG3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhDZG3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418516; x=1650954516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRDalgsr7TMC45xcY7giVXe7YppZxa1ApJwfiZdlyhY=;
  b=gqiy59vtq3DYzJRzRg/me3V6/VURciIKDaFrkwoEuKofvzKZXctIOz+Y
   jVnwuesyxGW7H36xq68gTOMmMd+X8DEt8dwTUtGOh3Mzf7UKMQLJ/5Fqj
   mUtdNzFhZZUUk8zUWWre3Eaol9nv3vyJzKnPEL8Cp3qbTXuNUvk/+w24v
   DCzRrIiIQLX+kWwBrmKbmGs2fEgE5mKtvm+8LaVwQol4BmZwcd4B5RoMz
   9SgN6fymM2kXn1TgvpicRoyM2jGFwa8GWN0mMMUVvFpnEm55Snam4CoAq
   EBzDBXso5xog6Di8F1XteZaRJBHC7euZoKepLqsKlxLI6t7UHggGBX4Uz
   w==;
IronPort-SDR: kMqSDHWlj5f+gEY+ySBy5X3yprcf1kKqoFMiNrkF4GN3r1JTLqmWMt36AvZ/9PArKwX4UzYR53
 LAniwSWrAvSB7jrahAuPkCm1n9+p6ITIbdNPMviMD8GN8bh3JDFKcNWZaV3W3MTeXrj8kJTOyI
 W3moLZVrReY9UsU1mR6CPmBlIUJTO6KLglar3YwdTHX6kbbx5oM7BaWcNDyXIddZff9JbsnKZ5
 BRAH4RIjEl3ELbDyR4OAlmysejXmJKhOMj5xZMKeAwDAol/+SW3puH17jtgWzqmshNJEUUELGL
 1Q0=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788144"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:36 +0800
IronPort-SDR: sWuLQdTClUVLndH0aqLByOXOJMV9FQs7iFdAyXTr0nWRQoO78MAXvjb1j4RqazeReQxDBkW9f3
 TLbNDfQQqCaaLuh9egJngn/FsaNxPmTbFjjOSEFxgc6KStNTB5SXnkaWRLXyHq1Cd+iFbdkHNU
 WwbbhNDK7vnwCZ3gLCbKepsWVvGuBAsUXIfJLCra84cAja1k5C8fM+QtiQ5uqXUzZJr43BcOEz
 K3J3izR5SrmMxUAadcLBkCpSJ1BBIvXK4AaaMWTBVnJayqVHkHF2bG5sLezGbkfo9CuqpwVDTk
 ul0FbIA0m6P+OaOwsKrKnqLB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:09:00 -0700
IronPort-SDR: 79SmdgjlGxoV3aL0pzZ+zK9Xl8MzmuxXZJ19ETNNGhtRiLHtKSq9PcfR3MEKgEc+/LRS9hzisy
 7kTEVhZ2a/1+C1s1ltXClb9Nx4/SeuybZZ67TIpJyeyGAjE8H+DFU5CvXh6n/nMp+paOPflATx
 k4X4eEavaHfYnRVsgHZ6DeELRJzheK2Uf6WmHfef/d4d3oCLjGe37Yne5Cic70Fut1WQ3Y2xwK
 nlXuYbLuIsUPSXqZjhfrlGL8klVB0/RsnTrO97/Jbev1udZv8ip+96LgroSDgwI5VETmZkroLC
 Xbw=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 25/26] btrfs-progs: zoned: device-add: support ZONED device
Date:   Mon, 26 Apr 2021 15:27:41 +0900
Message-Id: <f4c9911d1cefee8fc678b4f9be068acfb8fae641.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch check if the target file system is flagged as ZONED. If it is,
the device to be added is flagged PREP_DEVICE_ZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/device.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index adc21053fbc8..4cc104b788bb 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -29,6 +29,7 @@
 #include "ioctl.h"
 #include "common/utils.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/zoned.h"
 #include "cmds/filesystem-usage.h"
 
 #include "cmds/commands.h"
@@ -65,6 +66,8 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	int force = 0;
 	int last_dev;
 	bool enqueue = false;
+	int zoned;
+	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
@@ -113,12 +116,27 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 		return 1;
 	}
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("error getting feature flags '%s': %m", mntpnt);
+		return 1;
+	}
+	zoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED;
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
 		int	devfd, res;
 		u64 dev_block_count = 0;
 		char *path;
 
+		if (!zoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+			error(
+"zoned: cannot add host managed zoned device to non-ZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
 		res = test_dev_for_mkfs(argv[i], force);
 		if (res) {
 			ret++;
@@ -134,7 +152,8 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 
 		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(zoned ? PREP_DEVICE_ZONED : 0));
 		close(devfd);
 		if (res) {
 			ret++;
-- 
2.31.1

