Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2804DA4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFTTiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:16 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33669 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id h17so1689764ybm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=qKNxN4vauy9Oj22g2eHdqg+5OsGPhaVes893N77JQT0=;
        b=y+LPXnVAjK/U5qOUxwaj1QmS3UhLcYHhjm7D5ezcV1qz5/2PY9Kvv1ntgnepTC6PX4
         ZtIWy7Rh9d/zDeVkxNP9gEfwR1r3NWqEGA5Q/WTZrOpBfbZOPup7gefaYgKkEgnCK/dQ
         NfjbfcLyo/nSM8wOr0fDi0AYZVossyr+lsLoFSUGmy14N7dVZTZiLsHd6KztFvalyhJC
         xnxUJ4XfiHmixmmBBSikq4LyEM5s5jjPfmoNmsKt0k9JrKj36tluh/WBL5nas89aC+O5
         cjVNVYcmFNYWmzOadxmrJhkW+5CreJbQFesPHxxKs1A7eIGyGL9c2uQi6KyFV5+NDIqw
         czwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=qKNxN4vauy9Oj22g2eHdqg+5OsGPhaVes893N77JQT0=;
        b=TBw2apqB9ragwEwRurUv65MMHZBUOjC/i0G3sYwFEV9T+6CfJC+eSmBkr5/mmbhpdS
         HFzH80Z/Sn3uaahbmqUImDGpNh0ZyJvgkxjNCpKJNC5PlHuxvwQHqT3JPDbNusrENuJD
         JUVLd/cXkxnhTwvzhPzA/P2ROskkXauv4EYIWhPYtJIQu9C9YMzihStD0tvsPde8Nz2z
         MIZ0UQK3SUs0dkQPE+T4WjwZynf2dEric+Vw2j60TeMKF94mQScJiQxjhPlv3Co942uh
         oCmopm6yowSljVw9DG1q+X9u2uZxHPovcZpNuVYa1j/5Xmp329pSmcyBniHk44w0mnP3
         iASQ==
X-Gm-Message-State: APjAAAXKUT4KniKUIoiitx+xfrhRdeQJ5jgIKIU5EZp7YfrueJIlcB2s
        pKeqVgfgbzhiot/DD8glzw1pzuLSIVz03A==
X-Google-Smtp-Source: APXvYqx9y8uvr3X8rkUITxUwDOSLynx3zN2Mb3US0maCTr/b3pnS0gkuOrhNLlTjI0pZb5UAcgzLfg==
X-Received: by 2002:a25:7:: with SMTP id 7mr69765988yba.83.1561059494725;
        Thu, 20 Jun 2019 12:38:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q63sm113141ywq.17.2019.06.20.12.38.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/25] btrfs: migrate the block group lookup code
Date:   Thu, 20 Jun 2019 15:37:45 -0400
Message-Id: <20190620193807.29311-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move these bits first as they are the easiest to move.  Export two of
the helpers so they can be moved all at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/block-group.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  7 ++++
 fs/btrfs/ctree.h       |  3 --
 fs/btrfs/extent-tree.c | 96 +-----------------------------------------------
 5 files changed, 109 insertions(+), 98 deletions(-)
 create mode 100644 fs/btrfs/block-group.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 76a843198bcb..82200dbca5ac 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o
+	   block-rsv.o delalloc-space.o block-group.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
new file mode 100644
index 000000000000..f56b38bbe4b4
--- /dev/null
+++ b/fs/btrfs/block-group.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+#include "ctree.h"
+#include "block-group.h"
+
+
+/*
+ * This will return the block group at or after bytenr if contains is 0, else
+ * it will return the block group that contains the bytenr
+ */
+static struct btrfs_block_group_cache *
+block_group_cache_tree_search(struct btrfs_fs_info *info, u64 bytenr,
+			      int contains)
+{
+	struct btrfs_block_group_cache *cache, *ret = NULL;
+	struct rb_node *n;
+	u64 end, start;
+
+	spin_lock(&info->block_group_cache_lock);
+	n = info->block_group_cache_tree.rb_node;
+
+	while (n) {
+		cache = rb_entry(n, struct btrfs_block_group_cache,
+				 cache_node);
+		end = cache->key.objectid + cache->key.offset - 1;
+		start = cache->key.objectid;
+
+		if (bytenr < start) {
+			if (!contains && (!ret || start < ret->key.objectid))
+				ret = cache;
+			n = n->rb_left;
+		} else if (bytenr > start) {
+			if (contains && bytenr <= end) {
+				ret = cache;
+				break;
+			}
+			n = n->rb_right;
+		} else {
+			ret = cache;
+			break;
+		}
+	}
+	if (ret) {
+		btrfs_get_block_group(ret);
+		if (bytenr == 0 && info->first_logical_byte > ret->key.objectid)
+			info->first_logical_byte = ret->key.objectid;
+	}
+	spin_unlock(&info->block_group_cache_lock);
+
+	return ret;
+}
+
+/*
+ * return the block group that starts at or after bytenr
+ */
+struct btrfs_block_group_cache *
+btrfs_lookup_first_block_group(struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 0);
+}
+
+/*
+ * return the block group that contains the given bytenr
+ */
+struct btrfs_block_group_cache *
+btrfs_lookup_block_group(struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 1);
+}
+
+struct btrfs_block_group_cache *
+btrfs_next_block_group(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct rb_node *node;
+
+	spin_lock(&fs_info->block_group_cache_lock);
+
+	/* If our block group was removed, we need a full search. */
+	if (RB_EMPTY_NODE(&cache->cache_node)) {
+		const u64 next_bytenr = cache->key.objectid + cache->key.offset;
+
+		spin_unlock(&fs_info->block_group_cache_lock);
+		btrfs_put_block_group(cache);
+		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr); return cache;
+	}
+	node = rb_next(&cache->cache_node);
+	btrfs_put_block_group(cache);
+	if (node) {
+		cache = rb_entry(node, struct btrfs_block_group_cache,
+				 cache_node);
+		btrfs_get_block_group(cache);
+	} else
+		cache = NULL;
+	spin_unlock(&fs_info->block_group_cache_lock);
+	return cache;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f3f99787af86..05e5ac134140 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -153,4 +153,11 @@ btrfs_should_fragment_free_space(struct btrfs_block_group_cache *block_group)
 }
 #endif
 
