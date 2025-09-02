Return-Path: <linux-btrfs+bounces-16575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849CB3F3CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866AA1A85161
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 04:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FE2DFF33;
	Tue,  2 Sep 2025 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jmd3wh2Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1632D594E
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787415; cv=none; b=JflGLU+LNQfEC9Es1+jNgRfa5oWG46GX1Pk+RJV4TR1J+0be3LcOnGUd6dl4+1su6lqIGeMIMSui6GFsq7vxLpeN6BEUGUTtZHbWvcKMOwvDBjTJkTuurIC5yD+4ZgEDUAaf/13MMV1HXyrKK8wQf01Ol9t8VSSgPnLe7SWPWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787415; c=relaxed/simple;
	bh=LOc/PxYso+xIuy4a8+44e2bIr55HZca+zmJqpgYmrRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJOXjrh7w31stmGk0Fnp3ywA1ZEqa779F0Np8B4TRdhjdoO2LZ8PguNAs2c3DFeUHjb1dlB6RA/2Y8zHrP+CHso2mifvntrnZyq4CoerQ6Fd0BD4/Mjqe+/AXS7jLpz0zuBR3E/7mXxoKvwZQEcNwnmZFGVGrh3ZqoauDELB+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jmd3wh2Q; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756787414; x=1788323414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOc/PxYso+xIuy4a8+44e2bIr55HZca+zmJqpgYmrRY=;
  b=jmd3wh2QkcZ+IsFf2vERcSgtIwAEJ8054hYrO8ilFArdQR4yB7hLeMJb
   rWX3Bp39NG+JbF6UaH7hOC9MgtoxYQkGsNe/3VK5+9pD8YFGPUP+jzOnW
   wDqz/0sqvC0LK8/BWcFgoc+IB66q7GMP7RCawWAj/kmqM0AwdFWHAyNcI
   Wt7dIMXVGCqXi9PeNx/hBhe5scD9DgYbV154tu0TDYVuif5rRx0w6aKCF
   NzuD/qxfijAvyBUoEV/155fRieOGU3cjP0KbLdTYRq/d1ncQoMlu+Tu/V
   P3cgIJTteb7sF+5hTTblLxiQvnXhrW3TxsIefZUaEPz42iKlCY/ApKk9Y
   Q==;
X-CSE-ConnectionGUID: BYc1Kl3rS4a1Pm+vLdwz+w==
X-CSE-MsgGUID: KuhRBtxoSt+K+HSPwc/UnQ==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106426377"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 12:30:12 +0800
IronPort-SDR: 68b672d4_UaCeWVdWpwV9KzTHK9e0MyQSa+E+zXuiboHrjpOWt5LP3Xb
 XVuH4XHAQlgr8d0YzSpWzM0/FPfvFAfXrcqBdRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 21:30:13 -0700
WDCIronportException: Internal
Received: from wdap-uxdzwi0ixx.ad.shared (HELO naota-xeon) ([10.224.163.20])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2025 21:30:13 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned device
Date: Tue,  2 Sep 2025 13:29:20 +0900
Message-ID: <20250902042920.4039355-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042920.4039355-1-naohiro.aota@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new test is based on mkfs-tests/001-basic-profiles, and it goes
through the profiles to mkfs and do some basic checks.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/mkfs-tests/039-zoned-profiles/test.sh | 98 +++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100755 tests/mkfs-tests/039-zoned-profiles/test.sh

diff --git a/tests/mkfs-tests/039-zoned-profiles/test.sh b/tests/mkfs-tests/039-zoned-profiles/test.sh
new file mode 100755
index 000000000000..f40648cd06e1
--- /dev/null
+++ b/tests/mkfs-tests/039-zoned-profiles/test.sh
@@ -0,0 +1,98 @@
+#!/bin/bash
+# test various blockgroup profile combinations, use nullb devices as block
+# devices. This test is based on mkfs-tests/001-basic-profiles.
+
+source "$TEST_TOP/common" || exit
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_global_prereq blkzone
+
+setup_root_helper
+# Create one 128M device with 4M zones, 32 of them
+setup_nullbdevs 4 128 4
+prepare_nullbdevs
+dev1=${nullb_devs[1]}
+
+test_get_info()
+{
+	local tmp_out
+
+	tmp_out=$(_mktemp mkfs-get-info)
+	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
+	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
+
+	# Work around for kernel bug that will treat SINGLE and single
+	# device RAID0 as the same.
+	# Thus kernel may create new SINGLE chunks, causing extra warning
+	# when testing single device RAID0.
+	cond_wait_for_nullbdevs
+	run_check $SUDO_HELPER mount -o ro "$dev1" "$TEST_MNT"
+	run_check_stdout "$TOP/btrfs" filesystem df "$TEST_MNT" > "$tmp_out"
+	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
+		rm -- "$tmp_out"
+		_fail "temporary chunks are not properly cleaned up"
+	fi
+	rm -- "$tmp_out"
+	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
+	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
+	run_check $SUDO_HELPER umount "$TEST_MNT"
+}
+
+test_do_mkfs()
+{
+	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@"
+	if run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev1" | grep -iq warning; then
+		_fail "warnings found in check output"
+	fi
+}
+
+test_mkfs_single()
+{
+	test_do_mkfs "$@" "$dev1"
+	test_get_info
+}
+test_mkfs_multi()
+{
+	test_do_mkfs "$@" ${nullb_devs[@]}
+	test_get_info
+}
+
+test_mkfs_single
+test_mkfs_single  -d  single  -m  single
+test_mkfs_single  -d  single  -m  dup
+
+test_mkfs_multi
+test_mkfs_multi   -d  single  -m  single
+
+if [ -f "/sys/fs/btrfs/features/raid_stripe_tree" ]; then
+	test_mkfs_single  -d  dup     -m  single
+	test_mkfs_single  -d  dup     -m  dup
+
+	test_mkfs_multi   -d  raid0   -m  raid0
+	test_mkfs_multi   -d  raid1   -m  raid1
+	test_mkfs_multi   -d  raid10  -m  raid10
+	# RAID5/6 are not yet supported.
+	# test_mkfs_multi   -d  raid5   -m  raid5
+	# test_mkfs_multi   -d  raid6   -m  raid6
+	test_mkfs_multi   -d  dup     -m  dup
+
+	if [ -f "/sys/fs/btrfs/features/raid1c34" ]; then
+		test_mkfs_multi   -d  raid1c3 -m  raid1c3
+		test_mkfs_multi   -d  raid1c4 -m  raid1c4
+	else
+		_log "skip mount test, missing support for raid1c34"
+		test_do_mkfs -d raid1c3 -m raid1c3 ${nullb_devs[@]}
+		test_do_mkfs -d raid1c4 -m raid1c4 ${nullb_devs[@]}
+	fi
+
+	# Non-standard profile/device combinations
+
+	# Single device raid0, two device raid10 (simple mount works on older kernels too)
+	test_do_mkfs -d raid0 -m raid0 "$dev1"
+	test_get_info
+	test_do_mkfs -d raid10 -m raid10 "${nullb_devs[1]}" "${nullb_devs[2]}"
+	test_get_info
+fi
+
+cleanup_nullbdevs
-- 
2.51.0


