Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854A7507D90
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358525AbiDTAXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbiDTAXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10B2C64F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 854641F758
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGFP9puq3tGcnHIbspzxi6FjlTBkpm4h2GrjAblNRL4=;
        b=k1QnbmCD4rRA6y/s93TM7X0rHUgINKhbi8imbHb7Ub8kNHlg/3NpM/0yzTAQU49Mj8UafA
        KN4il3qw3fO5UCf+x6/KPIJsCB4UDGmljkbhZQQySVkwh7y8upreWqhQc/SkbXROIGkGtr
        2a0KaWTPyO1dhVpjp3sn2KXDvrr6KPQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8E79139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILMsI8NRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 02/10] btrfs-progs: delay chunk and device extent items insertion
Date:   Wed, 20 Apr 2022 08:19:51 +0800
Message-Id: <e963c78e806ce5033d71595fa2bd41f914c51936.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs-progs always insert chunk and device extent items at
btrfs_chunk_alloc() time.

This behavior has one limitation, if we don't have enough space for even
CoWing the chunk and device trees, then we can not allocate new chunks
to fulfill our btrfs_reserve_extent() call.

This is not a problem so far as we always make sure we have enough
space.

But it's going to cause problem for the incoming sprout support at mkfs
time.

As when sprouting the seed fs, initially there is no RW block group at
all, we must allocate new chunks to do anything.

To resolve the problem, we need to delay chunk item insertion, so that
in do_chunk_alloc() we can create new chunk mapping with new block group
cache without triggering tree block CoW.

With block group cache inserted, then we're able to call
btrfs_reserve_extent() and do regular tree block CoW or whatever.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c |   1 -
 kernel-shared/transaction.c |  77 ++++++++++++++++++
 kernel-shared/transaction.h |  12 +++
 kernel-shared/volumes.c     | 154 ++++++++++++++++++++----------------
 kernel-shared/volumes.h     |  10 +++
 5 files changed, 187 insertions(+), 67 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 697a8a1e4dec..da801b1d9926 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1741,7 +1741,6 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 		trans->allocating_chunk = 0;
 		return 0;
 	}
-
 	BUG_ON(ret);
 
 	ret = btrfs_make_block_group(trans, fs_info, 0, flags, start,
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 56828ee1714b..eb4e2b01cd83 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -54,6 +54,8 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
 	root->commit_root = root->node;
 	extent_buffer_get(root->node);
 	INIT_LIST_HEAD(&h->dirty_bgs);
+	INIT_LIST_HEAD(&h->new_chunks);
+	INIT_LIST_HEAD(&h->reserved_dev_extents);
 
 	return h;
 }
@@ -162,16 +164,74 @@ again:
 	return 0;
 }
 
