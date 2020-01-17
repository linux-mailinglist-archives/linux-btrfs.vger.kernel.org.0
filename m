Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D691412F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAQV1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:13 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40307 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgAQV1M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:12 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so11364032qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZiQjbwJ7NryblTjySfhGfvyrNO9cmH6e9y1g4xb0z7c=;
        b=gX5LLQ9nQqfOMgG4jrZ/tGhhLXfA6htFDSAvmKjXZRSbCGInigkXgvRi/ktREN2ESA
         YtN91T/epICp/JZYw2ofdbEzGnWVlgb0BVkLw8XD0pHbJBBI4gw7ZtadI9utER4lxtMZ
         Cyj+rBKXothk+VjBkhCQBqOicTSB1ouDqG3uzsKAgGeyZWbkqZ7qTqj19MbzlRAoCL1H
         Kun3xaetYKum6gvLu3vSZYnjNG31c94Yvw0G5FLjl0boC5jkM/5mTcBoRM0xoOKFm+/H
         O9/sY/Ow3L4dhXH5z5tAJvj0sZr3twbK+RahA/IBV5kxi4+KFeUsoKXCItzEymBUhHBg
         yjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZiQjbwJ7NryblTjySfhGfvyrNO9cmH6e9y1g4xb0z7c=;
        b=cLDWfxaUJsh+ChqFIgJNo3qIPLXgFIE3osy6x/sfV9DOX5STjqVe56ZTEAW66sBMMN
         eXA8g58aM3XyHhwYOYPGQwjI0A338tfZ9E69QhnDG85hjLWHyEfkMu20jaVTn8CEiX9D
         /adM+F0mJe7VIQCaTFeXyPuX+kdMGlm+gUc2b30IpmW6u7DMavMk8RuSpan6Ib5NV3of
         myJR19g8gpKU4psVHJAVfa3jTpZRHTeoJ29f6i8/Ni4B2RGe/siWM5EJFH7I9okWBcoc
         g7rPsJ842SRpzHUI5L5d1wcwbqfZvAfrVZsbX8xz1421ikXtXZBklegNlzB7ZDj7r1HP
         II0Q==
X-Gm-Message-State: APjAAAVZucb18lzrfPdVOG6OC7ICnIW2DCA+PvSIyqR11Q6j0ssPuOs2
        kfKddRug3O6wGvIS2bzS22vZc+DxCnS/RQ==
X-Google-Smtp-Source: APXvYqxRhwgSrQe58evgpNP9TVJHJhDn3v5jsnb9PBBZs7JEnJC/bPtDIjHRb1f11CbFoT5HtC8/Tg==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr9455406qvh.24.1579296431051;
        Fri, 17 Jan 2020 13:27:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w29sm13942482qtc.72.2020.01.17.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 38/43] btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root
Date:   Fri, 17 Jan 2020 16:25:57 -0500
Message-Id: <20200117212602.6737-39-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all callers of btrfs_get_fs_root are subsequently calling
btrfs_grab_fs_root and handling dropping the ref when they are done
appropriately, go ahead and push btrfs_grab_fs_root up into
btrfs_get_fs_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c     |  6 ------
 fs/btrfs/disk-io.c     | 45 ++++++++++++++++++++++++------------------
 fs/btrfs/export.c      |  4 ----
 fs/btrfs/file.c        |  4 ----
 fs/btrfs/inode.c       |  4 ----
 fs/btrfs/ioctl.c       | 26 ------------------------
 fs/btrfs/relocation.c  |  8 +-------
 fs/btrfs/root-tree.c   |  2 --
 fs/btrfs/scrub.c       |  4 ----
 fs/btrfs/send.c        | 11 -----------
 fs/btrfs/super.c       |  4 ----
 fs/btrfs/transaction.c |  6 ------
 fs/btrfs/tree-log.c    |  4 ----
 fs/btrfs/volumes.c     |  4 ----
 14 files changed, 27 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 193747b6e1f9..b69154d72529 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -527,12 +527,6 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
