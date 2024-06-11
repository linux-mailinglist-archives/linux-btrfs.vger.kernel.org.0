Return-Path: <linux-btrfs+bounces-5643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F17903771
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C58B28292E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F017624C;
	Tue, 11 Jun 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VhOws+5O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5984175549
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096806; cv=none; b=MurztFQzbBhYt5WvgFyDelRRacKZf9+UbynW8z719B/Wm0kI6uBadLfxwMTPOa3wdd9vO+P2lY4gOrQRzQTCfImAghV8qfN0T7qiQteezsEbRfL4sjeQvL85gRROHpRMi2U8oR/QEgmck8amJj48N1YhjbADWU+qajrblDD2CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096806; c=relaxed/simple;
	bh=qlGH8c/4KHfbxQgZjC/9ePp4znzFymK1WBcHi+MRXxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icXGVmcALd2S92YNKUPg9n9rCOUnxzgTJPY69JXTKeV0Kz6x/1Yb/GCSkQdjeN13LaRXNT91JYLNkmQUWNBjA9pM4RlZ/3j0MVw8t5zLG4b0UDnNWSEVIQwWtC3J0wlR+ROmNkKq4t/guLJRsEPI43aVloOzQI4RBrCgrL9zKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VhOws+5O; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718096804; x=1749632804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qlGH8c/4KHfbxQgZjC/9ePp4znzFymK1WBcHi+MRXxQ=;
  b=VhOws+5Om+1TE2aTxpB/t2pM5duG4HXtLEJkrTQIHW4U1ZemaSVN3MMn
   Hab7cKlZ3l08PxhrePWF1RdWx0Cw13Io5ReTJsNSmdkGVWHu6B5CBxlwx
   Ua8pypbYbPUFq9nXOeGUgLpy3KUHplCDPZipo/EpqogkoBp670OCzBiJ0
   wZcRzwBHCK5ursQPtPXLliKy/5pFOs9rqrvO4auwKMd5uJDvRw5sAM1BS
   X09zaFp7orraQCUg0FblPI3ck6+f0Z7YFwp290xKYYyTWvUwj6wXWg3JE
   LZDmpjCP23InBElNwS+t9pz5JLi2ya8Lx6/dEjThgX1w377LkiVk1iil2
   Q==;
X-CSE-ConnectionGUID: /288T0DGQLq/Hv+TK/jmNA==
X-CSE-MsgGUID: bkNTjlLhSx+pephVagVhRQ==
X-IronPort-AV: E=Sophos;i="6.08,229,1712592000"; 
   d="scan'208";a="19608372"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 17:06:37 +0800
IronPort-SDR: 6668073e_M/nbVlaIC4Mh09JMb7GlMwkekxQMdNGNLARQfzbl8APcktB
 jNu4JhKAp7hcUiRskkhu6ucEL/RvPvJke898AAw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2024 01:13:50 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.74])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jun 2024 02:06:37 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix initial free space detection
Date: Tue, 11 Jun 2024 18:05:52 +0900
Message-ID: <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a new block group, it calls btrfs_fadd_new_free_space() to
add the entire block group range into the free space
accounting. __btrfs_add_free_space_zoned() checks if size ==
block_group->length to detect the initial free space adding, and proceed
that case properly.

However, if the zone_capacity == zone_size and the over-write speed is fast
enough, the entire zone can be over-written within one transaction. That
confuses __btrfs_add_free_space_zoned() to handle it as an initial free
space accounting. As a result, that block group becomes a strange state: 0
used bytes, 0 zone_unusable bytes, but alloc_offset == zone_capacity (no
allocation anymore).

The initial free space accounting can properly be checked by checking
alloc_offset too.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Fixes: 98173255bddd ("btrfs: zoned: calculate free space from zone capacity")
CC: stable@vger.kernel.org # 6.1+
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index fcfc1b62e762..72e60764d1ea 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2697,7 +2697,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = (size == block_group->length);
+	bool initial = (size == block_group->length) && block_group->alloc_offset == 0;
 	u64 reclaimable_unusable;
 
 	WARN_ON(!initial && offset + size > block_group->zone_capacity);
-- 
2.45.2


