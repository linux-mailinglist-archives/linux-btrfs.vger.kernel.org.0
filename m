Return-Path: <linux-btrfs+bounces-20433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1FD16D3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 07:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46F0A300FBCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515922FAFD;
	Tue, 13 Jan 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hiot3/Gh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048A31691A
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285518; cv=none; b=p3DgmQNfUxDdvoZ06gtBP8DeDqv/nnSWHHPPeRq+LJceEPZTYDEHmBx0x6yB1Acr1f+U/oHv/BL89c4DKb3uAPVUMGRTkG48kAny9/1zu9OK1fNWgyOP5fMRC18EPBP88Hx4n0QqjWKvDuZvhM3/8kTjLpDQTZqFTdkFLiRmctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285518; c=relaxed/simple;
	bh=CiQCycotlPvJCtC2+5RpMEzxXF+Yer9fODvipRX3t7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgYwyScXEjlohDl14QpYHk9bTdmdm/q/2HnEWHK7p08ecDz6YvCtJ7sVgoGvF6yaeYHjRFoJwV1ZPjE26I6atRnPy5B2p70/dPVpPw1JNxl170d/YgX4pxJrQDe34Dx/ZOcVTvHYNm0mKQLwLL9pUX5VOEEovMS3t9xkpXtE5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hiot3/Gh; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81f38d974e0so182312b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 22:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285516; x=1768890316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7nn8GaSgRK8139ot13cW5/9sn9oe1iAWLiJBaCqOxI=;
        b=Hiot3/GhTQHpnh0IngztXX1Db9U77Clmsrm3E8hr095Ah+TN6m1zlBDCT5XIG5chpg
         VCxjiveFv8zzaRLvTYvRnbPXmWvoIyxIZ8b2JA+kBbmlS3O+tfC4LtwLbOgQ5VasDWwY
         rake5PkwtFxD9EibtsB8r8Lfp6CZGJG1zL+J3PwJdebdR+VOYAi2jOjkOuRswiuXK/sg
         CKGveJ5fa9CmzoIVZY5zg+uVgwus0dBpGqy86Pks+PDilf3dWNW5O+ALlmtDOE4nnoPB
         1tCktAHJxkmJ1ALsvs8sclNLBNHq9txkcdQmlWON2jVBNOMhvhACkEQvnuuBgi5LpJ/x
         43sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285516; x=1768890316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7nn8GaSgRK8139ot13cW5/9sn9oe1iAWLiJBaCqOxI=;
        b=N3lCjvyLK6+eu/EGC6R5sbS5QeAazvbNgyRCnOKTq+cgEO598jmYr46VFtrfNUDSNH
         K1peD9uQ/3/0I5IPPDxSRLkFXNbnOkPuASY0x3qRhf5XndNl3QcRxUSdp2QwV3iGCgVo
         NHG1AdQu3gSmX3E+z/k9OM3T4qQFU8FF1GWy9K5gxaSS1jpM2hkbCM767saOFLIXPFgh
         qu/jpBLlCuN4CDpWrVlrZHOg95DbCj3QuAGOIGBOHIFbRN5atdGcEQqtee3UNDE9U+pQ
         HsYfumEsshVhGxyXsffjg7tR7ykxB43oqdWoKoRqs2DXBQfR9yBUe6Q+9KxvYodsEXCz
         bFpA==
X-Gm-Message-State: AOJu0YxSPosdnrRbiwTI3aJIwlbCvHrNQCk5dImMHhtYwuwa+YY2ZOZB
	pHNYFS64Ll6TgczYZI2BnEyTN7V7ItpTaWl4KOyCDxm08WoVxeZ5NpqWBUz2YlrtkyGMyA==
X-Gm-Gg: AY/fxX6yDXhfKdXYTI9H/b6y0VPTeyqZmT8ir0eNVP8+dTmMsNvSDwssIe6WisobyA2
	BaJzTEeO/fSNMe9ynumB8Om94ie3MjZV/Z1cf5VOsX/VycjivS4QyKWl4wO8OaJHaquOdvX9VuJ
	fY3ykJxagqtRJpLfphdSrJMGCIWkFDcn75ZEAGA1huBpT5IPowbaakI+Pk+AnkWOz1i2Ls/C6kr
	UOxhvcgAnvdE7X2BKVG3qzr8vXZ7tCwp5p1elU1BQqFC4Ut9Yuua5xlf6TKSzGQ0eL39q4oSeMi
	OUGVm1Eg1tdbipf8yhzz6ui60R3PPqtVICr7SmkMVp8wHMacLkx/y9N1z50lReqTXBkQHLRCzX2
	RhSq9wLGoTJwgT9QhMXuBxCfBpUFXh8eyU0t9JdHPSF345vcSmCl4IrbL0TfNePqTVfJ/XWdHjr
	uyzloA2+dpam2xUwczvlbx
X-Google-Smtp-Source: AGHT+IH+0CQlnr0ktP2pl6ULiiyGvKEt1twzZ/ANIEiIHxP2I9kmXUaK5mvdcBaOKHu3ajXC2uE4pw==
X-Received: by 2002:a17:90b:2e0c:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34f68c28ea4mr14325154a91.5.1768285516247;
        Mon, 12 Jan 2026 22:25:16 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fed231fcsm419971a91.5.2026.01.12.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:25:15 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v3 1/2] btrfs: fix periodic reclaim condition
Date: Tue, 13 Jan 2026 12:07:04 +0800
Message-ID: <20260113060935.21814-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113060935.21814-2-sunk67188@gmail.com>
References: <20260113060935.21814-2-sunk67188@gmail.com>
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
perioidc reclaim  when there's enough free space.

Suggested-by: Boris Burkov <boris@bur.io>
Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c |  6 +++++-
 fs/btrfs/space-info.c  | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7..f0945a799aed 100644
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
@@ -1989,13 +1991,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			spin_lock(&space_info->lock);
 			space_info->reclaim_errors++;
 			if (READ_ONCE(space_info->periodic_reclaim))
-				space_info->periodic_reclaim_ready = false;
+				btrfs_set_periodic_reclaim_ready(space_info, false);
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


