Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE64B0F1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 14:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbiBJNrW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 08:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiBJNrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 08:47:21 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C5CF34
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644500840; x=1676036840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rWBoxZLcoCTAaOBaTFF0jfU++Pi/MwOSb7iKBNhqz1w=;
  b=OSE9LsB/oDVTmuEhLm8z40g6WH2g5AdegLFCFoJyyE6T7TJl/z9acoar
   lYJ9kfDM1huFldlJgK8VyIGB9JbGrYlJWOMI+UXEkbl75G+TzSWR8orYs
   HI/pDmGpWuSqpkbk2uPbVWeQHdt7OAYyEfzUN3qvOtz0p9LQ7NL/lL+VR
   swJeZopvQpV8PvrROOvq0tabMqpGDqoO0iIvvkCUd1sSIuMUA4lFgP5S1
   krYEsFsIXMBzaNhwkwKwQPQmb2LvOVm/aeytcD0COEASpdY0+DslEPi04
   XdIG72CVXR2ot1Yr2EGi6uUmW0ieBGzxQP70vHFMq3KwVjA5ZJcXFF9ix
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="192599364"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 21:47:19 +0800
IronPort-SDR: mn3LvuYzcql3lhnc8eJJRjlvx0/XMd2ar1tuw8xjxI+qWKSkNaBkbzukP981iRCiRSNk3KM/xd
 HcLedeNdikxM2ncHtbzrl+76iVBDOXFeQ+IEINoeX5i0Ji7E6h1awtveo9ihe+Ha8ekbxuQiqf
 Z7GfoIQNU3SVEfWaFGNF6RqLWSFd/7Xf7WahoCIiyO5KEY+BaX+n1wqc8Fd/LySzFiYkQEhUVF
 TE7BcyFweiIpOkctSOxSUOuVn9HCVtvMWXPkMwdCHr1zFyJjSjVFtQsiwAy5hxWYondihkuOXM
 9JTPO8c3CfgvxVl+Qjd0+6RP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:19:08 -0800
IronPort-SDR: GQ7r0XhJ61CqgG8aog/6A/w92Us0oU1pe34wPGp94e1T9OYb6HO1OuLELBlkLSLjGeGNVTRulT
 MKCMFeeCkqvDJqL6v7F3TLCP2ujvf/cAaMExexy0wTvJad6Op4xptWFK7dGO9JMge3rYbsVNd0
 yMEpwziEBqqTF3+dnzf1ENQIUQI5yiD+09iyV6qijoWbLTJy4YCGQiS/j9OsunRQ4cekuTJUOI
 UqtXdanLdc2g6lkSJfUuO1ZcN3mCFXgYEyOfGRXMkidJFZIZhVJL3VD9J7qIZaYlIYMoxdD97L
 gLA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Feb 2022 05:47:21 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: introduce a minimal zone size and reject mount
Date:   Thu, 10 Feb 2022 05:47:05 -0800
Message-Id: <3824ae6295104af815c8357525eaa896e836eb1c.1644500637.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When creating a filesystem on a zoned block device with a zone size of
32MB or 16MB successive mounting of this filesystem fails with the
following error message:
 host:/ # mount /dev/nullb0 /mnt/
  BTRFS info (device nullb0): flagging fs with big metadata feature
  BTRFS info (device nullb0): using free space tree
  BTRFS info (device nullb0): has skinny extents
  BTRFS info (device nullb0): host-managed zoned block device /dev/nullb0, 400 zones of 33554432 bytes
  BTRFS info (device nullb0): zoned mode enabled with zone size 33554432
  BTRFS error (device nullb0): zoned: block group 67108864 must not contain super block
  BTRFS error (device nullb0): failed to read block groups: -117
  BTRFS error (device nullb0): open_ctree failed
 mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nullb0, missing codepage or helper program, or other error.

This happens because mkfs.btrfs places the system block-group exactly at
the location where regular btrfs would have it's 1st super block mirror.
In case of a 16MiB filesystem, mkfs.btrfs will place the 1st metadata
block-group at this location.

As the smallest zone size on the market today is 64MiB and we're expecting
zone sizes to be more in the 256MiB - 4GiB region, refuse to mount a
filesystem with a zone size of 32MiB or smaller.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

@ Javier, I've CCed you because I've heared rumors that you guys have ZNS
dddrives with a zone size of 64MB. So I'd like to hear your toughts on the
patch as well, so I'm not breaking existing devices supported by Linux.


diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7b5fac1c779..3cf9217f6fcf 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -51,11 +51,13 @@
 #define BTRFS_MIN_ACTIVE_ZONES		(BTRFS_SUPER_MIRROR_MAX + 5)
 
 /*
- * Maximum supported zone size. Currently, SMR disks have a zone size of
- * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
- * expect the zone size to become larger than 8GiB in the near future.
+ * Minimum / maximum supported zone size. Currently, SMR disks have a zone
+ * size of 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range.
+ * We do not expect the zone size to become larger than 8GiB or smaller than
+ * 64MiB in the near future.
  */
 #define BTRFS_MAX_ZONE_SIZE		SZ_8G
+#define BTRFS_MIN_ZONE_SIZE		SZ_64M
 
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
@@ -402,6 +404,13 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
 		ret = -EINVAL;
 		goto out;
+	} else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
+		btrfs_err_in_rcu(fs_info,
+		"zoned: %s: zone size %llu smaller than supported minimum %u",
+				 rcu_str_deref(device->name),
+				 zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	nr_sectors = bdev_nr_sectors(bdev);
-- 
2.34.1

