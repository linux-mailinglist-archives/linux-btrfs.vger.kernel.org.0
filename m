Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E130F40D771
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhIPKdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 06:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236544AbhIPKdk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 06:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67F8161214
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631788339;
        bh=9ih1Uw0q5IxY6wV8aS8iXMK5h/jQvYq1TlOkqd/ms7s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vew1hlLKM167IvBnZNzMrtQ+UHZezwEgxjzvNMMcQys43AqCni6rYg47ozqTaHj6F
         XoQFp5cjAfSYZKJKn51RGISvU6aCr+jzWmWMDuFjEKoTfbXzjNwlFftwAp4mqAUiVk
         tUFwqFNt38lUtQy60Vw/dUBwIeKFrP7KCyOaRuYLVfZhSe3JhFi1dYQ0LkzUShhBIF
         U/B8QuD+hNg/O90qIpFHpQT0v2+M7IoS2FqD7goBFCWm0+urtnPOejvRLIXaB0QUnR
         FISR+8gp0lUUKwQJAJPis5UHgK3sap+2VCWXPLIuOh0r6tpF9tEv9SFjQLpmCArDx+
         EHSken6rvDObA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: factor out the copying loop of dir items from log_dir_items()
Date:   Thu, 16 Sep 2021 11:32:12 +0100
Message-Id: <5e030e2b8815dae4a0dcacce187e26d5082dd433.1631787796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631787796.git.fdmanana@suse.com>
References: <cover.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In preparation for the next change, move the loop that processes a leaf
and copies its directory items to the log, into a separate helper
function. This makes the next change simpler and it also helps making
log_dir_items() a bit shorter (specially after the next change).

This patch is part of a patchset comprised of the following 5 patches:

  btrfs: remove root argument from btrfs_log_inode() and its callees
  btrfs: remove redundant log root assignment from log_dir_items()
  btrfs: factor out the copying loop of dir items from log_dir_items()
  btrfs: insert items in batches when logging a directory when possible
  btrfs: keep track of the last logged keys when logging a directory

