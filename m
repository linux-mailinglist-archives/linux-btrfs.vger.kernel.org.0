Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C656A68FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 09:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCAIhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 03:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAIho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 03:37:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970238662
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 00:37:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E2911FE15
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677659860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W0byEGiFn7eqL9MhJMHtz7EkT/89atrV55YyT/Dc87w=;
        b=Gn5FmVVZWJJ/5oSFDm+nrqFvOBPSabkRnTSv5jCTH5PiVR1Ahdt/K8DWthwT5+Mft/gHMe
        jYfUZcurVm3eNKt5KbcKZeA4E8mp1FFiAIjbkc6aJUzj+5SZmaSZ4OPQAf7GHxxMUPfStB
        /HNZJNGzJCRMe5xQC0z3lVW8BzkPQck=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF7AE13A3E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 08:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nI4NJtMO/2PoagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 08:37:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion optimization
Date:   Wed,  1 Mar 2023 16:37:22 +0800
Message-Id: <4cb0ec4c8bc6b6aa1777c7d4f7ad1f0de975f6a9.1677659834.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
There is a recent discuss on why btrfs balanace can not convert
RAID1C*/DUP to SINGLE fast.

After all, RAID1C* and DUP are just SINGLE duplicated to one or more
devices.

[ENHANCEMENT]
The basic idea is, we don't need to do the IO intensive relocation, but
just drop the extra device extents, change the profile to SINGLE, then
call it a day.

[IMPLEMENTATION]
This patch would implement such quick path for conversion.

It has the following requirement:

- Source block group profile is RAID1C* or DUP
  Other profiles are either stripe based (RAID0/RAID10/RAID5/RAID6) or
  it's already SINGLE.

- Conversion target is SINGLE
  In theory, RAID1C4 -> RAID1/RAID1C3/SINGLE is also possible, but
  for now let's only allow SINGLE target.

The workflow involves the following changes:

- Shrink chunk_map to SINGLE profile
- Shrink chunk item to SINGLE profile
- Change block group item to SINGLE profile and force it to be updated
- Shrink sys chunk array if needed
- Remove device extents
- Update device used space
- Commit transaction
- Remove the CHUNK_ALLOCATED bits of alloc_state

Only after the final step we can allocate new chunks using the old dev
extents.
Here we use a transaction commitment to make sure any newer writes into
the old dev extents won't affect COW.

And this workflow would shortcut all the current chunk relocation code
(from data reloc inode creation to the removal of the source chunk).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

- This is still a PoC, not fully working
  In-place conversion for metadata can lead to crash, caused by too many
  skipped preparation code in btrfs_relocate_block_group().
  (E.g. we didn't mark the bg RO, nor allocate new bgs, this is the
   direct cause of metadata conversion failure).

  Only data in-place conversion is tested for now.

- Not sure if it's even worthy
  Although we can avoid tons of IO, the use case is still very niche.
  I'd still prefer to do the regular relocation without the
  "optimization", for a better code base.

- Not ideal code structure
  There is no existing infrastructure to just drop one or more stripes
  from a chunk.

  Thus a lot of infrastructure has to be implemented in this patch
  itself.
---
 fs/btrfs/relocation.c | 354 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h |   2 +
 fs/btrfs/volumes.c    |  23 ++-
 fs/btrfs/volumes.h    |   5 +
 4 files changed, 377 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef13a9d4e370..6d37d9ce5763 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3604,6 +3604,360 @@ int prepare_to_relocate(struct reloc_control *rc)
 	return ret;
 }
 
