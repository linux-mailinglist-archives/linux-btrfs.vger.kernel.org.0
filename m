Return-Path: <linux-btrfs+bounces-4987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7B8C5B0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8172B1C21D1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FC181310;
	Tue, 14 May 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uq6IjmAg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AC180A71
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711096; cv=none; b=Oy3UCeyMKAQnkLxLaqWVkpVO5QuClhqQhAqm3VKKogzHDCx1+O7qLImlVbEut/6enr9rNcrEcY6Tf6xaWpQ9XzBLfgof3wVPmfhHrmvkTzB0+mzSK2cNZbIgCZVl5FT6qwhe5I6laL3yvvjW3xHDlLhJ53IdhrYaGpLOIVc14gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711096; c=relaxed/simple;
	bh=291spckHOc/OndRzbUKt1knBk+0K4i7rEvJSmzcNZQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjgmTAa2xnadlKKpSn3EomqviF4p37e9xtQXotfPl+M6QXIF35Nj1C2g36fEKMZnE+s7xqj5ovu+/ZfA0BzhsyPw/1q/8E3W9kCz5PDOeGpLcTAVlpdUQtCptm/XcZQq1MnjNQpqCqgSfl6ipxYDKtoHrPRG4ePHcjkvlsSxskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Uq6IjmAg; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711094; x=1747247094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=291spckHOc/OndRzbUKt1knBk+0K4i7rEvJSmzcNZQA=;
  b=Uq6IjmAgVonU6uxI+llOz6iOwwX1Uxfi5s3fzUH4wiqmWh2w9ejz1UMw
   yNoZM9Z+bjXDM65cZIi5Cdhr7QQ8e6C0UMP7rNb1k1g9giZPXZFc9NkmU
   WbIzvJEgdr0DxTMXsPjmesIZjiK/dbklRQflgakXb+l5z5FT1uCizT9yb
   Amw7V9XY1im0idUykTlVGzP9cYtpiq0IgLGydg/DuLfWF8JkTT8LuhqQE
   JpCSbPAG/KLzToYOAL3z0vZ18H/xbPv90nfC3dMa28ZGLx2z8lcZyjgiO
   hRKfJVbYpT51OhSTdjCBGruiJBvaYCHc0Ot6keMi/TCmRZRj8rQ+c7cr4
   w==;
X-CSE-ConnectionGUID: zLSrvCZ2ROGurz9/Mou+qg==
X-CSE-MsgGUID: aB6k4ZvmS3OFCvadVhwr0Q==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162686"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:52 +0800
IronPort-SDR: 6643a036_VkJ7vvCtC5ObYWvSidRRSKn5GxykuIyoVOU/eio87RbXmjV
 wHF631DnlPCEoQ9jgWSvjBDskPiKTG0+jRg3PrA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:51 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 5/8] btrfs-progs: mkfs: check if byte_count is zone size aligned
Date: Tue, 14 May 2024 12:22:24 -0600
Message-ID: <20240514182227.1197664-6-naohiro.aota@wdc.com>
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

Creating a btrfs whose size is not aligned to the zone boundary is
meaningless and allowing it can confuse users. Disallow creating it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index a437ecc40c7f..faf397848cc4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1655,6 +1655,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		      opt_zoned ? "zoned mode " : "", min_dev_size);
 		goto error;
 	}
+	if (byte_count && opt_zoned && !IS_ALIGNED(byte_count, zone_size(file))) {
+		error("size %llu is not aligned to zone size %llu", byte_count,
+		      zone_size(file));
+		goto error;
+	}
 
 	for (i = saved_optind; i < saved_optind + device_count; i++) {
 		char *path;
-- 
2.45.0


