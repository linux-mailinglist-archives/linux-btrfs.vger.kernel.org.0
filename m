Return-Path: <linux-btrfs+bounces-2346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565C852AAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 09:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B7A1F210BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C71B5B1;
	Tue, 13 Feb 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TSRIkGt3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA81A708
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812184; cv=none; b=qAT8ULjRcGCih+8rN+K1YD2HM+GGHbbRITsD4qu3Cn9KslFloIeUV34m2ncZftFHSHvZWD6AoTpllL5K2MAylfXoKZkScSwws+i7ILyEWLUGS1PBM150bPJvn82gIFjN8zMru7PTjlxb3wWhVxMB/gCEypVMhX4rQOhky8clPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812184; c=relaxed/simple;
	bh=+vDFAf2MRA3npskfnuz03qZ1f93CDU8L5e0brGLyWOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1QL9AUN6kccAGuDs4LA/uterAa+DAyTyYuOxVOosaTNh8VFyL6uFyL9PhrT8FHYA4eg3C6PGcZzME9/F26k4anT81Y05z0cReIcLP/L9i2WKC5ZnDAkiO5oFmSeDBMHRwq6lqwdTEWlA/OhpjE75AuKb+59N54cGfr93ZtZZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TSRIkGt3; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707812183; x=1739348183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+vDFAf2MRA3npskfnuz03qZ1f93CDU8L5e0brGLyWOw=;
  b=TSRIkGt3g+uUf9QiBrRI9cxWMruAgbTzBCdn8nSS9oMsmAdSC0Am10Aa
   CUIZIbiNcT1DUI1ik2+NutmuCxNwzUexnn9F17/75Ojj7HBa5SfSOzE0e
   YtrwG25IaCJxKhCwBKON76qHL9zVsdJRggqxWxC2iUC3QF39+m4rjlmDe
   3xAHd1y4EbZ4xNovUIdes//Ln9MbFmtF6ttMVofjX1+Zf2mhFmFWqJ1cN
   JY27WdNoYg8tbq3l7QNtztXxe6pFWU3AwfyTycESO3rvAtNag7xPyjM0W
   kt8K4MquE1u0BPFhh6IQJemvvZ99Am0qYgossPacnAlSA3gclKib+AXkc
   w==;
X-CSE-ConnectionGUID: +PqJjbn8S1yuoVaQMF4+qg==
X-CSE-MsgGUID: ivzW1+kAQKmT2hT/VykzRw==
X-IronPort-AV: E=Sophos;i="6.06,156,1705334400"; 
   d="scan'208";a="9038040"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2024 16:16:22 +0800
IronPort-SDR: AH07KlPLEypN7bseyU8BZK3oa8km02JG47peWcu3NUUhMuRSFmFixBSLaWg4zA0vjLF3A1Axkw
 8K/Sm5xfpBIg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 23:20:17 -0800
IronPort-SDR: lLI1DIzkqvVVj/G8/cj8+K23/zZFYsSec0x/DQYh3BW5+Jd9Cft10rR5FT2j/rPpDZonjeXxwK
 qd42evRw7Pag==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2024 00:16:20 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	HAN Yuwei <hrx@bupt.moe>
Subject: [PATCH] btrfs: zoned: don't skip block group profile checks on conv zones
Date: Tue, 13 Feb 2024 00:16:15 -0800
Message-ID: <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a zoned filesystem with conventional zones, we're skipping the block
group profile checks for the conventional zones.

This allows converting a zoned filesystem's data block groups to RAID when
all of the zones backing the chunk are on conventional zones.  But this
will lead to problems, once we're trying to allocate chunks backed by
sequential zones.

So also check for conventional zones when loading a block group's profile
on them.

Reported-by: HAN Yuwei <hrx@bupt.moe>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
---
 fs/btrfs/zoned.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9716456bce0..e43c689b1253 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1637,6 +1637,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
+	/* Reject non SINGLE data profiles without RST */
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
+	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
 	if (cache->alloc_offset > cache->zone_capacity) {
 		btrfs_err(fs_info,
 "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
-- 
2.43.0


