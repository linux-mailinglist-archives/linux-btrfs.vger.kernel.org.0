Return-Path: <linux-btrfs+bounces-20961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JVaMKpsc2mnvgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20961-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:42:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA475EE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216213026892
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E131A280336;
	Fri, 23 Jan 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+RYFAgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB429A9C9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172132; cv=none; b=qACJuygsFXJnxAb8+2YvFlH18xtl4fhBRT5TO5B/hJjMYKZy9J5pN58UyKK+WH25DFkrOw134Ea6l/NB/uOWyROR0RQMetLkv2rAYaTzow4utrCWdNp8V/OpHs/rklYySvNfj9OzeNGbf2qzQ/hwSY+NV+hRMlknn4nTVEIqWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172132; c=relaxed/simple;
	bh=Jc4q5xT/SGfsinB4rcZhBgrvrFvkcdPakSXhO0KC5fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TccW2qZ0dn5zlq2kQ8LBipMfWoezC/+uK9+wnaA2SDOQl2Q8GCjnyW48GIQHGcvgAvxCXGGdMtHoSeQnfHf9Ay4dehwJml0as+l6Rqsc/0QnE673Z3SJu24UquWL8FtYhGLoagkRZ0sNF60sBxn3CeUEQGIwmOZzxovPHHZX5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e+RYFAgZ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769172130; x=1800708130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jc4q5xT/SGfsinB4rcZhBgrvrFvkcdPakSXhO0KC5fE=;
  b=e+RYFAgZczfS+KF8JecWPEir/O+AZUUCxjKozV2kx+qRTjVa07bhrQ/l
   zJPFM8blN1kFmcd0KIWfXdbOkmt2alB6rZfmYqveoFOieuEuElcmpANXX
   gqJjv8VS57tzIESDlxa3t/vLk0GXpxYA26JCG0c/922U64Fl4F4wMqROG
   rxrwmlWUIXWw4/9TLKB9eSoo0fsNh+j5x8TO2r+M/6jzwisEJjmKhErVe
   7InEbJWuKHg3vGTkc1aUwGLeSp5syuCRf23MqUQbegN4Hy1B6UKtd+7j/
   nhn6BK5cE++XHu69kPGrCzsDZMwcJCu2WZG0+MTlAXWiFIajsPXHKq3bL
   Q==;
X-CSE-ConnectionGUID: EVggRtJxTEmGrAW1wtXV9w==
X-CSE-MsgGUID: oQ5L6+dURXueQvfhElEpKw==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="140524250"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 20:42:06 +0800
IronPort-SDR: 69736c9f_Uj1diT6XOT4V2tlg0E8hLqFq2rKlPXdRWoEuNTbnL//Nfdg
 FJPJVs+85+7sZlFPrGPardina9+RSVgpwAslbSw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 04:42:07 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2026 04:42:07 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: fixup last alloc pointer after extent removal for RAID0/10
Date: Fri, 23 Jan 2026 21:41:36 +0900
Message-ID: <20260123124136.4110463-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123124136.4110463-1-naohiro.aota@wdc.com>
References: <20260123124136.4110463-1-naohiro.aota@wdc.com>
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
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20961-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 6DBA475EE4
X-Rspamd-Action: no action

When a block group is composed of a sequential write zone and a conventional
zone, we recover the (pseudo) write pointer of the conventional zone using the
end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position. Then, that
will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding write
pointer position.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 183 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 168 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a10e1076c881..576e8d3ef69c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1561,7 +1561,9 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 	u64 stripe_nr = 0, stripe_offset = 0;
+	u64 prev_offset = 0;
 	u32 stripe_index = 0;
