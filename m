Return-Path: <linux-btrfs+bounces-4989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1328C5B0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DCB1C21CF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A7180A6E;
	Tue, 14 May 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T1qwFK/j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F3180A71
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711099; cv=none; b=T2eM/Nu8AFCZ3dgfIXlMbhCSL1Gmmaebq/8Zh81ySfagxfMCxrVGlERnL4/oAT0z/pW8L03WvMOYhenT3wjv5GvLOF5Z2JxD2hxoabI2pCVS0Ol4VLQg7YL/F1++bb1in+dVYrCm2wt6m+KxWXLmWcrvekogyMn0rH1BMrRE2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711099; c=relaxed/simple;
	bh=08v2xyBmdJ3XAG4ZotMl4yNKbz9h2IXrSbM6HIDWuH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6mUxmb5hyO7+gD4pTL6vM2xb49olJV6zFreK2VRDgxf2whVMPRk95b1NVJKB9XLYEg2Q1p5bX4l7afuHxGG5s/AGdwq7xL2LrYeHB1Jm1c0a3Gxq7wWiZ7KgUfi8/XD86NQk9PSp8YuIBT8STatOBYuaMsOw6YZHJM79aSMRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T1qwFK/j; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711098; x=1747247098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08v2xyBmdJ3XAG4ZotMl4yNKbz9h2IXrSbM6HIDWuH0=;
  b=T1qwFK/j3ttBV8uxc83eBIIYw1Jnu3mZbbu6bNWG4mZPJD7SBiYXDvd5
   3ZFVvWxo5Pj3/57Ux95NXPDlSm/Xcrm+prU4qhkLL/jPLbqBv/GcSIchF
   3XekVuJTa5jV+Gtu6YV4lEOs5VYwbI0rFYI9oI+SK67++E9smyRJCdQ91
   BEOBim9Z2HR3cSjFFS2SlcG2VsH+QsUzjQWAKLNycpSJIL9zFcQ6Iw80F
   5h4EgOxfDTn53rohip982pRdi3uyMZjN0qX9teJJlj4o5hIPaPLM5nxna
   wROSla6mxTr1aUqcy+mLBNjTFVxTZ8RWRxIc2Y3QYouhT3pJws16Szmkw
   Q==;
X-CSE-ConnectionGUID: dBMPWFYVQIuuUDVsPptmlw==
X-CSE-MsgGUID: 58oCQ5SkQSqZJG0/5c4PKA==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162695"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:57 +0800
IronPort-SDR: 6643a03b_Qy9gvtO+gIVlUtilw4ygphvOrtxA6EoQhY9m9f1AGv9DDJM
 X6Ag8zN4qsnyefpEy/0kCPzj3nciTgPpjESpNgA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:56 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 8/8] btrfs-progs: test: use smaller emulated zone size
Date: Tue, 14 May 2024 12:22:27 -0600
Message-ID: <20240514182227.1197664-9-naohiro.aota@wdc.com>
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

With the change of minimal number of zones, mkfs-tests/030-zoned-rst now
fails because the loopback device is 2GB and can contain 8x 256MB zones.
Use "--param zone-size=4M" to use 4MB zone size as same other nullb case.

We also need to enable "--enable-experimental" configure option in the CI
scripts to use that mkfs.btrfs option. Currently, it is limited to the place
mkfs test is running, but it would be nice to have it in general, as we
need to test development code anyway.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 .github/workflows/coverage.yml         | 2 +-
 .github/workflows/devel.yml            | 2 +-
 .github/workflows/pull-request.yml     | 2 +-
 tests/mkfs-tests/030-zoned-rst/test.sh | 7 ++++---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/coverage.yml b/.github/workflows/coverage.yml
index 3aea8cd5f56b..b7f209b3fc51 100644
--- a/.github/workflows/coverage.yml
+++ b/.github/workflows/coverage.yml
@@ -16,7 +16,7 @@ jobs:
       - run: sudo modprobe btrfs
       - run: sudo apt-get install -y pkg-config gcc liblzo2-dev libzstd-dev libblkid-dev uuid-dev zlib1g-dev libext2fs-dev e2fsprogs libudev-dev python3-sphinx libaio-dev liburing-dev attr jq lcov
       - name: Configure
-        run: ./autogen.sh && ./configure --disable-documentation
+        run: ./autogen.sh && ./configure --disable-documentation --enable-experimental
       - name: Make
         run: make V=1 D=gcov
       - name: Tests cli
diff --git a/.github/workflows/devel.yml b/.github/workflows/devel.yml
index aca6ed975563..3ac85b0b32e4 100644
--- a/.github/workflows/devel.yml
+++ b/.github/workflows/devel.yml
@@ -71,7 +71,7 @@ jobs:
       - run: sudo modprobe btrfs
       - run: sudo apt-get install -y pkg-config gcc liblzo2-dev libzstd-dev libblkid-dev uuid-dev zlib1g-dev libext2fs-dev e2fsprogs libudev-dev libaio-dev liburing-dev attr jq
       - name: Configure
-        run: ./autogen.sh && ./configure --disable-documentation
+        run: ./autogen.sh && ./configure --disable-documentation --enable-experimental
       - name: Make
         run: make V=1
       - name: Tests mkfs
diff --git a/.github/workflows/pull-request.yml b/.github/workflows/pull-request.yml
index 954e1ee5ffb0..9765ea24a2e4 100644
--- a/.github/workflows/pull-request.yml
+++ b/.github/workflows/pull-request.yml
@@ -20,7 +20,7 @@ jobs:
       - run: sudo modprobe btrfs
       - run: sudo apt-get install -y pkg-config gcc liblzo2-dev libzstd-dev libblkid-dev uuid-dev zlib1g-dev libext2fs-dev e2fsprogs libudev-dev python3-sphinx libaio-dev liburing-dev attr jq
       - name: Configure
-        run: ./autogen.sh && ./configure --disable-documentation
+        run: ./autogen.sh && ./configure --disable-documentation --enable-experimental
       - name: Make
         run: make V=1
 #      - name: Musl build
diff --git a/tests/mkfs-tests/030-zoned-rst/test.sh b/tests/mkfs-tests/030-zoned-rst/test.sh
index 2e048cf79f20..9fa9c8c0d30b 100755
--- a/tests/mkfs-tests/030-zoned-rst/test.sh
+++ b/tests/mkfs-tests/030-zoned-rst/test.sh
@@ -9,17 +9,18 @@ prepare_loopdevs
 TEST_DEV=${loopdevs[1]}
 
 profiles="single dup raid1 raid1c3 raid1c4 raid10"
+zoned_param="-O zoned --param zone-size=4M"
 
 for dprofile in $profiles; do
 	for mprofile in $profiles; do
 		# It's sufficient to specify only 'zoned', the rst will be enabled
-		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d "$dprofile" -m "$mprofile" "${loopdevs[@]}"
+		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f ${zoned_param} -d "$dprofile" -m "$mprofile" "${loopdevs[@]}"
 	done
 done
 
 run_mustfail "unsupported profile raid56 created" \
-	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid5 -m raid5 "${loopdevs[@]}"
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f ${zoned_param} -d raid5 -m raid5 "${loopdevs[@]}"
 run_mustfail "unsupported profile raid56 created" \
-	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid6 -m raid6 "${loopdevs[@]}"
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f ${zoned_param} -d raid6 -m raid6 "${loopdevs[@]}"
 
 cleanup_loopdevs
-- 
2.45.0


