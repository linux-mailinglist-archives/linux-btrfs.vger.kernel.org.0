Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9A76A1DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGaU24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 16:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGaU2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 16:28:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3022118
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 13:28:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-765a7768f1dso445113985a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690835332; x=1691440132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPUr8Zr/EOHoFfm7jEcuExhRfeHwV2bP/kQnDLRRqz0=;
        b=BzBr9Ns8Ej+5Wl6XxeYKUsm0bQUiuqksrnyXLNBTv/Oeyj8CY/CRu9smRebSqV1N5t
         cKVKqh4GMp2s77/8ZRVPbWokGBIYeZFd03m88+1w3YsrcFuuB5hHQXDdMPfo5YzJHs7H
         hX7kkQcdapR1bh2FblyHtsu3A/1OK7+iQ4i6GIwHXjqBAIoPnGakx/sgBVzknmoh4Xdl
         BRI1apcO2P+ixtknXNVwpuKOLG2HWn/uLnr8gY0b9OVqQtknAQ8hSnC1mlVY856hlu0l
         4EryfCxkqR88IdQcFjAVHeS0Fo32NeM7VYybaf9uXJrQYZRcX8UBvvlZnmPazreNPLw5
         RQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835332; x=1691440132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPUr8Zr/EOHoFfm7jEcuExhRfeHwV2bP/kQnDLRRqz0=;
        b=Q3qExJXlklgnoDIqNfe1/3ULjq7taLPCVAD5mVFxUM2qhRt9qCzD1ylXdguLgqReCf
         dUKlS3+iQqUnDxVXjhobIHU0Vur6fSLPCylIf/ZBhJ7DfnX1c0NU0tpbr1iaRJT+dHG3
         TxUGtNGpnouwlOXqCA5PX4F01vYRSKFWBp1lnIbkiD6Z3CuAZoscskpfqVa3Wxu1M4oj
         AA64clDeeem1F2C3Lnh0NqIDUzU3SSIA/JDDZqW2ksqAvQnF6i0jX2HOmFoH4ZiPOfTz
         q2dDSmWn1Uz4dgg3D+rV9ieEBuPIwxCzXLryhoiR07egLRxjwMg0XfroDhonZl8KBUtX
         kaBw==
X-Gm-Message-State: ABy/qLYs+PVf3UjfhH1a3IMqdsZMUyovFOBtBv5pisDqQG/C892/WfX1
        R8M3shZusmYOoQjjKzC2DWApLeNLD20mEWFgOBJwpw==
X-Google-Smtp-Source: APBJJlFk4Zaa63zXG5bCzpTHt5pE2wDC2i4cDFrhb6mFJEdpIR/JZbpyLEQKfmybhUHDh45NR6Yg/w==
X-Received: by 2002:a05:620a:40c4:b0:768:1db5:d9d7 with SMTP id g4-20020a05620a40c400b007681db5d9d7mr14709935qko.52.1690835332522;
        Mon, 31 Jul 2023 13:28:52 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id os31-20020a05620a811f00b00767e20c4267sm3586400qkn.61.2023.07.31.13.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:28:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: wait on uncached block groups on every allocation loop
Date:   Mon, 31 Jul 2023 16:28:43 -0400
Message-ID: <37333ca86d431906b58093d1700f0cfdbc57fa2c.1690835309.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My initial fix for the generic/475 hangs was related to metadata, but
our CI testing uncovered another case where we hang for similar reasons.
We again have a task with a plug that is holding an outstanding request
that is keeping the dm device from finishing it's suspend, and that task
is stuck in the allocator.

This time it is stuck trying to allocate data, but we do not have a
block group that matches the size class.  The larger loop in the
allocator looks like this (simplified of course)

find_free_extent
  for_each_block_group {
    ffe_ctl->cached == btrfs_block_group_cache_done(bg)
    if (!ffe_ctl->cached)
      ffe_ctl->have_caching_bg = true;
    do_allocation()
      btrfs_wait_block_group_cache_progress();
  }

  if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
    go search again;

