Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3676C3B8EAE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhGAIQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 04:16:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46492 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 04:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625127230; x=1656663230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nheEpikuI6AW7mpJjmXE5S9kwlYADfBw8YLn0B9M+AA=;
  b=e+ZE6Eq8ihp+dJcEbyins34VYBtdLwPhHNdc7i/KqGICYw6ikFqVyNj5
   na5786bhjGtT/qa8z5LXVPyAP/t7fZLCsy4HkKTSodu9utilNnC2gtbQa
   Njqt393cA7xvwl289AHKHf23R9Do3ECUXSBpo73UWlpeCcrtEtCTSQVdq
   MR1v1CVu+tS8le31oiCCLD91wDBV9skEMyCnfbc48SXAMCud/Ptn7PgnS
   +SPALCzRwT8hElXJBCClmy8P37SV2ssMy2fNi/yHVymyelONQhwD7qxAt
   ID6KXE5KdpndFq3YPfccKXiLFrPe/Dobx3L5oO+ABg+jYo+t7DWolP2z7
   g==;
IronPort-SDR: VBJKDBsgo+B93kk/mUKZNDRmzf+2jSuAVynbNMnQM1j8duvK57tr6gzcJczgR2REkbXkSUOw9N
 noMMRzxYbVwI2Ppas1n+ukZl0EV0/1KRqsKOa+kLaPCBUJQ0kywMbNBT609bjtAQuXXUytU0V2
 vs+EOQ3rvW3sItXR1CoCj2c6MOw67BhBxFNKJSbEKQg0FAeqSWOagElq71wsVVchzX5XlZcnqS
 z64SAETgMs88AzM1Y2YlOxUhZRCZbksl+Z+P4qgDByv3/im1wVG3yiZAShmFCT03DlOmGf83QI
 nAo=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="277217392"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 16:13:49 +0800
IronPort-SDR: 4BUWtZBfblXl6ny0+rWqXWuJciCrpSOonAZKcyqclYGQhlLD7zjqog0rJ8uK0IxE/wT/qglwnW
 cdGVzwQFZGJwUtxjRRWQKZd1I+tfF7T+ATZhYhoAbsyKOpQgUF4TcQp/3HIeuSTHVOPUC5CsTQ
 sWHvOF9my+wnaiq92WWQr3dSZCugpImnIYqM+xxmcSz/pD7mV6kDb23VJHSnmP8hKf0vyGRdzb
 wcKIxH5BW+EYniYZILaxYEjVgm3rUJUK8AWiamvhkrx+wQCHXKI6KWzq8W5IoV2VikN7uOfs31
 uQd6l9w4Fyx+whCUfoVJirvT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 00:52:12 -0700
IronPort-SDR: YcJSD7LSO2WkVpACt94Tc68Her44jnQMcS2JkcoKitZ/T8zIV0qGhy/+fauL1YXOmJ+ZtbvStb
 NQVwslUvD3CmmJHp0hA3fQQV6Je19wKnAjTW4YCqSyvrn/qqVPsp9TkP6DOwi8MMKbB+mI6sxa
 2cbTw5hn1sjdIqV51/ORf/fLRIPddtJGCKw5kJSCA1wCE1ja5dhCJtcIr1aCmq4UXYYNnId0rh
 ahFBncAB1IEn5LEdjRW4paKuL3JvLldSCr5kcTfHEtNhS0kNrQ0NWkEVOLYbT6eAm7UTDSJxdK
 Qig=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2021 01:13:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] Revert "btrfs: zoned: fail mount if the device does not support zone append"
Date:   Thu,  1 Jul 2021 17:13:37 +0900
Message-Id: <00c2351fa6070a149866df5e599e09c908e9cf26.1625127204.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the device-mapper code can fully emulate zone append there's  no
need for this check anymore.

This reverts commit 1d68128c107a0b8c0c9125cb05d4771ddc438369.

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

