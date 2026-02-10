Return-Path: <linux-btrfs+bounces-21595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEo9Dw4Ri2nAPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21595-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:05:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97670119FB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7DD307AA78
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80836165A;
	Tue, 10 Feb 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RHZXZlbB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC6361652
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721474; cv=none; b=QWE9ELKBBDtw7L7lB2DI4KMt91XicP0I5/UbEHBWYbn13lYgW18O24M3o/cSy+riDTavaAjWpO4/OPcXLy4XoyBM+46jqUvS2SzmpWzaAxq/d4CKOFKCFnb75Zg+Ng7CvHooL2JwmCZTSyWAtoi6RKVqriazaDSYsq0jSvxYixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721474; c=relaxed/simple;
	bh=LN9SvrRIn8CBMix/KBjE3d2ARlbHHZdZ5DVRFgZr3yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNtyeNTpV0ctr5QCziVHaKLuQCyhVBJrtP7lTAMNvhREh66L17NqfFMi/zUcH9yaTw35CgECAc9zWIqNd0xf0fxZHilYBx5EcjCeZcUF+0+bYmhRJ3l7Rk/ITdc3RBfeXDPYCxv68+R3bgChvvIz499IsFMJfatNJXO4KmBHWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RHZXZlbB; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770721471; x=1802257471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LN9SvrRIn8CBMix/KBjE3d2ARlbHHZdZ5DVRFgZr3yQ=;
  b=RHZXZlbB11G0kb0pIiZRg2UA1bXqsnHospBa3xh9KzoD6fihsr1b62Xj
   fNki54jOm6HT0rlsrvKGEd+9/70173gIGZ7ZPEN9y5yr71KfCAnm9yUQ1
   uae+UiyOqzQiu2pyfgSULaYrc9wAUTXMRhLCsNu1pp7bduo5E6i/jhhyF
   fXbycDKK5T0w8O8GVozg9YZK1K7kbrpJR4HI1j97E+IBffe1qwVOqhdkO
   iDoY9WnLsg1Nb/iPo1k7hyQdFQLebuOLZcw6lZ6NKKKQcGTzK5+0211or
   1W5knOX1Ver39zBKNOsT/+u/xeTra2eUQBky02PquLrcghFoKGuDS4OJ1
   w==;
X-CSE-ConnectionGUID: xWO7LkRVTSa8bTZK/a58XQ==
X-CSE-MsgGUID: dv4qUyBsSq2sfJBevNQeCw==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136948398"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 19:04:31 +0800
IronPort-SDR: 698b10c0_+/1LeYyYglhxHLzTqMrM7xMB1OziWEEeJmgBeRpYUUMCcfj
 SscCaqq2lwewdqyW/D4WzfKpnQVQcX2Pg7F85/Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 03:04:32 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2026 03:04:29 -0800
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
Subject: [PATCH v3 1/3] btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit
Date: Tue, 10 Feb 2026 12:04:21 +0100
Message-ID: <20260210110423.264476-2-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21595-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 97670119FB9
X-Rspamd-Action: no action

On zoned filesystems metadata space accounting can become overly optimistic
due to delayed refs reservations growing without a hard upper bound.

The delayed_refs_rsv block reservation is allowed to speculatively grow and
is only backed by actual metadata space when refilled. On zoned devices this
can result in delayed_refs_rsv reserving a large portion of metadata space
that is already effectively unusable due to zone write pointer constraints.
As a result, space_info->may_use can grow far beyond the usable metadata
capacity, causing the allocator to believe space is available when it is not.

This leads to premature ENOSPC failures and "cannot satisfy tickets" reports
even though commits would be able to make progress by flushing delayed refs.

Analysis of "-o enospc_debug" dumps using a Python debug script
confirmed that delayed_refs_rsv was responsible for the majority of
metadata overcommit on zoned devices. By correlating space_info counters
(total, used, may_use, zone_unusable) across transactions, the analysis
showed that may_use continued to grow even after usable metadata space
was exhausted, with delayed refs refills accounting for the excess
reservations.

Here's the output of the analysis:

  ======================================================================
  Space Type: METADATA
  ======================================================================

  Raw Values:
    Total:                256.00 MB (268435456 bytes)
    Used:                 128.00 KB (131072 bytes)
    Pinned:                16.00 KB (16384 bytes)
    Reserved:             144.00 KB (147456 bytes)
    May Use:              255.48 MB (267894784 bytes)
    Zone Unusable:        192.00 KB (196608 bytes)

  Calculated Metrics:
    Actually Usable:       255.81 MB (total - zone_unusable)
    Committed:             255.77 MB (used + pinned + reserved + may_use)
    Consumed:              320.00 KB (used + zone_unusable)

  Percentages:
    Zone Unusable:    0.07% of total
    May Use:         99.80% of total

Fix this by adding a zoned-specific cap in btrfs_delayed_refs_rsv_refill():
Before reserving additional metadata bytes, limit the delayed refs
reservation based on the usable metadata space (total bytes minus
zone_unusable). If the reservation would exceed this cap, return -EAGAIN
to trigger the existing flush/commit logic instead of overcommitting
metadata space.

This preserves the existing reservation and flushing semantics while
preventing metadata overcommit on zoned devices. The change is limited to
metadata space and does not affect non-zoned filesystems.

This patch addresses premature metadata ENOSPC conditions on zoned devices
and ensures delayed refs are throttled before exhausting usable metadata.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

If anyone's interested, if pushed the space_info analysis tool to:
https://github.com/morbidrsa/debug-scripts/blob/master/analyze-space_info.py
---
 fs/btrfs/delayed-ref.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/transaction.c |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e8bc37453336..a4f968062fcd 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -207,6 +207,30 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info)
  * This will refill the delayed block_rsv up to 1 items size worth of space and
  * will return -ENOSPC if we can't make the reservation.
  */
+static int btrfs_zoned_cap_metadata_reservation(struct btrfs_space_info *space_info)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
+	u64 usable;
+	u64 cap;
+	int ret = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	spin_lock(&space_info->lock);
+	usable = space_info->total_bytes - space_info->bytes_zone_unusable;
+	spin_unlock(&space_info->lock);
+	cap = usable >> 1;
+
+	spin_lock(&block_rsv->lock);
+	if (block_rsv->size > cap)
+		ret = -EAGAIN;
+	spin_unlock(&block_rsv->lock);
+
+	return ret;
+}
+
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush)
 {
@@ -228,6 +252,10 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!num_bytes)
 		return 0;
 
+	ret = btrfs_zoned_cap_metadata_reservation(space_info);
+	if (ret)
+		return ret;
+
 	ret = btrfs_reserve_metadata_bytes(space_info, num_bytes, flush);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index aea84ac65ea7..746678044fed 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -678,6 +678,14 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * here.
 		 */
 		ret = btrfs_delayed_refs_rsv_refill(fs_info, flush);
+		if (ret == -EAGAIN) {
+			ASSERT(btrfs_is_zoned(fs_info));
+			ret = btrfs_commit_current_transaction(root);
+			if (ret)
+				goto reserve_fail;
+			ret = btrfs_delayed_refs_rsv_refill(fs_info, flush);
+		}
+
 		if (ret)
 			goto reserve_fail;
 	}
-- 
2.53.0