+bool btrfs_can_do_quick_convert(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
+	struct btrfs_balance_args *bargs;
+
+	ASSERT(bctl);
+
+	/* Only mirror based profiles with multiple mirrors can go fast path. */
+	if (!(bg->flags & (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_DUP)))
+		return false;
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
+		bargs = &bctl->data;
+	else if (bg->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		bargs = &bctl->sys;
+	else
+		bargs = &bctl->meta;
+
+	/* For now, we only support quick convert to SINGLE. */
+	if (chunk_to_extended(bargs->target) != BTRFS_AVAIL_ALLOC_BIT_SINGLE)
+		return false;
+	return true;
+}
+
+/*
+ * The max amount of dev extents to drop during quick convert.
+ * So far it's 3 for RAID1C4.
+ */
+#define MAX_VICTIM_STRIPES	(3)
+
+struct victim_stripe {
+	/* If @dev is NULL, this stripe is not in used. */
+	struct btrfs_device *dev;
+	u64 physical;
+};
+
+/* sort the devices in ascending order by total_avail */
+static int cmp_device_info(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	if (di_a->total_avail > di_b->total_avail)
+		return 1;
+	if (di_a->total_avail < di_b->total_avail)
+		return -1;
+	return 0;
+}
+
+static void shrink_chunk_map(struct extent_map *em,
+			     struct victim_stripe *victims)
+{
+	struct map_lookup *map = em->map_lookup;
+	int stripe_nr;
+
+	for (stripe_nr = 0; stripe_nr < map->num_stripes; stripe_nr++) {
+		struct btrfs_io_stripe *stripe = &map->stripes[stripe_nr];
+		int victim_nr;
+
+		for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+			if (stripe->dev == victims[victim_nr].dev &&
+			    stripe->physical == victims[victim_nr].physical) {
+				/* Here we do not shrink the map. */
+				memmove(&map->stripes[stripe_nr],
+					&map->stripes[stripe_nr + 1],
+					sizeof(struct btrfs_io_stripe) *
+					(map->num_stripes - stripe_nr - 1));
+				map->num_stripes--;
+				stripe_nr--;
+			}
+		}
+	}
+	ASSERT(map->num_stripes == 1);
+}
+
+static void shrink_system_chunk_array(struct btrfs_fs_info *fs_info,
+				      struct extent_map *em,
+				      struct victim_stripe *victims)
+{
+	struct btrfs_super_block *super_copy = fs_info->super_copy;
+	const u32 old_array_size = btrfs_super_sys_array_size(super_copy);
+	u32 array_size = old_array_size;
+	u32 cur = 0;
+	u8 *ptr = super_copy->sys_chunk_array;
+
+	while (cur < array_size) {
+		struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)ptr;
+		struct btrfs_chunk *chunk;
+		struct btrfs_key key;
+		int num_stripes;
+		int stripe_nr;
+		u32 old_num_stripes;
+		u32 chunk_item_len;
+
+		btrfs_disk_key_to_cpu(&key, disk_key);
+
+		/* Mount time check should have ensured this. */
+		ASSERT(key.type == BTRFS_CHUNK_ITEM_KEY);
+
+		chunk = (struct btrfs_chunk *)(ptr + sizeof(*disk_key));
+		num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+		chunk_item_len = btrfs_chunk_item_size(num_stripes);
+
+		if (key.offset != em->start)
+			goto next;
+
+		old_num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+		for (stripe_nr = 0; stripe_nr < num_stripes; stripe_nr++) {
+			struct btrfs_stripe *stripe = btrfs_stripe_nr(chunk,
+								      stripe_nr);
+			int victim_nr;
+
+			for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES;
+			     victim_nr++) {
+				if (victims[victim_nr].dev &&
+				    btrfs_stack_stripe_devid(stripe) ==
+				    victims[victim_nr].dev->devid &&
+				    btrfs_stack_stripe_offset(stripe) ==
+				    victims[victim_nr].physical) {
+					memmove(stripe, stripe + 1,
+						array_size - cur - sizeof(*stripe));
+					num_stripes--;
+					array_size -= sizeof(*stripe);
+					stripe_nr--;
+				}
+			}
+		}
+		ASSERT(array_size == old_array_size - (old_num_stripes - 1) *
+					sizeof(struct btrfs_stripe));
+		btrfs_set_stack_chunk_num_stripes(chunk, 1);
+		btrfs_set_stack_chunk_type(chunk, btrfs_stack_chunk_type(chunk) &
+					   BTRFS_BLOCK_GROUP_TYPE_MASK);
+		break;
+next:
+		cur += sizeof(*disk_key) + chunk_item_len;
+		ptr += sizeof(*disk_key) + chunk_item_len;
+	}
+	btrfs_set_super_sys_array_size(super_copy, array_size);
+}
+
+static int shrink_chunk_item(struct btrfs_block_group *bg,
+			     struct extent_map *em,
+			     struct victim_stripe *victims)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_root *root = fs_info->chunk_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = {0};
+	struct btrfs_chunk *chunk;
+	struct btrfs_key key;
+	int num_stripes;
+	int stripe_nr;
+	int victim_nr;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 3);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = em->start;
+
+	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	chunk = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_chunk);
+	num_stripes = btrfs_chunk_num_stripes(path.nodes[0], chunk);
+	for (stripe_nr = 0; stripe_nr < num_stripes; stripe_nr++) {
+		struct btrfs_stripe *stripe = btrfs_stripe_nr(chunk, stripe_nr);
+
+		for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+			if (victims[victim_nr].dev &&
+			    btrfs_stripe_devid(path.nodes[0], stripe) ==
+			    victims[victim_nr].dev->devid &&
+			    btrfs_stripe_offset(path.nodes[0], stripe) ==
+			    victims[victim_nr].physical) {
+				memmove_extent_buffer(path.nodes[0], (unsigned long)stripe,
+						(unsigned long)(stripe + 1),
+						(num_stripes - victim_nr - 1) *
+						sizeof(struct btrfs_stripe));
+				num_stripes--;
+				stripe_nr--;
+			}
+		}
+	}
+	/* Our target chunk num_stripes should be 1. */
+	ASSERT(num_stripes == 1);
+
+	/* Now shrink the chunk item. */
+	btrfs_set_chunk_type(path.nodes[0], chunk,
+			btrfs_chunk_type(path.nodes[0], chunk) &
+			BTRFS_BLOCK_GROUP_TYPE_MASK);
+	btrfs_set_chunk_num_stripes(path.nodes[0], chunk, 1);
+	btrfs_truncate_item(&path, btrfs_chunk_item_size(1), 1);
+	btrfs_release_path(&path);
+
+	/* Update bg's type and force it to be updated during commit. */
+	bg->flags &= BTRFS_BLOCK_GROUP_TYPE_MASK;
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		/* Force the bg item to be written back. */
+		bg->commit_used = (u64)-1;
+		btrfs_get_block_group(bg);
+		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
+		trans->delayed_ref_updates++;
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	/* And update the in-memory device used space. */
+	for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+		struct btrfs_device *dev = victims[victim_nr].dev;
+
+		if (!dev)
+			continue;
+		btrfs_device_set_bytes_used(dev, dev->bytes_used - em->len);
+		atomic64_add(em->len, &fs_info->free_chunk_space);
+	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+
+	mutex_lock(&fs_info->chunk_mutex);
+	/*
+	 * Remove the victim dev-extents.
+	 * The dev-extents themselves can not be reused yet, as dev->alloc_stat
+	 * still has CHUNK_ALLOCATED flag set for the ranges.
+	 */
+	for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+		struct btrfs_device *dev = victims[victim_nr].dev;
+		u64 dev_extent_len = em->len;
+
+		if (!dev)
+			continue;
+		ret = btrfs_free_dev_extent(trans, dev, victims[victim_nr].physical,
+					    &dev_extent_len);
+		if (ret < 0) {
+			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	/* Update device items. */
+	for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+		struct btrfs_device *dev = victims[victim_nr].dev;
+
+		if (!dev)
+			continue;
+		ret = btrfs_update_device(trans, dev);
+		if (ret < 0) {
+			mutex_unlock(&fs_info->chunk_mutex);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	/* Do the same for chunk item in sys chunk array. */
+	if (em->map_lookup->type & BTRFS_BLOCK_GROUP_SYSTEM)
+		shrink_system_chunk_array(fs_info, em, victims);
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The victim stripes are still marked CHUNK_ALLOCATED, thus it won't
+	 * be utilized by any new chunk.
+	 * Now since we have committed a transaction, we can finally release
+	 * the range.
+	 */
+	for (victim_nr = 0; victim_nr < MAX_VICTIM_STRIPES; victim_nr++) {
+		struct btrfs_device *dev = victims[victim_nr].dev;
+
+		if (!dev)
+			continue;
+		clear_extent_bits(&dev->alloc_state, victims[victim_nr].physical,
+				victims[victim_nr].physical + em->len,
+				CHUNK_ALLOCATED);
+	}
+	return ret;
+}
+
+int btrfs_do_quick_convert(struct btrfs_block_group *bg)
+{
+	struct btrfs_device_info *devices_info;
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct victim_stripe victims[MAX_VICTIM_STRIPES] = {0};
+	int nr_dev_extents = 0;
+	int ret;
+	int i;
+
+	em = btrfs_get_chunk_map(fs_info, bg->start, bg->length);
+	if (!em) {
+		btrfs_err(fs_info, "failed to find chunk map for bg %llu",
+			  bg->start);
+		return -ENOENT;
+	}
+	map = em->map_lookup;
+
+	/* btrfs_can_do_quick_convert() should have already checked this. */
+	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_DUP));
+
+	devices_info = kcalloc(map->num_stripes, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info) {
+		free_extent_map(em);
+		return -ENOMEM;
+	}
+
+	/* Gather the device available space to choose which stripes to drop. */
+	for (i = 0; i < map->num_stripes; i++) {
+		struct btrfs_device *dev = map->stripes[i].dev;
+
+		devices_info[i].dev = dev;
+		devices_info[i].dev_offset = map->stripes[i].physical;
+		if (dev->total_bytes > dev->bytes_used)
+			devices_info[i].total_avail = dev->total_bytes -
+						      dev->bytes_used;
+		else
+			devices_info[i].total_avail = 0;
+	}
+	sort(devices_info, map->num_stripes, sizeof(struct btrfs_device_info),
+	     cmp_device_info, NULL);
+
+	/*
+	 * Now the devices_info is sorted by their ascending total_avail,
+	 * first n-1 stripes are our drop target.
+	 */
+	for (i = 0; i < map->num_stripes - 1; i++) {
+		victims[nr_dev_extents].dev = devices_info[i].dev;
+		victims[nr_dev_extents].physical = devices_info[i].dev_offset;
+		nr_dev_extents++;
+	}
+
+	/* First shrink the chunk map. */
+	write_lock(&fs_info->mapping_tree.lock);
+	shrink_chunk_map(em, victims);
+	write_unlock(&fs_info->mapping_tree.lock);
+
+	/* And shrink the chunk item. */
+	ret = shrink_chunk_item(bg, em, victims);
+	free_extent_map(em);
+	return ret;
+}
+
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 2041a86186de..add2d55c32d2 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_RELOCATION_H
 #define BTRFS_RELOCATION_H
 
