Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55AD229AD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgGVO6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVO6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:58:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F3C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 07:58:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l23so2262235qkk.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oKSq7q+EXhNpng8BCirBUPr4IwMXUOxC08EKJZBtHk=;
        b=vYeo33m74VLo7ATaWRn2/xgrgPBrpYdo6g/QTRFPPmGkG4h/j5e/zwT5T7KAQoa5dr
         CTAyEWOdQ8X2HIxgQACiw+1uJXhmvTwctHYvBXxPY1bAikIH3dOzawLOkwgBv4pCj4HG
         +YyRyQi4bhJ9uKrbLaRdEmZoPyWdoY1LMZAae1+VXXFqBrzEzJWW9EYUCcwyQr7kklbM
         iJhYozv9eovd7J8uii4ZBZcuLyeXGjJsVxJJVpHE+pA5OXLlcEEpgJb5buaq2ifL0fal
         vpG/bpKkOBC2FXbb5a3eTxdD5FnFneQAPFtL8uJngcuRm+b1jl04QvyhHzRIDt9yvb7I
         Md3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oKSq7q+EXhNpng8BCirBUPr4IwMXUOxC08EKJZBtHk=;
        b=RavETrMBwUlYrg14XZYAZFXJrgI6m+l/nxY5qAn0SjbQYViRHTbHLhwumjAEKAjFHX
         E3mBefSTbITQsu90g2yJzaZfgr9y1j1xH6f3SkCRk4H/JqZmjRrr2rqpedR2clagQnNJ
         2XLEhv/9tIhz2LemnVMKrLjij8A3At1B5LRMqngs5tU9Bx2ALuC8HgUnp3//zePFuAH9
         fCdyUEDEohkYeEP0dRWzT+63QbHaG/arfBCYnASKqQX4JITPXeWqzK8YPigrmn8MI1IY
         VOl1xLPf5EWE6BYW9DAi3F53V4SnvECj5nUIB+L7esf/WTw9ep+C+gbcZJs550oejqX/
         OXxg==
X-Gm-Message-State: AOAM530vmfCK+W3n/doTH2sEt4Awl0yPb6VynqeeIhyJwyZFbw3vcY/e
        jo00bLT5wuyF8NMCRXo3zVLYVT0uNP/Hdg==
X-Google-Smtp-Source: ABdhPJwacu0TxwNiSyHJdVq84W6fRU4xRvRXnn95b643EclugetMkZiod8EPlcsBqQwX1N9senRhmg==
X-Received: by 2002:a37:4ccc:: with SMTP id z195mr346771qka.270.1595429901826;
        Wed, 22 Jul 2020 07:58:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c205sm81273qkg.98.2020.07.22.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 07:58:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v3] btrfs: introduce rescue=all
Date:   Wed, 22 Jul 2020 10:58:19 -0400
Message-Id: <20200722145819.1571-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
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

Qu addressed this sort of with rescue=skipbg, but that's poorly named as
what it really does is just allow you to operate without an extent root.
However there are a lot of other roots, and I'd rather not have to do

mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah

Instead take his original idea and modify it so it just works for
everything.  Turn it into rescue=all, and then any major root we fail
to read just gets left empty and we carry on.

Obviously if the fs roots are screwed then the user is in trouble, but
otherwise this makes it much easier to pull stuff off the disk without
needing our special rescue tools.  I tested this with my TEST_DEV that
had a bunch of data on it by corrupting the csum tree and then reading
files off the disk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Renamed to rescue=all.
- Fixed a lockdep splat from fill_dummy_bgs.
- Only skip csums if we fail to read the csum tree, otherwise use the csums.

 fs/btrfs/block-group.c | 46 +++++++++++++++++++++++++++
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 71 +++++++++++++++++++++++++++++-------------
 fs/btrfs/inode.c       |  6 +++-
 fs/btrfs/super.c       | 29 +++++++++++++++--
 fs/btrfs/volumes.c     |  7 +++++
 6 files changed, 135 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 884de28a41e4..50404e8c3629 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1997,6 +1997,49 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
@@ -2007,6 +2050,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
+	if (btrfs_test_opt(info, RESCUE_ALL))
+		return fill_dummy_bgs(info);
+
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b70c2024296f..93848c2b6eb5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1266,6 +1266,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_RESCUE_ALL		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c850d7f44fbe..805b9e836589 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2326,8 +2326,13 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
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
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	fs_info->extent_root = root;
@@ -2335,21 +2340,27 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2358,11 +2369,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2375,9 +2389,11 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -2387,11 +2403,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
@@ -3106,6 +3125,14 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index 611b3412fbfd..e3d73ee73f80 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2191,7 +2191,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+		!fs_info->csum_root;
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -2846,6 +2847,9 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	if (!root->fs_info->csum_root)
+		return 0;
+
 	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
 	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
 		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58f890f73650..de7a50353239 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -345,6 +345,7 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_rescue_all,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -440,6 +441,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_rescue_all, "all"},
 	{Opt_err, NULL},
 };
 
@@ -472,6 +474,11 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
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
@@ -1400,6 +1407,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=nologreplay");
+	if (btrfs_test_opt(info, RESCUE_ALL))
+		seq_puts(seq, ",rescue=all");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1839,6 +1848,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -1904,6 +1921,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -2208,8 +2232,9 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
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
index 537ccf66ee20..2d7b57303fe5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7628,6 +7628,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
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
2.24.1

