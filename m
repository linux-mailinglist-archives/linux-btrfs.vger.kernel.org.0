Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43D2261D71
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgIHThS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgIHP4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Sep 2020 11:56:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B7C061265
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 08:43:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so12261266qtd.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Sep 2020 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBF9JbBQdBRPB15TaoVbqxfDvLEoxpdpKgfc2rwyT1g=;
        b=RbXH5bbbGAoWhEZutgVAV8VAq2MLKgkI3I/78bSqelPpmASDXtPVFs7N5aFNHFUH6f
         vFNRZOGt8Wr9hMybKEyXIu1WSWQno2icg7tKAvye0tdMFT04qfPD01+CPSvP97fw6kyZ
         KnzNo0ZmLE2nrmEv8dB2/CEfbY60yv1s1e7nPd2me0oWdaNv5gsTEa90hjcoViBgLNds
         ibMFYjs7SkBmfqrDco4v37TZCZXR3crI1yvApncJLiRU2WykUcAaqPUKlb/pukzm0seJ
         FxnHjI2WSSCAWkVFLtnvCMiTiU4YkS0hliwOoljo1v94XO7Z1g8RyN5BnZUAeSwj6Db9
         lSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBF9JbBQdBRPB15TaoVbqxfDvLEoxpdpKgfc2rwyT1g=;
        b=QbrxTcOYCuND9yNJjqw0V3+S/JLqDJObVQrGOcEt3qRFpSl9e+QNH9j5ddJsxCZls0
         L9Ri92cX4bMO2yxg0IgOKdyi86ne+KStbRnx1G7b9sKjGG4kYB4mtGUImfQBfAwhlSQM
         6FPjTro/VYNJDxbTmc3gXxENuKaX8zhSSr5nZ7+XxGF/3XE90AkgfKXC2OjS4Axgrcw6
         fT2fuqMaUI9/zMYBeZ1J2HbAEfzsI3Z/nfBjzwum+rX6GDkElvoFpCgGRd1512onV1rC
         GLclSwZaVjsPwE8W3XuITuSMUgLqqBnS3pIk1OOOWlSEMzNcgVy+SSL8pAH5bfnh+N6y
         J+aA==
X-Gm-Message-State: AOAM531MeSbrigJPPMEp19Tyu1oIuTMuuqHPE7UmNYjaMblh9ohaB4Gz
        nk7gBiiFODgi53/FnPWeXuaPcKGzUTdjlkRd
X-Google-Smtp-Source: ABdhPJzFQaQmxjh61tTiqeCf/aZVghMiVJADzW5sOHMNrnFTweUqmi9MK3k5gupYhno8c0cBoAp2mA==
X-Received: by 2002:ac8:5b09:: with SMTP id m9mr731638qtw.12.1599579832149;
        Tue, 08 Sep 2020 08:43:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q190sm14547551qkf.20.2020.09.08.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:43:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: introduce rescue=all
Date:   Tue,  8 Sep 2020 11:43:50 -0400
Message-Id: <921662f28b90d7e5a67bb52a1e0b0b2e9584f946.1599579772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the things that came up consistently in talking with Fedora about
switching to btrfs as default is that btrfs is particularly vulnerable
to metadata corruption.  If any of the core global roots are corrupted,
the fs is unmountable and fsck can't usually do anything for you without
some special options.

What we really want is a simple mount option we can tell all users to
try if things are really wrong that are going to give them the highest
chance of allowing them to mount their file system and copy off their
data in the most direct way possible.

Obviously if the fs roots are screwed then the user is in trouble, but
otherwise this makes it much easier to pull stuff off the disk without
needing our special rescue tools.  I tested this with an xfstest that
I've submitted along side this patch that clears the roots and makes
sure we're still able to read the data on the disk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 46 ++++++++++++++++++++++++++
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 73 ++++++++++++++++++++++++++++--------------
 fs/btrfs/inode.c       |  6 +++-
 fs/btrfs/super.c       | 29 +++++++++++++++--
 fs/btrfs/volumes.c     |  7 ++++
 6 files changed, 135 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 01e8ba1da1d3..dfff2b6e7708 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1991,6 +1991,49 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_block_group *bg;
