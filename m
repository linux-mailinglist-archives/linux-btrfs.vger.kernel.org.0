Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7513057BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316716AbhAZXJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbhAZVZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:40 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43604C061793
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e17so13395470qto.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P19juSt88aaDuEk7yo6I9PILHC5D20fJUcCnAP6+H28=;
        b=IgJLcHy4edVyOIDPT4grN3UHiFciqXtlzUNB1hLj45f2Jplr4FXKAfJTzLk5zMGi73
         F/bS+LXM4E43uie+C9pXeqEr25AXtxMdE3JtxJCfU6gzbyadgqAZxoh0ozNL5pR0OFeE
         BY+AAGYRRz068PvfRjU1HICN27vNs+pFKFwAjFalXE+TL5v6gyFd8NGlUvz93i8WdXqi
         IhjiUCxGXQ6KavNwrnB3pHAI6o0QAHr8EcQYiHKwhTaU9ZtA1vo/F1EXq9bg7VNRVIfQ
         49oWWi9t9/7CN4HQ8K20sziQuPl89GtDEdDRhfYCfLRD8GsEe3GiRAlkezzMwJlNbEaB
         yxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P19juSt88aaDuEk7yo6I9PILHC5D20fJUcCnAP6+H28=;
        b=svVMlVMAfia5gUxq2hnTH81yiAbhNnOCcrUsrhksJ5dCEWBX8ut/3sSZaZmTfvcxRl
         yHbtZTtA3ltitBlQ/MJL/oq9dqpsuh2DF7EoYmPTMyTkvX9BJOFh5iYntU7zuYc8AP56
         YSs1Lm8x21FflW3LyONFqEOY6DGPS9yocvDLgDHs7D06E+C2zI9AtalJW/xNSvEuXapL
         wU/jwbftNQQS1jUBrRDc5OpKIuSdfniqe5Bf9XnFEmG8rFVAsbb+eTamDJqNwN7fPTMO
         Ix40828p83bP0hYiUzVteL0R0Nh+aHeZETMgwDcaFKBWxwkQ1PStVAkNYX9fIXylV5XU
         6HLg==
X-Gm-Message-State: AOAM5335gZLl8Ad4lUSxWCa5Trj2CFv33eQe7DsczIMx9WsBBMzGdLfO
        AJHzzYgM4tfxwQHIBN9TVlVcErgs79XAEGUK
X-Google-Smtp-Source: ABdhPJzL7QdaMF3HiMMpzmKPBZcZvA7P29c7dLbs/f6Xm5zLj+qiddcHlEAxcy3/AHOAyIiqghpXjQ==
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr7237574qtw.87.1611696294044;
        Tue, 26 Jan 2021 13:24:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m21sm14406980qtq.52.2021.01.26.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 09/12] btrfs: simplify the logic in need_preemptive_flushing
Date:   Tue, 26 Jan 2021 16:24:33 -0500
Message-Id: <8f206fd7fece62626124cc1d5272b81f10bc19ee.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A lot of this was added all in one go with no explanation, and is a bit
unwieldy and confusing.  Simplify the logic to start preemptive flushing
if we've reserved more than half of our available free space.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 73 ++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8f3b4cc8b812..1c4226f78e27 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -780,11 +780,11 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 }
 
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 used)
+				    struct btrfs_space_info *space_info)
 {
+	u64 ordered, delalloc;
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
-	u64 to_reclaim, expected;
+	u64 used;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -797,26 +797,52 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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
@@ -1013,7 +1039,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
-	u64 used;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1024,8 +1049,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	trans_rsv = &fs_info->trans_block_rsv;
 
 	spin_lock(&space_info->lock);
-	used = btrfs_space_info_used(space_info, true);
-	while (need_preemptive_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info)) {
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1087,7 +1111,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		flush_space(fs_info, space_info, to_reclaim, flush);
 		cond_resched();
 		spin_lock(&space_info->lock);
-		used = btrfs_space_info_used(space_info, true);
 	}
 	spin_unlock(&space_info->lock);
 }
@@ -1512,7 +1535,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

