Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D528F4AB73
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfFRUJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36331 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so9450641qkl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ds3DJXe4SzDWjCjgRNs2Qs0KISNhosxavfe01HqXFcc=;
        b=vQD1D+lo7SGjG5CHKvuaH9hNdhIZ4SZA0QMZTkUsUvkufNsEDguuYPQKjnt5+b3qf5
         coDYESyq2sFf2HD2vRww6FUCzNtQbjjHr1dom/v52sGaw5vJEnRFMFD47J4rmj1Xxpp7
         jsu4p6W3OK2Dzn21XmlmsxRDt09dq834Xqd1ugiA0xBs9WZFILSlUgq8e5Gp0irif4+D
         j04G99a8XfXwH+XSIhCGcYaSgGzwJYXgGZLjCFxvxLJ/FwgH0bLNkc9tX0dt4vlEs85r
         RKROLiAfGtdF1A0HKL3L2kTqeJb7TImPf1HGhwbZv7IgewQ9d+6wEN4j/G7UHpfp5/BQ
         fbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ds3DJXe4SzDWjCjgRNs2Qs0KISNhosxavfe01HqXFcc=;
        b=nOQLqZ7Qwguv5itnrB0yOXdI4m/Uj9hpwgAXkHIi4b9l9OCRDgCnMJfVw3P0WQF7cw
         fQSbo2LW/v6qcXaN+ZJ4nu/tHKgLHTk1q1h3NwQrbmvpZtZet3663bM7oxPpH3ewMt3g
         RZdxiUvbw+bZB75CaEo4mpzb1wKOFEp4srSrUnO0FO2mXS07WYxrfAJma8TU3ANMMzJt
         /Lq1quoFM3rzDpgIMD1SOJjU7ywN9+6HYNp5qPDMigZ91uiqeSFIWqY0FdsaXx/MPq6b
         AiDTBMLc8Est3RXQzlfPzuz9aRxD7w7/iXboGGr0GcUrSZfUA6E+tmmXhesZ5xSNlocL
         pABA==
X-Gm-Message-State: APjAAAU8wza9BPZNbyFAQ2XOq02kElmKf8OIbGGFeBUGAyD0DS2R0C9u
        eQmYdA+t0ExGP3B10lsjSIiO2u4Pf+rZgg==
X-Google-Smtp-Source: APXvYqy41VogYJAuenylyHL4zMdBtGxEm3PwP/uXrbHUI8ILRYYBPUfansqJqXXqawm7l+lTSNZKMA==
X-Received: by 2002:a37:6258:: with SMTP id w85mr83634794qkb.40.1560888580457;
        Tue, 18 Jun 2019 13:09:40 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o17sm6664336qkm.6.2019.06.18.13.09.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: move the space info update macro to space-info.h
Date:   Tue, 18 Jun 2019 16:09:21 -0400
Message-Id: <20190618200926.3352-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also rename it to btrfs_space_info_update_* so it's clear what we're
updating.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 68 +++++++++++++++++++++++---------------------------
 fs/btrfs/space-info.h  | 22 ++++++++++++++++
 2 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6eebfa5df53c..4ed194f4f60f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,26 +32,6 @@
 
 #undef SCRAMBLE_DELAYED_REFS
 
-/*
- * Declare a helper function to detect underflow of various space info members
- */
-#define DECLARE_SPACE_INFO_UPDATE(name)					\
-static inline void update_##name(struct btrfs_fs_info *fs_info,		\
-				 struct btrfs_space_info *sinfo,	\
-				 s64 bytes)				\
-{									\
-	lockdep_assert_held(&sinfo->lock);				\
-	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
-	if (bytes < 0 && sinfo->name < -bytes) {			\
-		WARN_ON(1);						\
-		sinfo->name = 0;					\
-		return;							\
-	}								\
-	sinfo->name += bytes;						\
-}
-
-DECLARE_SPACE_INFO_UPDATE(bytes_may_use);
-DECLARE_SPACE_INFO_UPDATE(bytes_pinned);
 
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_node *node, u64 parent,
@@ -4054,7 +4034,7 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 					      data_sinfo->flags, bytes, 1);
 		return -ENOSPC;
 	}
-	update_bytes_may_use(fs_info, data_sinfo, bytes);
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      data_sinfo->flags, bytes, 1);
 	spin_unlock(&data_sinfo->lock);
@@ -4107,7 +4087,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 
 	data_sinfo = fs_info->data_sinfo;
 	spin_lock(&data_sinfo->lock);
-	update_bytes_may_use(fs_info, data_sinfo, -len);
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      data_sinfo->flags, len, 0);
 	spin_unlock(&data_sinfo->lock);
@@ -4949,13 +4929,15 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * If not things get more complicated.
 	 */
 	if (used + orig_bytes <= space_info->total_bytes) {
-		update_bytes_may_use(fs_info, space_info, orig_bytes);
+		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
+						      orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
 	} else if (btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush,
 					system_chunk)) {
-		update_bytes_may_use(fs_info, space_info, orig_bytes);
+		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
+						      orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 					      space_info->flags, orig_bytes, 1);
 		ret = 0;
