Return-Path: <linux-btrfs+bounces-20949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDOQHx4vc2mTswAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20949-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 09:19:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F73F72566
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 09:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D7A30A95F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179DD308F2E;
	Fri, 23 Jan 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P29ieWc+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508D353ED9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156090; cv=none; b=Q3vOpeTHSr2uTo1p0MSor0yHqaZlcN9RJkqTsGSSi4zw7K0SsEq/yNnskmPzEfZ+nz4xsGog6yTXFMCloeWnDOdm4yAw44+iH/Hd0PWmA+92LRufYs2OJnUt6vuBk5nBaXWV9SK0z1ziIxmCNUEySd+pTRoZdyo1T9fQz5oKT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156090; c=relaxed/simple;
	bh=TYDjoFSHdEaYWFoSp3EvaRwZN8v+ITLEUmng3LiXfec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3/AVZMyRJa12XOb8LCIe+8Hl2wCSneTv6P3bMndvtA4Yh3RGxToF6CDXefzlHn3NSI+HeZagHkECIOvXRBtN4oHwKKT2ehwC/god9KcvB9mu/hvlubcxz+3aI82pOsbZNwY1eIA44K0K3temTO/HLWA3rOflxQoVpl8sDD1bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P29ieWc+; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769156087; x=1800692087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TYDjoFSHdEaYWFoSp3EvaRwZN8v+ITLEUmng3LiXfec=;
  b=P29ieWc+DOlsfeQbEsIMzZ6YjgJleLDC6hpzFmN9PVcWw0UQFnWlxNJL
   yyyb7khtwydkCYu2bN6VD/vuv+VQI4Ggpk7Yu4+xX1zeTNWFcvS3/rwrs
   dNpy2/qrpPkug22WpnqQg8qOpAK2/pMJ3y60ikjMSwX765NmyTxMUldeK
   a5dpSN1sUts+suiTPHS7cUVob8z3FavlL3XhjkGQhB54Tc6q3/gGkM8MR
   K6iDQa2J1v98yhlu7uAUrbZojz+OZQUGOi+4YWw8mdSqUNH0zQHBZmURC
   rMiEoKwruy82I9AVMApkDbJZD+WdB+ys8vwyHbYHTLxkoKkvvNZAGmHmr
   Q==;
X-CSE-ConnectionGUID: UvMt2dbiQ5+t/N7Lzwm57A==
X-CSE-MsgGUID: xGjWQESjTPeiGhQ5Op8ctg==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="138579393"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 16:14:46 +0800
IronPort-SDR: 69732df8_dIZwPULQ5X+tM9/RsUxRLaz8lxqfoZ2Ylyrt2JzF8kbwn6f
 q5yHfRI3URMzsuTFHlV051U7Q+zYDiuEUNqs1LQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 00:14:48 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.65])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2026 00:14:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: use local fs_info variable in btrfs_load_block_group_dup
Date: Fri, 23 Jan 2026 09:14:44 +0100
Message-ID: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20949-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 1F73F72566
X-Rspamd-Action: no action

btrfs_load_block_group_dup() has a local pointer to fs_info, yet the
error prints dereference fs_info from the block_group.

Use local fs_info variable to make the code more uniform.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1ad4147d8bae..f74bd9099d8a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1438,13 +1438,13 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
 	if (unlikely(zone_info[0].alloc_offset == WP_MISSING_DEV)) {
-		btrfs_err(bg->fs_info,
+		btrfs_err(fs_info,
 			  "zoned: cannot recover write pointer for zone %llu",
 			  zone_info[0].physical);
 		return -EIO;
 	}
 	if (unlikely(zone_info[1].alloc_offset == WP_MISSING_DEV)) {
-		btrfs_err(bg->fs_info,
+		btrfs_err(fs_info,
 			  "zoned: cannot recover write pointer for zone %llu",
 			  zone_info[1].physical);
 		return -EIO;
@@ -1465,7 +1465,7 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 	}
 
 	if (unlikely(zone_info[0].alloc_offset != zone_info[1].alloc_offset)) {
-		btrfs_err(bg->fs_info,
+		btrfs_err(fs_info,
 			  "zoned: write pointer offset mismatch of zones in DUP profile");
 		return -EIO;
 	}
-- 
2.52.0


