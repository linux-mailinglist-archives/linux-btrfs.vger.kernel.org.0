Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2027F2E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgI3UBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgI3UBd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2DC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so2326287qtu.4
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NEO7JaJRYOJ9+2Ya+pOMAE5K48OuLEcjGqV3Ac/EO7g=;
        b=DmaqX8FfVd4MWILxeKcF8+jg5XxyVKJLCqyWMsTqksmQJMwVevp24FgOIwvXKJNIxD
         GIP5Sz9CIjnE3BZYU36K61In7f4ltbRO7fP2w0YlOoe6dREMvvFkv4Y3S0MAhnIW+0Qh
         BuTuAyDVc01TrRuQuv/fzFz1EkvOGRkr58Kzsxl4gFae4p0+6hIrqyfwUjbKfd7c+cz5
         BRhVkBl5jpl5R1wXUXRu58r2raAaQ2Hn7DR4/8qufMZWatGgANt77MQhWORPbcrLEKDk
         R/0iZD591Wfls0pDXaIFLrVFvFQBsOk7ha+xprzVuUi0xifrAV3FpvjG4EhDCEn4r6CP
         zhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEO7JaJRYOJ9+2Ya+pOMAE5K48OuLEcjGqV3Ac/EO7g=;
        b=jYXzKMbQ1e7TRMjHPIgO25sTjIMg1qO3wma6H+wtELTvsjjncP3llwjWeLh7lfBd98
         M2DcDonhuRxxEth2W3BapSywIATL0duOhDkgyG2EKksgwyT24U9o/z8GR8sAO4yLSTgN
         K5dzRlL2nyhycHi96okn/r0r047zUXq44n4mHWG7f5Sfv17rYfbgCnVhD05OP0K60t8L
         Tmm7ACi5bZp/NvUrSeZY/B/BlsZSH2QoV+jeWcAOdhpHFBfTXQgb4syocRJxYcIinuSh
         tMakfVVVW92lj1M/o5uZALwKOEywU38zCKtxZRWqwwWQsUloQ1dvGLmBPbLzZMGo4PyN
         Kfng==
X-Gm-Message-State: AOAM530UjqfBm8c5XwgJceWM/KuYTn/EeEV1yJQ3/MFZFi0bN5jRSLN/
        ah4cP/Yz49eIPmBE05TqTkz0peUxsij788r3
X-Google-Smtp-Source: ABdhPJwcXyjJglfOw0OJFR2WXiFaJCAVfGLHKY3PpcEklMs/w4iTYtpIT7uTBpIcEM9z4sUbLWMbTQ==
X-Received: by 2002:ac8:4cd0:: with SMTP id l16mr3951885qtv.175.1601496091724;
        Wed, 30 Sep 2020 13:01:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p192sm3691105qke.7.2020.09.30.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: rework btrfs_calc_reclaim_metadata_size
Date:   Wed, 30 Sep 2020 16:01:05 -0400
Message-Id: <bc6b0eeceacb2b444acf1ff74673471e2dfd2bb9.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_calc_reclaim_metadata_size does two things, it returns
the space currently required for flushing by the tickets, and if there
are no tickets it calculates a value for the preemptive flushing.

However for the normal ticketed flushing we really only care about the
space required for tickets.  We will accidentally come in and flush one
time, but as soon as we see there are no tickets we bail out of our
flushing.

Fix this by making btrfs_calc_reclaim_metadata_size really only tell us
what is required for flushing if we have people waiting on space.  Then
move the preemptive flushing logic into need_preemptive_reclaim().  We
ignore btrfs_calc_reclaim_metadata_size() in need_preemptive_reclaim()
because if we are in this path then we made our reservation and there
are not pending tickets currently, so we do not need to check it, simply
do the fuzzy logic to check if we're getting low on space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 44 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 518749093bc5..37eb5a11a875 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -752,7 +752,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
-	u64 expected;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -770,28 +769,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	if (space_info->total_bytes + avail < used)
 		to_reclaim += used - (space_info->total_bytes + avail);
 
-	if (to_reclaim)
-		return to_reclaim;
-
-	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		return 0;
-
-	used = btrfs_space_info_used(space_info, true);
-
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		expected = div_factor_fine(space_info->total_bytes, 95);
-	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
-
-	if (used > expected)
-		to_reclaim = used - expected;
-	else
-		to_reclaim = 0;
-	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
-				     space_info->bytes_reserved);
 	return to_reclaim;
 }
 
@@ -800,6 +777,7 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 					  u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 to_reclaim, expected;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -812,7 +790,25 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if (space_info->reclaim_size)
 		return 0;
 
-	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
+	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL))
+		return 0;
+
+	used = btrfs_space_info_used(space_info, true);
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL))
+		expected = div_factor_fine(space_info->total_bytes, 95);
+	else
+		expected = div_factor_fine(space_info->total_bytes, 90);
+
+	if (used > expected)
+		to_reclaim = used - expected;
+	else
+		to_reclaim = 0;
+	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
+				     space_info->bytes_reserved);
+	if (!to_reclaim)
 		return 0;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
-- 
2.26.2

