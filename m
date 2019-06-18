Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583DC4AB78
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfFRUJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44893 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id p144so9402987qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=vc0txc4wVnC67Q4okWqR1UJ6/LJF5Yl+Ck4jPV8/+Dw=;
        b=QzjFhcYbdhGgtelc3gncFc9Ih8XPZFdZR0L7FSvAxXL4No1DsYUBnA5rDWh2IapWnj
         Ck4nKC3urhIsbvTmzKrioEYyKZCDZzBGVno1zrrAOutKs8whvPT0dM70249IJR3Z+nqT
         ZxLEzau2nF/7/GSpn5YiV19LOanYNYl5dWbjdoQ8XtYMBpyV5BsOH+1a0eY2XcAmCDOW
         S2JVqnYeIKVJoh6/j7NpzzlxA6iEYrgkpR9gHOk4j31jLV9+wdZQ004zxmxl4pLtrgLy
         zolullp0UleEJUumyMviME3Dv1zu6KhO4Wa3MKE+G+RejHm6+b/KMCHZZMDNhadBorf9
         xqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=vc0txc4wVnC67Q4okWqR1UJ6/LJF5Yl+Ck4jPV8/+Dw=;
        b=Xkt+SH09WoR38cfFJwxz1kfVQrj80mC+W98RAPl+BDMX1GyI0YuM2jAZ+Jjv33ztyv
         cQZG3PcV61z9v3bgjCGg3skv+Q1ug3dlVCZwPriyqos4R2YLoZ8mk5K9DAFhbf+J2a5n
         cannV/aldmvFLIWcZ08Z6DZhNJqNx2T35KHqxL2PRXGxI8epzloHOF16PncpcOdZQdiw
         tFmKZyxo9jJk0rRts31FBXRPEw/hRgap86oeq3ygIyk7wjf0oMBChEcclwkQgJd6uCFs
         gkSkuzt0KuVDwySsf6xwCE+EcaI1kOJI5wpANv4vsQRfU2Yqt3/iHRUWBYOww2lRcG3G
         uAkQ==
X-Gm-Message-State: APjAAAWHuMja2qFW7YP2nTVS5Sx1lpd2Fo/DmowR7GbH8Te1Zam+KJ70
        YuDsHSymbhbyMPl8Db196n/E8KWPCNzaZg==
X-Google-Smtp-Source: APXvYqwwsZOWcCbhzltjcB7x5yWtiPb9yb18e6E06SOSYqoRVlpVPHVkWBrj/v6p7Fsbe09wNkk+uA==
X-Received: by 2002:ae9:f209:: with SMTP id m9mr8714328qkg.251.1560888587507;
        Tue, 18 Jun 2019 13:09:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j66sm8908968qkf.86.2019.06.18.13.09.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: move reserve_metadata_bytes and supporting code to space-info.c
Date:   Tue, 18 Jun 2019 16:09:25 -0400
Message-Id: <20190618200926.3352-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This moves all of the metadata reservation code into space-info.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 710 +------------------------------------------------
 fs/btrfs/space-info.c  | 698 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |   4 +
 3 files changed, 710 insertions(+), 702 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4e1e664d36b3..3fc140dfcc58 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4348,701 +4348,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, int nr_items)
