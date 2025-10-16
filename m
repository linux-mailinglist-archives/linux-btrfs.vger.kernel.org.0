Return-Path: <linux-btrfs+bounces-17893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 912DDBE4335
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A1754384A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC5346A01;
	Thu, 16 Oct 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f++xuX29"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E8345724;
	Thu, 16 Oct 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628057; cv=none; b=mngBOsWUPs/6OhnOZZiyuYK3BEU7H5Jpn2PPsLZWnm1hzG4oQW/1mwtd+u1DpRahscVbnKvlO+zbJIiWLO1moClMFHqaR+pQbOUeFVHZws+o/ML+nF/6kslMpKCiBuuMr3RCkhPRsWHHqI6QzAPpJzAWOQGQjBQe804rQh5iBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628057; c=relaxed/simple;
	bh=Spxm2IdFeyRwRDXCfXtCz76Bi/95yV5GtobCAYpubeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCMzIkaka3WKEKxbuNvd4ccWlteGp0s+EokbQw+saC+DVKpiHQ/BBcQm4UzQ3bZnwkinYB9abwZSKbnHeZDzbwJDeEwMZNDdfMlFGDRoiEtdGIsyRMD1W4dIuU0wy3ImWTpio4Y0bKSm02e/PwjZYCwCslZUCT23PLTdeotPy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f++xuX29; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760628056; x=1792164056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Spxm2IdFeyRwRDXCfXtCz76Bi/95yV5GtobCAYpubeg=;
  b=f++xuX292TeAaIAvftLSa/9exDhNms+Ishq1qAdnLE4se9squBzPNTl8
   FUs/2Iq0T6sTIL34x/weHwzZAo0uNLpCrw7XiHstTgxpzUlHGNzqfE0EI
   NGphmDCyp6uqWMq2VnQJSkgi2U1xGN6Knya0edhAflD0UwNqdm9N3RnkK
   a2C++0w7eF+59kIeB61kcmi15ew4N1SmRkzf2MyDwTMPQsfgp4jlUer/l
   AfwcIALF13jsGgGcumsD32qJTPOlk7KVcBhY9bl6GYlioch9oSPV/r4GU
   NaMa3H4J5hclw3iewHlkAs3y2zHOBwWCOXXTmW7HkO59E8/8lBr09TyoV
   g==;
X-CSE-ConnectionGUID: SPAK2VxBSPGZVH5riM8DQQ==
X-CSE-MsgGUID: b4Pu9u4/QAO+lLP/AOoRkg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="133354094"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:20:55 +0800
IronPort-SDR: 68f10d57_mWSCbB5lhq9sov6qhJntgYsH/l6mRoe7v62QOAJBRRzZFdH
 MbpLcA8SYN6IpQyoFCLFbNqL9fcjVvlQgBqb6cQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 08:20:55 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.40])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 08:20:48 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Thu, 16 Oct 2025 17:20:32 +0200
Message-ID: <20251016152032.654284-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
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

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/772     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..10d2556b
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,43 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 772
+#
+# Smoke test for FSes with ZBD support on zloop
+#
+. ./common/preamble
+. ./common/zoned
+
+_begin_fstest auto zone quick
+
+_cleanup()
+{
+	_destroy_zloop $zloop
+}
+
+# Modify as appropriate.
+_require_scratch
+_require_scratch_size $((16 * 1024 * 1024)) #kB
+_require_zloop
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+mnt="$SCRATCH_MNT/mnt"
+zloopdir="$SCRATCH_MNT/zloop"
+
+mkdir -p $mnt
+zloop=$(_create_zloop $zloopdir 256 2)
+
+_try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
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


