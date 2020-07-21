Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660BD228209
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgGUOXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgGUOXW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7CC0619DA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so9206024qka.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMgFo4oJ+aQBwfV4aYAv+49uviAup6S9GkrB1A+o2Q4=;
        b=1X73USoKypau4NtgPOLnLSx7EnsCdcANnsqgocRzI1qRFylRHpZgCn08HRprIuHmHP
         PRw5lbIDeMNPI1GhUymPj5jDuSEu7WIzRtHHYmb65MxQ1amTglFqQ+AOsv8LaXmIe7RI
         Y79dhzMZHbI+H3kHkztGpq1eW2EBq8p17zNuBs5+0PEX59J+yCQRvix6XAbJ3pAHa6JB
         o+7qA7gkGEZ+b56Zbto2Wfs1N3XlmOgslas/Pk6Ls1vFuj1MRM4aSP4TzQVTnrr4nBfg
         25jqabblsHfBLDSw4+VLeVCSXw9legNpwfyui2i0SFAYzv4ORz6NezEfu2FHwJf9Pg/3
         1veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMgFo4oJ+aQBwfV4aYAv+49uviAup6S9GkrB1A+o2Q4=;
        b=lOO6I82o3+jtRFOmm3xWtWOaGH9uVsnFp17pmCvIfzcbxzBH4H5xriWQSd+quMATkb
         DQAC6uEqrlawlEV1c71i8UVKA1FbqYxgBzwNp+pgemnTnc32vvFwksAD574Pw3BzNcT3
         kl/O8T/L7HVMYbRy3r9/e7P9Ut9zWjPP9gbooQ/FY0WkF/rYRLyf8EcA2aVgHxx0TdT6
         yNMZUvXkavd49yvhEiTWJEu5k6WD6MieYgx4xyWmW/dlYIm+qsK9UGvihBUF6yCaAPbz
         thb8LE0CYXEVhdbHOEYWCx384xSNEpRQteeIC6OESfTh3DZ+lzdD7ji1udr0f2pAr/DA
         w1MQ==
X-Gm-Message-State: AOAM532Pjzv+zC4p+w63ERWsJn5Am0ETFy1o/w3z8z5AhFhCMrZLMCDd
        54YpiQEJG5YWxuRvIoXiXvNpg1BcQV2tkQ==
X-Google-Smtp-Source: ABdhPJyFDIf+19bh1EtL87DOf1CRE54MBpUESDKhCPHwAKq4LlxdqBTdv1WVgIXueZkELjCMRIQ6DQ==
X-Received: by 2002:a05:620a:222c:: with SMTP id n12mr26581621qkh.210.1595341399901;
        Tue, 21 Jul 2020 07:23:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c70sm2311005qke.109.2020.07.21.07.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 22/23] btrfs: do async reclaim for data reservations
Date:   Tue, 21 Jul 2020 10:22:33 -0400
Message-Id: <20200721142234.2680-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index a181f4959a1d..50592567e512 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -494,7 +494,7 @@ enum btrfs_orphan_cleanup_state {
 	ORPHAN_CLEANUP_DONE	= 2,
 };
 
-void btrfs_init_async_reclaim_work(struct work_struct *work);
+void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 
 /* fs_info */
 struct reloc_control;
@@ -912,6 +912,7 @@ struct btrfs_fs_info {
 
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
+	struct work_struct async_data_reclaim_work;
 
 	spinlock_t unused_bgs_lock;
 	struct list_head unused_bgs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c850d7f44fbe..fb2e171df9e0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2775,7 +2775,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->check_integrity_print_mask = 0;
 #endif
 	btrfs_init_balance(fs_info);
-	btrfs_init_async_reclaim_work(&fs_info->async_reclaim_work);
+	btrfs_init_async_reclaim_work(fs_info);
 
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
@@ -4078,6 +4078,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_cleanup_defrag_inodes(fs_info);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
+	cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index fce61f800150..680218a7b0e5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -998,9 +998,83 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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
@@ -1020,13 +1094,6 @@ static const enum btrfs_flush_state evict_flush_states[] = {
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
@@ -1059,12 +1126,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
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
@@ -1074,17 +1137,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -1139,6 +1191,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
@@ -1153,14 +1206,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -1225,6 +1272,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
@@ -1233,6 +1281,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
@@ -1274,7 +1327,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
-		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
+		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1282,8 +1336,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
index 58f890f73650..00c11f18d003 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1852,6 +1852,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 * the filesystem is busy.
 		 */
 		cancel_work_sync(&fs_info->async_reclaim_work);
+		cancel_work_sync(&fs_info->async_data_reclaim_work);
 
 		btrfs_discard_cleanup(fs_info);
 
-- 
2.24.1