-	if (!btrfs_grab_fs_root(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
-		ret = -ENOENT;
-		goto out_free;
-	}
-
 	if (btrfs_is_testing(fs_info)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = -ENOENT;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fa721ca1e732..ac306807e5cd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1496,6 +1496,8 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	root = radix_tree_lookup(&fs_info->fs_roots_radix,
 				 (unsigned long)root_id);
+	if (root)
+		root = btrfs_grab_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	return root;
 }
@@ -1552,29 +1554,31 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
-		return fs_info->tree_root;
+		return btrfs_grab_fs_root(fs_info->tree_root);
 	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return fs_info->extent_root;
+		return btrfs_grab_fs_root(fs_info->extent_root);
 	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
-		return fs_info->chunk_root;
+		return btrfs_grab_fs_root(fs_info->chunk_root);
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
-		return fs_info->dev_root;
+		return btrfs_grab_fs_root(fs_info->dev_root);
 	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return fs_info->csum_root;
+		return btrfs_grab_fs_root(fs_info->csum_root);
 	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
-		return fs_info->quota_root ? fs_info->quota_root :
-					     ERR_PTR(-ENOENT);
+		return btrfs_grab_fs_root(fs_info->quota_root) ?
+			fs_info->quota_root : ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
-		return fs_info->uuid_root ? fs_info->uuid_root :
-					    ERR_PTR(-ENOENT);
+		return btrfs_grab_fs_root(fs_info->uuid_root) ?
+			fs_info->uuid_root : ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return fs_info->free_space_root ? fs_info->free_space_root :
-						  ERR_PTR(-ENOENT);
+		return btrfs_grab_fs_root(fs_info->free_space_root) ?
+			fs_info->free_space_root : ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
-		if (check_ref && btrfs_root_refs(&root->root_item) == 0)
+		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
+			btrfs_put_fs_root(root);
 			return ERR_PTR(-ENOENT);
+		}
 		return root;
 	}
 
@@ -1607,8 +1611,18 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (ret == 0)
 		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
 
+	/*
+	 * All roots have two refs on them at all times, one for the mounted fs,
+	 * and one for being in the radix tree.  This way we only free the root
+	 * when we are unmounting or deleting the subvolume.  We get one ref
+	 * from __setup_root, one for inserting it into the radix tree, and then
+	 * we have the third for returning it, and the caller will put it when
+	 * it's done with the root.
+	 */
+	btrfs_grab_fs_root(root);
 	ret = btrfs_insert_fs_root(fs_info, root);
 	if (ret) {
+		btrfs_put_fs_root(root);
 		if (ret == -EEXIST) {
 			btrfs_free_fs_root(root);
 			goto again;
@@ -3204,13 +3218,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_qgroup;
 	}
 
-	if (!btrfs_grab_fs_root(fs_info->fs_root)) {
-		fs_info->fs_root = NULL;
-		err = -ENOENT;
-		btrfs_warn(fs_info, "failed to grab a ref on the fs tree");
-		goto fail_qgroup;
-	}
-
 	if (sb_rdonly(sb))
 		return 0;
 
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index eba6c6d27bad..f07c2300ade2 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -82,10 +82,6 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 		err = PTR_ERR(root);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		err = -ENOENT;
-		goto fail;
-	}
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3abc7986052b..682f21ee6034 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,10 +292,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
-	if (!btrfs_grab_fs_root(inode_root)) {
-		ret = -ENOENT;
-		goto cleanup;
-	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 85104886c1e7..c01dc2790a40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5026,10 +5026,6 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(new_root)) {
-		err = -ENOENT;
-		goto out;
-	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 47953d022328..20861cabe6a1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,11 +672,6 @@ static noinline int create_subvol(struct inode *dir,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(new_root)) {
-		ret = -ENOENT;
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
 
 	btrfs_record_root_in_trans(trans, new_root);
 
@@ -2191,10 +2186,6 @@ static noinline int search_ioctl(struct inode *inode,
 			btrfs_free_path(path);
 			return PTR_ERR(root);
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			btrfs_free_path(path);
-			return -ENOENT;
-		}
 	}
 
 	key.objectid = sk->min_objectid;
@@ -2332,11 +2323,6 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 		root = NULL;
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		root = NULL;
-		goto out;
-	}
 
 	key.objectid = dirid;
 	key.type = BTRFS_INODE_REF_KEY;
