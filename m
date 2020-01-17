Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446401412F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAQV1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47055 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgAQV1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so11570955qtr.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RInlyf/mImsi2WuBMMZNA7rwjD2OKhQz3aN9d/bSR7o=;
        b=dOuMbR8q82yVrMHoByoc6HJ7XzMbOxWnJor54ZEglOdPV/0rNO/DLXTr4mW9tnhEVM
         Fn4PbLl/pBaYFl7qpRkyE+FIxETpEWld44BZV4iZLnj65qxhJjmmtGXDVaHcLzxsISQi
         /gQHSXrcMvZQ2+97qb82R93BqhEo7xYWHICeQuFXEIPCtYFLWqZEG5+8495Fz/T2GfUm
         d4upZr1MsFV/vghLghijjLMUJ7u7T/MEE3BrB/jeDjRi6NLmfqVD5yvwcs1UNu85Hu0Z
         u2Cg66fSyG2UWdJuwdyP+7dRYvbvhyRkI0ZO7Q+oG/pz6nrpIMD4iwTyHflfubdJF3N5
         RITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RInlyf/mImsi2WuBMMZNA7rwjD2OKhQz3aN9d/bSR7o=;
        b=ZaRNfvl/axCrIQufnT7Q2US+z33gMnDxgb6QORi8FZoJhjKfqoPdyriD59H0DFsh5M
         9mwaWyKoSEW9vpkKQcM9fSH7DZ2hbO49vhf09D03C9jlGEK9/TjmocdHPAGoUOM6D8RN
         4/d5HkVP1EMB4/wPJORsquAiwaqwX/BAhpY3PjuGbtMXA6C44LJRp/SHtxzTav1ei3iq
         3s5Uqo0W0ysoRO++RrpEa4xcCLrHzNgzG1sgThMPXinOcPU5hZDRF2nJYuQFb3aFFX1S
         y2pP1NhMLnIoZY8U7c9D7Q1LU8ScnjAnKP7DYvsLDa5bt5D8RtT8bbgzlxL5stCMgXkV
         dLEw==
X-Gm-Message-State: APjAAAUrMhu3zk08uIuYdbuOAESDukhYN8WDK7L/P9VjUCp2dMskEfKB
        fXmyjhOba1cDJ02woqV1QiW75p3pxjLALA==
X-Google-Smtp-Source: APXvYqzd65n6Nsf6SzmEt5KcgI5DnGpXJzh+WQ2TBsD/qbrEjBWHDuyqgNnbRoF7RgI5fywtS/0vDg==
X-Received: by 2002:ac8:4513:: with SMTP id q19mr9554507qtn.253.1579296434291;
        Fri, 17 Jan 2020 13:27:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 201sm12523987qkf.10.2020.01.17.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 40/43] btrfs: move fs_info init work into it's own helper function
