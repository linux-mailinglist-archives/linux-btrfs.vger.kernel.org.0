Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBF4AB76
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfFRUJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44886 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so9402907qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=pSoPf9whKTMAO6LvDkoJtS6tbUiy40RYGfdvWZT3aBk=;
        b=JxZ+pcFOxsIKtcAHB9cwqTnmOYXw/r69R414YJikHIvdt3kJql9U+83yGAhCfYE8p5
         wcujnZ65S3OuZ7Sck0tNz3tzESD5tgHWLVsasKNpc0uz/yd1bm9s7qGnAE5noyNw+ED9
         qTyT6vm1yeFyECQl2ov/N6nFy/GbTb3VB2aE5kjw5+e0e01lgFoU59lqG6x8iiKPvvKU
         bMqiT0VXKABfhrEqX/0Aw5qDo2PEbNF+uGQNmG1YkVmjKtL+v6tKhKxemvXkAScqFcKc
         XIYQ4ysixJpyk+qVegsuXvPV9wJuooTCOUpA8c/PBCvC6aqOllt1pymHrh+SQ6kLtTL1
         m5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=pSoPf9whKTMAO6LvDkoJtS6tbUiy40RYGfdvWZT3aBk=;
        b=qKmGMHDM69d07XqnKcpxIBKkB17jFPMbKYuYwpkGL132u1jqkVSdGBMK0O9YWywSkp
         glaX8TMffh+HQd7R9JrPAllY2POpGrUJQY11wk4q9plWsL3QEdBG0yAv00eV3q4/c6QD
         sv/ZSB3IcoElJwJAG7fym6k3JO3japMJN26/urHYaa1t99pzNCQ+SdRK3QCPus2fn8KP
         kRBT1o/lUujnAInc+ZOgCN5P7xswDF0fVSCPlgKcsu2c3J99kvZoMIJT66PkdzTdrJjY
         WZMUu+enwo7m9FW6ulkxPtfBcDDRxa52sxVD3ZhoAa9rJCsaH6Jpjal2XV7F/JTw2GHh
         vJfA==
X-Gm-Message-State: APjAAAVdj0gk7OrN2XeHJR0DX5vKHDDwBe/nRX8EbUtSCjbij9fJL+SO
        Kt1dC4zvvlE+yVY1/KDOKJCv7FkqyfOjYg==
X-Google-Smtp-Source: APXvYqxDqjO4T+BvVhC1eJllXptC+XE4Q8DBhzGjvoPsxvHCendt2kKPYhd3i9g6/amCFm8sIPIPfw==
X-Received: by 2002:a37:4e92:: with SMTP id c140mr96757681qkb.48.1560888585666;
        Tue, 18 Jun 2019 13:09:45 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z18sm10837019qka.12.2019.06.18.13.09.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: move dump_space_info to space-info.c
Date:   Tue, 18 Jun 2019 16:09:24 -0400
Message-Id: <20190618200926.3352-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We'll need this exported so we can use it in all the various was we need
to use it.  This is prep work to move reserve_metadata_bytes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 70 +++++---------------------------------------------
 fs/btrfs/space-info.c  | 55 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  3 +++
 3 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d21ee7af1e3e..4e1e664d36b3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -50,9 +50,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_extent_op *extent_op);
 static int find_next_key(struct btrfs_path *path, int level,
 			 struct btrfs_key *key);
-static void dump_space_info(struct btrfs_fs_info *fs_info,
-			    struct btrfs_space_info *info, u64 bytes,
-			    int dump_block_groups);
 
 static noinline int
 block_group_cache_done(struct btrfs_block_group_cache *cache)
@@ -4196,7 +4193,7 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
 			   left, thresh, type);
-		dump_space_info(fs_info, info, 0, 0);
+		btrfs_dump_space_info(fs_info, info, 0, 0);
 	}
 
 	if (left < thresh) {
@@ -5040,8 +5037,8 @@ static int reserve_metadata_bytes(struct btrfs_root *root,
 					      orig_bytes, 1);
 
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			dump_space_info(fs_info, block_rsv->space_info,
-					orig_bytes, 0);
+			btrfs_dump_space_info(fs_info, block_rsv->space_info,
+					      orig_bytes, 0);
 	}
 	return ret;
 }
