Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC375D55B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGUUJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGUUJx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 16:09:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D63599
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 13:09:48 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5703d12ab9aso26273657b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689970187; x=1690574987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhVpoN7sY/ieVQzmlCrWdkVqpKbql4aFws8UA8vyakU=;
        b=SZLqE5JLBcdQKLgiimfvym/LSi/FEXUwcLqd0yzYCt74B8TEmNK2E38pMPkAL1iiKy
         YKRyD6FAYGVGWyrjHTZO6xI8cGo8f20DDo0UGBlvc+ncsaTSxAVLGbfSvpB15AZi1TXn
         KDEmd/zsVqTYU9MdCYGBmsu9qefuJ6q2UTar0xgk44OK9LLNttCRqKJ/eRMo2eULMi2H
         bhBR2owkNLJzhIaM4FlqzDiIXUT8j/GEQam4s/3hyVVcKnYFGLnM+7y3aQPGnA5TWNfM
         Z5ScqsbgRbBjiSYcPVYwAalsijT61dwZv3E8lSRupKDdZiCWnbqddLzKmgs1o3OX47a+
         OMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970187; x=1690574987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhVpoN7sY/ieVQzmlCrWdkVqpKbql4aFws8UA8vyakU=;
        b=WYz+aJ6p5YgPMh2WKzNjUnRNkmu560ucO+KuH7+j0x6LVoBs7H6869rZooTAVVHQeH
         9wtDPqZTkuNGIwtZI5+JHi+LvTzuqdpHn4HJ/LdqningC5q9OliKcifI6nAfRPR4eZWV
         8MM0jluCAEBv+cy5jcCUULNkbzevm+NRoNKL15JOKL5iF+f2qLvMCsh+GuxGP5l+fKJV
         42GKoCrBRUT6uYZU+qZ/x1ilOxRUE2uXmqiJeZNRB7QE0ugS8wzMw6+DDI4jcjRe6m/F
         pvI8wf0XS/GMHZj4G5EXLSC8nCGXos6nJPp3QJz9R/gQUQh2SVxTNjIub+hcU647x7R0
         /3Bw==
X-Gm-Message-State: ABy/qLZvUR5t5Om5z8UMEz7ftO8DZQgY771dxdLZAIov24P7fYmm90xp
        Xp4IT5QDZaiyNpZDGos5wLkT+mcaz2lKegIkqfJzig==
X-Google-Smtp-Source: APBJJlFbO3T+dia9WdJketWDbfMzEBozH/1TZ6RWnRT8NhHaoQhXWeWDG503iGBzNkIA5ob3HN3EgA==
X-Received: by 2002:a81:4e8b:0:b0:56d:2490:7cde with SMTP id c133-20020a814e8b000000b0056d24907cdemr996052ywb.50.1689970187340;
        Fri, 21 Jul 2023 13:09:47 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x206-20020a817cd7000000b005732b228a83sm1095044ywc.140.2023.07.21.13.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:09:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: wait for actual caching progress during allocation
Date:   Fri, 21 Jul 2023 16:09:43 -0400
Message-ID: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
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

Recently we've been having mysterious hangs while running generic/475 on
the CI system.  This turned out to be something like this

Task 1
dmsetup suspend --nolockfs
-> __dm_suspend
 -> dm_wait_for_completion
  -> dm_wait_for_bios_completion
   -> Unable to complete because of IO's on a plug in Task 2

Task 2
wb_workfn
-> wb_writeback
 -> blk_start_plug
  -> writeback_sb_inodes
   -> Infinite loop unable to make an allocation

Task 3
cache_block_group
->read_extent_buffer_pages
 ->Waiting for IO to complete that can't be submitted because Task 1
   suspended the DM device

The problem here is that we need Task 2 to be scheduled completely for
the blk plug to flush.  Normally this would happen, we normally wait for
the block group caching to finish (Task 3), and this schedule would
result in the block plug flushing.

However if there's enough free space available from the current caching
to satisfy the allocation we won't actually wait for the caching to
complete.  This check however just checks that we have enough space, not
that we can make the allocation.  In this particular case we were trying
to allocate 9mib, and we had 10mib of free space, but we didn't have
9mib of contiguous space to allocate, and thus the allocation failed and
we looped.

We specifically don't cycle through the FFE loop until we stop finding
cached block groups because we don't want to allocate new block groups
just because we're caching, so we short circuit the normal loop once we
hit LOOP_CACHING_WAIT and we found a caching block group.

This is normally fine, except in this particular case where the caching
thread can't make progress because the dm device has been suspended.

Fix this by not only waiting for free space to >= the amount of space we
want to allocate, but also that we make some progress in caching from
the time we start waiting.  This will keep us from busy looping when the
caching is taking a while but still theoretically has enough space for
us to allocate from, and fixes this particular case by forcing us to
actually sleep and wait for forward progress, which will flush the plug.

With this fix we're no longer hanging with generic/475.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Reworked the fix to just make sure we're waiting for forward progress on each
  run through btrfs_wait_block_group_cache_progress() instead of further
  complicating the free extent finding code.
- Dropped the comments patch and the RAID patch.

 fs/btrfs/block-group.c | 17 +++++++++++++++--
 fs/btrfs/block-group.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 91d38f38c1e7..a127865f49f9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -441,13 +441,23 @@ void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 					   u64 num_bytes)
 {
 	struct btrfs_caching_control *caching_ctl;
+	int progress;
 
 	caching_ctl = btrfs_get_caching_control(cache);
 	if (!caching_ctl)
 		return;
 
+	/*
+	 * We've already failed to allocate from this block group, so even if
+	 * there's enough space in the block group it isn't contiguous enough to
+	 * allow for an allocation, so wait for at least the next wakeup tick,
+	 * or for the thing to be done.
+	 */
+	progress = atomic_read(&caching_ctl->progress);
+
 	wait_event(caching_ctl->wait, btrfs_block_group_done(cache) ||
-		   (cache->free_space_ctl->free_space >= num_bytes));
+		   (progress != atomic_read(&caching_ctl->progress) &&
+		    (cache->free_space_ctl->free_space >= num_bytes)));
 
 	btrfs_put_caching_control(caching_ctl);
 }
@@ -808,8 +818,10 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 
 			if (total_found > CACHING_CTL_WAKE_UP) {
 				total_found = 0;
-				if (wakeup)
+				if (wakeup) {
+					atomic_inc(&caching_ctl->progress);
 					wake_up(&caching_ctl->wait);
+				}
 			}
 		}
 		path->slots[0]++;
@@ -922,6 +934,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	init_waitqueue_head(&caching_ctl->wait);
 	caching_ctl->block_group = cache;
 	refcount_set(&caching_ctl->count, 2);
+	atomic_set(&caching_ctl->progress, 0);
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index cdf674a5dbad..ae1cf4429cca 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -90,6 +90,7 @@ struct btrfs_caching_control {
 	wait_queue_head_t wait;
 	struct btrfs_work work;
 	struct btrfs_block_group *block_group;
+	atomic_t progress;
 	refcount_t count;
 };
 
-- 
2.41.0

