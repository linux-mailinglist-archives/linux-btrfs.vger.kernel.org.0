Return-Path: <linux-btrfs+bounces-4947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A458C4AA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B728460F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593411C20;
	Tue, 14 May 2024 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SDSxORnx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252D17C2
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647929; cv=none; b=W1blJ2fTbiKibSPaJyR30RbdkG0GJ9OGWCXvfLukgKzT3WHC75QgTyeuyLGfWXx0XXtY4AdWWBBz88DCEIEOyj1Fic7PicKsop/CHphBODiD4c8iqWyurUDrzHASFHMKCBUFwrNuqfWUPDZs1/oBfzA9J5wH4MCJ+/Sz/JVa+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647929; c=relaxed/simple;
	bh=TBUYJ3c6BS0lMAzA+zRpFALc0P5qHwaGeFmjh/qbv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF4TWOL/geLWEjhkD+i3QIQUpeGL/rb7rfQ9WTkb7tfTayLSzVZZaeaUm6LRInQmfOOBBFVaVmQRtY5sOiux/Zii9YbHAPTpXcUa1hVLT/s4ItTdmI46pwntAIQf+2RUtfcP4QaV0Y7huNfMazxvJortCiRxLlobsg0UuAMkLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SDSxORnx; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715647927; x=1747183927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TBUYJ3c6BS0lMAzA+zRpFALc0P5qHwaGeFmjh/qbv/o=;
  b=SDSxORnxYfE2MpiZRZvvpMop4JZTzfLgaLbKAiC0aTApdCyKFY3gTSaj
   s59toRoeQ0K8CK59i0hw/xIQ26LeLkAeq+FBgtTYM39yEDDTGASUkogzG
   CY03p+os+e8GIvSdaedXzkAS0upIwa+Re3d1gf/n/caWhlOy9KsiviNyJ
   gtat/ssGwO7HxoqnBxt4aJMolAwfF+d3vh+zFCZ3lP65E+0KESNL6RePL
   GMb51b+YNmNi+OprBxtyY9e6S0dYh9bdHKQhi8vNHtJUOITsa8amRETR8
   LKJ+kKyffbejovPsf7hnPfXbgl915dL3xmSq/zepiTnLm0D96IEwo6/1+
   g==;
X-CSE-ConnectionGUID: EMOX+MtSRay9orDR7mZjSg==
X-CSE-MsgGUID: rFta/bchQBWILjP1pkB05A==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16252229"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2024 08:52:01 +0800
IronPort-SDR: 6642a820_JHgBEcEMwz/T8XVN2TvNofBVOpTheb1LRUALHGQijNzgiU8
 HeEsyNTNv6lRSptegAmBVdx/fv6QHS5/ZHbdv7Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 16:54:08 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2024 17:52:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/7] btrfs-progs: mkfs: remove duplicated device size check
Date: Mon, 13 May 2024 18:51:28 -0600
Message-ID: <20240514005133.44786-3-naohiro.aota@wdc.com>
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
2.45.0


