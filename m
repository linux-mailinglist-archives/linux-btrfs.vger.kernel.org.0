Return-Path: <linux-btrfs+bounces-3891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783F89791B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3BC1C25AE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F5155720;
	Wed,  3 Apr 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="T7Zdd0fj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ep5940Rp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AA1553BE
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173043; cv=none; b=b3s9bu/3THiT3VF+0hsjBrXLZkqDzfaPgIHBEol/wllkiveWnM6M+4VBz1SGD8uYmrMgwu6KeCBQ9UY/7/SWk0r6ao2g7uHUzyjMbi5LXxWiDVwQNgLjikmqTDjeG/0SberM0zYBW1q1TJ0FvTKBK0KcR0jjCU0cZqg1ezqWEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173043; c=relaxed/simple;
	bh=vMlK68YznXOWlwJWSpCkjo18MiRpJ2pJMJz+PK369RQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlXHAeFNx5OlAKU1Zk+QzTAts4IJmJmYgfSFUP3Duj9KLOBEX2Emw0ljdR8LNursb3N/MWqS6zesjq6VoqZ4GgqCO0AVP7uk8ZFs6k73e+wHlIABdEGK/+T1ZX2CEmhJCxUwhFk4R2ClSty9/Zzqj4n1K5UcnStXvL5L+YVXjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=T7Zdd0fj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ep5940Rp; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E60253200A59;
	Wed,  3 Apr 2024 15:37:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 Apr 2024 15:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712173040; x=
	1712259440; bh=g5CuIlCpi99e0TX4hO70+lSp9Ds7op4KRzQwIEoADNI=; b=T
	7Zdd0fjb9u+D1fCOtnYFDHFOQfkUEEMjHYN3Dcby9PsxE9SCi8aWQc+hW5VZydux
	TX1KZ7XEvpND6iI6d92VhwJw0p95iBERZquF1Q7jow0yC7MLRHZLZfChpWle3Pua
	bhn/ZKsP2cHWwgmOX/a4011S9NS3mzK71XzzkwbAGeV815SNnCFjcCFrlXEwzDV8
	IV877ABF8qyziSEKNbE4f/NgaDqTVZvYRCUDFxCirHla8RJYz0jJiIy+3vkSTft2
	icNFqVgF28fF0+1065uaWW9oe1bPYiGxEkmq2EcSJcpUryTMHJe7QPYE0kD+eXu4
	RTqwN0G62/I9E+VABkYtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712173040; x=1712259440; bh=g5CuIlCpi99e0
	TX4hO70+lSp9Ds7op4KRzQwIEoADNI=; b=Ep5940Rpf4KY7r1l3Ex2rZaMJs7YO
	Q7oMxKnqpPrtE2ws5uTbUhcmYJi5KEeukQxWPiobfqyQE+SAY5owqtYzWvUZyXtu
	aCEJ933JHVNUVNF779WNPSv2ViZug88DFkhU0W3jPVccbd0neB2Raf+1AOrgq+Dr
	2Lv059fcabSKHrWBZMRJs+VAuG2WoxozedbeFOD3W2ljxqKuMWw1HOudM+XnaPc9
	r4OgjjRjsqXVaJ6jP1bj2I0W3jF7zXCP1Zava8+6YeqbE2Pu5pkqM79/ERmDg1ur
	upBnwZyHZt28he7FLNH830iwtaFJeG5TIbrDvfDyTkMOoM8lLHnlFl7tA==
X-ME-Sender: <xms:8K8NZr7S9EFHKMGlMyVliU1vy3a9Wm1HEfnMEl9Ooji21OMErkG7oQ>
    <xme:8K8NZg6Lsl3enKNCGKnRvVh5NheJBrFyinsLGLNrNEAPvzU3RkJKrIJEUHY62kO_a
    c33REFTartMcIxYmSE>
X-ME-Received: <xmr:8K8NZichPJrB87DZWgDXmobvxQh3teVApmTaaGpshc5fi5kMHLJrf8GkLukwYdi2RYXKyxVmpIG1YT9d815yJq9HXQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:8K8NZsKTOljD8QL_HsEJDlMfxlAT2hqzq-ibk3x0YYkdbfjM4aMjUg>
    <xmx:8K8NZvL5zOCbqiFTrH6EbRoaKVMFwdfUmE9Yw3464rK5JChYxrRWJQ>
    <xmx:8K8NZlx01KdYt_tgT9qImLDaCOAhCdGMUzIPwXot3kZ6JUxALBFROQ>
    <xmx:8K8NZrLEbdXhh12aTOkZ2EHR3RgIABCu0smO6E_89Vinijcnmkijbw>
    <xmx:8K8NZmWTbnRsUbjCrYOgXdlxkNk1Gg3JM9OzIs1yNyCgbwlEG21LJAKd1nVb>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:19 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/6] btrfs: prevent pathological periodic reclaim loops
Date: Wed,  3 Apr 2024 12:38:51 -0700
Message-ID: <f9701b8bd521b2806e47f5f31c607d2a3ec6874a.1712168477.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168477.git.boris@bur.io>
References: <cover.1712168477.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Periodic reclaim runs the risk of getting stuck in a state where it
keeps reclaiming the same block group over and over. This can happen if
1. reclaiming that block_group fails
2. reclaiming that block_group fails to move any extents into existing
   block_groups and just allocates a fresh chunk and moves everything.

