Return-Path: <linux-btrfs+bounces-5346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B98D2DEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3284BB251CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07A167DBA;
	Wed, 29 May 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aM5bB/3k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FD16729F
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966825; cv=none; b=nLg0cuervX19xSRMwmr6H9AUciOoK8lva5gumFqV4aDBkl05KmpV0PWe02gBX92WZxRh8MTu8JJEQsnWzMZIzpzwmzyDihf4y/Wc1TiUPksBJMBFZDovZ36kTqA+wJyZT97GBfgrSabIS88XEzvKjC1TE3jfBmasp5FpLUVZxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966825; c=relaxed/simple;
	bh=uZcIG1Z05gbvssV/KG6a10C2OPcE+6aIE5uZvc3mnGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEuEY8QTFIYD7nssyvzWsTuyHaqCCILSQcYhd6f8mNINOSWoVQ+h1rp1uSLpUNti3wdkK3GATMzcbkX/UdKRmMHFcp22XKQOFoReSZbdqy7fq2WHA71mDkLIPOzJIvFu33sF1VNqGrcDalhtC7TS1PH/zr8bja73GktzivyUtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aM5bB/3k; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966823; x=1748502823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZcIG1Z05gbvssV/KG6a10C2OPcE+6aIE5uZvc3mnGY=;
  b=aM5bB/3kKkhU5fUwTHEyKHhCHhGQTZA2ahPdV6ZfKTERWgITwTZ9lj8G
   AFO8PcoqSt308bImdbZ/U8X7pd182V9qF0HyebzQsGS3zxLkXmVdcKErC
   p24NKe1udRK2IQT4/W3yP+0at+Om07fkrl2H4QXhVfIVentT8mxrGktzW
   UTqP3Jy8kFHQASWK0i7D1v4BqfP/EWGSeBYQqVoVDjfikxEDq/DeXAXvH
   uPeCqkNgORM/XQtHG9c2Npa3TNvkVKtHTNcqCMVni2b76EMI7ldnKruuP
   Hslrzxl9K7GeH1ebShGYlboLchclpWatms828dMlDmkTooWCkPzRGUCSC
   Q==;
X-CSE-ConnectionGUID: ahUM2zLdRlWNMxw47Sfc0Q==
X-CSE-MsgGUID: 5NPn5GBSQOi0bvujzDZdwA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865351"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:38 +0800
IronPort-SDR: 6656c952_GzzN2FM2OO8jaRR1+7DZns/qLpcLiEBleJsOnwlGhE+dp2I
 nyQaGEy5FrF9FMYDAsHj5/BjaaiNo0wY9Wu4ucA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:37 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 09/10] btrfs-progs: test: use nullb helper and smaller zone size
Date: Wed, 29 May 2024 16:13:24 +0900
Message-ID: <20240529071325.940910-10-naohiro.aota@wdc.com>
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

With the change of minimal number of zones, mkfs-tests/030-zoned-rst now
fails because the loopback device is 2GB and can contain 8x 256MB zones.

Use the nullb helpers to choose a smaller zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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


