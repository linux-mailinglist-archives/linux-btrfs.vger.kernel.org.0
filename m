Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C917EE7F6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 06:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfJ2FC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 01:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:47608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729216AbfJ2FCz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 01:02:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9A96B1C3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2019 05:02:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 2/2] btrfs: Introduce new mount option to skip block group items scan
Date:   Tue, 29 Oct 2019 13:02:37 +0800
Message-Id: <20191029050237.213038-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029050237.213038-1-wqu@suse.com>
References: <20191029050237.213038-1-wqu@suse.com>
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
 fs/btrfs/block-group.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 29 ++++++++++++++++++++----
 fs/btrfs/super.c       | 25 ++++++++++++++++++++-
 fs/btrfs/volumes.c     |  7 ++++++
 5 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..e5e558e826ef 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1687,6 +1687,53 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_block_group_cache *cache;
+	struct btrfs_space_info *space_info;
+	struct rb_node *node;
+	int ret = 0;
+
+	read_lock(&em_tree->lock);
+	for (node = rb_first_cached(&em_tree->map); node;
+	     node = rb_next(node)) {
+		em = rb_entry(node, struct extent_map, rb_node);
+		map = em->map_lookup;
+		cache = btrfs_create_block_group_cache(fs_info, em->start,
+						       em->len);
+		if (!cache) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Fill dummy cache as FULL */
+		cache->flags = map->type;
+		cache->last_byte_to_unpin = (u64)-1;
+		cache->cached = BTRFS_CACHE_FINISHED;
+		btrfs_set_block_group_used(&cache->item, em->len);
+		btrfs_set_block_group_chunk_objectid(&cache->item, em->start);
+		btrfs_set_block_group_flags(&cache->item, map->type);
+		ret = btrfs_add_block_group_cache(fs_info, cache);
+		if (ret) {
+			btrfs_remove_free_space_cache(cache);
+			btrfs_put_block_group(cache);
+			goto out;
+		}
+		btrfs_update_space_info(fs_info, cache->flags, em->len, em->len,
+					0, &space_info);
+		cache->space_info = space_info;
+		link_block_group(cache);
+
+		set_avail_alloc_bits(fs_info, cache->flags);
+	}
+out:
+	read_unlock(&em_tree->lock);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -1701,6 +1748,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	u64 feature;
 	int mixed;
 
+	if (btrfs_test_opt(info, SKIP_BG))
+		return fill_dummy_bgs(info);
+
 	feature = btrfs_super_incompat_flags(info->super_copy);
 	mixed = !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..ff24b607bc91 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1190,6 +1190,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_SKIP_BG		(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981cf6df9..bb9867eba20f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2327,11 +2327,15 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, SKIP_BG)) {
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
@@ -2973,6 +2977,23 @@ int open_ctree(struct super_block *sb,
 		goto fail_csum;
 	}
 
+	/* Skip bg needs RO and no log tree replay */
+	if (btrfs_test_opt(fs_info, SKIP_BG)) {
+		if (!sb_rdonly(sb)) {
+			btrfs_err(fs_info,
+		"skip_bg mount option can only be used with read-only mount");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+		if (btrfs_super_log_root(disk_super) &&
+		    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
+			btrfs_err(fs_info,
+	"skip_bg must be used with rescue=nologreplay mount option for dirty log");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4cc88173e26d..ab61b0364960 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -328,10 +328,11 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
 
-	/* Rescue options */
+	/* Rescue options, Opt_rescue_* is only for rescue= mount options */
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
+	Opt_rescue_skip_bg,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -428,6 +429,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
+	{Opt_rescue_skip_bg, "skipbg"},
 	{Opt_err, NULL},
 };
 
@@ -460,6 +462,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
+		case Opt_rescue_skip_bg:
+			btrfs_set_and_info(info, SKIP_BG,
+				"skip mount time block group searching");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
@@ -1383,6 +1389,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=no_log_replay");
+	if (btrfs_test_opt(info, SKIP_BG))
+		seq_puts(seq, ",rescue=skip_bg");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD))
@@ -1810,6 +1818,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
+	if (btrfs_test_opt(fs_info, SKIP_BG) !=
+	    (old_opts & BTRFS_MOUNT_SKIP_BG)) {
+		btrfs_err(fs_info,
+		"rescue=skip_bg mount option can't be changed during remount");
+		ret = -EINVAL;
+		goto restore;
+	}
+
 	btrfs_remount_begin(fs_info, old_opts, *flags);
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
@@ -1871,6 +1887,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
+		if (btrfs_test_opt(fs_info, SKIP_BG)) {
+			btrfs_err(fs_info,
+		"remounting read-write with rescue=skip_bg is not allowed");
+			ret = -EINVAL;
+			goto restore;
+		}
+
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
 			goto restore;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cdd7af424033..82f36f370e7b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7775,6 +7775,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	u64 prev_dev_ext_end = 0;
 	int ret = 0;
 
+	/*
+	 * For rescue=skip_bg mount option, we're already RO and are salvaging
+	 * data, no need for such strict check.
+	 */
+	if (btrfs_test_opt(fs_info, SKIP_BG))
+		return 0;
+
 	key.objectid = 1;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
-- 
2.23.0