Currently, 1. is a very tight loop inside the reclaim worker. That is
critical for edge triggered reclaim or else we risk forgetting about a
reclaimable group. On the other hand, with level triggered reclaim we
can break out of that loop and get it later.

With that fixed, 2. applies to both failures and "successes" with no
progress. If we have done a periodic reclaim on a space_info and nothing
has changed in that space_info, there is not much point to trying again,
so don't, until enough space gets free, which we capture with a
heuristic of needing to net free 1 chunk.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 12 ++++++---
 fs/btrfs/space-info.c  | 56 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/space-info.h  | 14 +++++++++++
 3 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2a42edc3476b..a84454670d6a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1924,6 +1924,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				  bg->start);
 			spin_lock(&space_info->lock);
 			space_info->reclaim_count++;
+			if (READ_ONCE(space_info->periodic_reclaim))
+				space_info->periodic_reclaim_ready = false;
 			spin_unlock(&space_info->lock);
 		} else {
 			spin_lock(&space_info->lock);
@@ -1933,7 +1935,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 next:
-		if (ret)
+		if (ret && !READ_ONCE(space_info->periodic_reclaim))
 			btrfs_mark_bg_to_reclaim(bg);
 		btrfs_put_block_group(bg);
 
@@ -3663,6 +3665,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
+		if (READ_ONCE(space_info->periodic_reclaim))
+			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
 		spin_unlock(&cache->lock);
 		spin_unlock(&space_info->lock);
 	} else {
@@ -3672,8 +3676,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		btrfs_space_info_update_bytes_pinned(info, space_info, num_bytes);
 		space_info->bytes_used -= num_bytes;
 		space_info->disk_used -= num_bytes * factor;
-
-		reclaim = should_reclaim_block_group(cache, num_bytes);
+		if (READ_ONCE(space_info->periodic_reclaim))
+			btrfs_space_info_update_reclaimable(space_info, num_bytes);
+		else
+			reclaim = should_reclaim_block_group(cache, num_bytes);
 
 		spin_unlock(&cache->lock);
 		spin_unlock(&space_info->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 422fb7d4b4e1..149623cbd2d4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "linux/spinlock.h"
 #include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
@@ -1908,7 +1909,9 @@ static u64 calc_pct_ratio(u64 x, u64 y)
  */
 static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
 {
-	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * calc_effective_data_chunk_size(fs_info);
+	u64 chunk_sz = calc_effective_data_chunk_size(fs_info);
+
+	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * chunk_sz;
 }
 
 /*
@@ -1944,14 +1947,13 @@ static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
 	u64 unused = alloc - used;
 	u64 want = target > unalloc ? target - unalloc : 0;
 	u64 data_chunk_size = calc_effective_data_chunk_size(fs_info);
-	/* Cast to int is OK because want <= target */
-	int ratio = calc_pct_ratio(want, target);
 
-	/* If we have no unused space, don't bother, it won't work anyway */
+	/* If we have no unused space, don't bother, it won't work anyway. */
 	if (unused < data_chunk_size)
 		return 0;
 
-	return ratio;
+	/* Cast to int is OK because want <= target. */
+	return calc_pct_ratio(want, target);
 }
 
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
@@ -1993,6 +1995,46 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
+{
+	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
+
+	assert_spin_locked(&space_info->lock);
+	space_info->reclaimable_bytes += bytes;
+
+	if (space_info->reclaimable_bytes >= chunk_sz)
+		btrfs_set_periodic_reclaim_ready(space_info, true);
+}
+
+void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
+{
+	assert_spin_locked(&space_info->lock);
+	if (!READ_ONCE(space_info->periodic_reclaim))
+		return;
+	if (ready != space_info->periodic_reclaim_ready) {
+		space_info->periodic_reclaim_ready = ready;
+		if (!ready)
+			space_info->reclaimable_bytes = 0;
+	}
+}
+
+bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
+{
+	bool ret;
+
+	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		return false;
+	if (!READ_ONCE(space_info->periodic_reclaim))
+		return false;
+
+	spin_lock(&space_info->lock);
+	ret = space_info->periodic_reclaim_ready;
+	btrfs_set_periodic_reclaim_ready(space_info, false);
+	spin_unlock(&space_info->lock);
+
+	return ret;
+}
+
 int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
 {
 	int ret;
@@ -2000,9 +2042,7 @@ int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
 	struct btrfs_space_info *space_info;
 
 	list_for_each_entry(space_info, &fs_info->space_info, list) {
-		if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
-			continue;
-		if (!READ_ONCE(space_info->periodic_reclaim))
+		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
 		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
 			ret = do_reclaim_sweep(fs_info, space_info, raid);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 6f1f530d9c3b..8637be8de44f 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -190,6 +190,17 @@ struct btrfs_space_info {
 	 * threshold in the cleaner thread.
 	 */
 	bool periodic_reclaim;
+
+	/*
+	 * Periodic reclaim should be a no-op if a space_info hasn't
+	 * freed any space since the last time we tried.
+	 */
+	bool periodic_reclaim_ready;
+
+	/*
+	 * Net bytes freed or allocated since the last reclaim pass.
+	 */
+	s64 reclaimable_bytes;
 };
 
 struct reserve_ticket {
@@ -272,6 +283,9 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
+void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
+void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
+bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
 int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
-- 
2.44.0


