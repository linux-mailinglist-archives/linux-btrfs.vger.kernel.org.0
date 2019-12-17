Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870B912309C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfLQPhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33187 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQPhz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:55 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so4350921qvn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H5OQzTfUbkpobcBIOf/ShOb+3WfGLKryIvpSFu2kwWo=;
        b=RVm0bPTL8GZdeBh7jb5YQZCLnGuUpL4d2B9mH9Y+BBX68BMpoyn+2yJDwG+IwIzNgt
         c5477zlEjhaxHxgH/Gedk15rrH0ppGcSgUkM4JVGVc1pkRsK2M8u3siKOxbizsjFJxnu
         BIZwzKwQ2+kKKINIe9yrf+/Pro5LU7ibC8c1UInFKonAq8QZ/oPMvYEZqt9LbLc0RS3o
         4xZMlZVCBomOFDcR+uKevVONNmj9mqhrcsLLKoHpGUbMK3xrRF3zbFvLFNyeCCvzNYJR
         zq5pWsJmQBRtINilAUlWNxgE27SK1VHREWC68m0dFJWfxz54l3sHvWH7/B1FAfZQGmIT
         X6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5OQzTfUbkpobcBIOf/ShOb+3WfGLKryIvpSFu2kwWo=;
        b=cn+2n981j5R5DXkb0cCWUAkwAPwxvzEWlvZf0Ztt1uYxeGqqzXTnkHJerJ/ubSG3YJ
         HdtAw//5kIUkqobLez16iFNbiYn4QW84q5Yn19b66DPAy/6Jq4Nz9z2CHJ3BFSEiCur1
         nZmUqfzHsQxB1UNvZc6TE9iEyPoHrSzU4FCVFOKkWpbinOFE5HuTfKs88qAYV1L58kI4
         WrkeRIEN+Vb2md5qGw8LdoqgPtbdgW1WJgk5alhHp3QModiEoBYMLkwiaHrdWOsrEcjS
         mq+TXAndqA8/xgajZNoUTEiLd9PmFDFSCOfJHcI+wZyEbKDqHTlErFIah31t7ZYbXRSr
         XPTw==
X-Gm-Message-State: APjAAAW0XQVR0Z1jHXV616Q9aIf31QhA0zucMk9cOPTx//RidO4rVCll
        SyFlIBGVHKPoUo7u46Hq3HeffydxILLNag==
X-Google-Smtp-Source: APXvYqzm+Bc9c1aeJVQxQLm7pRqtuUONGlx79Q0vclXqtP+MV9MMw4g+jvehE5w+MLeLZbG69wNaxw==
X-Received: by 2002:ad4:450a:: with SMTP id k10mr4923805qvu.136.1576597073753;
        Tue, 17 Dec 2019 07:37:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z6sm7063942qkz.101.2019.12.17.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 42/45] btrfs: move fs_info init work into it's own helper function
Date:   Tue, 17 Dec 2019 10:36:32 -0500
Message-Id: <20191217153635.44733-43-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
 fs/btrfs/disk-io.c | 164 +++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 81 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b13f3f6e326d..90d4203818e5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2646,68 +2646,9 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
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
@@ -2771,21 +2712,6 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -2796,8 +2722,6 @@ int __cold open_ctree(struct super_block *sb,
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
-	btrfs_init_btree_inode(fs_info);
-
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->first_logical_byte = (u64)-1;
@@ -2842,12 +2766,91 @@ int __cold open_ctree(struct super_block *sb,
 
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
-	if (ret) {
-		err = ret;
-		goto fail_alloc;
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
+	err = init_fs_info(fs_info, sb);
+	if (err)
+		goto fail;
+
+	/* These need to be init'ed before we start creating inodes and such. */
+	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info,
+					BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
+	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info,
+					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);
+	if (!tree_root || !chunk_root) {
+		err = -ENOMEM;
+		goto fail_srcu;
 	}
 
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
@@ -3354,7 +3357,6 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
-fail_iput:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
-- 
2.23.0

