Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8423346BD10
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhLGOBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:01:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27922 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhLGOBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638885496; x=1670421496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZJfnpvuBgJmg79U/tuQ49iyfHI8SDQ+ZnmC6XujFSf0=;
  b=cHmIKOvL7ICUsGipGwMeSeFoXbzMdqk5SpVJiv0W9xm2HsRw0+16zzoU
   Un9O7sFN1BBnf5id58t6kfy55vyYVr3EFmlv8/ytefJARpUwLusONQdvK
   64I/ygRl5TMmv6ahDC/Qqpi/J39ce2AyA9sjgasMoMLaDXT8PMhvc1VfF
   XtecMkyPmLMMVPHQ6oVAkk6GFa/ghz9cBcBw+sng/Ba+DvHlWp8Y+CV63
   A9c30xtIPMEW0C6AxkVuLeF5pPHBPK8GL3yAoICblO7y+g8bA8UOrnHw5
   5VIAhwmH08GEgks5iQ81nTlwCj2Giz5xF7rutxAP8VmIf+ZMI6K8qL43E
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="192435472"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 21:58:16 +0800
IronPort-SDR: E/QOtj+hvVoC6vp+2C2HbXWcRkI2qEQGBxVPKd0VQeJn36vaFbe4Uy0Y/gym69mCm0hQA71Uoh
 YvxTnber7dZPBKfiTN2hIyAiOSWAYZMyXxACKKtSFyvXmyxjaylWirX1JZu2mym4jwZcnnSQsJ
 lIzS6rXC11OvYoA5J+5q67ykUvswNpEspnskSHl0aDLyuTZJj5ME068cnDaPkDwpuqj1m+mM80
 sL2F5egeuthAywGoNyru/wdO3xz4RmvVSFW13zWI4vxvHP47cHZWefxGHwBo8wdc18g304SgQl
 9M7p3g41/JAgNBxtUN1cAYSo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:32:54 -0800
IronPort-SDR: +HPf8NhWzqxMELO/Q3VsrJ1dA50Rix9ETfW8q9f2pzua6ZECIydfcErXGo3M3NWsPJpaCMw0EM
 TRchnsxIKdy59D6UyS3w+15LuPnbVWz2SadYWGVLbVth9r0PorgPyFwgFY79VhKDHgqYy5LcmD
 LWfTeyny4h1dTEl/f9tRqxNqCaN86ObMD/RJrH3P4su5nChlUImmLdNYWu03AJ+kt7+duDPeDF
 rNJhu5xH8vG44gQ2rp7rmoURV7ONaUKMXC6yKGyih4jllWH4rLnMseAcRd8ewOTKsphO1QrfSc
 /Iw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 05:58:19 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: free zone_cache when freeing zone_info
Date:   Tue,  7 Dec 2021 05:58:13 -0800
Message-Id: <f3ea96654bb7f39afb15555dece992f2a8479608.1638879879.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kmemleak was reporting the following memory leak on fstests btrfs/224 on my
zoned test setup:

 unreferenced object 0xffffc900001a9000 (size 4096):
   comm "mount", pid 1781, jiffies 4295339102 (age 5.740s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00  ................
     00 00 08 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000b0ef6261>] __vmalloc_node_range+0x240/0x3d0
     [<00000000aa06ac88>] vzalloc+0x3c/0x50
     [<000000001824c35c>] btrfs_get_dev_zone_info+0x426/0x7e0 [btrfs]
     [<0000000004ba8d9d>] btrfs_get_dev_zone_info_all_devices+0x52/0x80 [btrfs]
     [<0000000054bc27eb>] open_ctree+0x1022/0x1709 [btrfs]
     [<0000000074fe7dc0>] btrfs_mount_root.cold+0x13/0xe5 [btrfs]
     [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
     [<00000000ce480896>] vfs_get_tree+0x1b/0x80
     [<000000006423c6bd>] vfs_kern_mount.part.0+0x6c/0xa0
     [<000000003cf6fc28>] btrfs_mount+0x10d/0x380 [btrfs]
     [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
     [<00000000ce480896>] vfs_get_tree+0x1b/0x80
     [<00000000995da674>] path_mount+0x6b6/0xa10
     [<00000000a5b4b6ec>] __x64_sys_mount+0xde/0x110
     [<00000000fe985c23>] do_syscall_64+0x43/0x90
     [<00000000c6071ff4>] entry_SYSCALL_64_after_hwframe+0x44/0xae

The allocated object in question is the zone_cache.

Free it when freeing a btrfs_device's zone_info.

Also as the cleanup code in btrfs_get_dev_zone_info() utilizes the same
pattern btrfs_destroy_dev_zone_info() is using directly call
btrfs_destroy_dev_zone_info() instead of open-coding it.

Fixes: dea0e0d65459 ("btrfs: cache reported zone during mount")
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- call btrfs_destroy_dev_zone_info in btrfs_get_dev_zone_info's cleanup
  path
---
 fs/btrfs/zoned.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9cdef5e8f6b7..6a00f49a397c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -592,12 +592,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 out:
 	kfree(zones);
 out_free_zone_info:
-	bitmap_free(zone_info->active_zones);
-	bitmap_free(zone_info->empty_zones);
-	bitmap_free(zone_info->seq_zones);
-	vfree(zone_info->zone_cache);
-	kfree(zone_info);
-	device->zone_info = NULL;
+	btrfs_destroy_dev_zone_info(device);
 
 	return ret;
 }
@@ -612,6 +607,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
 	bitmap_free(zone_info->active_zones);
 	bitmap_free(zone_info->seq_zones);
 	bitmap_free(zone_info->empty_zones);
+	vfree(zone_info->zone_cache);
 	kfree(zone_info);
 	device->zone_info = NULL;
 }
-- 
2.31.1

