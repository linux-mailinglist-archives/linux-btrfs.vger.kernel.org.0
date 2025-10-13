Return-Path: <linux-btrfs+bounces-17679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C2BD1EEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA503C1F62
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D62EC08A;
	Mon, 13 Oct 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LQLJOBDk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EE2EBDE5;
	Mon, 13 Oct 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342899; cv=none; b=faS1vjt5D2TaeYQeBpj1ucVXb/+0+Dp6uD5Qu1dJmMvcqvI64O+UP5of417nL6jRADvCwUE9YKWRt0KHamAir5t43ua/QZl0udbuxWyjgE/skvos9bsGcsIKSLnI0m4Z7ra/cowcXVTpv+0EI33bbxq9YJrtBETW3sZwB6O8d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342899; c=relaxed/simple;
	bh=TxrezenWAuD7QSMm73w8F0dIYBfE0lUIx9nYBctR2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4bGDezLQHEIsbrUYg47ciCqiwEo9mN8FgnnHuJCcQAbtzq8c1pgb6XAlE23nf/Slv94bHCL9UBQljc2cMycF/lw+4ozHkvL55O494gc3cWn/hmPVALU1GMYkjRZ9t3EB33L1rID/lz9GedMNGggXs6c6OPXKdQy8stpQKxrX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LQLJOBDk; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760342897; x=1791878897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxrezenWAuD7QSMm73w8F0dIYBfE0lUIx9nYBctR2x0=;
  b=LQLJOBDkydZu+/5oYE2Gz8lff1U18jpfFLV+LT/f3fNNHtGhqFLvFSif
   /bhtYwMR8k/gI/lhSTzawTBOgDuMZQMZj8pVJs3fMeNM5Y6tM3n1ZFxky
   sLysJ1wXvVa1QiPfSWbyWZvgKAnQnPq5rUbXeg4F+P7VKuehAHe7nT3/Q
   X1Wqx+TJNmzbiaNMcszYKnFBR3q+OyrdLZ61IJnuzlkpJYArt5MxKf73R
   pv2QLCwl1bU6/LZD8mt3SY/80UyXetxQh/Iuo6U9g6eg5+fIHmJwLwepa
   AzJxgVArPqCzMt5DmsTfhieZ6OMDHkXzVy7ZQwS+PLOp8i0BV8VFAoKB2
   g==;
X-CSE-ConnectionGUID: Ui4M9CBRRMWEFozexVvMcg==
X-CSE-MsgGUID: 6ylRzrbITkK+QlubD+EzRw==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="133101999"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:08:16 +0800
IronPort-SDR: 68ecb371_ug2x6MVRub/qtVo+rSl63BpiKAtrRD8/IhOFabq7vN0hCzi
 8bIqEH51p6EbWZsoOFeQrAlUxrk/vsozM/Eu70g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2025 01:08:17 -0700
WDCIronportException: Internal
Received: from chnhcln-775.ad.shared (HELO neo.fritz.box) ([10.224.28.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2025 01:08:15 -0700
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
Subject: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned block devices
Date: Mon, 13 Oct 2025 10:07:59 +0200
Message-ID: <20251013080759.295348-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
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
 tests/generic/772     | 49 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..d9b84614
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,49 @@
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
+ID=$(_find_next_zloop)
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


