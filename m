Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FD3A4401
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhFKO0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:26:12 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36635 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKO0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:26:12 -0400
Received: by mail-qk1-f169.google.com with SMTP id i68so27512409qke.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qS+ZOloNp02i3+iBOpf4cZQWP8Gp/Dr8c2ZiUDSYZwg=;
        b=fURUn0Bi/1kYm+Xkq5oR/F9Mxo50hQ26NVq1fXXBni0XlvgxpukoVOsXue1HOH/Uzy
         syQKGPvVEj8Whq3UMPo4TzV/gMr+FdKhoAAxRfvxLeaD2YRmuhj56SMdb5/p0Xl8T1y3
         eeWXO366l6W1udiuSf3J4NzHOEHxJiOZoVQL+jn0l5sTK0vPrm/WaO1fyfCZMoGxOHRr
         csJ/6woIj5RGcYkteH7ZpKaS00CiTwh4tBaBaAevn8fk4epODlUTZGb2R9aCK/gUl19F
         OolPI2gE642Ur7EtVeWg/k1jVDlrRl8bsUanI4W2EOT89BHgP0yFjDe3JAR+i3IHgTre
         Cm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS+ZOloNp02i3+iBOpf4cZQWP8Gp/Dr8c2ZiUDSYZwg=;
        b=AMMEL4l3/JfcUG+T5Q7rqkHTp4UYF6Umj6eUr5yETPKnHg5I2lbnPBD2PGrVDjY75m
         sr6mfWekyxM/dDi0OQ7/w/8T9gzn4//q/MdJpEzJsE4F0r0sf9POI0gqWZ9UREeELiaJ
         lOgo7T241B9ltMbkzGYl3UcFVumDEbwLTPPZLMBzB8vSfAJ/N8xQK9d9e6zFf05phRwR
         gyGPbdMsZSXtceBnagQVWHftSv2WjsVblEdiZplDzgMu/n+LVsCugtD2Cs8dnmHuSz8d
         ipOldAvUylTrETklhTjVNISvljONoTBq3Bbg+gUVOh+dyuy7xRIe3rXj3acaXUv0f5Y6
         hesg==
X-Gm-Message-State: AOAM533ZYJf6EsbT9bjbq35+12aVEj+1sj1Kbsnxs7jutUg39Bc71hfs
        3b50anwMeglxsUZGLP3iCCGfrFcMMty7pQ==
X-Google-Smtp-Source: ABdhPJyrXOan89dbqEn6Aw72GUrsoMB1XHPVfjF1BATdJRFDfIzT6sSuMBKn0dEj/3VXErGuC7WbSg==
X-Received: by 2002:a05:620a:d45:: with SMTP id o5mr4020282qkl.319.1623421393631;
        Fri, 11 Jun 2021 07:23:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k124sm4432835qkc.132.2021.06.11.07.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:23:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: rip out may_commit_transaction
Date:   Fri, 11 Jun 2021 10:23:08 -0400
Message-Id: <65fd69e8e230d0d61e70ebade4d6cfe355d3b436.1623421213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623421213.git.josef@toxicpanda.com>
References: <cover.1623421213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

may_commit_transaction was introduced before the ticketing
infrastructure existed.  There was a problem where we'd legitimately be
out of space, but every reservation would trigger a transaction commit
and then fail.  Thus if you had 1000 things trying to make a
reservation, they'd all do the flushing loop and thus commit the
transaction 1000 times before they'd get their ENOSPC.

This helper was introduced to short circuit this, if there wasn't space
that could be reclaimed by committing the transaction then simply ENOSPC
out.  This made true ENOSPC tests much faster as we didn't waste a bunch
of time.

However many of our bugs over the years have been from cases where we
didn't account for some space that would be reclaimed by committing a
transaction.  The delayed refs rsv space, delayed rsv, many pinned bytes
miscalculations, etc.  And in the meantime the original problem has been
solved with ticketing.  We no longer will commit the transaction 1000
times.  Instead we'll get 1000 waiters, we will go through the flushing
mechanisms, and if there's no progress after 2 loops we ENOSPC everybody
out.  The ticketing infrastructure gives us a deterministic way to see
if we're making progress or not, thus we avoid a lot of extra work.

