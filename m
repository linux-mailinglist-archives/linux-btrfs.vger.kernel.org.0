Return-Path: <linux-btrfs+bounces-21598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E3nNHESi2nSPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21598-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:11:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAB11A027
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7563033F9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9636075A;
	Tue, 10 Feb 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MWNGdJ7m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6A3164D7;
	Tue, 10 Feb 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721884; cv=none; b=tV1A/kl8OzapWTG2DWJ7IF+fegTAwykqRRQ+hitHSu5MggC/9z/P5BbIt9ilnBat3CWgrtKyf5kD3bz1lH8Ny1NcrmZeK4kTtjpqpZD1EpmgP/6BMi+7MKdiPzSbuq276y5T8WpPA2lG+lyMMGVnEyfCiikQgepXMoWm44LK7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721884; c=relaxed/simple;
	bh=Oqk/dNM0gIHjCF+IO7D0gR4dl8qjOkNyhni+rAh9W+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t53RgJxhpm3ap3X4s8JHOK6Kyjj/Xaw+CFIIvSYenceIDwvZ3JKgg6o9TRKvzkY+ph59/o8Sk1Leo7q2cKbG8UU4MY4qO4lzX+VCtCY1tcBARFwR2boCr4auELYerD2DKcdWdwwH7FzK81PDAM1FpZF5tHyC0jAmuMLAlC41ZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MWNGdJ7m; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770721883; x=1802257883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oqk/dNM0gIHjCF+IO7D0gR4dl8qjOkNyhni+rAh9W+w=;
  b=MWNGdJ7m+Ga6tWrdabVc23puuqs9uilQvp+gug4r+yR3FVoSK/VlAri3
   r3kjr4RONPMAASvCGJCvuHH0bK0lK7viyQ2Z7HL9tzyi0CeYD9lMfp5kL
   Cm14QjCB5mQci34s9IOyn/+KhaEDkNnX7kQSe8SKUQMj+/n8NltddaRlN
   JS7u6ie3dS2eky2AOfeYyO0OralPJ1A9G6tBEdBenAHrB9qSQOEP0kj6q
   CzmcpEcXm2jtbrWdNNKpPFsGriozzI01q6nkFX8430+xPJbEcwcvfKras
   yzSliD58TaL2LtZnahvOTOjqYVWinmh+WJYJQs2MGIHUNQWCjq5J9yugW
   w==;
X-CSE-ConnectionGUID: TjUhorzOQje/XPHkkOFVpw==
X-CSE-MsgGUID: xIrknjmzSuuKGDlT9U6L5w==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="140451175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 19:11:16 +0800
IronPort-SDR: 698b1255_JtKQfmfHWGfvDURBzk9VpW5MDRr/RAnzzK8fkXdjmQ72DgF
 Zj3EWNPUGYuBDDOCTPflF/sEGv/iir24d3Dc4KQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 03:11:17 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2026 03:11:14 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: test premature ENOSPC in zoned garbage collection
Date: Tue, 10 Feb 2026 12:11:03 +0100
Message-ID: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21598-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[wdc.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 39DAB11A027
X-Rspamd-Action: no action

This test stresses garbage collection in zoned file systems by
constantly overwriting the same file. It is inspired by a reproducer for
a btrfs bugifx.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/783     | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/783.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/generic/783
 create mode 100644 tests/generic/783.out

diff --git a/tests/generic/783 b/tests/generic/783
new file mode 100755
index 000000000000..f996d78803a1
--- /dev/null
+++ b/tests/generic/783
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 783
+#
+# This test stresses garbage collection in zoned file systems by constantly
+# overwriting the same file. It is inspired by a reproducer for a btrfs bugifx.
+
+. ./common/preamble
+_begin_fstest auto quick zone
+
+. ./common/filter
+
+_require_scratch_size $((16 * 1024 * 1024))
+_require_zoned_device "$SCRATCH_DEV"
+
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
+if [ "$FSTYP" = btrfs ]; then
+	_fixed_by_kernel_commit XXXXXXXXXXXX \
+		"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
+	_fixed_by_kernel_commit XXXXXXXXXXXX \
+		"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
+	_fixed_by_kernel_commit XXXXXXXXXXXX \
+		"btrfs: zoned: add zone reclaim flush state for DATA space_info"
+fi
+
+_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
+_scratch_mount
+
+blocks="$(df -TB 1G $SCRATCH_DEV |\
+	$AWK_PROG -v fstyp="$FSTYP" 'match($2, fstyp) {print $3}')"
+
+loops=$(echo "$blocks * 4 - 2" | bc)
+
+for (( i = 0; i < $loops; i++)); do
+	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none 2>&1
+	if [ $? -ne 0 ]; then
+		_fail "Failed writing on iteration $i"
+	fi
+done
+
+echo "Silence is golden"
+# success, all done
+_exit 0
diff --git a/tests/generic/783.out b/tests/generic/783.out
new file mode 100644
index 000000000000..2522395956d4
--- /dev/null
+++ b/tests/generic/783.out
@@ -0,0 +1,2 @@
+QA output created by 783
+Silence is golden
-- 
2.53.0


