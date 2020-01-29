Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284B414D40F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgA2XvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:51:00 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:45740 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgA2XvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:51:00 -0500
Received: by mail-qk1-f178.google.com with SMTP id x1so1150031qkl.12
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kVLuSlNC4E4TfoBE1j4xGFlqeyenTSQJKN+LCxjoYzc=;
        b=JKPgAJQq60Qs/mbhwxGAQboAWYv7o2RqNX0vb4eyCBA+Xo9lbpCzfkD8h1z7qg7X4F
         yEXBbneSZJMFgGOLC8zGBwclnGvRf+j1B9T+Cm+BPGrFsQi9Vb0x26Ic/AUiWIEw00wu
         jn+kf+Z/hSUzX2mjOjugEaEcmH43lw5zN5eXhD0PYMmqf34nJ+BtIBF4V+G6fHGSlFpn
         Qv46dzTHbUvJ191AxLgetRlKdob99FZD4PbzF3DPMk1fvLT6x3wXPOoClLG/mumh9sVM
         VPzXDAYnFjJUzAMS+A/LhuhWMfr4gKI8xEq3gESFFNRUma6ttiHtbDImvYKn4JCc7JBm
         pOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVLuSlNC4E4TfoBE1j4xGFlqeyenTSQJKN+LCxjoYzc=;
        b=jWZzrGO8t7WfmLQOiqnBG160FGLf4R4KwXtsl6vMIWGEgTv8U+y1fF09EuuObnTmKg
         IHMBpasSchMGzIYZzo9mQOBw1DsIwJRIWF3NxbVGAGQwBiUmYs8Sa+oOFeDWUfd8A2uz
         x1PIXHmLJnm23N77UcjOWlkxN6iul4ZHmz/KE6ia5GierGklMUpIAXgmMwUbk2ME3uD/
         R9dWkkrStcqak1ylWpEBxXT3b32sbKDLx0a5tFXweDyyYXfnTMhkyvc88ytVse7DIZj7
         6ItlTfU04o9Xz8fsACRo/BZcTA63917a/E4vPCCsR3fXjcT+cyvlPiMatiCsdKZJsxyd
         rQ9Q==
X-Gm-Message-State: APjAAAXoa3Gh7uQfH4YWCOtNqY1h/mAm8DvbgPOvkrlXXk2AIK6agksf
        l/aZjXxSHqxICXq5kxbkIaxG9ErMlI4Pjg==
X-Google-Smtp-Source: APXvYqympwFfWajxxvHk2q8apywNvepPXjTe+dt7oK6jjHRbFWs62CnGzhfZIxuwAl47rwUtHsIuwA==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr2618794qkj.36.1580341858918;
        Wed, 29 Jan 2020 15:50:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p19sm2004854qte.81.2020.01.29.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/20] btrfs: do async reclaim for data reservations
Date:   Wed, 29 Jan 2020 18:50:23 -0500
Message-Id: <20200129235024.24774-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |   3 +-
 fs/btrfs/disk-io.c    |   2 +-
 fs/btrfs/space-info.c | 109 +++++++++++++++++++++++++++++-------------
 3 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 865b24a1759e..709823a23c62 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -493,7 +493,7 @@ enum btrfs_orphan_cleanup_state {
 	ORPHAN_CLEANUP_DONE	= 2,
 };
 
-void btrfs_init_async_reclaim_work(struct work_struct *work);
+void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 
 /* fs_info */
 struct reloc_control;
@@ -917,6 +917,7 @@ struct btrfs_fs_info {
 
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
+	struct work_struct async_data_reclaim_work;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 56d0a24aec74..825242f5c3f7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2753,7 +2753,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->check_integrity_print_mask = 0;
 #endif
 	btrfs_init_balance(fs_info);
-	btrfs_init_async_reclaim_work(&fs_info->async_reclaim_work);
+	btrfs_init_async_reclaim_work(fs_info);
 
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bbdf20253180..b47eca433c62 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -832,9 +832,72 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
-void btrfs_init_async_reclaim_work(struct work_struct *work)
+static const enum btrfs_flush_state data_flush_states[] = {
+	ALLOC_CHUNK_FORCE,
+	FLUSH_DELALLOC_WAIT,
+	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
+	COMMIT_TRANS,
+};
+
+static void btrfs_async_reclaim_data_space(struct work_struct *work)
+{
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
 {
-	INIT_WORK(work, btrfs_async_reclaim_metadata_space);
+	INIT_WORK(&fs_info->async_reclaim_work,
+		  btrfs_async_reclaim_metadata_space);
+	INIT_WORK(&fs_info->async_data_reclaim_work,
+		  btrfs_async_reclaim_data_space);
 }
 
 static const enum btrfs_flush_state priority_flush_states[] = {
@@ -854,14 +917,6 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
-static const enum btrfs_flush_state data_flush_states[] = {
-	ALLOC_CHUNK_FORCE,
-	FLUSH_DELALLOC_WAIT,
-	RUN_DELAYED_IPUTS,
-	FLUSH_DELAYED_REFS,
-	COMMIT_TRANS,
-};
-
 static int priority_reclaim_space(struct btrfs_fs_info *fs_info,
 				  struct btrfs_space_info *space_info,
 				  struct reserve_ticket *ticket,
@@ -904,23 +959,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
-					struct reserve_ticket *ticket,
-					enum btrfs_reserve_flush_enum flush)
+					struct reserve_ticket *ticket)
 {
-	int ret;
-
-	/*
-	 * First see if we can reclaim pinned space before forcing a bunch of
-	 * chunk allocations.
-	 */
-	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
-		ret = priority_reclaim_space(fs_info, space_info, ticket,
-					     U64_MAX, data_flush_states,
-					     ARRAY_SIZE(data_flush_states));
-		if (!ret)
-			return;
-	}
-
 	/*
 	 * The chunk allocator will only allocate min(10% of the fs, 1gib) at a
 	 * time, but our reservation may be much larger than that threshold, so
@@ -989,6 +1029,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
 		break;
@@ -1002,10 +1043,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
 		break;
-	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
-		priority_reclaim_data_space(fs_info, space_info, ticket,
-					    flush);
+		priority_reclaim_data_space(fs_info, space_info, ticket);
 		break;
 	default:
 		ASSERT(0);
@@ -1054,6 +1093,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
@@ -1062,6 +1102,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
@@ -1091,7 +1136,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1099,8 +1145,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
 							  "enospc");
-				queue_work(system_unbound_wq,
-					   &fs_info->async_reclaim_work);
+				queue_work(system_unbound_wq, async_work);
 			}
 		} else {
 			list_add_tail(&ticket.list,
-- 
2.24.1