In my earlier fix we were trying to allocate from the block group, but
we weren't waiting for the progress because we were only waiting for the
free space to be >= the amount of free space we wanted.  My fix made it
so we waited for forward progress to be made as well, so we would be
sure to wait.

This time however we did not have a block group that matched our size
class, so what was happening was this

find_free_extent
  for_each_block_group {
    ffe_ctl->cached == btrfs_block_group_cache_done(bg)
    if (!ffe_ctl->cached)
      ffe_ctl->have_caching_bg = true;
    if (size_class_doesn't_match())
      goto loop;
    do_allocation()
      btrfs_wait_block_group_cache_progress();
loop:
    release_block_group(block_group);
  }

  if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
    go search again;

The size_class_doesn't_match() part was true, so we'd just skip this
block group and never wait for caching, and then because we found a
caching block group we'd just go back and do the loop again.  We never
sleep and thus never flush the plug and we have the same deadlock.

Fix the logic for waiting on the block group caching to instead do it
unconditionally when we goto loop.  This takes the logic out of the
allocation step, so now the loop looks more like this

find_free_extent
  for_each_block_group {
    ffe_ctl->cached == btrfs_block_group_cache_done(bg)
    if (!ffe_ctl->cached)
      ffe_ctl->have_caching_bg = true;
    if (size_class_doesn't_match())
      goto loop;
    do_allocation()
      btrfs_wait_block_group_cache_progress();
loop:
    if (loop > LOOP_CACHING_NOWAIT && !ffe_ctl->retry_uncached &&
        !ffe_ctl->cached) {
       ffe_ctl->retry_uncached = true;
       btrfs_wait_block_group_cache_progress();
    }

    release_block_group(block_group);
  }

  if (loop == LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
    go search again;

This simplifies the logic a lot, and makes sure that if we're hitting
uncached block groups we're always waiting on them at some point.

I ran this through 100 iterations of generic/475, as this particular
case was harder to hit than the previous one.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 62 +++++++++++++-----------------------------
 fs/btrfs/extent-tree.h | 13 +++------
 2 files changed, 23 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3cae798499e2..6a3414545e01 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3432,7 +3432,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
  * Helper function for find_free_extent().
  *
  * Return -ENOENT to inform caller that we need fallback to unclustered mode.
- * Return -EAGAIN to inform caller that we need to re-search this block group
  * Return >0 to inform caller that we find nothing
  * Return 0 means we have found a location and set ffe_ctl->found_offset.
  */
@@ -3513,14 +3512,6 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 			trace_btrfs_reserve_extent_cluster(bg, ffe_ctl);
 			return 0;
 		}
-	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
-		   !ffe_ctl->retry_clustered) {
-		spin_unlock(&last_ptr->refill_lock);
-
-		ffe_ctl->retry_clustered = true;
-		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
-				ffe_ctl->empty_cluster + ffe_ctl->empty_size);
-		return -EAGAIN;
 	}
 	/*
 	 * At this point we either didn't find a cluster or we weren't able to
@@ -3535,7 +3526,6 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 /*
  * Return >0 to inform caller that we find nothing
  * Return 0 when we found an free extent and set ffe_ctrl->found_offset
- * Return -EAGAIN to inform caller that we need to re-search this block group
  */
 static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 					struct find_free_extent_ctl *ffe_ctl)
@@ -3573,25 +3563,8 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	offset = btrfs_find_space_for_alloc(bg, ffe_ctl->search_start,
 			ffe_ctl->num_bytes, ffe_ctl->empty_size,
 			&ffe_ctl->max_extent_size);
