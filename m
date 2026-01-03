Return-Path: <linux-btrfs+bounces-20086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819ACEFF45
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5059030037AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65F221FB4;
	Sat,  3 Jan 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J62CoXv3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242B15A86D
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445593; cv=none; b=gGUGVTWz4C9ZSzZ3q9aX93vMsBhU3kP4jBzGIKiV4Rg4YLQom3Zk7FRAYTQW+clyuvt6JYUqurN2MCE7lo/ackKVeWn5TLoLnLfLY2Oq14KlEbvm7uPjgwxCGYxG8EYbzmb15fuZNqwx8OynEDv9pd9DvU6Aw7yi3bqqrUsGZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445593; c=relaxed/simple;
	bh=PXeQesXVcxEhPx1N1+he1pggvjrINnKsaBGXdUI/voc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwvEj9GuQyNWC/CyIJEUh8eLmrg+BZ3pkq/wZtxFquTGu7tzVrGIS/8nLOjk5m6yxioRgRsyLKPiSy1oAvv/GVHd6VLtRLajIcdFCnm2UvOyswlINMBXr0XySkwF3z8wnN+6kjB0a1TdYsBuzJ/k9aW2OrEUHacX67OibRqy43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J62CoXv3; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63f9fa715c6so1855148d50.2
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445590; x=1768050390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/RoBZkysXWEpfjvlamudYIbRkjlOE4jf2sXBCUpcpI=;
        b=J62CoXv3AqLyeTdJ/S3bXmNCNdMyUwM+PYZdgAYldQVtgKjY88HtI6oqL+btbxtP/9
         pj2DlfJ0xSLk3O7nl8mdg5bjCHE8D7oFjhwSf6R2FGvDl0IN9XoGN811saTXn+VW9/qm
         GOZxnlcnPMZ8sCiD5QSmoTbLtKypHDtx5f2hsY3RrQRW6ChCr3kK1kuUNdznUBpkQdeU
         C36zcTrVxzO5sew2QrDfS2gSef5qQKmDwGcl7T3c3Ty62hnItDe/QSYngNvHESDM0qFx
         +sWE32HCwunL4R/lQFoX8L92cuH6jJ8QcLV5RZzjbN3BqcdM7i6gHE0bcs6PnGrCWv+N
         dTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445590; x=1768050390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/RoBZkysXWEpfjvlamudYIbRkjlOE4jf2sXBCUpcpI=;
        b=JIIhz1hKjcU1XvjLjWKl4VYhrbfZfxEgAc8raSVvFPHmkkNOxiTy/puYwGF6U0TfSO
         0Toh/N5W6uY+KyaTRfCaPQ1ObJO6CTQCmh1fsNEklqNL/SOUBxXc7p9dxzXJaCsFpVUe
         sZGg9U8xEQljfISnntHa31o3DGkYFYPbVb7OuHG21KfwL0kBunjWVIHWpUvdS7DZNmMC
         WuULcM1C7XI9eU9l84kAYwd4NbeK90TWyRqud8td1AycXrnzGJh9jv9tmTQ0rOnaNLpL
         E0e1CKOWf1FZEV8hCuM2l64uT5yo5xWpMB+krSSFEV0UoYZE2QCx/czTuZi9imJPt62h
         Wb2g==
X-Gm-Message-State: AOJu0YxchQIQnIyD0yypygtxTu5Bp8GdFZ35wdW8+uX58f2RYVhDnen8
	PqrfsnHsIzJ8MfmNjhSYgOFP0UGwsPYJiuCmHczOSY6QvNBAiPRB2TyEb6wNdZMt6hKcNQ==
X-Gm-Gg: AY/fxX75/I7ggA1JORR0WWzu0PcPQc1zqmpjB+kYXtLWnoxm9HDhGB4T4nso9lgsF5m
	7IGw3q4ZMewZxIkz/6lkamSk3FkThiQf1OEpqT4zDFspMZifuX5h4DKg8iFuAiPJW+hVZtLSSbG
	4inMnpM6gnClXH25+brmUX2GAFs2XPDWqP4lLPnRAbrU3MgWavBNjt+y02fm648EvGpVfWNaWvR
	PQqx8PrKxB6+iwwBEqRpSM3s/V8bdShtF9+H+bVCpgTNHls+e2b9shF4q8GbqPM3cQK4DU6d8gM
	XaXkqUStUzAqEkjnOc+XgRf3Q7iTLuLtXBqQ6ObtMrurj5G9vpMeJ6VAEbc/+Kkhz0AWs2Ba2kR
	zm9lj9TV5z2qxeK5wD+Obrx0p4z42yd1R1fQ3hhytfPsH1enshSJbJeDKR2jkp7gG/xS6nVvpR0
	pV+F1QVwCAEVpsjAkCsx8=
X-Google-Smtp-Source: AGHT+IE/cbTKT/B75vWtnBi2FX85Z3wpRteIK5SHuUOsBUrpVKM7JILqPP70pC1KdGXQw4pthm6vdA==
X-Received: by 2002:a05:690c:d85:b0:790:466f:baa6 with SMTP id 00721157ae682-790466fcddbmr106784707b3.9.1767445590465;
        Sat, 03 Jan 2026 05:06:30 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:30 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
Date: Sat,  3 Jan 2026 20:19:48 +0800
Message-ID: <20260103122504.10924-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problems with current implementation:
1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
   negative reclaimable_bytes to trigger reclaim unexpectedly
2. The "space must be freed between scans" assumption breaks the
   two-scan requirement: first scan marks block groups, second scan
   reclaims them. Without the second scan, no reclamation occurs.

