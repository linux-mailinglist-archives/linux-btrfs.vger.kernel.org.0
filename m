Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E366198EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 15:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiKDONX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKDONE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 10:13:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F342FFF7
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667571169; x=1699107169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FbATCyrBK3tJi2lp36pyC4nwgf0+foikA7m0886DZy0=;
  b=JvulheivRxYe6IVsoP3Vz3I57snqr1+AuqkCGe87SzbyDn5S6AjDITcO
   XG978mHXEEnjtKgH2Egvzc5khMhYr/cL1yfOR4fpCqwCjTCvgEyHmS17B
   L6KhN7VnMgFlqfd0gNM7Ys30ZlEel3wXk/EMYgcsRivTw+H7EH5v627gv
   ZEXsLCmKhho03nX9Pw+If6slA4E6yh8XwcH4/Zf+jc5dazRzJsWjaB2ml
   iEnEifVKZ+1og/0OJg9jA6mXayxpJ0+ZuRgvXWsd2jqrs1qnAqHCs1SrZ
   MeCPk3RvfPWGUIW8UCsApTTLlKY93CIvr3LOL5xjbWNrM+z7lzCuwd0uy
   A==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="327603638"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 22:12:43 +0800
IronPort-SDR: YJshiA7Cbemq3tCqgJezd+PKHNKcsG/K/ijJY/9+abi2v63ysqoThM3GA6JXvb7V9Rqp0xo8R8
 f2rKLxSFbesl3oeEVlS0Ym8t/XbOEuiWOp6bJHUu4gUFX6mXstaGaP9G1CiM1R/KUWOhZ+zBy4
 MN/gCuPhwQ/VzHI0Cyq4XiQ8AoEoYbZTDfMTjOS+/U2pTQbsYckzkXCAsI7BaqZAdO7vTNjJaw
 myYHKwcdEZLpLVRi8QGBvi5s6M1NKDbiL6sDGzp0FVZ73QN+jEkKoWyGWvZwGNG+rDNBXKQ+AA
 r9o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 06:31:55 -0700
IronPort-SDR: 8fA2DY226u1Ftd86T4dudGTDdOSAa3wChH7e1A1rL+LSJXn3yMr/1mntUyL2dnvgZh3mqivyIm
 fR62T7frQycLIq+1KV+EV1fr2ttP2UvIRLCaFtxpsYdARE/KjhSEMb1LaavtdSAhet6xk7c4/F
 QailqYOLKOjXgjq6PSSTC69oj+An2GUNuLfBCGPhuLzK+dvHpvrgXivIUplrNzaHZ9ydx9MKZr
 9nrYLqbYVQ5SvMERu1pFmQdmYJEPLDL32S2m/AbPMwRBIskFwgUUA7XkRHFt1mymzaHYOWh0CG
 cV8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2022 07:12:44 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 2/3] btrfs: zoned: init device's zone info for seeding
Date:   Fri,  4 Nov 2022 07:12:34 -0700
Message-Id: <d0c5aa0c8beb408fe769029e7bb5ad6081f19715.1667571005.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667571005.git.johannes.thumshirn@wdc.com>
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
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

When performing seeding on a zoned filesystem it is necessary to
initialize each zoned device's btrfs_zoned_device_info structure,
otherwise mounting the filesystem will cause a nullptr dereference.

This was uncovered by fstests' testcase btrfs/163.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  4 +++-
 fs/btrfs/volumes.c | 11 +++++++++--
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c099d046170..f5f793af12a0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2564,7 +2564,9 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->dev_root = root;
 	}
 	/* Initialize fs_info for all devices in any case */
-	btrfs_init_devices_late(fs_info);
+	ret = btrfs_init_devices_late(fs_info);
+	if (ret)
+		goto out;
 
 	/*
 	 * This tree can share blocks with some other fs tree during relocation
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f72ce52c67ce..2ee4050bf6c3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7769,10 +7769,11 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
+int btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	struct btrfs_device *device;
+	int ret = 0;
 
 	fs_devices->fs_info = fs_info;
 
@@ -7781,12 +7782,18 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 		device->fs_info = fs_info;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
-		list_for_each_entry(device, &seed_devs->devices, dev_list)
+		list_for_each_entry(device, &seed_devs->devices, dev_list) {
 			device->fs_info = fs_info;
+			ret = btrfs_get_dev_zone_info(device, false);
+			if (ret)
+				break;
+		}
 
 		seed_devs->fs_info = fs_info;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
+
+	return ret;
 }
 
 static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6c7b5cf2de79..b05124e62412 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -681,7 +681,7 @@ int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
 int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 			struct btrfs_ioctl_get_dev_stats *stats);
-void btrfs_init_devices_late(struct btrfs_fs_info *fs_info);
+int btrfs_init_devices_late(struct btrfs_fs_info *fs_info);
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info);
 int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
-- 
2.37.3

