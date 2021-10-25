Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D543931A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhJYJ7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232672AbhJYJ64 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB39C61040
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635155794;
        bh=QvNx4SpPfgedc+WMpN3zWrTPw0Lix1o4VcHYZybbPbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q/5vZBQpxIAtLuvsemkqR2XTeD+xoWiTriE80K4F2Z2b0pD9XnNJ/yRJSnh7HTaY4
         J2DVQa7kjWCKXuMJY/uH2C1yRPeyyeR6apYpEuo9ql7aQvmz5mTIkdX7WhpKebzQLI
         Aule4otqhj8aSHW1xqAg+0b5Nm9YpNZ7d1rpCcIWHfut/UvgSr8Pd/Xl+nxhXybjj/
         6cmuXBBxNQSqAKRT6dTftSuW0NaQPAw8vh0/qCW0EgnXSow8BkdKMd9ieFw5SfcL1m
         WIGdsGAq2RtwX4t1w0us1yFQg3o0V5C0bJy2qo8sOQ15AHI6U2KjzTacxcGdtXBESn
         VvnmDQOh7wMRQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: remove no longer needed logic for replaying directory deletes
Date:   Mon, 25 Oct 2021 10:56:26 +0100
Message-Id: <921ea4a1864e18cd5f72d829b0a1b9e65cb2a5ce.1635155473.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635155473.git.fdmanana@suse.com>
References: <cover.1635155473.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Now that we log only dir index keys when logging a directory, we no longer
need to deal with dir item keys in the log replay code for replaying
directory deletes. This is also true for the case when we replay a log
tree created by a kernel that still logs dir items.