+struct btrfs_block_group_cache *
+btrfs_lookup_first_block_group(struct btrfs_fs_info *info, u64 bytenr);
+struct btrfs_block_group_cache *
+btrfs_lookup_block_group(struct btrfs_fs_info *info, u64 bytenr);
+struct btrfs_block_group_cache *
+btrfs_next_block_group(struct btrfs_block_group_cache *cache);
+
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a904115c553..5b24ea48ed84 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2483,9 +2483,6 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
 			  u64 objectid, u64 offset, u64 bytenr);
-struct btrfs_block_group_cache *btrfs_lookup_block_group(
-						 struct btrfs_fs_info *info,
-						 u64 bytenr);
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index aeb8daf2a640..b9af50d19b0d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -132,52 +132,6 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	return 0;
 }
 
-/*
- * This will return the block group at or after bytenr if contains is 0, else
- * it will return the block group that contains the bytenr
- */
-static struct btrfs_block_group_cache *
-block_group_cache_tree_search(struct btrfs_fs_info *info, u64 bytenr,
-			      int contains)
-{
-	struct btrfs_block_group_cache *cache, *ret = NULL;
-	struct rb_node *n;
-	u64 end, start;
-
-	spin_lock(&info->block_group_cache_lock);
-	n = info->block_group_cache_tree.rb_node;
-
-	while (n) {
-		cache = rb_entry(n, struct btrfs_block_group_cache,
-				 cache_node);
-		end = cache->key.objectid + cache->key.offset - 1;
-		start = cache->key.objectid;
-
-		if (bytenr < start) {
-			if (!contains && (!ret || start < ret->key.objectid))
-				ret = cache;
-			n = n->rb_left;
-		} else if (bytenr > start) {
-			if (contains && bytenr <= end) {
-				ret = cache;
-				break;
-			}
-			n = n->rb_right;
-		} else {
-			ret = cache;
-			break;
-		}
-	}
-	if (ret) {
-		btrfs_get_block_group(ret);
-		if (bytenr == 0 && info->first_logical_byte > ret->key.objectid)
-			info->first_logical_byte = ret->key.objectid;
-	}
-	spin_unlock(&info->block_group_cache_lock);
-
-	return ret;
-}
-
 static int add_excluded_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 num_bytes)
 {
@@ -672,24 +626,6 @@ static int cache_block_group(struct btrfs_block_group_cache *cache,
 	return ret;
 }
 
-/*
- * return the block group that starts at or after bytenr
- */
-static struct btrfs_block_group_cache *
-btrfs_lookup_first_block_group(struct btrfs_fs_info *info, u64 bytenr)
-{
-	return block_group_cache_tree_search(info, bytenr, 0);
-}
-
-/*
- * return the block group that contains the given bytenr
- */
-struct btrfs_block_group_cache *btrfs_lookup_block_group(
-						 struct btrfs_fs_info *info,
-						 u64 bytenr)
-{
-	return block_group_cache_tree_search(info, bytenr, 1);
-}
 
 static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
 {
@@ -3145,34 +3081,6 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 }
 
-static struct btrfs_block_group_cache *next_block_group(
-		struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct rb_node *node;
-
-	spin_lock(&fs_info->block_group_cache_lock);
-
-	/* If our block group was removed, we need a full search. */
-	if (RB_EMPTY_NODE(&cache->cache_node)) {
-		const u64 next_bytenr = cache->key.objectid + cache->key.offset;
-
-		spin_unlock(&fs_info->block_group_cache_lock);
-		btrfs_put_block_group(cache);
-		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr); return cache;
-	}
-	node = rb_next(&cache->cache_node);
-	btrfs_put_block_group(cache);
-	if (node) {
-		cache = rb_entry(node, struct btrfs_block_group_cache,
-				 cache_node);
-		btrfs_get_block_group(cache);
-	} else
-		cache = NULL;
-	spin_unlock(&fs_info->block_group_cache_lock);
-	return cache;
-}
-
 static int cache_save_setup(struct btrfs_block_group_cache *block_group,
 			    struct btrfs_trans_handle *trans,
 			    struct btrfs_path *path)
@@ -7773,7 +7681,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 			if (block_group->iref)
 				break;
 			spin_unlock(&block_group->lock);
-			block_group = next_block_group(block_group);
+			block_group = btrfs_next_block_group(block_group);
 		}
 		if (!block_group) {
 			if (last == 0)
@@ -8963,7 +8871,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 	int ret = 0;
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
-	for (; cache; cache = next_block_group(cache)) {
+	for (; cache; cache = btrfs_next_block_group(cache)) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
 			break;
-- 
2.14.3

