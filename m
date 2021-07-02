Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4BD3B9F18
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGBKbz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 06:31:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28495 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhGBKbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 06:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625221764; x=1656757764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a+t86cZnTnAfFT5OWC7YMRqkGbz3z7vT5zRkrPSCi3E=;
  b=TeywUR6EkG1PQwqcKrsSp1240WWEzZtOAay0kNkaxp3KbVAV7XYRI8LQ
   warcshm27M3RZevwkH09MfQTdLfbxRGYHYeTkH8feOa4HzGVsrQ6OuEnY
   xcK7bExyJy8AIuJiXh17LTuf6EMbNel2N2pKNTduac8wqZbIVTudpUDPi
   ghRGeWRd2rZXVWQZBevrnuBizyxEc5yL4wz6yFfg8OFuPp6+uq3JPNocs
   IyR4D2ZOXZe8Bc5bj5cpGNUd36sXkpHClpR47hvWn+l6LMjKOdAb6rPxO
   /AEa07QQkedvKDrCSov7VrXT7CUlOo/ZRek3/fpMkveyEVHtfw4RSRX8m
   Q==;
IronPort-SDR: lus6fU8lLg5QLZaNZUV5kmtCZrHNnNyeSfCoFx+0z8aNRbAR8deZqo9tZWAqkFhkOahvldaJTx
 74NExRmm1tVNEe5+FCBvFsgsK1QrZ8z8z6MInD16VXiRvkm3LL7oi4afOm6aoEMeqQd2mFMtKt
 PXjh//iMbNENT6+t+UKfCbvJx+W0KVzw9vOQVFRjH33SRPf7MN0Axkx3GFj/O3ziYRBabP5I6E
 /6WlNlaI1PBUVMq2nn5dcXCas8KRy4a/m/ft4A4zbbF7XraDQm9cWEHE7mnuRU7M6l2P7VFjH4
 VQ8=
X-IronPort-AV: E=Sophos;i="5.83,317,1616428800"; 
   d="scan'208";a="174132996"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2021 18:29:23 +0800
IronPort-SDR: u576MTt3DGllXEUBrlVUrH5aYnHXwvG0574WoNeKpKmVrPqI+ZcYJYdT6/s3Cg9SWDvPNT7L9S
 6+NA8IRKvPmsSUHgWkcJNNqTy8XMvkw/7xqqzYBCS1ldlRkC3F0bV+bxBXF/14k/6UPxcSAkvS
 0UTGZAM8UQdomA97LuinEhf7Fs4g8i9jjNkfxi0E7hJyYOc7qJXMvM4dZ+Ek5jmdhliTbyiycM
 gaB3rGRmHCLN158q0OLde21NwhtEbBZfNUIUduIe19sw8qHWduqlFo/7Pj8tPWO7O8kHPz5Ytw
 DEWjPP3rdoWlH1WihUibkMmW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:07:45 -0700
IronPort-SDR: 3BCMBuIaWwrFS2xH1xg22UBBwUJi1PAZCphZJ6Rsslr6H01wOfp5c+/mdnssNcjUMa3ZMFqtGL
 c6F8gVW7DSsvco21AmvCUwzDqp/c+Jyzq3b2Eba/ds1328lFHhT3g3uWwIljqhS9bJ68EfCV87
 sGPSxE1whb8jt1e60a0mboJGCdQL0uMCmKaUhocYFthvPTeT5To1u00xE9HD+QirvbfCbdywxH
 uTiOnI2EBuask1h+emiwG5mW53ZVPlakSRhjd+0JZaoQTQdasvhyS3pdp2e1EHvMm6dn8y/Wwp
 xQk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2021 03:29:22 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] btrfs: zoned: revert "btrfs: zoned: fail mount if the device does not support zone append"
Date:   Fri,  2 Jul 2021 19:29:16 +0900
Message-Id: <a6b7c5c38267fb410a4a4f711e986c863790ddf8.1625221720.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
is merged in master, the device-mapper code can fully emulate zone append
there's no need for this check anymore.

This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
does not support zone append").

Cc: Naohiro  Aota <naohiro.aota@wdc.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 297c0b1c0634..e4087a2364a2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -354,13 +354,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
-	if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {
-		btrfs_err(fs_info, "zoned: device %pg does not support zone append",
-			  bdev);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
 	if (!zone_info->seq_zones) {
 		ret = -ENOMEM;
-- 
2.31.1

