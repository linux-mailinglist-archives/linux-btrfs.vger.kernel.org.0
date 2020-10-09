Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6492889CB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgJIN24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbgJIN2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDCC0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t9so7076938qtp.9
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DvrRtm8z7A1+P+r6iBYaK/ETxF//2ZbyFMbquOwZMU4=;
        b=b7OMNvgeVvhdWUIe/4kLPkY37CyzUHvuhdjcpn2twTXVj1cc/ldUC2+AUfsnwCRYyT
         kj/PRLoJv+sHU1ktNwl8gXab32BBYWpZ1SJIDn4HHkYEFFVoyGAtCEcEQtdiouqnt3Ov
         Ez+PfG56PLzFUT5kyTnWQePwRZYHSpyd5lBt7PmnAgHgwkoxe6QPo61ebGxYakn7Es4g
         QaTqGi+ifnlTv3eigxz1x8nRkgVLbnhiDuGfOVCUPtFrg9rH5dfIIxIUdupb4GqousvX
         UU3i5S3dNijuulVfmUucQomBTe1/GH/FpaJNaTK4J6jMVV4y2rLJ2VrmFe/oG/QYRphs
         tgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvrRtm8z7A1+P+r6iBYaK/ETxF//2ZbyFMbquOwZMU4=;
        b=qHxWo5X6vcAFd0YcxKkT8EANtDWLvIa6XSydyLyg7HgSyrumoGrAnEHL+BtX6r1to1
         HPK4B/W5t/+xqwGprwoAwWe1/tY2d1e2ZcW2ssRSkgx4eaRIQ1LwwtFsy0lcMpKMQ8Fn
         vU7yP0l0WNptQsAYtKbcsG2GWqVV8GsN7wBsWN+/YsHQSOzQ+htaOUk7blHX9othQWbW
         8oqGgTgExB6gLA/8Evsd/cSFmfDtPV0bOZ8CfZNM1BQvrtG9OtC1FdrprbRc9Wj1r6CE
         QHzaIu3msPDz4vIxijCEMQNcMihLMyd+XwkZxRK0Gfq06r8H/f6Nn6a4u2k3mcxy5uh1
         l3Rw==
X-Gm-Message-State: AOAM532eYKomewb2v6jTbkpSL6AE/roeTUE96F3BWjh0X0GxZV1OqMkn
        sECzQpIYy7l4q9tHhDdDSiHS6F+DVUVyadLI
X-Google-Smtp-Source: ABdhPJwi97B1ZX4k5yBzANj4G3b6VALDj0IFmVx9txCxhFVCixlbT6EYctcnqoddWtxMdLsJznmgGQ==
X-Received: by 2002:ac8:1a62:: with SMTP id q31mr6045590qtk.389.1602250129311;
        Fri, 09 Oct 2020 06:28:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i70sm6027178qke.11.2020.10.09.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 09/12] btrfs: simplify the logic in need_preemptive_flushing
Date:   Fri,  9 Oct 2020 09:28:26 -0400
Message-Id: <8b46bf643eb38d6381345b9985b2abbdc47711ad.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 73 ++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 03141251d44e..c56a4827956f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -777,11 +777,11 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 }
 
 static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-					   struct btrfs_space_info *space_info,
-					   u64 used)
+					   struct btrfs_space_info *space_info)
 {
+	u64 ordered, delalloc;
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
-	u64 to_reclaim, expected;
+	u64 used;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -794,26 +794,52 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if (space_info->reclaim_size)
 		return 0;
 
-	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		return 0;
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
 
-	used = btrfs_space_info_used(space_info, true);
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		expected = div_factor_fine(space_info->total_bytes, 95);
-	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
+	used = space_info->bytes_pinned;
 
-	if (used > expected)
-		to_reclaim = used - expected;
+	/*
+	 * If we have more ordered bytes than delalloc bytes then we're either
+	 * doing a lot of DIO, or we simply don't have a lot of delalloc waiting
+	 * around.  Preemptive flushing is only useful in that it can free up
+	 * space before tickets need to wait for things to finish.  In the case
+	 * of ordered extents, preemptively waiting on ordered extents gets us
+	 * nothing, if our reservations are tied up in ordered extents we'll
+	 * simply have to slow down writers by forcing them to wait on ordered
+	 * extents.
+	 *
+	 * In the case that ordered is larger than delalloc, only include the
+	 * block reserves that we would actually be able to directly reclaim
+	 * from.  In this case if we're heavy on metadata operations this will
+	 * clearly be heavy enough to warrant preemptive flushing.  In the case
+	 * of heavy DIO or ordered reservations, preemptive flushing will just
+	 * waste time and cause us to slow down.
+	 */
+	ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
+	delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
+	if (ordered >= delalloc)
+		used += fs_info->delayed_refs_rsv.reserved +
+			fs_info->delayed_block_rsv.reserved;
 	else
-		to_reclaim = 0;
-	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
-				     space_info->bytes_reserved);
-	if (!to_reclaim)
-		return 0;
+		used += space_info->bytes_may_use;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
@@ -1010,7 +1036,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
-	u64 used;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1021,8 +1046,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	trans_rsv = &fs_info->trans_block_rsv;
 
 	spin_lock(&space_info->lock);
-	used = btrfs_space_info_used(space_info, true);
-	while (need_preemptive_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info)) {
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1084,7 +1108,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		flush_space(fs_info, space_info, to_reclaim, flush);
 		cond_resched();
 		spin_lock(&space_info->lock);
-		used = btrfs_space_info_used(space_info, true);
 	}
 	spin_unlock(&space_info->lock);
 }
@@ -1499,7 +1522,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

