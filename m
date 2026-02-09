Return-Path: <linux-btrfs+bounces-21550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB5/Jj/ziWl+EwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21550-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:46:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D850110EBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1279D316E55B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9B37BE8C;
	Mon,  9 Feb 2026 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z+3l0FPE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629537BE72
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647882; cv=none; b=gnS6CEFT5pCrkNkcAY7WecmZM23ILYgjxSN7x/QHiLl9z3vc9SMOv0Yi64T/W91OIK7unGaIkdr7GhU3UqJinFoXhxALqOZIrJSP1KicfRbEI9eztg1y5LTo3VRHzoI6uFUCpv+ITX6B3H3ySCeMax7yS21cwMVlpmGCPtuO+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647882; c=relaxed/simple;
	bh=vMRDskaLOXI8RTZukBbyGWagYJExX+AK3Vq2JPJ4Msw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM0VeKL0s2f1sPBniP6oRCnZpi5wtQd5MdXRrpNOhCwLqkjJMf5r/Xns4DABu0i7CpWSa2WRFTddMn2yuRzPQgt7Cxl3u486m/NCxgporF2oPXF9xA7HH1OuF9Bb7Qo/Gh+O3SpbaCOr6dl+uWN66DBxysHdHXaMBaXqMYx3RsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z+3l0FPE; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770647880; x=1802183880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMRDskaLOXI8RTZukBbyGWagYJExX+AK3Vq2JPJ4Msw=;
  b=Z+3l0FPEvTY3VXxn3XLgFXOC8z8NPMDxd1pf8cNT9k+XJLxWA1EbTtX8
   8NV13hvXjlILBmpHL+bqALA7wJCj1P9eawXF5kxV9TnlGoV2FAOJoN5yP
   /0VzVo886wuSvp7PLWtBW0sV6cAN2+Qj92LcqJU+ZDW1ESdH1hP6WO57B
   wR0FepdPbbFCwTaIynUfFLjpltfWDqH7tS5QY+tv0wtJMxLxnsG/XXEwG
   J/HDl5TSdCIc+8TnAfoVrGyVQYMfbDUkAvC4biikxS0eUj4w+YGlJExlw
   VQ/pToBTCPTg2SZ0foGVeFnLgSYHC1R79qpFaav7gjdQnrsKhq/GTzjNd
   g==;
X-CSE-ConnectionGUID: gxpG5WifS7GAeClq5tKLpQ==
X-CSE-MsgGUID: whnjkO3jQ2+HWsK3EIJr6A==
X-IronPort-AV: E=Sophos;i="6.21,282,1763395200"; 
   d="scan'208";a="141537547"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2026 22:36:58 +0800
IronPort-SDR: 6989f10c_0oXuGOZ5UKoRLd4EhzFqyqJ5jXJmkup9FJHJgoMRh+It8Fm
 7/UBOs961QwVn/STBF4q5UbLrTUu7muG+Dsd/hw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2026 06:37:00 -0800
WDCIronportException: Internal
Received: from f170w04lxh.ad.shared (HELO neo.fritz.box) ([10.224.28.114])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Feb 2026 06:36:58 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: zoned: move partially zone_unusable block groups to reclaim list
Date: Mon,  9 Feb 2026 15:36:43 +0100
Message-ID: <20260209143644.96411-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209143644.96411-1-johannes.thumshirn@wdc.com>
References: <20260209143644.96411-1-johannes.thumshirn@wdc.com>
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
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21550-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[wdc.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,wdc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D850110EBD
X-Rspamd-Action: no action

On zoned block devices, block groups accumulate zone_unusable space
(space between the write pointer and zone end that cannot be allocated
until the zone is reset). When a block group becomes mostly
zone_unusable but still contains some valid data and it gets added to the
unused_bgs list it can never be deleted because it's not actually empty.

The deletion code (btrfs_delete_unused_bgs) skips these block groups
due to the btrfs_is_block_group_used() check, leaving them on the
unused_bgs list indefinitely. This causes two problems:
1. The block groups are never reclaimed, permanently wasting space
2. Eventually leads to ENOSPC even though reclaimable space exists

Fix by detecting block groups where zone_unusable exceeds 50% of the
block group size. Move these to the reclaim_bgs list instead of
skipping them. This triggers btrfs_reclaim_bgs_work() which:
1. Marks the block group read-only
2. Relocates the remaining valid data via btrfs_relocate_chunk()
3. Removes the emptied block group
4. Resets the zones, converting zone_unusable back to usable space

The 50% threshold ensures we only reclaim block groups where most space
is unusable, making relocation worthwhile. Block groups with less
zone_unusable are left on unused_bgs to potentially become fully empty
through normal deletion.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3186ed4fd26d..1fb23834d90c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1597,6 +1597,22 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
+
+		if (btrfs_is_zoned(fs_info) && btrfs_is_block_group_used(block_group) &&
+		    block_group->zone_unusable > div_u64(block_group->length, 2)) {
+			/*
+			 * If the block group has data left, but at least half
+			 * of the block group is zone_unusable, mark it as
+			 * reclaimable before continuing with the next block group.
+			 */
+			btrfs_mark_bg_to_reclaim(block_group);
+
+			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+
 		if (btrfs_is_block_group_used(block_group) ||
 		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
 		    list_is_singular(&block_group->list) ||
-- 
2.53.0


