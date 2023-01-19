Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145036745A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjASWOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjASWNu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:50 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F669A792B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:38 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d13so2485078qvj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuAQQu2MHoUfrDRPFO9sMf47K6AyvY6FC170FFrbzeo=;
        b=Khb2ApIGr35+Eek+a7GHO09jeE9VcSSKKHymbxuQe6DEg4AMTWsrdX8kw7v2tnIQPl
         wgoHmd5P5cW+gsf+Yroe4vTsx9WHjXEbUWYZhXNsGvxeQnR5nds6+NMWl4U6rXNnIzBU
         m1ej8/T2W2WSfCoXs9rw9NJjDclBjeGaEZRunTz1kXR/Vemk3I96MXpLI94hvLQRfFaf
         fPU/YpUo77gnXu6crZMa9dlRC8I+R7BJbBA1A0O0jXYNcxUxMXf98xem+ozlyxd6x8Tw
         XGPFiOhbifOEEva/pPNXyolbrxJ+hj2fvOHafA6zoHW32FAha/99XCxKIS86WBJ35BD+
         xaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuAQQu2MHoUfrDRPFO9sMf47K6AyvY6FC170FFrbzeo=;
        b=qnM3p7gNfuHu29ujKW4gckywzgOYGG9TI2QHdXBLGFDfzRgPaT1uUW43pvbBE+88Sl
         HiLAELUAye6SGBeQB2eJj23Zr6QGLlVtcakNs7gY2LV1AZMuMrr3Pk+radpV1pLDB4Y6
         nTYmqNFOVnKqtYhUV8FYuW90Q39FZbkmDNSP4aoOXmlPWE9xmT/o5bMIPXjw4SKY4aJq
         cKC7Ifcch4JqT23jJAI6SwdUSKhwbyIECBBuiL1yvN+WXrVyci9rN0tDdNi8aLCM6bax
         jyW9tAw9rcKHS70EoR5hDFgS1xpax7SvnqcThe07Isv98aYbOkDDCn2m31fRkW4sjRLp
         s/XQ==
X-Gm-Message-State: AFqh2kp+NnYjD+b9MoK6Fwu7dBvO5/On97WWXLJjjmNKWKCAY1bXfvx5
        LxQzKNKLBtFVpqcmiH4jY2aLE7z/22j8WLPitVs=
X-Google-Smtp-Source: AMrXdXsgsc4PJl1T+OBKO16GkQzJL1wLw+Xlh5zgW2JJcw9dzJHqlvahIf/IIUrqE0glJTb6l68AYw==
X-Received: by 2002:a05:6214:3b89:b0:535:1bf2:f241 with SMTP id nf9-20020a0562143b8900b005351bf2f241mr19314694qvb.30.1674165217128;
        Thu, 19 Jan 2023 13:53:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r19-20020ae9d613000000b0070617deb4b7sm13683507qkk.134.2023.01.19.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 7/9] btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
Date:   Thu, 19 Jan 2023 16:53:23 -0500
Message-Id: <6fc3fd1c656eb09e3f24655a46cc4ec9b4b37504.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
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
 fs/btrfs/ctree.c           | 14 +++++++-------
 fs/btrfs/disk-io.c         |  4 ++--
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent-tree.c     |  6 +++---
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        |  6 +++---
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ac33dbb08263..0b551d38d365 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1025,7 +1025,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		path->locks[level] = 0;
 		path->nodes[level] = NULL;
-		btrfs_clean_tree_block(mid);
+		btrfs_clear_buffer_dirty(mid);
 		btrfs_tree_unlock(mid);
 		/* once for the path */
 		free_extent_buffer(mid);
