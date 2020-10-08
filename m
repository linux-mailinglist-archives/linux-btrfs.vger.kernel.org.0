Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C8287D75
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgJHUtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgJHUtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF4C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 140so6757054qko.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J10bwqxUMUJRDGcvCUpdvN+5/oBXir1tP9do4FvVUmM=;
        b=0qY5nzIqbxafQPD4koy0rWsCXYIa8HGtd+h0vzJCIyNG5z2PrDSpEkvfwPPzlEfHKP
         uSj7jHiFkUvMSz3M6E3eyPnWLq3B+l9k1u8P8aDyrkbpVN7oRr/PBh8vkCCCErZ/O70t
         pLd9vybcPSLzSXoZCUeZ2n62hfJhpSnVGRm7s3HcZssQkNDyBXrerjDIs5AjFdrmZuHp
         o7OacZKlafEYv0L64tKYjRPnDcyptG2iZgIvvjEGn8sKcPZz/QXDSUJthOejOf0WwWrz
         tQEQTr2aN1dFtRFH8Edh3VP88xYlivn4CGhOH7U4qqWvhXpuUi+U80zxHv3wDNV9gUfg
         Q4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J10bwqxUMUJRDGcvCUpdvN+5/oBXir1tP9do4FvVUmM=;
        b=UpRgdgJ2wKeiZERCIYHw9V+qoXzMzXrBOgJP3ULJDijlwqWatYT/DYEmqNZkCKd+14
         XklJzrD7/zQFG0D528DHGjSX0hdIrwyPYlU6GD3uYZUuLjtpYcOwUyYCNTBOgSR0pDbn
         B+CDVus25IH8dqtFRpQ8Bz9VbBBKU5EYCEnrt4cWZWzlFZhW0DnL6u7xjANv3jQkuegL
         EKE6xK1RTLB3tB+Ll+S03EIu0zgmPupr9aSP0Q2nmniJAORM0U7Z6K+lLtMUeVi9eSI8
         xGIhs60LFkwUHJmbu3u125EjuD5zKxolmigWwcidZZdyO4098hHD+RUNtLDhY5ho0wjc
         JJog==
X-Gm-Message-State: AOAM531NjHtSeh+WaeQLGG2Q/i4Xq3Rx3Mliri6UPBgV9xO9Jyw2jgDI
        Wyy8xyLjTtof6wf5DlaOYZB96VhZVHbi35Nu
X-Google-Smtp-Source: ABdhPJxzIaZJPQ78E6RStEWPNa4oOs5QiNswrA1Pztz/zR/AVuq2xShwbig1+wpWmrKvsPEEpHH90A==
X-Received: by 2002:a37:4854:: with SMTP id v81mr10253899qka.20.1602190153427;
        Thu, 08 Oct 2020 13:49:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l30sm4970467qta.73.2020.10.08.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 09/11] btrfs: implement space clamping for preemptive flushing
Date:   Thu,  8 Oct 2020 16:48:53 -0400
Message-Id: <501bfeaa3dc6f4c59dd6062f6108bab974316b85.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Starting preemptive flushing at 50% of available free space is a good
start, but some workloads are particularly abusive and can quickly
overwhelm the preemptive flushing code and drive us into using tickets.

Handle this by clamping down on our threshold for starting and
continuing to run preemptive flushing.  This is particularly important
for our overcommit case, as we can really drive the file system into
overages and then it's more difficult to pull it back as we start to
actually fill up the file system.

The clamping is essentially 2^CLAMP, but we start at 1 so whatever we
calculate for overcommit is the baseline.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 40 ++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/space-info.h |  3 +++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4dfd99846534..71bebb60f0ce 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -206,6 +206,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->ro_bgs);
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
+	space_info->clamp = 1;
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
@@ -811,13 +812,13 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * because this doesn't quite work how we want.  If we had more than 50%
 	 * of the space_info used by bytes_used and we had 0 available we'd just
 	 * constantly run the background flusher.  Instead we want it to kick in
-	 * if our reclaimable space exceeds 50% of our available free space.
+	 * if our reclaimable space exceeds our clamped free space.
 	 */
 	thresh = calc_available_free_space(fs_info, space_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	thresh += (space_info->total_bytes - space_info->bytes_used -
 		   space_info->bytes_reserved - space_info->bytes_readonly);
-	thresh >>= 1;
+	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_pinned;
 
@@ -1041,6 +1042,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
+	int loops = 0;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1057,6 +1059,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 to_reclaim, block_rsv_size;
 		u64 global_rsv_size = global_rsv->reserved;
 
+		loops++;
+
 		/*
 		 * We don't have a precise counter for the metadata being
 		 * reserved for delalloc, so we'll approximate it by subtracting
@@ -1114,6 +1118,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
+
+	/* We only went through once, back off our clamping. */
+	if (loops == 1 && !space_info->reclaim_size)
+		space_info->clamp = max(1, space_info->clamp - 1);
 	spin_unlock(&space_info->lock);
 }
 
@@ -1427,6 +1435,26 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
 		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 }
 
+static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
+				       struct btrfs_space_info *space_info)
+{
+	u64 ordered, delalloc;
+
+	ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
+	delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
+
+	/*
+	 * If we're heavy on ordered operations then clamping won't help us.  We
+	 * need to clamp specifically to keep up with dirty'ing buffered
+	 * writers, because there's not a 1:1 correlation of writing delalloc
+	 * and freeing space, like there is with flushing delayed refs or
+	 * delayed nodes.  If we're already more ordered than delalloc then
+	 * we're keeping up, otherwise we aren't and should probably clamp.
+	 */
+	if (ordered < delalloc)
+		space_info->clamp = min(space_info->clamp + 1, 8);
+}
+
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
  * @root - the root we're allocating for
@@ -1519,6 +1547,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			list_add_tail(&ticket.list,
 				      &space_info->priority_tickets);
 		}
+
+		/*
+		 * We were forced to add a reserve ticket, so our preemptive
+		 * flushing is unable to keep up.  Clamp down on the threshold
+		 * for the preemptive flushing in order to keep up with the
+		 * workload.
+		 */
+		maybe_clamp_preempt(fs_info, space_info);
 	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
 		used += orig_bytes;
 		/*
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5646393b928c..bcbbfae131f6 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -22,6 +22,9 @@ struct btrfs_space_info {
 				   the space info if we had an ENOSPC in the
 				   allocator. */
 
+	int clamp;		/* Used to scale our threshold for preemptive
+				   flushing. */
+
 	unsigned int full:1;	/* indicates that we cannot allocate any more
 				   chunks for this space */
 	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
-- 
2.26.2

