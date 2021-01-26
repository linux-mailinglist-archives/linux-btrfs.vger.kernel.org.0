Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF72304D7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 01:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbhAZXJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbhAZVZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA7C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:56 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id es14so82917qvb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SlPFu4lBYS5XRiSORK34z2z5M4INkKulUNtRUu9/dPg=;
        b=jukiSguvCOviD/9JSRXraXAs+2XFpsN7pduxHV/x131YcV0U8EOg1+9HGogP1kVFoX
         c5Iq1IVEO7kSDK7sgjMmnXJvkKG76UR9QOPed/rWu2GOzPdF/Yg60uBaJPgESePzqmod
         y4CrbgQK+TdOEoZj13VgS8XIx4/+FbWB4ywI0cM67D/Cjcmr1P0+Kf8gd4YWtX9j7Ep5
         aYIKTqufOLS8Iv6UyEUsouQUO/3naq42ApODPxoQsYj9kaHFMBBzt6dvBoBkY7JbwL3r
         SFBNz3N27FTMhipYWdwVltPS/zbfd1M8znFlNkJbRJ2NyZMF6RPxQ0THCmyoeUwu5JdB
         7ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlPFu4lBYS5XRiSORK34z2z5M4INkKulUNtRUu9/dPg=;
        b=rjeqTC9ZcsNvjLfwjc4YY2fRoucDm+EOaTIFgB1/KaHUZux48Zsn1zhZKgDyIfPVI9
         4xkV6Hk9OXmipm9LJUuv1R5E0e6bS/Lir9E7kpRMDxofzALozdUmj0JzxsX5nIaNA3ll
         qNuRwvSFzno6EiU8S+fWb6mekZJ8OlrVOkbsBMsyg6zTw/FSeZn4NaQpP99MCvHUE1Vz
         bT3vdSsyQrATQ7bILyNCema5tnqifb6HpafbCxXVaE+P+hDdhwQFqULL5cb17K/MqvJi
         W/e9tBrElrW/3CHV0TGEIUFOLDhTStHHI0pW4BHPbBXkTiHt0NnviGw3MODif8+CgPDQ
         Ftuw==
X-Gm-Message-State: AOAM532pToQ9viU989M1QPlclFePR142eIat4XRUEtN3ZVLTymyaJ46A
        rHYED4TYRGweK5BekGjJGOTsUN7XWMCBNrnH
X-Google-Smtp-Source: ABdhPJxNzrqDQszb5W3ZJZ+kYf2c5EhznPkL5SxWGteEqNT9+Wf5x6teMOUXcC7KUWmKTRzSLPtAKg==
X-Received: by 2002:ad4:45b0:: with SMTP id y16mr7648729qvu.3.1611696295654;
        Tue, 26 Jan 2021 13:24:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h6sm13529774qtx.39.2021.01.26.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 10/12] btrfs: implement space clamping for preemptive flushing
Date:   Tue, 26 Jan 2021 16:24:34 -0500
Message-Id: <8bece7f165ba8b7b17aedc131533302434093afc.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/space-info.h |  4 ++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1c4226f78e27..6afb9cac694a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -206,6 +206,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->ro_bgs);
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
+	space_info->clamp = 1;
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
@@ -809,13 +810,26 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * because this doesn't quite work how we want.  If we had more than 50%
 	 * of the space_info used by bytes_used and we had 0 available we'd just
 	 * constantly run the background flusher.  Instead we want it to kick in
-	 * if our reclaimable space exceeds 50% of our available free space.
+	 * if our reclaimable space exceeds our clamped free space.
+	 *
+	 * Our clamping range is 2^1 -> 2^8.  Practically speaking that means
+	 * the following
+	 *
+	 * Amount of RAM	Minimum threshold	Maximum threshold
+	 * 256GIB		1GIB			128GIB
+	 * 128GIB		512MIB			64GIB
+	 * 64GIB		256MIB			32GIB
+	 * 32GIB		128MIB			16GIB
+	 * 16GIB		64MIB			8GIB
+	 *
+	 * These are the range our thresholds will fall in, corresponding to how
+	 * much delalloc we need for the background flusher to kick in.
 	 */
 	thresh = calc_available_free_space(fs_info, space_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	thresh += (space_info->total_bytes - space_info->bytes_used -
 		   space_info->bytes_reserved - space_info->bytes_readonly);
-	thresh >>= 1;
+	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_pinned;
 
@@ -1039,6 +1053,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
+	int loops = 0;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1055,6 +1070,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 to_reclaim, block_rsv_size;
 		u64 global_rsv_size = global_rsv->reserved;
 
+		loops++;
+
 		/*
 		 * We don't have a precise counter for the metadata being
 		 * reserved for delalloc, so we'll approximate it by subtracting
@@ -1112,6 +1129,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
+
+	/* We only went through once, back off our clamping. */
+	if (loops == 1 && !space_info->reclaim_size)
+		space_info->clamp = max(1, space_info->clamp - 1);
 	spin_unlock(&space_info->lock);
 }
 
@@ -1434,6 +1455,24 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
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
  * Try to reserve bytes from the block_rsv's space
  *
@@ -1527,6 +1566,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
index 74706f604bce..8870bd7805b5 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -22,6 +22,10 @@ struct btrfs_space_info {
 				   the space info if we had an ENOSPC in the
 				   allocator. */
 
+	int clamp;		/* Used to scale our threshold for preemptive
+				   flushing.  The value is >> clamp, so
+				   turns out to be a 2^clamp divisor. */
+
 	unsigned int full:1;	/* indicates that we cannot allocate any more
 				   chunks for this space */
 	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
-- 
2.26.2

