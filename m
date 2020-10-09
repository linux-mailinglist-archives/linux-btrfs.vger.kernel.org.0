Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204A2889CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgJIN25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbgJIN2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A6C0613D5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 140so8792262qko.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RS0oQDjA5A5QUfN1iSuMt4UMje6pwQsmdNJPdcNDTL4=;
        b=iG0DkuXPyUcc/dsOG2jvgY9LB9PMkKiGv9tzaU+NsO6TVzn0Ag4kXGrBA8DF4kMsRZ
         0/0bFR90GvbnSyizviPSRPQaYFHsruSkNwhkHWwKRRtvQNTiTBPuoh473gSormUKTu3E
         1MgAvAXx0CvpHxpun3Zbhdk/bkUXaVGdp4fLm4dQgvXPyPjDs6qrnmsvjH8pEhqaBr6m
         8725nJZbq/6iQRu7GgRpd/7Eb4Ipg7Ua+mpWV9lN2vyi0L2H+fw9524radBQIzJDvpGN
         Y5hYvP5b4I4IJrcoCeZ6OHFsEX17o/5oTm50TnYyHC8N8F1Lpendm5ruxHfhWQb1zk7j
         U47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RS0oQDjA5A5QUfN1iSuMt4UMje6pwQsmdNJPdcNDTL4=;
        b=i5WkClp5Clp3NqtwSMr+ejEfwmX/UK8qEe4UqMdPrXDnHFJuugrzoVKoWrOXCkzZVg
         FnqYJfFaLO+6p+I0bOdZQ5pPgDac5k7JiuE/MWeCAfh65qw8J8eSUAPK7VyP9R0Lrk1z
         cwAlaHNWqifKNXV66KubX45bI1SzieEfFLw26cgih9LzuGrhrSyKtIBlU4WwoxaWdr8h
         DL4jsLa4CRn6pMZRlme70yG/vsv8HVy5iS87RlomGQWtHYBzi9OuUgAsyMnCMOo86a0s
         i6rlcZO61puFXiRDOWbksH5/S63LeNpjTpMGu8N1qPsxc1z4IC6Bc5kQOTdaN4zfMl/8
         LF0w==
X-Gm-Message-State: AOAM530amYHlYrc1YEV13LBuuSGce5CIscLV0hXiTsPQQeqcCerhNwju
        0swZeq4ECdIGz4zIERu9ecjaYbnsRMTt+FRD
X-Google-Smtp-Source: ABdhPJy1lr8WWgRyWqtA4QKK7JcHKq5JktbuZFllRgv9TjdhtHIKDz2gLr1jSJZ+BSNoNnKRdQIPDQ==
X-Received: by 2002:a37:8044:: with SMTP id b65mr3147708qkd.24.1602250130981;
        Fri, 09 Oct 2020 06:28:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm6304459qkb.103.2020.10.09.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 10/12] btrfs: implement space clamping for preemptive flushing
Date:   Fri,  9 Oct 2020 09:28:27 -0400
Message-Id: <5ddb5076afa5872f8edf3bb4ea17aacec8e079fd.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 38 ++++++++++++++++++++++++++++++++++++--
 fs/btrfs/space-info.h |  3 +++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c56a4827956f..5ee698c12a7b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -206,6 +206,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->ro_bgs);
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
+	space_info->clamp = 1;
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
@@ -806,13 +807,13 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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
 
@@ -1036,6 +1037,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
+	int loops = 0;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1052,6 +1054,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 to_reclaim, block_rsv_size;
 		u64 global_rsv_size = global_rsv->reserved;
 
+		loops++;
+
 		/*
 		 * We don't have a precise counter for the metadata being
 		 * reserved for delalloc, so we'll approximate it by subtracting
@@ -1109,6 +1113,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
+
+	/* We only went through once, back off our clamping. */
+	if (loops == 1 && !space_info->reclaim_size)
+		space_info->clamp = max(1, space_info->clamp - 1);
 	spin_unlock(&space_info->lock);
 }
 
@@ -1422,6 +1430,24 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
 		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 }
 
+static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
+				       struct btrfs_space_info *space_info)
+{
+	u64 ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
+	u64 delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
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
@@ -1514,6 +1540,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

