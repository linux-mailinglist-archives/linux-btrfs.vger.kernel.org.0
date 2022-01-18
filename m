Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD35491F2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 06:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiARF5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 00:57:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20729 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiARF5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 00:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642485443; x=1674021443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lFe1rKRuJ3zJN4xQhiSz6eCA+PrB7GkMfSaZIMgBOWE=;
  b=TIcpJ0K/4emkUeW0dgQ/B3owpgeiaZreW0/29K03Uy0blZFmBwLKV+26
   XNl2ChsGqRTg2NhH29KLcY+zxYEEjy/5fLM8sga/gIymlkNWXj5upEAIR
   1pTa+tOgMjN0G6/ro2SEYE1ZYD77+2TLVvKJ3WqZ3mi+uHUnvr8bJvVp8
   jvlbU1d18iZ3jkMPyesZvOnpZua7TejtoslCNaKT6bIKBodp/epUwGg/k
   jSTZ5lci7z3c6xWZdakkLLLFBJU8eOloIoJb3rMsqNiYCjR7d/Vho0mlA
   /WDyBMNLj+1Mw0twoikclHytsmbMQbn/ovY2Vx0g10ydxWsbPPhmqTnGI
   A==;
X-IronPort-AV: E=Sophos;i="5.88,296,1635177600"; 
   d="scan'208";a="195505198"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2022 13:57:23 +0800
IronPort-SDR: bD6X3d7zPDMQaK0lz75xcVQYWIHdbPytUzgtHVZHunDrTM91BUzb8Z/6GvWD1FmQQDYI4KHgtD
 RoVT1qjd7OkvvGPKsBW8GZbLpv/mW3YeX8A2N7ArJWu6gj3Oa1uRMK28h8khJrpBZoPp8KsP2z
 r63Ogw3IFaIQdIE/+kwvMBjPtICuxQfQuxGWqV00RA41yZIU/6L7qz6PB/91brWjGVVxwkgnZe
 +sYo3kqShnjO000xKE8eCSTbpAmp0IsAhfL0cgOFFZBtiDdClx6HmZ8nptQZVeXNCPjIacSWs6
 DSXfr7+aaR+cO4CQDk5fWyPm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 21:30:55 -0800
IronPort-SDR: G75JaiD6ADqsBSq0BooDzYpM4nEpY3KYBOD76DY1++NF+M9z8+UBAdwFDgGXBOBMusMyT3eyVA
 AroAMJmPEaoCR3E+SlV3jZxBmCgNB54A+zwyVoVl/tk+F2LOtT0mr/l9K0Brv5VB/94EMOIE+m
 U997fH49zq0BRHmDYW4ruRpg1z5liXpk77kipYnqx+HVmGZSeFzGcuTjn3fjKqX1iDkbUYEiYf
 g8r4cL4gBN1M62p17uMKU+J30tNzQr0CJQh7hW+t8aFnDC15BtvBjn0Evjh3+GSVmSeaaHY9bc
 hVI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jan 2022 21:57:22 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] btrfs/255: add test for quota disable in parallel with balance
Date:   Tue, 18 Jan 2022 14:57:21 +0900
Message-Id: <20220118055721.982596-1-shinichiro.kawasaki@wdc.com>
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
Changes from v1:
* Put more stress by repeating quota enable/disable and btrfs balance
* Reflected other comments on the list

 tests/btrfs/255     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out

diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..32f00f42
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,45 @@
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

