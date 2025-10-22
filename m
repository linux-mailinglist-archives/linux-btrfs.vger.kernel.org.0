Return-Path: <linux-btrfs+bounces-18162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9671BFB295
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B24C508B31
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2895315D42;
	Wed, 22 Oct 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+c5DiHC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FB3191CF;
	Wed, 22 Oct 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125247; cv=none; b=ibtHCmcIaEOJS+K6+h3nYe+FmOLnUF/3FPpbIFBaN7zcPMuBwTLn+Ooi5WlaxeEmji4K0D0E+dIH1WE9IOHo5BIItS0UaH4rtau2H5yrORzb3HGwryFjXV7IZECmiFjuFZNb4PVbsfWURsUVxOsPITpo603sQ8gsmIzBNZWOe2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125247; c=relaxed/simple;
	bh=UJ7WgDSrO56YuuAiFpac+GAPS0XdspQuJA+hHjmZgP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAtsIaS3+sEPcKKQr5+hxIAJq1UWiIbYJFfTtNhhOp2tnyv4F/3oU265TAVxvLHRtewu14Om5I3bLQyCHoVYt5Ha8aHWTnSmR/4eVWX0f8iLHJoSIHIs4lh8sfB1K/iZJxqagBaxTFYeQgsFmSpgL0jWLO2ILTnqs8EC9YaiOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e+c5DiHC; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761125245; x=1792661245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJ7WgDSrO56YuuAiFpac+GAPS0XdspQuJA+hHjmZgP0=;
  b=e+c5DiHCp7QMbBTQtF4a4I5Rf5QVAN6l+jnhz7Szj44sPBBOeX1DTt8x
   7zAed4dYgEXhE8trKikUE5vwnEdWOYzhYurLE49sjPrNTH6TbApuJfwT+
   Xud72t/rJpogANyw6BQd2S7OwRVLtld4cODfPgNysLpYJ2n28ZOeDTtli
   lQHymofFPPZJNLDXZvJST4hTfidiF33ZOZUjkOBufFh+bhsZkIpxtXx9D
   /qF10hlJNmDPfYhBqp7zsJoEt1QKSXR8CBbyCYq3RyoxLxbfGEpQ7muH9
   rnBPZ+84uhmHg71wCan+p5/+7p2MhVH42ur+w3M8dYneBaEth+mqsf6bw
   w==;
X-CSE-ConnectionGUID: r9bknrZeQg26Unoq1pnClA==
X-CSE-MsgGUID: B64w/X/sSyqJIvVc/jbLhA==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="133356607"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 17:27:24 +0800
IronPort-SDR: 68f8a37c_T2FoykO3MEYOe5brwoSVXV0bwpr+21Dd+Hmkeo/lfPaV9IN
 du9w4PU57QLMRKLdUJS3M/XqA3Y4aNyHxODEeAQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:27:25 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.49])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Oct 2025 02:27:20 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Anand Jain <asj@kernel.org>
Subject: [PATCH v7 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Wed, 22 Oct 2025 11:27:07 +0200
Message-ID: <20251022092707.196710-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
References: <20251022092707.196710-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <asj@kernel.org>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/772     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..f9840cba
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
+_require_scratch_size $((16 * 1024 * 1024)) #kB
+_require_block_device $SCRATCH_DEV
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


