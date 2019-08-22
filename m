Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9899F80
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbfHVTLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45807 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so6112420qki.12
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jo6UDQHALNv+EwzXafLqFqVdzqvJ+aDClaqqQOQU604=;
        b=qPgGcMNdVOT4HI4lMGOnYCw+m+e0OylmONBWOmWe9FqPd2nTzrn2kI5ANizpOrZp6k
         n6ArzDHgIXtj3cQh4QBZkSh0Xu37qR2VVZrEAWeWd3DAzszDvnyksckKGpniw8CCC92e
         Vq1KEtz0Efadou61Hc1aJhzJWVH8jKM8xMsoJv7UrMumOf9a039aExDYHIW2bpd7lS6o
         +8xBmypQEtARMdY5wZ/VNYplHCEeQryvBw/qqzmykw6mKBSj247BkvZ1i4t2DT+KvOtI
         rStYO9HTGQ08PRxlvxm7CyA44cU4LDWkiA5es9Y0y+R6dOUZb8kLoho0c9punM3spZHC
         v4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jo6UDQHALNv+EwzXafLqFqVdzqvJ+aDClaqqQOQU604=;
        b=aVuxmLOnxd3GlZ92k5Me7lhE39Bzf3xj24Hw4OBVWcvZYsXToXBynSK2qkIgM+wCRC
         3r5iQ8c6/Sx+4V7yyMCzjVdKRzxZfOgoJmNhRtPHq9SeExHw9CAUNm2z1W6lFNibRT7j
         s+mtZX+xQ2WULrMwAofbYf+4x0GK1JTg/DUqkrdDmhAsP2OxqMvzb4DBrRYUd7EF7uiN
         dVk1ieC1Cl2kJZVdRdG0iVyMagAHvc9smztuHxPQU1nmGnRzGtlPDR7l4zt5uigrOSnH
         VvofzxyqTXJh0m+Nwio/sJ/5Gn8I4HBDqKP12K+j+SqQrVBoqs+seAN6hFCEITEeUYTI
         naPA==
X-Gm-Message-State: APjAAAUdV6XU3dRaZ/Xp/XUoizoa5CH+xVo/2dxYROUR+AvDBiN+rPbV
        YvU32RC5qaxdLT2TcCZUpbOgmA==
X-Google-Smtp-Source: APXvYqzz5xXwqtxIUg7te0DQHCD8TZC20OnZWFx0/7DfydbABDI1v6u4IV14Gv4civzJoIwE7iJoRA==
X-Received: by 2002:a37:4c4e:: with SMTP id z75mr512208qka.195.1566501074148;
        Thu, 22 Aug 2019 12:11:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q28sm298260qtk.34.2019.08.22.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/9] btrfs: refactor the ticket wakeup code
Date:   Thu, 22 Aug 2019 15:10:58 -0400
Message-Id: <20190822191102.13732-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that btrfs_space_info_add_old_bytes simply checks if we can make the
reservation and updates bytes_may_use, there's no reason to have both
helpers in place.  Factor out the ticket wakeup logic into it's own
helper, make btrfs_space_info_add_old_bytes() update bytes_may_use and
then call the wakeup helper, and replace all calls to
btrfs_space_info_add_new_bytes() with the wakeup helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c |  4 +--
 fs/btrfs/space-info.c  | 55 ++++--------------------------------------
 fs/btrfs/space-info.h  | 19 ++++++++++-----
 3 files changed, 20 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8c3e8fdbf2c1..2a56232309a3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2866,8 +2866,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			spin_unlock(&global_rsv->lock);
 			/* Add to any tickets we may have */
 			if (len)
-				btrfs_space_info_add_new_bytes(fs_info,
-						space_info, len);
+				btrfs_try_granting_tickets(fs_info,
+							   space_info);
 		}
 		spin_unlock(&space_info->lock);
 	}
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 357fe7548e07..c2143ddb7f4a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -131,9 +131,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_readonly += bytes_readonly;
 	if (total_bytes > 0)
 		found->full = 0;
-	btrfs_space_info_add_new_bytes(info, found,
-				       total_bytes - bytes_used -
-				       bytes_readonly);
+	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
 	*space_info = found;
 }
@@ -229,17 +227,15 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
  * This is for space we already have accounted in space_info->bytes_may_use, so
  * basically when we're returning space from block_rsv's.
  */
-void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes)
+void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info)
 {
 	struct list_head *head;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
 
-	spin_lock(&space_info->lock);
-	head = &space_info->priority_tickets;
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
+	lockdep_assert_held(&space_info->lock);
 
+	head = &space_info->priority_tickets;
 again:
 	while (!list_empty(head)) {
 		struct reserve_ticket *ticket;
@@ -268,47 +264,6 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
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
-			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      ticket->bytes);
-			ticket->bytes = 0;
-			space_info->tickets_id++;
-			wake_up(&ticket->wait);
-		} else {
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
 }
 
 #define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 025f7ce2c9b1..0e805b5b1fca 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -110,12 +110,6 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
-void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes);
-void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 num_bytes);
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
@@ -133,5 +127,18 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 				 struct btrfs_block_rsv *block_rsv,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
+void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info);
+
+static inline void
+btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
+			       struct btrfs_space_info *space_info,
+			       u64 num_bytes)
+{
+	spin_lock(&space_info->lock);
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
+	btrfs_try_granting_tickets(fs_info, space_info);
+	spin_unlock(&space_info->lock);
+}
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.21.0

