Return-Path: <linux-btrfs+bounces-5773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050090BFAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C82B22DDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7819AD6C;
	Mon, 17 Jun 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WeytFU/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRN7r9aF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90619AA6A
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665918; cv=none; b=L9GN7TY+PbqII+JkGugawapImWhWxBgWYKFwfx1ntG8YtW5l9VwZlDKUXGQmgTwLtcXj9n+Kv50AVVVtzJ3+wGpjGW3W2LHkDWdtxOdQdvkyNR9wBLjq6laKCgS0wMQC7ocFD5OIhraFg+/ZNURyj7Lou81KPiiauLNCIsjpdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665918; c=relaxed/simple;
	bh=2A8PNGhHxdhenxAO1bs9UcGiO/MQ2ZRsNOostZeZkxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfkpBL0K+75RF2klfosFgfcYFe8GKdEAYtFH+hGjt/RWS7T8zaveSyrRBUq7jcrnIiIXpFpLzm9S9wYqiyiU0q4FKrVUOVOYYpTdj86jBg023PSxAJqRJl1UDMPbh/IlY44k8ntE7SyFZ527CWOMzWjX4jYMxtmDghUySOtNve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WeytFU/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRN7r9aF; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id C173C1C000F6;
	Mon, 17 Jun 2024 19:11:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 19:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665915; x=
	1718752315; bh=4aFYZAoUSlDDUjKWHfHhgaMmQ7R6x6/872NjJjXnpRg=; b=W
	eytFU/ux9iIkPmlNd/qOifIOaAFvdAtZK4ebDu9SQbbY+layay+JYR+Opi26uPfu
	TL2DqS7Zf0tWVONmhia08zo2gNA04nKGATxH9EZr2DEAwN8t2ufbpKIreADoouoc
	OcAcY5QpAdlGIqX/JPawz+mpyyTu3BOAXcS+SPdjrucTSAvZ2GYYVV5OgRGG9Sl/
	xNj31WmT4XOXcst2xx9OWul+ete7FzxNGYwM2Y7TjPmLpTuIQj6XsVvCUWF9gnCS
	A69QPLySsIKQjrjVg97WQi0AtSuls5R6Loh96DLPfkytHMP9AizU0NRifGoTdK0f
	WViDHrBimUU5z9flqrn1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665915; x=1718752315; bh=4aFYZAoUSlDDU
	jKWHfHhgaMmQ7R6x6/872NjJjXnpRg=; b=jRN7r9aFIRC8WlHQ0dkTvdYgvOqFP
	VTrerPfVovtRL49oOZp9+nzZZfnvBtCeJOagsMsY21QnGbnifks1+pROJ8XTvxsn
	uELma7O0jDzw2ax733GJbAyyavQj9mIqKK4UeCgCqlvvuejbJR2/JnzPyylrph9K
	NlZk9T1vGADDpy3iSVp2bZkjDj0t0BYZbiqlUxQS/Wfep0B9sCp7Akbkj98d8sE/
	nB7xLe8iGKjf/idPqmQOWd31AONk/q1HMIFzeQeiKgQ7eHJsdlNjoirHdCkpvPsD
	S96alDos8PDLO8RH3IEG3K7EGZRet6wg/uj80ZfVWTQefU2NipCHMupTw==
X-ME-Sender: <xms:u8JwZkj_3q18XRYyrsrOu7Xp6prJsPcP0QcDvlg2_8AWt1cmy6MsZQ>
    <xme:u8JwZtB9o28QAWSOLirug6Ia_UERUnADG2WvR_LTHwVHR3AMrGdIyVpZIFtCQdtWh
    1iKTCL_7bGSFVQGF3Q>
X-ME-Received: <xmr:u8JwZsHJxb78QNav2MRectOv_7mtCYwl_FK1l0Bhx14-fXXfNiwCSBmDm5Bl1ziWpjGKw2rgMPXffp6FW7cDFvKUs68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:u8JwZlS5SY4_677N9yhUKndhToXVSmb8okNcly-B168g2EjzomIhBQ>
    <xmx:u8JwZhwlmb8EKdtPpZ-74xpgU5c8Fct209k_IKSJmqZyShkZ4LiV9A>
    <xmx:u8JwZj6RQiolZDRXFlwUjP8I8sg7ejl3ujAaRBSIYM_baSppxErogw>
    <xmx:u8JwZuwcm-gKnIsrkekD3ue8oMk4R2JZMxJIlA86DNKCUb2fguCY3A>
    <xmx:u8JwZs85oU5DmFLHLLh3_oVf0tHCkmvPHB87V_TGNzswNGViOjX1Tmw->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:54 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 5/6] btrfs: prevent pathological periodic reclaim loops
Date: Mon, 17 Jun 2024 16:11:17 -0700
Message-ID: <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718665689.git.boris@bur.io>
References: <cover.1718665689.git.boris@bur.io>
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
index 6bcf24f2ac79..ba9afb94e7ce 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1933,6 +1933,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			reclaimed = 0;
 			spin_lock(&space_info->lock);
 			space_info->reclaim_errors++;
+			if (READ_ONCE(space_info->periodic_reclaim))
+				space_info->periodic_reclaim_ready = false;
 			spin_unlock(&space_info->lock);
 		}
 		spin_lock(&space_info->lock);
@@ -1941,7 +1943,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&space_info->lock);
 
 next:
-		if (ret) {
+		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
 			/* Refcount held by the reclaim_bgs list after splice. */
 			btrfs_get_block_group(bg);
 			list_add_tail(&bg->bg_list, &retry_list);
@@ -3677,6 +3679,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
+		if (READ_ONCE(space_info->periodic_reclaim))
+			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
 		spin_unlock(&cache->lock);
 		spin_unlock(&space_info->lock);
 	} else {
@@ -3686,8 +3690,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index ff92ad26ffa2..e7a2aa751f8f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "linux/spinlock.h"
 #include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
@@ -1899,7 +1900,9 @@ static u64 calc_pct_ratio(u64 x, u64 y)
  */
 static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
 {
-	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * calc_effective_data_chunk_size(fs_info);
+	u64 chunk_sz = calc_effective_data_chunk_size(fs_info);
+
+	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * chunk_sz;
 }
 
 /*
@@ -1935,14 +1938,13 @@ static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
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
@@ -1984,6 +1986,46 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
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
@@ -1991,9 +2033,7 @@ int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
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
index ae4a1f7d5856..4db8a0267c16 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -196,6 +196,17 @@ struct btrfs_space_info {
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
@@ -278,6 +289,9 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
+void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
+void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
+bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
 int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
 
-- 
2.45.2


