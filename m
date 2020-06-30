Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F191920F6A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgF3OAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgF3OAO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E256C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id m9so9307020qvx.5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfVkz+2UGd3pKpWLk7eMITHTv6YrhNmgPwwAkCDHqPA=;
        b=F9QYl8Cw0MKqv7arFdC3XCgBr4f4iUw31eQAa9jXFk/BVvOXMuNeYcO5T3diY6x8Qx
         6xPRywW/D5bRx5TMXfPiP9I39KmiFWusMXONHZRx88DlTaySOVKCFI0NG3wmzEOvwl7i
         vKn5p4nH76MgRC6Bk0e39tldhkVtw/M9czhk8gg4Vdcbea/S/Osa9Vao55+vQBssGvqb
         O+B37xrJs0KMlpYwF3HbhwAFn5ngww0Vrn9TrRSuwRLH1EIc8EYWv4V/EaEktupvcH2x
         URwD2g10cuuVjPZc0Re7GX+FZvNNv455cyFECgZqJEGTbrFJXJo0M4B+YLSZJmlxQR03
         6Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfVkz+2UGd3pKpWLk7eMITHTv6YrhNmgPwwAkCDHqPA=;
        b=aC2zEUADhPpqqIPrVfxTmUNvJ4sb7czJQww3oOFu0MpcOY/a2ECqJTMhlvGVBTpX4O
         okn87YjwMnOaVksOl+xf5N0a5OQM3qKMYPvgP7sUijyuR0hiyFi+EDuOkF31Wm3ZRkOe
         gCOv2PX7lj7u4YLFv2i4xzYDG/v3d1dcEVSWnXcYVlZjsIn+5sOFN6jdlZ50fqQr2gKN
         MmaoKbpxRpse082YO27IoDpUGgAxYWNE6+teEy9Q62IvJ65sgTy3K78wvVU7RYOkdmrQ
         0c933gtsdtafZN9v0cvXoT/QjtM5rrBwfbndDKMRc9XqbkAluDmnX/1G0QmiN9mg50Mt
         3zAw==
X-Gm-Message-State: AOAM530Q78PXPvbm86HwN2lCvjIxvh7Tt5JhUQjlQPgFXwVZHHJ15Bzj
        rVfrzj8Ey7SyAZCyNW21MSj0bQSnG4R2jQ==
X-Google-Smtp-Source: ABdhPJwi0AqOhBAO+beSGmQTFIUNDh3qEwL1VRyZ6okrmgS16fNyFMvHK5rzsZYTwVG6/ehbygInoA==
X-Received: by 2002:a0c:b791:: with SMTP id l17mr20613821qve.44.1593525612635;
        Tue, 30 Jun 2020 07:00:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w18sm2880054qtn.3.2020.06.30.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 22/23] btrfs: do async reclaim for data reservations
Date:   Tue, 30 Jun 2020 09:59:20 -0400
Message-Id: <20200630135921.745612-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have the data ticketing stuff in place, move normal data
reservations to use an async reclaim helper to satisfy tickets.  Before
we could have multiple tasks race in and both allocate chunks, resulting
in more data chunks than we would necessarily need.  Serializing these
allocations and making a single thread responsible for flushing will
only allocate chunks as needed, as well as cut down on transaction
commits and other flush related activities.

Priority reservations will still work as they have before, simply
trying to allocate a chunk until they can make their reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |   3 +-
 fs/btrfs/disk-io.c    |   3 +-
 fs/btrfs/space-info.c | 123 ++++++++++++++++++++++++++++++------------
 fs/btrfs/super.c      |   1 +
 4 files changed, 93 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index efa72a204b91..998bda3132fd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -494,7 +494,7 @@ enum btrfs_orphan_cleanup_state {
 	ORPHAN_CLEANUP_DONE	= 2,
 };
 
-void btrfs_init_async_reclaim_work(struct work_struct *work);
+void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 
 /* fs_info */
 struct reloc_control;
