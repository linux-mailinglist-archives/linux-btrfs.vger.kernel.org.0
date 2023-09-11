Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378979C29E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjILCTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 22:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjILCSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 22:18:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D68395AF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 18:41:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 710FD21863
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694475346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSam5cRKu3/msUdYKqLYYij4RmQ84ITCmv1EnJUGr+8=;
        b=OvS4nxtrXV9WCMz9CKy6khRoW8r2O4GIRBHWQ5P54odQ0itgzKTydwf/zTAafqhO17oVh+
        VxoUFNHKzOAHWa9SfvQ9NHZUWKMg6EiooMsQ+KFSOMpwceLmo5Z7FF9kW/QOi41194R/Tm
        OEWuQejrAR6Scw6Q50/8wC6+6I9gfDU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A499D139CC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EAXDGFGk/2SgPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: fix all variable shadowing
Date:   Tue, 12 Sep 2023 09:05:24 +0930
Message-ID: <36726710fcb190d52deca81b2735b5b1613304b2.1694428549.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694428549.git.wqu@suse.com>
References: <cover.1694428549.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some variable shadowing in btrfs-progs, most of them are
just reusing some common names like tmp.
And those are quite safe and the shadowed one are even different type.

But there are some exceptions:

- @end in traverse_tree_blocks()
  There is already an @end with the same type, but a different meaning
  (the end of the current extent buffer passed in).
  Just rename it to @child_end.

- @start in generate_new_data_csums_range()
  Just rename it to @csum_start.

- @size of fixup_chunk_tree_block()
  This one is particularly bad, we declare a local @size and initialize
  it to -1, then before we really utilize the variable @size, we
  immediately reset it to 0, then pass it to logical_to_physical().
  Then there is a location to check if @size is -1, which will always be
  true.

  According to the code in logical_to_physical(), @size would be clamped
  down by its original value, thus our local @size will always be 0.

  This patch would rename the local @size to @found_size, and only set
  it to -1.
  The call site is only to pass something as logical_to_physical()
  requires a non-NULL pointer.
  We don't really need to bother the returned value.

- duplicated @ref declaration in run_delayed_tree_ref()
- duplicated @super_flags in change_meta_csums()
  Just delete the duplicated one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                |  6 +++---
 check/mode-lowmem.c         |  4 ++--
 check/qgroup-verify.c       | 23 +++++++++++------------
 check/repair.c              |  7 ++++---
 cmds/filesystem-usage.c     |  8 ++++----
 cmds/subvolume-list.c       |  2 +-
 image/image-restore.c       | 10 ++++------
 kernel-shared/extent-tree.c |  1 -
 tune/change-csum.c          | 10 +++++-----
 9 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/check/main.c b/check/main.c
