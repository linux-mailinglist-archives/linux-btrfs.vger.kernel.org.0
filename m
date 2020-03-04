Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43927178C45
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 09:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgCDIJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 03:09:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgCDIJx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 03:09:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A8E6B1A8
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 08:09:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 2/2] btrfs: Introduce new mount option to skip block group items scan
Date:   Wed,  4 Mar 2020 16:09:41 +0800
Message-Id: <20200304080941.50774-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304080941.50774-1-wqu@suse.com>
References: <20200304080941.50774-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are some reports of corrupted fs which can't be mounted due to
corrupted extent tree.

However under such situation, it's more likely the fs/subvolume trees
are still fine.

For such case we normally go btrfs-restore and salvage as much as we
can. However btrfs-restore can't list subvolumes as "btrfs subv list",
making it harder to restore a fs.

[ENHANCEMENT]
This patch will introduce a new mount option "rescue=skipbg" to skip
the mount time block group scan, and use chunk info solely to populate
fake block group cache.

The mount option has the following dependency:
- RO mount
  Obviously.

- No dirty log.
  Either there is no log, or use rescue=nologreplay mount option.

- No way to remoutn RW
  Similar to rescue=nologreplay option.

This allow kernel to accept all extent tree corruption, even when the
whole extent tree is corrupted, and allow user to salvage data and
subvolume info.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 29 +++++++++++++++++++++----
 fs/btrfs/super.c       | 32 ++++++++++++++++++++++++---
 fs/btrfs/volumes.c     |  7 ++++++
 5 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7b003a2df79e..16566e9a039e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1967,6 +1967,52 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
+		bg = btrfs_create_block_group_cache(fs_info, em->start,
+						       em->len);
+		if (!bg) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Fill dummy cache as FULL */
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
@@ -1977,6 +2023,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
+	if (btrfs_test_opt(info, SKIPBG))
+		return fill_dummy_bgs(info);
+
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ea5d0675465a..35abe7709c8b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1238,6 +1238,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_SKIPBG		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 483b54077d01..728ccfb8c828 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2287,11 +2287,15 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, SKIPBG)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+		fs_info->extent_root = NULL;
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->extent_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->extent_root = root;
 
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
@@ -3064,6 +3068,23 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	/* Skip bg needs RO and no log tree replay */
+	if (btrfs_test_opt(fs_info, SKIPBG)) {
+		if (!sb_rdonly(sb)) {
+			btrfs_err(fs_info,
+	"rescue=skipbg mount option can only be used with read-only mount");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+		if (btrfs_super_log_root(disk_super) &&
+		    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
+			btrfs_err(fs_info,
+"rescue=skipbg must be used with rescue=nologreplay mount option for dirty log");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6a2521781bb7..e28f10ec452a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -332,10 +332,11 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
 
-	/* Rescue options */
+	/* Rescue options, Opt_rescue_* is only for rescue= mount options */
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_rescue_skipbg,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -433,6 +434,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_rescue_skipbg, "skipbg"},
 	{Opt_err, NULL},
 };
 
@@ -465,6 +467,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
+		case Opt_rescue_skipbg:
+			btrfs_set_and_info(info, SKIPBG,
+				"skip mount time block group searching");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
@@ -1406,6 +1412,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=nologreplay");
+	if (btrfs_test_opt(info, SKIPBG))
+		seq_puts(seq, ",rescue=skipbg");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1845,6 +1853,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
+	if (btrfs_test_opt(fs_info, SKIPBG) !=
+	    (old_opts & BTRFS_MOUNT_SKIPBG)) {
+		btrfs_err(fs_info,
+		"rescue=skipbg mount option can't be changed during remount");
+		ret = -EINVAL;
+		goto restore;
+	}
+
 	btrfs_remount_begin(fs_info, old_opts, *flags);
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
@@ -1910,6 +1926,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
+		if (btrfs_test_opt(fs_info, SKIPBG)) {
+			btrfs_err(fs_info,
+		"remounting read-write with rescue=skipbg is not allowed");
+			ret = -EINVAL;
+			goto restore;
+		}
+
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
 			goto restore;
@@ -2213,9 +2236,12 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * not fit in the free metadata space.  If we aren't ->full then we
 	 * still can allocate chunks and thus are fine using the currently
 	 * calculated f_bavail.
+	 *
+	 * Or if we're rescuing, set available to 0 anyway.
 	 */
-	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	if (btrfs_test_opt(fs_info, SKIPBG) ||
+	    (!mixed && block_rsv->space_info->full &&
+	     total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 37e79de3256f..ddefa2642f40 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7600,6 +7600,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
+	/*
+	 * For rescue=skipbg mount option, we're already RO and are salvaging
+	 * data, no need for such strict check.
+	 */
+	if (btrfs_test_opt(fs_info, SKIPBG))
+		return 0;
+
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-- 
2.25.1

