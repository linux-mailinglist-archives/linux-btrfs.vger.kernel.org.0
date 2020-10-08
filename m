Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950C7287D70
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgJHUtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099FCC0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:07 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id q26so6308346qtb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6nmBTwZ3JTjg/IdzntkwKzBYPzJUr8Sdobs3sffeKE0=;
        b=kNMhrXH/EqIh/rG/61IvAMw+Hi6gFYI0U7+IjtjuKMmUJWtLYvxxcwQEsxfkXobzOC
         x023gvxOVmF3TuXTr1uB/qwuOw44qrcCt8kqoeASWD9awi+5rc59gNNnhzhZs0kmeepE
         O6jAHNGDmoqDi9OiHcwZB5l7yrjkFE9HMN154YCVROIUPNxqMtuZeJEanXvGA9jUP45w
         qdnWCE6UML3Jkq1kT9s/Xab2Ur3SSKnnSLWyFlQ5+hf4Zx+FyxwnBofyCfHdRVB0+RbR
         7cPNQWtshNSvB2ok2z7p5iCCMlYWEoPNaAV0NfxO2FQyWU+i8vC1XxVhyEQXlnZPyaOZ
         gcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nmBTwZ3JTjg/IdzntkwKzBYPzJUr8Sdobs3sffeKE0=;
        b=g8FYSiOX7XDwIkptTaiaF05PzpCwaLypRRvmIb/9w6hME+3JXVWnq2J4j9igfq794S
         uT1mdu+R0l+Dq751HUZL32BiuWMnNUxInFyMjxfH9cOaUIhtTTp24hxyXDkpSoZa0/mv
         CvgCXvrN+aQ1npA6XoDFpt7Fz0W9TnDmYIegel0HSyCawHWIuVxaxRQAwfT7WdW5akj3
         nYETuovHu75RV9FFEbJCxXZUtY5J+fKA7ERMOPo2UZbP9Z0xebR7eGNILUxuBVv8nXXu
         /1XuT2DURlX9igkzFbKgfNi3kAZCpp+lTu9hVEFMsSOz6JVRpmyTr1oF9UcKmcnytgpD
         WhCQ==
X-Gm-Message-State: AOAM531NtEZ3SF581Sz8zzFmVf6d2ufviTk8oKVPYTNmZzkkyRkEbkfw
        8HDP6FL2sM9b37fNBWEs4SxmWb7RozkmPLZD
X-Google-Smtp-Source: ABdhPJwNpTzeEPLsz6GNWlZnA3hkk0fLBLEq7gJrX+OSzltQ0Nl1WG3arYEp0EbEF/y0hfyQoKR2Pw==
X-Received: by 2002:ac8:7555:: with SMTP id b21mr10497158qtr.119.1602190145167;
        Thu, 08 Oct 2020 13:49:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j25sm4721112qtr.83.2020.10.08.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/11] btrfs: improve preemptive background space flushing
Date:   Thu,  8 Oct 2020 16:48:48 -0400
Message-Id: <dac3b8346fb45a74676568c274c50ed2b5c17f1c.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we ever have to flush space because we do not have enough
we allocate a ticket and attach it to the space_info, and then
systematically flush things in the file system that hold space
reservations until our space is reclaimed.

However this has a latency cost, we must go to sleep and wait for the
flushing to make progress before we are woken up and allowed to continue
doing our work.

In order to address that we used to kick off the async worker to flush
space preemptively, so that we could be reclaiming space hopefully
before any tasks needed to stop and wait for space to reclaim.

When I introduced the ticketed ENOSPC stuff this broke slightly in the
fact that we were using tickets to indicate if we were done flushing.
No tickets, no more flushing.  However this meant that we essentially
never preemptively flushed.  This caused a write performance regression
that Nikolay noticed in an unrelated patch that removed the committing
of the transaction during btrfs_end_transaction.

The behavior that happened pre that patch was btrfs_end_transaction()
would see that we were low on space, and it would commit the
transaction.  This was bad because in this particular case you could end
up with thousands and thousands of transactions being committed during
the 5 minute reproducer.  With the patch to remove this behavior you got
much more sane transaction commits, but we ended up slower because we
would write for a while, flush, write for a while, flush again.