@@ -7653,60 +7650,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-#define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
-do {									\
-	struct btrfs_block_rsv *__rsv = &(fs_info)->rsv_name;		\
-	spin_lock(&__rsv->lock);					\
-	btrfs_info(fs_info, #rsv_name ": size %llu reserved %llu",	\
-		   __rsv->size, __rsv->reserved);			\
-	spin_unlock(&__rsv->lock);					\
-} while (0)
-
-static void dump_space_info(struct btrfs_fs_info *fs_info,
-			    struct btrfs_space_info *info, u64 bytes,
-			    int dump_block_groups)
-{
-	struct btrfs_block_group_cache *cache;
-	int index = 0;
-
-	spin_lock(&info->lock);
-	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
-		   info->flags,
-		   info->total_bytes - btrfs_space_info_used(info, true),
-		   info->full ? "" : "not ");
-	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
-		info->total_bytes, info->bytes_used, info->bytes_pinned,
-		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly);
-	spin_unlock(&info->lock);
-
-	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
-	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
-
-	if (!dump_block_groups)
-		return;
-
-	down_read(&info->groups_sem);
-again:
-	list_for_each_entry(cache, &info->block_groups[index], list) {
-		spin_lock(&cache->lock);
-		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
-			cache->key.objectid, cache->key.offset,
-			btrfs_block_group_used(&cache->item), cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
-		btrfs_dump_free_space(cache, bytes);
-		spin_unlock(&cache->lock);
-	}
-	if (++index < BTRFS_NR_RAID_TYPES)
-		goto again;
-	up_read(&info->groups_sem);
-}
-
 /*
  * btrfs_reserve_extent - entry point to the extent allocator. Tries to find a
  *			  hole that is at least as big as @num_bytes.
@@ -7787,7 +7730,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 				  "allocation failed flags %llu, wanted %llu",
 				  flags, num_bytes);
 			if (sinfo)
-				dump_space_info(fs_info, sinfo, num_bytes, 1);
+				btrfs_dump_space_info(fs_info, sinfo,
+						      num_bytes, 1);
 		}
 	}
 
@@ -9305,7 +9249,7 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 		btrfs_info(cache->fs_info,
 			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
 			sinfo_used, num_bytes, min_allocable_bytes);
-		dump_space_info(cache->fs_info, cache->space_info, 0, 0);
+		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
 	}
 	return ret;
 }
@@ -9787,7 +9731,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		if (WARN_ON(space_info->bytes_pinned > 0 ||
 			    space_info->bytes_reserved > 0 ||
 			    space_info->bytes_may_use > 0))
-			dump_space_info(info, space_info, 0, 0);
+			btrfs_dump_space_info(info, space_info, 0, 0);
 		list_del(&space_info->list);
 		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
 			struct kobject *kobj;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 579de5c0b5cb..4fe5f229ce68 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -7,6 +7,7 @@
 #include "space-info.h"
 #include "sysfs.h"
 #include "volumes.h"
+#include "free-space-cache.h"
 
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
@@ -349,3 +350,57 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 		goto again;
 	}
 }
+
+#define DUMP_BLOCK_RSV(fs_info, rsv_name)				\
+do {									\
+	struct btrfs_block_rsv *__rsv = &(fs_info)->rsv_name;		\
+	spin_lock(&__rsv->lock);					\
+	btrfs_info(fs_info, #rsv_name ": size %llu reserved %llu",	\
+		   __rsv->size, __rsv->reserved);			\
+	spin_unlock(&__rsv->lock);					\
+} while (0)
+
+void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
+			   struct btrfs_space_info *info, u64 bytes,
+			   int dump_block_groups)
+{
+	struct btrfs_block_group_cache *cache;
+	int index = 0;
+
+	spin_lock(&info->lock);
+	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
+		   info->flags,
+		   info->total_bytes - btrfs_space_info_used(info, true),
+		   info->full ? "" : "not ");
+	btrfs_info(fs_info,
+		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
+		info->total_bytes, info->bytes_used, info->bytes_pinned,
+		info->bytes_reserved, info->bytes_may_use,
+		info->bytes_readonly);
+	spin_unlock(&info->lock);
+
+	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
+	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
+
+	if (!dump_block_groups)
+		return;
+
+	down_read(&info->groups_sem);
+again:
+	list_for_each_entry(cache, &info->block_groups[index], list) {
+		spin_lock(&cache->lock);
+		btrfs_info(fs_info,
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			cache->key.objectid, cache->key.offset,
+			btrfs_block_group_used(&cache->item), cache->pinned,
+			cache->reserved, cache->ro ? "[readonly]" : "");
+		btrfs_dump_free_space(cache, bytes);
+		spin_unlock(&cache->lock);
+	}
+	if (++index < BTRFS_NR_RAID_TYPES)
+		goto again;
+	up_read(&info->groups_sem);
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index e566a2e79d69..e2ab16e17fe1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -128,5 +128,8 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 			 struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush,
 			 bool system_chunk);
+void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
+			   struct btrfs_space_info *info, u64 bytes,
+			   int dump_block_groups);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.14.3

