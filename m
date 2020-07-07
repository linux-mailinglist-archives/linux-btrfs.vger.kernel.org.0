Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC172172C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgGGPnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D6C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w34so12025897qte.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwKnkctBatP8mq5wuRxIhxJyvILH7ub1QqZQoCTgCGo=;
        b=tw0ajwnx4uZkA6D7ysZyc5g3p6DA45yXLjzgQYwXJM5wMi/I0BcsDEzgKiz1M2/w+t
         6a7b5gyWLz05+lN18LYRqaiNSv7D313ymRTIum6oXYzuCjuWrFbCMoMyzVqIIgib2pn2
         eCmrpGTmlN0Kwj99s0q1vUrotwqUyxAP3NDWZRDIqgrcGcJ008gvsJ7b52gfrRjrR6Kq
         YjGVuNZkmgIp99al32slbyLQXVLZOL/+MMcX6/OynewIqmxFt23fvSzNP29is1P0/gaa
         wkZkYtYC+/PUAwNyu7iBzqfNKLTTYi3SKcWdrZZhGamZSIGkQ+l9tuuu+2O8byzHRDwC
         eBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwKnkctBatP8mq5wuRxIhxJyvILH7ub1QqZQoCTgCGo=;
        b=h2zlzmnGMsfEIi34Uw9EpcXvtoRqpC0efOIGhmeA7PB4nSN26aadm+TSEFWDmYB7Is
         jN9kBebe74c3wlL67dRNpMxkKUiBGD3sswuClAGHnJg4EUTKX5HU0+Bpc/Tra1B7CMqR
         Ivmg0NKQe27zUgPy2Pp0bCQmFTMNo1nZjmyTsqVsJFY+wMlLOMivlMckgsYjhQQd+lKz
         BCEnKAC89daBCKpg5kf7KddxU6MEBrGgfHrhdcRX0sYSH+uS74+AzVCYPD77OGYbFDb/
         XvSOotTRcLl6wUBqQG/wrAR7KC/6pVMs+xeQqApE9q2uLHBlKOtx4X+Xg1Z8GlJB1pLd
         nPKA==
X-Gm-Message-State: AOAM5308iRi+OkK6qVVMvE0AubPMa1c7xD3Q6O6KB9jIt2gcVKjTG3BT
        DKtLrdNz4/y+yPFUyO3nBP3Y1v6f3MJcFg==
X-Google-Smtp-Source: ABdhPJzeeG4uChCZgULpUSyxQPraWxdai9VyDgjKm+mps7qGNkk7V6IBLYGqhhrTHRIHpCckhdPOGw==
X-Received: by 2002:aed:2a75:: with SMTP id k50mr53586461qtf.27.1594136611727;
        Tue, 07 Jul 2020 08:43:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t5sm24215973qkh.46.2020.07.07.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 22/23] btrfs: do async reclaim for data reservations
Date:   Tue,  7 Jul 2020 11:42:45 -0400
Message-Id: <20200707154246.52844-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
index db0eebe6758b..bc99864c30d9 100644
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

