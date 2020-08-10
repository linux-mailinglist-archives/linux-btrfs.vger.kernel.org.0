Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A76240AA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHJPnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgHJPnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:02 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66573C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:02 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cs12so4436646qvb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=356KTM0H95tFsgYyGhsfOiwtmNGP2ckK5mMSSwT812U=;
        b=y0X+Jn6DkE0sZTpniwplpadsvBq6s+K+hHVYoMoWr/DU2tq0mpdDYCq0HUlxD7v2/N
         k7wQjf/hrC+BJnGkNF2Q865gtetGBdP4o/+vbTEws+jRkQpyO+FfTiQjIo9ZYhGuUzdv
         B+5IB7ZgQGLDyCMxpGQuyzlWFsI4A3aSCgDyeXCB9QSiLpAE9K9XHCH5Trirm/1Tif3W
         H39dPnzHKERUDfy5VVu+okjvhU1QghHJNgv7TTTZQj8ZUy3G0TeVR9YnSMTGsZ3VQtFX
         qr/uxIJTp2sQdwtKhM74TAy2MYwVRd2tl2SRo5Asv+sFjxRUTs6Httq4C6BTS1eSHDD3
         T4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=356KTM0H95tFsgYyGhsfOiwtmNGP2ckK5mMSSwT812U=;
        b=Yrj4/GCn7N3xwJ0VR+X1dbARE5V54+X0HUVp2Dzy5GIF1+m+CTM8eSSle6HLRA1zgF
         9cpuMvCXxek6uRSk5uSvMXyibEvq2KllRmxn9uq4z+JGiUW1pOhuah+XVkZ7BeGCZ8HK
         UNO27eHgSpfGdLKd5gn0wKzJO3pa7sX0DuIYvt5EDmsJnAmspxMqdbQRLo19eVuN+j5R
         Jv5GDptI/uAzQ1iwYVZtdEukLmMj/FmppgDkya925XryIhSEV/du8LYROKczPUUH2uWb
         CdpSj2wNV90PdwU4KEUh4z9f6Pt06F3l0Y0hQbd0KbRaInP+bDR7oz/1Eryus+hf+v+8
         oWig==
X-Gm-Message-State: AOAM530OcAhoDGuUL117Mk8tUEvURPQZZb+0C/o+m07/GxIxcGsBmP2r
        LHuHP3ZMS0/20DOvxAdyYJXrJw+IiMNVHA==
X-Google-Smtp-Source: ABdhPJxlOEx1mHn+piUv1OAKGaZAsVr5sc0uq6e8jr3t9PlWlGYfQ9lc4VInElMALzDNXumzeRmkfg==
X-Received: by 2002:a05:6214:554:: with SMTP id ci20mr29118533qvb.108.1597074181210;
        Mon, 10 Aug 2020 08:43:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c42sm17372760qte.5.2020.08.10.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/17] btrfs: introduce path->recurse
Date:   Mon, 10 Aug 2020 11:42:33 -0400
Message-Id: <20200810154242.782802-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
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
index cbacf700b68b..34d40b19bb71 100644
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
index 9c7e466f27a9..e7a28033eaef 100644
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
@@ -2651,8 +2652,6 @@ void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
 struct extent_buffer *btrfs_root_node(struct btrfs_root *root);
-struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
-struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 			struct btrfs_key *key, int lowest_level,
 			u64 min_trans);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 96064eb41d55..6c547aa905d7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6591,6 +6591,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
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

