Return-Path: <linux-btrfs+bounces-17770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D8BD8426
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD1427B16
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE562E2EF8;
	Tue, 14 Oct 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e2G2Q6aR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D92DFF12;
	Tue, 14 Oct 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431604; cv=none; b=u9KOL+Qawxc2AdOPAXlTcDwc8jI51n1kfKGQBt/8Occ78fGuSDXoxoZmSCZt8msDuj4/q+A+OecOficjISAJ61TAo7OKAJHpQnmkRW+FSPfw2sbaRl60N6K2PZpSwEnavYH59MeaLZ/Ot6ZNN/Ad5z5VrmN4BnuTw6fjvqEFsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431604; c=relaxed/simple;
	bh=OUprkFyyb8Jpajmlt2a3SCwzswy5WmljINCw/SKPmBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APp5sla8gLeXyJes0PElCCaTt2BdrlM7dEKP0jMh5Pw+mYGzwaNAIZef+Jp7QH/U4VTGEMXB1QKlnB4opA5CzIz/OMczlNCAJFkzGkwr56bms136yNK6vxwIaOg4G3RH3PbEOZGfVTP5jDZ1jY+MgEPckX2AmWGcThAueK8mVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e2G2Q6aR; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760431602; x=1791967602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUprkFyyb8Jpajmlt2a3SCwzswy5WmljINCw/SKPmBI=;
  b=e2G2Q6aR7dYPuthSjUJdX7HHB92IX4+Sa14OUYmwoQ55pMc8LJA+zBiu
   dhQ1rE3N43/c0qBdNKvWsQ6Qbbpph8/t/gWzGcaKO58uUi6/WohadFcSE
   rOn2Gvt3/ZApoEGfBJLOw8y8dTD/7upq/qH+dwWqBVNhKT/QVtxmk98DG
   I0DgP9OMVZja7VJJAAY6GHraHUkmffcbqJcgE2nH9u08WOI0vtUQBBxil
   KrkqzDtylYgUOsdolCjXu/nsgnJ3hlY/2eIQLUgMMY1YL9NIqGTFSyzq/
   vs5+qGe6OgilkPcwd1UiDYfex1Pb0TfUbzQmcqw8aMNAUE70iWYAApDGJ
   w==;
X-CSE-ConnectionGUID: XGmrWzOeQBuGzyGQvYzPgg==
X-CSE-MsgGUID: cs6Lbu2YT+mSiMlmIlh0xQ==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="130180120"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 16:46:42 +0800
IronPort-SDR: 68ee0df2_yVL+OcS702Ea6Ui4PQEp/T/FwVxnGloi6IgzG0qUgwPfj4I
 NxiAQaYT80POU9yxS8633jHqKrRT1ldDTwTYBsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 01:46:42 -0700
WDCIronportException: Internal
Received: from wdap-pnj1f24hc3.ad.shared (HELO neo.fritz.box) ([10.224.28.28])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2025 01:46:39 -0700
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
Subject: [PATCH v4 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Tue, 14 Oct 2025 10:46:25 +0200
Message-ID: <20251014084625.422974-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
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
 tests/generic/772     | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..d2c982c8
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,46 @@
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
+	if test -b "$zloop"; then
+		ID=$(echo $zloop | grep -oE '[0-9]+$')
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
+mnt="$SCRATCH_MNT/mnt"
+zloopdir="$SCRATCH_MNT/zloop"
+
+mkdir -p $mnt
+zloop=$(_create_zloop $zloopdir 256 2)
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


