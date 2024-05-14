Return-Path: <linux-btrfs+bounces-4988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5448C5B0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15921F21A2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2C18131A;
	Tue, 14 May 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YKJ78/ei"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBB180A99
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711097; cv=none; b=fyOByrgy4JEtkjll1XaNyj/4EAaqtjXpVDe+aLzO0j67S+gnnrx4hfRiTNCe7hqnM6KyPW4MGJEhvVSoZJp8JhFIALjVFAQq9Wisw+EGz+DvbAu9ix26I1FocxX5ORFkTuM/+w43thiR6OTfifi6REH0oTsP1ld3vhzR23kyJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711097; c=relaxed/simple;
	bh=4gkCUrWahnbxiYjoyll7myhbF+jlCYVlnaoJjk7//Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/Yj8xgyZx8qKU7Fpk9D3/BpBecxbsJLWVcQNHS2v4VlZU9TlBsPlOtvFNLA2VGRE4x01yA5q4rcc4EEAdfXC3lxwUGbqCO/qHmwkfnuWGMpclQemDUi7VezJ2G9JYwjCuPy9MjpRIfw3GmW/jNEWydX0hdztbsGfndMsppN12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YKJ78/ei; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711096; x=1747247096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gkCUrWahnbxiYjoyll7myhbF+jlCYVlnaoJjk7//Js=;
  b=YKJ78/eiasBA0pMAAvwGQlW8p/2TbaIdtpLQHAxVebo/Xq6bmjDNoRW0
   niE8vJbltFyK+bI0AK4sXjMfTuxJtJcl2QuTA4hCfmROLKB6UgZu50qxZ
   QTfhtQrLDA/m9fex6vk414ad/5sTqapTXthTVjpQH7vqz+NuxFgnSCQ1C
   IViz07qOXYWxQwdNeN20ysII4e/PXb3N9tHTzk2Xhdn62rPd1LQJ7xLvN
   vS4uKPNqzHlJDTGE9FeavYIgCVYTacJMtOJ7MGDoowon+ZRjBpYQikJsf
   nLa+EhmkEmKDkapaApfM3ISmpWe7ix9mNF5kWIPgliwhDsVJ1Zpu8RvS4
   A==;
X-CSE-ConnectionGUID: wjjbsDKlRFSlym15S03r2A==
X-CSE-MsgGUID: dufCt2YdQa6rQuT2kwoNjw==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162691"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:56 +0800
IronPort-SDR: 6643a03a_9tc5jqZAznBRNVZagr+F7n0EVa0StqztlmdNW6wV0NEazAR
 8MKEzU6QXXm3GNIjuf71rvyv9TUMnGlDkRWfGYQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:54 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 7/8] btrfs-progs: add test for zone resetting
Date: Tue, 14 May 2024 12:22:26 -0600
Message-ID: <20240514182227.1197664-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514182227.1197664-1-naohiro.aota@wdc.com>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
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


