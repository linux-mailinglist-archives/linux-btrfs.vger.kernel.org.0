Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6167D71B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjAZVBX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAZVBW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:22 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D14A20F
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:10 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o5so2394831qtr.11
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYEdTm+PXISxVNJJbhRYvaUQOlxI/mJ7RBKfYxSAgj0=;
        b=5LEWSBzKLBzWYqHbgiLFnfAo3TYM9wOYMws5JUG++69yHEDzfwUQ399bS4xZ79kymj
         vtiANcLOcglrxW6aPzFgfwOQlqSVVJRRuoshHTOu/XxqpjWV4ImU0cWJhxVivzoRLDvw
         wd+eT+YOhJJL/GH4VyWo3W8p5ZtcOXEO8kXDUcHhFuMgzfrcIV1zqzi8eTQQQuNnNhEj
         YuwzNqVtR42YB3NvyA9Tj4JIhD/0iV+6qDhlTaz1iR8NmmOiCtudXH17gvthpLg6A5bZ
         D96+PLeQyOOPpImdqImgBAcqbHC64J6N9SnuBk2FRkaNxwjpU9zrqQw5oUKox1rY29pV
         j1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYEdTm+PXISxVNJJbhRYvaUQOlxI/mJ7RBKfYxSAgj0=;
        b=lTIi23Lre4tWKt8IUalOtSl8jcXz+/sNE1VJEBF6RVQO7xLmpniIdp1OGmx7YhAWcl
         9o8Te8UJ6/BsyVJMbFRj8nuB0MmY58ZjJNROZwapZdNHLW5Nw2K7/WxpbouHt013sKs1
         Bl0F8wZyOoMhU1PLcJfxRP9wjtNPQpLB8LWJ5IrNpdkRhC0SFpgkpLGp/nfsRfPzSLyI
         bMHO6MFoGmkqtezsSafpwIrLGFy85nta9IWzLb7iQUtmyzDTRewEhjEM2e4n3kWnOtDo
         d4D13Mwtyk/Iu2XSGccCFzuUs7gawqLocYP9MQXkbxwM/jqdnGUvbJQLGYmWdHArvu6G
         6cMg==
X-Gm-Message-State: AO0yUKVrZ/kPVgCE5noCYP+YsKC5hTesDArf4zcOoCP55zYgMcEsEfd0
        rb7AzLfJJ7c7R+AipHxxboPtsUYHRo8epjGHEjw=
X-Google-Smtp-Source: AK7set9IurkbUBgxwrINOhiLyCkt7DNV4sf2mLnJ3WRm7vz0BSyG0rt0bH+RVkfQH45pCb6SyVQEYQ==
X-Received: by 2002:ac8:5bcd:0:b0:3b1:c537:38f1 with SMTP id b13-20020ac85bcd000000b003b1c53738f1mr12773638qtb.19.1674766869481;
        Thu, 26 Jan 2023 13:01:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a24-20020ac84d98000000b003b643951117sm1388352qtw.38.2023.01.26.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/7] btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
Date:   Thu, 26 Jan 2023 16:00:58 -0500
Message-Id: <85687150062b95fb20c495441b5b83f36e972204.1674766637.git.josef@toxicpanda.com>
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

btrfs_clean_tree_block is a misnomer, it's just
clear_extent_buffer_dirty with some extra accounting around it.  Rename
this to btrfs_clear_buffer_dirty to make it more clear it belongs with
it's setter, btrfs_mark_buffer_dirty.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c           | 16 ++++++++--------
 fs/btrfs/disk-io.c         |  6 +++---
 fs/btrfs/disk-io.h         |  4 ++--
 fs/btrfs/extent-tree.c     |  6 +++---
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        |  6 +++---
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a4acc0e953c4..c648a3493542 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -459,7 +459,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		}
-		btrfs_clean_tree_block(trans, buf);
+		btrfs_clear_buffer_dirty(trans, buf);
 		*last_ref = 1;
 	}
 	return 0;
@@ -1026,7 +1026,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		path->locks[level] = 0;
 		path->nodes[level] = NULL;
