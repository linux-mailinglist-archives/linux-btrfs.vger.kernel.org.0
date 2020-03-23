Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21A718F2A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCWKYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:24:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgCWKYk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:24:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC40EADF1;
        Mon, 23 Mar 2020 10:24:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 04/40] btrfs: relocation: Rename mark_block_processed() and __mark_block_processed()
Date:   Mon, 23 Mar 2020 18:23:40 +0800
Message-Id: <20200323102416.112862-5-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two functions are weirdly named, mark_block_processed() in fact
just mark a range dirty unconditionally, while __mark_block_processed()
does extra check before doing the marking.

This patch will open code old mark_block_processed, and rename
__mark_block_processed() to remove the "__" prefix.

Since we're here, also kill the forward declaration, which could also
kill in_block_group() with in_range() macro.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 56 +++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6b548439ab6f..ad7724d846b7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -236,8 +236,22 @@ struct reloc_control {
 
 static void remove_backref_node(struct backref_cache *cache,
 				struct backref_node *node);
-static void __mark_block_processed(struct reloc_control *rc,
-				   struct backref_node *node);
+
+static void mark_block_processed(struct reloc_control *rc,
+				 struct backref_node *node)
+{
+	u32 blocksize;
+
+	if (node->level == 0 ||
+	    in_range(node->bytenr, rc->block_group->start,
+		     rc->block_group->length)) {
+		blocksize = rc->extent_root->fs_info->nodesize;
+		set_extent_bits(&rc->processed_blocks, node->bytenr,
+				node->bytenr + blocksize - 1, EXTENT_DIRTY);
+	}
+	node->processed = 1;
+}
+
 
 static void mapping_tree_init(struct mapping_tree *tree)
 {
@@ -1104,7 +1118,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			if (list_empty(&lower->upper))
 				list_add(&lower->list, &useless);
 		}
-		__mark_block_processed(rc, upper);
+		mark_block_processed(rc, upper);
 		if (upper->level > 0) {
 			list_add(&upper->list, &cache->detached);
 			upper->detached = 1;
@@ -1570,14 +1584,6 @@ static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 	return NULL;
 }
 
-static int in_block_group(u64 bytenr, struct btrfs_block_group *block_group)
-{
-	if (bytenr >= block_group->start &&
-	    bytenr < block_group->start + block_group->length)
-		return 1;
-	return 0;
-}
-
 /*
  * get new location of data
  */
@@ -1675,7 +1681,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		if (bytenr == 0)
 			continue;
-		if (!in_block_group(bytenr, rc->block_group))
+		if (!in_range(bytenr, rc->block_group->start,
+			      rc->block_group->length))
 			continue;
 
 		/*
@@ -2605,7 +2612,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			ASSERT(next->root);
 			list_add_tail(&next->list,
 				      &rc->backref_cache.changed);
-			__mark_block_processed(rc, next);
+			mark_block_processed(rc, next);
 			break;
 		}
 
@@ -2955,25 +2962,6 @@ static int finish_pending_nodes(struct btrfs_trans_handle *trans,
 	return err;
 }
 
-static void mark_block_processed(struct reloc_control *rc,
-				 u64 bytenr, u32 blocksize)
-{
-	set_extent_bits(&rc->processed_blocks, bytenr, bytenr + blocksize - 1,
-			EXTENT_DIRTY);
-}
-
-static void __mark_block_processed(struct reloc_control *rc,
-				   struct backref_node *node)
-{
-	u32 blocksize;
-	if (node->level == 0 ||
-	    in_block_group(node->bytenr, rc->block_group)) {
-		blocksize = rc->extent_root->fs_info->nodesize;
-		mark_block_processed(rc, node->bytenr, blocksize);
-	}
-	node->processed = 1;
-}
-
 /*
  * mark a block and all blocks directly/indirectly reference the block
  * as processed.
@@ -2992,7 +2980,7 @@ static void update_processed_blocks(struct reloc_control *rc,
 			if (next->processed)
 				break;
 
-			__mark_block_processed(rc, next);
+			mark_block_processed(rc, next);
 
 			if (list_empty(&next->upper))
 				break;
@@ -4744,7 +4732,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		}
 
 		if (first_cow)
-			__mark_block_processed(rc, node);
+			mark_block_processed(rc, node);
 
 		if (first_cow && level > 0)
 			rc->nodes_relocated += buf->len;
-- 
2.25.2