+static int insert_items_for_one_chunk(struct btrfs_trans_handle *trans,
+				      struct map_lookup *map)
+{
+	const u64 dev_extent_len = calc_stripe_length(map->type, map->ce.size,
+						      map->num_stripes);
+	int ret;
+	int i;
+
+	/* Insert dev extents */
+	for (i = 0; i < map->num_stripes; i++) {
+		ret = btrfs_insert_dev_extent(trans, map->stripes[i].dev,
+					      map->ce.start, dev_extent_len,
+					      map->stripes[i].physical);
+		/*
+		 * Since we're delaying chunk allocation, normally there should
+		 * be no dev extent. But there are call sites like btrfs convert
+		 * manually insert dev extents before creating the chunk.
+		 *
+		 * So here we're safe to ignore -EEXIST error.
+		 */
+		if (ret == -EEXIST)
+			ret = 0;
+		if (ret < 0)
+			goto out;
+		ret = btrfs_update_device(trans, map->stripes[i].dev);
+		if (ret < 0)
+			goto out;
+
+	}
+	/* Insert chunk item */
+	ret = btrfs_insert_chunk_item(trans, map);
+out:
+	return ret;
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root)
 {
 	u64 transid = trans->transid;
 	int ret = 0;
+	struct map_lookup *map;
+	struct map_lookup *tmp;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_space_info *sinfo;
 
 	if (trans->fs_info->transaction_aborted)
 		return -EROFS;
+
+	/* Finish the items insert for new chunks */
+	list_for_each_entry_safe(map, tmp, &trans->new_chunks, list) {
+		ret = insert_items_for_one_chunk(trans, map);
+		if (ret < 0)
+			goto error;
+		list_del_init(&map->list);
+	}
+	/*
+	 * And cleanup the reserved extents, they have been inserted into dev
+	 * tree in above insert_items_for_one_chunk().
+	 */
+	while (!list_empty(&trans->reserved_dev_extents)) {
+		struct btrfs_reserved_dev_extent *reserved;
+
+		reserved = list_entry(trans->reserved_dev_extents.next,
+				struct btrfs_reserved_dev_extent, list);
+		list_del_init(&reserved->list);
+		free(reserved);
+	}
+
 	/*
 	 * Flush all accumulated delayed refs so that root-tree updates are
 	 * consistent
@@ -249,6 +309,23 @@ error:
 	return ret;
 }
 
+int btrfs_add_reserved_device_extent(struct btrfs_trans_handle *trans,
+				     struct btrfs_device *dev, u64 physical,
+				     u64 length)
+{
+	struct btrfs_reserved_dev_extent *reserved;
+
+	reserved = malloc(sizeof(*reserved));
+	if (!reserved)
+		return -ENOMEM;
+
+	reserved->dev = dev;
+	reserved->length = length;
+	reserved->physical = physical;
+	list_add_tail(&reserved->list, &trans->reserved_dev_extents);
+	return 0;
+}
+
 void btrfs_abort_transaction(struct btrfs_trans_handle *trans, int error)
 {
 	trans->fs_info->transaction_aborted = error;
diff --git a/kernel-shared/transaction.h b/kernel-shared/transaction.h
index 599cc95408de..b325cbe8ea3e 100644
--- a/kernel-shared/transaction.h
+++ b/kernel-shared/transaction.h
@@ -37,6 +37,15 @@ struct btrfs_trans_handle {
 	struct btrfs_block_group *block_group;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct list_head dirty_bgs;
+	struct list_head new_chunks;
+	struct list_head reserved_dev_extents;
+};
+
+struct btrfs_reserved_dev_extent {
+	struct list_head list;
+	struct btrfs_device *dev;
+	u64 physical;
+	u64 length;
 };
 
 struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
@@ -48,5 +57,8 @@ int commit_tree_roots(struct btrfs_trans_handle *trans,
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root);
 void btrfs_abort_transaction(struct btrfs_trans_handle *trans, int error);
+int btrfs_add_reserved_device_extent(struct btrfs_trans_handle *trans,
+				     struct btrfs_device *dev, u64 physical,
+				     u64 length);
 
 #endif
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index c61fb51c4def..923e1a9378d5 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -653,6 +653,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 				      u64 num_bytes, u64 search_start,
 				      u64 *start, u64 *len)
 {
+	struct btrfs_trans_handle *trans = device->fs_info->running_transaction;
 	struct btrfs_root *root = device->dev_root;
 	struct btrfs_path path = { 0 };
 	struct btrfs_key key;
@@ -735,6 +736,21 @@ next:
 		cond_resched();
 	}
 
+	/* Add reserved dev extents into @used_root */
+	if (trans) {
+		struct btrfs_reserved_dev_extent *reserved;
+
+		list_for_each_entry(reserved, &trans->reserved_dev_extents,
+				    list) {
+			if (reserved->dev != device)
+				continue;
+
+			ret = add_merge_cache_extent(&used_root,
+					reserved->physical, reserved->length);
+			if (ret < 0)
+				goto out;
+		}
+	}
 again:
 	/*
 	 * Now used_root contains all the dev extents. Iterate through the tree
@@ -795,7 +811,6 @@ again:
 		ret = -ENOSPC;
 	else
 		ret = 0;
-
 out:
 	btrfs_release_path(&path);
 	free_extent_cache_tree(&used_root);
@@ -863,26 +878,12 @@ err:
 	return ret;
 }
 
-/*
- * Allocate one free dev extent and insert it into the fs.
- */
-static int btrfs_alloc_dev_extent(struct btrfs_trans_handle *trans,
-				  struct btrfs_device *device,
-				  u64 chunk_offset, u64 num_bytes, u64 *start)
-{
-	int ret;
-
-	ret = find_free_dev_extent(device, num_bytes, start, NULL);
-	if (ret)
-		return ret;
-	return btrfs_insert_dev_extent(trans, device, chunk_offset, num_bytes,
-					*start);
-}
-
 static int find_next_chunk(struct btrfs_fs_info *fs_info, u64 *offset)
 {
+	struct btrfs_trans_handle *trans = fs_info->running_transaction;
 	struct btrfs_root *root = fs_info->chunk_root;
 	struct btrfs_path *path;
+	u64 new_chunk_end = 0;
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_chunk *chunk;
@@ -917,6 +918,16 @@ static int find_next_chunk(struct btrfs_fs_info *fs_info, u64 *offset)
 				btrfs_chunk_length(path->nodes[0], chunk);
 		}
 	}
