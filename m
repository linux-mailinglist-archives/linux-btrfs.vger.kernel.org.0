Return-Path: <linux-btrfs+bounces-15067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90316AECB5A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 07:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977E71898318
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238001C84DC;
	Sun, 29 Jun 2025 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="MLGFNaXG";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="tGSTli/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA30482EB;
	Sun, 29 Jun 2025 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173521; cv=none; b=ar02AFCg8SwggMpQJTO+Mu3yAkYoSq3kHhwBgNbJ3Zalg6rd1mrDrm/YifffaSwvBXGwb+eUJbqE7HtsLe6osf9/JZteQkX5wLu/w3kxP9C39/c5KQf/RG7rhfNQMGb8NhQ/znIYw8t39irSHc3HIjhv6S7pgp1TCJoKwFr01y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173521; c=relaxed/simple;
	bh=dvkABwX9Td2+ykPg1ot1Qw8RcD+va/FoPMrIhIXpH3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rm5VSO/r1Cs3rtsGhoUIRoX3f+QEQ/vcqQgFeOnO29P2eKwFVwbbgYw92k72GIHQOfOyeqOtLKWlr65FVmfF6N7QBXJb9/19N5T5MEOC+3Xq1ReBJDRLkdACzDQG3toyaaR3m715BJxW+BTJO8fsZBRP+f2RvAezMeZSNmrNu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=MLGFNaXG; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=tGSTli/l; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
From: George Hu <integral@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1751173507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lu6GylVgZqF081jIeNBQGjUEakzfhzvr769c18XONC8=;
	b=MLGFNaXGa5iPDnXqeSt0bzlu2AICzuDUyfbklbf+o58RiVRE7rsDol2prZ7luzP1U7Ihvq
	lpwPD9KqZG4PUOeeCHg7RGnKwZPVO6P96qlpKxuRQdDJESiEnnJJPWi4W6I0m+sQDd0AGY
	ThYgsI6lSx6Vbm2ZVjOapH8lWXhVGPalgpnqabgpo8bE8vCeIsv9eivFj5L1Rp5DD0sy1s
	KPj+dwW44+LQLXvs7BSUnxiRWQXcuIbHMuE3tUFk72RLHbVBOrNflCd8UxVE7YF+vC0tR5
	aybtIGHm6lTJts+b0RJuJuiuC4SW3YubU3BD6tUOX2CHD0hpb9jPdND/Y/KVWaqW3VUOVx
	D1+IhPEGUkPmanMjLYPBN9Ov2a3+sByAqjMe3gZjjASXd6aAoE3UaBrSAfQuvCo3pY0toz
	q419z+qC9SAYTsj/IZiV3i9EnVnAUJNW98PiTmgG1dKXH90dOhTCFKSb1FmAvKsxigT3n1
	+vgaVgMRhvUuZuhCQ9iQggzqtCR6hpc7R3QncHLRqrQQl0+kIRw9luO530DzYp3q9YcFnY
	Wf0l0oUYcNQtLkWAjf27Nj7y1fv62z1UYJDPUHy8Q45DLVewkvI11UKc/PHoGRb4tn0pn+
	KIXtGV5vFAeIYbGbE6v7ZfXLQuI1KjTlpUN60q61gpRKSkCItxJEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1751173507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lu6GylVgZqF081jIeNBQGjUEakzfhzvr769c18XONC8=;
	b=tGSTli/lvD+nfsZJ/Jy4Uu7GZpi0AVSuPv9ayG0uQttjVHp8NVMk5HFpuEBKkTbeoX1kIk
	F3s++w9mHGqzQiAA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	George Hu <integral@archlinux.org>
Subject: [PATCH] btrfs: use in_range() macro in volumes.c
Date: Sun, 29 Jun 2025 13:04:25 +0800
Message-ID: <20250629050425.139456-1-integral@archlinux.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "if (start <= val && val < (start + len))" in volumes.c
with in_range() macro to improve code readability.

Signed-off-by: George Hu <integral@archlinux.org>
---
 fs/btrfs/volumes.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f475b4b7c457..c5479dce0cb2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3198,7 +3198,7 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (unlikely(map->start > logical || map->start + map->chunk_len <= logical)) {
+	if (unlikely(!in_range(logical, map->start, map->chunk_len))) {
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, map->start,
@@ -3841,7 +3841,7 @@ static bool chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_of
 	else
 		user_thresh_max = mult_perc(cache->length, bargs->usage_max);
 
-	if (user_thresh_min <= chunk_used && chunk_used < user_thresh_max)
+	if (in_range(chunk_used, user_thresh_min, user_thresh_max))
 		ret = false;
 
 	btrfs_put_block_group(cache);
@@ -6211,9 +6211,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 			if (i < sub_stripes)
 				stripes[i].length -= stripe_offset;
 
-			if (stripe_index >= last_stripe &&
-			    stripe_index <= (last_stripe +
-					     sub_stripes - 1))
+			if (in_range(stripe_index, last_stripe, sub_stripes))
 				stripes[i].length -= stripe_end_offset;
 
 			if (i == sub_stripes - 1)
@@ -7047,11 +7045,10 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map = btrfs_find_chunk_map(fs_info, logical, 1);
 
 	/* already mapped? */
-	if (map && map->start <= logical && map->start + map->chunk_len > logical) {
-		btrfs_free_chunk_map(map);
-		return 0;
-	} else if (map) {
+	if (map) {
 		btrfs_free_chunk_map(map);
+		if (in_range(logical, map->start, map->chunk_len))
+			return 0;
 	}
 
 	map = btrfs_alloc_chunk_map(num_stripes, GFP_NOFS);
@@ -8239,8 +8236,7 @@ static void map_raid56_repair_block(struct btrfs_io_context *bioc,
 		u64 stripe_start = bioc->full_stripe_logical +
 				   btrfs_stripe_nr_to_offset(i);
 
-		if (logical >= stripe_start &&
-		    logical < stripe_start + BTRFS_STRIPE_LEN)
+		if (in_range(logical, stripe_start, BTRFS_STRIPE_LEN))
 			break;
 	}
 	ASSERT(i < data_stripes, "i=%d data_stripes=%d", i, data_stripes);
-- 
2.50.0


