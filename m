Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4593BC86A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGFJWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 05:22:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29360 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGFJWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 05:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625563172; x=1657099172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FKuWHygd+muCkA+l32/hR7rg6ZkV3O6KORAZIlwbtMI=;
  b=bDAhKlA9yhqxUr5W4xJKSV6fqNJm+pgauv1rpW9MDQYCZIbVJJ1lRZkU
   nl/L3n+qWrGH530wiLHA7aHs8Mk+Uw0wERZkSIn1fPLznKHfQUvJSZzB8
   KVnJL3Cvybt+3dhVlPhr5MTvzjbP20xXj3d+gppKWZ6PkIydouJHcwxHl
   cJIrxLow8UvcKUucKqLE2cPvx3XQxc9qUNraRSovweBYkm5CS/5JN/9o7
   G+Nm+kg21tto0unUwALuQUA5XYi+Q1eeaJv/qqTSylbVn4qiMVftJcF6Y
   gTqglSF8xFP8Fp0T/taZsyFHwj4juvjIzDruR9WMtxq/3rb7CyUMaRc7o
   g==;
IronPort-SDR: AmUIoVxfy7tQb4/I2dvd8JyCvSQ3OnbpMoVH9Q+InruXA2WRMVuU9ZUXutFHg+WJ8b5jEvGCZ0
 futoimist/Dcl1tgGDgh3vCkMSofxh2mO6hplAMNxGNy+THZeo1N8D/sMhyxdFAWcAbRpCKQjL
 Ttb47iq9VNxoE8APJ9/o1oh/BxPGObNJfh8qy8VvHNcVBhPzZVyUpZNzglwyUNC75iunRUxGaw
 YOoGMOy/dki111XobDmopZiEwrsPx0nX15g5aVX51LPQFXQ7NuofrqHe3sDUZ1tB717kFuKl8z
 jcA=
X-IronPort-AV: E=Sophos;i="5.83,328,1616428800"; 
   d="scan'208";a="173052626"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2021 17:19:32 +0800
IronPort-SDR: XiOVvivMoDdZ6QOOglpb3opVuRDNRKX/Z0SpYWsneUrnBLhQgxt9Vnf3ZePyPiiVqNC5PhAQxZ
 OiTnVyWLTjdCJIhHtKY5zIlRQ65/za/a8LiirSTI6u19crYffGtAExR82D1FrS7YnQfZacD0Yj
 5+NCa0KJuJEWbZsARCcZT2yA2zRBOG3qa83K+Ed+KolDpe7iHSHGVsAp58DZxtEZEYSJ1P2qq7
 StCV1BTlsDGEg5/sMNeFArYt29yTZjqyAcnOQzh9HHhcV5b9DgzROx9I7HwO+wWuXB9zHY25SN
 DHo4hMeeian51ltjlWkX3ax4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:57:49 -0700
IronPort-SDR: mpgNGxVEaKZyHdcScycFTOP2SLFiIBvEUGkA9pniKP5/fbvGPMIITFvFDSrWRWQCq2htQr09qE
 RrPLfZlm9PYYViKWnNyyrZQVNdUp1+rx39R/0dFn/xArSm9/oUN4p8r9l/jLgS0ycEvd2pH5Ta
 Yxg1lcyfw2h3aYFuMPODeHEgs8QDAd4hwfKnX+jsBNwM6U6VKKkju4iX5IwHYwf5O3PBPU9vue
 uc7iyVkj/BTkf2bYQjII0XWqv4QY/xaUUEwlMzS/M4GtGROzwbjOJ2PLcu82Jwo2b17IJ1EdKZ
 mcg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2021 02:19:32 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] btrfs-progs:  default to SINGLE profile on zoned devices
Date:   Tue,  6 Jul 2021 18:19:22 +0900
Message-Id: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On zoned devices we're currently not supporting any other block group
profile than the SINGLE profile, so pick it as default value otherwise a
user would have to specify it manually at mkfs time for rotational zoned
devices.

Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mkfs/common.h | 2 ++
 mkfs/main.c   | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.h b/mkfs/common.h
index ea87c3cabccf..cd98c3717235 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -34,9 +34,11 @@
 #define BTRFS_MKFS_DEFAULT_DATA_ONE_DEVICE	0	/* SINGLE */
 #define BTRFS_MKFS_DEFAULT_META_ONE_DEVICE	BTRFS_BLOCK_GROUP_DUP
 #define BTRFS_MKFS_DEFAULT_META_ONE_DEVICE_SSD	0	/* SINGLE */
+#define BTRFS_MKFS_DEFAULT_META_ONE_DEVICE_ZONED 0	/* SINGLE */
 
 #define BTRFS_MKFS_DEFAULT_DATA_MULTI_DEVICE	0	/* SINGLE */
 #define BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE	BTRFS_BLOCK_GROUP_RAID1
+#define BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE_ZONED 0	/* SINGLE */
 
 struct btrfs_trans_handle;
 struct btrfs_root;
diff --git a/mkfs/main.c b/mkfs/main.c
index d2322fafc862..fb68136a8389 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1149,10 +1149,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				"force metadata duplication.\n");
 
 			if (dev_cnt > 1) {
-				tmp = BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE;
+				if (zoned)
+					tmp = BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE_ZONED;
+				else
+					tmp = BTRFS_MKFS_DEFAULT_META_MULTI_DEVICE;
 			} else {
 				if (ssd)
 					tmp = BTRFS_MKFS_DEFAULT_META_ONE_DEVICE_SSD;
+				else if (zoned)
+					tmp = BTRFS_MKFS_DEFAULT_META_ONE_DEVICE_ZONED;
 				else
 					tmp = BTRFS_MKFS_DEFAULT_META_ONE_DEVICE;
 			}
-- 
2.31.1

