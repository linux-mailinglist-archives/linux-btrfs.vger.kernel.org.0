Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6324C26E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHTPqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgHTPqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B6C061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so1926477qkf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+dObLDh95L5Bj6DDfUYr3nj/Lz3U/g+KhLR5I69WE9M=;
        b=WxnoIzZ2d6kTYH8+Aq4E5SpOr8IlsNhtDIMG3Ma0+36HYG7dMkrdWhiDLj73zYk0IR
         MEDoBxksmYvEGZv6Q0Nc88/flaEcC4jvlPilKEIhpIbEW6JpqaicZB2N1m5UXRCTqlnK
         yYvWae/ihEJBjFI3Lqe8qDBkG/btMDG5XY72rvrTdwWXF+FCXmnB92s59+2/3DElVFmM
         DJE09Cv0n+HomH+XPGV5Xzr4ZHKct+73mu9EPTgZPxTvHfrsfqU+Ln8KfNwCkK1EfTwK
         eAnUtRDHw14THHfTnTXGeVlzLuee+XOIPJqIl/M6fn7aJQAoYDyTcBniBKpkcK4yExJ9
         V2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dObLDh95L5Bj6DDfUYr3nj/Lz3U/g+KhLR5I69WE9M=;
        b=Lgf8y1gyADanAzHZAehitDkdg6kJiWLPIke8a06Z6y/hxo0G+K5Hmx6nedT4I7UZzo
         HcXaLrkZHHkkyC1+gtIgDp4y16eyGGLPZlOP35s8cqz5LH6NS+dJo48UvL9b4YLU6I8f
         ek9x2wpdqx1lKbGI/fjBjjM1eb5wYjHQSE81ypyn3/u0iR3XRKx2BTmdeRHMe1KSQacp
         OhGHtXUg/7iZn6RQuuBRbsDCqfktkmE06XipxwMLMaOpEd4Kgfc1U9yMAXlR2fKMVL72
         MlU4zgW/d2NQsat6sYc5XE/Nd1gZhVzqamF5VDrrDYIbUYEmyxOjybXvzsZ37FFCW7OB
         GixA==
X-Gm-Message-State: AOAM5326K0AxtB0MehCqNhco6TKUpkth+5EV5w9RNcoBCsJCC+BBPWFk
        LLSIyHlx2ZZ7MhrCxF4fNE0mRqjiypHbcNL/
X-Google-Smtp-Source: ABdhPJyEMfnEYXhH6Q4kpXaj+jG5bxvdN+SrV7kMyUxOml9rsdvzeJtN2XV0HEnDz7p0eRTwH/rrFA==
X-Received: by 2002:a37:6808:: with SMTP id d8mr2936760qkc.15.1597938378672;
        Thu, 20 Aug 2020 08:46:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d20sm2517518qkk.84.2020.08.20.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/12] btrfs: introduce path->recurse
Date:   Thu, 20 Aug 2020 11:46:01 -0400
Message-Id: <f54ff9dfcae7f958e83a6b690c22d4cd0c94ffaa.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our current tree locking stuff allows us to recurse with read locks if
we're already holding the write lock.  This is necessary for the space
cache inode, as we could be holding a lock on the root_tree root when we
need to cache a block group, and thus need to be able to read down the
root_tree to read in the inode cache.

We can get away with this in our current locking, but we won't be able
to with a rwsem.  Handle this by purposefully annotating the places
where we require recursion, so that in the future we can maybe come up
with a way to avoid the recursion.  In the case of the free space inode,
this will be superseded by the free space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   |  8 ++++----
 fs/btrfs/ctree.h   |  3 +--
 fs/btrfs/inode.c   |  2 ++
 fs/btrfs/locking.c | 13 ++++++++++---
 fs/btrfs/locking.h | 10 ++++++++++
 5 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e0fd8a34efcc..025a75767d61 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2601,7 +2601,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 		 * We don't know the level of the root node until we actually
 		 * have it read locked
 		 */
-		b = btrfs_read_lock_root_node(root);
+		b = __btrfs_read_lock_root_node(root, p->recurse);
 		level = btrfs_header_level(b);
 		if (level > write_lock_level)
 			goto out;
@@ -2875,7 +2875,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			} else {
 				if (!btrfs_tree_read_lock_atomic(b)) {
 					btrfs_set_path_blocking(p);
-					btrfs_tree_read_lock(b);
+					__btrfs_tree_read_lock(b, p->recurse);
 				}
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
@@ -5379,7 +5379,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			}
 			if (!ret) {
 				btrfs_set_path_blocking(path);
-				btrfs_tree_read_lock(next);
+				__btrfs_tree_read_lock(next, path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
@@ -5414,7 +5414,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			ret = btrfs_try_tree_read_lock(next);
 			if (!ret) {
 				btrfs_set_path_blocking(path);
-				btrfs_tree_read_lock(next);
+				__btrfs_tree_read_lock(next, path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3b110ffbc93..0df7a593ddf0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -374,6 +374,7 @@ struct btrfs_path {
 	unsigned int search_commit_root:1;
 	unsigned int need_commit_sem:1;
 	unsigned int skip_release_on_error:1;
+	unsigned int recurse:1;
 };
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
@@ -2654,8 +2655,6 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
 struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
-struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
-struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 			struct btrfs_key *key, int lowest_level,
 			u64 min_trans);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dd84c4d58a56..d90b079a9dbc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6592,6 +6592,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	 */
 	path->leave_spinning = 1;
 
+	path->recurse = btrfs_is_free_space_inode(inode);
+
 	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
 	if (ret < 0) {
 		err = ret;
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 8e3d107a6192..d07818733833 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -244,7 +244,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
  *
  * The rwlock is held upon exit.
  */
-void btrfs_tree_read_lock(struct extent_buffer *eb)
+void __btrfs_tree_read_lock(struct extent_buffer *eb, bool recurse)
 {
 	u64 start_ns = 0;
 
@@ -263,6 +263,7 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 			 * depends on this as it may be called on a partly
 			 * (write-)locked tree.
 			 */
+			WARN_ON(!recurse);
 			BUG_ON(eb->lock_recursed);
 			eb->lock_recursed = true;
 			read_unlock(&eb->lock);
@@ -279,6 +280,11 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
+void btrfs_tree_read_lock(struct extent_buffer *eb)
+{
+	__btrfs_tree_read_lock(eb, false);
+}
+
 /*
  * Lock extent buffer for read, optimistically expecting that there are no
  * contending blocking writers. If there are, don't wait.
@@ -552,13 +558,14 @@ struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
  *
  * Return: root extent buffer with read lock held
  */
-struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
+struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
+						  bool recurse)
 {
 	struct extent_buffer *eb;
 
 	while (1) {
 		eb = btrfs_root_node(root);
-		btrfs_tree_read_lock(eb);
+		__btrfs_tree_read_lock(eb, recurse);
 		if (eb == root->node)
 			break;
 		btrfs_tree_read_unlock(eb);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index d715846c10b8..587f144adafe 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -21,6 +21,7 @@ struct btrfs_path;
 void btrfs_tree_lock(struct extent_buffer *eb);
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
+void __btrfs_tree_read_lock(struct extent_buffer *eb, bool recurse);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
@@ -29,6 +30,15 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb);
+struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
+struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
+						  bool recurse);
+
+static inline struct extent_buffer *
+btrfs_read_lock_root_node(struct btrfs_root *root)
+{
+	return __btrfs_read_lock_root_node(root, false);
+}
 
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
-- 
2.24.1

