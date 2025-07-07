Return-Path: <linux-btrfs+bounces-15273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBCBAFA9C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 04:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270E03B0B36
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 02:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD01D6187;
	Mon,  7 Jul 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AyQKVWH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399021448D5
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856351; cv=none; b=Zpy3fDoNRgO7eYBEn5PAiGnK9XcY5uQH64THlAWFF+FXNoKJog73PsOWFmxX7duBfxFI/57BJiq2x7Lmh2+Jd4+d9DbbjuvoBaI/+utdQH6LYPgmKNsGqaixaBWAtqTlpf0Pgny4aFLWjLqk3ECuuYIUTxazaU1A3/rbRx6EhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856351; c=relaxed/simple;
	bh=UwAs5q7zczpR3AVm6nXMziQluZEYH2fLaVDUMgWWy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7cLkLQ48dYwFF1EKCU3t7QpJISvq7DyTFAaI+f/dVu4UmIKeymMx2V2t3n+eva618CuxddvPmmSPeVglTy4F0wV9iNBEBYRPGhJ8xDAdALkfBsHte7xq9yCWRHVy9rWPKNM1AeUwV1taWQt4kVCu/BcMfOoOaJekW71oOMrs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AyQKVWH7; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751856350; x=1783392350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwAs5q7zczpR3AVm6nXMziQluZEYH2fLaVDUMgWWy6M=;
  b=AyQKVWH7Vnl4OSPAInyXA/J2EuKMK7MqEqnSBfkFD+0SOehUlX1mZwvG
   Eg6Ho9A6Eme2Ftmi/ka412KvewW4pWCoPWu9BuhKVlzC39Ki+Xw75v233
   krodaAb8/Yx8/gZvA1C7AsDqE+XfF4e+NVIhcFh5N8zCBk1XwGS/gUtEJ
   ZBwe0Wxr7WiWz5dfqP4fA2t523tCvcrQwThmD/mxiMmTMw4nNQi7RWYDT
   Wbs2pDa0xKl2MmE19WkVdUUoERxxl/WTsGJt7IPuWGR1FCjYHxhuxKgb2
   TYX6xYSenneA5PuvxgW1EXdkfqScGbEOWsVtaeCwfqWBpX+EMR98A0qlr
   w==;
X-CSE-ConnectionGUID: 6WpieCn5Qe6LDCWF7+oxNg==
X-CSE-MsgGUID: tb2cELHyQJmaO8ImN20KuQ==
X-IronPort-AV: E=Sophos;i="6.16,293,1744041600"; 
   d="scan'208";a="85911271"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2025 10:44:39 +0800
IronPort-SDR: 686b2604_/b2lJOt6WbfiEAn6FbHLIrU3/cuWKLSU3J40Pbo9pmaURod
 Hkc8/gJaeTMQ7BjUZyXlDjSkkC3br/P/md+evpw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 18:42:28 -0700
WDCIronportException: Internal
Received: from 5cg217427s.ad.shared (HELO naota-xeon) ([10.224.173.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2025 19:44:39 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs: zoned: do not select metadata BG as finish target
Date: Mon,  7 Jul 2025 11:44:10 +0900
Message-ID: <91e1b6f06906a4737b9d7b3e1083bd8fec040041.1751611657.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751611657.git.naohiro.aota@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We call btrfs_zone_finish_one_bg() to zone finish one block group and make
a room to activate another block group. Currently, we can choose a metadata
block group as a target. But, as we reserve an active metadata block group,
we no longer want to select a metadata block group. So, skip it in the
loop.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bd987c90a05c..6fb4d95412d6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2651,7 +2651,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_DATA) ||
 		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
-- 
2.50.0