+
+	/* Still need to check the new chunks to avoid conflicts */
+	if (trans && !list_empty(&trans->new_chunks)) {
+		struct map_lookup *map;
+
+		list_for_each_entry(map, &trans->new_chunks, list)
+			new_chunk_end = max(new_chunk_end, map->ce.start +
+					    map->ce.size);
+		*offset = max(*offset, new_chunk_end);
+	}
 	ret = 0;
 error:
 	btrfs_free_path(path);
@@ -1362,10 +1373,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 			struct btrfs_fs_info *info, struct alloc_chunk_ctl *ctl,
 			struct list_head *private_devs)
 {
-	struct btrfs_root *chunk_root = info->chunk_root;
-	struct btrfs_stripe *stripes;
 	struct btrfs_device *device = NULL;
-	struct btrfs_chunk *chunk;
 	struct list_head *dev_list = &info->fs_devices->devices;
 	struct list_head *cur;
 	struct map_lookup *map;
@@ -1387,22 +1395,14 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 	key.offset = offset;
 
-	chunk = kmalloc(btrfs_chunk_item_size(ctl->num_stripes), GFP_NOFS);
-	if (!chunk)
-		return -ENOMEM;
-
 	map = kmalloc(btrfs_map_lookup_size(ctl->num_stripes), GFP_NOFS);
-	if (!map) {
-		kfree(chunk);
+	if (!map)
 		return -ENOMEM;
-	}
 
-	stripes = &chunk->stripe;
 	ctl->num_bytes = chunk_bytes_by_type(ctl);
 	index = 0;
 	while (index < ctl->num_stripes) {
 		u64 dev_offset;
-		struct btrfs_stripe *stripe;
 
 		BUG_ON(list_empty(private_devs));
 		cur = private_devs->next;
@@ -1414,45 +1414,30 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 			list_move(&device->dev_list, dev_list);
 
 		if (!ctl->dev_offset) {
-			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-					ctl->stripe_size, &dev_offset);
+			ret = find_free_dev_extent(device, ctl->stripe_size, &dev_offset, NULL);
+			if (ret < 0)
+				goto out_chunk_map;
+			/*
+			 * Add this dev extent to trans::reserved_dev_ext, to
+			 * prevent allocation from the allocated one.
+			 */
+			ret = btrfs_add_reserved_device_extent(trans, device,
+					dev_offset, ctl->stripe_size);
 			if (ret < 0)
 				goto out_chunk_map;
 		} else {
 			dev_offset = ctl->dev_offset;
-			ret = btrfs_insert_dev_extent(trans, device, key.offset,
-						      ctl->stripe_size,
-						      ctl->dev_offset);
-			BUG_ON(ret);
 		}
 
 		ASSERT(!zone_size || IS_ALIGNED(dev_offset, zone_size));
 
 		device->bytes_used += ctl->stripe_size;
-		ret = btrfs_update_device(trans, device);
-		if (ret < 0)
-			goto out_chunk_map;
-
 		map->stripes[index].dev = device;
 		map->stripes[index].physical = dev_offset;
-		stripe = stripes + index;
-		btrfs_set_stack_stripe_devid(stripe, device->devid);
-		btrfs_set_stack_stripe_offset(stripe, dev_offset);
-		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
 		index++;
 	}
 	BUG_ON(!list_empty(private_devs));
 
