Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD776A7F8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCBKFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 05:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCBKEv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 05:04:51 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAACC1E28F;
        Thu,  2 Mar 2023 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677751455; x=1709287455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ryv8OEA/cr4FOZ/HAmMgoOd7WZraPKixzNLPqcbKjxM=;
  b=D4m6cylbewUXK+sU0mtZ115wOOPPEZnuJm31dgPk/a3V7oe5pDbaJjzY
   P3klR4SDgUS+OGxUMZ8tgQjFAxLR1zhRyjqK0OGOTQBrL1jK0IOGIHgWy
   VqsnFABwUpbCuDkBpqWqY/Eo8lUaOUDCiwpZVbChn3Y1+StmjKV6HkTtI
   b7BiS86mgITkc1lgAcwWMMSk9fFOp30egUyEEEBUx06ZYB3qAe29y/1by
   q6ctETh54ZhR/jCiG8VttDztY77pq73LocmYlhJQNo+/AG59oqpiJ+Vjm
   pPQo+OJPVoNjWFAsKpJtUS9hjP7hhmuuBZg0c/UzAEjsGvl2idxMMGIOF
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328940252"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 18:03:25 +0800
IronPort-SDR: 368cVpuMUjsWJTC54QZJyDk3ZNKbsPmuB4/RGWJYGAR93u4jCtUcbYDeMssEOjoTDzGB0mg1b9
 pSNpLXwOf6xVwinZdoGIHYsYAdCg8ndTZPdfzsCKcGe7cyNEhVZMS2S9ywgcU+XFA5OqwpsQaU
 ObjNAUs0EcevFDxY3dyISeHKJIcaBbtviCRRLRBZEAC84rzrlwWP2msvLa8MKn8hbFbrrrM3P6
 sTQDZhC+0W8wh8BIEDVnkiqDa/f+/uMQnqZuJeQy6pbjJ2za7s0A7uOAh9t+LzT5z4KSkRolx+
 ZpE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 01:14:29 -0800
IronPort-SDR: iUoHSY+RZqucb4DjkiMm66YoNpeq9IqV2h3eoD9eJyDZJ6XuoDRnMZLQ2tWHD3ae3WO5m5N5q6
 VyjQOYdzZRGC6gqNwqdtBoyfRDwlNYRRizQmOKfFAhYVRU7yDFcE60JpGM/y9EYQyuDLICPsuG
 uVvEz0XmAWoBER4CXMsN8kiW+PC0DL1KQM6zuM+cgd9FVF/1Cy1PpSnyLjBDK+4EZNDOZZWd10
 IYBO0dwNTb6edwCAxvjhqFG8BubX1rT0yt2WLMMH/NhMnTEE/Ju09K30lzZwqA3Kcrm1HljTJD
 +rY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 02:03:25 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Disseldorp <ddiss@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3] common/rc: don't clear superblock for zoned scratch pools
Date:   Thu,  2 Mar 2023 02:03:21 -0800
Message-Id: <20230302100321.566715-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
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

_require_scratch_dev_pool() zeros the first 100 sectors of each device to
clear eventual remains of older filesystems.

On zoned devices this won't work as a plain dd will end up creating
unaligned write errors failing all subsequent actions on the device.

For zoned devices it is enough to simply reset the first two zones of the
device to achieve the same result.

Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 654730b21ead..dd0d17959db3 100644
--- a/common/rc
+++ b/common/rc
@@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
 		            exit 1
 		        fi
 		fi
-		# to help better debug when something fails, we remove
-		# traces of previous btrfs FS on the dev.
-		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		# To help better debug when something fails, we remove
+		# traces of previous btrfs FS on the dev. For zoned devices we
+		# can't use dd as it'll lead to unaligned writes so simply
+		# reset the first two zones.
+		if [ "`_zone_type "$i"`" = "none" ]; then
+			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		else
+			$BLKZONE_PROG reset -c 2 $i
+		fi
 	done
 }
 
-- 
2.39.1