+	struct btrfs_space_info *space_info;
+	struct rb_node *node;
+	int ret = 0;
+
+	for (node = rb_first_cached(&em_tree->map); node;
+	     node = rb_next(node)) {
+		em = rb_entry(node, struct extent_map, rb_node);
+		map = em->map_lookup;
+		bg = btrfs_create_block_group_cache(fs_info, em->start);
+		if (!bg) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		/* Fill dummy cache as FULL */
+		bg->length = em->len;
+		bg->flags = map->type;
+		bg->last_byte_to_unpin = (u64)-1;
+		bg->cached = BTRFS_CACHE_FINISHED;
+		bg->used = em->len;
+		bg->flags = map->type;
+		ret = btrfs_add_block_group_cache(fs_info, bg);
+		if (ret) {
+			btrfs_remove_free_space_cache(bg);
+			btrfs_put_block_group(bg);
+			break;
+		}
+		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
+					0, &space_info);
+		bg->space_info = space_info;
+		link_block_group(bg);
+
+		set_avail_alloc_bits(fs_info, bg->flags);
+	}
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -2001,6 +2044,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
+	if (btrfs_test_opt(info, RESCUE_ALL))
+		return fill_dummy_bgs(info);
+
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 98c5f6178efc..f84b3f67faa4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1275,6 +1275,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_RESCUE_ALL		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7147237d9bf0..f61366a57be4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2303,30 +2303,39 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->extent_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->extent_root = root;
 
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->dev_root = root;
+		btrfs_init_devices_late(fs_info);
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->dev_root = root;
-	btrfs_init_devices_late(fs_info);
 
 	location.objectid = BTRFS_CSUM_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->csum_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->csum_root = root;
 
 	/*
 	 * This tree can share blocks with some other fs tree during relocation
@@ -2335,11 +2344,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_get_fs_root(tree_root->fs_info,
 				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->data_reloc_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->data_reloc_root = root;
 
 	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
@@ -2352,9 +2364,11 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	location.objectid = BTRFS_UUID_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		if (ret != -ENOENT)
-			goto out;
+		if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			ret = PTR_ERR(root);
+			if (ret != -ENOENT)
+				goto out;
+		}
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		fs_info->uuid_root = root;
@@ -2364,11 +2378,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		location.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID;
 		root = btrfs_read_tree_root(tree_root, &location);
 		if (IS_ERR(root)) {
-			ret = PTR_ERR(root);
-			goto out;
+			if (!btrfs_test_opt(fs_info, RESCUE_ALL)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		}  else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->free_space_root = root;
 		}
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->free_space_root = root;
 	}
 
 	return 0;
@@ -3082,6 +3099,14 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	/* Skip bg needs RO and no tree-log to replay */
+	if (btrfs_test_opt(fs_info, RESCUE_ALL) && !sb_rdonly(sb)) {
+		btrfs_err(fs_info,
+			  "rescue=all can only be used on read-only mount");
+		err = -EINVAL;
+		goto fail_alloc;
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cce6f8789a4e..d90c86ac9ebe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2196,7 +2196,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+		!fs_info->csum_root;
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -2851,6 +2852,9 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	if (!root->fs_info->csum_root)
+		return 0;
+
 	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
 	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
 		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..89703c2ec1f3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -360,6 +360,7 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_rescue_all,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -455,6 +456,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_rescue_all, "all"},
 	{Opt_err, NULL},
 };
 
@@ -487,6 +489,11 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
+		case Opt_rescue_all:
+			btrfs_set_and_info(info, RESCUE_ALL,
+					   "only reading fs roots, also setting  nologreplay");
+			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
@@ -1421,6 +1428,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=nologreplay");
+	if (btrfs_test_opt(info, RESCUE_ALL))
+		seq_puts(seq, ",rescue=all");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1858,6 +1867,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
+	if (btrfs_test_opt(fs_info, RESCUE_ALL) !=
+	    (old_opts & BTRFS_MOUNT_RESCUE_ALL)) {
+		btrfs_err(fs_info,
+		"rescue=all mount option can't be changed during remount");
+		ret = -EINVAL;
+		goto restore;
+	}
+
 	btrfs_remount_begin(fs_info, old_opts, *flags);
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
@@ -1924,6 +1941,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
+		if (btrfs_test_opt(fs_info, RESCUE_ALL)) {
+			btrfs_err(fs_info,
+		"remounting read-write with rescue=all is not allowed");
+			ret = -EINVAL;
+			goto restore;
+		}
+
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
 			goto restore;
@@ -2238,8 +2262,9 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * still can allocate chunks and thus are fine using the currently
 	 * calculated f_bavail.
 	 */
-	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	if (btrfs_test_opt(fs_info, RESCUE_ALL) ||
+	    (!mixed && block_rsv->space_info->full &&
+	     total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2a55356ef4a2..614acd4b9988 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7648,6 +7648,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
+	/*
+	 * For rescue=all mount option, we're already RO and are salvaging
+	 * data, no need for such strict check.
+	 */
+	if (btrfs_test_opt(fs_info, RESCUE_ALL))
+		return 0;
+
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-- 
2.26.2

