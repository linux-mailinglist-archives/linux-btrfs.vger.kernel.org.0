Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5374AB70
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfFRUJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35688 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so17052624qto.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zDNDKlCAA/QF0bvH+pr0BZFYanMtrycs03p4GUtEF9A=;
        b=R3BRIEPAx38q7Q4Wui97qYOWc/H2i/IuidYuC3sLP+oAYF2/r5m/o8pZxbtE9ougF+
         d7rOEiWw7YQs2z9P5QrObtJclks/PYQTq1INqCWYIKwZ22tMZ1D4uttpF0lgUrZVckN6
         2qQIWj4klAan6SYnMKj8ueFy3Ol4ydprA9R1+tX2u26cg4t+vB3WPrevlBwMrBut87MB
         nPpkb/7uPZK3IPgrD1kOuWn8WV7hBUcndiiW4ykL/bCrIcLOzLsIbWl4+qBBXp2o3SzP
         RVSm4E+EUYcSJVz//aLRZHkiti1DMcFoUna3uUK2HrDptNEjxxtZREreEIq+171WcVPQ
         i7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zDNDKlCAA/QF0bvH+pr0BZFYanMtrycs03p4GUtEF9A=;
        b=gjkNkU2DTRHouZGqwFU40OFGTIksZBmahXqfxWhzc3CC1ZePR6BAYaCAVYTf4ce7+g
         XNrMe8K+RUEsEaZsVis9dMjJyk8aAr8vx7xQuOfFb4Mgx1/sMROQ4CZrHPussddTThtV
         TYQf0ESQPqMXv8PP/56PkdH/Kx7fw8dVjoNG8c00VM81uKcghxDLVpoE3nr+ahRkOWfn
         lOmU9Tb8pXe/srTp6e5+aocOCcejJ8Kbn7aUiAl+kkNmkyxhqbTkJgh5HOmwRIMWsPmh
         8Mjj9Nh8Ricg7hy69F37df7rw2Ihc5gdXEi9EHqVGyOZ85heztzo0ySlDoevvi5lXXBx
         F5Pg==
X-Gm-Message-State: APjAAAXgmwvU0q8gKczhx6u9mUTNye2DQK63rumyazJH9IgwMPGe/wFu
        WhPl7rV2hsxvaBiQ25vi/EefH5EZ+wweyg==
X-Google-Smtp-Source: APXvYqysDcNO0iBWEh0X2u91MwVuklEYO0/7mQam4oaHkvWOzjMmTHr21wiMOW22CGFIe6O1UMv8Zw==
X-Received: by 2002:aed:3b9c:: with SMTP id r28mr24995892qte.74.1560888575213;
        Tue, 18 Jun 2019 13:09:35 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z126sm9541729qkb.7.2019.06.18.13.09.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: export space_info_add_*_bytes
Date:   Tue, 18 Jun 2019 16:09:18 -0400
Message-Id: <20190618200926.3352-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prep work for consolidating all of the space_info code into one file.
We need to export these so multiple files can use them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 42 ++++++++++++++++++++----------------------
 fs/btrfs/space-info.h  |  6 ++++++
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7b4232ee48a0..9dcda96ef309 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -75,12 +75,6 @@ static void dump_space_info(struct btrfs_fs_info *fs_info,
 			    int dump_block_groups);
 static int block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
 			       u64 num_bytes);
-static void space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				     struct btrfs_space_info *space_info,
-				     u64 num_bytes);
-static void space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				     struct btrfs_space_info *space_info,
-				     u64 num_bytes);
 
 static noinline int
 block_group_cache_done(struct btrfs_block_group_cache *cache)
@@ -3908,8 +3902,8 @@ static void update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_readonly += bytes_readonly;
 	if (total_bytes > 0)
 		found->full = 0;
-	space_info_add_new_bytes(info, found, total_bytes -
-				 bytes_used - bytes_readonly);
+	btrfs_space_info_add_new_bytes(info, found, total_bytes -
+				       bytes_used - bytes_readonly);
 	spin_unlock(&found->lock);
 	*space_info = found;
 }
@@ -5110,7 +5104,8 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 
 	if (reclaim_bytes)
-		space_info_add_old_bytes(fs_info, space_info, reclaim_bytes);
+		btrfs_space_info_add_old_bytes(fs_info, space_info,
+					       reclaim_bytes);
 	return ret;
 }
 
@@ -5227,7 +5222,8 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 
 	if (reclaim_bytes)
-		space_info_add_old_bytes(fs_info, space_info, reclaim_bytes);
+		btrfs_space_info_add_old_bytes(fs_info, space_info,
+					       reclaim_bytes);
 	ASSERT(list_empty(&ticket.list));
 	return ret;
 }
@@ -5393,8 +5389,9 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 					      0, num_bytes, 1);
 	if (to_free)
-		space_info_add_old_bytes(fs_info, delayed_refs_rsv->space_info,
-					 to_free);
+		btrfs_space_info_add_old_bytes(fs_info,
+					       delayed_refs_rsv->space_info,
+					       to_free);
 }
 
 /**
@@ -5437,9 +5434,9 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
  * This is for space we already have accounted in space_info->bytes_may_use, so
  * basically when we're returning space from block_rsv's.
  */
-static void space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-				     struct btrfs_space_info *space_info,
-				     u64 num_bytes)
+void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes)
 {
 	struct reserve_ticket *ticket;
 	struct list_head *head;
@@ -5497,9 +5494,9 @@ static void space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
  * space_info->bytes_may_use yet.  So if we allocate a chunk or unpin an extent
  * we use this helper.
  */
-static void space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
-				     struct btrfs_space_info *space_info,
-				     u64 num_bytes)
+void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes)
 {
 	struct reserve_ticket *ticket;
 	struct list_head *head = &space_info->priority_tickets;
@@ -5583,8 +5580,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 			spin_unlock(&dest->lock);
 		}
 		if (num_bytes)
-			space_info_add_old_bytes(fs_info, space_info,
-						 num_bytes);
+			btrfs_space_info_add_old_bytes(fs_info, space_info,
+						       num_bytes);
 	}
 	if (qgroup_to_release_ret)
 		*qgroup_to_release_ret = qgroup_to_release;
@@ -6760,8 +6757,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			spin_unlock(&global_rsv->lock);
 			/* Add to any tickets we may have */
 			if (len)
-				space_info_add_new_bytes(fs_info, space_info,
-							 len);
+				btrfs_space_info_add_new_bytes(fs_info,
+							       space_info,
+							       len);
 		}
 		spin_unlock(&space_info->lock);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2f69cf9e13da..b3a43fe62b7c 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -78,4 +78,10 @@ static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
 		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
 }
 
+void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes);
+void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes);
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.14.3

