Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E033F4932E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 03:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350952AbiASCZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 21:25:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24233 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 21:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642559133; x=1674095133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qDnzAb0yTT+trwK6aMHqx4i3Kd7Kti8R/6GetIs5akM=;
  b=Xm6oCub24213/Lwr5iHgueE5Rzy0SQnRr4Pnm13nXxyORAosQsZW6QMo
   9qtRHJKzX65592sdKI3X6MQwBON78DQ1nQ6KSda3tQOvAQnP1p9Fh5FNi
   aEGkZQVpXaipGcXjKk3o0UdcY0fUPJetdS5YsazNGm9sXfK1T/cSouSfK
   VvFiJqZpmLfgSoCzZM96E0httB3X9X5Kv1BWKysgmkHpqUcevVvXqB6sp
   XzqVaCy6t46t/WVPt8vdy2/5YC8c3znz+tw77DQbS4FKMITMkF2BXenC4
   IJIEZN9Or1192LfcAwf0+V+jaQV77dYUJ5KFhJIyYzKvE6RlkMuJhUlYq
   A==;
X-IronPort-AV: E=Sophos;i="5.88,298,1635177600"; 
   d="scan'208";a="190804147"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2022 10:25:32 +0800
IronPort-SDR: hbTcTbLmSKN/aFjrZ/k8w6aiP9obWHf8/u7jEvP1nOTInbxsf5m5Rjc+t04RX3QvjwIEpl6i4J
 7U8A1+fcd0Tj0exo1wpmh7gQBe1qSKbL78zxjIfl2YM+Ix3Pr357bOnYJKnFvIpb6dMFaYKS3d
 Xj0SUEboJjKOSr0mrip0HwknzLIDkBVC92UzFmCbVS0fq2UKjOED0rPR56A5Q9DNFxAFO2cA2n
 +kJ9djFeLUGwFnaT3AhDi6GSnirO5Pp5FXq6ZTVKW5BB0ha8+rvslzx17Yy+jcHec9aSXoJ11+
 OO8SurLSexKIoU4SFNKAvZ4Q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:59:04 -0800
IronPort-SDR: Ys0U8nDYqSowtAGNQuci1F5tOYzQcgLDCxtuQel8rIzNY5fNz2jjdVzQIMssz/5O1Tlw6ocIBh
 XEaSHwTNiORAPyY8IfGH4rdejXh+iTyvMoeM0mM6ymMIjU9eZwkMTJpnpZMHepVmJoM9DalnCZ
 F/uWq7fj2OI0DMPMOXx7goxQN8zHckwNFZ0ZkUm6VV+UEtB8wlPTBykkXnFg2itBhQDq4qBgw7
 CETyPMKB/+B5oTTI+NTBOgOlnndPorBaZiXFNEKWGL7t8QHL48d7SNC+/ikjFrRdtP/07vFaSZ
 a+U=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jan 2022 18:25:32 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] btrfs/255: add test for quota disable in parallel with balance
Date:   Wed, 19 Jan 2022 11:25:31 +0900
Message-Id: <20220119022531.990072-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test quota disable during btrfs balance and confirm it does not cause
kernel hang. This is a regression test for the problem reported to
linux-btrfs list [1]. The hang was recreated using the test case and
memory backed null_blk device with 5GB size as the scratch device.

[1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinichiro.kawasaki@wdc.com/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Added wait for balance operation finish

Changes from v1:
* Put more stress by repeating quota enable/disable and btrfs balance
* Reflected other comments on the list

 tests/btrfs/255     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out

diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..74aa9769
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Western Digital Corporation or its affiliates.
+#
+# FS QA Test No. btrfs/255
+#
+# Confirm that disabling quota during balance does not hang
+#
+. ./common/preamble
+_begin_fstest auto qgroup balance
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Fill 40% of the device or 2GB
+fill_percent=40
+max_fillsize=$((2 * 1024 * 1024 * 1024))
+
+devsize=$(($(_get_device_size $SCRATCH_DEV) * 512))
+fillsize=$((devsize * fill_percent / 100))
+((fillsize > max_fillsize)) && fillsize=$max_fillsize
+
+fs=$((4096 * 1024))
+for ((i = 0; i * fs < fillsize; i++)); do
+	dd if=/dev/zero of=$SCRATCH_MNT/file.$i bs=$fs count=1 \
+	   >> $seqres.full 2>&1
+done
+
+# Run btrfs balance and quota enable/disable in parallel
+_btrfs_stress_balance $SCRATCH_MNT >> $seqres.full &
+balance_pid=$!
+echo $balance_pid >> $seqres.full
+for ((i = 0; i < 20; i++)); do
+	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
+done
+kill $balance_pid &> /dev/null
+wait
+# wait for the balance operation to finish
+while ps aux | grep "balance start" | grep -qv grep; do
+	sleep 1
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
new file mode 100644
index 00000000..7eefb828
--- /dev/null
+++ b/tests/btrfs/255.out
@@ -0,0 +1,2 @@
+QA output created by 255
+Silence is golden
-- 
2.33.1

