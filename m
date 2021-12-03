Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8674675F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380283AbhLCLP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 06:15:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21681 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbhLCLP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 06:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638529952; x=1670065952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GaxKpsgIAuloNxDaQ0qppdDDeVX8f30FGtFMyTW2w0Y=;
  b=YOQxcJleY9VC8iCYJFeavnfwjPWxPTFM/aCBWNzYd7Mh+WUvpFM81rAG
   nkQ5V4PCOX8Q/UTTIWXiR1hXXmR9JJRD29UdbwOPolPNVzW9LW5obVpJS
   EPIqn9T2WcUZUibdke9unvSUStDzAlSQSw6f39GPUzyUzHf0E6u1V/Olp
   KZmXWP7DxtUGx2SfSrB0XdeOywIPRQqsVwr9eV2NszLw0PDYnbzUMBdJy
   Vm0dYHCSAamv2UIc/RuW0Ko1Kuykyt6AyY+GURJRhggSoL2J4uZXReRd2
   U9gqiP2w0INdCGR3UJR44dHNS/VEsqp5nthpFyAI094xbFoSfHMdeBu2J
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,284,1631548800"; 
   d="scan'208";a="187379621"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2021 19:12:32 +0800
IronPort-SDR: tTVnZS00WkThF3aOp+RSyAsXqa4wSzBMg/8+2xO4y+FhdHN1Zmw8z+Zv2Qn0PY89oD1VeZRHTv
 iSsRqblV31IDo/JCvpQF5zKGiPt2COqpX/sNYwxekWFrF+6lpScc0km+ZiWSRiX9xOWprTsFwJ
 MCX8cQhfmKdSo/RlKq3kNGYVvJt82MibRzRI3a2T87CB2FPCPY+P0Vu3tfh9w1Bcg3IqDEsSiu
 vMXgIdtQCxCbaZs6G41wAq6P9tzlkKKtagVXpPN76g6XJSG+UHmiyDwsbAd4qHlesyUNna2ghv
 Of5eAYlc8CGqg8sqsRJPQYLF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:47:14 -0800
IronPort-SDR: w3rnP1SLT8W1iCTQps09aRiL47TIq7WVTPbVLg1Unk5d94f2Duwc+uXrWlkwwAOHtJ3zZz3a9E
 65/jW4gbnEvsRy9YV+0xODMz+4ctF8NmbFFOEqvycsCgQDVa+UHtjLQIGwTHV16BmKH/6j65b5
 H2cF7hPstViiK5YZ8NXBXuAwd8/qmOaNe/uTEKVTpCCWNiEmRGyYES0ZICTsbZClkEfkDXi5l2
 /3hmMoFJfDdRERDPwmSHqD0lqEBfrcctdK1iHffGrY5pZC4ilAEMnv4J/mknoD4+MofGs/k/93
 /b8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2021 03:12:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Date:   Fri,  3 Dec 2021 03:12:27 -0800
Message-Id: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
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

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c917867a4261..fc9c6ae7bc00 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -612,6 +612,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
 	bitmap_free(zone_info->active_zones);
 	bitmap_free(zone_info->seq_zones);
 	bitmap_free(zone_info->empty_zones);
+	vfree(zone_info->zone_cache);
 	kfree(zone_info);
 	device->zone_info = NULL;
 }
-- 
2.31.1

