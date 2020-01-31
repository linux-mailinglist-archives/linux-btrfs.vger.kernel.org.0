Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451E614F4E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgAaWg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40252 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAaWg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id t204so8213826qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F1kgxxdEuvekc6AuLbOv+zeBfkBqv+pniLCWvc0BX5Q=;
        b=LiQbawZ5rSoXlwSb99XhMJ5ovjr1aYHCR0yJcB9oUarXiTOhI3onhfIMPwDKOBJR+l
         9jBaH3Zvrrsx3N4WzUWPUMd6qg2HJSGnt1LSgQvLRMy4VGjASzcjWR5x2mA0JmlBZn3E
         AcCCLlQHeTVOvNjZqJJnjZvppBcfR/JSTdfuL8ZJaeyGXRT0RD64d1CUTXbkjhlzPbXj
         1onZc/6JbpmA8pxw1cWEgEQ5Tok5KRAnRnnvKYL2/ADLrlUkN5bBBeEGjkGDvLmNaZX+
         d4RRUnkOTbuXDv3EXXdg6Enqi+4JEF1hTErGwRSDVFwAzkAAl7i1tv8VCUHc/4ZqBf5s
         88Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1kgxxdEuvekc6AuLbOv+zeBfkBqv+pniLCWvc0BX5Q=;
        b=VdSa8hM4KsFOdKGsjo6uJ9EsgFz5Abc0F9cq2t0IZyIhK5h70X6tFISWpUmBEj3X/T
         AX7C6El6mv/Rv/uAYwnV0o1viV+wujHK+4Y6RWNkiee6ji5MvFPb/T+ZZZuQh5L7IuwI
         zGcGn0Tj7v9M6U8jrng6msluv+adBwI3jkdbJZFkhZ/Qa33HrMTrfScdGlNEIUhPnXZL
         wpvrsfxmZwnTO6avmxQpFZRCIJaKxXUWsGZ7vkUg+lwoosVDmjXlECaxjBA0OtgR0Uad
         rMbjm4i1whgKADm/68WVPNOrgTFpAzNYFvIT3MfucMdPE5WAU8N5hsPjZUvctq8/7BER
         bd0g==
X-Gm-Message-State: APjAAAVniqsKpwu7zhMREFOaXujRFqB34hPJKMuSbDblomMNcx2Rh9zb
        3AvddNzYpsP+ipJXTIMotHBwAPdnwOROGw==
X-Google-Smtp-Source: APXvYqwUOvGWn+Zz6CL6P6fowPiaxXA6C8UdKIG+9SKSi03XiMgUV64KYcLIo6tlG/ule+GAH+nJpA==
X-Received: by 2002:a05:620a:1522:: with SMTP id n2mr13232754qkk.108.1580510216121;
        Fri, 31 Jan 2020 14:36:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e13sm5714559qtq.26.2020.01.31.14.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: do async reclaim for data reservations
Date:   Fri, 31 Jan 2020 17:36:13 -0500
Message-Id: <20200131223613.490779-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 123 ++++++++++++++++++++++++++++++------------
 3 files changed, 91 insertions(+), 37 deletions(-)

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
index 5b0dc1046daa..4249a6711200 100644
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
@@ -840,12 +907,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
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
@@ -855,17 +918,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -920,6 +972,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_DATA:
 	case BTRFS_RESERVE_FLUSH_ALL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
 		break;
@@ -933,14 +986,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -989,6 +1036,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
@@ -997,6 +1045,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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
@@ -1026,7 +1079,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
@@ -1034,8 +1088,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

