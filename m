Return-Path: <linux-btrfs+bounces-1593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C97836029
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0F61F23806
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D83A28B;
	Mon, 22 Jan 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fRNE+9en"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42D846C;
	Mon, 22 Jan 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920966; cv=none; b=PgKotk6o5BzDZ8tq1PcdI8gYcuhyO2eLNVR3vLxx87Hw+QPLNCM4/1ZscBx7JRXHeY8YHA4R3WnNX8Nw11qorowNgmDO0a7Nvy171EWTOMwHng0dpkwADPPNQ5Eiymd1BSOdPSz6a0oPQ0BG6ElyAFutBnWjTCI4V7Xj0VdjawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920966; c=relaxed/simple;
	bh=Ct1BRvI18tj/nrFSKk2O/11pq6mYGA7NQy7getC6X30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXShWJoOHA/FVYje/d1iaQZbbOZL09CIwiH+ZsHnjObEQ8lyoxWxrjDG9Rr9w4cixD2Pei4zhZumVYml7aDOT9HCp1zB/xie8EG6PDl2LaNWxFvFNYl0G99DEcTix/NWjchKkLgEMMQ4iMVcbj2YfJaNNGnyRVxgborZGHPEyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fRNE+9en; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705920965; x=1737456965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ct1BRvI18tj/nrFSKk2O/11pq6mYGA7NQy7getC6X30=;
  b=fRNE+9enS+SHMHDlmXF4xdrctGvXQclXlYfBRASs/6rBnslYbpnSWc2p
   p3GYBIUNMC6ZUP6fs/ORBWzQ0vuTns9skyPot+OtwDH8mk7fYkMJiW68b
   8qFLRAZqL5y5LM6FbaaHmXPf1quKcJIGNfDP2QqBs+eWTerDAKoBYC0tb
   SYGixtzkb9vI43BrsmCA6Hmd0RuokVST50ddry1Nz3QBptC1Z3dvWXCLe
   CzfMRKQvfd5ygNGprZJk12/DbeAFJVhQSpFW27hS8PobyMtARNnc8Z+9J
   kGbw+l1xABb05o6rOX88gqCTLZRGlkIGE/c92ZctdOrMAOsvx8EKgxEJ9
   A==;
X-CSE-ConnectionGUID: v0EsbH2CSP6mix/y0cyKdQ==
X-CSE-MsgGUID: v6LsmTgkSmaoyZYe7XWcJg==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7653431"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 18:55:58 +0800
IronPort-SDR: bLdc3CPMdKBXUxm3LlFcwGrXdjnT8DiyrnGYGwCkHdHVeQ3Sd3NjWZeXMXhYIj4nrX4S3aRnuP
 t4I/qq/xBzaQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 02:00:21 -0800
IronPort-SDR: vINmgkVn0CwLrnLXikRKJW9k7G/lFsiUZrOW9/Zf5ldx0QopspZMiDkj/7Ya0lzJBdSDMWblU0
 ThDTHLOp/d0w==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Jan 2024 02:55:57 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>,
	Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs/zoned: test premature ENOSPC because of reclaim being too slow
Date: Mon, 22 Jan 2024 02:55:54 -0800
Message-ID: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test writing a file of 60% the drive size on a zoned btrfs and then
overwriting the file again.

On fast drives this will cause premature ENOSPC because the reclaim
process isn't triggered fast enough.

The kernel patch for this issue is:
 btrfs: zoned: wake up cleaner sooner if needed

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/310     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 000000000000..6f6f5542f73f
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 310
+#
+# Write a single file with 60% disk size to a zoned btrfs and then overwrite
+# it again. On kernels without the fix this results in ENOSPC.
+#
+# This issue is fixed by the following kernel patch:
+#    btrfs: zoned: wake up cleaner sooner if needed
+
+. ./common/preamble
+_begin_fstest auto enospc rw zone
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_zoned_device "$SCRATCH_DEV"
+
+devsize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/size)
+devsize=$(expr $devsize \* 512)
+filesize=$(expr $devsize \* 60 / 100)
+
+fio_config=$tmp.fio
+
+# Override the default cleanup function.
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+cat >$fio_config <<EOF
+[test]
+filename=$SCRATCH_MNT/test
+readwrite=write
+loops=2
+filesize=$filesize
+EOF
+
+_require_fio $fio_config
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+
+$FIO_PROG $fio_config >> $seqres.full
+
+_scratch_unmount
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 000000000000..7b9eaf78a07a
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,2 @@
+QA output created by 310
+Silence is golden
-- 
2.43.0


