Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90F4CFC90
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiCGLW1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiCGLWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:22:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46CA24F0B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646650044; x=1678186044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ul9GXlz1m+drUDFZI0YV7rX7GRPyTWgtJ0WYupYmPhU=;
  b=aQaZh+mA4j7K/Hq6k8Dpu44PceR+5f2f86mYhZX8H66aaEnxeRASrkyf
   1c5eh+XwGSm89LaK0qk64VNpBRQoQDoybeMjQPGfAnDy6RrrDPa+u4Jaw
   461arJj/s02uUOt98Fthg14cwxtyrreC1sb2ndi4AyKvlkuqxgAnJlxf0
   w1OzWWvovg/9cqHn4IeDQ6p2GnEqjUGLqiqdauSz9jEi4Igk6ikMzaFLd
   ykGUrH1V5PatKYCHLxAgA7/tdp7oRYAKswrLzoBWqB9Y25/qfvkaL1jUa
   4BlhN4h7dFukKyST6hds7CGjwCPgLOvzefLjvPALux/JEno44zRBKhsWU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195615431"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 18:47:23 +0800
IronPort-SDR: 1hX98ryyCoBeP1+zl7dwzzHq+S2iY1zPl2et0tliWhosNp7XxbGP/p7U/Znw6+9oF1GnKKMWoG
 TAIb+d19hWou9yX7IcCBfWR/MQoc7kszzyOeFumqfaEl2pzp4kZId0+8j4yIL4NEwYXzRd1yna
 /PkAJg9mqyfFyDfF/EczpKnu+aGCtYdH727ak1vtsJyK9sZbm3esnwfA5HOmuWZzM+xTsMFPpV
 GEyzgQ75hNfxGixw17AdAp4gx/Hw9EHI7csqtad57RdJTskp+KLHrIcEcQB18raOzHxJRS0+yp
 4w/mlfeEWQcitXfOagDSbHDu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:19:41 -0800
IronPort-SDR: ir8oMu0Womgku/2PXxmaMwBMvcNsnSpnJwhuNpKYDXeD9kL1AMLKZDdLrIhEO7X2wb0GW3aFmZ
 gZfBOjfsSq241ANRFnmEaFfSt0VGC9YxdjksbpO/duuCp2wZS0GO83VWlxdfryblshDRg/L44C
 NbPv4HHy++52qYBzS1nFXYPNyr8OEE1F6Sj2SSd6VNe7CfHeDZIlOulcmF/RQLchka0Oc+0JDa
 bi1LmfZTm9+ToSxErhqMNB0lA5aQWtJ4oMZ/b8ikdsbTlPQrw1Ma0vclzc2r8WCHFTKXrgTlZ8
 sts=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 02:47:23 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wwdc.com>
Subject: [PATCH v2 1/2] btrfs: zoned: use rcu list in btrfs_can_activate_zone
Date:   Mon,  7 Mar 2022 02:47:17 -0800
Message-Id: <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646649873.git.johannes.thumshirn@wdc.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
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

btrfs_can_activate_zone() can be called with the device_list_mutex already
held, which will lead to a deadlock.

As we're only traversing the list for reads we can switch from the
device_list_mutex to an rcu traversal of the list.

Fixes: a85f05e59bc1 ("btrfs: zoned: avoid chunk allocation if active block group has enough space")
Cc: Naohiro Aota <naohiro.aota@wwdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7b5fac1c779..cf6341d45689 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1986,8 +1986,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
 
 	/* Check if there is a device with active zones left */
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 
 		if (!device->bdev)
@@ -1999,7 +1999,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 			break;
 		}
 	}
-	mutex_unlock(&fs_devices->device_list_mutex);
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.35.1

