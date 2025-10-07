Return-Path: <linux-btrfs+bounces-17517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE41BC16D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A39F34EBB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8172E0910;
	Tue,  7 Oct 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QLJGLg8Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC02DFA27;
	Tue,  7 Oct 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841898; cv=none; b=g7cNODllaNlDdzDYJmR0VHKp3n264Qn7ZI5aZsi341Jay1BilytS6PFSU6byUT/k/r07GCs8idU0dr3Mk/06ZJ86DoluRy+k5R5xwcftXEQLcSz/QpbXeANJC1dL9YAXjGo5OWhBw/EQ+3MrWsgKqb6MwwtL9IBsI27MEnVQ6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841898; c=relaxed/simple;
	bh=ZDEpkflDT9gu9ziYilCJ12wRSK1iMcTMXXqphV2J7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm5ktoyC6dCxSwzg3NfxpD3WaDE6l0+IAG9vyD1jP3hTyZb9RSuQRLJstom5PDNCe005bHkVIlZUEf1E/aKQTjxISK4a7qgj7S3i0cDydKDgjZ+A8tOuiIHdyGsh7ekx/Jp/mh8uGVD5E5RuuogFDSCWdxRLK0LCN0w2yFezn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QLJGLg8Z; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759841896; x=1791377896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDEpkflDT9gu9ziYilCJ12wRSK1iMcTMXXqphV2J7WI=;
  b=QLJGLg8ZIgqGb/Liam1VJxO3kZDKKbIdJx7tmBuW5uhodR67y/qq5l+O
   Ytew2E03HgRJraZhzfooCqkx2xuU1hRNFsYZ2P9u3ErPuFYtHtFQSJXVT
   kwgAi4gxjuqXgxFAQcup+s75g8n5+CMF49vi2mJEBnI8IUma2JIZhiNFV
   Qmb1/P6zGAXs/q8K+bzhP3tNrovXPNZ6Z6TyskjPv7aNNY0yfQYDlj25A
   KVJK4m3EF/avGMF1gAup9ZYtaH9s8obZKMXST0jqzGS/zmEcGPpy4ybdP
   dfuWXEglrXliYWldFmP2VFiGj+zWbBA4IcKGTz4L6Duns7tS4COJh+06+
   w==;
X-CSE-ConnectionGUID: KSMsU4XJTyKyh5WUzwG+jQ==
X-CSE-MsgGUID: XxUKq67QQfaSoKoS1VR6sw==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132746704"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:58:16 +0800
IronPort-SDR: 68e50e68_8iZBrmi0sU6bEK2US8g550qfomHZdv1EVHgOtFA1TBVOcKi
 w2TCphCxHcAa3FGMAPigkiOYYlkatMqrcwT2aGg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 05:58:16 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.183.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 05:58:14 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Tue,  7 Oct 2025 14:58:03 +0200
Message-ID: <20251007125803.55797-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic smoke test for filesystems that support running on zoned
block devices.

It creates a zloop device with 2 conventional and 62 sequential zones,
mounts it and then runs fsx on it.

Currently this tests supports BTRFS, F2FS and XFS.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/772     | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..403798ff
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,50 @@
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
+mkdir -p "$zloopdir/$ID"
+mkdir -p $mnt
+_create_zloop $ID $zloopdir 256 2
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


