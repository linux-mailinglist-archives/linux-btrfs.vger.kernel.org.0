Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72B21230B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLQPoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33018 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so7536319qto.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uJ5AnvU0Fiainc6J2R8urnzVehG1Nf2SIF4Un+wMq8w=;
        b=ab4PlJOg+zD/dG8nchYKjTr4rl94kuIbv/uGE4lnE/cAoaYC+CkD5JLQpIZf1COmri
         wNcLJ5jXlnilzruqtsiHk1pvaZn9tYF6ezZlNTPw1XMHFA9u6pf474yTeYPutj0VmPZy
         EnCjn6aqSS25dfLmLHdAtMFkPS4jrtXACQClVCVigkDpZ24fAhPilXqV8G4qSmb6v0Sn
         nlcRCbMM05ohO29UYT4vQJVZNlXbwMYAXeSOIwEnCfKHpFDQwGO4LHJMPUR3FMVjqWhv
         cXfy0WH5lxmHHrKcwMEPOl9THZU6IC/a3u1rm4SngOSPiwINfPyu4Bnroqyt8vfzMJCF
         KKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJ5AnvU0Fiainc6J2R8urnzVehG1Nf2SIF4Un+wMq8w=;
        b=FeagRb4W/gpsSaxjCNW2DzZSyPzLiFR4RvuPUM+x2pFRcegXZJmYwFq+8EhGSevkqX
         AtXD8rfGEyQadrWPsQ+xDiZ64fAl+6GifqKGuP/lW1XNsPsJHHhKc9ScL5xNVVltDyWw
         CtZtrirTaoqbuvYT+YwSlN/JBYv5F3SF0qgJm6+ebdn/IOTRjr+C4Xh9vr1FkP28WKLm
         7/UpriQEMe0QJbPZfTPTImsgSs99SxuQP3ilSlv7yZUhVQJhkdOqF72CZc8v8ASlJ2+U
         fTx+URP8GatPyIfbI+Q717vFspskCozKvalT/+xS14YqE23todzJEyt0E+rdAdvDPY6H
         Jrmw==
X-Gm-Message-State: APjAAAUaU7aK6ofC9Tjl8w7ILAUvaHldpcF8ygHeQkBKEJEYeWV+EhDx
        RTCzwOq1cxYosmtXBh7alTcXLLs1idamIA==
X-Google-Smtp-Source: APXvYqzygJpYC3UXKpDworiBpOlpUHp2zEbZ+m6gjT3p/mSlsRqmBHpJ2NHUA1AXhijawZWyOvgeVA==
X-Received: by 2002:ac8:5156:: with SMTP id h22mr5028690qtn.290.1576597459682;
        Tue, 17 Dec 2019 07:44:19 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g21sm7081525qkl.116.2019.12.17.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: kill the subvol_srcu
Date:   Tue, 17 Dec 2019 10:44:04 -0500
Message-Id: <20191217154404.44831-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have proper root ref counting everywhere we can kill the
subvol_srcu.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c           | 12 +-----------
 fs/btrfs/ctree.h             |  1 -
 fs/btrfs/disk-io.c           | 37 +++++++++---------------------------
 fs/btrfs/export.c            | 21 ++++----------------
 fs/btrfs/file.c              |  5 -----
 fs/btrfs/inode.c             | 14 +-------------
 fs/btrfs/send.c              | 14 --------------
 fs/btrfs/tests/btrfs-tests.c |  9 ---------
 8 files changed, 15 insertions(+), 98 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ded46efac27d..9d0f87df2c35 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -512,23 +512,18 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	int root_level;
 	int level = ref->level;
