Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5910466B5DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 04:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAPDJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 22:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjAPDI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 22:08:59 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB34485
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673838538; x=1705374538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BldiiUdCZl/EnQ4f6uidcKsmRnYf5WZuim53wnmUVKk=;
  b=XMSYr4pXgf8ddNdHESqUATCRb2Slhyj5ZRV8imZOQ+3Jyv4pGwTNxOIF
   QP4hoZ1k2H5P4CIRAPVWjXPs4UE8PFFnKXw4ZWZImeV37YiQnPftOXSb+
   TK3QqGRxdmkvr7Lj+oy+9J5LPw9AgIGmLTk9hRIpjOaT7YAhBpZU8a+nD
   TGWZld3TM1JFkCfZrsjNSJ8DAj8/Lbs/hNSj+ewkvyDTV24DHw8UgbhqI
   j7zAbwcZh9QbZ1KTI0UkpYcRbZNCUsuRulFtvU6yRrW2pc8lf0f4yrdPo
   RrvPHy1P5FGBUz20icbR2Lmtb9UZ5SV7tDngxHXZsw/kcAfGonE4dK2Oz
   g==;
X-IronPort-AV: E=Sophos;i="5.97,219,1669046400"; 
   d="scan'208";a="220723916"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 11:08:58 +0800
IronPort-SDR: 0CCyZbmSmpnTA2xDZin4bFvNL/j4DY0+Vn+D43UcwDhjp1KHPP8hXyh0APcHpFFXsP7O/3EMu3
 IbnOaqK6+/JjNqC8GE47sumc1HLbRR1fqK8L/fyu3+TSByie81l0nDBlD1Y1LVBR8M7s+bjucU
 UO4Mytc5HqpiTMM8sE5lWUMUP3seHkpccbK/xl08mDRpdCtoKYOVikAr8ZHRWqsugBtCB/Bvjf
 xPijNeqjzWt3QrPSfrhzaay9TAo1ZX6cBgzjDhqIDcJ4+yiTgL3LQtXaVZ7I50YDFql5SqCTl4
 BEM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2023 18:26:41 -0800
IronPort-SDR: tiKi0SxJA277v/OkjNc1eUj50HoNfhRHY1HZPA6QVKpcOgGje4dZJZ4qjPONyqLHS3WHl8CYN6
 x0mj87e+/vmFpv7XoxT0Wc51N2XoCfmWNV4am6Ye8cWUdWsiUl/gWzhwsmnfW+5VLeg5awGiGF
 pAE/YUzwrv48BOpmzg+RhPEZNrpjoM8u/tA0ufjMU5v77eSI1TEedSuQ1MQZXxqsBQ8p8/QHzw
 rsut1YdejHah04824bERCYIJFhpnO5eiruPIvU/wErr/VK7A7YQKIHN30W6IpWbF21g+b5D8xA
 ryQ=
WDCIronportException: Internal
Received: from thd002594.ad.shared (HELO naota-xeon.wdc.com) ([10.225.54.84])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2023 19:08:58 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs-progs: mkfs: check blkid version
Date:   Mon, 16 Jan 2023 12:08:53 +0900
Message-Id: <20230116030853.3606361-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.0
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

Prior to libblkid-2.38, it fails to detect zoned mode's superblock location
and cause "blkid" to fail to detect btrfs properly. This patch suggets to
upgrade libblkid if it detects <libblkid-2.38.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index df091b16760c..e0cb6a8c2bff 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -28,6 +28,7 @@
 #include <string.h>
 #include <pthread.h>
 #include <uuid/uuid.h>
+#include <blkid/blkid.h>
 #include "kernel-lib/list.h"
 #include "kernel-lib/list_sort.h"
 #include "kernel-lib/rbtree.h"
@@ -1346,6 +1347,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		exit(1);
 	}
 	if (opt_zoned) {
+		const int blkid_version =  blkid_get_library_version(NULL, NULL);
+
 		if (source_dir_set) {
 			error("the option -r and zoned mode are incompatible");
 			exit(1);
@@ -1360,6 +1363,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			error("cannot enable RAID5/6 in zoned mode");
 			exit(1);
 		}
+
+		if (blkid_version < 2380)
+			warning("libblkid < 2.38 does not support zoned mode's superblock location, update recommended");
 	}
 
 	if (btrfs_check_nodesize(nodesize, sectorsize, &features))
-- 
2.39.0

