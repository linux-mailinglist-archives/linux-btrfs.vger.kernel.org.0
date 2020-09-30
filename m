Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A618427F2DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgI3UB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE840C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z18so1599482qvp.6
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJlTYq5gqGrZlaxt4poHqoD22ENUJR3hzjoA1FtElis=;
        b=EXumW3v/jEPFJehCDPtSDXm+Iho50aDEXFT5ouKWcsYP2ZysSm/GeVIkoO56iMfnot
         faXgJ43tvZ6Fan0TKWOP/UsvPueK4VMLChz5o5dPIISmbNLvkRKaHIM3VDqk19Fw3KIG
         XS66u5O2e7U+nJonyIflKAuQV9rsrvURXllbz6mBHCJ3ibEayaEBvTO1n5t049a6s1Kr
         npifeLLaoxK5w6XMYafKaR/ldACjeSS+mHnj9SDk3GBNDI1lfOV6tAwSVC79fqShFFkC
         hbPoUVcSK8m0rcCAxWyPE9OR1yVLK+xx0fLEAl84xdja8lhPWoI8h1ryj69R0SiCYO3j
         sB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJlTYq5gqGrZlaxt4poHqoD22ENUJR3hzjoA1FtElis=;
        b=GgU5Llx9oJ3HJ6Dd6k5JWk9HHik+EBhsGqYsY2ut/xKCDSJ5fUPspfROyq6MYZC1gk
         5jjHr207XCI/cowr5sQb2V1K0GteT88HPVeyqN9Xssty6i99sL/zZJ9fHUGDQ+3Ce8L1
         vbDte6ep40vYEH26/00OXWVW8Rttd04fl1vpiiVTEm1I8nBq+Qqas3x5Z/d42SMOGA3C
         5fz4nQWd72uT0rODG8hOeSfmGrP6rBDrN3Y14sfuqPh9Fw4RHl+JPtes+lN3YKicQDx8
         yvJ2CB46lBGY0GtQHorT0xKgBDkecsoG0wAm1SDAfKFAJWGXmSpAnV/ir9IjQ1htGTGa
         Ptrg==
X-Gm-Message-State: AOAM531a4fC+xVugzvux0HQMyVFHCUrD3wT3wNvA0Pq38Rz/kWui6SL5
        ahrhoHxoFVM1Fp3AKVvFiC9etFHFUWmWGIKF
X-Google-Smtp-Source: ABdhPJx97TIPpz6wXPWhbekoi4qOCdbVSieYRAkfcLjm5N020/6qMX3ys7HbPrtQR/AHGv9XIsz5Hw==
X-Received: by 2002:a0c:ca08:: with SMTP id c8mr4161111qvk.42.1601496086212;
        Wed, 30 Sep 2020 13:01:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y7sm3823077qtn.11.2020.09.30.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: improve preemptive background space flushing
Date:   Wed, 30 Sep 2020 16:01:02 -0400
Message-Id: <fc525d2a6a15a701d688b4f9f62f23caa51023bb.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 122 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..483182eaea19 100644
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
index 3d39f5d47ad3..2d0edc849da9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3999,6 +3999,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
+	cancel_work_sync(&fs_info->preempt_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 40726c8888f7..024daa843c56 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -987,6 +987,122 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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
+		 * If we're just full of pinned, commit the transaction.  We
+		 * don't call flush_space(COMMIT_TRANS) here because that has
+		 * logic to decide whether we need to commit the transaction to
+		 * satisfy the ticket to keep us from live locking the box by
+		 * committing over and over again.  Here we don't care about
+		 * that, we know we are using a lot of space and most of it is
+		 * pinned, just commit.
+		 *
+		 * We do not want to include the global rsv size in the
+		 * bytes_may_use size here because it's unreclaimable.
+		 */
+		to_reclaim = (space_info->bytes_may_use < global_rsv_size) ? 0:
+			space_info->bytes_may_use - global_rsv_size;
+		if (space_info->bytes_pinned >= to_reclaim) {
+			struct btrfs_trans_handle *trans;
+
+			spin_unlock(&space_info->lock);
+			trans = btrfs_join_transaction(fs_info->extent_root);
+			if (IS_ERR(trans))
+				return;
+			btrfs_commit_transaction(trans);
+			goto next;
+		}
+
+		/*
+		 * We don't have a precise counter for delalloc, so we'll
+		 * approximate it by subtracting out the block rsv's space from
+		 * the bytes_may_use.  If that amount is higher than the
+		 * individual reserves, then we can assume it's tied up in
+		 * delalloc reservations.
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
+next:
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
@@ -1113,6 +1229,8 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 {
 	INIT_WORK(&fs_info->async_reclaim_work, btrfs_async_reclaim_metadata_space);
 	INIT_WORK(&fs_info->async_data_reclaim_work, btrfs_async_reclaim_data_space);
+	INIT_WORK(&fs_info->preempt_reclaim_work,
+		  btrfs_preempt_reclaim_metadata_space);
 }
 
 static const enum btrfs_flush_state priority_flush_states[] = {
@@ -1392,11 +1510,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

