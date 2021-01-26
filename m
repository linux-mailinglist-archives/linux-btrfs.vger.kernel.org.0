Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0000304D46
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbhAZXIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbhAZVZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:28 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF780C061788
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id n3so58746qvf.11
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5J8YnBBEMMcy0FkwWf34zV8t6N78p6V4m9gc/uV8nM=;
        b=BZ3Pbyg4mRJCs/EjyHyAbqyuFr9GQH7RZikWM9wSKWNi03ZfR4gKEGt7U5v+MLj01P
         JsaNi4Xm6s6QE5ftgp7NLKKxjLktbX2lKeVVBLVL9+1i47kHEGXYoHjinIub8VamRgUI
         cDfWknPq+j5LSfbtc/p/ww6CfDuYuxe2f+KbJWBOO8+tvtLVgqwBcbUljlYG4uJkLmY/
         dse8C9TCANtC1c7Nwuo/tXi7MJOosBcRNo1uuJB1eMA9Re07QY1jsFMjkZmQDtQsYMLa
         CBxNe64JouK7QPRMvvEkpmisa7CFCLPWBOVh4H3rDxo1GylcQdABcBXtAb8ONNkonwD2
         bL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5J8YnBBEMMcy0FkwWf34zV8t6N78p6V4m9gc/uV8nM=;
        b=imwpCBCa+0K3JwAg8+QJtFzBGndYtGDDltjStGoj7zjwt18PEhUfyzSsw6xM+COXsK
         U3u555Fp3LH2KB2ffqFJK3TUvI2s5Pjf+K0uI0n6YnTZ1Nv5XKyfE2qulrxk8LcbyCaj
         ycrpvERdwlo+zT1QqvQ5il+RFJwez1aHg5SGD7laJZro0SV54cfBLxx6dDeeVbso/Pcx
         bNgNRvNIh/WG4ZVPb6IGWxRg4j3pVnXRP1RthgZ03ODIS559soIeF0wCc8OLemZR57EK
         guZe5kLbKlvZB0uecTUKAl+5Mlq5br23F4kSZPNHUUyHgBJ75628KacOpCBYUIjh3FGN
         O7OQ==
X-Gm-Message-State: AOAM533Vjhdqbw+Ae+phRY83NZVneE5qTNCy/J4QzLi8Xp9RrOvEjEeE
        be+hs4/7aVUVGeau463hjn5QD5tqVBp5KsXY
X-Google-Smtp-Source: ABdhPJzG6J9k/VIfj1P3AtIEceJcGzqwa008loG7WAq14GkZD50DKlmK5nTEsyLAztu5x2sd+A0JMA==
X-Received: by 2002:a05:6214:a54:: with SMTP id ee20mr7566642qvb.16.1611696286555;
        Tue, 26 Jan 2021 13:24:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 77sm3133452qkk.29.2021.01.26.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 05/12] btrfs: improve preemptive background space flushing
Date:   Tue, 26 Jan 2021 16:24:29 -0500
Message-Id: <1343341b9dfadec9237dceb38fcbcf1cb32eccff.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |   1 +
 fs/btrfs/disk-io.c    |   1 +
 fs/btrfs/space-info.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 90726954b883..a9b0521d9e89 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -933,6 +933,7 @@ struct btrfs_fs_info {
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
 	struct work_struct async_data_reclaim_work;
+	struct work_struct preempt_reclaim_work;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0d56b3d1223..e0d1b328397e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4111,6 +4111,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
+	cancel_work_sync(&fs_info->preempt_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 94c9534505c5..f05c97a2ae7c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -994,6 +994,101 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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
+		enum btrfs_flush_state flush;
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
@@ -1126,6 +1221,8 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 {
 	INIT_WORK(&fs_info->async_reclaim_work, btrfs_async_reclaim_metadata_space);
 	INIT_WORK(&fs_info->async_data_reclaim_work, btrfs_async_reclaim_data_space);
+	INIT_WORK(&fs_info->preempt_reclaim_work,
+		  btrfs_preempt_reclaim_metadata_space);
 }
 
 static const enum btrfs_flush_state priority_flush_states[] = {
@@ -1413,11 +1510,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

