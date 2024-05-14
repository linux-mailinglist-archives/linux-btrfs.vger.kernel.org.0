Return-Path: <linux-btrfs+bounces-4952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751E8C4AA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11889284670
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC2A94B;
	Tue, 14 May 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SLlAldhy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4F4687
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647932; cv=none; b=GVMA/cstA8CgCC2f/jPTJ57AJeENw4KQOUr66uj74wc3LMf/94RTgRPTcBLnYFW6/ScUhUihnzKUY6a4xW+I16bopeQUelA3e/S3/f0+NhBxMZRTNm/BcSNBxWm1jmJqwercCok2ajmkt14ImrjfeSY4ZOLurElv3P8wA3dgNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647932; c=relaxed/simple;
	bh=mO5apShsF+TsSW1yIfO/kU2e6vCLLScBuhwJP12j/uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cix/44aUgYD5/LS4vAw4Jx1+YefyiWW3/y7WBG1ZWa6/FvJ2DJpXaw4Dzy7yjC1AZXzNA1vF47JNCCgL9CWLG/0UbqNRIjsp5sNc8CH9Fvrnl09HSinOmnc5f+xrf4d7pOAZUH3w6fMU6j82PuPMNOEg35ScNm00iKN9u4Q1V4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SLlAldhy; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647931; x=1747183931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mO5apShsF+TsSW1yIfO/kU2e6vCLLScBuhwJP12j/uo=;
  b=SLlAldhy+nEeTKMUxYgZR2gOCbrMIoAGnck87zZZ0R3qZXHzy2KAwkN5
   sUHHsFA13S8opehLR9dJEKJZS94V+RLWiNIEZaPZ87ZWsIXO+E4+4P50a
   xRuHS4H80JgsNDvaFDIZ0+2Zo8xCIdCfmWRM5Yd2YcY7E2lJ3fPUhbQKD
   KCX3c0wVbNoZrBF+vxTLazscYvvlofrlo8dVbI8qcLzgdOj2nNzRsMSFH
   kxX9K6Q9sgpYGrpatoySui+/GBu+xxOmQc1NqVRg6uzeQPrxm+x6MbFPg
   mhufE5bXq4HtqlJAoZ9RQvx/jzMpR6r2/v+tksKNms+FLdOA62+PkPJDx
   g==;
X-CSE-ConnectionGUID: iJ/iE7wISn+2EbZb+tKtTQ==
X-CSE-MsgGUID: W2X7obgSTayrdc+H8nQbQg==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16252245"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:52:10 +0800
IronPort-SDR: 6642a829_WXyykLXvn82YpOS3ani38TBc7ALN4KFsmZM9cUSQQPghEZQ
 WIz25tuhj5qr3asGkrPoPgP3fJuOf9TSd/keczA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:54:17 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:52:09 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 7/7] btrfs-progs: add test for zone resetting
Date: Mon, 13 May 2024 18:51:33 -0600
Message-ID: <20240514005133.44786-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514005133.44786-1-naohiro.aota@wdc.com>
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
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
- it does not reset a zone outside of the range

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/mkfs-tests/032-zoned-reset/test.sh | 62 ++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh

diff --git a/tests/mkfs-tests/032-zoned-reset/test.sh b/tests/mkfs-tests/032-zoned-reset/test.sh
new file mode 100755
index 000000000000..6a599dd2874f
--- /dev/null
+++ b/tests/mkfs-tests/032-zoned-reset/test.sh
@@ -0,0 +1,62 @@
+#!/bin/bash
+# Verify mkfs for zoned devices support block-group-tree feature
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+prepare_test_dev
+
+nullb="$TEST_TOP/nullb"
+# Create one 128M device with 4M zones, 32 of them
+size=128
+zone=4
+
+run_mayfail $SUDO_HELPER "$nullb" setup
+if [ $? != 0 ]; then
+	_not_run "cannot setup nullb environment for zoned devices"
+fi
+
+# Record any other pre-existing devices in case creation fails
+run_check $SUDO_HELPER "$nullb" ls
+
+# Last line has the name of the device node path
+out=$(run_check_stdout $SUDO_HELPER "$nullb" create -s "$size" -z "$zone")
+if [ $? != 0 ]; then
+	_fail "cannot create nullb zoned device $i"
+fi
+dev=$(echo "$out" | tail -n 1)
+name=$(basename "${dev}")
+
+run_check $SUDO_HELPER "$nullb" ls
+
+TEST_DEV="${dev}"
+last_zone_sector=$(( 4 * 31 * 1024 * 1024 / 512 ))
+# Write some data to the last zone
+run_check $SUDO_HELPER dd if=/dev/urandom of="${dev}" bs=1M count=4 seek=$(( 4 * 31 ))
+# Use single as it's supported on more kernels
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m single -d single "${dev}"
+# Check if the lat zone is empty
+$SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${dev}" | grep -Fq '(em)'
+if [ $? != 0 ]; then
+	_fail "last zone is not empty"
+fi
+
+# Write some data to the last zone
+run_check $SUDO_HELPER dd if=/dev/urandom of="${dev}" bs=1M count=1 seek=$(( 4 * 31 ))
+# Create a FS excluding the last zone
+run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m single -d single "${dev}"
+if [ $? == 0 ]; then
+	_fail "mkfs.btrfs should detect active zone outside of FS range"
+fi
+
+# Fill the last zone to finish it
+run_check $SUDO_HELPER dd if=/dev/urandom of="${dev}" bs=1M count=3 seek=$(( 4 * 31 + 1 ))
+# Create a FS excluding the last zone
+run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m single -d single "${dev}"
+# Check if the lat zone is not empty
+$SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${dev}" | grep -Fq '(em)'
+if [ $? == 0 ]; then
+	_fail "last zone is empty"
+fi
+
+run_check $SUDO_HELPER "$nullb" rm "${name}"
--
2.45.0