Instead, track actual reclaim progress: pause reclaim when block groups
will be reclaimed, and resume only when progress is made. This ensures
reclaim continues until no further progress can be made, then resumes when
space_info changes or new reclaimable groups appear.

CC: Boris Burkov <boris@bur.io>
Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 15 +++++++-------
 fs/btrfs/space-info.c  | 44 +++++++++++++++++++-----------------------
 fs/btrfs/space-info.h  | 28 ++++++++++++++++++---------
 3 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7..94a4068cd42a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 used;
 		u64 reserved;
+		u64 old_total;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 
 		spin_unlock(&bg->lock);
+		old_total = space_info->total_bytes;
 		spin_unlock(&space_info->lock);
 
 		/*
@@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			reserved = 0;
 			spin_lock(&space_info->lock);
 			space_info->reclaim_errors++;
-			if (READ_ONCE(space_info->periodic_reclaim))
-				space_info->periodic_reclaim_ready = false;
 			spin_unlock(&space_info->lock);
 		}
 		spin_lock(&space_info->lock);
 		space_info->reclaim_count++;
 		space_info->reclaim_bytes += used;
 		space_info->reclaim_bytes += reserved;
+		if (space_info->total_bytes < old_total)
+			btrfs_resume_periodic_reclaim(space_info);
 		spin_unlock(&space_info->lock);
 
 next:
@@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
-		if (READ_ONCE(space_info->periodic_reclaim))
-			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
 		spin_unlock(&cache->lock);
 		spin_unlock(&space_info->lock);
 	} else {
@@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
 		space_info->bytes_used -= num_bytes;
 		space_info->disk_used -= num_bytes * factor;
-		if (READ_ONCE(space_info->periodic_reclaim))
-			btrfs_space_info_update_reclaimable(space_info, num_bytes);
-		else
-			reclaim = should_reclaim_block_group(cache, num_bytes);
+		reclaim = should_reclaim_block_group(cache, num_bytes);
 
 		spin_unlock(&cache->lock);
+		if (reclaim)
+			btrfs_resume_periodic_reclaim(space_info);
 		spin_unlock(&space_info->lock);
 
 		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7b7b7255f7d8..de8bde1081be 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2119,48 +2119,44 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	 * really need a block group, do take a fresh one.
 	 */
 	if (try_again && urgent) {
-		try_again = false;
+		urgent = false;
 		goto again;
 	}
 
 	up_read(&space_info->groups_sem);
-}
-
-void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
-{
-	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
-
-	lockdep_assert_held(&space_info->lock);
-	space_info->reclaimable_bytes += bytes;
 
-	if (space_info->reclaimable_bytes >= chunk_sz)
-		btrfs_set_periodic_reclaim_ready(space_info, true);
-}
-
-void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
-{
-	lockdep_assert_held(&space_info->lock);
-	if (!READ_ONCE(space_info->periodic_reclaim))
-		return;
-	if (ready != space_info->periodic_reclaim_ready) {
-		space_info->periodic_reclaim_ready = ready;
-		if (!ready)
-			space_info->reclaimable_bytes = 0;
+	/*
+	 * Temporary pause periodic reclaim until reclaim make some progress.
+	 * This can prevent periodic reclaim keep happening but make no progress.
+	 */
+	if (!try_again) {
+		spin_lock(&space_info->lock);
+		btrfs_pause_periodic_reclaim(space_info);
+		spin_unlock(&space_info->lock);
 	}
 }
 
 static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
 {
 	bool ret;
+	u64 chunk_sz;
+	u64 unused;
 
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return false;
 	if (!READ_ONCE(space_info->periodic_reclaim))
 		return false;
+	if (!READ_ONCE(space_info->periodic_reclaim_paused))
+		return true;
+
+	chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
 
 	spin_lock(&space_info->lock);
-	ret = space_info->periodic_reclaim_ready;
-	btrfs_set_periodic_reclaim_ready(space_info, false);
+	unused = space_info->total_bytes - space_info->bytes_used;
+	ret = (unused >= space_info->last_reclaim_unused + chunk_sz ||
+	       btrfs_calc_reclaim_threshold(space_info) != space_info->last_reclaim_threshold);
+	if (ret)
+		btrfs_resume_periodic_reclaim(space_info);
 	spin_unlock(&space_info->lock);
 
 	return ret;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0703f24b23f7..a49a4c7b0a68 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -214,14 +214,11 @@ struct btrfs_space_info {
 
 	/*
 	 * Periodic reclaim should be a no-op if a space_info hasn't
-	 * freed any space since the last time we tried.
+	 * freed any space since the last time we made no progress.
 	 */
-	bool periodic_reclaim_ready;
-
-	/*
-	 * Net bytes freed or allocated since the last reclaim pass.
-	 */
-	s64 reclaimable_bytes;
+	bool periodic_reclaim_paused;
+	int last_reclaim_threshold;
+	u64 last_reclaim_unused;
 };
 
 static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
@@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
-void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
-void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
 int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
+static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_info *space_info)
+{
+	lockdep_assert_held(&space_info->lock);
+	if (space_info->periodic_reclaim_paused)
+		space_info->periodic_reclaim_paused = false;
+}
+static inline void btrfs_pause_periodic_reclaim(struct btrfs_space_info *space_info)
+{
+	lockdep_assert_held(&space_info->lock);
+	if (!space_info->periodic_reclaim_paused) {
+		space_info->periodic_reclaim_paused = true;
+		space_info->last_reclaim_threshold = btrfs_calc_reclaim_threshold(space_info);
+		space_info->last_reclaim_unused = space_info->total_bytes - space_info->bytes_used;
+	}
+}
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
-- 
2.51.2