Date:   Fri, 17 Jan 2020 16:25:59 -0500
Message-Id: <20200117212602.6737-41-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_ctree mixes initialization of fs stuff and fs_info stuff, which
makes it confusing when doing things like adding the root leak
detection.  Make a separate function that init's all the static
structures inside of the fs_info needed for the fs to operate, and then
call that before we start setting up the fs_info to be mounted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 162 +++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d8adc9c6d8ea..b7e4313bdc6f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2649,68 +2649,9 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-int __cold open_ctree(struct super_block *sb,
-	       struct btrfs_fs_devices *fs_devices,
-	       char *options)
+static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 {
-	u32 sectorsize;
-	u32 nodesize;
-	u32 stripesize;
-	u64 generation;
-	u64 features;
-	u16 csum_type;
-	struct btrfs_key location;
-	struct buffer_head *bh;
-	struct btrfs_super_block *disk_super;
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_root *tree_root;
-	struct btrfs_root *chunk_root;
 	int ret;
-	int err = -EINVAL;
-	int clear_free_space_tree = 0;
-	int level;
-
-	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info,
-					BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
-	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info,
-					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);
-	if (!tree_root || !chunk_root) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	ret = init_srcu_struct(&fs_info->subvol_srcu);
-	if (ret) {
-		err = ret;
-		goto fail;
-	}
-
-	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
-	if (ret) {
-		err = ret;
-		goto fail_srcu;
-	}
-
-	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
-	if (ret) {
-		err = ret;
-		goto fail_srcu;
-	}
-	fs_info->dirty_metadata_batch = PAGE_SIZE *
-					(1 + ilog2(nr_cpu_ids));
-
-	ret = percpu_counter_init(&fs_info->delalloc_bytes, 0, GFP_KERNEL);
-	if (ret) {
-		err = ret;
-		goto fail_srcu;
-	}
-
-	ret = percpu_counter_init(&fs_info->dev_replace.bio_counter, 0,
-			GFP_KERNEL);
-	if (ret) {
-		err = ret;
-		goto fail_srcu;
-	}
 
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
@@ -2774,21 +2715,6 @@ int __cold open_ctree(struct super_block *sb,
 	INIT_LIST_HEAD(&fs_info->ordered_roots);
 	spin_lock_init(&fs_info->ordered_root_lock);
 
-	fs_info->btree_inode = new_inode(sb);
-	if (!fs_info->btree_inode) {
-		err = -ENOMEM;
-		goto fail_srcu;
-	}
-	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
-
-	fs_info->delayed_root = kmalloc(sizeof(struct btrfs_delayed_root),
-					GFP_KERNEL);
-	if (!fs_info->delayed_root) {
-		err = -ENOMEM;
-		goto fail_iput;
-	}
-	btrfs_init_delayed_root(fs_info->delayed_root);
-
 	btrfs_init_scrub(fs_info);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	fs_info->check_integrity_print_mask = 0;
@@ -2799,8 +2725,6 @@ int __cold open_ctree(struct super_block *sb,
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	btrfs_init_btree_inode(fs_info);
-
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->first_logical_byte = (u64)-1;
@@ -2846,12 +2770,93 @@ int __cold open_ctree(struct super_block *sb,
 
 	fs_info->send_in_progress = 0;
 
+	ret = init_srcu_struct(&fs_info->subvol_srcu);
+	if (ret)
+		return ret;
+
+	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
+	if (ret)
+		goto fail;
+
+	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
+	if (ret)
+		goto fail;
+
+	fs_info->dirty_metadata_batch = PAGE_SIZE *
+					(1 + ilog2(nr_cpu_ids));
+
+	ret = percpu_counter_init(&fs_info->delalloc_bytes, 0, GFP_KERNEL);
+	if (ret)
+		goto fail;
+
+	ret = percpu_counter_init(&fs_info->dev_replace.bio_counter, 0,
+			GFP_KERNEL);
+	if (ret)
+		goto fail;
+
+	fs_info->delayed_root = kmalloc(sizeof(struct btrfs_delayed_root),
+					GFP_KERNEL);
+	if (!fs_info->delayed_root) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	btrfs_init_delayed_root(fs_info->delayed_root);
+
 	ret = btrfs_alloc_stripe_hash_table(fs_info);
+	if (ret)
+		goto fail;
+
+	return 0;
+fail:
+	cleanup_srcu_struct(&fs_info->subvol_srcu);
+	return ret;
+}
+
+int __cold open_ctree(struct super_block *sb,
+	       struct btrfs_fs_devices *fs_devices,
+	       char *options)
+{
+	u32 sectorsize;
+	u32 nodesize;
+	u32 stripesize;
+	u64 generation;
+	u64 features;
+	u16 csum_type;
+	struct btrfs_key location;
+	struct buffer_head *bh;
+	struct btrfs_super_block *disk_super;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_root *tree_root;
+	struct btrfs_root *chunk_root;
+	int ret;
+	int err = -EINVAL;
+	int clear_free_space_tree = 0;
+	int level;
+
+	ret = init_fs_info(fs_info, sb);
 	if (ret) {
 		err = ret;
-		goto fail_alloc;
+		goto fail;
 	}
 
+	/* These need to be init'ed before we start creating inodes and such. */
+	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info,
+					BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
+	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info,
+					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);
+	if (!tree_root || !chunk_root) {
+		err = -ENOMEM;
+		goto fail_srcu;
+	}
+
+	fs_info->btree_inode = new_inode(sb);
+	if (!fs_info->btree_inode) {
+		err = -ENOMEM;
+		goto fail_srcu;
+	}
+	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
+	btrfs_init_btree_inode(fs_info);
+
 	invalidate_bdev(fs_devices->latest_bdev);
 
 	/*
@@ -3352,7 +3357,6 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
-fail_iput:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
-- 
2.24.1

