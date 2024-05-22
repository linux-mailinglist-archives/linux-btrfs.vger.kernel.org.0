Return-Path: <linux-btrfs+bounces-5187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239088CBAE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D273E282CCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472DF78C6D;
	Wed, 22 May 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HOCnt5/K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757B7710B
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357829; cv=none; b=AkLJiLWlOKsBACAC5KlMjaSS8aBAF6daIzkFVxTH0/VSxaH4vlLE2DKOv4o2ERa3sf9A0OfPSa/rsc0ovUWuPcGICeMBvVztYtdbeAlWy15BZP1kyDHznZD459BswRhX8dKNFRUyDsK5Zn0oRpCm1vVWiPf/48V9N620xFwJP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357829; c=relaxed/simple;
	bh=eQ7qyZA19r71928d/RA8iSLKqiOcKrFbwrcrBkRKmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOIJWxO2CVJDG3ABDS472NRvFsWFZatZnWpXuX1jTaJKq5w96SaD+/exeMq44eYpuLNjucaJLYe7whWiuL+5X4X1chGtdtapLwBvw82fzQvH6VdF3rRoYHoO3tY0slexesSdIRlKR6t/semALHX9eW6oZF7QoZmzYxuqiH5WOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HOCnt5/K; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357827; x=1747893827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQ7qyZA19r71928d/RA8iSLKqiOcKrFbwrcrBkRKmY4=;
  b=HOCnt5/KJQpSGCZYjus+tAm9GbwIyUBFWqomKviKn6eoqma9l/9WaR4N
   NDYkn+N1y5G7AS7gyHjupSfFEoag0sQB5JF31e/DMBqbnPp+l9vVtAohr
   jUqx1vg01JlQpuDtOClnoElni3OTo05qE+ref3xUApP3QI3gl9d/RVtfj
   dN0OJNtBcK681BPqcGTTWTeL/RNHwGBvJfeN8nol3vu+o46IMxzZfzIzl
   1GXto/LU1UMpMeU43KiOtXA9t12oKqcM+C6U4fCaOYyWb5hSqmE3md1BU
   DuoCpwqJPV+yTVG3ZL95TL+tDqFHp3vscTHw3pSha3MfDeiZ1bcT1XOUC
   w==;
X-CSE-ConnectionGUID: fN52nwXGSc6owJvvAZakeg==
X-CSE-MsgGUID: sHqZpfHGStWVSLLi6jiV6Q==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16664802"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:42 +0800
IronPort-SDR: 664d7d20_vkQSYLvAqWCjiRzRWtNYuWPgQVDDIaKJd11ML/Omt9H6UX7
 BHoPPN068j7gdMz+iSc60vUto9Z5JovSbHWEJOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:36 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:40 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 02/10] btrfs-progs: mkfs: remove duplicated device size check
Date: Wed, 22 May 2024 15:02:24 +0900
Message-ID: <20240522060232.3569226-3-naohiro.aota@wdc.com>
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

test_minimum_size() already checks if each device can host the initial
block groups. There is no need to check if the first device can host the
initial system chunk again.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 950f76101058..f6f67abf3b0e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1189,7 +1189,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct prepare_device_progress *prepare_ctx = NULL;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
-	u64 system_group_size;
 	/* Options */
 	bool force_overwrite = false;
 	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
@@ -1770,14 +1769,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	/* To create the first block group and chunk 0 in make_btrfs */
-	system_group_size = (opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	if (dev_byte_count < system_group_size) {
-		error("device is too small to make filesystem, must be at least %llu",
-				system_group_size);
-		goto error;
-	}
-
 	if (btrfs_bg_type_to_tolerated_failures(metadata_profile) <
 	    btrfs_bg_type_to_tolerated_failures(data_profile))
 		warning("metadata has lower redundancy than data!\n");
-- 
2.45.1