-	int index;
 
 	root_key.objectid = ref->root_id;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root_key.offset = (u64)-1;
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
-
 	root = btrfs_get_fs_root(fs_info, &root_key, false);
 	if (IS_ERR(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = PTR_ERR(root);
 		goto out_free;
 	}
 
 	if (btrfs_is_testing(fs_info)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -540,10 +535,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	else
 		root_level = btrfs_old_root_level(root, time_seq);
 
-	if (root_level + 1 == level) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
+	if (root_level + 1 == level)
 		goto out;
-	}
 
 	path->lowest_level = level;
 	if (time_seq == SEQ_LAST)
@@ -553,9 +546,6 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		ret = btrfs_search_old_slot(root, &ref->key_for_search, path,
 					    time_seq);
 
-	/* root node has been locked, we can release @subvol_srcu safely here */
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
-
 	btrfs_debug(fs_info,
 		"search slot in root %llu (level %d, ref count %d) returned %d for key (%llu %u %llu)",
 		 ref->root_id, level, ref->count, ret,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fb92c35edadb..a01ff3e0ead4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -655,7 +655,6 @@ struct btrfs_fs_info {
 	struct rw_semaphore cleanup_work_sem;
 
 	struct rw_semaphore subvol_sem;
-	struct srcu_struct subvol_srcu;
 
 	spinlock_t trans_lock;
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9a0b74b4e7f9..fb60d09d2ac7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2806,46 +2806,33 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	ret = init_srcu_struct(&fs_info->subvol_srcu);
-	if (ret)
-		return ret;
-
 	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
 	if (ret)
-		goto fail;
+		return ret;
 
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret)
-		goto fail;
+		return ret;
 
 	fs_info->dirty_metadata_batch = PAGE_SIZE *
 					(1 + ilog2(nr_cpu_ids));
 
 	ret = percpu_counter_init(&fs_info->delalloc_bytes, 0, GFP_KERNEL);
 	if (ret)
-		goto fail;
+		return ret;
 
 	ret = percpu_counter_init(&fs_info->dev_replace.bio_counter, 0,
 			GFP_KERNEL);
 	if (ret)
-		goto fail;
+		return ret;
 
 	fs_info->delayed_root = kmalloc(sizeof(struct btrfs_delayed_root),
 					GFP_KERNEL);
-	if (!fs_info->delayed_root) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!fs_info->delayed_root)
+		return -ENOMEM;
 	btrfs_init_delayed_root(fs_info->delayed_root);
 
-	ret = btrfs_alloc_stripe_hash_table(fs_info);
-	if (ret)
-		goto fail;
-
-	return 0;
-fail:
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
-	return ret;
+	return btrfs_alloc_stripe_hash_table(fs_info);
 }
 
 int __cold open_ctree(struct super_block *sb,
@@ -2880,13 +2867,13 @@ int __cold open_ctree(struct super_block *sb,
 					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);
 	if (!tree_root || !chunk_root) {
 		err = -ENOMEM;
-		goto fail_srcu;
+		goto fail;
 	}
 
 	fs_info->btree_inode = new_inode(sb);
 	if (!fs_info->btree_inode) {
 		err = -ENOMEM;
-		goto fail_srcu;
+		goto fail;
 	}
 	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
 	btrfs_init_btree_inode(fs_info);
@@ -3400,8 +3387,6 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
-fail_srcu:
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
 fail:
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
@@ -3896,9 +3881,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
-	if (btrfs_root_refs(&root->root_item) == 0)
-		synchronize_srcu(&fs_info->subvol_srcu);
-
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
 		btrfs_free_log(NULL, root);
 		if (root->reloc_root) {
@@ -4083,7 +4065,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 	btrfs_close_devices(fs_info->fs_devices);
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
 }
 
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 657fd6ad6e18..7f9dd8384083 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -65,8 +65,6 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	struct btrfs_root *root;
 	struct inode *inode;
 	struct btrfs_key key;
-	int index;
-	int err = 0;
 
 	if (objectid < BTRFS_FIRST_FREE_OBJECTID)
 		return ERR_PTR(-ESTALE);
@@ -75,13 +73,9 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
-
 	root = btrfs_get_fs_root(fs_info, &key, true);
-	if (IS_ERR(root)) {
-		err = PTR_ERR(root);
-		goto fail;
-	}
+	if (IS_ERR(root))
+		return ERR_CAST(root);
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
@@ -89,12 +83,8 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 
 	inode = btrfs_iget(sb, &key, root);
 	btrfs_put_root(root);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto fail;
-	}
-
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	if (check_generation && generation != inode->i_generation) {
 		iput(inode);
@@ -102,9 +92,6 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	}
 
 	return d_obtain_alias(inode);
-fail:
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
-	return ERR_PTR(err);
 }
 
 static struct dentry *btrfs_fh_to_parent(struct super_block *sb, struct fid *fh,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 254fa3cc1ba7..4fadb892af24 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -277,7 +277,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key;
 	struct btrfs_ioctl_defrag_range_args range;
 	int num_defrag;
-	int index;
 	int ret;
 
 	/* get the inode */
@@ -285,8 +284,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
-
 	inode_root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(inode_root)) {
 		ret = PTR_ERR(inode_root);
@@ -302,7 +299,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode);
 		goto cleanup;
 	}
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	/* do a chunk of defrag */
 	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
