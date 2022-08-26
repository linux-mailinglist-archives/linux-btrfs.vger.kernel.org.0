Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F365A1E81
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 04:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbiHZCEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 22:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbiHZCED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 22:04:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B0CACA0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 19:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661479442; x=1693015442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hPqnxjqaXpmZNx1ytP1Wh8mu7Jf6tY/Em29YnbuYlnc=;
  b=glDovG9KGnxDUp31BMfyhPiDvJFlFi/2RsAN2dCaBWcaDq013nDo38pb
   25DNwlVcBRFKcBVYQPfhykxCid1z8xFzF4kPavQBvpDsWkYdcXhb440nh
   bxeaGOTPFdyjB7gySA6We0fyNx+UB3vvHEIkmDkWEobw6CJZerpCuj3ZJ
   93qHT5k4dakucnmjdunpoRj6Gs2tYalpS1fh6SDNv55IubDsPphAZT1x0
   NbtnExhs4jArLOTa1HhPqOdgiShy6tWRBRjsbHRS9AxSTlllU+CJncdBb
   Uksp178xqh29wgiOAPumoBIoG8M6AlZGaf3eL1KiKFElYzm2rMGtSU+f0
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="313978772"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 10:04:01 +0800
IronPort-SDR: rq/oEN9PRYuRsU6LshZEbdhUKUO+vuOzxqskSOUrP4hdoyCfbMMddtq/km5AOkU0mc1iM3O6tM
 dBGtQu95J/T11rVG0RkXYUAk0aIgzBPusbvLXQP1xBQO3iNbz+Wuzk61PPgHj5nl3qQiKWJyXm
 VBQMNlD59lmYRGLpBmJHqTeYxqF6Hjh+nTp2gBxb+aQRTEMZL3SLo1WTaOA+YuF/JwtoEBQPIw
 HVTKjBPlpFCacYyCrm9XAlNZdvvO7aodsboCsR7XT2Vc6iie6C5Ptb1b05220Gt/N4EmTn6iWA
 MQMUVIzj5vBlAUK7BGhNceFk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 18:24:38 -0700
IronPort-SDR: dXVXk4ymU9H1VfNvyVAM1rhESCARwWhn0X5cgelx68HOLjYAj+yUcfwBz5DcqU/SqQ+NEQa5Cd
 FcjZ+RDEMWYO6GBcyDTqQgOCGkNSSl7h6RRrg2gyEqW6GjM87mugzqyGtHXnytb/6N1mXcBo1C
 jXrwkheyYu3yXeuR0yFH1iEjHcVkEk+PP4xFIpxh18/0TCkVZ6trHgC8qOK5dBnA+NVNSc8Aow
 tScQ6Cd8dN/WIF2OFzKo0jC1QICsIYwrGkqWrv8jUOX3vBnJ2xbbGA1H2BkUcrLslVow7wICcA
 tY0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2022 19:04:01 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: zoned: set pseudo max append zone limit in zone emulation mode
Date:   Fri, 26 Aug 2022 11:04:00 +0900
Message-Id: <20220826020400.144377-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
fs_info->max_extent_size") introduced a division by
fs_info->max_extent_size. This max_extent_size is initialized with max
zone append limit size of the device btrfs runs on. However, in zone
emulation mode, the device is not zoned then its zone append limit is
zero. This resulted in zero value of fs_info->max_extent_size and caused
zero division error.

Fix the error by setting non-zero pseudo value to max append zone limit
in zone emulation mode. Set the pseudo value based on max_segments as
suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
max_zone_append_bytes").

Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info->max_extent_size")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 fs/btrfs/zoned.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b150b07ba1a7..560dd0a67536 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -421,10 +421,19 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
 	 * increase the metadata reservation even if it increases the number of
 	 * extents, it is safe to stick with the limit.
+	 *
+	 * When zoned btrfs is in zone emulation mode, bdev is a non-zoned
+	 * device and does not have valid max zone append size. In this case,
+	 * use max_segments * PAGE_SIZE as the pseudo max_zone_append_size.
 	 */
-	zone_info->max_zone_append_size =
-		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
-		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
+	if (bdev_is_zoned(bdev)) {
+		zone_info->max_zone_append_size = min_t(u64,
+			(u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
+			(u64)bdev_max_segments(bdev) << PAGE_SHIFT);
+	} else {
+		zone_info->max_zone_append_size =
+			bdev_max_segments(bdev) << PAGE_SHIFT;
+	}
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
-- 
2.37.2

