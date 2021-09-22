Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEE4142EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhIVHzU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 03:55:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhIVHzU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 03:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632297230; x=1663833230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiKJpGwl5tEO1GdcALlNNYNHHQigIGjUs8ahYMTJGP0=;
  b=pVPl76AK0jxd5KTz43F4nuuyGQRE+l7FAKIqN3wbHjiM2vn9JvnsJtif
   hXPgFYV0CpFd7CSyzOSLL58hfMqmcWmELEQWhZGUfkmzG+XEz/9jtKe89
   0+Il7p5hc0j+pDktupb3sWPYQcLBHLrx/AQZ4d7b1Y1ugm4IIhb9EXFIg
   ji96D9ntCIwKr7vMEArPojRGzPDyLCl17bAutsLSdpYPkrfGnR/xfC33x
   z3C13DEFWfM/rxGizlILofzBa11fEewZMED21TG+j8YIBJaCuF/dEISRq
   d41x4NQcOUSP1BXgjj17mkbc1UwZODj8sdz746+91o0/CcOU3qI9GxK8k
   w==;
X-IronPort-AV: E=Sophos;i="5.85,313,1624291200"; 
   d="scan'208";a="284429250"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2021 15:53:50 +0800
IronPort-SDR: 3c/hdGHMOdrQLs6gpHr1fMPFjTh2GrvysbZxb91LU/0ObQVn2oAuXYyjNE+p2jvBESKFOwtuRV
 nF2xvmp13YDsRyUuZUIbV0P66hfd44a1jEUef0BPFaLj2y5F0srgk8LoCOIGRLhSitMVDhV5sw
 CDgA6cjj+DQ/WAFKmd0UMMdv/rClNtRuzSz3kFAbwy6J5DlFqF4j5Ui8I4O8dYzRHpDoEhTofy
 xB0OZIxifj7Ya0qqzhAzV0KgywWZacopLk9RT8z32qUYAcHZnquvrqXQc7exmMIOZHdsymwstJ
 /1ReSYQ4TaS81ksW4KCGBSQi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 00:30:03 -0700
IronPort-SDR: x189Hsji2DcnU0ad0K1HySvwu3lRu0lfEXoezTlO+ad5wMc2s5DTpW6EwAWNgxEmLnykz6p4ET
 ZmV4/jHaDjNlJ++u3eFUdcE/cGuLF5GkQFIaiwW3zhcy8A7ebyz4zwBLW5M+iwbHDWDNaZENMh
 JkCHOVUxOiaLgZ3npOqlvY2XBHaCJ7fwZUioLRBQzTGAw372iV7bAACM7/PjrPy4ZdMKTgZk4G
 JbHEFbBMQNlpePhhE635/aXzlSc5tMGeiW/dlkh/mrHxaHJKHPPwG7ALluaMTmek1IQ4i2T79W
 tK8=
WDCIronportException: Internal
Received: from wdmnc1780.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.67])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2021 00:53:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs-progs: do not zone reset on emulated zoned mode
Date:   Wed, 22 Sep 2021 16:53:43 +0900
Message-Id: <20210922075343.1160788-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075343.1160788-1-naohiro.aota@wdc.com>
References: <20210922075343.1160788-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We cannot zone reset a regular file with emulated zones. So, mkfs.btrfs on
such a file cause a following error.

ERROR: zoned: failed to reset device '/home/naota/tmp/btrfs.img' zones: Inappropriate ioctl for device

Intorduce btrfs_zoned_device_info->emulated to distinguish the zones are
emulated or not. And, use it to decide it needs zone reset or not.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 27 +++++++++++++++------------
 kernel-shared/zoned.c |  2 ++
 kernel-shared/zoned.h |  1 +
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 1c853545c6ad..503705c43754 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -220,18 +220,21 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 			      file);
 			return 1;
 		}
-		if (opflags & PREP_DEVICE_VERBOSE)
-			printf("Resetting device zones %s (%u zones) ...\n",
-			       file, zinfo->nr_zones);
-		/*
-		 * We cannot ignore zone reset errors for a zoned block
-		 * device as this could result in the inability to write to
-		 * non-empty sequential zones of the device.
-		 */
-		if (btrfs_reset_all_zones(fd, zinfo)) {
-			error("zoned: failed to reset device '%s' zones: %m",
-			      file);
-			goto err;
+
+		if (!zinfo->emulated) {
+			if (opflags & PREP_DEVICE_VERBOSE)
+				printf("Resetting device zones %s (%u zones) ...\n",
+				       file, zinfo->nr_zones);
+			/*
+			 * We cannot ignore zone reset errors for a zoned block
+			 * device as this could result in the inability to write
+			 * to non-empty sequential zones of the device.
+			 */
+			if (btrfs_reset_all_zones(fd, zinfo)) {
+				error("zoned: failed to reset device '%s' zones: %m",
+				      file);
+				goto err;
+			}
 		}
 	} else if (opflags & PREP_DEVICE_DISCARD) {
 		/*
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 891a2c0aeef2..6e46354b8b52 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -346,6 +346,7 @@ static int report_zones(int fd, const char *file,
 				error("zoned: ioctl BLKREPORTZONE failed (%m)");
 				exit(1);
 			}
+			zinfo->emulated = false;
 		} else {
 			ret = emulate_report_zones(file, fd,
 						   sector << SECTOR_SHIFT,
@@ -354,6 +355,7 @@ static int report_zones(int fd, const char *file,
 				error("zoned: failed to emulate BLKREPORTZONE");
 				exit(1);
 			}
+			zinfo->emulated = true;
 		}
 
 		if (!rep->nr_zones)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 99f8e9a2faac..66cf081b84c3 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -54,6 +54,7 @@ struct btrfs_zoned_device_info {
 	u64		        max_zone_append_size;
 	u32			nr_zones;
 	struct blk_zone		*zones;
+	bool			emulated;
 };
 
 enum btrfs_zoned_model zoned_model(const char *file);
-- 
2.33.0

