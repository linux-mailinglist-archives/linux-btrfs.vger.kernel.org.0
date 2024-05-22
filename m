Return-Path: <linux-btrfs+bounces-5193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF718CBAF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290F21C216B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFD79B9D;
	Wed, 22 May 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CK/nFD8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC8763FC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357835; cv=none; b=Oe7SbBc6QV88ybtm+sG6CcWIeQ285tsq5ZXB/Otad5ArswUTaUgH48+gORICD6smWJ5KoW8VovXm7NKV2ctnPhena9BLSTGWxH9ldv67ZKapcyQUaMCEXTW8iQOZAzyFEztc9zpJS2noysUDFpkfec830V/DzdVWhnIsTUGWmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357835; c=relaxed/simple;
	bh=0a9Ok1Pil5K+RV1V9LVFBmoQFHRNpWTveGIfvgBVqMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWnAn4K/V2mNLlHXkUdL5RVXeWD3oKpyV85//t2LtxzVlCPq/PEi1ctGOYAezNgal8LN+/Zx3yRw5MKde5jvdWG8f+mAtCpy/xyq5HHBvH+pceL9kBW8fC+pDiVS+bOF9crsF8GgIJ0TR8x8bJTMxzHn6MRjbzYXuKCs54/TA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CK/nFD8I; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357833; x=1747893833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0a9Ok1Pil5K+RV1V9LVFBmoQFHRNpWTveGIfvgBVqMM=;
  b=CK/nFD8IYgGRsn9NQO6uUbdbgUOKuw8OeRWV563cBPdAnz5ksqAv8f+E
   8StLzkHv6nWBBQMcIOkumiigQlHmbeObEsPbiHU4GEWFYqIfCY25wKYTU
   9oYP2kjpmYMFPMJDJqXTkZ0V3wMtBakHCof42WB9B4qmR2IM7tRTti/Ir
   lSz1lNOvcbXFD0bHC2pzcJkcc0cu436TfknDoRUdREdMMXffnVItPAhIR
   RhydYtfPjOpWzjeClaHPvIfX+B5u7qj17NWhD13f/OrJDbbqd9CYFCwRz
   hTqAl3k15I/ga1M/XhB18nbGRww/UnVXBVpaNgAEmEZ6BwhKvCC+W0we5
   Q==;
X-CSE-ConnectionGUID: vu3zCIClSHydGCDNCNHZWg==
X-CSE-MsgGUID: OU0VIRqeTr+mp9B56g6oJw==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170981"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:44 +0800
IronPort-SDR: 664d7d24_dSGirlmfmNbvAkf1rHifrJjhZR2GgNRYiMeP2uEO2+p7u+/
 9GexkRRlojJBrhQZuDNvsbOnfAXm7HbsrHcjssw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:41 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:45 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 08/10] btrfs-progs: test: add test for zone resetting
Date: Wed, 22 May 2024 15:02:30 +0900
Message-ID: <20240522060232.3569226-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
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


