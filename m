Return-Path: <linux-btrfs+bounces-5194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3548CBAF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBA21F22655
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCA763FC;
	Wed, 22 May 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E4DfaRAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44178C9B
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357836; cv=none; b=Q5E1YdjlBICRI0HEI1/BGH88L/A1EMbZulslz8SS03VkF0cfM9dM0QGMexmbgj9M8qsS/uSoqi0vE6HYRgbP5Ayrft/RcLYyxnV+5ENofxil9xzWuJnLFwKnxZFNX8/ypatUYxRAcb2YUfzVCxr1Oc+zFCZDjRzkdJjJVKKtDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357836; c=relaxed/simple;
	bh=vveptgKvf6jZr400dXREY6y4NYyFXwV9ioLYEwPVTKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUbad4ayWpNrhh8esiaW/oW2glWXzZP2cFvXKniOMN+AUeqr/5yRusmIAU+jggg2H8dM9MbOSwWd3dIrzcJoxS36lg0gIG7/I/wrfEKK0xOayTR2sXDB2TleY5wuh/qjUGzSFwnnTihtfcq3MUrvVSx29RIzHBVCxfLgem9BCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E4DfaRAr; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357834; x=1747893834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vveptgKvf6jZr400dXREY6y4NYyFXwV9ioLYEwPVTKw=;
  b=E4DfaRAriPob1j5sza1v+Gtef1iSYWqado49dCp+FO3VD+nVSxZqeF2s
   Zf0Mi1yegBpLVhPWAkQpU/gc+4QhIm+r41vY8kzUuAVfgvEshgYCU2jdC
   4wz4QO3ecafi2cJ/2I9SxSBzUmtbSlG87CrOYXzMS/WI/f7zLDjYVmm+S
   NiA5BmfZcWwkeNcf4u/oiyk4P8+Ov4eYD6OyTs6/chxns+hLVdiC28M7X
   JlhbGjGEukzSxScr1RNMhYhyxt6mJoI6MFgMVxn3ZKclFIrrHqCJVqX3F
   97ezHs0nMGDlGOTR9T1CR7lfBRp33OFIGEUhUFnORyFaoNcE8Dq7iL33M
   g==;
X-CSE-ConnectionGUID: DgBEaYNmTPmJ9Ikx+Mu2xA==
X-CSE-MsgGUID: xpx1mdtYRF6nQbjZrGDDUA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170983"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:45 +0800
IronPort-SDR: 664d7d25_iQqbFOPCm4KoFdu9lZoKshoqz6O4ccnfDlahJN60oe8ODIY
 sdXzWcTMQLq89ntykkLafjYiJXLsxUT7/sx230w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:41 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:45 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 09/10] btrfs-progs: test: use nullb helper and smaller zone size
Date: Wed, 22 May 2024 15:02:31 +0900
Message-ID: <20240522060232.3569226-10-naohiro.aota@wdc.com>
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

With the change of minimal number of zones, mkfs-tests/030-zoned-rst now
fails because the loopback device is 2GB and can contain 8x 256MB zones.

Use the nullb helpers to choose a smaller zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/mkfs-tests/030-zoned-rst/test.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/mkfs-tests/030-zoned-rst/test.sh b/tests/mkfs-tests/030-zoned-rst/test.sh
index 2e048cf79f20..b1c696c96eb7 100755
--- a/tests/mkfs-tests/030-zoned-rst/test.sh
+++ b/tests/mkfs-tests/030-zoned-rst/test.sh
@@ -4,22 +4,22 @@
 source "$TEST_TOP/common" || exit
 
 setup_root_helper
-setup_loopdevs 4
-prepare_loopdevs
-TEST_DEV=${loopdevs[1]}
+setup_nullbdevs 4 128 4
+prepare_nullbdevs
+TEST_DEV=${nullb_devs[1]}
 
 profiles="single dup raid1 raid1c3 raid1c4 raid10"
 
 for dprofile in $profiles; do
 	for mprofile in $profiles; do
 		# It's sufficient to specify only 'zoned', the rst will be enabled
-		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d "$dprofile" -m "$mprofile" "${loopdevs[@]}"
+		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d "$dprofile" -m "$mprofile" "${nullb_devs[@]}"
 	done
 done
 
 run_mustfail "unsupported profile raid56 created" \
-	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid5 -m raid5 "${loopdevs[@]}"
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid5 -m raid5 "${nullb_devs[@]}"
 run_mustfail "unsupported profile raid56 created" \
-	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid6 -m raid6 "${loopdevs[@]}"
+	$SUDO_HELPER "$TOP/mkfs.btrfs" -f -O zoned -d raid6 -m raid6 "${nullb_devs[@]}"
 
-cleanup_loopdevs
+cleanup_nullbdevs
-- 
2.45.1