This is patch 3/5. The change log of the last patch (5/5) has performance
results.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 135 ++++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 64db4bd8e965..3b1ec645b8d2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3615,6 +3615,66 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
+				  struct btrfs_inode *inode,
+				  struct btrfs_path *path,
+				  struct btrfs_path *dst_path,
+				  int key_type,
+				  struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_root *log = inode->root->log_root;
+	struct extent_buffer *src = path->nodes[0];
+	const int nritems = btrfs_header_nritems(src);
+	const u64 ino = btrfs_ino(inode);
+	int i;
+
+	for (i = path->slots[0]; i < nritems; i++) {
+		struct btrfs_key key;
+		struct btrfs_dir_item *di;
+		int ret;
+
+		btrfs_item_key_to_cpu(src, &key, i);
+
+		if (key.objectid != ino || key.type != key_type)
+			return 1;
+
+		ret = overwrite_item(trans, log, dst_path, src, i, &key);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * We must make sure that when we log a directory entry, the
+		 * corresponding inode, after log replay, has a matching link
+		 * count. For example:
+		 *
+		 * touch foo
+		 * mkdir mydir
+		 * sync
+		 * ln foo mydir/bar
+		 * xfs_io -c "fsync" mydir
+		 * <crash>
+		 * <mount fs and log replay>
+		 *
+		 * Would result in a fsync log that when replayed, our file inode
+		 * would have a link count of 1, but we get two directory entries
+		 * pointing to the same inode. After removing one of the names,
+		 * it would not be possible to remove the other name, which
+		 * resulted always in stale file handle errors, and would not be
+		 * possible to rmdir the parent directory, since its i_size could
+		 * never be decremented to the value BTRFS_EMPTY_DIR_SIZE,
+		 * resulting in -ENOTEMPTY errors.
+		 */
+		di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
+		btrfs_dir_item_key_to_cpu(src, di, &key);
+		if ((btrfs_dir_transid(src, di) == trans->transid ||
+		     btrfs_dir_type(src, di) == BTRFS_FT_DIR) &&
+		    key.type != BTRFS_ROOT_ITEM_KEY)
+			ctx->log_new_dentries = true;
+	}
+
+	return 0;
+}
+
 /*
  * log all the items included in the current transaction for a given
  * directory.  This also creates the range items in the log tree required
@@ -3630,11 +3690,8 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	struct btrfs_key min_key;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_root *log = root->log_root;
-	struct extent_buffer *src;
 	int err = 0;
 	int ret;
-	int i;
-	int nritems;
 	u64 first_offset = min_offset;
 	u64 last_offset = (u64)-1;
 	u64 ino = btrfs_ino(inode);
@@ -3712,61 +3769,14 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	 * from our directory
 	 */
 	while (1) {
-		struct btrfs_key tmp;
-		src = path->nodes[0];
-		nritems = btrfs_header_nritems(src);
-		for (i = path->slots[0]; i < nritems; i++) {
-			struct btrfs_dir_item *di;
-
-			btrfs_item_key_to_cpu(src, &min_key, i);
-
-			if (min_key.objectid != ino || min_key.type != key_type)
-				goto done;
-
-			if (need_resched()) {
-				btrfs_release_path(path);
-				cond_resched();
-				goto search;
-			}
-
-			ret = overwrite_item(trans, log, dst_path, src, i,
-					     &min_key);
-			if (ret) {
+		ret = process_dir_items_leaf(trans, inode, path, dst_path,
+					     key_type, ctx);
+		if (ret != 0) {
+			if (ret < 0)
 				err = ret;
-				goto done;
-			}
-
-			/*
-			 * We must make sure that when we log a directory entry,
-			 * the corresponding inode, after log replay, has a
-			 * matching link count. For example:
-			 *
-			 * touch foo
-			 * mkdir mydir
-			 * sync
-			 * ln foo mydir/bar
-			 * xfs_io -c "fsync" mydir
-			 * <crash>
-			 * <mount fs and log replay>
-			 *
-			 * Would result in a fsync log that when replayed, our
-			 * file inode would have a link count of 1, but we get
-			 * two directory entries pointing to the same inode.
-			 * After removing one of the names, it would not be
-			 * possible to remove the other name, which resulted
-			 * always in stale file handle errors, and would not
-			 * be possible to rmdir the parent directory, since
-			 * its i_size could never decrement to the value
-			 * BTRFS_EMPTY_DIR_SIZE, resulting in -ENOTEMPTY errors.
-			 */
-			di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
-			btrfs_dir_item_key_to_cpu(src, di, &tmp);
-			if ((btrfs_dir_transid(src, di) == trans->transid ||
-			     btrfs_dir_type(src, di) == BTRFS_FT_DIR) &&
-			    tmp.type != BTRFS_ROOT_ITEM_KEY)
-				ctx->log_new_dentries = true;
+			goto done;
 		}
-		path->slots[0] = nritems;
+		path->slots[0] = btrfs_header_nritems(path->nodes[0]);
 
 		/*
 		 * look ahead to the next item and see if it is also
@@ -3780,21 +3790,26 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 				err = ret;
 			goto done;
 		}
-		btrfs_item_key_to_cpu(path->nodes[0], &tmp, path->slots[0]);
-		if (tmp.objectid != ino || tmp.type != key_type) {
+		btrfs_item_key_to_cpu(path->nodes[0], &min_key, path->slots[0]);
+		if (min_key.objectid != ino || min_key.type != key_type) {
 			last_offset = (u64)-1;
 			goto done;
 		}
 		if (btrfs_header_generation(path->nodes[0]) != trans->transid) {
 			ret = overwrite_item(trans, log, dst_path,
 					     path->nodes[0], path->slots[0],
-					     &tmp);
+					     &min_key);
 			if (ret)
 				err = ret;
 			else
-				last_offset = tmp.offset;
+				last_offset = min_key.offset;
 			goto done;
 		}
+		if (need_resched()) {
+			btrfs_release_path(path);
+			cond_resched();
+			goto search;
+		}
 	}
 done:
 	btrfs_release_path(path);
-- 
2.33.0

