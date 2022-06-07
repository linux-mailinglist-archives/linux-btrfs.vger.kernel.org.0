Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEC53F7DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiFGIHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFGIHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 04:07:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D86B82E3;
        Tue,  7 Jun 2022 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654589218; x=1686125218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9cdqJxWJpsXb4ejaVbh4KSeqbOD7/vw3zsXuAOp3L90=;
  b=R5r6UOZO4Z9TPIyrXO5lzUnRxd5ctLxyizCsZXpEkdIZTqqzRh0hMTTD
   g1H64B3GjVWFCVjHQ7auRa8we/BVuFzq6rWnWKNwamuRFCFSJhqLH/G8k
   TH+mnanRUtoAV5JY87azOPNyHey7P45kggqD2MFViyIsKjOMuiCxFlaqz
   Vscn54H/4SeZA7BobEnD4iuhCj94p0Vt6NOJmGzag0xA9TthiCCdKq2bL
   UD+Tx5zwPuB1hFyqd/W87Hq0BSJ9DJByhogXbypnC5O2V1vnG0Oyp2umO
   UBo8PnGoHVqAiicBu28hhbpTILk/QVtHc8kNMlBQYwEwTPEXsBSEX5QFg
   w==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="314508301"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 16:06:58 +0800
IronPort-SDR: cLcjORxtgMNIhqYjs0DwAV0EYKiZZLtu1x6KAhv4AraGEHmbTxj+kyW9Trg12yv7D/+hdrzjsu
 we3RvSEvYA1aXCYuNj8HSJCB3SBaMatKhe+fn63qSFWNqLyi6jf0jtwrSq2FzxaiBm5cyfTI59
 LpJxuyT48Ok7yFRW4l0YS69GzTq+s5ybuL3mLt9BSB0jW5zXsmBx+6m62i1elKI5kXROzH2vvf
 SLLR1glPbY/K36QB2etaspbrfgxMxwRXmb0MhE/TY+tgxtYOvbOLgpGX+gtEr1kbz4z2lLz+h6
 bYl/w5E3GloyGNMm8818XCma
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 00:30:14 -0700
IronPort-SDR: JJZ1O0i94qbifZgzgzPPadSjJJqozpmiYAowGl+nPWcFHI43Y80DjPdt4ZS1aYZI60H96+tYW5
 H0sPs9WxBjWoN61nEhOdSlC2r6HdnifygdL6mZewDBSTcSUP1hTSp2pgWFBrzxSixuBCkYqbTC
 EaGOGp5VsygMEQy+0gbqVgXmWbTixia42rNfj7pAf5TM85ldiVnkddfyCuRsbwut/ALMi5O3Q2
 /8C7MCTqa8Rrp3LIBumSEVRfT0MhjARxnGOxNvx1yZzYkQGBmZHuj/J0AUACBYFYnqwXhmOT+M
 rhw=
WDCIronportException: Internal
Received: from hr204m2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2022 01:06:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/220: zoned: skip nodatacow mount option for zoned btrfs
Date:   Tue,  7 Jun 2022 17:06:35 +0900
Message-Id: <20220607080635.4010254-1-naohiro.aota@wdc.com>
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

The nodatacow mount option is not allowed on zoned btrfs and failing the
test. Skip the cases for zoned btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/220 | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index fa91a38493af..4d94ccd6eee2 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -265,14 +265,16 @@ test_revertible_options()
 	test_roundtrip_mount "compress=zlib:20" "compress=zlib:9" "compress=zstd:16" "compress=zstd:15"
 	test_roundtrip_mount "compress-force=lzo" "compress-force=lzo" "compress-force=zlib:4" "compress-force=zlib:4"
 
-	# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
-	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,datasum" "$DEFAULT_OPTS"
-	# nodatacow disabled compression
-	test_roundtrip_mount "compress-force" "compress-force=zlib:3" "nodatacow" "nodatasum,nodatacow"
-
-	# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
-	test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" "$DEFAULT_OPTS"
-	test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
+	if ! _scratch_btrfs_is_zoned; then
+		# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
+		test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,datasum" "$DEFAULT_OPTS"
+		# nodatacow disabled compression
+		test_roundtrip_mount "compress-force" "compress-force=zlib:3" "nodatacow" "nodatasum,nodatacow"
+
+		# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
+		test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" "$DEFAULT_OPTS"
+		test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
+	fi
 
 	test_should_fail "discard=invalid"
 	if [ "$enable_discard_sync" = true ]; then
-- 
2.35.1

