Return-Path: <linux-btrfs+bounces-18214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2AC024A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7721E3AD390
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858F29B8D3;
	Thu, 23 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUjeGSMA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654929B76F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235231; cv=none; b=VQytARFHoOJko0kiiCsWIPLjo5SJXulTrQLkRGsf0kaFvQYO7xNO4fxHK0+tm+R2t/biwsgLabvBo8zfcVTjn8oedTrAU30E07SmsgQCs+Wc5AL0pE6wYyTliZpXmAkf8cjZKktXVEyEOR7mSohVQuM7JgEZahP1pWyh+C3F5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235231; c=relaxed/simple;
	bh=pLmSQCz+G3qjhTn33SKBfBDW51HFO+RHzZR8mgtCWp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+9vbE66Gc/SUQCGHQ+GpI7tMKE9lW68yhiW/6jMzpgs+HCYE7aGMsh6mzXlHPfP3j/zG36mXaih+IUWAZ1TBr1/6/pk8+1WXp7GwHZ1T+3DhPPPP4cZX6ZKmpmP9NNeL47H2WFahepK9QJANeLk9mmZ1cuwMq25d4sfYe1EVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUjeGSMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AC5C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235231;
	bh=pLmSQCz+G3qjhTn33SKBfBDW51HFO+RHzZR8mgtCWp4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bUjeGSMAg7tXLRW8IHLqgnKzUmm/hIeWL+ul5Pibls/62v93RbKBOfQFWVkTmZbYT
	 IY8snwalG7lDBmmLDz5CYP9R7vMPzosfhtOY5L1i7aj5eeIrsssV5Zjd7miKRezCIx
	 /j2apN8k5p55JmMzMwB0ohIM+Bt8J3LguwcSJ6OrYZ9vFkJrViN2GOwOnfNt/MBq49
	 xifO4um3KAm2rjlZA3Z7/FFOk7845wVEp/8ytbyu5yl3u9NBOenrBr+FxTOWdhE/Bi
	 Cq+76/BERNKAFRksawXvoftcP1aUrqYEiqRJHqLoTTQpKDkRhKL5wkaEEMad38Xr2v
	 eWh7p7GklDiDQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 27/28] btrfs: avoid space_info locking when checking if tickets are served
Date: Thu, 23 Oct 2025 17:00:00 +0100
Message-ID: <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When checking if a ticket was served, we take the space_info's spinlock.
If the ticket was served (its ->bytes is 0) or had an error (its ->error
it not 0) then we just unlock the space_info and return.

This however causes contention on the space_info's spinlock, which is
heavily used (space reservation, space flushing, allocating and
deallocating an extent from a block group (btrfs_update_block_group()),
etc).

Instead of using the space_info's spinlock to check if a ticket was
served, use a per ticket spinlock which isn't used by anyone other than
the task that created the ticket (stack allocated) and the task that
serves the ticket (a reclaim task or any task deallocating space that
ends up at btrfs_try_granting_tickets()).

After applying this patch and all previous patches from the same patchset
(many attempt to reduce space_info critical sections), lockstat showed
some improvements for a fs_mark test regarding the space_info's spinlock
'lock'. The lockstat results:

Before patchset:

  con-bounces:     13733858
  contentions:     15902322
  waittime-total:  264902529.72
  acq-bounces:     28161791
  acquisitions:    38679282

