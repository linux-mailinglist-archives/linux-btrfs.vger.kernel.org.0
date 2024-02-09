Return-Path: <linux-btrfs+bounces-2277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131A84F4D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 12:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C67F1C2160A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38122E84A;
	Fri,  9 Feb 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PizZnc9m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353A4689;
	Fri,  9 Feb 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479467; cv=none; b=eEQZHSUEDzeIkshCDB6qIpZEFDDjwEfAtYYfhO+x6KNrSCh03wtiJPmBAh1gonSlz20JM4m/gcA8J7ybldSUBl9kE7ZpfK8RPhk6S1zLvEdA2/CRFYjmrtoMUdHGTd5TSNlTAqKPcW+Wkz3y0MFz6O4Gldun5gNbXOFhSwzW+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479467; c=relaxed/simple;
	bh=dR1qcZKW8kQ2XpgdDfLen/+oyRFwit1btOj2tOkV3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQQLzcm60SY3Azl2BgSnWhAZ5e4pp4s+JPBz5HpAOKIooMK6GpVVHOBfDz3MyYueIO6K8+wnk9GIDujQuIrxlxGt1cBUMbxTdBVIYWyIE56ylnKTAT3H/0/B0CitY9pBNShJNtaWG5zTwzqekjzkO6A1Kl7WInG1U260OvE2Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PizZnc9m; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707479464; x=1739015464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dR1qcZKW8kQ2XpgdDfLen/+oyRFwit1btOj2tOkV3k0=;
  b=PizZnc9mdbOJ5qHXXtwwc9MJ6dU5mU2oZnMlMpEbKBLKYbkgnNrAKUz2
   +lnbHUo93kbRSlAmctTsx+MF0bhRWJjp10BNCwvNTp2nDesaKBZ+Z4+4e
   tIf0hlz7YCaL7woT7jBO/RFReF8kVNOG+r/VmWOd62fnp7231IAsvSyf0
   7DNeG0HWh0soC55Ro0pzNwx88GREEkAIIk6ech2Vg8fDtS3G5mNLKIyRU
   z0s7VAPLcxQtFV31nZXaeXRSFw83uIsbh1fIgmSwuQKgussYka5MP1G54
   2oAYTpyPa7STSmJpKZ0a/AF76tev8f84E/yPYNOrFQz552eMPpEJJya2J
   Q==;
X-CSE-ConnectionGUID: mnd912y5QpuvVuV1BM1Y6w==
X-CSE-MsgGUID: HxRM7LtjScGkCkK+tXXHjg==
X-IronPort-AV: E=Sophos;i="6.05,256,1701100800"; 
   d="scan'208";a="8891843"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2024 19:51:02 +0800
IronPort-SDR: i7b+onYOmbpojNgwphoZlAaUeYna3Q9CsvKCKV2g0S4gADsqKBW554syv2D8pdwJuewTahjRx+
 W8wpq+zIr24g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 02:55:04 -0800
IronPort-SDR: eFNz4PIIvU/8osVEfkiujrI1vhwvTdv9hWU4oba/TpYB3ZjjIw34Krw5YMe2hClOWn4v8LfswM
 AvCqph6OVyeQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Feb 2024 03:51:02 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: btrfs: check conversion of zoned fileystems
Date: Fri,  9 Feb 2024 03:50:57 -0800
Message-ID: <20240209115057.1918103-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we had a bug where a zoned filesystem could be converted to a
higher data redundancy profile than supported.

Add a test-case to check the conversion on zoned filesystems.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/310     | 75 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out | 31 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 00000000..5a9664d1
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Western Digital Corperation.  All Rights Reserved.
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
+. common/filter
+. common/filter.btrfs
+
+_supported_fs btrfs
+_require_scratch_dev_pool 4
+_require_zoned_device "$SCRATCH_DEV"
+
+
+_filter_convert()
+{
+	_filter_scratch | \
+	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
+}
+
+_filter_add()
+{
+	_filter_scratch | _filter_scratch_pool | \
+  	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
+
+}
+
+devs=( $SCRATCH_DEV_POOL )
+
+# Create and mount single device FS
+_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null
+_scratch_mount
+
+# Convert FS to metadata/system DUP
+$BTRFS_UTIL_PROG balance start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 | _filter_convert
+
+# Convert FS to data DUP, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=dup $SCRATCH_MNT 2>&1 | _filter_convert 
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_add
+
+# Convert FS to data RAID1, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=raid1 $SCRATCH_MNT 2>&1 | _filter_convert
+
+# Convert FS to data RAID0, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=raid0 $SCRATCH_MNT 2>&1 | _filter_convert
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_add
+
+# Convert FS to data RAID5, must fail
+$BTRFS_UTIL_PROG balance start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 | _filter_convert
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_add
+
+# Convert FS to data RAID10, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=raid10 $SCRATCH_MNT 2>&1 | _filter_convert
+
+# Convert FS to data RAID6, must fail
+$BTRFS_UTIL_PROG balance start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 | _filter_convert
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 00000000..f1e44af6
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,31 @@
+QA output created by 310
+Done, had to relocate X out of X chunks
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+WARNING:
+
+	RAID5/6 support has known problems and is strongly discouraged
+	to be used besides testing or evaluation. It is recommended that
+	you use one of the other RAID profiles.
+	Safety timeout skipped due to --force
+
+Resetting device zones SCRATCH_DEV (XXX zones) ...
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
+There may be more info in syslog - try dmesg | tail
+WARNING:
+
+	RAID5/6 support has known problems and is strongly discouraged
+	to be used besides testing or evaluation. It is recommended that
+	you use one of the other RAID profiles.
+	Safety timeout skipped due to --force
+
-- 
2.35.3


