Return-Path: <linux-btrfs+bounces-16573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42AAB3F3C9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 06:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B9D48363A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 04:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94F2DF13D;
	Tue,  2 Sep 2025 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o8WDTse6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33B1DB15F
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787414; cv=none; b=X7oRF0p5pJp6xUbeSX2kREtukBCUN+fTnq1wmlR2IZ1Ur6Q0q0gEiW05AwS/ALE+E9/8RErvcnAzxcjnaBTBod2fqfCN8SdneK1t7mzsd7V9S1AMndTqrr0u5tcrShMzp2E6RKuskfGYe5DgB80YSdfI1AhnxoK0NjBccgTMGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787414; c=relaxed/simple;
	bh=MHQsj9z2J9xrTD7W5JYyWoE+0VT/gQehK20LFZynsjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmMHrOIdNOWpyZkt6pN4WlG09E5WpMWFJ4W3rmPDXJaNFA437KHzXroj4PfzbxjljiK5OxqjkgX/IhhkkMrDWjzzq8o9dQpseK0rBuMChpxOby19kBWTixSYEszXoJQcEbClIx1cPho1sstUBKsD37osmtyDN66z0nTJJciADRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o8WDTse6; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756787412; x=1788323412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MHQsj9z2J9xrTD7W5JYyWoE+0VT/gQehK20LFZynsjo=;
  b=o8WDTse6JPioxVmMbQxohWhUSqHkHPiMeN8YB+Tqmc2EofE6XP5yfH0m
   tb7TbNQkNFENnvciSKvHBl7ugauZIeMEmbmZz7ivp4pbKfsGGvf6Wl1Sv
   aDfYNcjv6RIvvpmkbFysaZBU9ajiMWlqF9UchJRyE1rEfjEurqIugXnGM
   IS1Yy3rX8QlKb6KbbDlPhefh+9TbaFOX3ZotiQcBiDM8weHnyBhCPy9o7
   vnZ+KJyvSGahB3gKd5xHH5YhHjdHH5YyuCpvEaGwQ8ls+SUANKg0N24s+
   iWsU2VX0uurjdtdunx6Kg+nca4EXdFUcSMrKF2VwnEWG6/LRkFxOCw0mw
   A==;
X-CSE-ConnectionGUID: n9Gw+YgsT0KVmL0Hf2ypkg==
X-CSE-MsgGUID: jUZDRIIvR6W3Uxen2mz7VQ==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106426373"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 12:30:11 +0800
IronPort-SDR: 68b672d3_hBUL+mWUOEy0hHGifK+a6o9RDC3mj3kc36jsOPx6hAcG4Lz
 Tc+IgOTJFZj5E/kaW2gXoO1qjaVXF4Luy1kQbSg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 21:30:11 -0700
WDCIronportException: Internal
Received: from wdap-uxdzwi0ixx.ad.shared (HELO naota-xeon) ([10.224.163.20])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2025 21:30:11 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs-progs: tests: check nullb index for the error case
Date: Tue,  2 Sep 2025 13:29:18 +0900
Message-ID: <20250902042920.4039355-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042920.4039355-1-naohiro.aota@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"_find_free_index" can return "ERROR: ...". Check the return value for the
case and fail the test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/nullb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/nullb b/tests/nullb
index 457ae0d8354a..bfc5640c4470 100755
--- a/tests/nullb
+++ b/tests/nullb
@@ -146,6 +146,9 @@ fi
 if [ "$CMD" = 'create' ]; then
 	_check_setup
 	index=$(_find_free_index)
+	if [[ "$index" = ERROR* ]]; then
+		_error "$index"
+	fi
 	name="nullb$index"
 	# size in MB
 	size=$(_parse_device_size "$@")
-- 
2.51.0