After patchset:

  con-bounces:     12032220
  contentions:     13598034
  waittime-total:  221806127.28
  acq-bounces:     24717947
  acquisitions:    34103281

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 56 +++++++++++++++++++++++++------------------
 fs/btrfs/space-info.h |  1 +
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 86cd87c5884a..cce53a452fd3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -517,18 +517,22 @@ bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 static void remove_ticket(struct btrfs_space_info *space_info,
 			  struct reserve_ticket *ticket, int error)
 {
+	lockdep_assert_held(&space_info->lock);
+
 	if (!list_empty(&ticket->list)) {
 		list_del_init(&ticket->list);
 		ASSERT(space_info->reclaim_size >= ticket->bytes);
 		space_info->reclaim_size -= ticket->bytes;
 	}
 
+	spin_lock(&ticket->lock);
 	if (error)
 		ticket->error = error;
 	else
 		ticket->bytes = 0;
 
 	wake_up(&ticket->wait);
+	spin_unlock(&ticket->lock);
 }
 
 /*
@@ -1495,6 +1499,17 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	RESET_ZONES,
 };
 
+static bool is_ticket_served(struct reserve_ticket *ticket)
+{
+	bool ret;
+
+	spin_lock(&ticket->lock);
+	ret = (ticket->bytes == 0);
+	spin_unlock(&ticket->lock);
+
+	return ret;
+}
+
 static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 					    struct reserve_ticket *ticket,
 					    const enum btrfs_flush_state *states,
@@ -1504,29 +1519,25 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	u64 to_reclaim;
 	int flush_state = 0;
 
-	spin_lock(&space_info->lock);
 	/*
 	 * This is the priority reclaim path, so to_reclaim could be >0 still
 	 * because we may have only satisfied the priority tickets and still
 	 * left non priority tickets on the list.  We would then have
 	 * to_reclaim but ->bytes == 0.
 	 */
-	if (ticket->bytes == 0) {
-		spin_unlock(&space_info->lock);
+	if (is_ticket_served(ticket))
 		return;
-	}
 
+	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 
 	while (flush_state < states_nr) {
 		spin_unlock(&space_info->lock);
 		flush_space(space_info, to_reclaim, states[flush_state], false);
+		if (is_ticket_served(ticket))
+			return;
 		flush_state++;
 		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
-			return;
-		}
 	}
 
 	/*
@@ -1554,22 +1565,17 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
 					struct reserve_ticket *ticket)
 {
-	spin_lock(&space_info->lock);
-
 	/* We could have been granted before we got here. */
-	if (ticket->bytes == 0) {
-		spin_unlock(&space_info->lock);
+	if (is_ticket_served(ticket))
 		return;
-	}
 
+	spin_lock(&space_info->lock);
 	while (!space_info->full) {
 		spin_unlock(&space_info->lock);
 		flush_space(space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
-		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
+		if (is_ticket_served(ticket))
 			return;
-		}
+		spin_lock(&space_info->lock);
 	}
 
 	remove_ticket(space_info, ticket, -ENOSPC);
@@ -1582,11 +1588,13 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
 
 {
 	DEFINE_WAIT(wait);
-	int ret = 0;
 
-	spin_lock(&space_info->lock);
+	spin_lock(&ticket->lock);
 	while (ticket->bytes > 0 && ticket->error == 0) {
+		int ret;
+
 		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
+		spin_unlock(&ticket->lock);
 		if (ret) {
 			/*
 			 * Delete us from the list. After we unlock the space
@@ -1596,17 +1604,18 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
 			 * despite getting an error, resulting in a space leak
 			 * (bytes_may_use counter of our space_info).
 			 */
+			spin_lock(&space_info->lock);
 			remove_ticket(space_info, ticket, -EINTR);
-			break;
+			spin_unlock(&space_info->lock);
+			return;
 		}
-		spin_unlock(&space_info->lock);
 
 		schedule();
 
 		finish_wait(&ticket->wait, &wait);
-		spin_lock(&space_info->lock);
+		spin_lock(&ticket->lock);
 	}
-	spin_unlock(&space_info->lock);
+	spin_unlock(&ticket->lock);
 }
 
 /*
@@ -1804,6 +1813,7 @@ static int reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
+		spin_lock_init(&ticket.lock);
 		ticket.steal = can_steal(flush);
 		if (trace_btrfs_reserve_ticket_enabled())
 			start_ns = ktime_get_ns();
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 7e16d4c116c8..a4c2a3c8b388 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -230,6 +230,7 @@ struct reserve_ticket {
 	bool steal;
 	struct list_head list;
 	wait_queue_head_t wait;
+	spinlock_t lock;
 };
 
 static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
-- 
2.47.2