-{
-	struct super_block *sb = fs_info->sb;
-
-	if (down_read_trylock(&sb->s_umount)) {
-		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
-		up_read(&sb->s_umount);
-	} else {
-		/*
-		 * We needn't worry the filesystem going from r/w to r/o though
-		 * we don't acquire ->s_umount mutex, because the filesystem
-		 * should guarantee the delalloc inodes list be empty after
-		 * the filesystem is readonly(all dirty pages are written to
-		 * the disk).
-		 */
-		btrfs_start_delalloc_roots(fs_info, nr_items);
-		if (!current->journal_info)
-			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
-	}
-}
-
-static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
-					u64 to_reclaim)
-{
-	u64 bytes;
-	u64 nr;
-
-	bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
-	nr = div64_u64(to_reclaim, bytes);
-	if (!nr)
-		nr = 1;
-	return nr;
-}
-
-#define EXTENT_SIZE_PER_ITEM	SZ_256K
-
-/*
- * shrink metadata reservation for delalloc
- */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
-{
-	struct btrfs_space_info *space_info;
-	struct btrfs_trans_handle *trans;
-	u64 delalloc_bytes;
-	u64 dio_bytes;
-	u64 async_pages;
-	u64 items;
-	long time_left;
-	unsigned long nr_pages;
-	int loops;
-
-	/* Calc the number of the pages we need flush for space reservation */
-	items = calc_reclaim_items_nr(fs_info, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
-
-	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-
-	delalloc_bytes = percpu_counter_sum_positive(
-						&fs_info->delalloc_bytes);
-	dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-	if (delalloc_bytes == 0 && dio_bytes == 0) {
-		if (trans)
-			return;
-		if (wait_ordered)
-			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
-		return;
-	}
-
-	/*
-	 * If we are doing more ordered than delalloc we need to just wait on
-	 * ordered extents, otherwise we'll waste time trying to flush delalloc
-	 * that likely won't give us the space back we need.
-	 */
-	if (dio_bytes > delalloc_bytes)
-		wait_ordered = true;
-
-	loops = 0;
-	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
-
-		/*
-		 * Triggers inode writeback for up to nr_pages. This will invoke
-		 * ->writepages callback and trigger delalloc filling
-		 *  (btrfs_run_delalloc_range()).
-		 */
-		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
-
-		/*
-		 * We need to wait for the compressed pages to start before
-		 * we continue.
-		 */
-		async_pages = atomic_read(&fs_info->async_delalloc_pages);
-		if (!async_pages)
-			goto skip_async;
-
-		/*
-		 * Calculate how many compressed pages we want to be written
-		 * before we continue. I.e if there are more async pages than we
-		 * require wait_event will wait until nr_pages are written.
-		 */
-		if (async_pages <= nr_pages)
-			async_pages = 0;
-		else
-			async_pages -= nr_pages;
-
-		wait_event(fs_info->async_submit_wait,
-			   atomic_read(&fs_info->async_delalloc_pages) <=
-			   (int)async_pages);
-skip_async:
-		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets) &&
-		    list_empty(&space_info->priority_tickets)) {
-			spin_unlock(&space_info->lock);
-			break;
-		}
-		spin_unlock(&space_info->lock);
-
-		loops++;
-		if (wait_ordered && !trans) {
-			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
-		} else {
-			time_left = schedule_timeout_killable(1);
-			if (time_left)
-				break;
-		}
-		delalloc_bytes = percpu_counter_sum_positive(
-						&fs_info->delalloc_bytes);
-		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-	}
-}
-
-/**
- * maybe_commit_transaction - possibly commit the transaction if its ok to
- * @root - the root we're allocating for
- * @bytes - the number of bytes we want to reserve
- * @force - force the commit
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
-	struct btrfs_trans_handle *trans;
-	u64 bytes_needed;
-	u64 reclaim_bytes = 0;
-
-	trans = (struct btrfs_trans_handle *)current->journal_info;
-	if (trans)
-		return -EAGAIN;
-
-	spin_lock(&space_info->lock);
-	if (!list_empty(&space_info->priority_tickets))
-		ticket = list_first_entry(&space_info->priority_tickets,
-					  struct reserve_ticket, list);
-	else if (!list_empty(&space_info->tickets))
-		ticket = list_first_entry(&space_info->tickets,
-					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : 0;
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
-	 * See if there is some space in the delayed insertion reservation for
-	 * this reservation.
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
-/*
- * Try to flush some data based on policy set by @state. This is only advisory
- * and may fail for various reasons. The caller is supposed to examine the
- * state of @space_info to detect the outcome.
- */
-static void flush_space(struct btrfs_fs_info *fs_info,
-		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       int state)
-{
-	struct btrfs_root *root = fs_info->extent_root;
-	struct btrfs_trans_handle *trans;
-	int nr;
-	int ret = 0;
-
-	switch (state) {
-	case FLUSH_DELAYED_ITEMS_NR:
-	case FLUSH_DELAYED_ITEMS:
-		if (state == FLUSH_DELAYED_ITEMS_NR)
-			nr = calc_reclaim_items_nr(fs_info, num_bytes) * 2;
-		else
-			nr = -1;
-
-		trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			break;
-		}
-		ret = btrfs_run_delayed_items_nr(trans, nr);
-		btrfs_end_transaction(trans);
-		break;
-	case FLUSH_DELALLOC:
-	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
-				state == FLUSH_DELALLOC_WAIT);
-		break;
-	case FLUSH_DELAYED_REFS_NR:
-	case FLUSH_DELAYED_REFS:
-		trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			break;
-		}
-		if (state == FLUSH_DELAYED_REFS_NR)
-			nr = calc_reclaim_items_nr(fs_info, num_bytes);
-		else
-			nr = 0;
-		btrfs_run_delayed_refs(trans, nr);
-		btrfs_end_transaction(trans);
-		break;
-	case ALLOC_CHUNK:
-	case ALLOC_CHUNK_FORCE:
-		trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			break;
-		}
-		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
-				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
-					CHUNK_ALLOC_FORCE);
-		btrfs_end_transaction(trans);
-		if (ret > 0 || ret == -ENOSPC)
-			ret = 0;
-		break;
-	case COMMIT_TRANS:
-		/*
-		 * If we have pending delayed iputs then we could free up a
-		 * bunch of pinned space, so make sure we run the iputs before
-		 * we do our pinned bytes check below.
-		 */
-		btrfs_run_delayed_iputs(fs_info);
-		btrfs_wait_on_delayed_iputs(fs_info);
-
-		ret = may_commit_transaction(fs_info, space_info);
-		break;
-	default:
-		ret = -ENOSPC;
-		break;
-	}
-
-	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
-				ret);
-	return;
-}
-
-static inline u64
-btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
-				 bool system_chunk)
-{
-	struct reserve_ticket *ticket;
-	u64 used;
-	u64 expected;
-	u64 to_reclaim = 0;
-
-	list_for_each_entry(ticket, &space_info->tickets, list)
-		to_reclaim += ticket->bytes;
-	list_for_each_entry(ticket, &space_info->priority_tickets, list)
-		to_reclaim += ticket->bytes;
-	if (to_reclaim)
-		return to_reclaim;
-
-	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
-		return 0;
-
-	used = btrfs_space_info_used(space_info, true);
-
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
-		expected = div_factor_fine(space_info->total_bytes, 95);
-	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
-
-	if (used > expected)
-		to_reclaim = used - expected;
-	else
-		to_reclaim = 0;
-	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
-				     space_info->bytes_reserved);
-	return to_reclaim;
-}
-
-static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
-					u64 used, bool system_chunk)
-{
-	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
-
-	/* If we're just plain full then async reclaim just slows us down. */
-	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
-		return 0;
-
-	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-					      system_chunk))
-		return 0;
-
-	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
-		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
-}
-
-static bool wake_all_tickets(struct list_head *head)
-{
-	struct reserve_ticket *ticket;
-
-	while (!list_empty(head)) {
-		ticket = list_first_entry(head, struct reserve_ticket, list);
-		list_del_init(&ticket->list);
-		ticket->error = -ENOSPC;
-		wake_up(&ticket->wait);
-		if (ticket->bytes != ticket->orig_bytes)
-			return true;
-	}
-	return false;
-}
-
-/*
- * This is for normal flushers, we can wait all goddamned day if we want to.  We
- * will loop and continuously try to flush as long as we are making progress.
- * We count progress as clearing off tickets each time we have to loop.
- */
-static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
-{
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_space_info *space_info;
-	u64 to_reclaim;
-	int flush_state;
-	int commit_cycles = 0;
-	u64 last_tickets_id;
-
-	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-
-	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
-	if (!to_reclaim) {
-		space_info->flush = 0;
-		spin_unlock(&space_info->lock);
-		return;
-	}
-	last_tickets_id = space_info->tickets_id;
-	spin_unlock(&space_info->lock);
-
-	flush_state = FLUSH_DELAYED_ITEMS_NR;
-	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state);
-		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
-			spin_unlock(&space_info->lock);
-			return;
-		}
-		to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info,
-							      space_info,
-							      false);
-		if (last_tickets_id == space_info->tickets_id) {
-			flush_state++;
-		} else {
-			last_tickets_id = space_info->tickets_id;
-			flush_state = FLUSH_DELAYED_ITEMS_NR;
-			if (commit_cycles)
-				commit_cycles--;
-		}
-
-		/*
-		 * We don't want to force a chunk allocation until we've tried
-		 * pretty hard to reclaim space.  Think of the case where we
-		 * freed up a bunch of space and so have a lot of pinned space
-		 * to reclaim.  We would rather use that than possibly create a
-		 * underutilized metadata chunk.  So if this is our first run
-		 * through the flushing state machine skip ALLOC_CHUNK_FORCE and
-		 * commit the transaction.  If nothing has changed the next go
-		 * around then we can force a chunk allocation.
-		 */
-		if (flush_state == ALLOC_CHUNK_FORCE && !commit_cycles)
-			flush_state++;
-
-		if (flush_state > COMMIT_TRANS) {
-			commit_cycles++;
-			if (commit_cycles > 2) {
-				if (wake_all_tickets(&space_info->tickets)) {
-					flush_state = FLUSH_DELAYED_ITEMS_NR;
-					commit_cycles--;
-				} else {
-					space_info->flush = 0;
-				}
-			} else {
-				flush_state = FLUSH_DELAYED_ITEMS_NR;
-			}
-		}
-		spin_unlock(&space_info->lock);
-	} while (flush_state <= COMMIT_TRANS);
-}
-
-void btrfs_init_async_reclaim_work(struct work_struct *work)
-{
-	INIT_WORK(work, btrfs_async_reclaim_metadata_space);
-}
-
-static const enum btrfs_flush_state priority_flush_states[] = {
-	FLUSH_DELAYED_ITEMS_NR,
-	FLUSH_DELAYED_ITEMS,
-	ALLOC_CHUNK,
-};
-
-static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-					    struct btrfs_space_info *space_info,
-					    struct reserve_ticket *ticket)
-{
-	u64 to_reclaim;
-	int flush_state;
-
-	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
-	if (!to_reclaim) {
-		spin_unlock(&space_info->lock);
-		return;
-	}
-	spin_unlock(&space_info->lock);
-
-	flush_state = 0;
-	do {
-		flush_space(fs_info, space_info, to_reclaim,
-			    priority_flush_states[flush_state]);
-		flush_state++;
-		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
-			return;
-		}
-		spin_unlock(&space_info->lock);
-	} while (flush_state < ARRAY_SIZE(priority_flush_states));
-}
-
-static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-			       struct btrfs_space_info *space_info,
-			       struct reserve_ticket *ticket)
-
-{
-	DEFINE_WAIT(wait);
-	u64 reclaim_bytes = 0;
-	int ret = 0;
-
-	spin_lock(&space_info->lock);
-	while (ticket->bytes > 0 && ticket->error == 0) {
-		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
-		if (ret) {
-			ret = -EINTR;
-			break;
-		}
-		spin_unlock(&space_info->lock);
-
-		schedule();
-
-		finish_wait(&ticket->wait, &wait);
-		spin_lock(&space_info->lock);
-	}
-	if (!ret)
-		ret = ticket->error;
-	if (!list_empty(&ticket->list))
-		list_del_init(&ticket->list);
-	if (ticket->bytes && ticket->bytes < ticket->orig_bytes)
-		reclaim_bytes = ticket->orig_bytes - ticket->bytes;
-	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
-	return ret;
-}
-
-/**
- * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @space_info - the space info we want to allocate from
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
- *
- * This will reserve orig_bytes number of bytes from the space info associated
- * with the block_rsv.  If there is not enough space it will make an attempt to
- * flush out space to make room.  It will do this by flushing delalloc if
- * possible or committing the transaction.  If flush is 0 then no attempts to
- * regain reservations will be made and this will fail if there is not enough
- * space already.
- */
-static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 orig_bytes,
-				    enum btrfs_reserve_flush_enum flush,
-				    bool system_chunk)
-{
-	struct reserve_ticket ticket;
-	u64 used;
-	u64 reclaim_bytes = 0;
-	int ret = 0;
-
-	ASSERT(orig_bytes);
-	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
-
-	spin_lock(&space_info->lock);
-	ret = -ENOSPC;
-	used = btrfs_space_info_used(space_info, true);
-
-	/*
-	 * If we have enough space then hooray, make our reservation and carry
-	 * on.  If not see if we can overcommit, and if we can, hooray carry on.
-	 * If not things get more complicated.
-	 */
-	if (used + orig_bytes <= space_info->total_bytes) {
-		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
-						      orig_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-					      space_info->flags, orig_bytes, 1);
-		ret = 0;
-	} else if (btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush,
-					system_chunk)) {
-		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
-						      orig_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-					      space_info->flags, orig_bytes, 1);
-		ret = 0;
-	}
-
-	/*
-	 * If we couldn't make a reservation then setup our reservation ticket
-	 * and kick the async worker if it's not already running.
-	 *
-	 * If we are a priority flusher then we just need to add our ticket to
-	 * the list and we will do our own flushing further down.
-	 */
-	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
-		ticket.orig_bytes = orig_bytes;
-		ticket.bytes = orig_bytes;
-		ticket.error = 0;
-		init_waitqueue_head(&ticket.wait);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
-			list_add_tail(&ticket.list, &space_info->tickets);
-			if (!space_info->flush) {
-				space_info->flush = 1;
-				trace_btrfs_trigger_flush(fs_info,
-							  space_info->flags,
-							  orig_bytes, flush,
-							  "enospc");
-				queue_work(system_unbound_wq,
-					   &fs_info->async_reclaim_work);
-			}
-		} else {
-			list_add_tail(&ticket.list,
-				      &space_info->priority_tickets);
-		}
-	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
-		used += orig_bytes;
-		/*
-		 * We will do the space reservation dance during log replay,
-		 * which means we won't have fs_info->fs_root set, so don't do
-		 * the async reclaim as we will panic.
-		 */
-		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_do_async_reclaim(fs_info, space_info,
-					  used, system_chunk) &&
-		    !work_busy(&fs_info->async_reclaim_work)) {
-			trace_btrfs_trigger_flush(fs_info, space_info->flags,
-						  orig_bytes, flush, "preempt");
-			queue_work(system_unbound_wq,
-				   &fs_info->async_reclaim_work);
-		}
-	}
-	spin_unlock(&space_info->lock);
-	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
-		return ret;
-
-	if (flush == BTRFS_RESERVE_FLUSH_ALL)
-		return wait_reserve_ticket(fs_info, space_info, &ticket);
-
-	ret = 0;
-	priority_reclaim_metadata_space(fs_info, space_info, &ticket);
-	spin_lock(&space_info->lock);
-	if (ticket.bytes) {
-		if (ticket.bytes < orig_bytes)
-			reclaim_bytes = orig_bytes - ticket.bytes;
-		list_del_init(&ticket.list);
-		ret = -ENOSPC;
-	}
-	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
-	ASSERT(list_empty(&ticket.list));
-	return ret;
-}
-
-/**
- * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
- * @root - the root we're allocating for
- * @block_rsv - the block_rsv we're allocating for
- * @orig_bytes - the number of bytes we want
- * @flush - whether or not we can flush to make our reservation
- *
- * This will reserve orig_bytes number of bytes from the space info associated
- * with the block_rsv.  If there is not enough space it will make an attempt to
- * flush out space to make room.  It will do this by flushing delalloc if
- * possible or committing the transaction.  If flush is 0 then no attempts to
- * regain reservations will be made and this will fail if there is not enough
- * space already.
- */
-static int reserve_metadata_bytes(struct btrfs_root *root,
-				  struct btrfs_block_rsv *block_rsv,
-				  u64 orig_bytes,
-				  enum btrfs_reserve_flush_enum flush)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	int ret;
-	bool system_chunk = (root == fs_info->chunk_root);
-
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush, system_chunk);
-	if (ret == -ENOSPC &&
-	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
-		if (block_rsv != global_rsv &&
-		    !btrfs_block_rsv_use_bytes(global_rsv, orig_bytes))
-			ret = 0;
-	}
-	if (ret == -ENOSPC) {
-		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
-					      block_rsv->space_info->flags,
-					      orig_bytes, 1);
-
-		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, block_rsv->space_info,
-					      orig_bytes, 0);
-	}
-	return ret;
-}
-
 static struct btrfs_block_rsv *get_block_rsv(
 					const struct btrfs_trans_handle *trans,
 					const struct btrfs_root *root)
