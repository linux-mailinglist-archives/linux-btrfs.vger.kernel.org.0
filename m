Return-Path: <linux-btrfs+bounces-16770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCEB50CFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4D71884836
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A02BE7A1;
	Wed, 10 Sep 2025 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X2JXd0gA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07A26E158
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480678; cv=none; b=VMf3CXQa4QVQdhYPgGxfB35TwDCTucK+lRLYmqwAnkhD7pYyt/Fw3vIMYFz82iIzQS5F0CdINuVxALFudkhrZ7wNPDe4s2Z2pP19zWDngxR1zW+cgk98TVFbHKwRFSeNtfEPHm5T/cPk+M7ICF+eMNBWryD9O9k/0r4mHH2jOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480678; c=relaxed/simple;
	bh=26UEBhEEckA4g8mK15oJe37zfCgSucg4E/C1JPtLAts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2cUTvT2oTeNm9LIdiaTvtnyDHJfJGiYb6YNOpfl1PcQc49xbmMSGfRMxtHn+lVwrF5nApBXYbdFkSwFJs4D+CVxZr4DzGdt2LF4XFgTtA3Bas4iHPsBsnp1LJ1+1ykRSxXq/YzZyPmqoZzt3Lnv/ux8hA1YIpVH/PQ53WPIGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X2JXd0gA; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757480676; x=1789016676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26UEBhEEckA4g8mK15oJe37zfCgSucg4E/C1JPtLAts=;
  b=X2JXd0gA8Meg4TrdRgHdzK/nv5sSzq4rnqDaiGdRsq4PbX4Zljsu6lA4
   +4kEN9pA6icoe/Y4w+76eoDwD47haE2WaJdN4sQz8ATV86QhYHi5hR2GT
   tH+hMY3Lg0iC6cUfICcrStZeniFOEhp3pYBBqiRhEXC5Z/1a+dg7J6I8g
   l5O18WsnBQl9GV02WfzgpPTSy77EX76/+DUG41NLyEi7Bjn15j12VtK2d
   X0q6hiMGuGf5zQtMLAHl39ZAH7839LX51jgOonUMFnzih5dbO1dW47eUq
   ADC/yo+lnEIK50eJen3R4pwgjvDciwC0xo8yRgx4IyyQde6tg9TxvjJTI
   g==;
X-CSE-ConnectionGUID: ZcmdYKwYQHelx2h3W/UaTA==
X-CSE-MsgGUID: EZAi6/PtQmSoDg0HF6cd0w==
X-IronPort-AV: E=Sophos;i="6.18,253,1751212800"; 
   d="scan'208";a="114170377"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 13:04:36 +0800
IronPort-SDR: 68c106e4_C/kjmL0oMhW+Q1qddo+DwhbLGNN0Ouh6gKtLiEbCi8k19vT
 j2OWOR7CKI0BGAcQJIZvHmatpEevlmAWWKv+znQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 22:04:37 -0700
WDCIronportException: Internal
Received: from wdap-vuijzzqtlv.ad.shared (HELO naota-xeon) ([10.224.173.18])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 22:04:35 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 4/4] btrfs-progs: tests: add new mkfs test for zoned device
Date: Wed, 10 Sep 2025 14:04:12 +0900
Message-ID: <20250910050412.2138579-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910050412.2138579-1-naohiro.aota@wdc.com>
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/039-zoned-profiles/test.sh | 98 +++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100755 tests/mkfs-tests/039-zoned-profiles/test.sh

diff --git a/tests/mkfs-tests/039-zoned-profiles/test.sh b/tests/mkfs-tests/039-zoned-profiles/test.sh
new file mode 100755
index 000000000000..2592eb6f9a93
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
+	wait_for_nullbdevs
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
+	test_do_mkfs "$@" "${nullb_devs[@]}"
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
+if _test_config "EXPERIMENTAL" && [ -f "/sys/fs/btrfs/features/raid_stripe_tree" ]; then
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
+		test_do_mkfs -d raid1c3 -m raid1c3 "${nullb_devs[@]}"
+		test_do_mkfs -d raid1c4 -m raid1c4 "${nullb_devs[@]}"
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


