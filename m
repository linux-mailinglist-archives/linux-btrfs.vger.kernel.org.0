Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF59C526695
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358928AbiEMPxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382265AbiEMPw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 11:52:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269081FE1CB
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652457178; x=1683993178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H5eTAL6roU+zpHuZPyBci91EKZLtiOskyKcgoNDXw50=;
  b=JKdbPUNlo91u4rTU5lLzBYeZ9pleyKuohhcRPlJeas9FjN+wIwxivFXs
   92a3/F91tUwBpHttLmpEO75WLeU8Bbh9+kioXLe75ONGShmD8DszdwtIR
   OMKz0nsX0vT7qB3VPveOsW+CFFpVOlm9rjGjSMDql1EZXoGVysDPXjxAZ
   X3Aux0DvTTXe3r9XQX1RfVWBU5bvlTsgPEkwKVE4TuoGlHZ5v4YkHuZH+
   5QrXVinwsRb56rM2HFvuvfZOwFWqJpOx/xNc6Oogm8JuSXfP5AHtEoaoV
   Is/5i0Y5Sy75ykf/ZabU2catOuQcPwxwadUtPN10HSEFL1IIh4wj5du3z
   w==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647273600"; 
   d="scan'208";a="199099870"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 23:52:57 +0800
IronPort-SDR: ilnPUR/mhs0wA9o0KGgfivfNUdbr8XyQt5Wr2k6rcS939gHMZRVJn6ddk5WSIaCheLM/oyq8yg
 wKl9DnVAs4dHd8eZYHoUuLOZfAvZfZpRwiJfV0HJCTsYZeQKBVLCv+qyxTIUUssTvbmIbLpCH1
 JDu72yUxx/h/hCRtj0vD0fcrYj1tshyF11S3P90cHK3YNLdxwyPU/roWqnPX/n6x9iTaKkcTSY
 eK6tmsyFWFotyTpnhwVtps12FYGU6pqFtjfnJVTgzj2tsKXoRhIZtAKL47NMfwKYCZvCxA+T4V
 Z3aTSqFUcVqj79ZGxs/1C/UY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2022 08:18:53 -0700
IronPort-SDR: W9jPO0sWtkOcAZWJ/tNKeCC7uCNqMZJxgFPJhenyVQmwk3os4axtgDVJYjC0AFEgAO0lchhrrl
 u4Db95VwePW90R5jul4Qiv3EXnEK0BEuK5ikSzsCQtjA7eXmEGkASB4Zt0Wc03pfmOPQXWpB5L
 e/kl8aWzzESJJWxR5ymncY/NvsOK7+HSzO/DkNUFm14Rtj5XxoEWrpxqIZR08mfcpXWCFvucUx
 Qj4k0TxzLb5iJZYVCzDVZv8Ry+WzgJdR+N/961P0ubkCEY9u7BiDB22uGxdPdJvONw1hDp63e/
 3SM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2022 08:52:57 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: introduce a minimal zone size and reject mount
Date:   Fri, 13 May 2022 08:52:52 -0700
Message-Id: <8aa15bbbacbafa2ab77c01bfdfdabe65d6bfa606.1652457157.git.johannes.thumshirn@wdc.com>
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

Zoned devices are expected to have zone sizes in the range of 1-2GB for
ZNS SSDs and SMR HDDs have zone sizes of 256MB, so there is no need to
allow arbitrarily small zone sizes on btrfs.

But for testing purposes with emulated devices it is sometimes desirable
to create devices with as small as 4MB zone size to uncover errors.

So use 4MB as the smallest possible zone size and reject mounts of devices
with a smaller zone size.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b1b310c3c51..d9579d4ec0f2 100644
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
+ * 4MiB in the near future.
  */
 #define BTRFS_MAX_ZONE_SIZE		SZ_8G
+#define BTRFS_MIN_ZONE_SIZE		(4 * SZ_1M)
 
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
2.35.1

