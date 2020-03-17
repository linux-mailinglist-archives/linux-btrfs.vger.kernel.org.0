Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C9187ADB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgCQIL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:11:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgCQILz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:11:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFA79AD31
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:11:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 07/39] btrfs: relocation: Make reloc root search specific for relocation backref cache
Date:   Tue, 17 Mar 2020 16:10:53 +0800
Message-Id: <20200317081125.36289-8-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

find_reloc_root() searches reloc_control::reloc_root_tree to find the
reloc root.
This behavior is only useful for relocation backref cache.

For the incoming more generic purposed backref cache, we don't care
about who owns the reloc root, but only care if it's a reloc root.

So this patch makes the following modifications to make the reloc root
search more specific to relocation backref:
- Add backref_node::is_reloc_root
  This will be an extra indicator for generic purposed backref cache.
  User doesn't need to read root key from backref_node::root to
  determine if it's a reloc root.
  Also for reloc tree root, it's useless and will be queued to useless
  list.

- Add backref_cache::is_reloc
  This will allow backref cache code to do different behavior for
  generic purposed backref cache and relocation backref cache.

- Make find_reloc_root() to accept fs_info
  Just a personal taste.

- Export find_reloc_root()
  So backref.c can utilize this function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  2 ++
 fs/btrfs/relocation.c | 50 +++++++++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ea5d0675465a..b57bb3e5f1f2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3381,6 +3381,8 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve);
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
+struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
+				   u64 bytenr);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 560a144d5b95..37d102564e72 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -121,6 +121,12 @@ struct backref_node {
 	 * backref node.
 	 */
 	unsigned int detached:1;
+
+	/*
+	 * For generic purpose backref cache, where we only care if it's a reloc
+	 * root, doesn't care the source subvolid.
+	 */
+	unsigned int is_reloc_root:1;
 };
 
 /*
@@ -165,6 +171,14 @@ struct backref_cache {
 	struct list_head useless_node;
 
 	struct btrfs_fs_info *fs_info;
+
+	/*
+	 * Whether this cache is for relocation
+	 *
+	 * Reloction backref cache require more info for reloc root compared
+	 * to generic backref cache.
+	 */
+	unsigned int is_reloc;
 };
 
 /*
@@ -267,7 +281,7 @@ static void mapping_tree_init(struct mapping_tree *tree)
 }
 
 static void backref_cache_init(struct btrfs_fs_info *fs_info,
-			       struct backref_cache *cache)
+			       struct backref_cache *cache, int is_reloc)
 {
 	int i;
 	cache->rb_root = RB_ROOT;
@@ -279,6 +293,7 @@ static void backref_cache_init(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cache->pending_edge);
 	INIT_LIST_HEAD(&cache->useless_node);
 	cache->fs_info = fs_info;
+	cache->is_reloc = is_reloc;
 }
 
 static void backref_cache_cleanup(struct backref_cache *cache)
@@ -651,13 +666,14 @@ static int should_ignore_root(struct btrfs_root *root)
 /*
  * find reloc tree by address of tree root
  */
-static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
-					  u64 bytenr)
+struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
+	struct reloc_control *rc = fs_info->reloc_ctl;
 	struct rb_node *rb_node;
 	struct mapping_node *node;
 	struct btrfs_root *root = NULL;
 
+	ASSERT(rc);
 	spin_lock(&rc->reloc_root_tree.lock);
 	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
 	if (rb_node) {
@@ -701,6 +717,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 {
 	struct btrfs_backref_iter *iter;
 	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
 	struct btrfs_root *root;
 	struct backref_node *cur;
@@ -823,13 +840,24 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
 		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
 			if (key.objectid == key.offset) {
-				/*
-				 * Only root blocks of reloc trees use backref
-				 * pointing to itself.
-				 */
-				root = find_reloc_root(rc, cur->bytenr);
-				ASSERT(root);
-				cur->root = root;
+				cur->is_reloc_root = 1;
+				/* Only reloc backref cache cares exact root */
+				if (cache->is_reloc) {
+					root = find_reloc_root(fs_info,
+							cur->bytenr);
+					if (WARN_ON(!root)) {
+						err = -ENOENT;
+						goto out;
+					}
+					cur->root = root;
+				} else {
+					/*
+					 * For generic purpose backref cache,
+					 * reloc root node is useless.
+					 */
+					list_add(&cur->list,
+						&cache->useless_node);
+				}
 				break;
 			}
 
@@ -4307,7 +4335,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 
 	INIT_LIST_HEAD(&rc->reloc_roots);
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
-	backref_cache_init(fs_info, &rc->backref_cache);
+	backref_cache_init(fs_info, &rc->backref_cache, 1);
 	mapping_tree_init(&rc->reloc_root_tree);
 	extent_io_tree_init(fs_info, &rc->processed_blocks,
 			    IO_TREE_RELOC_BLOCKS, NULL);
-- 
2.25.1

