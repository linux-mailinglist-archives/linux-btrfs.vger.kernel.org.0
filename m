Return-Path: <linux-btrfs+bounces-21582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDYhGU7fimlIOgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21582-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:33:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D2117F73
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 583A33031B1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADD32B98C;
	Tue, 10 Feb 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I4WtFGXN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024122D24B7
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708805; cv=none; b=PNALRCrTYDxWhtvid2SHtE07XRk8mSKPdd4PVv7/si9j7lONTLwMEhyQcb4XfMXbAFJjP4KEW4IV881439CUj59mzeNWn2xSUZFsLmB0eLFRw9cPEd99ptnAcEw6zpLm5gAM2AGDzSJV2nq7Ny7TEM51HE4ne6n0xQkjONgIf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708805; c=relaxed/simple;
	bh=fFMAwfd8PfxD2b4scdf9pijojxbqkn9JTtWQL0I6TeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCmkR9V21LIlctW8eQmNDSEvdOpwDI+6BDwUpt/+NpGBpBIcbYGFwJ7d1YovM6QXVwjUNmiw2Davsd1q3SK9XjJc0v/AxEWaHWZhGZ1Sx9kfIhrXn3QjYrjBiwkN/a0H3Z3gx0m3xz6YFTGPII0N7vHG8ZFfip80bKhGud9NyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I4WtFGXN; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770708804; x=1802244804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fFMAwfd8PfxD2b4scdf9pijojxbqkn9JTtWQL0I6TeY=;
  b=I4WtFGXNh3LTsibmzVBVU7HIzhZBM5rkigSBUnye4tcZUJlsvAefj1NM
   la+JcCmZjiRR82CH8o59cjQ7aG4ZREMlvt+vHdzf+R7yw8XPXvCKAL8nB
   flvrsUk0Qz/hNiA2GKADVZA2qez8ogrjO7WsXsTHXKZE5Weffv+XaQ10w
   UqR9vbVjafMs82rNbuQRaQlF8p1sYigeegOh/ZL09hr9V7M3VnFjhMc50
   iNT7lFB85seT9aPGuLrWuNPyKbPs/wjcTlGGo4lY1VHFhvjwP1GInm0op
   tPN53MAL+ngU7vigVj4AWKUehYdM3TsUQgYFG9ke2MW0i5aHMVu9gU5bO
   A==;
X-CSE-ConnectionGUID: og+zUuN3QwGHYnb4yHu/KQ==
X-CSE-MsgGUID: lrsBiyMDRG6vXjp+dMCy/g==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="139583139"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 15:33:23 +0800
IronPort-SDR: 698adf43_hWut44CckLbQmdrh6UQPIJ4+CBc/TWtFqVAOrc9KAxJfHTa
 ucu5Uor2xq1+ci1Kz+KykrdyE+RxhNdQfU4kgvg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2026 23:33:23 -0800
WDCIronportException: Internal
Received: from c2qdky46rp.ad.shared (HELO neo.fritz.box) ([10.224.28.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Feb 2026 23:33:21 -0800
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
Subject: [PATCH v2 3/3] btrfs: zoned: add zone reclaim flush state for DATA space_info
Date: Tue, 10 Feb 2026 08:33:09 +0100
Message-ID: <20260210073309.195274-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210073309.195274-1-johannes.thumshirn@wdc.com>
References: <20260210073309.195274-1-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21582-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D37D2117F73
X-Rspamd-Action: no action

On zoned block devices, DATA block groups can accumulate large amounts
of zone_unusable space (space between the write pointer and zone end).
When zone_unusable reaches high levels (e.g., 98% of total space), new
allocations fail with ENOSPC even though space could be reclaimed by
relocating data and resetting zones.

The existing flush states don't handle this scenario effectively - they
either try to free cached space (which doesn't exist for zone_unusable)
or reset empty zones (which doesn't help when zones contain valid data
mixed with zone_unusable space).

Add a new RECLAIM_ZONES flush state that triggers the block group
reclaim machinery. This state:
- Calls btrfs_reclaim_sweep() to identify reclaimable block groups
- Calls btrfs_reclaim_bgs() to queue reclaim work
- Waits for reclaim_bgs_work to complete via flush_work()
- Commits the transaction to finalize changes

The reclaim work (btrfs_reclaim_bgs_work) safely relocates valid data
from fragmented block groups to other locations before resetting zones,
converting zone_unusable space back into usable space.

Insert RECLAIM_ZONES before RESET_ZONES in data_flush_states so that
we attempt to reclaim partially-used block groups before falling back
to resetting completely empty ones.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 22 ++++++++++++++++++++++
 fs/btrfs/space-info.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 243b2593d4bc..b174c68a5ebb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -129,6 +129,15 @@
  *     churn a lot and we can avoid making some extent tree modifications if we
  *     are able to delay for as long as possible.
  *
+ *   RECLAIM_ZONES
+ *     This state only works for the zoned mode. In zoned mode, we cannot reuse
+ *     regions that have once been allocated and then been freed until we reset
+ *     the zone, due to the sequential write requirement. The RECLAIM_ZONES state
+ *     calls the reclaim machinery, evacuating the still valid data in these
+ *     block-groups and relocates it to the data_reloc_bg. Afterwards these
+ *     block-groups get deleted and the transaction is committed. This frees up
+ *     space to use for new allocations.
+ *
  *   RESET_ZONES
  *     This state works only for the zoned mode. On the zoned mode, we cannot
  *     reuse once allocated then freed region until we reset the zone, due to
@@ -905,6 +914,18 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
+	case RECLAIM_ZONES:
+		if (btrfs_is_zoned(fs_info)) {
+			btrfs_reclaim_sweep(fs_info);
+			btrfs_delete_unused_bgs(fs_info);
+			btrfs_reclaim_bgs(fs_info);
+			flush_work(&fs_info->reclaim_bgs_work);
+			ASSERT(current->journal_info == NULL);
+			ret = btrfs_commit_current_transaction(root);
+		} else {
+			ret = 0;
+		}
+		break;
 	case RUN_DELAYED_IPUTS:
 		/*
 		 * If we have pending delayed iputs then we could free up a
@@ -1403,6 +1424,7 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_FULL,
 	RUN_DELAYED_IPUTS,
 	COMMIT_TRANS,
+	RECLAIM_ZONES,
 	RESET_ZONES,
 	ALLOC_CHUNK_FORCE,
 };
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 6f96cf48d7da..174b1ecf63be 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -113,6 +113,7 @@ enum btrfs_flush_state {
 	RUN_DELAYED_IPUTS	= 10,
 	COMMIT_TRANS		= 11,
 	RESET_ZONES		= 12,
+	RECLAIM_ZONES		= 13,
 };
 
 enum btrfs_space_info_sub_group {
-- 
2.53.0


