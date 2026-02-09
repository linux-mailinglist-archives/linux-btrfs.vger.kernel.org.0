Return-Path: <linux-btrfs+bounces-21551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCEcEFnxiWnGEgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21551-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:38:17 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194F110972
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A737D3009892
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E637BE75;
	Mon,  9 Feb 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p/6mECQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744B276028
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647885; cv=none; b=bTWU6LQmb19ia/q0ZVintlem4dk/44jgLSDNpWpgWsCQVgOEp1tfdmqncxf6olkMcZzB/zZtT6nZ+L2Uc1fVflvB/3izs0/r75Z4WBR7vTihJfK0VGOGTM04XDlFRSx0EYiiK0zu1X57jweG5GajrpJ9ASlOtlJ0FeJF/Xxts9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647885; c=relaxed/simple;
	bh=shdzCTzP06icgL7wuo66uUyWYPSmRJ4z1ZqCerr35dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7PobYLUR6AA0oHLWdqEP6INhVanDq2u7Q+n/8J1gAultabVbUIB+U82W8jOmwuQOj966fPrCqq+vdQHe7C2NszBtf4R5vLSxv8IH69PDz6/DkfNzZfDWxKowc6/HLrBOgr354A+iVF69vgRMV7krfbmCZsbuQ2Cx+q9fjxo19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p/6mECQK; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770647883; x=1802183883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shdzCTzP06icgL7wuo66uUyWYPSmRJ4z1ZqCerr35dw=;
  b=p/6mECQKCF8xxSpcm4m3BK4Ouku0Q8Ftb4ICLj6NaNPgnUl7yDZt3NaW
   6KoLnF34Wb1Q8P2iQV8S5Wh9NDOdRbabf7f/X8mGhGHZUACaR3q+HC7jU
   bcwPYB2uw6wDy/jofpswadNatkuVvi1hHno6xPu7zs0gFhT0qthu2T4D3
   sc4eafBUPAWsosp6X3MzKrsd5/z7/g5aLC8l6BVoELcJMhNqfFyUBpXfT
   0wIr3/F4zZmH6DdCoX9zLbv3+61GtaUrtE0/CIw0401LqfKCY7+ipwYa7
   yvUQ38cTeZJuLFm++Dtvh9WgX30cXtN1stLh6UiiCblphBywxWv9/6oa/
   A==;
X-CSE-ConnectionGUID: BQxs9RySR9q1nGxNpn9S5Q==
X-CSE-MsgGUID: xs+2u0aRRZKevBYcxROiuQ==
X-IronPort-AV: E=Sophos;i="6.21,282,1763395200"; 
   d="scan'208";a="141537549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2026 22:37:01 +0800
IronPort-SDR: 6989f10f_sGjSDPezWKYi4V3JsYeM/g6FMszFk0SBPBZ+J8ymWPwmOIL
 pJTojanizmorgBeasBghOAgLqOUgA9vmkYluctg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2026 06:37:03 -0800
WDCIronportException: Internal
Received: from f170w04lxh.ad.shared (HELO neo.fritz.box) ([10.224.28.114])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Feb 2026 06:37:01 -0800
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
Subject: [PATCH 3/3] btrfs: zoned: add zone reclaim flush state for DATA space_info
Date: Mon,  9 Feb 2026 15:36:44 +0100
Message-ID: <20260209143644.96411-4-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21551-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0194F110972
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
 fs/btrfs/space-info.c | 12 ++++++++++++
 fs/btrfs/space-info.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bb5aac7ee9d2..1d5d4f33116d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -902,6 +902,17 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
+	case RECLAIM_ZONES:
+		ret = 0;
+		if (btrfs_is_zoned(fs_info)) {
+			btrfs_reclaim_sweep(fs_info);
+			btrfs_delete_unused_bgs(fs_info);
+			btrfs_reclaim_bgs(fs_info);
+			flush_work(&fs_info->reclaim_bgs_work);
+			ASSERT(current->journal_info == NULL);
+			ret = btrfs_commit_current_transaction(root);
+		}
+		break;
 	case RUN_DELAYED_IPUTS:
 		/*
 		 * If we have pending delayed iputs then we could free up a
@@ -1400,6 +1411,7 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_FULL,
 	RUN_DELAYED_IPUTS,
 	COMMIT_TRANS,
+	RECLAIM_ZONES,
 	RESET_ZONES,
 	ALLOC_CHUNK_FORCE,
 };
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0703f24b23f7..4359e3a89b41 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -96,6 +96,7 @@ enum btrfs_flush_state {
 	RUN_DELAYED_IPUTS	= 10,
 	COMMIT_TRANS		= 11,
 	RESET_ZONES		= 12,
+	RECLAIM_ZONES		= 13,
 };
 
 enum btrfs_space_info_sub_group {
-- 
2.53.0


