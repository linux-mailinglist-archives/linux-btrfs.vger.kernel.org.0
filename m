Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB536AC21
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhDZG2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:28:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhDZG2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418491; x=1650954491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qR+05otdO4j1VtWAkrYMlCkmh0VIFngmakMgf6s/9uA=;
  b=SIi/arNtwlrlmwfi2ftjReJJOJwHMIclmYjRDR+LFyYzRj90ewSRnwpj
   tINLpkYzTnJ+QPWCPONPjsAYOCjvYkuPvqUSwckPp5m2ZDXbVvhgN2C73
   xjdFDJqIjrZqVUEydvIPeMCaDssGNa+kApEsKuDOmhAIAzbqmlV3IZfb2
   rpJRGSAtWuOaYcIpqWY7mitFpVtgwaNnbzYebghxhBaE94o0D+8Lcjk0+
   KfGq1twfH8iH/MIHykjfeAdMBRumird7a6ZyjG0B9FUAb6y3a3dyCnnRP
   DWYM8mX9r4rTW2fFUzqsgR1JBWb7KvibXua/vQoaJLv0kFlZexmX+Bezx
   w==;
IronPort-SDR: Cyqq+6t6aYikqkPtApnR+oGfgnBYlE0RHodbXF8y7VzUuB7UcuRD9rUtpqO8VDn7sPv8eN3dK/
 zBpFIZXKqOQF4LpJSx3Kb12u0nW3Oq273s8s2CLk+/vX+WkXW7nXyqI/EPTDO554ZpRzgpiwyM
 twst4J0zQWS/EFceIKG1JvOYCBCFXtJiaU6lbh7iQyx2XuI7LRW/DS30S66OpM0SR3VTfw7wNw
 CfguO9v49tjdZ/qV2o+66YqVSKhv46I7gPr7G+PKi87Pd88LpYeBeA4LV7X+9rjGN6Y/SoCaBU
 Rdo=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788105"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:10 +0800
IronPort-SDR: osZP+ye4j9Kc9iFjkv2fllQec72dbFWRVLfDRlxrccHFa8W08qcFmSaOjapXP+9QLWYe9F9iXl
 JYXC+IdShNMSO9xKlf3YizUx27l1Du3VP3speYJU43KHfP9dHwAOxREmoj8N6DLejNaHTKMMsD
 ydE7go5Z5ga9BcHfGs51+7hx8w61zmhpDH2VpNyAZJCSHVj/bA2B9fBR/upW8sV52NTXNZEC4e
 a9mq2Q9TsReGaiUblbNyASHqhKFpS3wdkmVQ0QLXHr1UIzzCo6Lyd9m6DvTB02AVO+03e9di43
 RVyW+H9mOxIJrwc02xVFF1Ec
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:35 -0700
IronPort-SDR: JtwrsZgxbifRM4P9g10HcxlaTYnyGzxnz/6JbJXjkVfLs1ROW8DvCM3fA3n1REOpLhuA30A1dB
 03xcYrlSH2RNjbfCvXp7Xmnjs+m+Z8hUp9yW+qVu1US8xqV1a4fwP5zKPvFpiilTNovcp2DQDJ
 ZSDO1fuex6Y35gsNtWJ/qUz8X7Ud2YfwIOSpoH8NueFvbkl3j224cuSdFht5CG7KytI6lB/kMX
 YMLlaTci5nzxmDzOBujDsV9Q30aL8goVSFkin3DaNuzyfdQqhpiKkO8zpkRa7bc9VVbdljtF/o
 wkI=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/26] btrfs-progs: provide fs_info from btrfs_device
Date:   Mon, 26 Apr 2021 15:27:18 +0900
Message-Id: <6bc8f7eb4dee9cc47219fd0930c892b6683c3b14.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Likewise in the kernel code, provide fs_info access from struct
btrfs_device. This will help to unify the code between the kernel and the
userland.

Since fs_info can be NULL at the time of btrfs_add_to_fsid(), let's use
btrfs_open_devices() to set fs_info to the devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/rescue-chunk-recover.c | 2 +-
 common/device-scan.c        | 1 +
 kernel-shared/disk-io.c     | 2 +-
 kernel-shared/volumes.c     | 8 ++++++--
 kernel-shared/volumes.h     | 5 +++--
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 5f21672b9d3e..216a6226b0f7 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1446,7 +1446,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 	fs_info->is_chunk_recover = 1;
 
 	fs_info->fs_devices = rc->fs_devices;
-	ret = btrfs_open_devices(fs_info->fs_devices, O_RDWR);
+	ret = btrfs_open_devices(fs_info, fs_info->fs_devices, O_RDWR);
 	if (ret)
 		goto out;
 
diff --git a/common/device-scan.c b/common/device-scan.c
index cd4c12821078..01d2e0656583 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -141,6 +141,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	dev_item = &disk_super->dev_item;
 
 	uuid_generate(device->uuid);
+	device->fs_info = fs_info;
 	device->devid = 0;
 	device->type = 0;
 	device->io_width = io_width;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 5555a406321b..a78be1e7a692 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1271,7 +1271,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 	if (flags & OPEN_CTREE_EXCLUSIVE)
 		oflags |= O_EXCL;
 
-	ret = btrfs_open_devices(fs_devices, oflags);
+	ret = btrfs_open_devices(fs_info, fs_devices, oflags);
 	if (ret)
 		goto out;
 
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index f7dd879398d4..cbcf7bfa371d 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -389,13 +389,17 @@ void btrfs_close_all_devices(void)
 	}
 }
 
-int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
+int btrfs_open_devices(struct btrfs_fs_info *fs_info,
+		       struct btrfs_fs_devices *fs_devices, int flags)
 {
 	int fd;
 	struct btrfs_device *device;
 	int ret;
 
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->fs_info)
+			device->fs_info = fs_info;
+
 		if (!device->name) {
 			printk("no name for device %llu, skip it now\n", device->devid);
 			continue;
@@ -2106,7 +2110,7 @@ static int open_seed_devices(struct btrfs_fs_info *fs_info, u8 *fsid)
 		memcpy(fs_devices->fsid, fsid, BTRFS_FSID_SIZE);
 	}
 
-	ret = btrfs_open_devices(fs_devices, O_RDONLY);
+	ret = btrfs_open_devices(fs_info, fs_devices, O_RDONLY);
 	if (ret)
 		goto out;
 
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index e1d7918dd30b..faaa285dbf11 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -28,6 +28,7 @@ struct btrfs_device {
 	struct list_head dev_list;
 	struct btrfs_root *dev_root;
 	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_fs_info *fs_info;
 
 	u64 total_ios;
 
@@ -282,8 +283,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      u64 *num_bytes, u64 type);
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *fs_info, u64 *start, u64 num_bytes);
-int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
-		       int flags);
+int btrfs_open_devices(struct btrfs_fs_info *fs_info,
+		       struct btrfs_fs_devices *fs_devices, int flags);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_close_all_devices(void);
 int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
-- 
2.31.1

