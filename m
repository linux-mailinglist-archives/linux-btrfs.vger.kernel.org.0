Return-Path: <linux-btrfs+bounces-20482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D237D1C4BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 04:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A5003003FE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B1284B37;
	Wed, 14 Jan 2026 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdhgMhcY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8D13FEE
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362704; cv=none; b=tDHsuC/UctZLWwCmxQdoHc5BR6UgPh6X/d1AMnQCzztYSwDkUjZx8XvrFIPnUa5uuUvTSKpNLaFJyD4IZg7ovyX5XmU0aXS9gTrpwtkOR/Y/uvlT/M2Lqo05KD1eq/7+gT6CNNRoPqm9KBXq1AxSv3jrWGs5ubWSFaBxAGmESDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362704; c=relaxed/simple;
	bh=T8vaAn8el60VIhOScvjSskessuO7mwFCOBb2OnhRE4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC/U1Vp/2pjQ9EfSSOQR96IwYF4o+lM1Y/YkiE/+tPxO/9lTVX4gayIKB4HDYN43ECjkAmFnZEp6Uub9S1EqO0+vV/0akQdxyoWbwBC+BZg/sv94RAK2FGVi7zH6lq0qUZfLQNQJ/M04cRnu4tw2NRmm4HHa9/O0VRO8d2MA/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdhgMhcY; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a2bff5f774so26033805ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768362703; x=1768967503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44M6dgINpG7u5DWmPK1eg+CGzVnTVtIMPuWtQutNl1s=;
        b=gdhgMhcYtWET9CuXlxA2krvhWaLDdEDT1xvtR3W+FnotS4t7bzzND8zWardDtzScRk
         6XS/Kozmvy5Y1s/kHDll/cYeQl8YZaKZ75g0s7EwOhZ82+EJ5LLI865U17D3v66h2jnc
         ug2dHGE6C5rVtzh3nZkTT9l9Z3KXDNNxl0NfzxCVhtn2Wknmulw6tFDK64wzRS188Ahe
         g9M9+uybBjqumJtiR3E/7bHlzBwMU01KVJcObVpigzfBFF/ry1d6qrwsuNNxVHzmMGbH
         nh3zH5l5aPPjIrDbRP3rKKvHz0b7MzSz/bq2IvAmivLXX9ORU7kL44i55FdTxGNLpHZP
         RL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362703; x=1768967503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44M6dgINpG7u5DWmPK1eg+CGzVnTVtIMPuWtQutNl1s=;
        b=RgdaR+ofsj3yy/SwajBQKVu9oD0CzEyU8hCgOtstg/85pppx1DqHgmSb7egLN3xKoU
         wAljBXOsgMSsUnqiLj/ud+Mv9/dLmh1OI7MjcXqYef8jCQmQeF2AcKzqpcC0Va/OOSep
         gHBGYZpRavwpPPAFtFwnos8vjHjrwUZUZONRhVVYByuy7ePRakHbTU9AmYuesAWQeqZl
         /KY3jFi3ZQ2iwY43oxV3DlbLu0VaA3xpsGBdkKYeMYuLmSrOjsKaxALNwO3F8nY7FnmN
         D81Wbc/Mvo7BD4J1hQlCyIYu/pVggq5mTqXu2m38+3GIOcJqgqjAG2zOA05enytt+3oD
         2OcQ==
X-Gm-Message-State: AOJu0YyUt/VtLQ/9kR2z7ckdjVExzQm/adhDY3P/TjpMeHwUJYwQ0t6D
	UcdS0Ril7SQhMSVShxZtSortypknBtr7K6Tj/nptWGwiEmeldEtE2/L/2wpNu7mGpz37zQ==