+	bool has_partial = false, has_conventional = false;
 
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1569,6 +1571,34 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	/*
+	 * When the last extent is removed, last_alloc can be smaller than the other write
+	 * pointer. In that case, last_alloc should be moved to the corresponding write
+	 * pointer position.
+	 */
+	for (int i = 0; i < map->num_stripes; i++) {
+		u64 alloc;
+
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		stripe_nr = zone_info[i].alloc_offset >> BTRFS_STRIPE_LEN_SHIFT;
+		stripe_offset = zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK;
+		if (stripe_offset == 0 && stripe_nr > 0) {
+			stripe_nr--;
+			stripe_offset = BTRFS_STRIPE_LEN;
+		}
+		alloc = ((stripe_nr * map->num_stripes + i) << BTRFS_STRIPE_LEN_SHIFT) +
+			stripe_offset;
+		last_alloc = max(last_alloc, alloc);
+		/* Partially written stripe found. It should be last. */
+		if (zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK)
+			break;
+	}
+	stripe_nr = 0;
+	stripe_offset = 0;
+
 	if (last_alloc) {
 		u32 factor = map->num_stripes;
 
@@ -1582,7 +1612,7 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 			continue;
 
 		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
-
+			has_conventional = true;
 			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
 
 			if (stripe_index > i)
@@ -1591,6 +1621,26 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 				zone_info[i].alloc_offset += stripe_offset;
 		}
 
+		/* Verification */
+		if (i != 0) {
+			if (prev_offset < zone_info[i].alloc_offset) {
+				btrfs_err(fs_info,
+				  "zoned: stripe position disorder found in BG %llu",
+					  bg->start);
+				return -EIO;
+			}
+
+			if (has_partial &&
+			    (zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK)) {
+				btrfs_err(fs_info,
+			  "zoned: multiple partial written stripe found in BG %llu",
+					  bg->start);
+				return -EIO;
+			}
+		}
+		prev_offset = zone_info[i].alloc_offset;
+		has_partial |= ((zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK) != 0);
+
 		if (test_bit(0, active) != test_bit(i, active)) {
 			if (unlikely(!btrfs_zone_activate(bg)))
 				return -EIO;
@@ -1602,6 +1652,19 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		bg->alloc_offset += zone_info[i].alloc_offset;
 	}
 
