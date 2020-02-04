Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB151151E32
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBDQUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34077 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgBDQUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so8828824qvf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hW4vjXb3jtMaL6CtU/Qmu5BGe3aHPlhzeIoayWrO0o=;
        b=pMr6ewWmntzBjEsX+xKLbft5z04lshmSPPXWtDLFwZ9s6FA/7O3aG7AVFz0qHIpgNM
         qsr6j359UgMAmmhFRZamfWF9DtHrCIYA52jb2LAIUH1C9NhVdRSGNSv3dYqDv7QnY/7G
         687hXoRGPQFgd7r76tcekdvaXozi9DnhCtRi8DAGMFwmLTxBxCnE8rSiTHMMBrNVMMU9
         1uwtLMPeWYvYZg/lOUU0KlJBhbgmd9SCLr9wVRqcZ8QAR/rt4MNGgJO7Nw9znnpRMZDJ
         GRUg64Vm6drJOn0pARyLfIKi2dx64DItE7hH5aDtv3tWpPn6bjeNH83b0zW5lKIubvox
         OxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hW4vjXb3jtMaL6CtU/Qmu5BGe3aHPlhzeIoayWrO0o=;
        b=fnD/Pedh4Da3eeri/AhfuwDwa7pEamKzE7GrIMTjfNW65c5cTCDyS+KjUobvOEzBJy
         wj29b+Aw3sNj08fVjNraT4VfhASjIyhHAYLxZOA7OSZIsxnNUk4hqHcqwOAIbOcoOEHZ
         cWViU3emlzd0dLEueNb8EpXY1Og6Wv1cH6kbq+61fBA/qC2TmNMyeS54l3rstpShHzLG
         e+dR4rPlpwwKVXvIigHCp+bs/s/zEBQ8SlUk5MkDhiJxAd1k+0umfG0xwH+mhOjW5uIw
         Qye7CZ8ao8ZQ3P4s8f5Q9aoQHk+FDwTlCCAnKLj/++y47LoRCO9oasu8r4O7pOQtMm7Z
         0c7w==
X-Gm-Message-State: APjAAAVbpnjbZXytjGg0+FSYpCU0HwXGto1Uhfv0GlJbbPCTw9ehwZG3
        zIyDco+7WEDsKA71Lx0IyxUJd5Yg2ccI4g==
X-Google-Smtp-Source: APXvYqyJwSLBHw/2jMQpaBeneIRmWnblhKsiqvCPNjcloE44aKfBpmWAlnc4JDFQVGgkAO+8mRR8Tw==
X-Received: by 2002:a05:6214:13a3:: with SMTP id h3mr28475718qvz.212.1580833230253;
        Tue, 04 Feb 2020 08:20:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k7sm11893700qtd.79.2020.02.04.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 22/23] btrfs: do async reclaim for data reservations
Date:   Tue,  4 Feb 2020 11:19:50 -0500
Message-Id: <20200204161951.764935-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
index 56d0a24aec74..67981138d250 100644
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
@@ -4006,6 +4006,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_cleanup_defrag_inodes(fs_info);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
+	cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8d5d57d4aba3..18a31d96bbbd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -780,9 +780,83 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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
@@ -802,13 +876,6 @@ static const enum btrfs_flush_state evict_flush_states[] = {
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
@@ -841,12 +908,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
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
@@ -856,17 +919,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -921,6 +973,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
 		break;
@@ -934,14 +987,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -990,6 +1037,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
@@ -998,6 +1046,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
@@ -1027,7 +1080,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1035,8 +1089,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
index d421884f0c23..f4cdfd42eafd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1796,6 +1796,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 * the filesystem is busy.
 		 */
 		cancel_work_sync(&fs_info->async_reclaim_work);
+		cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 		btrfs_discard_cleanup(fs_info);
 
-- 
2.24.1

