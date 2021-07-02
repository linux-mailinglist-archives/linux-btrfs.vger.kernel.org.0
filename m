Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8283BA0B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhGBMus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 08:50:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhGBMur (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 08:50:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15FDF228AD;
        Fri,  2 Jul 2021 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625230095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=sd/Aw2a3PqTG59iNP2A6VCAETRDD7R9SaltFc68GXI0=;
        b=Bn2LwQdo7mVaiYzQNZQQk5Yex4WiKVorexXQb0uCHDa6AkJpYdh4AnWphRY7R19rplfiIH
        DFUtFUisVxZuJC+Ns/iB3IivOewJMDWtlS/QRkkXuP4DTwlIkRRza25xAlUEw0i3hai1VW
        1VzKgXrBczmMbunaKKKboj0BI4Al43k=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CCB9311C84;
        Fri,  2 Jul 2021 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625230095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=sd/Aw2a3PqTG59iNP2A6VCAETRDD7R9SaltFc68GXI0=;
        b=Bn2LwQdo7mVaiYzQNZQQk5Yex4WiKVorexXQb0uCHDa6AkJpYdh4AnWphRY7R19rplfiIH
        DFUtFUisVxZuJC+Ns/iB3IivOewJMDWtlS/QRkkXuP4DTwlIkRRza25xAlUEw0i3hai1VW
        1VzKgXrBczmMbunaKKKboj0BI4Al43k=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ApJ+Lw4L32AQLQAALh3uQQ
        (envelope-from <nborisov@suse.com>); Fri, 02 Jul 2021 12:48:14 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to block-group.c
Date:   Fri,  2 Jul 2021 15:48:13 +0300
Message-Id: <20210702124813.29764-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the final things that must be done to add a new chunk is
allocating its device extents and inserting them in the extent tree.
This is currently done in btrfs_finish_chunk_alloc whose name isn't very
informative. What's more this functino is only used in block-group.c but
is defined as public. There isn't anything special about it that would
warrant it being defined in volumes.c.

Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
block-group.c, make the former static and it to alloc_chunk_dev_extents.
The new name is a lot more explicit about the purpose of the function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>

---
 fs/btrfs/block-group.c | 98 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c     | 92 ---------------------------------------
 fs/btrfs/volumes.h     |  2 -
 3 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c557327b4545..2e133ee61d83 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2236,6 +2236,100 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 }
 
+
+static int alloc_dev_extent(struct btrfs_trans_handle *trans,
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
+static int alloc_chunk_dev_extents(struct btrfs_trans_handle *trans,
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
+		ret = alloc_dev_extent(trans, device, chunk_offset, dev_offset,
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
+		ret = alloc_chunk_dev_extents(trans, block_group->start,
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
2.17.1