@@ -5286,7 +5268,7 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	update_bytes_may_use(fs_info, space_info, -num_bytes);
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 	trace_btrfs_space_reservation(fs_info, "space_info",
 				      space_info->flags, num_bytes, 0);
 	spin_unlock(&space_info->lock);
@@ -5314,8 +5296,9 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 						      ticket->bytes, 1);
 			list_del_init(&ticket->list);
 			num_bytes -= ticket->bytes;
-			update_bytes_may_use(fs_info, space_info,
-					     ticket->bytes);
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      ticket->bytes);
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
@@ -5323,7 +5306,9 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 			trace_btrfs_space_reservation(fs_info, "space_info",
 						      space_info->flags,
 						      num_bytes, 1);
-			update_bytes_may_use(fs_info, space_info, num_bytes);
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      num_bytes);
 			ticket->bytes -= num_bytes;
 			num_bytes = 0;
 		}
@@ -5616,14 +5601,16 @@ static void update_global_block_rsv(struct btrfs_fs_info *fs_info)
 			num_bytes = min(num_bytes,
 					block_rsv->size - block_rsv->reserved);
 			block_rsv->reserved += num_bytes;
-			update_bytes_may_use(fs_info, sinfo, num_bytes);
+			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+							      num_bytes);
 			trace_btrfs_space_reservation(fs_info, "space_info",
 						      sinfo->flags, num_bytes,
 						      1);
 		}
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
-		update_bytes_may_use(fs_info, sinfo, -num_bytes);
+		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+						      -num_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
 				      sinfo->flags, num_bytes, 0);
 		block_rsv->reserved = block_rsv->size;
@@ -6086,7 +6073,9 @@ static int update_block_group(struct btrfs_trans_handle *trans,
 			old_val -= num_bytes;
 			btrfs_set_block_group_used(&cache->item, old_val);
 			cache->pinned += num_bytes;
-			update_bytes_pinned(info, cache->space_info, num_bytes);
+			btrfs_space_info_update_bytes_pinned(info,
+							     cache->space_info,
+							     num_bytes);
 			cache->space_info->bytes_used -= num_bytes;
 			cache->space_info->disk_used -= num_bytes * factor;
 			spin_unlock(&cache->lock);
@@ -6161,7 +6150,8 @@ static int pin_down_extent(struct btrfs_block_group_cache *cache,
 	spin_lock(&cache->space_info->lock);
 	spin_lock(&cache->lock);
 	cache->pinned += num_bytes;
-	update_bytes_pinned(fs_info, cache->space_info, num_bytes);
+	btrfs_space_info_update_bytes_pinned(fs_info, cache->space_info,
+					     num_bytes);
 	if (reserved) {
 		cache->reserved -= num_bytes;
 		cache->space_info->bytes_reserved -= num_bytes;
@@ -6370,7 +6360,8 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	} else {
 		cache->reserved += num_bytes;
 		space_info->bytes_reserved += num_bytes;
-		update_bytes_may_use(cache->fs_info, space_info, -ram_bytes);
+		btrfs_space_info_update_bytes_may_use(cache->fs_info,
+						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
 	}
@@ -6526,7 +6517,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&space_info->lock);
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
-		update_bytes_pinned(fs_info, space_info, -len);
+		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
+						     -len);
 
 		trace_btrfs_space_reservation(fs_info, "pinned",
 					      space_info->flags, len, 0);
@@ -6547,8 +6539,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				to_add = min(len, global_rsv->size -
 					     global_rsv->reserved);
 				global_rsv->reserved += to_add;
-				update_bytes_may_use(fs_info, space_info,
-						     to_add);
+				btrfs_space_info_update_bytes_may_use(fs_info,
+								      space_info,
+								      to_add);
 				if (global_rsv->reserved >= global_rsv->size)
 					global_rsv->full = 1;
 				trace_btrfs_space_reservation(fs_info,
@@ -10808,7 +10801,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 
-		update_bytes_pinned(fs_info, space_info, -block_group->pinned);
+		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
+						     -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 				   -block_group->pinned,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c1f48f548cb6..800a02e54ac0 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -77,6 +77,28 @@ static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
 }
+/*
+ *
+ * Declare a helper function to detect underflow of various space info members
+ */
+#define DECLARE_SPACE_INFO_UPDATE(name)					\
+static inline void							\
+btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
+			       struct btrfs_space_info *sinfo,		\
+			       s64 bytes)				\
+{									\
+	lockdep_assert_held(&sinfo->lock);				\
+	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
+	if (bytes < 0 && sinfo->name < -bytes) {			\
+		WARN_ON(1);						\
+		sinfo->name = 0;					\
+		return;							\
+	}								\
+	sinfo->name += bytes;						\
+}
+
+DECLARE_SPACE_INFO_UPDATE(bytes_may_use);
+DECLARE_SPACE_INFO_UPDATE(bytes_pinned);
 
 void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
-- 
2.14.3

