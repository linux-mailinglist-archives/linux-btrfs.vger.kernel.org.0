Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431273BB9C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhGEJEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 05:04:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEJED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 05:04:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FA411FE07;
        Mon,  5 Jul 2021 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625475686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YHJec7jPUnlgBWQcs4bC0WPyBAozbAcFh5VJLtdo+c=;
        b=Yx2hwWuY+NoHwzCTUE9mlq0p5XfN1fA6GDcyZEF/5SWuObtZRFZ/DaLgirRy/PooCN0xAn
        hwvD7QLWuurwq6HB67xjLDivNcfSy9D+11e5W7r3LpCqaK5o4FqFpz5f6IsQj69BVxDG5T
        YVClabdEJRKr333VO3G6/qmWZX6NA1Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0083213522;
        Mon,  5 Jul 2021 09:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OjbKOGXK4mAWJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 05 Jul 2021 09:01:25 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: make btrfs_finish_chunk_alloc private to block-group.c
Date:   Mon,  5 Jul 2021 12:01:24 +0300
Message-Id: <20210705090124.3402812-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the final things that must be done to add a new chunk is
inserting its device extent items in the extent tree. They describe
the the portion of allocated device physical space during phase 1 of
chunk allocation. This is currently done in btrfs_finish_chunk_alloci
whose name isn't very informative. What's more, this function is only
used in block-group.c but is defined as public. There isn't anything
special about it that would warrant it being defined in volumes.c.

Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
block-group.c, make the former static and rename both functions to
insert_dev_extents and insert_dev_extent respectively.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Give the 2 moved functions better names.
 * Improve changelog to correctly reflect reality.

 fs/btrfs/block-group.c | 98 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c     | 92 ---------------------------------------
 fs/btrfs/volumes.h     |  2 -
 3 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c557327b4545..5c2361168363 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2236,6 +2236,100 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }

+
+static int insert_dev_extent(struct btrfs_trans_handle *trans,
+			    struct btrfs_device *device, u64 chunk_offset,
+			    u64 start, u64 num_bytes)
+{
+	int ret;
+	struct btrfs_path *path;
+	struct btrfs_fs_info *fs_info = device->fs_info;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_dev_extent *extent;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+
+	WARN_ON(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state));
+	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = device->devid;
+	key.offset = start;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+	ret = btrfs_insert_empty_item(trans, root, path, &key,
+				      sizeof(*extent));
+	if (ret)
+		goto out;
+
+	leaf = path->nodes[0];
+	extent = btrfs_item_ptr(leaf, path->slots[0],
+				struct btrfs_dev_extent);
+	btrfs_set_dev_extent_chunk_tree(leaf, extent,
+					BTRFS_CHUNK_TREE_OBJECTID);
+	btrfs_set_dev_extent_chunk_objectid(leaf, extent,
+					    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
+
+	btrfs_set_dev_extent_length(leaf, extent, num_bytes);
+	btrfs_mark_buffer_dirty(leaf);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+
+/*
+ * This function belongs to phase 2.
+ *
+ * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
+ * phases.
+ */
+static int insert_dev_extents(struct btrfs_trans_handle *trans,
+				   u64 chunk_offset, u64 chunk_size)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_device *device;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 dev_offset;
+	u64 stripe_size;
+	int i;
+	int ret = 0;
+
+	em = btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+
+	map = em->map_lookup;
+	stripe_size = em->orig_block_len;
+
+	/*
+	 * Take the device list mutex to prevent races with the final phase of
+	 * a device replace operation that replaces the device object associated
+	 * with the map's stripes, because the device object's id can change
+	 * at any time during that final phase of the device replace operation
+	 * (dev-replace.c:btrfs_dev_replace_finishing()), so we could grab the
+	 * replaced device and then see it with an ID of BTRFS_DEV_REPLACE_DEVID,
+	 * resulting in persisting a device extent item with such ID.
+	 */
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	for (i = 0; i < map->num_stripes; i++) {
+		device = map->stripes[i].dev;
+		dev_offset = map->stripes[i].physical;
+
+		ret = insert_dev_extent(trans, device, chunk_offset, dev_offset,
+				       stripe_size);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+
+	free_extent_map(em);
+	return ret;
+}
+
 /*
  * This function, btrfs_create_pending_block_groups(), belongs to the phase 2 of
  * chunk allocation.
@@ -2270,8 +2364,8 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 			if (ret)
 				btrfs_abort_transaction(trans, ret);
 		}
-		ret = btrfs_finish_chunk_alloc(trans, block_group->start,
-					block_group->length);
+		ret = insert_dev_extents(trans, block_group->start,
+					      block_group->length);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 		add_block_group_free_space(trans, block_group);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6c14315b1c9..f820c32f4a0d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1758,48 +1758,6 @@ static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }

-static int btrfs_alloc_dev_extent(struct btrfs_trans_handle *trans,
-				  struct btrfs_device *device,
-				  u64 chunk_offset, u64 start, u64 num_bytes)
-{
-	int ret;
-	struct btrfs_path *path;
-	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct btrfs_root *root = fs_info->dev_root;
-	struct btrfs_dev_extent *extent;
-	struct extent_buffer *leaf;
-	struct btrfs_key key;
-
-	WARN_ON(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state));
-	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = device->devid;
-	key.offset = start;
-	key.type = BTRFS_DEV_EXTENT_KEY;
-	ret = btrfs_insert_empty_item(trans, root, path, &key,
-				      sizeof(*extent));
-	if (ret)
-		goto out;
-
-	leaf = path->nodes[0];
-	extent = btrfs_item_ptr(leaf, path->slots[0],
-				struct btrfs_dev_extent);
-	btrfs_set_dev_extent_chunk_tree(leaf, extent,
-					BTRFS_CHUNK_TREE_OBJECTID);
-	btrfs_set_dev_extent_chunk_objectid(leaf, extent,
-					    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
-
-	btrfs_set_dev_extent_length(leaf, extent, num_bytes);
-	btrfs_mark_buffer_dirty(leaf);
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
 static u64 find_next_chunk(struct btrfs_fs_info *fs_info)
 {
 	struct extent_map_tree *em_tree;
@@ -5462,56 +5420,6 @@ struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	return block_group;
 }

-/*
- * This function, btrfs_finish_chunk_alloc(), belongs to phase 2.
- *
- * See the comment at btrfs_chunk_alloc() for details about the chunk allocation
- * phases.
- */
-int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
-			     u64 chunk_offset, u64 chunk_size)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_device *device;
-	struct extent_map *em;
-	struct map_lookup *map;
-	u64 dev_offset;
-	u64 stripe_size;
-	int i;
-	int ret = 0;
-
-	em = btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-
-	map = em->map_lookup;
-	stripe_size = em->orig_block_len;
-
-	/*
-	 * Take the device list mutex to prevent races with the final phase of
-	 * a device replace operation that replaces the device object associated
-	 * with the map's stripes, because the device object's id can change
-	 * at any time during that final phase of the device replace operation
-	 * (dev-replace.c:btrfs_dev_replace_finishing()), so we could grab the
-	 * replaced device and then see it with an ID of BTRFS_DEV_REPLACE_DEVID,
-	 * resulting in persisting a device extent item with such ID.
-	 */
-	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	for (i = 0; i < map->num_stripes; i++) {
-		device = map->stripes[i].dev;
-		dev_offset = map->stripes[i].physical;
-
-		ret = btrfs_alloc_dev_extent(trans, device, chunk_offset,
-					     dev_offset, stripe_size);
-		if (ret)
-			break;
-	}
-	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-
-	free_extent_map(em);
-	return ret;
-}
-
 /*
  * This function, btrfs_chunk_alloc_add_chunk_item(), typically belongs to the
  * phase 1 of chunk allocation. It belongs to phase 2 only when allocating system
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 55a8ba244716..70c749eee3ad 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -508,8 +508,6 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical);
-int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
-			     u64 chunk_offset, u64 chunk_size);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
--
2.25.1