-		btrfs_clean_tree_block(trans, mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		btrfs_tree_unlock(mid);
 		/* once for the path */
 		free_extent_buffer(mid);
@@ -1087,7 +1087,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (wret < 0 && wret != -ENOSPC)
 			ret = wret;
 		if (btrfs_header_nritems(right) == 0) {
-			btrfs_clean_tree_block(trans, right);
+			btrfs_clear_buffer_dirty(trans, right);
 			btrfs_tree_unlock(right);
 			del_ptr(root, path, level + 1, pslot + 1);
 			root_sub_used(root, right->len);
@@ -1133,7 +1133,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		BUG_ON(wret == 1);
 	}
 	if (btrfs_header_nritems(mid) == 0) {
-		btrfs_clean_tree_block(trans, mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		btrfs_tree_unlock(mid);
 		del_ptr(root, path, level + 1, pslot);
 		root_sub_used(root, mid->len);
@@ -3107,7 +3107,7 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	if (left_nritems)
 		btrfs_mark_buffer_dirty(left);
 	else
-		btrfs_clean_tree_block(trans, left);
+		btrfs_clear_buffer_dirty(trans, left);
 
 	btrfs_mark_buffer_dirty(right);
 
@@ -3119,7 +3119,7 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
 		if (btrfs_header_nritems(path->nodes[0]) == 0)
-			btrfs_clean_tree_block(trans, path->nodes[0]);
+			btrfs_clear_buffer_dirty(trans, path->nodes[0]);
 		btrfs_tree_unlock(path->nodes[0]);
 		free_extent_buffer(path->nodes[0]);
 		path->nodes[0] = right;
@@ -3332,7 +3332,7 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	if (right_nritems)
 		btrfs_mark_buffer_dirty(right);
 	else
-		btrfs_clean_tree_block(trans, right);
+		btrfs_clear_buffer_dirty(trans, right);
 
 	btrfs_item_key(right, &disk_key, 0);
 	fixup_low_keys(path, &disk_key, 1);
@@ -4368,7 +4368,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_clean_tree_block(trans, leaf);
+			btrfs_clear_buffer_dirty(trans, leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
 	} else {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5bcb77662b1d..319d664e1782 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,8 +965,8 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-void btrfs_clean_tree_block(struct btrfs_trans_handle *trans,
-			    struct extent_buffer *buf)
+void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			      struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	if (!trans || btrfs_header_generation(buf) == trans->transid) {
@@ -5080,7 +5080,7 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 
 			btrfs_tree_lock(eb);
 			wait_on_extent_buffer_writeback(eb);
-			btrfs_clean_tree_block(NULL, eb);
+			btrfs_clear_buffer_dirty(NULL, eb);
 			btrfs_tree_unlock(eb);
 
 			free_extent_buffer_stale(eb);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9ccb44adc5c3..13687458a321 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -39,8 +39,8 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clean_tree_block(struct btrfs_trans_handle *trans,
-			    struct extent_buffer *buf);
+void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			      struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 241a92a25b52..b1d3e37a6398 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4908,7 +4908,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
 	__btrfs_tree_lock(buf, nest);
-	btrfs_clean_tree_block(trans, buf);
+	btrfs_clear_buffer_dirty(trans, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
@@ -5533,12 +5533,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				}
 			}
 		}
-		/* make block locked assertion in btrfs_clean_tree_block happy */
+		/* make block locked assertion in btrfs_clear_buffer_dirty happy */
 		if (!path->locks[level]) {
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
-		btrfs_clean_tree_block(trans, eb);
+		btrfs_clear_buffer_dirty(trans, eb);
 	}
 
 	if (eb == root->node) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ab206af5b2f5..4d155a48ec59 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1283,7 +1283,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	list_del(&free_space_root->dirty_list);
 
 	btrfs_tree_lock(free_space_root->node);
-	btrfs_clean_tree_block(trans, free_space_root->node);
+	btrfs_clear_buffer_dirty(trans, free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
 			      free_space_root->node, 0, 1);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 82afb1aef744..f0babad56ad3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -707,7 +707,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		 * exists).
 		 */
 		btrfs_tree_lock(leaf);
-		btrfs_clean_tree_block(trans, leaf);
+		btrfs_clear_buffer_dirty(trans, leaf);
 		btrfs_tree_unlock(leaf);
 		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6aadf620eb14..1d06a93edc35 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1303,7 +1303,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	list_del(&quota_root->dirty_list);
 
 	btrfs_tree_lock(quota_root->node);
-	btrfs_clean_tree_block(trans, quota_root->node);
+	btrfs_clear_buffer_dirty(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f543af4328b6..050ae214fb4f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2636,7 +2636,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				}
 
 				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(trans, next);
+				btrfs_clear_buffer_dirty(trans, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
 
@@ -2705,7 +2705,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				next = path->nodes[*level];
 
 				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(trans, next);
+				btrfs_clear_buffer_dirty(trans, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
 
@@ -2786,7 +2786,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			next = path->nodes[orig_level];
 
 			btrfs_tree_lock(next);
-			btrfs_clean_tree_block(trans, next);
+			btrfs_clear_buffer_dirty(trans, next);
 			btrfs_wait_tree_block_writeback(next);
 			btrfs_tree_unlock(next);
 
-- 
2.26.3