@@ -916,6 +916,7 @@ struct btrfs_fs_info {
 
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
+	struct work_struct async_data_reclaim_work;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c07578866f3..0907e02eea54 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2713,7 +2713,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->check_integrity_print_mask = 0;
 #endif
 	btrfs_init_balance(fs_info);
-	btrfs_init_async_reclaim_work(&fs_info->async_reclaim_work);
+	btrfs_init_async_reclaim_work(fs_info);
 
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
@@ -4033,6 +4033,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_cleanup_defrag_inodes(fs_info);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
+	cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8b1a5b644d2f..0a2fdfaa9fe6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -996,9 +996,83 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
-void btrfs_init_async_reclaim_work(struct work_struct *work)
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
+	COMMIT_TRANS,
+};
+
+static void btrfs_async_reclaim_data_space(struct work_struct *work)
 {
-	INIT_WORK(work, btrfs_async_reclaim_metadata_space);
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+	u64 last_tickets_id;
+	int flush_state = 0;
+
+	fs_info = container_of(work, struct btrfs_fs_info,
+			       async_data_reclaim_work);
+	space_info = fs_info->data_sinfo;
+
+	spin_lock(&space_info->lock);
+	if (list_empty(&space_info->tickets)) {
+		space_info->flush = 0;
+		spin_unlock(&space_info->lock);
+		return;
+	}
+	last_tickets_id = space_info->tickets_id;
+	spin_unlock(&space_info->lock);
+
+	while (!space_info->full) {
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets)) {
+			space_info->flush = 0;
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		last_tickets_id = space_info->tickets_id;
+		spin_unlock(&space_info->lock);
+	}
+
+	while (flush_state < ARRAY_SIZE(data_flush_states)) {
+		flush_space(fs_info, space_info, U64_MAX,
+			    data_flush_states[flush_state]);
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets)) {
+			space_info->flush = 0;
+			spin_unlock(&space_info->lock);
+			return;
+		}
+
+		if (last_tickets_id == space_info->tickets_id) {
+			flush_state++;
+		} else {
+			last_tickets_id = space_info->tickets_id;
+			flush_state = 0;
+		}
+
+		if (flush_state >= ARRAY_SIZE(data_flush_states)) {
+			if (space_info->full) {
+				if (maybe_fail_all_tickets(fs_info,
+							   space_info))
+					flush_state = 0;
+				else
+					space_info->flush = 0;
+			} else {
+				flush_state = 0;
+			}
+		}
+		spin_unlock(&space_info->lock);
+	}
+}
+
+void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
+{
+	INIT_WORK(&fs_info->async_reclaim_work,
+		  btrfs_async_reclaim_metadata_space);
+	INIT_WORK(&fs_info->async_data_reclaim_work,
+		  btrfs_async_reclaim_data_space);
 }
 
 static const enum btrfs_flush_state priority_flush_states[] = {
@@ -1018,13 +1092,6 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
-static const enum btrfs_flush_state data_flush_states[] = {
-	FLUSH_DELALLOC_WAIT,
-	RUN_DELAYED_IPUTS,
-	FLUSH_DELAYED_REFS,
-	COMMIT_TRANS,
-};
-
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
@@ -1057,12 +1124,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
-					struct reserve_ticket *ticket,
-					const enum btrfs_flush_state *states,
-					int states_nr)
+					struct reserve_ticket *ticket)
 {
-	int flush_state = 0;
-
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
 		spin_lock(&space_info->lock);
@@ -1072,17 +1135,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		}
 		spin_unlock(&space_info->lock);
 	}
-
-	while (flush_state < states_nr) {
-		flush_space(fs_info, space_info, U64_MAX, states[flush_state]);
-		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
-			return;
-		}
-		spin_unlock(&space_info->lock);
-		flush_state++;
-	}
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
@@ -1137,6 +1189,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
@@ -1151,14 +1204,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
 		break;
-	case BTRFS_RESERVE_FLUSH_DATA:
-		priority_reclaim_data_space(fs_info, space_info, ticket,
-					data_flush_states,
-					ARRAY_SIZE(data_flush_states));
-		break;
 	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
-		priority_reclaim_data_space(fs_info, space_info, ticket,
-					    NULL, 0);
+		priority_reclaim_data_space(fs_info, space_info, ticket);
 		break;
 	default:
 		ASSERT(0);
@@ -1223,6 +1270,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
@@ -1231,6 +1279,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	ASSERT(orig_bytes);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
 
+	if (flush == BTRFS_RESERVE_FLUSH_DATA)
+		async_work = &fs_info->async_data_reclaim_work;
+	else
+		async_work = &fs_info->async_reclaim_work;
+
 	spin_lock(&space_info->lock);
 	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
@@ -1272,7 +1325,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
-		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
+		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1280,8 +1334,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
 							  "enospc");
-				queue_work(system_unbound_wq,
-					   &fs_info->async_reclaim_work);
+				queue_work(system_unbound_wq, async_work);
 			}
 		} else {
 			list_add_tail(&ticket.list,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3c9ebd4f2b61..66094f076385 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1880,6 +1880,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 * the filesystem is busy.
 		 */
 		cancel_work_sync(&fs_info->async_reclaim_work);
+		cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 		btrfs_discard_cleanup(fs_info);
 
-- 
2.24.1

