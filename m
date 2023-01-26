Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAB67D71E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjAZVBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjAZVBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:13 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E471CF50
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:06 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id h19so1502716vsv.13
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjVusJAN+I02YWCK7n1qvVRKflEz3wYbD533NUmx614=;
        b=fLDjLvpM9TR8AjM7jfxMfMfQm7rSHTo2EJizd/g2YHqkPlx3u7Xer3j001+I4Dxv3S
         AzT2EYNeHFKXDB8LjNcT7LJcWLx1kGg//d6k9ynQNvAuP3SuQS6fKWPh7gUJb7mBGtwg
         EXjMWr4Mm71zShNNg/ftnUkQ3gwPfv1rMGDMEuUD9sM5MJVQ3k7U6vzktYek7mpSKQQS
         5LvGWtv7tNY6KQaumDlbeR2BGpC/y0XCYhlZYn3Cuv0fyeW6mVWulWxEqYMwyPoBsCdS
         besIKTY4CxlQppfwqvIzmBCZlB8tX0a0lbAGZbLCy2BLQHXqMch3qfNyBkAOv+x0kCkl
         gnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjVusJAN+I02YWCK7n1qvVRKflEz3wYbD533NUmx614=;
        b=AGWnWvgyj+3pb9I1l4GwPyDb5aTv8JHC9vNxvFtlUoQKr0XPpsVquoSjfjD6gqahqu
         JCQQ8P67Lb+q/1sJwTfbZp0fHAEvWSIO7I4bPgYiL5YFBjpZnXaIGBKmvZXhdgfeYvpb
         dttlsTfp10SHDhnDf027HjWUr1BD9P5HA9ECMIlTTJMmA0+t/8RpqNUWEngikKKjqZ8A
         bz53XBdQUTTv9yiSh4F4XUuCOhdg3UdJiVzQHkldC3iq6iAhEeRpGgQn0ChLs2asriGl
         igOd8ZuKtu3ZfzhcZ1J6ESsOIzU4bAs/grmuitoZUoXOOyACjvGRfEE0oN1IrdRnPeGk
         RORQ==
X-Gm-Message-State: AFqh2kq9ZTRKpw9yAyB9gM3qbwupAecdLRzKi4QK/yKfdl+Es0L0qpG8
        2xsYeABXvXRsfF0u8x+bEHqmUul8RfMwbBDKhuo=
X-Google-Smtp-Source: AMrXdXv4Z5TMbynTplNC/MpCVUOXjUJRe3a4JxgZZZOtUtjvomWEzaLAu/k9ftELOgVMKSdgt90HXQ==
X-Received: by 2002:a67:f692:0:b0:3c4:997b:667b with SMTP id n18-20020a67f692000000b003c4997b667bmr21476887vso.6.1674766865092;
        Thu, 26 Jan 2023 13:01:05 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a285600b006faaf6dc55asm1603256qkp.22.2023.01.26.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/7] btrfs: add trans argument to btrfs_clean_tree_block
Date:   Thu, 26 Jan 2023 16:00:55 -0500
Message-Id: <a7ba4fdb9a8f3d5b1a51138de7f5a39a632f0469.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We check the header generation in the extent buffer against the current
running transaction id to see if it's safe to clear DIRTY on this
buffer.  Generally speaking if we're clearing the buffer dirty we're
holding the transaction open, but in the case of cleaning up an aborted
transaction we don't, so we have extra checks in that path to check the
transid.  To allow for a future cleanup go ahead and pass in the trans
handle so we don't have to rely on ->running_transaction being set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c           | 31 ++++++++++++++++---------------
 fs/btrfs/disk-io.c         |  6 +++---
 fs/btrfs/disk-io.h         |  3 ++-
 fs/btrfs/extent-tree.c     |  4 ++--
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        |  6 +++---
 8 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5476d90a76ce..a4acc0e953c4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -459,7 +459,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		}
-		btrfs_clean_tree_block(buf);
+		btrfs_clean_tree_block(trans, buf);
 		*last_ref = 1;
 	}
 	return 0;
@@ -1026,7 +1026,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		path->locks[level] = 0;
 		path->nodes[level] = NULL;
-		btrfs_clean_tree_block(mid);
+		btrfs_clean_tree_block(trans, mid);
 		btrfs_tree_unlock(mid);
 		/* once for the path */
 		free_extent_buffer(mid);
