Return-Path: <linux-btrfs+bounces-5345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B38D2DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6761B24E88
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55883167DAC;
	Wed, 29 May 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oOUSMvQn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390616728D
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966824; cv=none; b=T467tecOlYXj3qQLXYMy3istVBRL+kOoHqPgHzoZUufxOSDM78geZdmRHyTW5MaG/Lbs8anAr39Ub0A2wFxPjWReSPJ86xH9GM5XoDyHRakm6kTo9tbcPr+NxjAw74NTfX3uxGkANsIiLNEeseAcOUtMNAHiBuTDBiytWrjm3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966824; c=relaxed/simple;
	bh=fLsf/3m9l3+ERd408z8DH/bzykNNhkf2WOKkiQdOidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJzmFF1AajXEu7uv784Tw9/n7r/wjzTEo1+TM4CbLoZpMm/E26+KUSO15Yo0DKjB/eimKX17HYiFZnVIJHC9KRwByhue8SfdmABjsf3XrlOFN9v8zXftRuqqEV0//cu8Q0kb22VACkk+Si04epJxZux2Hmlt5W1sMZDPbC6w1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oOUSMvQn; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966822; x=1748502822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fLsf/3m9l3+ERd408z8DH/bzykNNhkf2WOKkiQdOidw=;
  b=oOUSMvQnkwVP4z/n+zg9pq3f+1SNqm3N1sFU8BQkf7+/x7AHeN+yM1Bv
   vX6KiWwwEm3XlkjQ4xFL2Tdox93RCwVPehmEFqWjM4M9ccvvb3k9PBNHE
   8PRRzWWszT8VALD5/uTmcftodteZwtGBAGe4LQCnoaSR+i0Ki2ZGY4xXV
   UgwMFCZO2/YDfntY9wd/ja6l2mhkrFPRhiUJsCG3BiB5fdreEeB90tnnc
   OGu8IevfbwpbnehNBmbng//nBrGN5P9IhviywnVldPB8pF/rNik1EWzsE
   4TY0D4w7GPp3VTnQ26x7bSXU+vweXZV8lBQuoCDe3gte+4Hf8+OsvfF+3
   Q==;
X-CSE-ConnectionGUID: pLUsa7JsTc2lZoIbFt+xHg==
X-CSE-MsgGUID: I5LFWovLR5GKP8RXv4Jyaw==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865350"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:37 +0800
IronPort-SDR: 6656c951_nMxtgf4rQxdVsmB0miL0lQFf4Lrnf1BqKGLQB1KFz1IxeU/
 Efx3UteXjOgT8st1cOS05v0EAJ/VJYNrdFV+/sQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:05 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:36 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 08/10] btrfs-progs: test: add test for zone resetting
Date: Wed, 29 May 2024 16:13:23 +0900
Message-ID: <20240529071325.940910-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test for mkfs.btrfs's zone reset behavior to check if

- it resets all the zones without "-b" option
- it detects an active zone outside of the FS range
- it do not reset a zone outside of the range

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/032-zoned-reset/test.sh | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

diff --git a/tests/mkfs-tests/032-zoned-reset/test.sh b/tests/mkfs-tests/032-zoned-reset/test.sh
new file mode 100755
index 000000000000..2aedb14abb03
--- /dev/null
+++ b/tests/mkfs-tests/032-zoned-reset/test.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# Verify mkfs for zoned devices support block-group-tree feature
+
+source "$TEST_TOP/common" || exit
+
+check_global_prereq blkzone
+setup_root_helper
+# Create one 128M device with 4M zones, 32 of them
+setup_nullbdevs 1 128 4
+
+prepare_nullbdevs
+
+TEST_DEV="${nullb_devs[1]}"
+last_zone_sector=$(( 4 * 31 * 1024 * 1024 / 512 ))
+# Write some data to the last zone
+run_check $SUDO_HELPER dd if=/dev/urandom of="${TEST_DEV}" bs=1M count=4 seek=$(( 4 * 31 ))
+# Use single as it's supported on more kernels
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m single -d single "${TEST_DEV}"
+# Check if the lat zone is empty
+run_check_stdout $SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${TEST_DEV}" | grep -Fq '(em)'
+if [ $? != 0 ]; then
+	_fail "last zone is not empty"
+fi
+
+# Write some data to the last zone
+run_check $SUDO_HELPER dd if=/dev/urandom of="${TEST_DEV}" bs=1M count=1 seek=$(( 4 * 31 ))
+# Create a FS excluding the last zone
+run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m single -d single "${TEST_DEV}"
+if [ $? == 0 ]; then
+	_fail "mkfs.btrfs should detect active zone outside of FS range"
+fi
+
+# Fill the last zone to finish it
+run_check $SUDO_HELPER dd if=/dev/urandom of="${TEST_DEV}" bs=1M count=3 seek=$(( 4 * 31 + 1 ))
+# Create a FS excluding the last zone
+run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m single -d single "${TEST_DEV}"
+# Check if the lat zone is not empty
+run_check_stdout $SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${TEST_DEV}" | grep -Fq '(em)'
+if [ $? == 0 ]; then
+	_fail "last zone is empty"
+fi
+
+cleanup_nullbdevs
-- 
2.45.1