index 01c677dc17d2..70001821ef72 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7595,9 +7595,9 @@ static int find_possible_backrefs(struct btrfs_path *path,
 
 		cache = lookup_cache_extent(extent_cache, bytenr, 1);
 		if (cache) {
-			struct extent_record *tmp;
+			struct extent_record *extent;
 
-			tmp = container_of(cache, struct extent_record, cache);
+			extent = container_of(cache, struct extent_record, cache);
 
 			/*
 			 * If we found an extent record for the bytenr for this
@@ -7607,7 +7607,7 @@ static int find_possible_backrefs(struct btrfs_path *path,
 			 * extent tree since they likely belong to this record
 			 * and we need to fix it if it doesn't match bytenrs.
 			 */
-			if  (tmp->found_rec)
+			if  (extent->found_rec)
 				continue;
 		}
 
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index c3d2fec18294..3b2807cc5de9 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5027,7 +5027,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 
 		next = btrfs_find_tree_block(gfs_info, bytenr, gfs_info->nodesize);
 		if (!next || !btrfs_buffer_uptodate(next, ptr_gen, 0)) {
-			struct btrfs_tree_parent_check check = {
+			struct btrfs_tree_parent_check tree_check = {
 				.owner_root = btrfs_header_owner(cur),
 				.transid = ptr_gen,
 				.level = *level - 1,
@@ -5035,7 +5035,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
-			next = read_tree_block(gfs_info, bytenr, &check);
+			next = read_tree_block(gfs_info, bytenr, &tree_check);
 			if (!extent_buffer_uptodate(next)) {
 				struct btrfs_key node_key;
 
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 348b2cfa7384..c9753c0c7028 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -406,7 +406,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 	int ret;
 	u64 id, nr_roots, nr_refs;
 	struct qgroup_count *count;
-	struct ulist *counts = ulist_alloc(0);
+	struct ulist *local_counts = ulist_alloc(0);
 	struct ulist *tmp = ulist_alloc(0);
 	struct ulist_iterator uiter;
 	struct ulist_iterator tmp_uiter;
@@ -414,8 +414,8 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 	struct ulist_node *tmp_unode;
 	struct btrfs_qgroup_list *glist;
 
-	if (!counts || !tmp) {
-		ulist_free(counts);
+	if (!local_counts || !tmp) {
+		ulist_free(local_counts);
 		ulist_free(tmp);
 		return ENOMEM;
 	}
@@ -433,7 +433,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 			continue;
 
 		BUG_ON(!is_fstree(unode->val));
-		ret = ulist_add(counts, count->qgroupid, ptr_to_u64(count), 0);
+		ret = ulist_add(local_counts, count->qgroupid, ptr_to_u64(count), 0);
 		if (ret < 0)
 			goto out;
 
@@ -460,7 +460,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 
 				BUG_ON(!count);
 
-				ret = ulist_add(counts, id, ptr_to_u64(parent),
+				ret = ulist_add(local_counts, id, ptr_to_u64(parent),
 						0);
 				if (ret < 0)
 					goto out;
@@ -478,7 +478,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 	 */
 	nr_roots = roots->nnodes;
 	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(counts, &uiter))) {
+	while ((unode = ulist_next(local_counts, &uiter))) {
 		count = u64_to_ptr(unode->aux);
 
 		nr_refs = group_get_cur_refcnt(count);
@@ -504,7 +504,7 @@ static int account_one_extent(struct ulist *roots, u64 bytenr, u64 num_bytes)
 	inc_qgroup_seq(roots->nnodes);
 	ret = 0;
 out:
-	ulist_free(counts);
+	ulist_free(local_counts);
 	ulist_free(tmp);
 	return ret;
 }
@@ -920,7 +920,7 @@ static int add_qgroup_relation(u64 memberid, u64 parentid)
 }
 
 static void read_qgroup_status(struct extent_buffer *eb, int slot,
-			      struct counts_tree *counts)
+			      struct counts_tree *ct)
 {
 	struct btrfs_qgroup_status_item *status_item;
 	u64 flags;
@@ -931,10 +931,9 @@ static void read_qgroup_status(struct extent_buffer *eb, int slot,
 	 * Since qgroup_inconsist/rescan_running is just one bit,
 	 * assign value directly won't work.
 	 */
-	counts->qgroup_inconsist = !!(flags &
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
-	counts->rescan_running = !!(flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN);
-	counts->scan_progress = btrfs_qgroup_status_rescan(eb, status_item);
+	ct->qgroup_inconsist = !!(flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
+	ct->rescan_running = !!(flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN);
+	ct->scan_progress = btrfs_qgroup_status_rescan(eb, status_item);
 }
 
 static int load_quota_info(struct btrfs_fs_info *info)
diff --git a/check/repair.c b/check/repair.c
index 9656241f6799..c81f19bad21f 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -169,10 +169,10 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 			if (ret)
 				return ret;
 		} else {
-			u64 end;
+			u64 child_end;
 
 			bytenr = btrfs_node_blockptr(eb, i);
-			end = bytenr + fs_info->nodesize - 1;
+			child_end = bytenr + fs_info->nodesize - 1;
 
 			/* If we aren't the tree root don't read the block */
 			if (level == 1 && !tree_root) {
@@ -180,7 +180,8 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 					btrfs_pin_extent(fs_info, bytenr,
 							 fs_info->nodesize);
 				else
-					set_extent_dirty(tree, bytenr, end, GFP_NOFS);
+					set_extent_dirty(tree, bytenr,
+							 child_end, GFP_NOFS);
 				continue;
 			}
 
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 8b97f8ae36d2..403ab78ae004 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -537,11 +537,11 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 			 * As mixed mode is not supported in zoned mode, this
 			 * will account for all profile types
 			 */
-			u64 tmp;
+			u64 unusable;
 
-			tmp = device_get_zone_unusable(fd, flags);
-			if (tmp != DEVICE_ZONE_UNUSABLE_UNKNOWN)
-				zone_unusable += tmp;
+			unusable = device_get_zone_unusable(fd, flags);
+			if (unusable != DEVICE_ZONE_UNUSABLE_UNKNOWN)
+				zone_unusable += unusable;
 		}
 		if (flags & BTRFS_BLOCK_GROUP_DATA) {
 			r_data_used += sargs->spaces[i].used_bytes * ratio;
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index a583c8b63f3d..5a91f41da998 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -1411,7 +1411,7 @@ static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
 	n = rb_first(root_lookup);
 	while (n) {
 		struct root_info *entry;
-		int ret;
+
 		entry = to_root_info(n);
 		ret = lookup_ino_path(fd, entry);
 		if (ret && ret != -ENOENT)
diff --git a/image/image-restore.c b/image/image-restore.c
index edd81870adfb..2c3b276e39df 100644
--- a/image/image-restore.c
+++ b/image/image-restore.c
@@ -227,15 +227,15 @@ static int fixup_chunk_tree_block(struct mdrestore_struct *mdres,
 		for (i = 0; i < btrfs_header_nritems(eb); i++) {
 			struct btrfs_chunk *chunk;
 			struct btrfs_key key;
-			u64 type, physical, physical_dup, size = (u64)-1;
+			u64 type, physical, physical_dup;
+			u64 found_size = (u64)-1;
 
 			btrfs_item_key_to_cpu(eb, &key, i);
 			if (key.type != BTRFS_CHUNK_ITEM_KEY)
 				continue;
 
-			size = 0;
 			physical = logical_to_physical(mdres, key.offset,
-						       &size, &physical_dup);
+						       &found_size, &physical_dup);
 
 			if (!physical_dup)
 				truncate_item(eb, i, sizeof(*chunk));
@@ -254,9 +254,7 @@ static int fixup_chunk_tree_block(struct mdrestore_struct *mdres,
 				btrfs_set_chunk_num_stripes(eb, chunk, 1);
 			btrfs_set_chunk_sub_stripes(eb, chunk, 0);
 			btrfs_set_stripe_devid_nr(eb, chunk, 0, mdres->devid);
-			if (size != (u64)-1)
-				btrfs_set_stripe_offset_nr(eb, chunk, 0,
-							   physical);
+			btrfs_set_stripe_offset_nr(eb, chunk, 0, physical);
 			/* update stripe 2 offset */
 			if (physical_dup)
 				btrfs_set_stripe_offset_nr(eb, chunk, 1,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5f83ff5548e5..7022643a9843 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3768,7 +3768,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		BUG_ON(!extent_op || !extent_op->update_flags);
 		ret = alloc_reserved_tree_block(trans, node, extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
-		struct btrfs_delayed_tree_ref *ref = btrfs_delayed_node_to_tree_ref(node);
 		ret =  __free_extent(trans, node->bytenr, node->num_bytes,
 			     ref->parent, ref->root, ref->level, 0, 1);
 	} else {
diff --git a/tune/change-csum.c b/tune/change-csum.c
index ae8670f98a3f..0780a18b090b 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -248,7 +248,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 	}
 
 	while (cur < last_csum) {
-		u64 start;
+		u64 csum_start;
 		u64 len;
 		u32 item_size;
 
@@ -276,14 +276,14 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 		assert(key.offset >= cur);
 		item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
 
-		start = key.offset;
+		csum_start = key.offset;
 		len = item_size / fs_info->csum_size * fs_info->sectorsize;
 		read_extent_buffer(path.nodes[0], csum_buffer,
 				btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
 				item_size);
 		btrfs_release_path(&path);
 
-		ret = generate_new_csum_range(trans, start, len, new_csum_type,
+		ret = generate_new_csum_range(trans, csum_start, len, new_csum_type,
 					      csum_buffer);
 		if (ret < 0)
 			goto out;
@@ -303,7 +303,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 				goto out;
 			}
 		}
-		cur = start + len;
+		cur = csum_start + len;
 	}
 	ret = btrfs_commit_transaction(trans, csum_root);
 	if (inject_error(0x4de02239))
@@ -628,7 +628,7 @@ out:
 		struct btrfs_root *tree_root = fs_info->tree_root;
 		struct btrfs_trans_handle *trans;
 
-		u64 super_flags = btrfs_super_flags(fs_info->super_copy);
+		super_flags = btrfs_super_flags(fs_info->super_copy);
 
 		btrfs_set_super_csum_type(fs_info->super_copy, new_csum_type);
 		super_flags &= ~(BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
-- 
2.42.0

