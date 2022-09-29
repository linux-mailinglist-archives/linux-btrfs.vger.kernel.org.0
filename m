Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4675EECB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 06:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiI2ETy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 00:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2ETt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 00:19:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5489584;
        Wed, 28 Sep 2022 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664425182; x=1695961182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PLevBtQBPR/jAdXiKRjAMrqRDiVgMyjZ1wWYG8vQcV0=;
  b=bXBadW2pBO7Y5qXQtV41cQ8bOAPlAZMOv4lsqUiLInERCuEWQuv5VygF
   +gjdRIg4rH/uDh+7xirrYMv7qnxVsbWdzvXE2Ae5tloE5kzv5Ig4e5EVw
   vAD0RHGUTJQ/l6X6uXuSgTvxxyYJigb/mbolG6PWvkpc2YTkQt7NbSr70
   DkWpmvoImh7NzbhkJVcEiwJJqLD8xDxPLSukTpKZAxtTTRZ2LhLojIaTg
   jGudgupA0yjKk5wHsA6/2u1/36mU5S2zHDsqt3ZMb6y4Mm+/C0Lli7RUD
   yPexWAhhVnC6moEvPxseNN0m6JCu3y+8ka3IXLW/onwUWXB8EDorDBOeu
   g==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="210903787"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 12:19:37 +0800
IronPort-SDR: a21lqbJMwrAiXLOdwReGdp+JfKMu5exMSNE2Qg1GGU/LKaBQyWB9G/zzJocwQ5A6eAqwIo4+Dk
 sxeZ+L6GOsIIIbx4ZO3XlSQM4ZrqdPo5RR6ktx/rz0c/nwvf0YSETbMKMlf10eSTL78w7vAZn9
 RGkE7HGfWMXYwO5tTIZcqZkBjOj53i4rHrvzyTtME9L+JvcPi8ff2vxD8tKgIvyKtAp4hQt2cn
 Fsb6rhr5UcHHL7o24lvXQ8yfuBKlOUbF3SSIaOs7/7xAz8V1p7yd/IlVeMsEj2jlqyMdWJ4KkF
 XgyXR+Lk7j6YdfrRw+O72UAe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 20:39:31 -0700
IronPort-SDR: p21hmIzXc7CKyg3Nurs5eT/R8iiDv+dmg4kCZzGRZHw6q1D6L8z9ckdoDYmGMYDGHOhQI/3fvY
 SCX0wT9jbEwaeKoMVd8/lJ4NmxprIgB4mpVMAh0mIzJ2CpdE5M4enlgx/YCle3fCk5b8+WUQ+w
 kArkS0VO7SCW1AoF3joHDE4OxfMtkoZ2c1+8Kw7p3VQ3El9MQVckqbaUz5GGs51jAZc3pUXtgJ
 BpOCvYvHSasHU4w9hyxAbydCH+KhdiAlXD6gmmvv9myhKsfwjGmjez6+IR5otZWj2pnl6uCUGE
 gHo=
WDCIronportException: Internal
Received: from h69v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Sep 2022 21:19:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] common: introduce zone_capacity() to return a zone capacity
Date:   Thu, 29 Sep 2022 13:19:24 +0900
Message-Id: <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664419525.git.naohiro.aota@wdc.com>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
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
in the given device (optional). Move _filter_blkzone_report() for it, and
rewrite btrfs/237 with it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/filter   | 13 -------------
 common/zoned    | 28 ++++++++++++++++++++++++++++
 tests/btrfs/237 |  8 ++------
 3 files changed, 30 insertions(+), 19 deletions(-)
 create mode 100644 common/zoned

diff --git a/common/filter b/common/filter
index 28dea64662dc..ac5c93422567 100644
--- a/common/filter
+++ b/common/filter
@@ -651,18 +651,5 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
-#
-# blkzone report added zone capacity to be printed from v2.37.
-# This filter will add an extra column 'cap' with the same value of
-# 'len'(zone size) for blkzone version < 2.37
-#
-# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
-# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
-_filter_blkzone_report()
-{
-	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
-	sed -e 's/len/cap/2'
-}
-
 # make sure this script returns success
 /bin/true
diff --git a/common/zoned b/common/zoned
new file mode 100644
index 000000000000..d1bc60f784a1
--- /dev/null
+++ b/common/zoned
@@ -0,0 +1,28 @@
+#
+# Common zoned block device specific functions
+#
+
+#
+# blkzone report added zone capacity to be printed from v2.37.
+# This filter will add an extra column 'cap' with the same value of
+# 'len'(zone size) for blkzone version < 2.37
+#
+# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
+# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 ..
+_filter_blkzone_report()
+{
+	$AWK_PROG -F "," 'BEGIN{OFS=",";} $3 !~ /cap/ {$2=$2","$2;} {print;}' |\
+	sed -e 's/len/cap/2'
+}
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