So simplify this step by simply unconditionally committing the
transaction.  This removes what is arguably our most common source of
early ENOSPC bugs and will allow us to drastically simplify many of the
things we track because we simply won't need them with this stuff gone.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h             |   1 -
 fs/btrfs/space-info.c        | 155 +++--------------------------------
 include/trace/events/btrfs.h |   3 +-
 3 files changed, 14 insertions(+), 145 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 20d7121225d9..95733aa2d9fc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2793,7 +2793,6 @@ enum btrfs_flush_state {
 	ALLOC_CHUNK_FORCE	=	9,
 	RUN_DELAYED_IPUTS	=	10,
 	COMMIT_TRANS		=	11,
-	FORCE_COMMIT_TRANS	=	12,
 };
 
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3c89af4fd729..a4cfc8feadf1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -133,18 +133,13 @@
  *     operations, however they won't be usable until the transaction commits.
  *
  *   COMMIT_TRANS
- *     may_commit_transaction() is the ultimate arbiter on whether we commit the
- *     transaction or not.  In order to avoid constantly churning we do all the
- *     above flushing first and then commit the transaction as the last resort.
- *     However we need to take into account things like pinned space that would
- *     be freed, plus any delayed work we may not have gotten rid of in the case
- *     of metadata.
- *
- *   FORCE_COMMIT_TRANS
- *     For use by the preemptive flusher.  We use this to bypass the ticketing
- *     checks in may_commit_transaction, as we have more information about the
- *     overall state of the system and may want to commit the transaction ahead
- *     of actual ENOSPC conditions.
+ *     This will commit the transaction.  Historically we had a lot of logic
+ *     surrounding whether or not we'd commit the transaction, but this was born
+ *     out of a pre-tickets era where we could end up committing the transaction
+ *     thousands of times in a row without making progress.  Now thanks to our
+ *     ticketing system we know if we're not making progress and can error
+ *     everybody out after a few commits rather than burning the disk hoping for
+ *     a different answer.
  *
  * OVERCOMMIT
  *
@@ -615,109 +610,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	}
 }
 
