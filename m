Return-Path: <linux-btrfs+bounces-5347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC88D2DEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FB91F21889
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F6168C11;
	Wed, 29 May 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o3n2ErrB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC0167D94
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966825; cv=none; b=qvBJ1FjhXuUPPZXKoaMp0hpVQJkjHrs1SBEB2UyeQ4gYHecocNL1PNklGnUjWxlFvkeQtNOt4YZ6Rb0ppr11FWpvKB655zeCCx9xEoo5apGxhXARZoKwbIHo4X06gfdEjqwPAs42NskjO/4iDsV5z+kWj8cpo2SlGiFVT9UuvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966825; c=relaxed/simple;
	bh=ZhIrO75nhRZjU15nUgPpUwToGimb0hwXNBSUt61BJpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdmJq3OK3lbgDbByQX7INZcbmLNvxhz1+OJ4TYaueMwK3m8h/Akgtoe1IOWU6L9obk/17ABzsXXX2PNyiX9vnfFhtQ8d7nKElJldAcvYYqLevo0OL1hsb7IzdJYqi+AIF6pk169MG3eWpHUjm464xnJpj9ZcLLfFb/y+zIlCXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o3n2ErrB; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966824; x=1748502824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhIrO75nhRZjU15nUgPpUwToGimb0hwXNBSUt61BJpk=;
  b=o3n2ErrBCnSIpC3IVKcvDoWWuNYxW/VD941QXTMyxc2ICcYXSG5VETe3
   u1Ft7d5b2v49csJmKO2a6ECYEAZ7oqXDDldEbISqusLX7KTNBueY0XgMG
   TKBYi1wWGK0mi46/0wpQhyzHa4GKP57/wu0pELgG547XM8MWKjtfcrOkV
   0HXxhOViGR+w/2oQDmEdqXsZqVkSwp7RF4ITeq7lEJ0oRuD+VhWVc9iJN
   gFSE7iIZzKIKJnBErI8PfVBj87ysN8Sp5JwiZ20k2LC5c93ZarGuM9sEg
   jb/hjZAXfQzBrJeY2P4RAac9OATkzLMANvXNf+MKc8BhWewMjhHNe2lAQ
   g==;
X-CSE-ConnectionGUID: NQcxbT/jQhS9/Ij/khGxFA==
X-CSE-MsgGUID: DnIjC7I8Qo206Q2xTlkQ8Q==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865353"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:39 +0800
IronPort-SDR: 6656c953_rZ9onBDbuUeILI1KN+6vxxfMXt2XtdvgcVMnQ6B0m/P82/x
 wRWhJJjoSWbB81DHNmMLiU6C8iGVHjuXZ3s2KDA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:07 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 10/10] btrfs-progs: test: use nullb helpers in 031-zoned-bgt
Date: Wed, 29 May 2024 16:13:25 +0900
Message-ID: <20240529071325.940910-11-naohiro.aota@wdc.com>
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

Rewrite 031-zoned-bgt with the nullb helpers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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


