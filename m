Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213BE4142EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhIVHzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 03:55:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhIVHzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 03:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632297229; x=1663833229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnzCEkEsSr0wReGEZPQDyGtL670wd61z70BeguuQ/qU=;
  b=dIFoCYHha9dCefyYpdlusAYUvuo5sQXKk6vx/igoaKeQvnKcbNC1Amtq
   D16BRoiQvMa/RQMVDELY+D53knRCrgkfs0DUV02oLiPmAfRWlHD/YIuyF
   ytRrYqWViqbwgbPWgBkdFgT00PSUQI5Be6PHxqDz2TieFhc/JQF73Dud/
   Pk7gjiPbp5ECdOJcxaAZyvPYNo7WsoUC8kti49yXQSSzFVI4N72btfKcB
   XgjGEf08x/5R0pCjbpa30MocEBI4Ww0p5l0TxjsQ+zq1KElo5NQIEytZg
   8cs+knuXuH2ixx3b5PbvOJhtISV7VNgehO+ATRhr/hp3wyNVmEQC7Ycg8
   w==;
X-IronPort-AV: E=Sophos;i="5.85,313,1624291200"; 
   d="scan'208";a="284429249"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2021 15:53:49 +0800
IronPort-SDR: XAf1VCD+N8k/V8bWU7rrkJqLNB4imtvRlY387MU0AcIFCJlH3V4Xt476lc3NUwMaRoTsHDeaan
 +5QneZDsGm6XbZpqO8ODNMKYiPs2ucAcCn2+xmy9xNdFZ1UgrzYW7XthNtVuHYTHOy9Kwv7A31
 5alvKwhE1p3Aw+BRKDqoQjGsR44XtcSMoX0xxVUassgLufhH7Krn3kRURM0ldEKWdBHTcnwp1Y
 MwW1UbFRZLWuy1vlCMmHG/z3O6+QV1/iBMnnuKhLAlURz+PH8jrshGSG5ewLBhNI00Flv3YfNj
 wJRavaIgJ4OCifDAIIwYSLST
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 00:30:02 -0700
IronPort-SDR: jMsrPtQOFJ5Dgm+zUQRM+5MrRuExRoj3yoXU336kDKy+fF/gklpoLv0ugaGVclDt4ypt2q/6qm
 jWccEBb/VeSfVYt52UzltEeLjjTfae5KQoUKHHtltakInW5zQdYQ8dJLLrmBZAROmic0MJ5W9U
 HiCoRHJyjVz/q7knS4smEMkGCjU4h7KzarcU+X0uiUIU+0B5hjcobdbz8MY+hEDPOmFgDxlhyJ
 cMecAHBJv4CSRxyGAAN84G4I8S5Ic2LyDw+EygNIsjOoURow5+93nHJqDnQuHURUXThblfTaxY
 1Rs=
WDCIronportException: Internal
Received: from wdmnc1780.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.67])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2021 00:53:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs-progs: use btrfs_device_size() instead of device_get_partition_size_fd()
Date:   Wed, 22 Sep 2021 16:53:42 +0900
Message-Id: <20210922075343.1160788-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075343.1160788-1-naohiro.aota@wdc.com>
References: <20210922075343.1160788-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

device_get_partition_size_fd() fails if we pass a regular file. This can
happen when trying to create an emualted zoned btrfs on a regular file.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 75c6c53393ac..891a2c0aeef2 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -267,6 +267,7 @@ static int report_zones(int fd, const char *file,
 	u64 zone_bytes = zone_size(file);
 	size_t rep_size;
 	u64 sector = 0;
+	struct stat st;
 	struct blk_zone_report *rep;
 	struct blk_zone *zone;
 	unsigned int i, n = 0;
@@ -291,11 +292,13 @@ static int report_zones(int fd, const char *file,
 		exit(1);
 	}
 
-	/*
-	 * No need to use btrfs_device_size() here, since it is ensured
-	 * that the file is block device.
-	 */
-	device_size = device_get_partition_size_fd(fd);
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		error("unable to stat %s: %m", file);
+		return -EIO;
+	}
+
+	device_size = btrfs_device_size(fd, &st);
 	if (device_size == 0) {
 		error("zoned: failed to read size of %s: %m", file);
 		exit(1);
-- 
2.33.0

