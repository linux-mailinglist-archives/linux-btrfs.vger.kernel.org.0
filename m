Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6016B7020
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 08:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCMHaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMHaC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 03:30:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F3924C8C
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678692601; x=1710228601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ytfCQS5QOLo8G3vvZN2cXWqKEifYjXXrPb8K/2Kx/g4=;
  b=io7Ofl+PSxtwJLZTFp0MIPL2SieRRdItij2U2e6t9fxiJ4gYjB8Ortxd
   IZA3CZtTqaA3UBzB2AC3CXRDi3XeYnV3C9dh5IKywBAamvqZSd44zR2Qi
   1ounWSGsMREZali+zsKfHCGT5catDDEi2KmmHGbFr1knt0+qKauTaWZcF
   NZn90nQbBOJY5B8BRXzJCjOXC/vLOtLndgr8OtTb6abFQleYS7QT3GmS0
   taVHWden1ZLK7UpI2HTCIdKYIUkFCY0iPQQ6lO4C0sP9G41WPG4iFxucH
   /lPk/CHp/qCpw/28tDNANuHlF4FEQJiSUy42fgx0vmzWhbQ//6Bl40j3x
   g==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="225486354"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 15:30:00 +0800
IronPort-SDR: f5VfmZiLti7yagOyz6D1K/wvFhgvD1w3LQqA4A3n5UGhmOG8yCGM3km1XHnDO/1TAnlTrk0juL
 XTim+KieZowmBm9U+2Bt3GsG3jIWxOQktemuToRNO49kHg1v1iz7LbIf/hYuSYpsPn2fvYm0lv
 eSBovTdlsXJd0/bfh0T3dvvoKZHupVe8IbopAGN5olk194y3KVrmVvIH22x0b7xTf4MxC2j4w9
 HSMI1DGkC2FcwqGUUnyCFGQViYtrbGB/Gdorx7rY6G2Y5MPspwKcztj3aVeQI5E90uy5ralxPA
 dZA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 23:40:49 -0700
IronPort-SDR: QXW6Cqq7HMMscSOXv8GG7tRr9gzBz1iMy3gQFlhyrK5TI21WC5LCoUP4PzJsv3S2Fq/AxbabC1
 6K3UVwBhI5fR9Jp7gsTiLFi88iIQQ6Hk9oHGdybdaiMzwLwGrjOTS4Ugw6nRwkM/QeL4cl2gfA
 f67/R/J46vcGyQNDoVelEKgk1VReB0dsY7I9pjPFwSx45M+UbTH0NfpyGAugB+4deZU53COp7k
 75QS3meXuIcLyalacrI4ETjVKoJZq9dRBF1mCBxq5H+FtWCEw9SIl//4f53IBX28AJjLRF9tOC
 K+4=
WDCIronportException: Internal
Received: from 5cg2075dxm.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.82])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Mar 2023 00:30:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix btrfs_can_activate_zone() to support DUP profile
Date:   Mon, 13 Mar 2023 16:29:49 +0900
Message-Id: <b0e431dcee052cd66decba8a4484d28055d5d843.1678692557.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_can_activate_zone() returns true if at least one device has one zone
available for activation. This is OK for the single profile, but not OK for
DUP profile. We need two zones to create a DUP block group. Fix it buy
properly handle the case with the profile flags.

Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f3fcc3e09550..f7397680cde9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2099,11 +2099,21 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 		if (!device->bdev)
 			continue;
 
-		if (!zinfo->max_active_zones ||
-		    atomic_read(&zinfo->active_zones_left)) {
+		if (!zinfo->max_active_zones) {
 			ret = true;
 			break;
 		}
+
+		switch (flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		case 0: /* single */
+			ret = atomic_read(&zinfo->active_zones_left) >= 1;
+			break;
+		case BTRFS_BLOCK_GROUP_DUP:
+			ret = atomic_read(&zinfo->active_zones_left) >= 2;
+			break;
+		}
+		if (ret)
+			break;
 	}
 	mutex_unlock(&fs_info->chunk_mutex);
 
-- 
2.39.2

