Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA2140B87
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAQNtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39685 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQNtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:49:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so22694001qko.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RInlyf/mImsi2WuBMMZNA7rwjD2OKhQz3aN9d/bSR7o=;
        b=ORM3sHgmHVChhlfTlkdRXCGEL+VVOMn3mxCCq5nad2PqkCFgt2EltW/yQuTWHNg+0k
         R/WoI+kPOo/1pWIVTajhwL4Bb6GrpNVim6crgs+ktwCtPZs0gN811NOrPOWwSS1YFI+6
         uWVDO9DzDesYTHC8FTETatdFmnCoP5pbp73rppW/rBIENLykRx1Ujl72Yg/9SvFwcIcS
         EtwNA4jBCr7vz3KOKWtOHKPTiGkiZNoKlUVsxIddI98uF2TyN0dESanvjsbEfUFV4jZV
         dK0Hr6lqofhO2D9vpFG/lSN8YBu8MtwQXp4PWtzSKs4YapdYA8IlOgjYGMyUwJBbcew8
         YDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RInlyf/mImsi2WuBMMZNA7rwjD2OKhQz3aN9d/bSR7o=;
        b=nJi1RBWB98a1KthTr+NJ6kFRSoDGDtY7zpi4Z97Bi4h1C2UAKvfXYPsfUqGQWax+5l
         qp0ncB5IhNGmOe+HmwWA53kIktxchg8ykVlwNiqpWJZFp4Utp3T88HtNvzPwkgqxs+AV
         th/5kSRvhwAvagHjDm3PnZnTTJqDglkG+MsNjeiKMh1c+y2ioNTDIYJzKOfds2RAOXqd
         swg7LrQl3Ie34ghrHgtkVe8s36RQy56hNwokVpuPkhI3EQ6sqZqyXZFTSuoD+vi73fUp
         ZizROpjSTBwTaARmqsP7Qlkr5r6Lz6zthYgBc62p5ZBpB8Tm5qtWs593VdLYfsoe0NTp
         KOWg==
X-Gm-Message-State: APjAAAV2WRIUTD1ehnY953Q8QSha/ilLSuuLikHsx9/mJvPGQvMEi4Xe
        /b43tMHmRBgUENaOz5NTbjPFUXpJGJi+gw==
X-Google-Smtp-Source: APXvYqxN0AYLa8WosqY/Wv3DKE6eSV+4/STb+9+3E7QikCPrF+1YvguM5YiCPK00Y6CTzg3BdzPKKQ==
X-Received: by 2002:a05:620a:142c:: with SMTP id k12mr38797521qkj.207.1579268948753;
        Fri, 17 Jan 2020 05:49:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e64sm12746119qtd.45.2020.01.17.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:49:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 40/43] btrfs: move fs_info init work into it's own helper function
Date:   Fri, 17 Jan 2020 08:47:55 -0500
Message-Id: <20200117134758.41494-41-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

