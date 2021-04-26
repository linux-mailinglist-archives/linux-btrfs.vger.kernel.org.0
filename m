Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20436AC20
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhDZG2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhDZG2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418490; x=1650954490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYj2D3vCfh0AB0IqIZFogs4QFkCRHDdkEehdh8qZFRY=;
  b=OSHlGW5yk+Fqvb6QOZOWVk1+vZoFj5neCPI4gPrMjtzLxNgva1+mkdf8
   S707buVErYo9xQT3rnRtlgwlOq343f0ppWKrz+PefMopWgWdTmpdO9IqZ
   8rF8fn7HR/DjbRbrqkHsb0zsqdP70qGZxRrSGOcYNZrYCqodmv48Xm7JT
   XARKe0Oeg/u2DS1yb7VRgIIqYGqCw+5j9MqF20O2doaVwJOZzJzJYw4E6
   t6Md4lAs3iyRHmuVu+kJxxUF+OhQX4u3zxdSib1UFUKE88pD7Tn65+HAo
   GKcfEUg+7lJXMqYFRKDugD9qYe8UOoMXsRQ0nleiRCWDn0EQX9Kz02gc8
   Q==;
IronPort-SDR: UCY5am4aABkWGfbO/5/a2vHa/rCakDG+LzWl4LS62z1zvHVFjMV8YU8sYf9uiHDsu61kElX3Qt
 eV3/23e0kNB5HkU9iYc1BPceLwOob6nP7CxUYPMSVyTtx7baV0Nl5Evd+6/eVoSIMh7NBnq/3L
 YTqyw1SS3Nj4VaHffwRkE5Iz1qYtKZWz4Sxsshg5G6hvr6NRbbUGIz464mwjCeY0uKb7r1jwtW
 22U4MEQrvHR/D4rS6xjuhhs0jOOuzEJ1qA/ayHW53a6sZZcO2INU2BCiMfNGZuingjzZAqVN6t
 1co=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788101"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:10 +0800
IronPort-SDR: unOKvWF4hO7O7/sL6AZkaIfHwwpD48tas0PB9r2wnqKmdoUdJzw5m9IIj6kgLLUknk7/TiNxxr
 OEOP8GYBzI1MuwSVKiN2vblDrhqaAKI8tmWHF43VCVc9meEAVFHykdoM3DRl72SdE5vxqPJsTA
 t+TMlrHySa80yp2yLLmEcjLkH+vIcEEbxdk3Gon3dZ6mU8Ut+1fGqao7I3JUFEBXQGLjjqcKql
 +0nDhgzuuDOeMvO2XN14nYYvCap9zhJEr3gLsxsHEKchAwe6bxRgv56cMm/17gTZ7JZVxjpePR
 OBWKC+mYdNNd8o4ACSH2CNzy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:34 -0700
IronPort-SDR: UuU41OTQYUQ0zsC/kZF0hIqa19D7j/bt2cnwZut3CNRGEppJuptA26iQFcP7JIdaz4vOOpmpbi
 F7EKNUJpjZaKXLRxLR32KQNi7cKPcZOHasZvy9YSJY3m/IVjAw1bx/yhyquinFdhuFZ3fAGkzO
 8c7tzGgRDMtvEglZfauiPgH3ZwyQQQxE3lw/7dgRGtsq7JfYfdSVolhpNKFDDycmlpJRk1xWnH
 yCs3eZdlHl/QBpUEiRvjLE4z8LP/OyRZIJtOM0rHNi039FAT7wWqCZsC8Ms0DeEdh44j5Cwf71
 VmA=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 01/26] btrfs-progs: utils: Introduce queue_param helper function
Date:   Mon, 26 Apr 2021 15:27:17 +0900
Message-Id: <bb41cec6cf9449b3899cf9fe816ae4a7d5820a0c.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce the queue_param helper function to get a device request queue
parameter. This helper will be used later to query information of a zoned
device.

Furthermore, rewrite is_ssd() using the helper function.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
[Naohiro] fixed error return value
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 common/device-utils.h |  1 +
 mkfs/main.c           | 40 ++-----------------------------------
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index c860b94661c4..f5d5277e8fce 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -252,3 +252,49 @@ u64 get_partition_size(const char *dev)
 	return result;
 }
 
+/*
+ * Get a device request queue parameter.
+ */
+int queue_param(const char *file, const char *param, char *buf, size_t len)
+{
+	blkid_probe probe;
+	char wholedisk[PATH_MAX];
+	char sysfs_path[PATH_MAX];
+	dev_t devno;
+	int fd;
+	int ret;
+
+	probe = blkid_new_probe_from_filename(file);
+	if (!probe)
+		return 0;
+
+	/* Device number of this disk (possibly a partition) */
+	devno = blkid_probe_get_devno(probe);
+	if (!devno) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	/* Get whole disk name (not full path) for this devno */
+	ret = blkid_devno_to_wholedisk(devno,
+			wholedisk, sizeof(wholedisk), NULL);
+	if (ret) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/%s",
+		 wholedisk, param);
+
+	blkid_free_probe(probe);
+
+	fd = open(sysfs_path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, buf, len);
+	close(fd);
+
+	return len;
+}
+
diff --git a/common/device-utils.h b/common/device-utils.h
index 70d19cae3e50..d1799323d002 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -29,5 +29,6 @@ u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
+int queue_param(const char *file, const char *param, char *buf, size_t len);
 
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index c910369cbf94..a903896289fa 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -434,49 +434,13 @@ static int zero_output_file(int out_fd, u64 size)
 
 static int is_ssd(const char *file)
 {
-	blkid_probe probe;
-	char wholedisk[PATH_MAX];
-	char sysfs_path[PATH_MAX];
-	dev_t devno;
-	int fd;
 	char rotational;
 	int ret;
 
-	probe = blkid_new_probe_from_filename(file);
-	if (!probe)
+	ret = queue_param(file, "rotational", &rotational, 1);
+	if (ret < 1)
 		return 0;
 
-	/* Device number of this disk (possibly a partition) */
-	devno = blkid_probe_get_devno(probe);
-	if (!devno) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	/* Get whole disk name (not full path) for this devno */
-	ret = blkid_devno_to_wholedisk(devno,
-			wholedisk, sizeof(wholedisk), NULL);
-	if (ret) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/rotational",
-		 wholedisk);
-
-	blkid_free_probe(probe);
-
-	fd = open(sysfs_path, O_RDONLY);
-	if (fd < 0) {
-		return 0;
-	}
-
-	if (read(fd, &rotational, 1) < 1) {
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
 	return rotational == '0';
 }
 
-- 
2.31.1

