Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6040C287D74
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgJHUtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgJHUtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05970C0613D3
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so8420980qkk.12
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JbC6vn7ZVqIJL+b/MUMEBlIHIAOgIKH2TkxD4nMyKXU=;
        b=gz3gBGcFMAyfbZ7XFzVASPHA7Qo4sW23Sy3qs1bw/QOHwbxUNL4plzeRVYAwkq4rqP
         OB5V9FNkhI7g0RPh5tmyT5+1+KdPaLr3ZiO5Dap1phosOQSkp6LyBPAh2D6SgDb6L5xu
         9i4GXgnCBkV2I/NIo2bwH49u3QhpHwpY7KszT9mxFMJZQD7V71aUfQsBjbmbE3Q7GvhU
         Mz96xIeOs4cDIzYQN3LCsRpZ27tZLPKdkUCIT5OSga5DrtpiZWOwfGlfoWtureI+k2Dv
         XNICaoh+gTl24V2eDVJs7zHfwge+3STaCnPFpOLX5umCcp+MclFxLjBwde0KKEWgvd8t
         rw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbC6vn7ZVqIJL+b/MUMEBlIHIAOgIKH2TkxD4nMyKXU=;
        b=bOsKNx8Mia+GZ2Xu6sQVGcG+oK04l7i6F4fVIlC9tuVvjgKmWNbEisYSVDeL/uG8oz
         lgAjxw0SLNJwuA288YfEcGzMR3Wx52AlLMo4OhY+nBeoOTDd1SAoRvpDaE0SYYFR3gv+
         kJxZnyd5F8OW1zcsD3CJChtAxjTtOIcNbv8CWHGOPqJ3S7gkgXR2+2/0BC7txdHPIkM9
         fQKVWykTbZFGo3N4rLHrGrK5uQIEpB3JTV04d7Fo5L6hVp7Di1fgteg5rY8Zv8/covaj
         cdj+4JWQK53rwwXsHh4Ne/BfIIsvasTaAVqJ0va+1xbaLz3CPTIIVvEeNwuY1+OURGbT
         PZZA==
X-Gm-Message-State: AOAM533eD8Yivb167y/5gtxYF3DDC3S/Tfb7KFBnOT/tXvYyJ45rMhTI
        ReG5JDVkQsYK0cajgWu3sh1pvh49C9F9uHNQ
X-Google-Smtp-Source: ABdhPJwNVpwmZjM4e/JyoorxzXvJ/9OJyOekixUggjCTbp3wJiTECtBvwrPl0lFHiE9RoOeEBhry+A==
X-Received: by 2002:a37:a251:: with SMTP id l78mr9577394qke.291.1602190151816;
        Thu, 08 Oct 2020 13:49:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p17sm3932427qtq.79.2020.10.08.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/11] btrfs: simplify the logic in need_preemptive_flushing
Date:   Thu,  8 Oct 2020 16:48:52 -0400
Message-Id: <6602110b46e619a85bddfa0d19e936e303120bfc.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
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
index 82cc3985a4b6..4dfd99846534 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -782,11 +782,11 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
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
@@ -799,26 +799,52 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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
@@ -1015,7 +1041,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
-	u64 used;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1026,8 +1051,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	trans_rsv = &fs_info->trans_block_rsv;
 
 	spin_lock(&space_info->lock);
-	used = btrfs_space_info_used(space_info, true);
-	while (need_preemptive_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info)) {
 		enum btrfs_reserve_flush_enum flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1089,7 +1113,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		flush_space(fs_info, space_info, to_reclaim, flush);
 		cond_resched();
 		spin_lock(&space_info->lock);
-		used = btrfs_space_info_used(space_info, true);
 	}
 	spin_unlock(&space_info->lock);
 }
@@ -1504,7 +1527,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

