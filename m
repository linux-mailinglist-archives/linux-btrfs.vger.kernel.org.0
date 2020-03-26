Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8A193B0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgCZIet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgCZIes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0652BAC69
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 38/39] btrfs: qgroup: Introduce a new function to get old_roots ulist using backref cache
Date:   Thu, 26 Mar 2020 16:33:15 +0800
Message-Id: <20200326083316.48847-39-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, get_old_roots() will replace the old
btrfs_find_all_roots() to do a backref cache based search for all
referring roots.

The workflow includes:
- Search the extent tree to get basic tree info
  Including: first key, level and owner (from btrfs_header).

- Skip all non-subvolume tree blocks
  Since non-subvolume tree blocks will never be shared with subvolume
  trees, skipping them would speed up the procedure.

- Build backref cache for the tree block
  Either we get the backref_node inserted into the cache, or it's
  referred exclusively by reloc tree which doesn't contribute to qgroup.

- Find all roots using the return backref_node
  It's a simple iterative depth-first search. The result will be stored
  into a ulist, just like old btrfs_find_all_roots().

- Verify the cached result with old btrfs_find_all_roots() for DEBUG
  build
  If we enabled CONFIG_BTRFS_FS_CHECK_INTEGRITY, we again call
  btrfs_find_all_roots() just as what we used to do.
  Then verify the result against the result from backref cache.

  This is very performance heavy as it kills all the benefit we get from
  backref cache, thus should only be enabled for DEBUG build.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 07a0101836ff..ab19b2bfa112 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1938,6 +1938,115 @@ static int iterate_all_roots(struct btrfs_backref_node *node,
 	return ret;
 }
 
+static struct ulist *get_old_roots(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct ulist *tree_blocks = NULL;
+	struct btrfs_path *path = NULL;
+	struct btrfs_key key;
+	struct ulist_iterator uiter;
+	struct ulist_node *unode;
+	struct ulist *ret_ulist;
+	u64 extent_flag;
+	int ret;
+
+	ret_ulist = ulist_alloc(GFP_NOFS);
+	if (!ret_ulist)
+		return ERR_PTR(-ENOMEM);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	ret = extent_from_logical(fs_info, bytenr, path, &key, &extent_flag);
+	if (ret == -ENOENT) {
+		/* No backref for this extent, returning empty old_root */
+		ret = 0;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	if (extent_flag & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+		tree_blocks = ulist_alloc(GFP_NOFS);
+		if (!tree_blocks) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = ulist_add(tree_blocks, bytenr, 0, GFP_NOFS);
+		if (ret < 0)
+			goto out;
+	} else {
+		ret = btrfs_find_all_leafs(NULL, fs_info, bytenr, 0,
+				&tree_blocks, NULL, true);
+		if (ret < 0)
+			goto out;
+	}
+	btrfs_release_path(path);
+
+	/*
+	 * Add all related tree blocks to backref cache and get all roots
+	 * from each iteration
+	 */
+	ULIST_ITER_INIT(&uiter);
+	while ((unode = ulist_next(tree_blocks, &uiter))) {
+		struct btrfs_backref_node *node;
+		struct btrfs_key node_key;
+		u64 owner;
+		u8 tree_level;
+
+		ret = get_tree_info(fs_info, path, unode->val,
+				&node_key, &owner, &tree_level);
+		if (ret < 0)
+			goto out;
+
+		/* Isn't a subvolume tree, direct exist */
+		if (!is_fstree(owner))
+			goto out;
+
+		mutex_lock(&fs_info->qgroup_backref_lock);
+		/*
+		 * This can happen when rescan worker is running while qgroup
+		 * is being disabled.
+		 * Just exit without verification, qgroup will cleanup itself.
+		 */
+		if (!fs_info->qgroup_backref_cache) {
+			mutex_unlock(&fs_info->qgroup_backref_lock);
+			goto out_no_verify;
+		}
+
+		node = qgroup_backref_cache_build(fs_info, &node_key,
+				tree_level, unode->val, owner);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			mutex_unlock(&fs_info->qgroup_backref_lock);
+			goto out;
+		}
+		if (node)
+			ret = iterate_all_roots(node, ret_ulist);
+		mutex_unlock(&fs_info->qgroup_backref_lock);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	if (IS_ENABLED(CONFIG_BTRFS_FS_CHECK_INTEGRITY) && !ret) {
+		ret = verify_old_roots(fs_info, ret_ulist, bytenr);
+		WARN_ON(ret < 0);
+	}
+out_no_verify:
+	btrfs_free_path(path);
+	ulist_free(tree_blocks);
+	if (ret < 0) {
+		ulist_free(ret_ulist);
+		return ERR_PTR(ret);
+	}
+	return ret_ulist;
+}
+
 int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
 				   struct btrfs_qgroup_extent_record *qrecord)
 {
-- 
2.26.0