@@ -5191,8 +4496,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!num_bytes)
 		return 0;
 
-	ret = reserve_metadata_bytes(fs_info->extent_root, block_rsv,
-				     num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info->extent_root, block_rsv,
+					   num_bytes, flush);
 	if (ret)
 		return ret;
 	block_rsv_add_bytes(block_rsv, num_bytes, 0);
@@ -5318,7 +4623,7 @@ int btrfs_block_rsv_add(struct btrfs_root *root,
 	if (num_bytes == 0)
 		return 0;
 
-	ret = reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
 	if (!ret)
 		block_rsv_add_bytes(block_rsv, num_bytes, true);
 
@@ -5363,7 +4668,7 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 	if (!ret)
 		return 0;
 
-	ret = reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
 	if (!ret) {
 		block_rsv_add_bytes(block_rsv, num_bytes, false);
 		return 0;
@@ -5737,7 +5042,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		goto out_fail;
-	ret = reserve_metadata_bytes(root, block_rsv, meta_reserve, flush);
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, meta_reserve,
+					   flush);
 	if (ret)
 		goto out_qgroup;
 
@@ -8111,8 +7417,8 @@ use_block_rsv(struct btrfs_trans_handle *trans,
 				"BTRFS: block rsv returned %d\n", ret);
 	}
 try_reserve:
