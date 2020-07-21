Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1729422833B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 17:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGUPLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 11:11:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B48C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:11:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so3799440qts.6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzxdjsJlTSooKEgH9lmku2by1keZ1LXHo73wZIsz/m0=;
        b=t7n6UMr7oMWG5HbRhAWPtOeB50Se2ybz9abK4fkGHxUFzaDQCnmtV/xLlMfw2/YIjn
         niE0+CzVD3+4YU1taHVj4QDn0G3UQcI3MWOX694elxLKNYEwJbEr1aaxdA21xqzbh4hT
         39MsiDTUG7sMzdZskrOWC894M+1xGQyABNKas+y1Bh1PwNyusWjmNP8EmfLQZXfvGtgl
         UHkRuCTeuvTUz9ZWPqRZ8Cogv6g8HzIAriw1fMzXdoBCq9z4qBXQB2RVg1DjN5LrmcIb
         xQl5ZuTMnXBru1bFvexTKMXtuLb5R9C6HmkBufBWj7wSSdckW8AmjDGFVLouuL0RcS49
         69WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzxdjsJlTSooKEgH9lmku2by1keZ1LXHo73wZIsz/m0=;
        b=EbAArmGPH2rFyHZbCpB9V37sUp/PHFEhrZqZES3Oh8SEieD0w8aK695s1LAeg/Gpti
         9MeX2W9fthXsdCyZQ6cpHO94yng68Dn6WMHnWAk0wk3GI4Sl61s0sYoPkuvQuHYD0rMW
         ShNqqJbX/7mxc1i+VcEG15nJ8XIPWfTa5ofYBbwWArqdpDgdevVDJoy1qq74fFa3G8n0
         u+ShPFTFshP/mdQbff2vO26tFcpNkJLxWfMOqlSx5Xex3hkXEeeHtbBw/0MHquSI8UAl
         udrtdslgZldcFUf8Sn/sNYsVNo6xjuDNC4Rr+O8Su2p+DyXGVRzaHY+KEYqyt8KfY+M2
         wOhw==
X-Gm-Message-State: AOAM530rz0hlOsCm8ozuMMsBSpFKQIftSecsaQ7Juyqn88pYPjm04F7q
        hrQsZryDcyAnF+2KNBakojpHlbb5MR+fCQ==
X-Google-Smtp-Source: ABdhPJx01/Sy6pdlsBfnjYLgauoBCRnq1FN1laRbOGWO+aXMjBOeoKdCpz1aTNMq0N0Pym6emedsqg==
X-Received: by 2002:ac8:729a:: with SMTP id v26mr29601431qto.362.1595344258828;
        Tue, 21 Jul 2020 08:10:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm22913218qtk.18.2020.07.21.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:10:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: introduce rescue=onlyfs
Date:   Tue, 21 Jul 2020 11:10:57 -0400
Message-Id: <20200721151057.9325-1-josef@toxicpanda.com>
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
everything.  Turn it into rescue=onlyfs, and then any major root we fail
to read just gets left empty and we carry on.

Obviously if the fs roots are screwed then the user is in trouble, but
otherwise this makes it much easier to pull stuff off the disk without
needing our special rescue tools.  I tested this with my TEST_DEV that
had a bunch of data on it by corrupting the csum tree and then reading
files off the disk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Rebase onto recent misc-next.
- Add in the fill_dummy_bgs since skipbg is no longer in this tree.

 fs/btrfs/block-group.c | 49 +++++++++++++++++++++++++++++
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 71 +++++++++++++++++++++++++++++-------------
 fs/btrfs/inode.c       |  6 +++-
 fs/btrfs/super.c       | 29 +++++++++++++++--
 fs/btrfs/volumes.c     |  7 +++++
 6 files changed, 138 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 884de28a41e4..416fc419fd95 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1997,6 +1997,52 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
+	read_lock(&em_tree->lock);
+	for (node = rb_first_cached(&em_tree->map); node;
+	     node = rb_next(node)) {
+		em = rb_entry(node, struct extent_map, rb_node);
+		map = em->map_lookup;
+		bg = btrfs_create_block_group_cache(fs_info, em->start);
+		if (!bg) {
+			ret = -ENOMEM;
+			goto out;
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
+			goto out;
+		}
+		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
+					0, &space_info);
+		bg->space_info = space_info;
+		link_block_group(bg);
+
+		set_avail_alloc_bits(fs_info, bg->flags);
+	}
+out:
+	read_unlock(&em_tree->lock);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -2007,6 +2053,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
+	if (btrfs_test_opt(info, ONLYFS))
+		return fill_dummy_bgs(info);
+
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b70c2024296f..0be7d9461443 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1266,6 +1266,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_ONLYFS		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c850d7f44fbe..0dffa4c12d8c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2326,8 +2326,13 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+			if (!btrfs_test_opt(fs_info, ONLYFS)) {
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
+	if (btrfs_test_opt(fs_info, ONLYFS) && !sb_rdonly(sb)) {
+		btrfs_err(fs_info,
+			  "rescue=onlyfs can only be used on read-only mount");
+		err = -EINVAL;
+		goto fail_alloc;
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 611b3412fbfd..49cd3eba651e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2191,7 +2191,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+		btrfs_test_opt(fs_info, ONLYFS);
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -2846,6 +2847,9 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	if (btrfs_test_opt(root->fs_info, ONLYFS))
+		return 0;
+
 	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
 	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
 		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 58f890f73650..4dc3f35ca7e3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -345,6 +345,7 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_rescue_onlyfs,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -440,6 +441,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_rescue_onlyfs, "onlyfs"},
 	{Opt_err, NULL},
 };
 
@@ -472,6 +474,11 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
+		case Opt_rescue_onlyfs:
+			btrfs_set_and_info(info, ONLYFS,
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
+	if (btrfs_test_opt(info, ONLYFS))
+		seq_puts(seq, ",rescue=onlyfs");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1839,6 +1848,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
+	if (btrfs_test_opt(fs_info, ONLYFS) !=
+	    (old_opts & BTRFS_MOUNT_ONLYFS)) {
+		btrfs_err(fs_info,
+		"rescue=onlyfs mount option can't be changed during remount");
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
 
+		if (btrfs_test_opt(fs_info, ONLYFS)) {
+			btrfs_err(fs_info,
+		"remounting read-write with rescue=onlyfs is not allowed");
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
+	if (btrfs_test_opt(fs_info, ONLYFS) ||
+	    (!mixed && block_rsv->space_info->full &&
+	     total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 537ccf66ee20..e86f78579884 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7628,6 +7628,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
+	/*
+	 * For rescue=onlyfs mount option, we're already RO and are salvaging
+	 * data, no need for such strict check.
+	 */
+	if (btrfs_test_opt(fs_info, ONLYFS))
+		return 0;
+
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-- 
2.24.1

