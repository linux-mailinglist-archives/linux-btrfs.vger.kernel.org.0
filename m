Return-Path: <linux-btrfs+bounces-2347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B066852AE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 09:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADA8282219
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4585225B2;
	Tue, 13 Feb 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HyH7PSss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1413224E8;
	Tue, 13 Feb 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812445; cv=none; b=d4D5KbY2gGIa9Ft5zDZgME4SRfPZJfSbw2OLKAKLQwIno8FbvGPj4tvzxk1lNxOjeiFTQdL4I3ILd93q/t/Rhl2gXqrVOXK7zCZ8V01vNpVbDE6WzqnNe+tkMMMH4YqbW2obEB2u7U7f3u+35O5LLXp0zXLbBGOzGuN6b3rCQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812445; c=relaxed/simple;
	bh=RV2GNgHGtHQL4J3p7GYFaEobWNY0esM34yRKamfJ4C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyxKhT6DXKuQ8hm49GZlLdL0nqKL0Bmm0/bJ6gVm37YhuMbORDbXR0OG/BWTv0Dg/Mxj5MOx4pp3p+3uJUcSJYlTSSBRbNo465NWoNxN8j56oy3zAGg0zVisCNiF0yZq+5ZE3Few77GG1poHZTLyto5PCjyn2cENDdZYOJ++v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HyH7PSss; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707812444; x=1739348444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RV2GNgHGtHQL4J3p7GYFaEobWNY0esM34yRKamfJ4C4=;
  b=HyH7PSssO9D6IIEml+QMl+WMJvKQ1O0osOPzzntZTgCbWVBN0G5Al6qA
   zxLKudv8vMiK+pXpUW470zT/WwvbTC2DevqMCLZ2z8RLi38ve6Zj0rC2A
   IiXF1YCdTiWMk6W5m0n4S9BwrW+aOX+0PKn8Ajqr0Tb+JRZNJAzYRP2Ik
   1BnZ3xO23B56xCTdUSUmEc4/jxwmkH7oDXyNwV6/hAA5i6RFd/dOx+DM4
   OQwX2puPmLFrx1kT9Pbb+bb6wT7rdCqLm3t3XlRGjIcdhDO5DAgilh/Kt
   WOm1pGVF4+FzRPwIkkfc8SftCrXhHyrsvEgNg6HcDIQ2/C4WBrEvPFrkN
   w==;
X-CSE-ConnectionGUID: XBopsPDrRriSzJgOMxcpIA==
X-CSE-MsgGUID: qPjEmcZdScKdr0I1of9ASQ==
X-IronPort-AV: E=Sophos;i="6.06,156,1705334400"; 
   d="scan'208";a="9701339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2024 16:20:36 +0800
IronPort-SDR: /uy2n7120SAAZR9JYELELH5u592KYuD6w3j/oeYjngBod681HdbasdS/0z1YnYj/HBVe8FKZog
 y6R6nC5EggmA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 23:30:13 -0800
IronPort-SDR: gbXKhXrkW0V6vW1wLAdspcHYp01xsmFkwlvuZxEQhua6VC3e+xeRfhLKMLXtPw/b30vSuSIo8F
 mQYB/JUZTycw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2024 00:20:35 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: btrfs: check conversion of zoned fileystems
Date: Tue, 13 Feb 2024 00:20:31 -0800
Message-ID: <20240213082031.1943895-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/310     | 75 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out | 12 ++++++++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 00000000..6b0846f0
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,75 @@
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
+	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
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
+$BTRFS_UTIL_PROG balance start -dconvert=raid1 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
+
+# Convert FS to data RAID0, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=raid0 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_add
+
+# Convert FS to data RAID5, must fail
+$BTRFS_UTIL_PROG balance start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
+
+# Add device
+$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_add
+
+# Convert FS to data RAID10, must fail
+$BTRFS_UTIL_PROG balance start -dconvert=raid10 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
+
+# Convert FS to data RAID6, must fail
+$BTRFS_UTIL_PROG balance start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 00000000..bc06b29e
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
2.35.3


