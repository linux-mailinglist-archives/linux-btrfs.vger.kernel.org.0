Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8367D176FCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCCHPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:56788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgCCHPQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5D39ADC9
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/19] btrfs: relocation: Add backref_cache::fs_info member
Date:   Tue,  3 Mar 2020 15:13:55 +0800
Message-Id: <20200303071409.57982-6-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add this member so that we can grab fs_info without the help from
reloc_control.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 4ad1193c78e0..e1438425cf59 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -286,6 +286,8 @@ struct backref_cache {
 
 	/* The list of useless backref nodes during backref cache build */
 	struct list_head useless_node;
+
+	struct btrfs_fs_info *fs_info;
 };
 
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 413a83d1d9f1..0fb9ceb2665e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -185,10 +185,12 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_init(struct backref_cache *cache, int is_reloc)
+static void backref_cache_init(struct btrfs_fs_info *fs_info,
+			       struct backref_cache *cache, int is_reloc)
 {
 	int i;
 	cache->rb_root = RB_ROOT;
+	cache->fs_info = fs_info;
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		INIT_LIST_HEAD(&cache->pending[i]);
 	INIT_LIST_HEAD(&cache->changed);
@@ -579,14 +581,13 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
-static int handle_one_tree_backref(struct reloc_control *rc,
+static int handle_one_tree_backref(struct backref_cache *cache,
 				   struct btrfs_path *path,
 				   struct btrfs_key *ref_key,
 				   struct btrfs_key *tree_key,
 				   struct backref_node *cur)
 {
-	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct list_head *useless_node = &cache->useless_node;
 	struct list_head *pending_edge = &cache->pending_edge;
 	struct backref_node *upper;
@@ -777,13 +778,12 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 	return ret;
 }
 
-static int handle_one_tree_block(struct reloc_control *rc,
+static int handle_one_tree_block(struct backref_cache *cache,
 				 struct btrfs_path *path,
 				 struct btrfs_backref_iter *iter,
 				 struct btrfs_key *node_key,
 				 struct backref_node *cur)
 {
-	struct backref_cache *cache = &rc->backref_cache;
 	struct backref_edge *edge;
 	struct backref_node *exist;
 	int ret;
@@ -867,7 +867,7 @@ static int handle_one_tree_block(struct reloc_control *rc,
 			continue;
 		}
 
-		ret = handle_one_tree_backref(rc, path, &key, node_key, cur);
+		ret = handle_one_tree_backref(cache, path, &key, node_key, cur);
 		if (ret < 0)
 			goto out;
 	}
@@ -1109,7 +1109,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 	/* Breadth-first search to build backref cache */
 	while (1) {
-		ret = handle_one_tree_block(rc, path, iter, node_key, cur);
+		ret = handle_one_tree_block(cache, path, iter, node_key, cur);
 		if (ret < 0) {
 			err = ret;
 			goto out;
@@ -4307,7 +4307,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
-	backref_cache_init(&rc->backref_cache, 1);
+	backref_cache_init(fs_info, &rc->backref_cache, 1);
 	mapping_tree_init(&rc->reloc_root_tree);
 	extent_io_tree_init(fs_info, &rc->processed_blocks,
 			    IO_TREE_RELOC_BLOCKS, NULL);
-- 
2.25.1

