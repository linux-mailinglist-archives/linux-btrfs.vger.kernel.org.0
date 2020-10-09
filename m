Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D89F289921
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbgJIUJu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391343AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD8C0613AE
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so11826232qkk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ftTs+U31YKAAWO3mY773spMIkOJL5Cg3a24UxQNNEsY=;
        b=ZxOsX6aZJD6InEBZjYGaqJcBsut9GNb2zozwC3QpLExk6kXplyTqCasGB+laEViq+V
         q2dfb9WYcZ4Z2PTZGTS1MV65SE1sTY074ZzZEL1tJTXViBKKzTlKujOysmpSxPn4zkUj
         mPOCgSVFjdWtngF5s2NmjIHgurT0LU6PqiCnoK1Bvh8K66YZxY2lUltZylKiwoNTkjiX
         M4MPWFFxJVcA9E2rmsAQx+XRRj94pzlfacxmYu2tFfwXyQDbcEH0m35sL/yzZPOLr9ZT
         +wv0JVqn14rmgB4RCRTMuyg3yLOoZ2WVOzxyN3qPrS4Nka6nIoOJZ3Ej6AXHfEP9R0T5
         +/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftTs+U31YKAAWO3mY773spMIkOJL5Cg3a24UxQNNEsY=;
        b=K1ooiUy0DkYIo7j54sV5GgRFnAxHwDL28EWr88kz4mAcEnDiC8q+VZQfZOFSzKz6Qc
         Jdki3VkGAu1MnzqU68FIeq8hC7T2hrZeLad8/7goqEMc3L93RcorMYFnmm7SXEZXVcpG
         0hGzFaq7AHlkoN+sJqgp8oZUDQdOLJDxGYjQ4uH568q8RjnHJITJmEfk3Kjm//t9enV6
         zwd0IzIB1xvAh7fwj8swwzPY9eSKQoANq1Q1g+XHjQKe2p+jBrdnekXYBuTmKsZElUj1
         Te3NwSxgyEvZ4GDJQT1cPqDTawhYJAbweVOowwLgFMwc7dVilgCTaGVnPhToMb+sipnP
         6OHg==
X-Gm-Message-State: AOAM533oKgrNdYClwCT3XVVM6MkcuJMFwUMqqk9QTyR5r9kkdTh0hNMu
        3J2h+FRNZtua3+E8UxnCEzeGW0kvHu+8qQuj
X-Google-Smtp-Source: ABdhPJzsxTUKxg1LTqOvzYl/DRHzD9MBMMB4sbv6RuMiVUj1PJL9AXnmWsKYC/VmNCDKu/kM1GtBxQ==
X-Received: by 2002:a05:620a:653:: with SMTP id a19mr15170803qka.440.1602274053460;
        Fri, 09 Oct 2020 13:07:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h4sm6808489qtq.41.2020.10.09.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/8] btrfs: introduce rescue=ignorebadroots
Date:   Fri,  9 Oct 2020 16:07:18 -0400
Message-Id: <2baf880894a1a49b59a369acad832222973d5932.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the face of extent root corruption, or any other core fs wide root
corruption we will fail to mount the file system.  This makes recovery
kind of a pain, because you need to fall back to userspace tools to
scrape off data.  Instead provide a mechanism to gracefully handle bad
roots, so we can at least mount read-only and possibly recover data from
the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 48 +++++++++++++++++++++++++++++++
 fs/btrfs/block-rsv.c   |  8 ++++++
 fs/btrfs/compression.c |  3 +-
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 65 ++++++++++++++++++++++++++----------------
 fs/btrfs/file-item.c   |  3 +-
 fs/btrfs/inode.c       |  6 +++-
 fs/btrfs/super.c       | 11 ++++++-
 fs/btrfs/sysfs.c       |  1 +
 fs/btrfs/volumes.c     | 13 +++++++++
 10 files changed, 131 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0f1d6818df7..7e32f7820543 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1985,6 +1985,51 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
+	if (!ret)
+		btrfs_init_global_block_rsv(fs_info);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -1995,6 +2040,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
+	if (!info->extent_root)
+		return fill_dummy_bgs(info);
+
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 7e1549a84fcc..58b38912498d 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -426,6 +426,14 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->delayed_block_rsv.space_info = space_info;
 	fs_info->delayed_refs_rsv.space_info = space_info;
 