-
-	/*
-	 * If we didn't find a chunk, and we haven't failed on this block group
-	 * before, and this block group is in the middle of caching and we are
-	 * ok with waiting, then go ahead and wait for progress to be made, and
-	 * set @retry_unclustered to true.
-	 *
-	 * If @retry_unclustered is true then we've already waited on this
-	 * block group once and should move on to the next block group.
-	 */
-	if (!offset && !ffe_ctl->retry_unclustered && !ffe_ctl->cached &&
-	    ffe_ctl->loop > LOOP_CACHING_NOWAIT) {
-		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
-						      ffe_ctl->empty_size);
-		ffe_ctl->retry_unclustered = true;
-		return -EAGAIN;
-	} else if (!offset) {
+	if (!offset)
 		return 1;
-	}
 	ffe_ctl->found_offset = offset;
 	return 0;
 }
@@ -3605,7 +3578,7 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	/* We want to try and use the cluster allocator, so lets look there */
 	if (ffe_ctl->last_ptr && ffe_ctl->use_cluster) {
 		ret = find_free_extent_clustered(block_group, ffe_ctl, bg_ret);
-		if (ret >= 0 || ret == -EAGAIN)
+		if (ret >= 0)
 			return ret;
 		/* ret == -ENOENT case falls through */
 	}
@@ -3821,8 +3794,7 @@ static void release_block_group(struct btrfs_block_group *block_group,
 {
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
-		ffe_ctl->retry_clustered = false;
-		ffe_ctl->retry_unclustered = false;
+		ffe_ctl->retry_uncached = false;
 		break;
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		/* Nothing to do */
@@ -4165,9 +4137,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl->orig_have_caching_bg = false;
 	ffe_ctl->index = btrfs_bg_flags_to_raid_index(ffe_ctl->flags);
 	ffe_ctl->loop = 0;
-	/* For clustered allocation */
-	ffe_ctl->retry_clustered = false;
-	ffe_ctl->retry_unclustered = false;
+	ffe_ctl->retry_uncached = false;
 	ffe_ctl->cached = 0;
 	ffe_ctl->max_extent_size = 0;
 	ffe_ctl->total_free_space = 0;
@@ -4315,16 +4285,13 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 		bg_ret = NULL;
 		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
-		if (ret == 0) {
-			if (bg_ret && bg_ret != block_group) {
-				btrfs_release_block_group(block_group,
-							  ffe_ctl->delalloc);
-				block_group = bg_ret;
-			}
-		} else if (ret == -EAGAIN) {
-			goto have_block_group;
-		} else if (ret > 0) {
+		if (ret > 0)
 			goto loop;
+
+		if (bg_ret && bg_ret != block_group) {
+			btrfs_release_block_group(block_group,
+						  ffe_ctl->delalloc);
+			block_group = bg_ret;
 		}
 
 		/* Checks */
@@ -4365,6 +4332,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 		break;
 loop:
+		if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
+		    !ffe_ctl->retry_uncached) {
+			ffe_ctl->retry_uncached = true;
+			btrfs_wait_block_group_cache_progress(block_group,
+						ffe_ctl->num_bytes +
+						ffe_ctl->empty_cluster +
+						ffe_ctl->empty_size);
+			goto have_block_group;
+		}
 		release_block_group(block_group, ffe_ctl, ffe_ctl->delalloc);
 		cond_resched();
 	}
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index b9e148adcd28..042a2e73732c 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -48,16 +48,11 @@ struct find_free_extent_ctl {
 	int loop;
 
 	/*
-	 * Whether we're refilling a cluster, if true we need to re-search
-	 * current block group but don't try to refill the cluster again.
+	 * Set to true if we're retry'ing the allocation on this block group
+	 * after waiting for caching progress, this is so that we retry only
+	 * once before moving on to another block group.
 	 */
-	bool retry_clustered;
-
-	/*
-	 * Whether we're updating free space cache, if true we need to re-search
-	 * current block group but don't try updating free space cache again.
-	 */
-	bool retry_unclustered;
+	bool retry_uncached;
 
 	/* If current block group is cached */
 	int cached;
-- 
2.41.0

