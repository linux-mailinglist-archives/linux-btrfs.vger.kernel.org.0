Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0628527F2E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgI3UBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgI3UBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E0C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so2790261qke.12
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5T4eeHdnmKr5ODQ2vQG6/MB7MsF6PHFHpGutlLVudRM=;
        b=XDoln5lIkSj/M0A6ggyyQlnPwxL3BPuo739hgRjyLuundCM9Q5ofv2fcYthGpLbAQN
         rox7gzRuZlbsJQynDi6B26v/ZidWVzwMM0lsgoWTneBIPzedyCI28iXUhaxrc9UkvXSX
         ZlFpiqXjbuhu/g4FDUFagUuZKCwdc4K/SOBbc/v7WmJBag2fpl51YE5FaGrSkqXCWKt6
         LulDrvsLG+6BOV+/49rxUNN1cAbNrJDSsIKOnqu5+Z0EaS2w8yYztF4j7d1brU8Y409F
         Xe2wicxfjngYHZRP2oQ9AemTdVL5O4NCP4YSPYm/peBAnHTSeuKTD89t/2hFX6/sPGYk
         CroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5T4eeHdnmKr5ODQ2vQG6/MB7MsF6PHFHpGutlLVudRM=;
        b=Hr3n6WJbxLOx4/By9tzTgJ+gCqn0YkZTa2Jxs7L8LcmCn7xotFv8n5Dm1D4XblEJf5
         GA68IVW2z6qe1XN4JMSNtQVEbws4aMFTopArqwOLRx+2OWmfpJlro0+7FuA+wKBWoaL9
         ehcSUG/fXCvkoYaqX0aQu19TbN77mBVoNFijWZSkZ4PHbkasGPqzMdaHtsU+gGif4tkt
         jsVRd8zzoQovrbTYpM5QLF2sG8cUNzI83yDfQKowscpMvC8KyjkGjGtsYvDt7BlW9QYC
         U4RfP1ZZk68BgQH0dNHC9/Bg2HaYXwm/rCcnaF8U+aVlT2toIqH5Dex0ursXylWcvs/P
         wERg==
X-Gm-Message-State: AOAM533oAxPhxIAVy0kMip2/6pkF0Jj3laM7NoUlCeBz1fDquutQ3vq1
        Tu6mMprUY4T7zcylPDS896VHtLuKy6vrmeP+
X-Google-Smtp-Source: ABdhPJxc7vlxc/vydg9DtbouCSQTrf55fXenLWI/ePvOlCe2IlKJqU6cOBUBGwUhr1y0vQt+3bKaCw==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr4213494qkk.386.1601496094170;
        Wed, 30 Sep 2020 13:01:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x43sm3989995qtx.40.2020.09.30.13.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/9] btrfs: simplify the logic in need_preemptive_flushing
Date:   Wed, 30 Sep 2020 16:01:06 -0400
Message-Id: <8f5cc79f377c0358c3ad40188bf5917b4bc07924.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A lot of this was added all in one go with no explanation, and is a bit
unwieldy and confusing.  Simplify the logic to start preemptive flushing
if we've reserved more than half of our available free space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 37eb5a11a875..a41cf358f438 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -773,11 +773,10 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 }
 
 static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-					  struct btrfs_space_info *space_info,
-					  u64 used)
+					  struct btrfs_space_info *space_info)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
-	u64 to_reclaim, expected;
+	u64 used;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -790,26 +789,27 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if (space_info->reclaim_size)
 		return 0;
 
-	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		return 0;
-
-	used = btrfs_space_info_used(space_info, true);
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		expected = div_factor_fine(space_info->total_bytes, 95);
-	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
+	/*
+	 * If we have over half of the free space occupied by reservations or
+	 * pinned then we want to start flushing.
+	 *
+	 * We do not do the traditional thing here, which is to say
+	 *
+	 *   if (used >= ((total_bytes + avail) >> 1))
+	 *     return 1;
+	 *
+	 * because this doesn't quite work how we want.  If we had more than 50%
+	 * of the space_info used by bytes_used and we had 0 available we'd just
+	 * constantly run the background flusher.  Instead we want it to kick in
+	 * if our reclaimable space exceeds 50% of our available free space.
+	 */
+	thresh = calc_available_free_space(fs_info, space_info,
+					   BTRFS_RESERVE_FLUSH_ALL);
+	thresh += (space_info->total_bytes - space_info->bytes_used -
+		   space_info->bytes_reserved - space_info->bytes_readonly);
+	thresh >>= 1;
 
-	if (used > expected)
-		to_reclaim = used - expected;
-	else
-		to_reclaim = 0;
-	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
-				     space_info->bytes_reserved);
-	if (!to_reclaim)
-		return 0;
+	used = space_info->bytes_may_use + space_info->bytes_pinned;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
@@ -1006,7 +1006,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
-	u64 used;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1017,8 +1016,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	trans_rsv = &fs_info->trans_block_rsv;
 
 	spin_lock(&space_info->lock);
-	used = btrfs_space_info_used(space_info, true);
-	while (need_preemptive_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info)) {
 		enum btrfs_reserve_flush_enum flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1101,7 +1099,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 next:
 		cond_resched();
 		spin_lock(&space_info->lock);
-		used = btrfs_space_info_used(space_info, true);
 	}
 	spin_unlock(&space_info->lock);
 }
@@ -1512,7 +1509,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_preemptive_reclaim(fs_info, space_info, used) &&
+		    need_preemptive_reclaim(fs_info, space_info) &&
 		    !work_busy(&fs_info->preempt_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
-- 
2.26.2