+	/*
+	 * Our various recovery options can leave us with NULL roots, so check
+	 * here and just bail before we go deref'ing NULLS everywhere.
+	 */
+	if (!fs_info->extent_root || !fs_info->csum_root ||
+	    !fs_info->dev_root || !fs_info->chunk_root || !fs_info->tree_root)
+		return;
+
 	fs_info->extent_root->block_rsv = &fs_info->delayed_refs_rsv;
 	fs_info->csum_root->block_rsv = &fs_info->delayed_refs_rsv;
 	fs_info->dev_root->block_rsv = &fs_info->global_block_rsv;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7e1eb57b923c..46dc621f599d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -150,7 +150,8 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	struct compressed_bio *cb = bio->bi_private;
 	u8 *cb_sum = cb->sums;
 
-	if (inode->flags & BTRFS_INODE_NODATASUM)
+	if (!fs_info->csum_root ||
+	    inode->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
 	shash->tfm = fs_info->csum_shash;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..fb3cfd0aaf1e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1295,6 +1295,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..f08887703915 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2247,30 +2247,39 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
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
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
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
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
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
@@ -2279,11 +2288,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_get_fs_root(tree_root->fs_info,
 				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
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
@@ -2296,9 +2308,11 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	location.objectid = BTRFS_UUID_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		if (ret != -ENOENT)
-			goto out;
+		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+			ret = PTR_ERR(root);
+			if (ret != -ENOENT)
+				goto out;
+		}
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		fs_info->uuid_root = root;
@@ -2308,11 +2322,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		location.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID;
 		root = btrfs_read_tree_root(tree_root, &location);
 		if (IS_ERR(root)) {
-			ret = PTR_ERR(root);
-			goto out;
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
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
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8083d71d6af6..90c728652033 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -272,7 +272,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	int count = 0;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+	if (!fs_info->csum_root ||
+	    BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return BLK_STS_OK;
 
 	path = btrfs_alloc_path();
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9f77e9e9c31d..4834a2565dac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2187,7 +2187,8 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+		!fs_info->csum_root;
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -2844,6 +2845,9 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	if (!root->fs_info->csum_root)
+		return 0;
+
 	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
 	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
 		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 833b7eb91536..dccdc670998d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -360,6 +360,7 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_ignorebadroots,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -455,6 +456,8 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_ignorebadroots, "ignorebadroots"},
+	{Opt_ignorebadroots, "ibadroots"},
 	{Opt_err, NULL},
 };
 
@@ -498,6 +501,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
+		case Opt_ignorebadroots:
+			btrfs_set_and_info(info, IGNOREBADROOTS,
+					   "ignoring bad roots");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
@@ -983,7 +990,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	if (new_flags & SB_RDONLY)
 		goto out;
 
-	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay"))
+	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots"))
 		ret = -EINVAL;
 out:
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
@@ -1437,6 +1445,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	print_rescue_option(NOLOGREPLAY, "nologreplay");
 	print_rescue_option(USEBACKUPROOT, "usebackuproot");
+	print_rescue_option(IGNOREBADROOTS, "ignorebadroots");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5c558e65c1ba..c60240d0d7e6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -332,6 +332,7 @@ BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
 static const char *rescue_opts[] = {
 	"usebackuproot",
 	"nologreplay",
+	"ignorebadroots",
 };
 
 static ssize_t supported_rescue_options_show(struct kobject *kobj,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58b9c419a2b6..1dc0b9425a28 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7662,6 +7662,19 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
+	/*
+	 * We don't have a dev_root because we mounted with ignorebadroots and
+	 * failed to load the root, so we want to skip the verification in this
+	 * case for sure.
+	 *
+	 * However if the dev root is fine, but the tree itself is corrupt we'd
+	 * still fail to mount.  This verification is only to make sure writes
+	 * can happen safely, so instead just bypass this check completely in
+	 * the case of IGNOREBADROOTS.
+	 */
+	if (btrfs_test_opt(fs_info, IGNOREBADROOTS))
+		return 0;
+
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-- 
2.26.2