X-Gm-Gg: AY/fxX438aUXMsffrQLjVP/hH0XYOGaAq8x20wfJNM02yX2nHcJgn18J5W4OPsumOer
	AJIWkoDMS1ksfpRQNx3MZXNA3PZxvBsw7RrWi07n6gAf/HnMdV2c//vZSkw9qhCYgcLrDdghhsq
	ibo0KvI3u9inlJLrpWi/+d9UbBrPufv3MIfh15AfRg92nVsjNZe03tj5/LQjPU9gzm4636H+dwX
	19Xs1AvHJGoj5EMLFsVWDpf0zRR4Gd42SSIJIu4urRazaKo4sN3HuDX/INItJ/dFiFWtsaoZErO
	9M1PzDpd6ABJGepvJGR0pke4asRASGOSk5gZObWRcSvqMr9rB3FTEgCMxbJOCU8Px2JHKSR7RNT
	DifDXUs2B4msTB3vVh+R9Vpu7huSADynbekYRcGPzjBm+8ZsT/pyC26fcmjx7LkfcpSqIMZ8FzP
	/YMoh3otIWQBE19S0lf829
X-Received: by 2002:a17:90b:570b:b0:340:29db:6196 with SMTP id 98e67ed59e1d1-351091302f0mr1018444a91.4.1768362702663;
        Tue, 13 Jan 2026 19:51:42 -0800 (PST)
Received: from SaltyKitkat ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109e7ee68sm525647a91.17.2026.01.13.19.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:51:42 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v4 1/2] btrfs: fix periodic reclaim condition
Date: Wed, 14 Jan 2026 11:47:02 +0800
Message-ID: <20260114035126.20095-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114035126.20095-1-sunk67188@gmail.com>
References: <20260114035126.20095-1-sunk67188@gmail.com>
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
reclaim continues until no further progress can be made. And resume
perioidc reclaim when there's enough free space.

And we take care if reclaim is making any progress now, so it's
unnecessary to set periodic_reclaim_ready to false when failed to reclaim
a blockgroup.

Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
Suggested-by: Boris Burkov <boris@bur.io>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c |  6 ++++--
 fs/btrfs/space-info.c  | 21 ++++++++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7..79d86b233dda 100644
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
+			btrfs_set_periodic_reclaim_ready(space_info, true);
 		spin_unlock(&space_info->lock);
 
 next:
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7b7b7255f7d8..7d2386ea86c5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2079,11 +2079,11 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
 	return unalloc < data_chunk_size;
 }
 
-static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
+static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
-	bool try_again = true;
+	bool will_reclaim = false;
 	bool urgent;
 
 	spin_lock(&space_info->lock);
@@ -2101,7 +2101,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 		spin_lock(&bg->lock);
 		thresh = mult_perc(bg->length, thresh_pct);
 		if (bg->used < thresh && bg->reclaim_mark) {
-			try_again = false;
+			will_reclaim = true;
 			reclaim = true;
 		}
 		bg->reclaim_mark++;
@@ -2118,12 +2118,13 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	 * If we have any staler groups, we don't touch the fresher ones, but if we
 	 * really need a block group, do take a fresh one.
 	 */
-	if (try_again && urgent) {
-		try_again = false;
+	if (!will_reclaim && urgent) {
+		urgent = false;
 		goto again;
 	}
 
 	up_read(&space_info->groups_sem);
+	return will_reclaim;
 }
 
 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
@@ -2133,7 +2134,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
 	lockdep_assert_held(&space_info->lock);
 	space_info->reclaimable_bytes += bytes;
 
-	if (space_info->reclaimable_bytes >= chunk_sz)
+	if (space_info->reclaimable_bytes > 0 &&
+	    space_info->reclaimable_bytes >= chunk_sz)
 		btrfs_set_periodic_reclaim_ready(space_info, true);
 }
 
@@ -2160,7 +2162,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
 
 	spin_lock(&space_info->lock);
 	ret = space_info->periodic_reclaim_ready;
-	btrfs_set_periodic_reclaim_ready(space_info, false);
 	spin_unlock(&space_info->lock);
 
 	return ret;
@@ -2174,8 +2175,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 	list_for_each_entry(space_info, &fs_info->space_info, list) {
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
-		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
-			do_reclaim_sweep(space_info, raid);
+		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
+			if (do_reclaim_sweep(space_info, raid))
+				btrfs_set_periodic_reclaim_ready(space_info, false);
+		}
 	}
 }
 
-- 
2.52.0


