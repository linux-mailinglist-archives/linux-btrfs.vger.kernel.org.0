Return-Path: <linux-btrfs+bounces-17462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AAABBE2EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDD614EC2E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253B2D12EC;
	Mon,  6 Oct 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cM/8bIEJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45542D0C64;
	Mon,  6 Oct 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757182; cv=none; b=jnx7+fcwIRXAUiScwqUvMNG+FKPjvnQdKFN8xvcRnFZRjPXwy81w1HRNVuOaszm8kh3M7h2OCZEcjlFxjsM1CYBgaYRc2qVinzc1EWWM0hJyXhyhynVXN8r5xP2QMC4Z7Pe1qQuv+HLj91OAV/Uu7MUul4WUL3m1HwgYUgXw3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757182; c=relaxed/simple;
	bh=0dFHISE/jOjIkneju0DdqyWKU1iFBYh0kHcEhn2/0FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhDjhWWeZhGWOttO1RyxrbJSAcrqMZpiFhHz7wR5spCDl1X1G0RsnD1pjRN1MEyh4pg0XricWs/EKlClMxEON/DiJCBCSaAKf7yAENUARwHkUch6v2o0TwgykO5yhG8y9AUMEBhxW5ucf+Ca+9lFaicrWsRainD9bIJMgcRmwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cM/8bIEJ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759757180; x=1791293180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dFHISE/jOjIkneju0DdqyWKU1iFBYh0kHcEhn2/0FM=;
  b=cM/8bIEJOdc1jdb6uVsTcd2XNa5LPkZTLmR/So0UEAOEoPPfEMAQ/aVD
   X0MMEO9gbY/OHrBEr+B+D1Iqb9GMUuNDAOY5eWmEjxFsuzjReaCPBtc0Y
   E77OP94vZi95RfFCxyY+410ejvy+4Wq0pEa95F7DybLHP1YDa4jCve4Rg
   3msjJcBFFsqqTIlMuPIjNoSO7mLo5jWZi/AwRLBTQKAvzFDnQLo8Md3AV
   6VKl8RQnGId57ZHuzR378Wsgw6XHGB6Pse0W9oWHeWFZJQivOPwAZvPPJ
   e+Y90UmJ78OG4vj/QZXfLGATNGykoEqzEh5NYDh4INjGsPuH16HKuLWu0
   g==;
X-CSE-ConnectionGUID: ZQAFEqkrTdOT6xFEOgX0Ag==
X-CSE-MsgGUID: kAaJa3/IT9iWYf2x5ffC0w==
X-IronPort-AV: E=Sophos;i="6.18,319,1751212800"; 
   d="scan'208";a="133893178"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2025 21:25:06 +0800
IronPort-SDR: 68e3c332_q7arA5RdkL7uhUwl6rWE83MsLvtdFhJt8MCd3A5I7Sgn7IS
 x+F/XlLh5mI1WzRaMRFBCLLjrBPVMSw/bXFLesw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2025 06:25:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.183.246])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2025 06:25:04 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] generic: basic smoke for filesystems on zoned block devices
Date: Mon,  6 Oct 2025 15:24:55 +0200
Message-ID: <20251006132455.140149-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic smoke test for filesystems that support running on zoned
block devices.

It creates a zloop device with 2 sequential and 62 sequential zones,
mounts it and then runs fsx on it.

Currently this tests supports BTRFS, F2FS and XFS.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/772     | 52 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 54 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..412fd024
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 772
+#
+# Smoke test for FSes with ZBD support on zloop
+#
+. ./common/preamble
+_begin_fstest auto zone quick
+
+_cleanup()
+{
+	if test -b /dev/zloop$ID; then
+		echo "remove id=$ID" > /dev/zloop-control
+	fi
+}
+
+. ./common/zoned
+
+# Modify as appropriate.
+_require_scratch
+_require_scratch_size $((16 * 1024 * 1024)) #kB
+_require_zloop
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
+ID=$((last_id + 1))
+
+mnt="$SCRATCH_MNT/mnt"
+zloopdir="$SCRATCH_MNT/zloop"
+
+zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
+
+mkdir -p "$zloopdir/$ID"
+mkdir -p $mnt
+echo "$zloop_args" > /dev/zloop-control
+zloop="/dev/zloop$ID"
+
+_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
+	_notrun "cannot mkfs zoned filesystem"
+_mount $zloop $mnt
+
+$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
+
+umount $mnt
+
+echo Silence is golden
+# success, all done
+_exit 0
diff --git a/tests/generic/772.out b/tests/generic/772.out
new file mode 100644
index 00000000..98c13968
--- /dev/null
+++ b/tests/generic/772.out
@@ -0,0 +1,2 @@
+QA output created by 772
+Silence is golden
-- 
2.51.0


