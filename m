Return-Path: <linux-btrfs+bounces-21596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A0cEM4Qi2l/PQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21596-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B98119F6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D84613015DB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725323612C5;
	Tue, 10 Feb 2026 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f9OCxC4n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAA34216C
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721477; cv=none; b=dala2mht2pyVta7tMQoC+d6Aul9PKFs1BaEFZl8gLcUc7iJxcOcZ0ES4FHWd8JTZDPU8EynEItdjmV8qD9jNRz7qbqer6VjcGy0sFiiHbOCbqczIpU9o44aczSU0rfHrC11ivS2p++ummZbIWQbFmUsMaIxtIE5W0E1bNOTubWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721477; c=relaxed/simple;
	bh=a/qUZBJ9sqRMVU6Xa0kTEgGQweGhCDri33EdXUS5eew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4USHuToHGjCp2g9fsC17ehdrocXtpTOg0EYKHEUFERYWiNlyldnLBaCyB44ZF1hOySWUDAK9XiohGYJ5LkZyJ6NSF5NyYN+TymB3vcnk0OQsrk2Xbr8QWNlpAUT8Szm+b/VKOWEJNoMqXuMse/p1QrMWDad1maFeHMn4QMHd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f9OCxC4n; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770721474; x=1802257474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/qUZBJ9sqRMVU6Xa0kTEgGQweGhCDri33EdXUS5eew=;
  b=f9OCxC4nERDvgjz5iEV3Rz4xNi9QL2J9l272Jwg+o2miWVElBLZIO8V3
   ytkushrEzmjuKC4YBPJ1upHgmi8NwL43wj3t/KOruDfQMqYgJEz/OOYc1
   SeGgpuHrTfA3Hcuq9+4cG5UjWeKVmeyIifDhj9/LIOouUGrciBXV2/vzw
   XbLCEqWrxqwih8O+9q7oLfcH26giMIIABZCh9kQAjtDkVoOrNVrL6puZL
   hkbbaid871150PE39IGYAS7jgf05HcVT8MIbCaooQVhZmp+axXak6vbVw
   CCfYg16A+Ud1Su+Nmuflp56AlVfmNIS4iV2YiIF/MQ/Tr8FrXBI0hLpS1
   g==;
X-CSE-ConnectionGUID: 42+rCIlDQS2+cWpcVswMFg==
X-CSE-MsgGUID: GNDpqKfsQ1qP49+T4d+5aQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136948400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 19:04:34 +0800
IronPort-SDR: 698b10c4_cIwW5khaq3SNNAReltQNsGszt7GLRJqoOlkoCWmzD8cLB7n
 OUvvsvEnFvVl4gOd3FDjM+j6/N7vGFz8181DDAQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 03:04:36 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2026 03:04:33 -0800
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
Subject: [PATCH v3 2/3] btrfs: zoned: move partially zone_unusable block groups to reclaim list
Date: Tue, 10 Feb 2026 12:04:22 +0100
Message-ID: <20260210110423.264476-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210110423.264476-1-johannes.thumshirn@wdc.com>
References: <20260210110423.264476-1-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21596-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: C7B98119F6E
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 764caaf1d8b2..e3e7852dd3e0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1597,6 +1597,24 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
+
+		if (btrfs_is_zoned(fs_info) && btrfs_is_block_group_used(block_group) &&
+		    block_group->zone_unusable >= div_u64(block_group->length, 2)) {
+			/*
+			 * If the block group has data left, but at least half
+			 * of the block group is zone_unusable, mark it as
+			 * reclaimable before continuing with the next block group.
+			 */
+
+			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
+			up_write(&space_info->groups_sem);
+
+			btrfs_mark_bg_to_reclaim(block_group);
+
+			goto next;
+		}
+
 		if (btrfs_is_block_group_used(block_group) ||
 		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
 		    list_is_singular(&block_group->list) ||
-- 
2.53.0


