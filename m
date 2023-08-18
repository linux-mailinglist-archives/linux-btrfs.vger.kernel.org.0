Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A378039F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 04:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357167AbjHRCDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357165AbjHRCD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 22:03:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8D30DF;
        Thu, 17 Aug 2023 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692324208; x=1723860208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFbSp5P6d84AR5BRsgqD/c4FrXTmfzo61rKLHZH8Ju4=;
  b=HFhiuf2fdIpc2CFYYLEKOFrlOIaoWxfUWWyI+yUB0YwEZvvTFfuSgMpv
   sVUrapn7GGhZhQsMvb3y1BRfIF1kX37DHhet2ZpP3KyV8AFY6On0+we50
   afu77WKZSTRZ9PuFKtCuDoGwhe0+2MJwcjyaE2DWadUGOVDh4FILxULP7
   FyDmYf3RYwK4NRa6QTbmupDHczAVIb8yraPlwbkhxklQTIgikiPrS1q2z
   B48Jun65THfedjur/i9GSJNfZ2csnmwImPI2+G0KyRsSYZVD1yb8RmGS5
   UWEhp1NwUD0M0G3IVwe5D3t/6DuRmleSvX1C8AoA4QUxHshQuL4DbWShq
   w==;
X-IronPort-AV: E=Sophos;i="6.01,181,1684771200"; 
   d="scan'208";a="346627805"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 10:03:28 +0800
IronPort-SDR: 3Kl0D5eiVp44aq1QfnOdeIuoYwosZLaSXZYjtIVHzhDRX0hOdMxQ+TJjse/Pzk/cuwXQX/pmK9
 gjVXS18kAkOMSyqGjxTSRU/VhPLE0UKNSkZb/+/KDgKI+kYWdcKoHPlrWLTjV/KCILgP1En52I
 hT7l06KI0Fai+IrztLKQ76ko0JCpK1QTXAgAVmTBOPnMDyB823hFCi5yUNRlXy6c8szA4ix4Mj
 mTKQ3b497gq9SSWWOe5OOeQI3Xbh7HiodE45yhJoF/0oxC8CF1s64fI3KMaj+0/5qoBEcJm5kP
 FX4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2023 18:11:03 -0700
IronPort-SDR: rSqAqxsPOJKOm9JTuf2GeEilUmAD2skqy72q+NiKsKTcW/Y+6pHWl1bXZJXyL+CJIgN3NEQwzi
 TA0/shS3m6TUyrXCAxn5awRDlmmQW0dGD0WecmtnIRnHNrQIIB2xR6jzYyXmamMXgCFD3BKNl1
 RetND0I7yiPnrfL4XLBrUuUdHBy1u4+R43shfrboircguFwAoPhcVU5wJ1k3sAjG21K+kJSjtN
 ntP7HOHzGtZu8F8yozp8I9AxtcId7S/CBNrvOK/3ldt1+Y7miY1Sxzwe9yS2+Vy5wR/yC5n+4/
 7Kc=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.92])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2023 19:03:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/220: do not run async discard test on zoned device
Date:   Fri, 18 Aug 2023 11:03:25 +0900
Message-ID: <20230818020325.1214715-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mount option "discard=async" is not meant to be used on the zoned mode.
Skip it from the test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/220 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 30ca06f6038d..b092f40bc1e0 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -279,7 +279,9 @@ test_revertible_options()
 	test_should_fail "discard=invalid"
 	if [ "$enable_discard_sync" = true ]; then
 		test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
-		test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
+		if ! _scratch_btrfs_is_zoned; then
+			test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
+		fi
 		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
 	else
 		test_roundtrip_mount "discard" "discard" "discard" "discard"
-- 
2.41.0

