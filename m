Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C71C4AD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEEACp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27BF4AEE7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 05/11] btrfs-progs: block-group: Rename write_one_cahce_group()
Date:   Tue,  5 May 2020 08:02:24 +0800
Message-Id: <20200505000230.4454-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The name of this function contains the word "cache", which is left from
the era where btrfs_block_group is called btrfs_block_group_cache.

Now this "cache" doesn't match any thing, and we have better namings for
functions like read/insert/remove_block_group_item().

So rename this function to update_block_group_item().

Since we're here, also rename the local variables to be more like a
Chrismas tree, and rename @extent_root to @root for later reuse.
And replace the BUG_ON() with proper error handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 911fd25f3c6e..89e38e2ed7ae 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1527,25 +1527,28 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, record_parent, 0);
 }
 
-static int write_one_cache_group(struct btrfs_trans_handle *trans,
-				 struct btrfs_path *path,
-				 struct btrfs_block_group *cache)
+static int update_block_group_item(struct btrfs_trans_handle *trans,
+				   struct btrfs_path *path,
+				   struct btrfs_block_group *cache)
 {
-	int ret;
-	struct btrfs_root *extent_root = trans->fs_info->extent_root;
-	unsigned long bi;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group_item bgi;
 	struct extent_buffer *leaf;
+	struct btrfs_root *root;
 	struct btrfs_key key;
+	unsigned long bi;
+	int ret;
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = cache->length;
+	root = fs_info->extent_root;
 
-	ret = btrfs_search_slot(trans, extent_root, &key, path, 0, 1);
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	if (ret > 0)
+		ret = -ENOENT;
 	if (ret < 0)
 		goto fail;
-	BUG_ON(ret);
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
@@ -1555,11 +1558,9 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
-	btrfs_release_path(path);
 fail:
-	if (ret)
-		return ret;
-	return 0;
+	btrfs_release_path(path);
+	return ret;
 
 }
 
@@ -1577,7 +1578,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 		cache = list_first_entry(&trans->dirty_bgs,
 				 struct btrfs_block_group, dirty_list);
 		list_del_init(&cache->dirty_list);
-		ret = write_one_cache_group(trans, path, cache);
+		ret = update_block_group_item(trans, path, cache);
 		if (ret)
 			break;
 	}
-- 
2.26.2

