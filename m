Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F34AB74
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfFRUJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41770 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so12060955qtj.8
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4Zx4+o4IBhgloviJMq79beJ2ggsz7/y+R3bDLLBVplo=;
        b=dKvJmsAo1XkGueAdHwbeKJJMuoZLQF+J2cCzB3dadjCFJGJwcT9Guvrf9zs/lpqeQK
         rBaj63kKqDfLI1n+F8vgCxByRHEBkFbHiSZEEvhBUX4DmFwjNOGLeiXTrkD1k3gzMmaj
         QANm+BUSJgDlCH32McmIxKZxoJA2eS2i2R/1BYXRm1yz/E5soLIhSZVY7h8MCgEsK2U6
         oqps4TEPAs8ce/uhHglFzYZDAnus7x3M7Zux5lOlpUnZ9QisNdJLGfjPqYjtNX6MQUoN
         AmJ7NbOPsrDzoVrSQTZ6/6K5Qxzy54h5fNhwWjwooYdV1Hwdtb2fvO1GRgLg33VoMsn1
         TAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=4Zx4+o4IBhgloviJMq79beJ2ggsz7/y+R3bDLLBVplo=;
        b=R3q820xyGytVegdUN9/ZvAEE2kU3j49HELnGkAwJbifH/2rThxiCO0gpoIuKkzfzTM
         PytrU4jPcNbdph34S7azB+2o5SUfxT8n2aUt8//WUBYzlAs9m7UW9nlAmQ0P8B7DdlZJ
         GlVfbbNIDgTOrblWJOUBX4zzxewZYS4wDNDMzqQM0Pbd8JYqye+9b9gCj71uuDIYzBhw
         dV2h9KbgCSUX0gyt1WEBCLFNh2CFbOtTJ1euN3tmE+YPeMMc6jIT2qOrdK8/b9j5fBfA
         IySErmpJ8oDSWfrPaOOyrIJcHNGpsWeVFxa8S0sAQaOsy2XibmhUnOA9rHg8+RxYRSe6
         ULVw==
X-Gm-Message-State: APjAAAUS4zLAJCx6Gzgj2/5Mi7rVwOEVtTT97LkKcNz8749xkAeyvu+u
        i8ag8sR1EqKWW0vcgpKTIBwWFWag9Cd84A==
X-Google-Smtp-Source: APXvYqwIVbizrvsiP/xe4U8mgctvuwOF0StRnxc4CV8XeAg+aD15XzTNnvqx8yKTft72w4FhBRvDTQ==
X-Received: by 2002:ac8:685:: with SMTP id f5mr27889434qth.9.1560888582386;
        Tue, 18 Jun 2019 13:09:42 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u19sm10821186qka.35.2019.06.18.13.09.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: move btrfs_space_info_add_*_bytes to space-info.c
Date:   Tue, 18 Jun 2019 16:09:22 -0400
Message-Id: <20190618200926.3352-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we've moved all the pre-requisite stuff, move these two
functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 114 -------------------------------------------------
 fs/btrfs/space-info.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |   8 ++++
 3 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4ed194f4f60f..86f5b26c0bf1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4487,14 +4487,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 }
 
-struct reserve_ticket {
-	u64 orig_bytes;
-	u64 bytes;
-	int error;
-	struct list_head list;
-	wait_queue_head_t wait;
-};
-
 /**
  * maybe_commit_transaction - possibly commit the transaction if its ok to
  * @root - the root we're allocating for
@@ -5214,112 +5206,6 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-/*
- * This is for space we already have accounted in space_info->bytes_may_use, so
- * basically when we're returning space from block_rsv's.
- */
-void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes)
-{
-	struct reserve_ticket *ticket;
-	struct list_head *head;
-	u64 used;
-	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
-	bool check_overcommit = false;
-
-	spin_lock(&space_info->lock);
-	head = &space_info->priority_tickets;
-
-	/*
-	 * If we are over our limit then we need to check and see if we can
-	 * overcommit, and if we can't then we just need to free up our space
-	 * and not satisfy any requests.
-	 */
-	used = btrfs_space_info_used(space_info, true);
-	if (used - num_bytes >= space_info->total_bytes)
-		check_overcommit = true;
-again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		/*
-		 * We use 0 bytes because this space is already reserved, so
-		 * adding the ticket space would be a double count.
-		 */
-		if (check_overcommit &&
-		    !btrfs_can_overcommit(fs_info, space_info, 0, flush,
-					  false))
-			break;
-		if (num_bytes >= ticket->bytes) {
-			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
-			ticket->bytes = 0;
-			space_info->tickets_id++;
-			wake_up(&ticket->wait);
-		} else {
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
-		}
-	}
-
-	if (num_bytes && head == &space_info->priority_tickets) {
-		head = &space_info->tickets;
-		flush = BTRFS_RESERVE_FLUSH_ALL;
-		goto again;
-	}
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      space_info->flags, num_bytes, 0);
-	spin_unlock(&space_info->lock);
-}
-
-/*
- * This is for newly allocated space that isn't accounted in
- * space_info->bytes_may_use yet.  So if we allocate a chunk or unpin an extent
- * we use this helper.
- */
-void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes)
-{
-	struct reserve_ticket *ticket;
-	struct list_head *head = &space_info->priority_tickets;
-
-again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		if (num_bytes >= ticket->bytes) {
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      space_info->flags,
-						      ticket->bytes, 1);
-			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      ticket->bytes);
-			ticket->bytes = 0;
-			space_info->tickets_id++;
-			wake_up(&ticket->wait);
-		} else {
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      space_info->flags,
-						      num_bytes, 1);
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      num_bytes);
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
-		}
-	}
-
-	if (num_bytes && head == &space_info->priority_tickets) {
-		head = &space_info->tickets;
-		goto again;
-	}
-}
-
 static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_rsv *block_rsv,
 				    struct btrfs_block_rsv *dest, u64 num_bytes,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2cb9f3b6ffc9..579de5c0b5cb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -243,3 +243,109 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 1;
 	return 0;
 }
