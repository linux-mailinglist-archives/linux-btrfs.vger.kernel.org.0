Return-Path: <linux-btrfs+bounces-21597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPsZJs0Qi2l/PQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21597-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A9119F67
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E9E7301C960
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E834CFDA;
	Tue, 10 Feb 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QygVupFg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD8341AC5
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721481; cv=none; b=XwxNA4UPz0aPXvfctw1sNSVSX+udSTQIZM51EqGJUVs892ejfa16lk5zz6Bcny3KcSuAkBA0+mKW3et8uDC35s9xdpdYYZzQJ4zNQwyYrxOuwMPvdxAWR8y0DSZ/mJuVi1c4ExJa7S8188UxPl+mWsOdIILfY9iwATY35/wnk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721481; c=relaxed/simple;
	bh=TexqHI6LZ8RaXbvYA4aT0HAHBiuLLYDFtRBgfvxILbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owI8csk2YOkVmjZinM68ntJsnEyeQQpRSyvwnPzVeC/sDfaE5RnA15V8CRXCiQgTxT6BKNOe5sjpLA+Wcm96ByghewWTTymvGyPkXFSLBwA58yjZ3nXvMFkWuRctJMHsSK4G/9sueSOO+b+p5gLd7pATN/gv5Kw9UXhyYQl2Qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QygVupFg; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770721478; x=1802257478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TexqHI6LZ8RaXbvYA4aT0HAHBiuLLYDFtRBgfvxILbE=;
  b=QygVupFgleq8esyICwcOAmxg+bhy8YjB9GF+P186t9aX60pF32rODtPC
   eQE/sjAQIHbqWfcj/mXoHM/Zoq3+V/lQrkCs4SF8q6H4GUSq9pFM7FvU+
   SFcC82VEhPxj8dX9iFtwajoyhXghnOxn+g3i6sQgjpmN9sQYLqQmy6z7S
   m84kMGYlK/IqyBC2KfhWj9/X7SjnBX+osLZpKsu+QJugDaVZvXQKPbNNB
   0ZcN4xLxK3KCZLXQrkZZ28lSHYhza2TiEA0vaKzn+wXUl+VIsbDFuT1E3
   wpJ9crNBSiCouN4MliyZFzbaWXCsPcHsHOy8i99ST6sIu3acoOMvl67vD
   Q==;
X-CSE-ConnectionGUID: voQOPwcLQJCGCi9dKqa8Cw==
X-CSE-MsgGUID: 9z0uR8UNQGSzpm6hnruJxQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136948401"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 19:04:38 +0800
IronPort-SDR: 698b10c8_e2PdKyt1SwfpQebs99eAgzXZpCV+6xBp92xSGyAThz8iOrT
 P/W3up30NtttpqGBmgtQAHB+xEZvPX/4eQYWh3g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 03:04:40 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2026 03:04:36 -0800
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
Subject: [PATCH v3 3/3] btrfs: zoned: add zone reclaim flush state for DATA space_info
Date: Tue, 10 Feb 2026 12:04:23 +0100
Message-ID: <20260210110423.264476-4-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21597-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 031A9119F67
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


