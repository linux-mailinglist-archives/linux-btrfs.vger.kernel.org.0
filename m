Return-Path: <linux-btrfs+bounces-2419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13185625C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AA2B2E435
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1412BEAF;
	Thu, 15 Feb 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rm6FZt1N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAD12B144;
	Thu, 15 Feb 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997635; cv=none; b=J8zDTsOj5lKAsKYZYSvoj7ESSHDfyaUwh2Xn+g7dFbRHahK/N6qthwYDmM4KSQjyvj5ArmHevb8mvNlsyY8gQ7CGLJpV39G128ImKPQCHFY4FlcfCNVnM/8AyBl2LiZiblHxtw1R+vSqli8DDJ7uDql9qc7ju7jjkmps7JJkAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997635; c=relaxed/simple;
	bh=S+7EbsEyEm/QpVUEhRGu6+et5IyHnqN/50jaPSCcAMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Prw5cNkKl/fg8+eiYlgTqPz+G5aRHOD03VH+kEhE585TV9jTVM3tjpc05pJuI0vfPgpLb9msyT9eLy+E54mqv9KF+8CwOiGbuld3bAmauNOapkt4ZuT+jbOTk+KItsxen/GvPhvgYNdp53ORBcYFNWl+e8rcclzYI68AjBKP9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rm6FZt1N; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707997633; x=1739533633;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=S+7EbsEyEm/QpVUEhRGu6+et5IyHnqN/50jaPSCcAMs=;
  b=rm6FZt1NTxur8Z5Kz0Zi2xeEOpIwtF5ach/7DOPPvw67ykDQqaJyfzSx
   jzolD45x2iz5vJpUSaV2HhaLLu6JHfVtTxd2IuKVGUl+TRXySRUqo6OZk
   jBmSCO1P97TXsLjvk+V97e7EU3pO/03Vm2NYsRQHHK4Dcu2uAQ9RlWUER
   mm+EONPYxDoKS/v1D7D4lWWDbB6/00w+x83F0iCCN+NMl5PgPwbbCaNxo
   f3tQQIMCrqlrD6Ow0q5afycu8vb/TEcW6mUI5AIB+cUgAbhlmNnW9TJFE
   1lLbUFY/opTxvZFYDQeDWamMW/ZGmB7dQjcYwpSyk/KKlJe+01T/XRvKq
   A==;
X-CSE-ConnectionGUID: w82ys33XReaa4pWK9F+hEw==
X-CSE-MsgGUID: 5gfgWBfPS3yb+YbNPkJTpQ==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="8967201"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 19:47:12 +0800
IronPort-SDR: Pf+NC5xCZ2D73xArsp6B9kjsmgTqZUdZGFer1A4SN3eR9gtDRd8kxWE5w2GyP91IzrdZIWy1Gl
 co1YGWBg2yTA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:56:46 -0800
IronPort-SDR: 88AxqHl70/Lg0dx19tj2AaED0JikQJA+I1fOYxatWiWdSBNr+GyxIYWEVQoAMH8m5pULj+7IoU
 flFB5ElznpXQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Feb 2024 03:47:11 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 15 Feb 2024 03:47:06 -0800
Subject: [PATCH v3 3/3] fstests: btrfs: check conversion of zoned
 fileystems
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
In-Reply-To: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, fdmanana@suse.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707997627; l=3493;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=S+7EbsEyEm/QpVUEhRGu6+et5IyHnqN/50jaPSCcAMs=;
 b=ojl1bD+HbpHb+0eCrmZHDkEMONAgnYfp25WCHBLqk6/1jf567FgHNn3Y482RfoU4uTmOeAs69
 AEmyPQsNj/FCMR4KH8xpk2ExfOA8PfLIEtZqMRpSuwMOWMYMrWJrLb5
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Recently we had a bug where a zoned filesystem could be converted to a
higher data redundancy profile than supported.

Add a test-case to check the conversion on zoned filesystems.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out | 12 ++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 000000000000..c39f60168f8a
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 310
+#
+# Test that btrfs convert can ony be run to convert to supported profiles on a
+# zoned filesystem
+#
+. ./common/preamble
+_begin_fstest volume raid convert
+
+_fixed_by_kernel_commit XXXXXXXXXX \
+	"btrfs: zoned: don't skip block group profile checks on conv zones"
+
+. common/filter.btrfs
+
+_supported_fs btrfs
+_require_scratch_dev_pool 4
+_require_zoned_device "$SCRATCH_DEV"
+
+devs=( $SCRATCH_DEV_POOL )
+
+# Create and mount single device FS
+_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null
+_scratch_mount
+
+# Convert FS to metadata/system DUP
+_run_btrfs_balance_start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert
+
+# Convert FS to data DUP, must fail
+_run_btrfs_balance_start -dconvert=dup $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID1, must fail
+_run_btrfs_balance_start -dconvert=raid1 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Convert FS to data RAID0, must fail
+_run_btrfs_balance_start -dconvert=raid0 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID5, must fail
+_run_btrfs_balance_start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_device_add
+
+# Convert FS to data RAID10, must fail
+_run_btrfs_balance_start -dconvert=raid10 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# Convert FS to data RAID6, must fail
+_run_btrfs_balance_start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 |\
+	_filter_balance_convert | head -1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 000000000000..bc06b29ecf10
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,12 @@
+QA output created by 310
+Done, had to relocate X out of X chunks
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument

-- 
2.43.0


