Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3FB3B9FE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhGBLl2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 07:41:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51357 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhGBLl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 07:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625225938; x=1656761938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o78p1XOIX+/3q0F9kjPuxflMscusVtTuPdCXTedSEjs=;
  b=dMHSrhr+ZI879iQzHHwEFPe2MaGpe2u4Yp+Q9id4Uhtpi1QaPPiJx4Bp
   CU8gXSN5qa0WHgfqkeYeoy+JpoacH50CvqhWlx5zqZ1XSb4nXW6piMG2A
   mdthTHWRooEF6s3EwOiGBG3J8EQzZ5BGW0fJgErlRDJG8dIRahKNqwY/6
   IZTzGEvr+JUjG3npAO8DxwVZyAxZH6Zv8eYCUlmigBAb1QC+fyCFmrhEc
   Lg+7Hmqi51ENSyL0egtWbJEc99Q0G5lsLiRjfZ2jgbFpAfZXEceryGBkg
   L6zCrZx585FY9rFVDY9WzatPVoq4/SRatF6k2Qs9k8e0kNaiymw94k877
   Q==;
IronPort-SDR: WhiEY35xYnxQh4yBS8uMhou7elnpwQkeEpdAEf97LQih9ihptKiLDFrs1xwVb9TIWWM2iEqr+k
 PRRmCkEFwWHlx43SicI25zgnUwG+bLiOax73yb9YlrV8XwMyKorct5CzFSSFhLqzpNW0g6PFv5
 otci/9i/tlMnnJnvc2MZ9fYIrWZbvG7KsTkt5iwI1MxuWXQhWweiMQXXyo+NrG7gxqQo50qBYg
 iphz6MJauIStMF1tRKfmjCiLyCf6Jt1d3lOnBOkfYSzyHOiVjH3n1mURw74Woq8dav/FeAX6TG
 16M=
X-IronPort-AV: E=Sophos;i="5.83,317,1616428800"; 
   d="scan'208";a="277353413"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2021 19:38:58 +0800
IronPort-SDR: pwm1fRn511/T6lOF0/6/lwBzdFuQMD9bX1mlXPGtSzdHQx0MJhN6fRdXSluLSM7mnkQhQW3x1f
 URdcLu10EH2/xDdE+vNkSLIrxVM5uIAP3Sp5yF5tqXKH0/rEbju2+k+JfRl58r7gCw1SbefXhv
 Ma4aDp2zzCwasjfkMLSH2znRXEn4zN7U0duTtFXgVfk+FPCqwQDoIXFQE5MuSObO1UpmXriShO
 99MUNWUN1xuzpYWYyd0L+0nwoVq+F53TfgUqwZkrb3+GJFCYGrDTkzWq4gkbRmrHYySvDO86wq
 Zi/QqoPvclY9b3RHES+db/6R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 04:17:18 -0700
IronPort-SDR: WRrxHafpLQYdR3iAnB7J+L3gQtmADbSv3oLDVWcRRRMoGejLUaBs6a590YBUV7d0rKlBSzyYKN
 r36kdd8KPQXHuPV0kOmElagVObw7mUqHSdVVeks28qtVZN0ulPlbNwSytNLKmkRTVRaolvVtsI
 MSIMgn8NJ8Tq5yC9s8QDA6ULAmnQSvQq4uHV2nTzfGVYxDcn6QEZRNZRxkKJglkVYCUk+b5iGU
 wMT9hPNZdShUUkA6QdQneDO1HXJOXsJT0cYGZfDXyXQ61924fq5fSFqz56xma0aNAlRe1Uv4g0
 8lo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jul 2021 04:38:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3] btrfs: zoned: revert "btrfs: zoned: fail mount if the device does not support zone append"
Date:   Fri,  2 Jul 2021 20:38:51 +0900
Message-Id: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
is merged in master, the device-mapper code can fully emulate zone append.
So there's no need for this check anymore.

This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
does not support zone append").

Cc: Naohiro  Aota <naohiro.aota@wdc.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