So remove the remaining code of the replay of directory deletes algorithm
that deals with dir item keys.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c             | 158 ++++++++++++++------------------
 include/uapi/linux/btrfs_tree.h |   4 +-
 2 files changed, 72 insertions(+), 90 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e49fe86f390e..482f0b18b220 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2202,7 +2202,7 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
  */
 static noinline int find_dir_range(struct btrfs_root *root,
 				   struct btrfs_path *path,
-				   u64 dirid, int key_type,
+				   u64 dirid,
 				   u64 *start_ret, u64 *end_ret)
 {
 	struct btrfs_key key;
@@ -2215,7 +2215,7 @@ static noinline int find_dir_range(struct btrfs_root *root,
 		return 1;
 
 	key.objectid = dirid;
-	key.type = key_type;
+	key.type = BTRFS_DIR_LOG_INDEX_KEY;
 	key.offset = *start_ret;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
@@ -2229,7 +2229,7 @@ static noinline int find_dir_range(struct btrfs_root *root,
 	if (ret != 0)
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
-	if (key.type != key_type || key.objectid != dirid) {
+	if (key.type != BTRFS_DIR_LOG_INDEX_KEY || key.objectid != dirid) {
 		ret = 1;
 		goto next;
 	}
@@ -2256,7 +2256,7 @@ static noinline int find_dir_range(struct btrfs_root *root,
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
-	if (key.type != key_type || key.objectid != dirid) {
+	if (key.type != BTRFS_DIR_LOG_INDEX_KEY || key.objectid != dirid) {
 		ret = 1;
 		goto out;
 	}
@@ -2287,95 +2287,82 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	int ret;
 	struct extent_buffer *eb;
 	int slot;
-	u32 item_size;
 	struct btrfs_dir_item *di;
-	struct btrfs_dir_item *log_di;
 	int name_len;
-	unsigned long ptr;
-	unsigned long ptr_end;
 	char *name;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	struct btrfs_key location;
 
-again:
+	/*
+	 * Currenly we only log dir index keys. Even if we replay a log created
+	 * by an older kernel that logged both dir index and dir item keys, all
+	 * we need to do is process the dir index keys, we (and our caller) can
+	 * safely ignore dir item keys (key type BTRFS_DIR_ITEM_KEY).
+	 */
+	ASSERT(dir_key->type == BTRFS_DIR_INDEX_KEY);
+
 	eb = path->nodes[0];
 	slot = path->slots[0];
-	item_size = btrfs_item_size_nr(eb, slot);
-	ptr = btrfs_item_ptr_offset(eb, slot);
-	ptr_end = ptr + item_size;
-	while (ptr < ptr_end) {
-		di = (struct btrfs_dir_item *)ptr;
-		name_len = btrfs_dir_name_len(eb, di);
-		name = kmalloc(name_len, GFP_NOFS);
-		if (!name) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		read_extent_buffer(eb, name, (unsigned long)(di + 1),
-				  name_len);
-		log_di = NULL;
-		if (log && dir_key->type == BTRFS_DIR_ITEM_KEY) {
-			log_di = btrfs_lookup_dir_item(trans, log, log_path,
-						       dir_key->objectid,
-						       name, name_len, 0);
-		} else if (log && dir_key->type == BTRFS_DIR_INDEX_KEY) {
-			log_di = btrfs_lookup_dir_index_item(trans, log,
-						     log_path,
-						     dir_key->objectid,
-						     dir_key->offset,
-						     name, name_len, 0);
-		}
-		if (!log_di) {
-			btrfs_dir_item_key_to_cpu(eb, di, &location);
-			btrfs_release_path(path);
-			btrfs_release_path(log_path);
-			inode = read_one_inode(root, location.objectid);
-			if (!inode) {
-				kfree(name);
-				return -EIO;
-			}
+	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
+	name_len = btrfs_dir_name_len(eb, di);
+	name = kmalloc(name_len, GFP_NOFS);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-			ret = link_to_fixup_dir(trans, root,
-						path, location.objectid);
-			if (ret) {
-				kfree(name);
-				iput(inode);
-				goto out;
-			}
+	read_extent_buffer(eb, name, (unsigned long)(di + 1), name_len);
 
-			inc_nlink(inode);
-			ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
-					BTRFS_I(inode), name, name_len);
-			if (!ret)
-				ret = btrfs_run_delayed_items(trans);
-			kfree(name);
-			iput(inode);
-			if (ret)
-				goto out;
+	if (log) {
+		struct btrfs_dir_item *log_di;
 
-			/* there might still be more names under this key
-			 * check and repeat if required
-			 */
-			ret = btrfs_search_slot(NULL, root, dir_key, path,
-						0, 0);
-			if (ret == 0)
-				goto again;
+		log_di = btrfs_lookup_dir_index_item(trans, log, log_path,
+						     dir_key->objectid,
+						     dir_key->offset,
+						     name, name_len, 0);
+		if (IS_ERR(log_di)) {
+			ret = PTR_ERR(log_di);
+			goto out;
+		} else if (log_di) {
+			/* The dentry exists in the log, we have nothing to do. */
 			ret = 0;
 			goto out;
-		} else if (IS_ERR(log_di)) {
-			kfree(name);
-			return PTR_ERR(log_di);
 		}
-		btrfs_release_path(log_path);
-		kfree(name);
+	}
 
-		ptr = (unsigned long)(di + 1);
-		ptr += name_len;
+	btrfs_dir_item_key_to_cpu(eb, di, &location);
+	btrfs_release_path(path);
+	btrfs_release_path(log_path);
+	inode = read_one_inode(root, location.objectid);
+	if (!inode) {
+		ret = -EIO;
+		goto out;
 	}
-	ret = 0;
+
+	ret = link_to_fixup_dir(trans, root, path, location.objectid);
+	if (ret)
+		goto out;
+
+	inc_nlink(inode);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), name,
+				 name_len);
+	if (ret)
+		goto out;
+
+	ret = btrfs_run_delayed_items(trans);
+	if (ret)
+		goto out;
+
+	/*
+	 * Unlike dir item keys, dir index keys can only have one name (entry) in
+	 * them, as there are no key collisions since each key has a unique offset
+	 * (an index number), so we're done.
+	 */
 out:
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
+	kfree(name);
+	iput(inode);
 	return ret;
 }
 
@@ -2495,7 +2482,6 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 {
 	u64 range_start;
 	u64 range_end;
-	int key_type = BTRFS_DIR_LOG_ITEM_KEY;
 	int ret = 0;
 	struct btrfs_key dir_key;
 	struct btrfs_key found_key;
@@ -2503,7 +2489,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	struct inode *dir;
 
 	dir_key.objectid = dirid;
-	dir_key.type = BTRFS_DIR_ITEM_KEY;
+	dir_key.type = BTRFS_DIR_INDEX_KEY;
 	log_path = btrfs_alloc_path();
 	if (!log_path)
 		return -ENOMEM;
@@ -2517,14 +2503,14 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 		btrfs_free_path(log_path);
 		return 0;
 	}
-again:
+
 	range_start = 0;
 	range_end = 0;
 	while (1) {
 		if (del_all)
 			range_end = (u64)-1;
 		else {
-			ret = find_dir_range(log, path, dirid, key_type,
+			ret = find_dir_range(log, path, dirid,
 					     &range_start, &range_end);
 			if (ret < 0)
 				goto out;
@@ -2551,8 +2537,10 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 					      path->slots[0]);
 			if (found_key.objectid != dirid ||
-			    found_key.type != dir_key.type)
-				goto next_type;
+			    found_key.type != dir_key.type) {
+				ret = 0;
+				goto out;
+			}
 
 			if (found_key.offset > range_end)
 				break;
@@ -2571,15 +2559,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 			break;
 		range_start = range_end + 1;
 	}
-
-next_type:
 	ret = 0;
-	if (key_type == BTRFS_DIR_LOG_ITEM_KEY) {
-		key_type = BTRFS_DIR_LOG_INDEX_KEY;
-		dir_key.type = BTRFS_DIR_INDEX_KEY;
-		btrfs_release_path(path);
-		goto again;
-	}
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(log_path);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e1c4c732aaba..5416f1f1a77a 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -146,7 +146,9 @@
 
 /*
  * dir items are the name -> inode pointers in a directory.  There is one
- * for every name in a directory.
+ * for every name in a directory.  BTRFS_DIR_LOG_ITEM_KEY is no longer used
+ * but it's still defined here for documentation purposes and to help avoid
+ * having its numerical value reused in the future.
  */
 #define BTRFS_DIR_LOG_ITEM_KEY  60
 #define BTRFS_DIR_LOG_INDEX_KEY 72
-- 
2.33.0

