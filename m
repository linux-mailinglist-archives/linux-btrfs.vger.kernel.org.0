Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590E4D868B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 15:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiCNOSE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbiCNOSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 10:18:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D419C1C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647267411; x=1678803411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wkONxQ9Pv71JTCigchV2IHgLlXFbgJKX9v2aJdaHaTk=;
  b=Wm9nFfppXZy8OYBmYiXpNye51LnVVCkvsE0i7k3zn431njid93H6drNC
   2ISqxvr3kgYmoerIhAPldxpmU8o6B1OthWqSEHQuHwLYeimMgzqq+TQd9
   PngkZvh+lqAklDpkl6sHayK5DLT17/Qvtv+PNjDMbTyyphzxecExTcNk6
   f++7O+TXI9LiTm2nsDoGFpQoTKmUlXn0yqx2B/bcbzLdvUeuK5ze5KQGF
   +c55l5DXpCHvwFBdc9VVyB1ADlGiIUmN9cmFPAMw0z6G9m+UB/pG+I3Vu
   IZvnpcAtugCRyzoyjWB3HBf0J50oFNSULlTzXBdzEGN7SZ4RJv08EovSu
   g==;
X-IronPort-AV: E=Sophos;i="5.90,181,1643644800"; 
   d="scan'208";a="195313308"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 22:16:50 +0800
IronPort-SDR: RE3nNfySG0al1x/hs7q2IWK8no4TRbe3jSUn3X3y/7cahrEU90BceS+2eB4jNIerYWF1gxlWFN
 /KKfLPKTlNuSQF6mh2YED2P7NZY0ihUn/H7tzlWZdvRmcZNYElF+ueHb18N/kS6J/WzuKzRqro
 GECcBN3ZXA2oFZo6AIGEAEx1psg/Y517MMrGSpkDyFVFXWGSyzdbPHqgDEpCC5zHdLgiWNKAAZ
 KKJ2kkhK0M2dPoIJnVd5yokRvQ73v0S0LyMTQ5YudV+BDbqxVO+yJTCCTHZzhV02nsIKjU8KkO
 LbpfMq81KysHI0M4EP8jud9c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 06:49:00 -0700
IronPort-SDR: qpkO6gJFBilomD2WJo49fIHyBs75/IHM9fkERPobMeqyI0KBIhODK+GPaTftkrcN47MDV8yc4w
 aOG/UyzuBHojMaCmjMP5uD6u4b0Ss0tvcRohw9i0K2FumQ8mmFjJyCUQCSlN377k/dD6G+XYxx
 3pcr45M9PNTrOEn7R9uAcrpwOazWG66WDSZljF8WrzzeffL7lVeqg36jy/9+csUPv/IcVgag+G
 Emoo+jkaoQH1RlSTR+61mAqDY5eJ0t+AWRyzSp/lUVMhKws2QP0FdVQaw0FaDYlyXgWb5jDkRB
 RI4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2022 07:16:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked device_list
Date:   Mon, 14 Mar 2022 07:16:47 -0700
Message-Id: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
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

Anand pointed out, that instead of using the rcu locked version of
fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
the chunk_mutex to traverse the list of active deviices in
btrfs_can_activate_zone().

Suggested-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 49446bb5a5d1..7da630ff5708 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1975,15 +1975,16 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 {
+	struct btrfs_fs_info *fs_info = fs_devices->fs_info;
 	struct btrfs_device *device;
 	bool ret = false;
 
-	if (!btrfs_is_zoned(fs_devices->fs_info))
+	if (!btrfs_is_zoned(fs_info))
 		return true;
 
 	/* Check if there is a device with active zones left */
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
+	mutex_lock(&fs_info->chunk_mutex);
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_list) {
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 
 		if (!device->bdev)
@@ -1995,7 +1996,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 			break;
 		}
 	}
-	rcu_read_unlock();
+	mutex_unlock(&fs_info->chunk_mutex);
 
 	return ret;
 }
-- 
2.35.1

