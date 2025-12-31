Return-Path: <linux-btrfs+bounces-20055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB36CEBDA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1FB23081BC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1A3148C1;
	Wed, 31 Dec 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY3cH9su"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82D320A09
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179816; cv=none; b=fE9B+zXGVxoUJMquujp3UsFAqDIaVXSSmLoH4qpBqyB0SS2xcb8jyyeshiqy8PckYpAmtmmyEOblegTqD8jGbsmuEUyupVH945qk76mjZxhI+PtkGpGpFJWCwhDgNw0zqdpmrrsnzk+XWpAai9RzFGEc88be4ubfyOdbe/tm6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179816; c=relaxed/simple;
	bh=o5nd70XT0vO+Ia6bqtzyA96QFgEbrzulHmizVnVdnWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2XTt6KxDyaBF/MAdztj61Yg3HbEcbgH7VNo4wiSJvvOflONkJojv/XgzRELzsPKN2cS9+JU+HLJHoFxKHagWStdcubZCATgXutd90m/zezPUhuAQjrDiz8oTMR4JWktBnHYx1JYL0J6TO9EAxmLrHz/QOV0lTB9XX6a2m3MhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY3cH9su; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f3018dfc3so32628885ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179814; x=1767784614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7+GqKdaxBqR9a1XzPDrzDhfZAMGMIzogp6uw9MNchM=;
        b=XY3cH9su2daAY4IP/zbXd2oXKugYbFyb4K57ibLLaB1HQj1rUYy6b7r9dehUQ11V9p
         vyDeQKejU6xxEpu9rwnQb1s4/uqyEgT6zQ4D2WC3+1fojxX24JI5VGkbkIMr04idhLYc
         jxg0jYiIKsGbzBzLFvdJ095vDzwLlJ5yobniWifx/JGvw0OGCvX1OOIn6TY+Faxe7wq0
         RZll2rW/fT2phaNGhn7rANH8OaJwBNSpfBj7kBKUsG0wWRUjmT8gWYCyoKBEM4SijNqW
         NagRttvKEIbqebTs1fA+7tCeQdTJfYWDUYlhbA/3kg2JPZuNB5EnYhJNwN0XPJqbRdc/
         PJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179814; x=1767784614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7+GqKdaxBqR9a1XzPDrzDhfZAMGMIzogp6uw9MNchM=;
        b=eqENoygXQdJNQR1UgElT4KrD5kPEUHz/4HkmW0c5+zjZBdBHNP1RyGTZ9/9I+YCXHv
         /s3HZpB+3+b9Cl0SVGcQxKSVPYi297+sAan87SApQpyx57ksjVIkx7KZyHH5L+IUdaC/
         UVuCdDO4KdnueQJ/IHDWoWTaiWFCjQ6IdXW0Sn8bni8Z9/pqVg9+Puh40iGvBghX81HZ
         PgGXI7EZwrC3gjXV5clwgzqU56WeyCxqu0I723y73DVhbHGZvcGeDgq2ABmjh4I8VDOr
         0SFvnM18RKybtw0pddPEYCdXvy3s/Ezp3Wdl7WmKcjd2J87fvhrMNwfIsiZxSrgH7vph
         7Kjw==
X-Gm-Message-State: AOJu0YwBPi24GXR3S8CdAO52xpAxGxcQM4es4eA3CRbIMWj8rbfZaDRW
	mWfFArjh3vW9mr8K5x7b+HSaQo6/z2wC9KWboyYSqU0zUUFmeR1vYroFDt9G6W+tKQxManan
X-Gm-Gg: AY/fxX5ukJww2LFtQ8JR/0gHC+CHRKMj9q9iJ0g8q9Ob4JSVsRKk54G8Qkr8Fz3x8mV
	6VaKlQ4YQTj1jwBydouX+uLb38sDqFtwvhl1I7SE/kg2FBW3QRV9RWQCItFiEQfvT31ZuxTD1ee
	WGlJjajUyEla5ICkfF8UMgeQ3Ss3T9y15tooute17Miy2Q6/L8rjba502Es5OmT3PC6tF9iFZVl
	LWpDwXq2DeeW8BDV85CuLgic0JHduFkjYZ9XxkKO1TptY85WL4Uzb7UXgBpykmE9JbqnPWVrwfi
	nhxtUi7tK7rTzhCmQ12GGGEC0D+BNSx2H1jj9xDVn8qy8j558rvZ5uQNgK26jP1GCQFwUXulcmR
	DRd22oew3Jziyd6fRA9rHy6TIRnHeYIngcFPoHxOIh8NU7O4D8AHoFl2JsZBbJHDPrd9A+pj289
	r85/BCyHB8u4ltb8Wv3AU4DVw=
X-Google-Smtp-Source: AGHT+IGn5ia0QTw9D8FHBwvA6dG1xbaDy8zCeVeimV81tGYwx7qGuTKpVdcUcWDCFq7572uzrDRizQ==
X-Received: by 2002:a17:903:18e:b0:2a1:48e:2b42 with SMTP id d9443c01a7336-2a2f2c5eb1dmr255924985ad.9.1767179813847;
        Wed, 31 Dec 2025 03:16:53 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:53 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 7/7] btrfs: fix periodic reclaim condition
Date: Wed, 31 Dec 2025 18:39:40 +0800
Message-ID: <20251231111623.30136-8-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
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

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 15 +++++++--------
 fs/btrfs/space-info.c  | 42 +++++++++++++++++++-----------------------
 fs/btrfs/space-info.h  | 26 ++++++++++++++++++--------
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 944857bd6af6..39e6f1bf3506 100644
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
index b6ec09aea64f..dce21809e640 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2124,43 +2124,39 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
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
+	if (will_reclaim) {
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
index a4fa04d10722..2ebfe440837b 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -216,12 +216,9 @@ struct btrfs_space_info {
 	 * Periodic reclaim should be a no-op if a space_info hasn't
 	 * freed any space since the last time we tried.
 	 */
-	bool periodic_reclaim_ready;
-
-	/*
-	 * Net bytes freed or allocated since the last reclaim pass.
-	 */
-	s64 reclaimable_bytes;
+	bool periodic_reclaim_paused;
+	u8 last_reclaim_threshold;
+	u64 last_reclaim_unused;
 };
 
 static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
@@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
-void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
-void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
 u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
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