@@ -338,7 +334,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	iput(inode);
 	return 0;
 cleanup:
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f5664f02e702..c1c6e6afa3bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2687,7 +2687,6 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	u64 lock_start;
 	u64 lock_end;
 	bool merge = false;
-	int index;
 
 	if (prev && prev->root_id == backref->root_id &&
 	    prev->inum == backref->inum &&
@@ -2699,18 +2698,14 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
-
 	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		if (PTR_ERR(root) == -ENOENT)
 			return 0;
 		return PTR_ERR(root);
 	}
 
 	if (btrfs_root_readonly(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		btrfs_put_root(root);
 		return 0;
 	}
@@ -2722,12 +2717,8 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 
 	inode = btrfs_iget(fs_info->sb, &key, root);
 	btrfs_put_root(root);
-	if (IS_ERR(inode)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
+	if (IS_ERR(inode))
 		return 0;
-	}
-
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	/* step 3: relink backref */
 	lock_start = backref->file_pos;
@@ -5886,7 +5877,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct btrfs_root *sub_root = root;
 	struct btrfs_key location;
 	u8 di_type = 0;
-	int index;
 	int ret = 0;
 
 	if (dentry->d_name.len > BTRFS_NAME_LEN)
@@ -5913,7 +5903,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return inode;
 	}
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
 	ret = fixup_tree_root_location(fs_info, dir, dentry,
 				       &location, &sub_root);
 	if (ret < 0) {
@@ -5926,7 +5915,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	}
 	if (root != sub_root)
 		btrfs_put_root(sub_root);
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a7041f270140..16a9d96bbfec 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7065,7 +7065,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	int clone_sources_to_rollback = 0;
 	unsigned alloc_size;
 	int sort_clone_roots = 0;
-	int index;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -7198,11 +7197,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			key.type = BTRFS_ROOT_ITEM_KEY;
 			key.offset = (u64)-1;
 
-			index = srcu_read_lock(&fs_info->subvol_srcu);
-
 			clone_root = btrfs_get_fs_root(fs_info, &key, true);
 			if (IS_ERR(clone_root)) {
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				ret = PTR_ERR(clone_root);
 				goto out;
 			}
@@ -7210,7 +7206,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			if (!btrfs_root_readonly(clone_root) ||
 			    btrfs_root_dead(clone_root)) {
 				spin_unlock(&clone_root->root_item_lock);
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				btrfs_put_root(clone_root);
 				ret = -EPERM;
 				goto out;
@@ -7218,14 +7213,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			if (clone_root->dedupe_in_progress) {
 				dedupe_in_progress_warn(clone_root);
 				spin_unlock(&clone_root->root_item_lock);
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				btrfs_put_root(clone_root);
 				ret = -EAGAIN;
 				goto out;
 			}
 			clone_root->send_in_progress++;
 			spin_unlock(&clone_root->root_item_lock);
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 			sctx->clone_roots[i].root = clone_root;
 			clone_sources_to_rollback = i + 1;
@@ -7239,11 +7232,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
 
-		index = srcu_read_lock(&fs_info->subvol_srcu);
-
 		sctx->parent_root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(sctx->parent_root)) {
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
 			ret = PTR_ERR(sctx->parent_root);
 			goto out;
 		}
@@ -7253,20 +7243,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		if (!btrfs_root_readonly(sctx->parent_root) ||
 				btrfs_root_dead(sctx->parent_root)) {
 			spin_unlock(&sctx->parent_root->root_item_lock);
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
 			ret = -EPERM;
 			goto out;
 		}
 		if (sctx->parent_root->dedupe_in_progress) {
 			dedupe_in_progress_warn(sctx->parent_root);
 			spin_unlock(&sctx->parent_root->root_item_lock);
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
 			ret = -EAGAIN;
 			goto out;
 		}
 		spin_unlock(&sctx->parent_root->root_item_lock);
-
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
 	}
 
 	/*
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index c077f1011797..9c774ef78f79 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -111,14 +111,6 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
-
-	if (init_srcu_struct(&fs_info->subvol_srcu)) {
-		kfree(fs_info->fs_devices);
-		kfree(fs_info->super_copy);
-		kfree(fs_info);
-		return NULL;
-	}
-
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
@@ -162,7 +154,6 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_qgroup_config(fs_info);
 	btrfs_free_fs_roots(fs_info);
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
 	kfree(fs_info->super_copy);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
-- 
2.23.0

