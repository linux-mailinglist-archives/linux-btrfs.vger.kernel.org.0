Return-Path: <linux-btrfs+bounces-19708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBECBA4EB
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 06:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C941D30C6503
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 05:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028E233711;
	Sat, 13 Dec 2025 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UNRRN8WN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70C182D2
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602211; cv=none; b=Dd724pWEQAfylkJsaC4buyv6Jc4a4jOBPAfqcPvr7im8J1sNSZcKBmWwz3IA4EJUbXyo7WTn9nvzHx/Rzgc7ZZ1P3Ys+FJ7zIo9+PEJ6SqC2n9aiXkUSbX9+6TX4/cnoXAKOQPMSW095zgJvGJoyebxqcYscU6htRxGqr/YDTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602211; c=relaxed/simple;
	bh=7ZTC6WtNlS5Vq0f4vM6kvzX3oENKA9IpDvPjX+FIRdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHrfDVLHOpL3cEGc53YdkoHwg6j60Arg3yvnzfqL8a9LjVjeF2RikZHfaEQUcg7DqiwKvzrm7W3aJs3M93llr0FuD36Tdzx2TFOuf4HFPMCg9kUoVJQzsygot9AINL721FPnLCa9h22GKM0BkC/TF2EoTyEQKSTO7vyEihTnaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UNRRN8WN; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765602209; x=1797138209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZTC6WtNlS5Vq0f4vM6kvzX3oENKA9IpDvPjX+FIRdc=;
  b=UNRRN8WNuoip8P2IUbyb2TDOMFUdUBtcFINdBeS1IxA/x7HwSwk0Zhxx
   b3SxtjAt/JDiFIqRLpy4flG6nW3jeNNzHM+MrYM6M1gmaUIUl7lHnyKOn
   o790pg3umVZvX1abC3iXILbDbg1RWN8/iHqdqqqJIl030AiiwR4njX/GD
   DC2e+2CxWoWYF7fWx6fwOmiZryBSLsAIrIypmItkOmgXb4Z5tH3ehh7wH
   v7Cz7MHkxm1Bb97lLKb/nTz5c1eS8ov6F1Q3W+29V4Y2fsBpFcCU1Ccq2
   O5BmoiD3FNEgbSUN2QomxcME8rz0wmem2+wDkm+7TEAknhVrju/M1ytGe
   Q==;
X-CSE-ConnectionGUID: FvyQai+/T56D1Nx34XnT8Q==
X-CSE-MsgGUID: bN3Ig0NCQfmW3u0CThbMYg==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136986300"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2025 13:03:29 +0800
IronPort-SDR: 693cf3a1_NXMpEltqkjoBPTespbKzR43jUZgviSAUesT+yT8j2r48Lbr
 JDpmysJhE6vy82MILQC77+aH7Y8HPx942xlvl3g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 21:03:30 -0800
WDCIronportException: Internal
Received: from 5cg21747lt.ad.shared (HELO neo.wdc.com) ([10.224.28.121])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2025 21:03:26 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 3/4] btrfs: zoned: print block-group type for zoned statistics
Date: Sat, 13 Dec 2025 06:03:04 +0100
Message-ID: <20251213050305.10790-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the zoned statistics, also include the block-group type in
the block-group listing output.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 41c6b58556a9..6983e7177c0a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3021,9 +3021,9 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 	seq_puts(s, "\tactive zones:\n");
 	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
 		seq_printf(s,
-			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
 			   bg->start, bg->alloc_offset, bg->used, bg->reserved,
-			   bg->zone_unusable);
+			   bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
-- 
2.52.0


