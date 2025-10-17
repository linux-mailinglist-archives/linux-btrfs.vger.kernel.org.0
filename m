Return-Path: <linux-btrfs+bounces-17918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63BBE67B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 07:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024123AEABB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259730F55B;
	Fri, 17 Oct 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L1dLEv0n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27830BB84;
	Fri, 17 Oct 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680228; cv=none; b=o6K5dx2TRuruePDsWarwITeKTMcHWaVWqLT6h5UwLJV7nDe7iCgat+8gFLgDcLyLAZ8uX82bnPzCOMbm1a8riH7uGdo3F5hrZYRajhu9hPJS+CZAaIrt2oCaQWrTglO17ihtKcCtDywiB0SNDCMdTxRAF1921ERX7U+DgwDDiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680228; c=relaxed/simple;
	bh=1J+GbIw8yOzE4JVT0wixRNMzS3FfXkeAGtgOeg8wPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HELPXfYcFSqsTXced1EVAfMCC4cWTRoXktF8bFP1V/aYxXQ6hRy/0rcf89egvnDV/9JVUfu7kiP0D+7VnaOIc5omVtpSkxCZWKE5oY+axL/ryS4A8ErQSTDBf6aVVJNb2DAtegypBjIY2fU1UCfiJkFBKu4MczM2BfKDEb5ie0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L1dLEv0n; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760680227; x=1792216227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1J+GbIw8yOzE4JVT0wixRNMzS3FfXkeAGtgOeg8wPBQ=;
  b=L1dLEv0n9QNiWF1HyC/8npfhWxfziHnIj9sW/oa8CbIhxL/+0UAdBCHu
   8m2pZIXLAHi4utthe1GoSTxOJ0h/d9THAjVqQwo3sB+4SzMmPhdafY/GI
   bfJMWByV/xHcZ3oMste8vu1HQLd7JWFruf3aQH6gQMaz1Um/wAQRYWcfD
   RAgTTRgHUZVoV5bsEEbnMlZe02eZ1LvgUD1aeAivAYNhKLry71i8WBYRr
   vNoZl/kg5EVke1zxzqlKD3APl2Yt3dJ2NHZvY+dquSoZEnJZi7x1grQbb
   EUA8eFWYaRpHsrAGRJU6hnHa9M97bpHPhf9w/S0uSJvbPQ/r8rJGLbyBl
   w==;
X-CSE-ConnectionGUID: 0LDw60ycT5SE1etU/CC0Bg==
X-CSE-MsgGUID: 5PoFZup7Qwupif7pOrgnvg==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134338865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 13:50:27 +0800
IronPort-SDR: 68f1d922_0yWWAkC2gh7feEIam1l2E3xbFyNgET6T0qnCf58PM7floTQ
 VDKB3SBPtvXGza+otXJPAWDH3Sa/r5zl4xT2crg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 22:50:26 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 22:50:23 -0700
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
Subject: [PATCH v6 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Fri, 17 Oct 2025 07:50:08 +0200
Message-ID: <20251017055008.672621-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
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
index 00000000..c2bb25ba
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


