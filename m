Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83ED15F879
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgBNVMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35965 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgBNVMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:12:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so7943327qto.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IQBQTZSYxn/YQxIbd9yyaCs1y7sOPUSJvlXLwuPkVJI=;
        b=LTU1v2+pHJCNcSH3BeHIU3CZpAiLO3c51vJaGXBG4G1YKNReaxxEFrKsjiNCWnNQj+
         lESCW6WPm6hEoI72p81U1w5zuE8H75g167QK9SjXH6IYA3L/0zW+0z4Rssoet6kPVrG+
         cIX1m3SsElS4ZUExSN1KyBxiiQHbE7dJPUIXhg8N/IrIbNag2JGgCGPBZOQFWiL1Mamo
         R9zehZIknWGRHc5Heiit4+ZorbzEyiUqLFBydn4Pjs+B/qNuKwm95WAO83Kg5OgyweIE
         6lVs8Y6ebCmLw2cvwNcf435nj4PQPTTJVe4+LY11zZBBiQvsTpkv5Y3C9za8MgqRQorb
         OHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQBQTZSYxn/YQxIbd9yyaCs1y7sOPUSJvlXLwuPkVJI=;
        b=eqpIt8uAIjqqPIIETCznpgw1di0KJ1y7AfcYBCoYPU/A9xiI88CzFykgtKvBlEXlfB
         vx4k7ZPRszPhJhI29YlwsFUVMRMSMvX8DCw2I4Kd0dr8jtLPqAREPoGAGk3G8g8FumaL
         78mzSya/VP8VmTA28S/8LEUVsAr1JepdxJxshVzgi9fVGa8vd5duDVrN8HAbgf4kNVK/
         7YP9hw2gkISpzIvdj144Z6EzF9stv3luf7sKEz46OPxwdp864qF+Pgp1YFoVV1Ss9lT3
         KoGFIhAtHnfILQt6zM8BC11+STe4Gss3WGZu6jQnrE92xxxS14GPZy4/tTVw+jsmakbo
         SChg==
X-Gm-Message-State: APjAAAVnb9W45bPlBNM5P1axOZvNYxLzY8DErgMVzLBAOCUmjFfcAFkp
        ZGE3OTCG2qjg3Sfb8IF1eEdVcNHjF2Y=
X-Google-Smtp-Source: APXvYqwFjj/CKRwKPJ9AXL2Du4Ny7NqazTreAx3kmCD0wx5cm43jtr+FyLg3ClVT03yWN/ISvwWzUg==
X-Received: by 2002:aed:3463:: with SMTP id w90mr4135689qtd.42.1581714723743;
        Fri, 14 Feb 2020 13:12:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o187sm3879055qkf.26.2020.02.14.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: kill the subvol_srcu
Date:   Fri, 14 Feb 2020 16:11:47 -0500
Message-Id: <20200214211147.24610-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
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
 fs/btrfs/inode.c             |  3 ---
 fs/btrfs/send.c              | 14 --------------
 fs/btrfs/tests/btrfs-tests.c |  9 ---------
 8 files changed, 14 insertions(+), 88 deletions(-)

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
index 000ad54629e3..069868a37785 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -696,7 +696,6 @@ struct btrfs_fs_info {
 	struct rw_semaphore cleanup_work_sem;
 
 	struct rw_semaphore subvol_sem;
-	struct srcu_struct subvol_srcu;
 
 	spinlock_t trans_lock;
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ca46ca3e9dca..9159da5b0a67 100644
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
 
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
@@ -2883,13 +2870,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->chunk_root = chunk_root;
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
@@ -3398,8 +3385,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
-fail_srcu:
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
 fail:
 	btrfs_close_devices(fs_info->fs_devices);
 	return err;
@@ -3894,9 +3879,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
-	if (btrfs_root_refs(&root->root_item) == 0)
-		synchronize_srcu(&fs_info->subvol_srcu);
-
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
 		btrfs_free_log(NULL, root);
 		if (root->reloc_root) {
@@ -4095,7 +4077,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
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
index a37feadd9344..5cdcdbdd908b 100644
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
index 338283bb66f1..b2dbfb25c3d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5363,7 +5363,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct btrfs_root *sub_root = root;
 	struct btrfs_key location;
 	u8 di_type = 0;
-	int index;
 	int ret = 0;
 
 	if (dentry->d_name.len > BTRFS_NAME_LEN)
@@ -5390,7 +5389,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return inode;
 	}
 
-	index = srcu_read_lock(&fs_info->subvol_srcu);
 	ret = fixup_tree_root_location(fs_info, dir, dentry,
 				       &location, &sub_root);
 	if (ret < 0) {
@@ -5403,7 +5401,6 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	}
 	if (root != sub_root)
 		btrfs_put_root(sub_root);
-	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6b86841315be..21e1c77832ed 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7066,7 +7066,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	int clone_sources_to_rollback = 0;
 	unsigned alloc_size;
 	int sort_clone_roots = 0;
-	int index;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -7193,11 +7192,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7206,7 +7202,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			    btrfs_root_dead(clone_root)) {
 				spin_unlock(&clone_root->root_item_lock);
 				btrfs_put_root(clone_root);
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				ret = -EPERM;
 				goto out;
 			}
@@ -7214,13 +7209,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				dedupe_in_progress_warn(clone_root);
 				spin_unlock(&clone_root->root_item_lock);
 				btrfs_put_root(clone_root);
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				ret = -EAGAIN;
 				goto out;
 			}
 			clone_root->send_in_progress++;
 			spin_unlock(&clone_root->root_item_lock);
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 			sctx->clone_roots[i].root = clone_root;
 			clone_sources_to_rollback = i + 1;
@@ -7234,11 +7227,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7248,20 +7238,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
index 42e62fd2809c..999c14e5d0bd 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -134,14 +134,6 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 
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
@@ -191,7 +183,6 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	}
 	btrfs_free_qgroup_config(fs_info);
 	btrfs_free_fs_roots(fs_info);
-	cleanup_srcu_struct(&fs_info->subvol_srcu);
 	kfree(fs_info->super_copy);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
-- 
2.24.1

