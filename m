Return-Path: <linux-btrfs+bounces-5195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9EB8CBAF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC758B21692
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A978C9B;
	Wed, 22 May 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GWGIe04k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F578C83
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357836; cv=none; b=FtysxnnXR8PoxvX8kkgxCm+Qt9nmZN56QshcVgog0DgJ2Jnx5ARVVqzIt1O/PD4CyHDHIAuQn/M4dvK4hGWbTzRyAl/GKTDJ/7XY8w8NCTQgQWEG3+4MT8TayD0CV/k5RvaIdRn9XfuPgtx92Gk2/J7MyIfJ/200udMvQzpNjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357836; c=relaxed/simple;
	bh=P/+3Yz1jAL+wNpcETlU/vWrCw9svhZwTT5lyGR4l3dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmthh2OgbcYH6twOpUUdy092Qf7uImVnQgn87fXm1T7e5ihfBqvRoAoqZZJaLA2yasAj4hgW19gcEJL3EQhDFWM1y8trR+Ndwv90T9bBps3HzstbyYQVUh20J2AWDBnwU//GKfN52wmatKI+hEDKOf4X23lTARtAMMvGPvQbT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GWGIe04k; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357834; x=1747893834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/+3Yz1jAL+wNpcETlU/vWrCw9svhZwTT5lyGR4l3dw=;
  b=GWGIe04kXKEayYblYRzVYuZ8eZGsr710G8pBngH+YbHCydMdpIOkqG/B
   klgRcQVWW5njJFHtOUfh400W/MJwsNz6ASyM4L4w3gF3hDDI7zlihR5q7
   iDXKjk+KtnJlhN83eo6CbTOc1LHyLEJQo/vtGnBiLH06AFaeou2juODpU
   3XfdWR7cyrcub5fb62lTZqAFLl50LQAvO5hsiJbo6QgA7mm3gXyk7YN+I
   BTJTpSmj8OGX4P//t5//YH9mW4znDR2oxuz05WwEz3j0II7KhYTV1fd3f
   cO2qBBYaZ/lK//M3Qra61pyBetOHEMjKspMiXiL4NlrtHQTNU/k+RGjh+
   g==;
X-CSE-ConnectionGUID: QDM1T00uRpiRLGDOur2Dvg==
X-CSE-MsgGUID: fLo8R8oXSBWd0gPVlU58rw==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170985"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:46 +0800
IronPort-SDR: 664d7d26_qWCUIQUk2EdzuJWJtaXXXAYdoQcTRlBKWwdLtQ1+Ti93ZMV
 OOn3O7uXwsmdHO9pyrR+tKVYlRqSwYX2v2rciYA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:42 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:46 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 10/10] btrfs-progs: test: use nullb helpers in 031-zoned-bgt
Date: Wed, 22 May 2024 15:02:32 +0900
Message-ID: <20240522060232.3569226-11-naohiro.aota@wdc.com>
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

Rewrite 031-zoned-bgt with the nullb helpers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/mkfs-tests/031-zoned-bgt/test.sh | 30 +++++---------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/tests/mkfs-tests/031-zoned-bgt/test.sh b/tests/mkfs-tests/031-zoned-bgt/test.sh
index 91c107cd5a3b..e296c29b9238 100755
--- a/tests/mkfs-tests/031-zoned-bgt/test.sh
+++ b/tests/mkfs-tests/031-zoned-bgt/test.sh
@@ -4,37 +4,17 @@
 source "$TEST_TOP/common" || exit
 
 setup_root_helper
-prepare_test_dev
-
-nullb="$TEST_TOP/nullb"
 # Create one 128M device with 4M zones, 32 of them
-size=128
-zone=4
-
-run_mayfail $SUDO_HELPER "$nullb" setup
-if [ $? != 0 ]; then
-	_not_run "cannot setup nullb environment for zoned devices"
-fi
-
-# Record any other pre-existing devices in case creation fails
-run_check $SUDO_HELPER "$nullb" ls
-
-# Last line has the name of the device node path
-out=$(run_check_stdout $SUDO_HELPER "$nullb" create -s "$size" -z "$zone")
-if [ $? != 0 ]; then
-	_fail "cannot create nullb zoned device $i"
-fi
-dev=$(echo "$out" | tail -n 1)
-name=$(basename "${dev}")
+setup_nullbdevs 1 128 4
 
-run_check $SUDO_HELPER "$nullb" ls
+prepare_nullbdevs
 
-TEST_DEV="${dev}"
+TEST_DEV="${nullb_devs[1]}"
 # Use single as it's supported on more kernels
-run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -m single -d single -O block-group-tree "${dev}"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -m single -d single -O block-group-tree "${TEST_DEV}"
 run_check_mount_test_dev
 run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file bs=1M count=1
 run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
 run_check_umount_test_dev
 
-run_check $SUDO_HELPER "$nullb" rm "${name}"
+cleanup_nullbdevs
-- 
2.45.1