-	ret = reserve_metadata_bytes(root, block_rsv, blocksize,
-				     BTRFS_RESERVE_NO_FLUSH);
+	ret = btrfs_reserve_metadata_bytes(root, block_rsv, blocksize,
+					   BTRFS_RESERVE_NO_FLUSH);
 	if (!ret)
 		return block_rsv;
 	/*
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4fe5f229ce68..3d6b197e6c0f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -8,6 +8,9 @@
 #include "sysfs.h"
 #include "volumes.h"
 #include "free-space-cache.h"
+#include "ordered-data.h"
+#include "transaction.h"
+#include "math.h"
 
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
@@ -404,3 +407,698 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		goto again;
 	up_read(&info->groups_sem);
 }
+
+static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
+					 unsigned long nr_pages, int nr_items)
+{
+	struct super_block *sb = fs_info->sb;
+
+	if (down_read_trylock(&sb->s_umount)) {
+		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
+		up_read(&sb->s_umount);
+	} else {
+		/*
+		 * We needn't worry the filesystem going from r/w to r/o though
+		 * we don't acquire ->s_umount mutex, because the filesystem
+		 * should guarantee the delalloc inodes list be empty after
+		 * the filesystem is readonly(all dirty pages are written to
+		 * the disk).
+		 */
+		btrfs_start_delalloc_roots(fs_info, nr_items);
+		if (!current->journal_info)
+			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
+	}
+}
+
+static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
+					u64 to_reclaim)
+{
+	u64 bytes;
+	u64 nr;
+
+	bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
+	nr = div64_u64(to_reclaim, bytes);
+	if (!nr)
+		nr = 1;
+	return nr;
+}
+
+#define EXTENT_SIZE_PER_ITEM	SZ_256K
+
+/*
+ * shrink metadata reservation for delalloc
+ */
+static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
+			    u64 orig, bool wait_ordered)
+{
+	struct btrfs_space_info *space_info;
+	struct btrfs_trans_handle *trans;
+	u64 delalloc_bytes;
+	u64 dio_bytes;
+	u64 async_pages;
+	u64 items;
+	long time_left;
+	unsigned long nr_pages;
+	int loops;
+
+	/* Calc the number of the pages we need flush for space reservation */
+	items = calc_reclaim_items_nr(fs_info, to_reclaim);
+	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+
+	trans = (struct btrfs_trans_handle *)current->journal_info;
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+
+	delalloc_bytes = percpu_counter_sum_positive(
+						&fs_info->delalloc_bytes);
+	dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
+	if (delalloc_bytes == 0 && dio_bytes == 0) {
+		if (trans)
+			return;
+		if (wait_ordered)
+			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
+		return;
+	}
+
+	/*
+	 * If we are doing more ordered than delalloc we need to just wait on
+	 * ordered extents, otherwise we'll waste time trying to flush delalloc
+	 * that likely won't give us the space back we need.
+	 */
+	if (dio_bytes > delalloc_bytes)
+		wait_ordered = true;
+
+	loops = 0;
+	while ((delalloc_bytes || dio_bytes) && loops < 3) {
+		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+
+		/*
+		 * Triggers inode writeback for up to nr_pages. This will invoke
+		 * ->writepages callback and trigger delalloc filling
+		 *  (btrfs_run_delalloc_range()).
+		 */
+		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
+
+		/*
+		 * We need to wait for the compressed pages to start before
+		 * we continue.
+		 */
+		async_pages = atomic_read(&fs_info->async_delalloc_pages);
+		if (!async_pages)
+			goto skip_async;
+
+		/*
+		 * Calculate how many compressed pages we want to be written
+		 * before we continue. I.e if there are more async pages than we
+		 * require wait_event will wait until nr_pages are written.
+		 */
+		if (async_pages <= nr_pages)
+			async_pages = 0;
+		else
+			async_pages -= nr_pages;
+
+		wait_event(fs_info->async_submit_wait,
+			   atomic_read(&fs_info->async_delalloc_pages) <=
+			   (int)async_pages);
+skip_async:
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets) &&
+		    list_empty(&space_info->priority_tickets)) {
+			spin_unlock(&space_info->lock);
+			break;
+		}
+		spin_unlock(&space_info->lock);
+
+		loops++;
+		if (wait_ordered && !trans) {
+			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
+		} else {
+			time_left = schedule_timeout_killable(1);
+			if (time_left)
+				break;
+		}
+		delalloc_bytes = percpu_counter_sum_positive(
+						&fs_info->delalloc_bytes);
+		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
+	}
+}
+
+/**
+ * maybe_commit_transaction - possibly commit the transaction if its ok to
+ * @root - the root we're allocating for
+ * @bytes - the number of bytes we want to reserve
+ * @force - force the commit
+ *
+ * This will check to make sure that committing the transaction will actually
+ * get us somewhere and then commit the transaction if it does.  Otherwise it
+ * will return -ENOSPC.
+ */
+static int may_commit_transaction(struct btrfs_fs_info *fs_info,
+				  struct btrfs_space_info *space_info)
+{
+	struct reserve_ticket *ticket = NULL;
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
+	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_trans_handle *trans;
+	u64 bytes_needed;
+	u64 reclaim_bytes = 0;
+
+	trans = (struct btrfs_trans_handle *)current->journal_info;
+	if (trans)
+		return -EAGAIN;
+
+	spin_lock(&space_info->lock);
+	if (!list_empty(&space_info->priority_tickets))
+		ticket = list_first_entry(&space_info->priority_tickets,
+					  struct reserve_ticket, list);
+	else if (!list_empty(&space_info->tickets))
+		ticket = list_first_entry(&space_info->tickets,
+					  struct reserve_ticket, list);
+	bytes_needed = (ticket) ? ticket->bytes : 0;
+	spin_unlock(&space_info->lock);
+
+	if (!bytes_needed)
+		return 0;
+
+	trans = btrfs_join_transaction(fs_info->extent_root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	/*
+	 * See if there is enough pinned space to make this reservation, or if
+	 * we have block groups that are going to be freed, allowing us to
+	 * possibly do a chunk allocation the next loop through.
+	 */
+	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	    __percpu_counter_compare(&space_info->total_bytes_pinned,
+				     bytes_needed,
+				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
+		goto commit;
+
+	/*
+	 * See if there is some space in the delayed insertion reservation for
+	 * this reservation.
+	 */
+	if (space_info != delayed_rsv->space_info)
+		goto enospc;
+
+	spin_lock(&delayed_rsv->lock);
+	reclaim_bytes += delayed_rsv->reserved;
+	spin_unlock(&delayed_rsv->lock);
+
+	spin_lock(&delayed_refs_rsv->lock);
+	reclaim_bytes += delayed_refs_rsv->reserved;
+	spin_unlock(&delayed_refs_rsv->lock);
+	if (reclaim_bytes >= bytes_needed)
+		goto commit;
+	bytes_needed -= reclaim_bytes;
+
+	if (__percpu_counter_compare(&space_info->total_bytes_pinned,
+				   bytes_needed,
+				   BTRFS_TOTAL_BYTES_PINNED_BATCH) < 0)
+		goto enospc;
+
+commit:
+	return btrfs_commit_transaction(trans);
+enospc:
+	btrfs_end_transaction(trans);
+	return -ENOSPC;
+}
+
+/*
+ * Try to flush some data based on policy set by @state. This is only advisory
+ * and may fail for various reasons. The caller is supposed to examine the
+ * state of @space_info to detect the outcome.
+ */
+static void flush_space(struct btrfs_fs_info *fs_info,
+		       struct btrfs_space_info *space_info, u64 num_bytes,
+		       int state)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_trans_handle *trans;
+	int nr;
+	int ret = 0;
+
+	switch (state) {
+	case FLUSH_DELAYED_ITEMS_NR:
+	case FLUSH_DELAYED_ITEMS:
+		if (state == FLUSH_DELAYED_ITEMS_NR)
+			nr = calc_reclaim_items_nr(fs_info, num_bytes) * 2;
+		else
+			nr = -1;
+
+		trans = btrfs_join_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+		ret = btrfs_run_delayed_items_nr(trans, nr);
+		btrfs_end_transaction(trans);
+		break;
+	case FLUSH_DELALLOC:
+	case FLUSH_DELALLOC_WAIT:
+		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+				state == FLUSH_DELALLOC_WAIT);
+		break;
+	case FLUSH_DELAYED_REFS_NR:
+	case FLUSH_DELAYED_REFS:
+		trans = btrfs_join_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+		if (state == FLUSH_DELAYED_REFS_NR)
+			nr = calc_reclaim_items_nr(fs_info, num_bytes);
+		else
+			nr = 0;
+		btrfs_run_delayed_refs(trans, nr);
+		btrfs_end_transaction(trans);
+		break;
+	case ALLOC_CHUNK:
+	case ALLOC_CHUNK_FORCE:
+		trans = btrfs_join_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+		ret = btrfs_chunk_alloc(trans,
+				btrfs_metadata_alloc_profile(fs_info),
+				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
+					CHUNK_ALLOC_FORCE);
+		btrfs_end_transaction(trans);
+		if (ret > 0 || ret == -ENOSPC)
+			ret = 0;
+		break;
+	case COMMIT_TRANS:
+		/*
+		 * If we have pending delayed iputs then we could free up a
+		 * bunch of pinned space, so make sure we run the iputs before
+		 * we do our pinned bytes check below.
+		 */
+		btrfs_run_delayed_iputs(fs_info);
+		btrfs_wait_on_delayed_iputs(fs_info);
+
+		ret = may_commit_transaction(fs_info, space_info);
+		break;
+	default:
+		ret = -ENOSPC;
+		break;
+	}
+
+	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
+				ret);
+	return;
+}
+
+static inline u64
+btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info,
+				 bool system_chunk)
+{
+	struct reserve_ticket *ticket;
+	u64 used;
+	u64 expected;
+	u64 to_reclaim = 0;
+
+	list_for_each_entry(ticket, &space_info->tickets, list)
+		to_reclaim += ticket->bytes;
+	list_for_each_entry(ticket, &space_info->priority_tickets, list)
+		to_reclaim += ticket->bytes;
+	if (to_reclaim)
+		return to_reclaim;
+
+	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+		return 0;
+
+	used = btrfs_space_info_used(space_info, true);
+
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+		expected = div_factor_fine(space_info->total_bytes, 95);
+	else
+		expected = div_factor_fine(space_info->total_bytes, 90);
+
+	if (used > expected)
+		to_reclaim = used - expected;
+	else
+		to_reclaim = 0;
+	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
+				     space_info->bytes_reserved);
+	return to_reclaim;
+}
+
+static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
+					struct btrfs_space_info *space_info,
+					u64 used, bool system_chunk)
+{
+	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+
+	/* If we're just plain full then async reclaim just slows us down. */
+	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
+		return 0;
+
+	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info,
+					      system_chunk))
+		return 0;
+
+	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
+		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
+}
+
+static bool wake_all_tickets(struct list_head *head)
+{
+	struct reserve_ticket *ticket;
+
+	while (!list_empty(head)) {
+		ticket = list_first_entry(head, struct reserve_ticket, list);
+		list_del_init(&ticket->list);
+		ticket->error = -ENOSPC;
+		wake_up(&ticket->wait);
+		if (ticket->bytes != ticket->orig_bytes)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This is for normal flushers, we can wait all goddamned day if we want to.  We
+ * will loop and continuously try to flush as long as we are making progress.
+ * We count progress as clearing off tickets each time we have to loop.
+ */
+static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+	u64 to_reclaim;
+	int flush_state;
+	int commit_cycles = 0;
+	u64 last_tickets_id;
+
+	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+
+	spin_lock(&space_info->lock);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
+						      false);
+	if (!to_reclaim) {
+		space_info->flush = 0;
+		spin_unlock(&space_info->lock);
+		return;
+	}
+	last_tickets_id = space_info->tickets_id;
+	spin_unlock(&space_info->lock);
+
+	flush_state = FLUSH_DELAYED_ITEMS_NR;
+	do {
+		flush_space(fs_info, space_info, to_reclaim, flush_state);
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets)) {
+			space_info->flush = 0;
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info,
+							      space_info,
+							      false);
+		if (last_tickets_id == space_info->tickets_id) {
+			flush_state++;
+		} else {
+			last_tickets_id = space_info->tickets_id;
+			flush_state = FLUSH_DELAYED_ITEMS_NR;
+			if (commit_cycles)
+				commit_cycles--;
+		}
+
+		/*
+		 * We don't want to force a chunk allocation until we've tried
+		 * pretty hard to reclaim space.  Think of the case where we
+		 * freed up a bunch of space and so have a lot of pinned space
+		 * to reclaim.  We would rather use that than possibly create a
+		 * underutilized metadata chunk.  So if this is our first run
+		 * through the flushing state machine skip ALLOC_CHUNK_FORCE and
+		 * commit the transaction.  If nothing has changed the next go
+		 * around then we can force a chunk allocation.
+		 */
+		if (flush_state == ALLOC_CHUNK_FORCE && !commit_cycles)
+			flush_state++;
+
+		if (flush_state > COMMIT_TRANS) {
+			commit_cycles++;
+			if (commit_cycles > 2) {
+				if (wake_all_tickets(&space_info->tickets)) {
+					flush_state = FLUSH_DELAYED_ITEMS_NR;
+					commit_cycles--;
+				} else {
+					space_info->flush = 0;
+				}
+			} else {
+				flush_state = FLUSH_DELAYED_ITEMS_NR;
+			}
+		}
+		spin_unlock(&space_info->lock);
+	} while (flush_state <= COMMIT_TRANS);
+}
+
+void btrfs_init_async_reclaim_work(struct work_struct *work)
+{
+	INIT_WORK(work, btrfs_async_reclaim_metadata_space);
+}
+
+static const enum btrfs_flush_state priority_flush_states[] = {
+	FLUSH_DELAYED_ITEMS_NR,
+	FLUSH_DELAYED_ITEMS,
+	ALLOC_CHUNK,
+};
+
+static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
+					    struct btrfs_space_info *space_info,
+					    struct reserve_ticket *ticket)
+{
+	u64 to_reclaim;
+	int flush_state;
+
+	spin_lock(&space_info->lock);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
+						      false);
+	if (!to_reclaim) {
+		spin_unlock(&space_info->lock);
+		return;
+	}
+	spin_unlock(&space_info->lock);
+
+	flush_state = 0;
+	do {
+		flush_space(fs_info, space_info, to_reclaim,
+			    priority_flush_states[flush_state]);
+		flush_state++;
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+	} while (flush_state < ARRAY_SIZE(priority_flush_states));
+}
+
+static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
+			       struct btrfs_space_info *space_info,
+			       struct reserve_ticket *ticket)
+
+{
+	DEFINE_WAIT(wait);
+	u64 reclaim_bytes = 0;
+	int ret = 0;
+
+	spin_lock(&space_info->lock);
+	while (ticket->bytes > 0 && ticket->error == 0) {
+		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
+		if (ret) {
+			ret = -EINTR;
+			break;
+		}
+		spin_unlock(&space_info->lock);
+
+		schedule();
+
+		finish_wait(&ticket->wait, &wait);
+		spin_lock(&space_info->lock);
+	}
+	if (!ret)
+		ret = ticket->error;
+	if (!list_empty(&ticket->list))
+		list_del_init(&ticket->list);
+	if (ticket->bytes && ticket->bytes < ticket->orig_bytes)
+		reclaim_bytes = ticket->orig_bytes - ticket->bytes;
+	spin_unlock(&space_info->lock);
+
+	if (reclaim_bytes)
+		btrfs_space_info_add_old_bytes(fs_info, space_info,
+					       reclaim_bytes);
+	return ret;
+}
+
+/**
+ * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
+ * @root - the root we're allocating for
+ * @space_info - the space info we want to allocate from
+ * @orig_bytes - the number of bytes we want
+ * @flush - whether or not we can flush to make our reservation
+ *
+ * This will reserve orig_bytes number of bytes from the space info associated
+ * with the block_rsv.  If there is not enough space it will make an attempt to
+ * flush out space to make room.  It will do this by flushing delalloc if
+ * possible or committing the transaction.  If flush is 0 then no attempts to
+ * regain reservations will be made and this will fail if there is not enough
+ * space already.
+ */
+static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 orig_bytes,
+				    enum btrfs_reserve_flush_enum flush,
+				    bool system_chunk)
+{
+	struct reserve_ticket ticket;
+	u64 used;
+	u64 reclaim_bytes = 0;
+	int ret = 0;
+
+	ASSERT(orig_bytes);
+	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
+
+	spin_lock(&space_info->lock);
+	ret = -ENOSPC;
+	used = btrfs_space_info_used(space_info, true);
+
+	/*
+	 * If we have enough space then hooray, make our reservation and carry
+	 * on.  If not see if we can overcommit, and if we can, hooray carry on.
+	 * If not things get more complicated.
+	 */
+	if (used + orig_bytes <= space_info->total_bytes) {
+		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
+						      orig_bytes);
+		trace_btrfs_space_reservation(fs_info, "space_info",
+					      space_info->flags, orig_bytes, 1);
+		ret = 0;
+	} else if (btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush,
+					system_chunk)) {
+		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
+						      orig_bytes);
+		trace_btrfs_space_reservation(fs_info, "space_info",
+					      space_info->flags, orig_bytes, 1);
+		ret = 0;
+	}
+
+	/*
+	 * If we couldn't make a reservation then setup our reservation ticket
+	 * and kick the async worker if it's not already running.
+	 *
+	 * If we are a priority flusher then we just need to add our ticket to
+	 * the list and we will do our own flushing further down.
+	 */
+	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
+		ticket.orig_bytes = orig_bytes;
+		ticket.bytes = orig_bytes;
+		ticket.error = 0;
+		init_waitqueue_head(&ticket.wait);
+		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
+			list_add_tail(&ticket.list, &space_info->tickets);
+			if (!space_info->flush) {
+				space_info->flush = 1;
+				trace_btrfs_trigger_flush(fs_info,
+							  space_info->flags,
+							  orig_bytes, flush,
+							  "enospc");
+				queue_work(system_unbound_wq,
+					   &fs_info->async_reclaim_work);
+			}
+		} else {
+			list_add_tail(&ticket.list,
+				      &space_info->priority_tickets);
+		}
+	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
+		used += orig_bytes;
+		/*
+		 * We will do the space reservation dance during log replay,
+		 * which means we won't have fs_info->fs_root set, so don't do
+		 * the async reclaim as we will panic.
+		 */
+		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
+		    need_do_async_reclaim(fs_info, space_info,
+					  used, system_chunk) &&
+		    !work_busy(&fs_info->async_reclaim_work)) {
+			trace_btrfs_trigger_flush(fs_info, space_info->flags,
+						  orig_bytes, flush, "preempt");
+			queue_work(system_unbound_wq,
+				   &fs_info->async_reclaim_work);
+		}
+	}
+	spin_unlock(&space_info->lock);
+	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
+		return ret;
+
+	if (flush == BTRFS_RESERVE_FLUSH_ALL)
+		return wait_reserve_ticket(fs_info, space_info, &ticket);
+
+	ret = 0;
+	priority_reclaim_metadata_space(fs_info, space_info, &ticket);
+	spin_lock(&space_info->lock);
+	if (ticket.bytes) {
+		if (ticket.bytes < orig_bytes)
+			reclaim_bytes = orig_bytes - ticket.bytes;
+		list_del_init(&ticket.list);
+		ret = -ENOSPC;
+	}
+	spin_unlock(&space_info->lock);
+
+	if (reclaim_bytes)
+		btrfs_space_info_add_old_bytes(fs_info, space_info,
+					       reclaim_bytes);
+	ASSERT(list_empty(&ticket.list));
+	return ret;
+}
+
+/**
+ * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
+ * @root - the root we're allocating for
+ * @block_rsv - the block_rsv we're allocating for
+ * @orig_bytes - the number of bytes we want
+ * @flush - whether or not we can flush to make our reservation
+ *
+ * This will reserve orig_bytes number of bytes from the space info associated
+ * with the block_rsv.  If there is not enough space it will make an attempt to
+ * flush out space to make room.  It will do this by flushing delalloc if
+ * possible or committing the transaction.  If flush is 0 then no attempts to
+ * regain reservations will be made and this will fail if there is not enough
+ * space already.
+ */
+int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
+				 struct btrfs_block_rsv *block_rsv,
+				 u64 orig_bytes,
+				 enum btrfs_reserve_flush_enum flush)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	int ret;
+	bool system_chunk = (root == fs_info->chunk_root);
+
+	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
+				       orig_bytes, flush, system_chunk);
+	if (ret == -ENOSPC &&
+	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
+		if (block_rsv != global_rsv &&
+		    !btrfs_block_rsv_use_bytes(global_rsv, orig_bytes))
+			ret = 0;
+	}
+	if (ret == -ENOSPC) {
+		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
+					      block_rsv->space_info->flags,
+					      orig_bytes, 1);
+
+		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+			btrfs_dump_space_info(fs_info, block_rsv->space_info,
+					      orig_bytes, 0);
+	}
+	return ret;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index e2ab16e17fe1..05bfd8e5b10e 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -131,5 +131,9 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
 			   int dump_block_groups);
+int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
+				 struct btrfs_block_rsv *block_rsv,
+				 u64 orig_bytes,
+				 enum btrfs_reserve_flush_enum flush);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.14.3