-/**
- * Possibly commit the transaction if its ok to
- *
- * @fs_info:    the filesystem
- * @space_info: space_info we are checking for commit, either data or metadata
- *
- * This will check to make sure that committing the transaction will actually
- * get us somewhere and then commit the transaction if it does.  Otherwise it
- * will return -ENOSPC.
- */
-static int may_commit_transaction(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info)
-{
-	struct reserve_ticket *ticket = NULL;
-	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
-	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
-	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
-	struct btrfs_trans_handle *trans;
-	u64 reclaim_bytes = 0;
-	u64 bytes_needed = 0;
-	u64 cur_free_bytes = 0;
-
-	trans = (struct btrfs_trans_handle *)current->journal_info;
-	if (trans)
-		return -EAGAIN;
-
-	spin_lock(&space_info->lock);
-	cur_free_bytes = btrfs_space_info_used(space_info, true);
-	if (cur_free_bytes < space_info->total_bytes)
-		cur_free_bytes = space_info->total_bytes - cur_free_bytes;
-	else
-		cur_free_bytes = 0;
-
-	if (!list_empty(&space_info->priority_tickets))
-		ticket = list_first_entry(&space_info->priority_tickets,
-					  struct reserve_ticket, list);
-	else if (!list_empty(&space_info->tickets))
-		ticket = list_first_entry(&space_info->tickets,
-					  struct reserve_ticket, list);
-	if (ticket)
-		bytes_needed = ticket->bytes;
-
-	if (bytes_needed > cur_free_bytes)
-		bytes_needed -= cur_free_bytes;
-	else
-		bytes_needed = 0;
-	spin_unlock(&space_info->lock);
-
-	if (!bytes_needed)
-		return 0;
-
-	trans = btrfs_join_transaction(fs_info->extent_root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	/*
-	 * See if there is enough pinned space to make this reservation, or if
-	 * we have block groups that are going to be freed, allowing us to
-	 * possibly do a chunk allocation the next loop through.
-	 */
-	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
-	    __percpu_counter_compare(&space_info->total_bytes_pinned,
-				     bytes_needed,
-				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
-		goto commit;
-
-	/*
-	 * See if there is some space in the delayed insertion reserve for this
-	 * reservation.  If the space_info's don't match (like for DATA or
-	 * SYSTEM) then just go enospc, reclaiming this space won't recover any
-	 * space to satisfy those reservations.
-	 */
-	if (space_info != delayed_rsv->space_info)
-		goto enospc;
-
-	spin_lock(&delayed_rsv->lock);
-	reclaim_bytes += delayed_rsv->reserved;
-	spin_unlock(&delayed_rsv->lock);
-
-	spin_lock(&delayed_refs_rsv->lock);
-	reclaim_bytes += delayed_refs_rsv->reserved;
-	spin_unlock(&delayed_refs_rsv->lock);
-
-	spin_lock(&trans_rsv->lock);
-	reclaim_bytes += trans_rsv->reserved;
-	spin_unlock(&trans_rsv->lock);
-
-	if (reclaim_bytes >= bytes_needed)
-		goto commit;
-	bytes_needed -= reclaim_bytes;
-
-	if (__percpu_counter_compare(&space_info->total_bytes_pinned,
-				   bytes_needed,
-				   BTRFS_TOTAL_BYTES_PINNED_BATCH) < 0)
-		goto enospc;
-
-commit:
-	return btrfs_commit_transaction(trans);
-enospc:
-	btrfs_end_transaction(trans);
-	return -ENOSPC;
-}
-
 /*
  * Try to flush some data based on policy set by @state. This is only advisory
  * and may fail for various reasons. The caller is supposed to examine the
@@ -795,9 +687,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		btrfs_wait_on_delayed_iputs(fs_info);
 		break;
 	case COMMIT_TRANS:
-		ret = may_commit_transaction(fs_info, space_info);
-		break;
-	case FORCE_COMMIT_TRANS:
+		ASSERT(current->journal_info == NULL);
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -1187,7 +1077,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			   (delayed_block_rsv->reserved +
 			    delayed_refs_rsv->reserved)) {
 			to_reclaim = space_info->bytes_pinned;
-			flush = FORCE_COMMIT_TRANS;
+			flush = COMMIT_TRANS;
 		} else if (delayed_block_rsv->reserved >
 			   delayed_refs_rsv->reserved) {
 			to_reclaim = delayed_block_rsv->reserved;
@@ -1238,31 +1128,12 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
  *   If we are freeing inodes, we want to make sure all delayed iputs have
  *   completed, because they could have been on an inode with i_nlink == 0, and
  *   thus have been truncated and freed up space.  But again this space is not
- *   immediately re-usable, it comes in the form of a delayed ref, which must be
- *   run and then the transaction must be committed.
- *
- * FLUSH_DELAYED_REFS
- *   The above two cases generate delayed refs that will affect
- *   ->total_bytes_pinned.  However this counter can be inconsistent with
- *   reality if there are outstanding delayed refs.  This is because we adjust
- *   the counter based solely on the current set of delayed refs and disregard
- *   any on-disk state which might include more refs.  So for example, if we
- *   have an extent with 2 references, but we only drop 1, we'll see that there
- *   is a negative delayed ref count for the extent and assume that the space
- *   will be freed, and thus increase ->total_bytes_pinned.
- *
- *   Running the delayed refs gives us the actual real view of what will be
- *   freed at the transaction commit time.  This stage will not actually free
- *   space for us, it just makes sure that may_commit_transaction() has all of
- *   the information it needs to make the right decision.
+ *   immediately re-usable, it will be pinned, which will be reclaimed by
+ *   committing the transaction.
  *
  * COMMIT_TRANS
- *   This is where we reclaim all of the pinned space generated by the previous
- *   two stages.  We will not commit the transaction if we don't think we're
- *   likely to satisfy our request, which means if our current free space +
- *   total_bytes_pinned < reservation we will not commit.  This is why the
- *   previous states are actually important, to make sure we know for sure
- *   whether committing the transaction will allow us to make progress.
+ *   This is where we reclaim all of the pinned space generated by running
+ *   delayed iputs.
  *
  * ALLOC_CHUNK_FORCE
  *   For data we start with alloc chunk force, however we could have been full
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8144b8e345b5..a63a3d34b47b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -100,8 +100,7 @@ struct btrfs_space_info;
 	EM( ALLOC_CHUNK,		"ALLOC_CHUNK")			\
 	EM( ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE")		\
 	EM( RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS")		\
-	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
-	EMe(FORCE_COMMIT_TRANS,		"FORCE_COMMIT_TRANS")
+	EMe(COMMIT_TRANS,		"COMMIT_TRANS")
 
 /*
  * First define the enums in the above macros to be exported to userspace via
-- 
2.26.3