@@ -2433,10 +2419,6 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			ret = PTR_ERR(root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			ret = -ENOENT;
-			goto out;
-		}
 
 		key.objectid = dirid;
 		key.type = BTRFS_INODE_REF_KEY;
@@ -2686,10 +2668,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = PTR_ERR(root);
 		goto out_free;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		goto out;
-	}
 	root_item = &root->root_item;
 
 	subvol_info->treeid = key.objectid;
@@ -4019,10 +3997,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		goto out;
-	}
 	if (!is_fstree(new_root->root_key.objectid)) {
 		ret = -ENOENT;
 		goto out_free;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d166cc742f75..c08aeb83a8f7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -613,7 +613,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
 	struct btrfs_key key;
-	struct btrfs_root *root;
 
 	key.objectid = root_objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -622,12 +621,7 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	else
 		key.offset = (u64)-1;
 
-	root = btrfs_get_fs_root(fs_info, &key, false);
-	if (IS_ERR(root))
-		return root;
-	if (!btrfs_grab_fs_root(root))
-		return ERR_PTR(-ENOENT);
-	return root;
+	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
 static noinline_for_stack
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 25842527fd42..fca8334cb34d 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,8 +257,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
-		if (!err && !btrfs_grab_fs_root(root))
-			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f9ee327d7978..4f21f0b04a17 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -658,10 +658,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
-	if (!btrfs_grab_fs_root(local_root)) {
-		ret = -ENOENT;
-		goto err;
-	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ee2fc9ea9d7e..5ef4c6f75ecd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7200,11 +7200,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				ret = PTR_ERR(clone_root);
 				goto out;
 			}
-			if (!btrfs_grab_fs_root(clone_root)) {
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
-				ret = -ENOENT;
-				goto out;
-			}
 			spin_lock(&clone_root->root_item_lock);
 			if (!btrfs_root_readonly(clone_root) ||
 			    btrfs_root_dead(clone_root)) {
@@ -7246,12 +7241,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			ret = PTR_ERR(sctx->parent_root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(sctx->parent_root)) {
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
-			ret = -ENOENT;
-			sctx->parent_root = ERR_PTR(ret);
-			goto out;
-		}
 
 		spin_lock(&sctx->parent_root->root_item_lock);
 		sctx->parent_root->send_in_progress++;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0c81456df23e..8ce292a47634 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1101,10 +1101,6 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(fs_root);
 			goto err;
 		}
-		if (!btrfs_grab_fs_root(fs_root)) {
-			ret = -ENOENT;
-			goto err;
-		}
 
 		/*
 		 * Walk up the filesystem tree by inode refs until we hit the
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7008def3391b..e194d3e4e3a9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,12 +1637,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(pending->snap)) {
-		ret = -ENOENT;
-		pending->snap = NULL;
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f06ad415faf8..e7525689b1e8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6114,10 +6114,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
-		if (!IS_ERR(wc.replay_dest)) {
-			if (!btrfs_grab_fs_root(wc.replay_dest))
-				wc.replay_dest = ERR_PTR(-ENOENT);
-		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 527b0b41ebdc..4a922b9f6e2c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4382,10 +4382,6 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(subvol_root)) {
-		ret = 1;
-		goto out;
-	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
-- 
2.24.1