@@ -1087,7 +1087,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (wret < 0 && wret != -ENOSPC)
 			ret = wret;
 		if (btrfs_header_nritems(right) == 0) {
-			btrfs_clean_tree_block(right);
+			btrfs_clean_tree_block(trans, right);
 			btrfs_tree_unlock(right);
 			del_ptr(root, path, level + 1, pslot + 1);
 			root_sub_used(root, right->len);
@@ -1133,7 +1133,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		BUG_ON(wret == 1);
 	}
 	if (btrfs_header_nritems(mid) == 0) {
-		btrfs_clean_tree_block(mid);
+		btrfs_clean_tree_block(trans, mid);
 		btrfs_tree_unlock(mid);
 		del_ptr(root, path, level + 1, pslot);
 		root_sub_used(root, mid->len);
@@ -3008,7 +3008,8 @@ noinline int btrfs_leaf_free_space(struct extent_buffer *leaf)
  * min slot controls the lowest index we're willing to push to the
  * right.  We'll push up to and including min_slot, but no lower
  */
-static noinline int __push_leaf_right(struct btrfs_path *path,
+static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
+				      struct btrfs_path *path,
 				      int data_size, int empty,
 				      struct extent_buffer *right,
 				      int free_space, u32 left_nritems,
@@ -3106,7 +3107,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	if (left_nritems)
 		btrfs_mark_buffer_dirty(left);
 	else
-		btrfs_clean_tree_block(left);
+		btrfs_clean_tree_block(trans, left);
 
 	btrfs_mark_buffer_dirty(right);
 
@@ -3118,7 +3119,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
 		if (btrfs_header_nritems(path->nodes[0]) == 0)
-			btrfs_clean_tree_block(path->nodes[0]);
+			btrfs_clean_tree_block(trans, path->nodes[0]);
 		btrfs_tree_unlock(path->nodes[0]);
 		free_extent_buffer(path->nodes[0]);
 		path->nodes[0] = right;
@@ -3210,8 +3211,8 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 0;
 	}
 
-	return __push_leaf_right(path, min_data_size, empty,
-				right, free_space, left_nritems, min_slot);
+	return __push_leaf_right(trans, path, min_data_size, empty, right,
+				 free_space, left_nritems, min_slot);
 out_unlock:
 	btrfs_tree_unlock(right);
 	free_extent_buffer(right);
@@ -3226,7 +3227,8 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
  * item at 'max_slot' won't be touched.  Use (u32)-1 to make us do all the
  * items
  */
-static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
+static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
+				     struct btrfs_path *path, int data_size,
 				     int empty, struct extent_buffer *left,
 				     int free_space, u32 right_nritems,
 				     u32 max_slot)
@@ -3330,7 +3332,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	if (right_nritems)
 		btrfs_mark_buffer_dirty(right);
 	else
-		btrfs_clean_tree_block(right);
+		btrfs_clean_tree_block(trans, right);
 
 	btrfs_item_key(right, &disk_key, 0);
 	fixup_low_keys(path, &disk_key, 1);
@@ -3416,9 +3418,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		ret = -EUCLEAN;
 		goto out;
 	}
-	return __push_leaf_left(path, min_data_size,
-			       empty, left, free_space, right_nritems,
-			       max_slot);
+	return __push_leaf_left(trans, path, min_data_size, empty, left,
+				free_space, right_nritems, max_slot);
 out:
 	btrfs_tree_unlock(left);
 	free_extent_buffer(left);
@@ -4367,7 +4368,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_clean_tree_block(leaf);
+			btrfs_clean_tree_block(trans, leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
 	} else {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d0ed52cab304..5942005d50fe 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,11 +965,11 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-void btrfs_clean_tree_block(struct extent_buffer *buf)
+void btrfs_clean_tree_block(struct btrfs_trans_handle *trans,
+			    struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (btrfs_header_generation(buf) ==
-	    fs_info->running_transaction->transid) {
+	if (btrfs_header_generation(buf) == trans->transid) {
 		btrfs_assert_tree_write_locked(buf);
 
 		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f2c507fd0e04..9ccb44adc5c3 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -39,7 +39,8 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clean_tree_block(struct extent_buffer *buf);
+void btrfs_clean_tree_block(struct btrfs_trans_handle *trans,
+			    struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c85af644e353..241a92a25b52 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4908,7 +4908,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
 	__btrfs_tree_lock(buf, nest);
-	btrfs_clean_tree_block(buf);
+	btrfs_clean_tree_block(trans, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
@@ -5538,7 +5538,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
-		btrfs_clean_tree_block(eb);
+		btrfs_clean_tree_block(trans, eb);
 	}
 
 	if (eb == root->node) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c667e878ef1a..ab206af5b2f5 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1283,7 +1283,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	list_del(&free_space_root->dirty_list);
 
 	btrfs_tree_lock(free_space_root->node);
-	btrfs_clean_tree_block(free_space_root->node);
+	btrfs_clean_tree_block(trans, free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
 			      free_space_root->node, 0, 1);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a64a71d882dc..82afb1aef744 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -707,7 +707,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		 * exists).
 		 */
 		btrfs_tree_lock(leaf);
-		btrfs_clean_tree_block(leaf);
+		btrfs_clean_tree_block(trans, leaf);
 		btrfs_tree_unlock(leaf);
 		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 35856ea28e32..6aadf620eb14 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1303,7 +1303,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	list_del(&quota_root->dirty_list);
 
 	btrfs_tree_lock(quota_root->node);
-	btrfs_clean_tree_block(quota_root->node);
+	btrfs_clean_tree_block(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8fcfaf015a70..d0c40a4af48d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2637,7 +2637,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(next);
+					btrfs_clean_tree_block(trans, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
 					ret = btrfs_pin_reserved_extent(trans,
@@ -2707,7 +2707,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_clean_tree_block(next);
+					btrfs_clean_tree_block(trans, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
 					ret = btrfs_pin_reserved_extent(trans,
@@ -2790,7 +2790,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			if (trans) {
 				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(next);
+				btrfs_clean_tree_block(trans, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
 				ret = btrfs_pin_reserved_extent(trans,
-- 
2.26.3