To address this we need to reinstate a preemptive flushing mechanism.
However it is distinctly different from our ticketing flushing in that
it doesn't have tickets to base it's decisions on.  Instead of bolting
this logic into our existing flushing work, add another worker to handle
this preemptive flushing.  Here we will attempt to be slightly
intelligent about the things that we flushing, attempting to balance
between whichever pool is taking up the most space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |   1 +
 fs/btrfs/disk-io.c    |   1 +
 fs/btrfs/space-info.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 84c5db91dc44..d72469ea7c87 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -922,6 +922,7 @@ struct btrfs_fs_info {
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
 	struct work_struct async_data_reclaim_work;
+	struct work_struct preempt_reclaim_work;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 61bb3321efaa..0b2b3a4a2b47 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4003,6 +4003,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
+	cancel_work_sync(&fs_info->preempt_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a215470c1887..be054c5b39f6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -996,6 +996,101 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
+/*
+ * This handles pre-flushing of metadata space before we get to the point that
+ * we need to start blocking people on tickets.  The logic here is different
+ * from the other flush paths because it doesn't rely on tickets to tell us how
+ * much we need to flush, instead it attempts to keep us below the 80% full
+ * watermark of space by flushing whichever reservation pool is currently the
+ * largest.
+ */
+static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+	struct btrfs_block_rsv *delayed_block_rsv;
+	struct btrfs_block_rsv *delayed_refs_rsv;
+	struct btrfs_block_rsv *global_rsv;
+	struct btrfs_block_rsv *trans_rsv;
+	u64 used;
+
+	fs_info = container_of(work, struct btrfs_fs_info,
+			       preempt_reclaim_work);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	delayed_block_rsv = &fs_info->delayed_block_rsv;
+	delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	global_rsv = &fs_info->global_block_rsv;
+	trans_rsv = &fs_info->trans_block_rsv;
+
+	spin_lock(&space_info->lock);
+	used = btrfs_space_info_used(space_info, true);
+	while (need_do_async_reclaim(fs_info, space_info, used)) {
+		enum btrfs_reserve_flush_enum flush;
+		u64 delalloc_size = 0;
+		u64 to_reclaim, block_rsv_size;
+		u64 global_rsv_size = global_rsv->reserved;
+
+		/*
+		 * We don't have a precise counter for the metadata being
+		 * reserved for delalloc, so we'll approximate it by subtracting
+		 * out the block rsv's space from the bytes_may_use.  If that
+		 * amount is higher than the individual reserves, then we can
+		 * assume it's tied up in delalloc reservations.
+		 */
+		block_rsv_size = global_rsv_size +
+			delayed_block_rsv->reserved +
+			delayed_refs_rsv->reserved +
+			trans_rsv->reserved;
+		if (block_rsv_size < space_info->bytes_may_use)
+			delalloc_size = space_info->bytes_may_use -
+				block_rsv_size;
+		spin_unlock(&space_info->lock);
+
+		/*
+		 * We don't want to include the global_rsv in our calculation,
+		 * because that's space we can't touch.  Subtract it from the
+		 * block_rsv_size for the next checks.
+		 */
+		block_rsv_size -= global_rsv_size;
+
+		/*
+		 * We really want to avoid flushing delalloc too much, as it
+		 * could result in poor allocation patterns, so only flush it if
+		 * it's larger than the rest of the pools combined.
+		 */
+		if (delalloc_size > block_rsv_size) {
+			to_reclaim = delalloc_size;
+			flush = FLUSH_DELALLOC;
+		} else if (space_info->bytes_pinned >
+			   (delayed_block_rsv->reserved +
+			    delayed_refs_rsv->reserved)) {
+			to_reclaim = space_info->bytes_pinned;
+			flush = FORCE_COMMIT_TRANS;
+		} else if (delayed_block_rsv->reserved >
+			   delayed_refs_rsv->reserved) {
+			to_reclaim = delayed_block_rsv->reserved;
+			flush = FLUSH_DELAYED_ITEMS_NR;
+		} else {
+			to_reclaim = delayed_refs_rsv->reserved;
+			flush = FLUSH_DELAYED_REFS_NR;
+		}
+
+		/*
+		 * We don't want to reclaim everything, just a portion, so scale
+		 * down the to_reclaim by 1/4.  If it takes us down to 0,
+		 * reclaim 1 items worth.
+		 */
+		to_reclaim >>= 2;
+		if (!to_reclaim)
+			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
+		flush_space(fs_info, space_info, to_reclaim, flush);
+		cond_resched();
+		spin_lock(&space_info->lock);
+		used = btrfs_space_info_used(space_info, true);
+	}
+	spin_unlock(&space_info->lock);
+}
+
 /*
  * FLUSH_DELALLOC_WAIT:
  *   Space is freed from flushing delalloc in one of two ways.
@@ -1122,6 +1217,8 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 {
 	INIT_WORK(&fs_info->async_reclaim_work, btrfs_async_reclaim_metadata_space);
 	INIT_WORK(&fs_info->async_data_reclaim_work, btrfs_async_reclaim_data_space);
+	INIT_WORK(&fs_info->preempt_reclaim_work,
+		  btrfs_preempt_reclaim_metadata_space);
 }
 
 static const enum btrfs_flush_state priority_flush_states[] = {
@@ -1405,11 +1502,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
 		    need_do_async_reclaim(fs_info, space_info, used) &&
-		    !work_busy(&fs_info->async_reclaim_work)) {
+		    !work_busy(&fs_info->preempt_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
 			queue_work(system_unbound_wq,
-				   &fs_info->async_reclaim_work);
+				   &fs_info->preempt_reclaim_work);
 		}
 	}
 	spin_unlock(&space_info->lock);
-- 
2.26.2

