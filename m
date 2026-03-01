Return-Path: <linux-btrfs+bounces-22116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKNyKrOTo2khHQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22116-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:17:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4E1CA147
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8765301284A
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F823D2B1;
	Sun,  1 Mar 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERiRokya"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E22126C;
	Sun,  1 Mar 2026 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327844; cv=none; b=LyQVO6krt/V+yK/shafiN+3kJ6d8Za/yjqkgBQZLkE/a1Joolk/siPTEZx1mIm1IvAp3ANe+Vewi3hfNGUEd4/V0o+iHr1tJq28U2E91bmi/h2iVbpoTxgTWd0KvsljRYLcY877gg9mUM1ivm8ygJArNwv87H58H8oz4M3cL8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327844; c=relaxed/simple;
	bh=bBs+6i0kud29qLmB7LVtgcy9LSyLZfL95VH1OQBoMW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm+zaesov2jnCoP6kn9+/+SLgWOVqvQYjc/BnJ9aH6NCngJfH85Ip/mI2pgzkeh8QhmY+shg+rQeIBSidyLYJ+TD3teWQzlER36LAjqJX6EftdFu0NYCcFF2HEc0B1F97WuKJgs60sFSK3r8iGTEcvAqNO02unoWatcmZkwfaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERiRokya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628EC19421;
	Sun,  1 Mar 2026 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327844;
	bh=bBs+6i0kud29qLmB7LVtgcy9LSyLZfL95VH1OQBoMW0=;
	h=From:To:Cc:Subject:Date:From;
	b=ERiRokyaBO7pF0+uEld/DP85//5FKBuzcJwQPXG0nhNf8won1QI90lUC7PeyjZp+p
	 2xf2JUC15HQmqOEc09KdjkuQ/XoKyGHFdqdtyyI9LX7QFMMhbVmNQ8V1fl9kLSNF+F
	 7DD0C2lEb+rLAajSMu2X0kXluYDYuq4/EnUZJUdYAIfOqp8Mgcr6XzD3WHpxsJpgzk
	 Ow64o2nE8a7OlzonqIjCGmri+hyCsMDhCeboJyxhXSuNjXLn88pNqxX9Ls/mG2Y1kp
	 WaJdQVWuxZOyIcib750Z1mAhu/VLoJGveGlfPPOkofUjZLBKb3WNslVVhks2Tt61IT
	 CQ2+LMpsX78Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	naohiro.aota@wdc.com
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: FAILED: Patch "btrfs: zoned: fixup last alloc pointer after extent removal for RAID0/10" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:22 -0500
Message-ID: <20260301011722.1671300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22116-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF4E1CA147
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52ee9965d09b2c56a027613db30d1fb20d623861 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Fri, 23 Jan 2026 21:41:36 +0900
Subject: [PATCH] btrfs: zoned: fixup last alloc pointer after extent removal
 for RAID0/10

When a block group is composed of a sequential write zone and a
conventional zone, we recover the (pseudo) write pointer of the
conventional zone using the end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position.
Then, that will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding
write pointer position.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zoned.c | 194 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 179 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a10e1076c8816..7fa60a44d7166 100644
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
@@ -1569,6 +1571,35 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
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
+
+		/* Partially written stripe found. It should be last. */
+		if (zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK)
+			break;
+	}
+	stripe_nr = 0;
+	stripe_offset = 0;
+
 	if (last_alloc) {
 		u32 factor = map->num_stripes;
 
@@ -1582,7 +1613,7 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 			continue;
 
 		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
-
+			has_conventional = true;
 			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
 
 			if (stripe_index > i)
@@ -1591,6 +1622,28 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 				zone_info[i].alloc_offset += stripe_offset;
 		}
 
+		/* Verification */
+		if (i != 0) {
+			if (unlikely(prev_offset < zone_info[i].alloc_offset)) {
+				btrfs_err(fs_info,
+				"zoned: stripe position disorder found in block group %llu",
+					  bg->start);
+				return -EIO;
+			}
+
+			if (unlikely(has_partial &&
+				     (zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK))) {
+				btrfs_err(fs_info,
+				"zoned: multiple partial written stripe found in block group %llu",
+					  bg->start);
+				return -EIO;
+			}
+		}
+		prev_offset = zone_info[i].alloc_offset;
+
+		if ((zone_info[i].alloc_offset & BTRFS_STRIPE_LEN_MASK) != 0)
+			has_partial = true;
+
 		if (test_bit(0, active) != test_bit(i, active)) {
 			if (unlikely(!btrfs_zone_activate(bg)))
 				return -EIO;
@@ -1602,6 +1655,19 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		bg->alloc_offset += zone_info[i].alloc_offset;
 	}
 
+	/* Check if all devices stay in the same stripe row. */
+	if (unlikely(zone_info[0].alloc_offset -
+		     zone_info[map->num_stripes - 1].alloc_offset > BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info, "zoned: stripe gap too large in block group %llu", bg->start);
+		return -EIO;
+	}
+
+	if (unlikely(has_conventional && bg->alloc_offset < last_alloc)) {
+		btrfs_err(fs_info, "zoned: allocated extent stays beyond write pointers %llu %llu",
+			  bg->alloc_offset, last_alloc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -1612,8 +1678,11 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
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
@@ -1621,6 +1690,60 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
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
+			} else if (unlikely(zone_info[idx].alloc_offset != alloc)) {
+				btrfs_err(fs_info,
+				"zoned: write pointer mismatch found in block group %llu",
+					  bg->start);
+				return -EIO;
+			}
+		}
+
+		raid0_allocs[i / map->sub_stripes] = alloc;
+		if (alloc == WP_CONVENTIONAL)
+			continue;
+		if (unlikely(alloc == WP_MISSING_DEV)) {
+			btrfs_err(fs_info,
+			"zoned: cannot recover write pointer of block group %llu due to missing device",
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
+
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
 
@@ -1630,24 +1753,51 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
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
+				if (unlikely(prev_offset < raid0_allocs[idx])) {
+					btrfs_err(fs_info,
+					"zoned: stripe position disorder found in block group %llu",
+						  bg->start);
+					return -EIO;
+				}
 
-			if (stripe_index > (i / map->sub_stripes))
-				zone_info[i].alloc_offset += BTRFS_STRIPE_LEN;
-			else if (stripe_index == (i / map->sub_stripes))
-				zone_info[i].alloc_offset += stripe_offset;
+				if (unlikely(has_partial &&
+					     (raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK))) {
+					btrfs_err(fs_info,
+					"zoned: multiple partial written stripe found in block group %llu",
+						  bg->start);
+					return -EIO;
+				}
+			}
+			prev_offset = raid0_allocs[idx];
+
+			if ((raid0_allocs[idx] & BTRFS_STRIPE_LEN_MASK) != 0)
+				has_partial = true;
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
@@ -1656,6 +1806,20 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		}
 	}
 
+	/* Check if all devices stay in the same stripe row. */
+	if (unlikely(zone_info[0].alloc_offset -
+		     zone_info[map->num_stripes - 1].alloc_offset > BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info, "zoned: stripe gap too large in block group %llu",
+			  bg->start);
+		return -EIO;
+	}
+
+	if (unlikely(has_conventional && bg->alloc_offset < last_alloc)) {
+		btrfs_err(fs_info, "zoned: allocated extent stays beyond write pointers %llu %llu",
+			  bg->alloc_offset, last_alloc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.51.0