+
+/*
+ * This is for space we already have accounted in space_info->bytes_may_use, so
+ * basically when we're returning space from block_rsv's.
+ */
+void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes)
+{
+	struct reserve_ticket *ticket;
+	struct list_head *head;
+	u64 used;
+	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
+	bool check_overcommit = false;
+
+	spin_lock(&space_info->lock);
+	head = &space_info->priority_tickets;
+
+	/*
+	 * If we are over our limit then we need to check and see if we can
+	 * overcommit, and if we can't then we just need to free up our space
+	 * and not satisfy any requests.
+	 */
+	used = btrfs_space_info_used(space_info, true);
+	if (used - num_bytes >= space_info->total_bytes)
+		check_overcommit = true;
+again:
+	while (!list_empty(head) && num_bytes) {
+		ticket = list_first_entry(head, struct reserve_ticket,
+					  list);
+		/*
+		 * We use 0 bytes because this space is already reserved, so
+		 * adding the ticket space would be a double count.
+		 */
+		if (check_overcommit &&
+		    !btrfs_can_overcommit(fs_info, space_info, 0, flush,
+					  false))
+			break;
+		if (num_bytes >= ticket->bytes) {
+			list_del_init(&ticket->list);
+			num_bytes -= ticket->bytes;
+			ticket->bytes = 0;
+			space_info->tickets_id++;
+			wake_up(&ticket->wait);
+		} else {
+			ticket->bytes -= num_bytes;
+			num_bytes = 0;
+		}
+	}
+
+	if (num_bytes && head == &space_info->priority_tickets) {
+		head = &space_info->tickets;
+		flush = BTRFS_RESERVE_FLUSH_ALL;
+		goto again;
+	}
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
+	trace_btrfs_space_reservation(fs_info, "space_info",
+				      space_info->flags, num_bytes, 0);
+	spin_unlock(&space_info->lock);
+}
+
+/*
+ * This is for newly allocated space that isn't accounted in
+ * space_info->bytes_may_use yet.  So if we allocate a chunk or unpin an extent
+ * we use this helper.
+ */
+void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes)
+{
+	struct reserve_ticket *ticket;
+	struct list_head *head = &space_info->priority_tickets;
+
+again:
+	while (!list_empty(head) && num_bytes) {
+		ticket = list_first_entry(head, struct reserve_ticket,
+					  list);
+		if (num_bytes >= ticket->bytes) {
+			trace_btrfs_space_reservation(fs_info, "space_info",
+						      space_info->flags,
+						      ticket->bytes, 1);
+			list_del_init(&ticket->list);
+			num_bytes -= ticket->bytes;
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      ticket->bytes);
+			ticket->bytes = 0;
+			space_info->tickets_id++;
+			wake_up(&ticket->wait);
+		} else {
+			trace_btrfs_space_reservation(fs_info, "space_info",
+						      space_info->flags,
+						      num_bytes, 1);
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      num_bytes);
+			ticket->bytes -= num_bytes;
+			num_bytes = 0;
+		}
+	}
+
+	if (num_bytes && head == &space_info->priority_tickets) {
+		head = &space_info->tickets;
+		goto again;
+	}
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 800a02e54ac0..e566a2e79d69 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -72,6 +72,14 @@ struct btrfs_space_info {
 	struct kobject *block_group_kobjs[BTRFS_NR_RAID_TYPES];
 };
 
+struct reserve_ticket {
+	u64 orig_bytes;
+	u64 bytes;
+	int error;
+	struct list_head list;
+	wait_queue_head_t wait;
+};
+
 static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
-- 
2.14.3