@@ -1086,7 +1086,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (wret < 0 && wret != -ENOSPC)
 			ret = wret;
 		if (btrfs_header_nritems(right) == 0) {
-			btrfs_clean_tree_block(right);
+			btrfs_clear_buffer_dirty(right);
 			btrfs_tree_unlock(right);
 			del_ptr(root, path, level + 1, pslot + 1);
 			root_sub_used(root, right->len);
@@ -1132,7 +1132,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		BUG_ON(wret == 1);
 	}
 	if (btrfs_header_nritems(mid) == 0) {
-		btrfs_clean_tree_block(mid);
+		btrfs_clear_buffer_dirty(mid);
 		btrfs_tree_unlock(mid);
 		del_ptr(root, path, level + 1, pslot);
 		root_sub_used(root, mid->len);
@@ -3105,7 +3105,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	if (left_nritems)
 		btrfs_mark_buffer_dirty(left);
 	else
-		btrfs_clean_tree_block(left);
+		btrfs_clear_buffer_dirty(left);
 
 	btrfs_mark_buffer_dirty(right);
 
@@ -3117,7 +3117,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
 		if (btrfs_header_nritems(path->nodes[0]) == 0)
-			btrfs_clean_tree_block(path->nodes[0]);
+			btrfs_clear_buffer_dirty(path->nodes[0]);
 		btrfs_tree_unlock(path->nodes[0]);
 		free_extent_buffer(path->nodes[0]);
 		path->nodes[0] = right;
@@ -3329,7 +3329,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	if (right_nritems)
 		btrfs_mark_buffer_dirty(right);
 	else
-		btrfs_clean_tree_block(right);
+		btrfs_clear_buffer_dirty(right);
 
 	btrfs_item_key(right, &disk_key, 0);
 	fixup_low_keys(path, &disk_key, 1);
@@ -4366,7 +4366,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_clean_tree_block(leaf);
+			btrfs_clear_buffer_dirty(leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
 	} else {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 275ba1925eeb..b8f1ac54d10c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,7 +965,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-void btrfs_clean_tree_block(struct extent_buffer *buf)
+void btrfs_clear_buffer_dirty(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	btrfs_assert_tree_write_locked(buf);
@@ -5077,7 +5077,7 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 
 			btrfs_tree_lock(eb);
 			wait_on_extent_buffer_writeback(eb);
-			btrfs_clean_tree_block(eb);
+			btrfs_clear_buffer_dirty(eb);
 			btrfs_tree_unlock(eb);
 
 			free_extent_buffer_stale(eb);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f2c507fd0e04..8d23746c7660 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -39,7 +39,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clean_tree_block(struct extent_buffer *buf);
+void btrfs_clear_buffer_dirty(struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 971b1de50d9e..3f123c3570a9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4905,7 +4905,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
 	__btrfs_tree_lock(buf, nest);
-	btrfs_clean_tree_block(buf);
+	btrfs_clear_buffer_dirty(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
@@ -5530,12 +5530,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				}
 			}
 		}
-		/* make block locked assertion in btrfs_clean_tree_block happy */
+		/* make block locked assertion in btrfs_clear_buffer_dirty happy */
 		if (!path->locks[level]) {
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
-		btrfs_clean_tree_block(eb);
+		btrfs_clear_buffer_dirty(eb);
 	}
 
 	if (eb == root->node) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index c667e878ef1a..e03f58f43719 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1283,7 +1283,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	list_del(&free_space_root->dirty_list);
 
 	btrfs_tree_lock(free_space_root->node);
-	btrfs_clean_tree_block(free_space_root->node);
+	btrfs_clear_buffer_dirty(free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
 			      free_space_root->node, 0, 1);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a64a71d882dc..8048b536c682 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -707,7 +707,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		 * exists).
 		 */
 		btrfs_tree_lock(leaf);
-		btrfs_clean_tree_block(leaf);
+		btrfs_clear_buffer_dirty(leaf);
 		btrfs_tree_unlock(leaf);
 		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 35856ea28e32..9e22698ea439 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1303,7 +1303,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	list_del(&quota_root->dirty_list);
 
 	btrfs_tree_lock(quota_root->node);
-	btrfs_clean_tree_block(quota_root->node);
+	btrfs_clear_buffer_dirty(quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 73e621df32f7..15695f505f05 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2636,7 +2636,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 				}
 
 				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(next);
+				btrfs_clear_buffer_dirty(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
 
@@ -2705,7 +2705,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				next = path->nodes[*level];
 
 				btrfs_tree_lock(next);
-				btrfs_clean_tree_block(next);
+				btrfs_clear_buffer_dirty(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
 
@@ -2786,7 +2786,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			next = path->nodes[orig_level];
 
 			btrfs_tree_lock(next);
-			btrfs_clean_tree_block(next);
+			btrfs_clear_buffer_dirty(next);
 			btrfs_wait_tree_block_writeback(next);
 			btrfs_tree_unlock(next);
 
-- 
2.26.3

