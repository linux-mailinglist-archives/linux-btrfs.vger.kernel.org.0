Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4444D5F4F92
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJEFqz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 01:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJEFqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 01:46:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581672B62;
        Tue,  4 Oct 2022 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664948811; x=1696484811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQ2IUQJMF4R3aEPD69wWuI8fkmboUToQc43FPIw02LY=;
  b=iaLuTfoTsK5As/JEkEuB0aFYlJ7OF2VkZBeSxhOTmtZbwtJ5eF8u06ys
   cuVb7IBKhzrDv1rZ36B/VA3vOE3ZdYP/A0LOs2Oc2hWqOXtqszxR++6ej
   ei0OCZL2O3BjW+Wa2U6Pj8psTrr3CocawRHV3y0QvxdL2ADLy9b6+QoMR
   6wOcieatSuOw1mMP2K1l9hZRO8U/TW+3SE2o5qPDqqxpY7T/xZSOLz6xa
   COOGoDjFAQj/6jejy+4xaYRkWSL/pVWGJ8CDInu6Ta+jw0kjLm/nkgQ8B
   7+bQEFVEMNWns8GYJSJ4SJEWhzvvixRqNwFBnI7ermid+mrOBTccOajDA
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="317309477"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:46:51 +0800
IronPort-SDR: NWN3yqZKQ0HpfOAI9JHY92p6RoE97KF93zud8WK1KUIH0ZpryGmbzXFW27qqg8QQZm0+FKTrso
 2cKYxWZ0gh1YyYGY5rFXxc7qnDU1mBAiS0YOseUNPnmfHDTuVRfu3BDSGklv2lglsHkgQDd6jp
 nK4/8wJNxtl9CC6lIunpjxdi8Hrp1W3TxhwhLrPppODg5xCgYx2Ev9hIqZOBsWFSxPa+EuSpK8
 +rwtfZMgic0wSDByNMNo+J5meFXQ9AcgI0cH19sWn0SqBj5r1st6qdQ06/SpZtCjhMih/xvrxR
 ia9MWtfy7b3LuDv2HkEHIBir
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:01:04 -0700
IronPort-SDR: AGtflkBt0OjjmtG6CWZ/InwCpyoQBwhp52J6fGq3xILtBQhLe0Jd5wUsO1iSH+mWXsoxx5aSBi
 fhhL1djJfFUkfYDHbxRHDnAV0Vy3ymEXMGyfLABH8g2l6pZFpi6oQTMyPleLUSBX5V0Qxhx5b/
 8lGli9pEScMESKOxCT7T3DYSKUoSLN7twerSLcgp0wMhSrZ70XRXIXU1MO/XWbvKJkeFm4U1nr
 1dtyprDm/z5p+7rh/LnHg1zFaP6sxVxPBQWbwOuIwyK0iZq3+AmZ0TBE3vw1gw6CCuOfVlroqy
 E6A=
WDCIronportException: Internal
Received: from 5cg2075dx4.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.62])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Oct 2022 22:46:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Zorro Lang <zlang@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] common: introduce zone_capacity() to return a zone capacity
Date:   Wed,  5 Oct 2022 14:46:43 +0900
Message-Id: <b7cbdab139385136beb9c3e502ea6b3de74987bb.1664948475.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1664948475.git.naohiro.aota@wdc.com>
References: <cover.1664948475.git.naohiro.aota@wdc.com>
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

Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/filter   | 13 -------------
 common/zoned    | 28 ++++++++++++++++++++++++++++
 tests/btrfs/237 |  8 ++------
 3 files changed, 30 insertions(+), 19 deletions(-)
 create mode 100644 common/zoned

diff --git a/common/filter b/common/filter
index 6433a30e53c2..3e3fea7ea02e 100644
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
index bc6522e2200a..733ce9c8bd8e 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -13,7 +13,7 @@
 _begin_fstest auto quick zone balance
 
 # Import common functions.
-. ./common/filter
+. ./common/zoned
 
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
2.38.0

