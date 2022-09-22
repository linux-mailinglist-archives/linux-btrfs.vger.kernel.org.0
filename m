Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE25E5B06
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIVFzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIVFzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 01:55:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE902B4420;
        Wed, 21 Sep 2022 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663826139; x=1695362139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fuX+N/jPRiLEpVvBWbWnHHkQ24UIw9RfyIEX4XwB7qo=;
  b=jbagDYYDrOoRmvFVLNOHqZng9KmfZF0t7LX4JRY4TNv1twxLIeMq8w+p
   3d80Jc7Hh1A6Ou2uJwHjv3EUccEAVW4dInUAYVrmhhL+nnmCmVAvc6COI
   KDnMpFig/AnUyguwGq+Hj7sIZZJeKiiy/56JqKfPLFztXAnfmoVRM3ATl
   Pu1cgd5mTC/Aay6cVBKh+zU14XmtdvyNNUkY6bgCE5d7EEKkPp9GdR1Oi
   j5zbohlvBLg58LECwNCh/fZ6FdrIkaVXoClwVSyWGaH+b4W9nqVtUGiWi
   re5Djuwrtz8fJrIlwtg5ZsS84O8uIj0PdFncvcbkPuebiWnPxgcUvoWZS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654531200"; 
   d="scan'208";a="324089196"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 13:55:39 +0800
IronPort-SDR: Mi1gDXmM48GU1xSIZFx0yYUgCnVIggG1JAS2YBA3MdCxS/T79Yg+Nk1ZfZoM/0Wey5JWVOp/Le
 N74rE5oJXS1T/wKtxrbUBUdC4ktR5KiDAL7uN1LvU6vvnEI0Pn4hR5ppINgJmJfmp5Z78aCG+q
 JBeGS2R/zSqUXO6wOennC2t1W+FfMp211SKv3gNuUWhbT4rooAqyQtA1qcB7gw65WKIaQHsGLk
 WTAeE8BjVbqiSPmDva86hJ6Otd6u+4gm4SvlQiB1n0zfKuKnDitkZZcvvALnEVDe8hFeG+EHJ6
 AcyvFO1gG/LGUzITLTGvHl4E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 22:10:13 -0700
IronPort-SDR: j2idZ8wu9C8ck77ehJDkMTUjYtjy6/ipMS3OlGFq8AL+MvqmrXTQME/Zb6bOJO+UqGgfv57QBX
 sH1NKKwEMxh9arSw1QpCzlTleaE3H+8U2TFaQk6K4OxJLw/yyHZIsYFEUGw7Ia3mSyJy9EYekS
 InyCAEv73naKXMhI370SK0KqeTz6q1c/71kS0wQzpz68MWnGrDJYIbcAkuCq8VCpNzdMiVy2GE
 uwzjf3rHAeyW7u8fnDDwoMLzNV4MOK+ngJ47xq2oST4ERV0jOV/sA/Vot1i11+kRave6qMYxHK
 rrQ=
WDCIronportException: Internal
Received: from ghkxqv2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.86])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2022 22:55:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] common: introduce zone_capacity() to return a zone capacity
Date:   Thu, 22 Sep 2022 14:54:58 +0900
Message-Id: <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663825728.git.naohiro.aota@wdc.com>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
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

Introduce _zone_capacity() to return a zone capacity of the given address
in the given device (optional). Rewrite btrfs/237 with it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/zbd      | 17 +++++++++++++++++
 tests/btrfs/237 |  8 ++------
 2 files changed, 19 insertions(+), 6 deletions(-)
 create mode 100644 common/zbd

diff --git a/common/zbd b/common/zbd
new file mode 100644
index 000000000000..329bb7be6b7b
--- /dev/null
+++ b/common/zbd
@@ -0,0 +1,17 @@
+#
+# Common zoned block device specific functions
+#
+
+. common/filter
+
+_zone_capacity() {
+    local phy=$1
+    local dev=$2
+
+    [ -z "$dev" ] && dev=$SCRATCH_DEV
+
+    size=$($BLKZONE_PROG report -o $phy -l 1 $dev |\
+	       _filter_blkzone_report |\
+	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
+    echo $((size << 9))
+}
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index bc6522e2200a..101094b5ce70 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -13,7 +13,7 @@
 _begin_fstest auto quick zone balance
 
 # Import common functions.
-. ./common/filter
+. ./common/zbd
 
 # real QA test starts here
 
@@ -56,11 +56,7 @@ fi
 
 start_data_bg_phy=$(get_data_bg_physical)
 start_data_bg_phy=$((start_data_bg_phy >> 9))
-
-size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
-	_filter_blkzone_report |\
-	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
-size=$((size << 9))
+size=$(_zone_capacity $start_data_bg_phy)
 
 reclaim_threshold=75
 echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
-- 
2.37.3

