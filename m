Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6945541C51
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfFLGhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 02:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730957AbfFLGhP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 02:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42369AC40
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:37:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: Introduce new mount option to skip block group items scan
Date:   Wed, 12 Jun 2019 14:36:57 +0800
Message-Id: <20190612063657.21063-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612063657.21063-1-wqu@suse.com>
References: <20190612063657.21063-1-wqu@suse.com>
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
This patch will introduce a new mount option "rescue=skip_bg" to skip
the mount time block group scan, and use chunk info purely to populate
fake block group cache.

The mount option has the following dependency:
- RO mount
  Obviously.

- No dirty log.
  Either there is no log, or use rescue=no_log_replay mount option.

- No way to remoutn RW
  Similar to rescue=no_log_replay option.

This should allow kernel to accept most extent tree corruption, and
salvage data and subvolume info.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 29 ++++++++++++++++++++----
 fs/btrfs/extent-tree.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c       | 24 +++++++++++++++++++-
 fs/btrfs/volumes.c     |  7 ++++++
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..9413db8c9bf0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1441,6 +1441,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_SKIP_BG		(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..9701bf8ffbda 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2330,11 +2330,15 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
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
@@ -2956,6 +2960,23 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
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
+		    !btrfs_test_opt(fs_info, NOTREELOG)) {
+			btrfs_err(fs_info,
+	"skip_bg must be used with notreelog mount option for dirty log");
+			err = -EINVAL;
+			goto fail_alloc;
+		}
+	}
+
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1aee51a9f3bf..aac9b3ce5224 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10292,6 +10292,53 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
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
+		update_space_info(fs_info, cache->flags, em->len, em->len,
+				  0, &space_info);
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
@@ -10306,6 +10353,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	u64 feature;
 	int mixed;
 
+	if (btrfs_test_opt(info, SKIP_BG))
+		return fill_dummy_bgs(info);
+
 	feature = btrfs_super_incompat_flags(info->super_copy);
 	mixed = !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4512f25dcf69..f9b33f175e02 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -340,7 +340,7 @@ enum {
 	Opt_ref_verify,
 #endif
 	/* Rescue options */
-	Opt_rescue, Opt_usebackuproot, Opt_nologreplay,
+	Opt_rescue, Opt_usebackuproot, Opt_nologreplay, Opt_rescue_skip_bg,
 	Opt_err,
 };
 
@@ -416,6 +416,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "use_backup_root"},
 	{Opt_nologreplay, "no_log_replay"},
+	{Opt_rescue_skip_bg, "skip_bg"},
 	{Opt_err, NULL},
 };
 
@@ -448,6 +449,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
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
@@ -1367,6 +1372,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=no_log_replay");
+	if (btrfs_test_opt(info, SKIP_BG))
+		seq_puts(seq, ",rescue=skip_bg");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD))
@@ -1796,6 +1803,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
@@ -1857,6 +1872,13 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
index 1c2a6e4b39da..5d307b2b19d3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7740,6 +7740,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
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
2.22.0

