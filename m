Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477974BF0E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 05:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiBVE1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 23:27:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBVE1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 23:27:08 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC148C7DD;
        Mon, 21 Feb 2022 20:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645503551; x=1677039551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y5ZKh7nMy4hnUo7yNBnvoIvadIb5o8jBNPIXgh9mzWc=;
  b=Epsd/tMcuHLN5XX7J+CuBgsc6Vlypxjuv/H0S/NvsbJoIP1weqSi2aus
   1YBSNPI/9ZfR5k5vH/I6J032MVXnNvaIIn3GFGEOWwmwdYHt/5KJ8Wa0i
   Ejawo+FzuQ4KbKeOn3DOkb7jf0cJVxQDszvJEgMBPt8XmiH7h3SfG1CPq
   L300tcIywA028xT8OQjRToWNwWP+yGNSFvj+cX8/5voAH6IWqlhxlBjPJ
   UdosqDww+nJpeVOeBJX4FaSS0RuHPLmMdwUrVLwA1S9iytcHSFEZGQOmK
   xACNnnbmxXLI2TMDP8sCOoqa0dG79j59TW6j8yHGG9lgm9IbUmhjJ6hfP
   g==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635177600"; 
   d="scan'208";a="198430545"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 12:19:10 +0800
IronPort-SDR: FOTZ8uQM3mT9nQNzAnT2gfNzt9lUgBhWcPk9bKYX9fd4sG00VWLXLad8i8Zg2qEitrgIQe4pbW
 qmFp8gWijQMO9fYdeu0M8Cf5EH9ssHlr3IOybygPd2K4Nu+yaFJKJgOF1ryI/hUlD7LI9OZziW
 XGFErxb/ZeAm5foWJmcnDJHaVfKPLYi54XpI8hR5yhuZ+FIdti8hUMgifuIzjqQQVwIthTiDJm
 VyzMe0pj+J06qIeOUXGECXLLh2B/yiK8MUHYaX0p1PDbEaLykCuvhzTlb4A7WKr0wMzGt9O2FK
 rQlOGTYNd8UYf8ENyheNQiNX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 19:50:43 -0800
IronPort-SDR: L409miecvQcX2HR0JZtKt3LPGyTKAd/Nbrk0BHFe+Q5GqPV3bFsLQtxDNAXyFarhTkYP7pNNRX
 u5Zc+dFgG3LIOypdjGLrLpya2azxy20bTGfEw3U0CNj27AWvSmc4yNh/AjstCQsJSy94V6XYsF
 8IoyTcVQmgRT2Je7Fr2qIl06KMwhz5P7CGp+XCZThpsWV8OHLx9eF5Ag8C1Mxye8ShGzDBqvTF
 ARFD7b2NWhMIIkxHeBdqmTSYwj+w2GFNbCrTkr7TYdz6J2VXNp26YKPCOoWcUvt/tP3b0+5JGP
 Of0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2022 20:19:09 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] common/rc: avoid mixed mode for zoned btrfs
Date:   Tue, 22 Feb 2022 13:19:08 +0900
Message-Id: <20220222041908.3213724-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
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

When the helper function _scratch_mkfs_sized is called with small
filesystem size and FSTYP=btrfs, it calls mkfs.btrfs with --mixed option
to enable mixed mode. However, mkfs.btrfs with --mixed option fails for
zoned block devices since btrfs does not support mixed mode together
with zoned mode. To avoid this failure, do not set --mixed option when
the scratch device is a zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This is the left work of the series posted before [1]. Reposted as a single
patch.

Change from the previous post:
* Keep change minimum btrfs device size as 256MiB.

[1] https://lore.kernel.org/fstests/20220221110254.y2yb7xdlf22ahh7k@shindev/

 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index e2d3d72a..d326572f 100644
--- a/common/rc
+++ b/common/rc
@@ -1078,10 +1078,10 @@ _scratch_mkfs_sized()
 		;;
 	btrfs)
 		local mixed_opt=
-		# minimum size that's needed without the mixed option.
-		# Ref: btrfs-prog: btrfs_min_dev_size()
-		# Non mixed mode is also the default option.
-		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
+		# Mixed option is required when the filesystem size is small and
+		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
+		(( fssize < $((256 * 1024 * 1024)) )) &&
+			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
 		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 		;;
 	jfs)
-- 
2.34.1