-	/* key was set above */
-	btrfs_set_stack_chunk_length(chunk, ctl->num_bytes);
-	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
-	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
-	btrfs_set_stack_chunk_type(chunk, ctl->type);
-	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
-	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
-	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
-	btrfs_set_stack_chunk_sub_stripes(chunk, ctl->sub_stripes);
 	map->sector_size = info->sectorsize;
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
@@ -1461,9 +1446,6 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	map->num_stripes = ctl->num_stripes;
 	map->sub_stripes = ctl->sub_stripes;
 
-	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
-				btrfs_chunk_item_size(ctl->num_stripes));
-	BUG_ON(ret);
 	ctl->start = key.offset;
 
 	map->ce.start = key.offset;
@@ -1472,21 +1454,16 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	ret = insert_cache_extent(&info->mapping_tree.cache_tree, &map->ce);
 	if (ret < 0)
 		goto out_chunk_map;
+	/*
+	 * Add the new chunk to new_chunks list so at commit trans time we can
+	 * finish the items insert.
+	 */
+	list_add(&map->list, &trans->new_chunks);
 
-	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM) {
-		ret = btrfs_add_system_chunk(info, &key,
-			    chunk, btrfs_chunk_item_size(ctl->num_stripes));
-		if (ret < 0)
-			goto out_chunk;
-	}
-
-	kfree(chunk);
 	return ret;
 
 out_chunk_map:
 	kfree(map);
-out_chunk:
-	kfree(chunk);
 	return ret;
 }
 
@@ -1594,6 +1571,51 @@ again:
 	return ret;
 }
 
+int btrfs_insert_chunk_item(struct btrfs_trans_handle *trans,
+			    struct map_lookup *map)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_stripe *stripe;
+	struct btrfs_chunk *chunk;
+	struct btrfs_key key;
+	int i;
+	int ret;
+
+	chunk = malloc(btrfs_chunk_item_size(map->num_stripes));
+	if (!chunk)
+		return -ENOMEM;
+
+	btrfs_set_stack_chunk_length(chunk, map->ce.size);
+	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
+	btrfs_set_stack_chunk_stripe_len(chunk, map->stripe_len);
+	btrfs_set_stack_chunk_type(chunk, map->type);
+	btrfs_set_stack_chunk_num_stripes(chunk, map->num_stripes);
+	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
+	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
+	btrfs_set_stack_chunk_sector_size(chunk, fs_info->sectorsize);
+	btrfs_set_stack_chunk_sub_stripes(chunk, map->sub_stripes);
+	for (i = 0, stripe = &chunk->stripe; i < map->num_stripes;
+	     i++, stripe++) {
+		struct btrfs_device *device = map->stripes[i].dev;
+
+		btrfs_set_stack_stripe_devid(stripe, device->devid);
+		btrfs_set_stack_stripe_offset(stripe, map->stripes[i].physical);
+		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
+	}
+
+	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = map->ce.start;
+	ret = btrfs_insert_item(trans, fs_info->chunk_root, &key, chunk,
+				btrfs_chunk_item_size(map->num_stripes));
+	if (ret < 0)
+		return ret;
+	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM)
+		ret = btrfs_add_system_chunk(fs_info, &key, chunk,
+				btrfs_chunk_item_size(map->num_stripes));
+	return ret;
+}
+
 /*
  * Alloc a DATA chunk with SINGLE profile.
  *
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 6e9103a933b7..2beae2d02fad 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -113,6 +113,14 @@ struct btrfs_multi_bio {
 
 struct map_lookup {
 	struct cache_extent ce;
+
+	/*
+	 * Newly allocated chunk map will be added to trans::new_chunks,
+	 * and its chunk/dev_extent/block_group items will be inserted into
+	 * the trees at transaction commit time.
+	 */
+	struct list_head list;
+
 	u64 type;
 	int io_align;
 	int io_width;
@@ -264,6 +272,8 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		      u64 *num_bytes, u64 type);
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *fs_info, u64 *start, u64 num_bytes);
+int btrfs_insert_chunk_item(struct btrfs_trans_handle *trans,
+			    struct map_lookup *map);
 int btrfs_open_devices(struct btrfs_fs_info *fs_info,
 		       struct btrfs_fs_devices *fs_devices, int flags);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.35.1