+	/* Check if all devices stay in the same stripe row. */
+	if (zone_info[0].alloc_offset - zone_info[map->num_stripes - 1].alloc_offset >
+	    BTRFS_STRIPE_LEN) {
+		btrfs_err(fs_info, "zoned: stripe gap too large in BG %llu", bg->start);
+		return -EIO;
+	}
+
+	if (has_conventional && bg->alloc_offset < last_alloc) {
+		btrfs_err(fs_info, "zoned: allocated extent stays beyond write pointers %llu %llu",
+			  bg->alloc_offset, last_alloc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -1612,8 +1675,11 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 					 u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 AUTO_KFREE(raid0_allocs);
 	u64 stripe_nr = 0, stripe_offset = 0;
 	u32 stripe_index = 0;
+	bool has_partial = false, has_conventional = false;
+	u64 prev_offset = 0;
 
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1621,6 +1687,56 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	raid0_allocs = kcalloc(map->num_stripes / map->sub_stripes, sizeof(*raid0_allocs),
+			       GFP_NOFS);
+	if (!raid0_allocs)
+		return -ENOMEM;
+
+	/*
+	 * When the last extent is removed, last_alloc can be smaller than the other write
+	 * pointer. In that case, last_alloc should be moved to the corresponding write
+	 * pointer position.
+	 */
+	for (int i = 0; i < map->num_stripes; i += map->sub_stripes) {
+		u64 alloc = zone_info[i].alloc_offset;
+
+		for (int j = 1; j < map->sub_stripes; j++) {
+			int idx = i + j;
+
+			if (zone_info[idx].alloc_offset == WP_MISSING_DEV ||
+			    zone_info[idx].alloc_offset == WP_CONVENTIONAL)
+				continue;
+			if (alloc == WP_MISSING_DEV || alloc == WP_CONVENTIONAL) {
+				alloc = zone_info[idx].alloc_offset;
+			} else if (zone_info[idx].alloc_offset != alloc) {
+				btrfs_err(fs_info, "zoned: write pointer mismatch found in BG %llu",
+					  bg->start);
+				return -EIO;
+			}
+		}
+		raid0_allocs[i / map->sub_stripes] = alloc;
+		if (alloc == WP_CONVENTIONAL)
+			continue;
+		if (alloc == WP_MISSING_DEV) {
+			btrfs_err(fs_info, "zoned: cannot recover write pointer of BG %llu due to missing device",
+				  bg->start);
+			return -EIO;
+		}
+
+		stripe_nr = alloc >> BTRFS_STRIPE_LEN_SHIFT;
+		stripe_offset = alloc & BTRFS_STRIPE_LEN_MASK;
+		if (stripe_offset == 0 && stripe_nr > 0) {
+			stripe_nr--;
+			stripe_offset = BTRFS_STRIPE_LEN;
+		}
+		alloc = ((stripe_nr * (map->num_stripes / map->sub_stripes) +
+			  (i / map->sub_stripes)) <<
+			 BTRFS_STRIPE_LEN_SHIFT) + stripe_offset;
+		last_alloc = max(last_alloc, alloc);
+	}
+	stripe_nr = 0;
+	stripe_offset = 0;
+
 	if (last_alloc) {
 		u32 factor = map->num_stripes / map->sub_stripes;
 
@@ -1630,24 +1746,48 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 	}
 
 	for (int i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
-			continue;
+		int idx = i / map->sub_stripes;
 
-		if (test_bit(0, active) != test_bit(i, active)) {
-			if (unlikely(!btrfs_zone_activate(bg)))
-				return -EIO;
-		} else {
-			if (test_bit(0, active))
-				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
+		if (raid0_allocs[idx] == WP_CONVENTIONAL) {
+			has_conventional = true;
+			raid0_allocs[idx] = btrfs_stripe_nr_to_offset(stripe_nr);
+
+			if (stripe_index > idx)
+				raid0_allocs[idx] += BTRFS_STRIPE_LEN;
+			else if (stripe_index == idx)
+				raid0_allocs[idx] += stripe_offset;
 		}
 
-		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
-			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
+		if ((i % map->sub_stripes) == 0) {
+			/* Verification */
+			if (i != 0) {
+				if (prev_offset < raid0_allocs[idx]) {
+					btrfs_err(fs_info,
+					  "zoned: stripe position disorder found in BG %llu",
+						  bg->start);
+					return -EIO;
+				}
 
-			if (stripe_index > (i / map->sub_stripes))
-				zone_info[i].alloc_offset += BTRFS_STRIPE_LEN;
-			else if (stripe_index == (i / map->sub_stripes))
-				zone_info[i].alloc_offset += stripe_offset;
+				if (has_partial && (raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK)) {
+					btrfs_err(fs_info,
+				  "zoned: multiple partial written stripe found in BG %llu",
+						  bg->start);
+					return -EIO;
+				}
+			}
+			prev_offset = raid0_allocs[idx];
+			has_partial |= ((raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK) != 0);
+		}
+
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			zone_info[i].alloc_offset = raid0_allocs[idx];
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			if (unlikely(!btrfs_zone_activate(bg)))
+				return -EIO;
+		} else if (test_bit(0, active)) {
+			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
 		}
 
 		if ((i % map->sub_stripes) == 0) {
@@ -1656,6 +1796,19 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		}
 	}
 
+	/* Check if all devices stay in the same stripe row. */
+	if (zone_info[0].alloc_offset - zone_info[map->num_stripes - 1].alloc_offset >
+	    BTRFS_STRIPE_LEN) {
+		btrfs_err(fs_info, "zoned: stripe gap too large in BG %llu", bg->start);
+		return -EIO;
+	}
+
+	if (has_conventional && bg->alloc_offset < last_alloc) {
+		btrfs_err(fs_info, "zoned: allocated extent stays beyond write pointers %llu %llu",
+			  bg->alloc_offset, last_alloc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.52.0