+bool btrfs_can_do_quick_convert(struct btrfs_block_group *bg);
+int btrfs_do_quick_convert(struct btrfs_block_group *bg);
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9d6775c7196f..2f068377ab7c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1716,7 +1716,7 @@ int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	return find_free_dev_extent_start(device, num_bytes, 0, start, len);
 }
 
-static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
+int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 			  struct btrfs_device *device,
 			  u64 start, u64 *dev_extent_len)
 {
@@ -2848,8 +2848,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
-					struct btrfs_device *device)
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device)
 {
 	int ret;
 	struct btrfs_path *path;
@@ -3262,16 +3262,25 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 */
 	lockdep_assert_held(&fs_info->reclaim_bgs_lock);
 
-	/* step one, relocate all the extents inside this chunk */
+	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
+	if (!block_group)
+		return -ENOENT;
+
+	/* Step zero, check if we can do an in-place conversion. */
 	btrfs_scrub_pause(fs_info);
+	if (btrfs_can_do_quick_convert(block_group)) {
+		ret = btrfs_do_quick_convert(block_group);
+		btrfs_scrub_continue(fs_info);
+		btrfs_put_block_group(block_group);
+		return ret;
+	}
+
+	/* step one, relocate all the extents inside this chunk */
 	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
 	btrfs_scrub_continue(fs_info);
 	if (ret)
 		return ret;
 
-	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
-	if (!block_group)
-		return -ENOENT;
 	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 	length = block_group->length;
 	btrfs_put_block_group(block_group);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 650e131d079e..ce3c4c8fee01 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -620,6 +620,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct block_device **bdev, fmode_t *mode);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
@@ -638,6 +640,9 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
 bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
+int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
+			  struct btrfs_device *device,
+			  u64 start, u64 *dev_extent_len);
 int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 			 u64 *start, u64 *max_avail);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
-- 
2.39.1

