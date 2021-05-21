Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65838CEB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEUUSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhEUUSC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621628198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f67p3hpmCVEJo4APEZPm0qka4JYxfzi63Aj8+g9JwJ0=;
        b=RL2KOyYzvHWuvg3Z8EVKWfOrmEltzuKSO56Rt+4/YdMOUlG56cSVrZrl7H7ARSYQlBrfgi
        RljYYjsqku0XN3FsnB9VZUVP0jObZxMZtuCO+C1ADOeIXr8q8qGioqeKkqWIQHLK1oehbA
        8rJvSxODDpAnY8H7RgszcgiAhfWzbLw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7C65AAFD;
        Fri, 21 May 2021 20:16:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FA0CDA72C; Fri, 21 May 2021 22:14:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fix typos in comments
Date:   Fri, 21 May 2021 22:14:02 +0200
Message-Id: <20210521201402.23136-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix typos that have snuck in since the last round. Found by codespell.

Signed-off-by: David Sterba <dsterba@suse.com>
---

The most important patch of the year.

 fs/btrfs/backref.c                | 2 +-
 fs/btrfs/ctree.h                  | 6 +++---
 fs/btrfs/delalloc-space.c         | 2 +-
 fs/btrfs/dev-replace.c            | 2 +-
 fs/btrfs/extent-tree.c            | 2 +-
 fs/btrfs/extent_io.c              | 2 +-
 fs/btrfs/file-item.c              | 2 +-
 fs/btrfs/inode.c                  | 4 ++--
 fs/btrfs/ioctl.c                  | 2 +-
 fs/btrfs/locking.c                | 4 ++--
 fs/btrfs/ordered-data.c           | 2 +-
 fs/btrfs/props.c                  | 2 +-
 fs/btrfs/qgroup.c                 | 2 +-
 fs/btrfs/scrub.c                  | 2 +-
 fs/btrfs/send.c                   | 2 +-
 fs/btrfs/space-info.c             | 4 ++--
 fs/btrfs/tests/extent-map-tests.c | 2 +-
 fs/btrfs/volumes.c                | 8 ++++----
 fs/btrfs/zoned.c                  | 4 ++--
 19 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 117d423fdb93..7a8a2fc19533 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2675,7 +2675,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
  *
  * @ref_key:	The same as @ref_key in  handle_direct_tree_backref()
  * @tree_key:	The first key of this tree block.
- * @path:	A clean (released) path, to avoid allocating path everytime
+ * @path:	A clean (released) path, to avoid allocating path every time
  *		the function get called.
  */
 static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 42048d051317..677d612dcdcb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2746,9 +2746,9 @@ enum btrfs_reserve_flush_enum {
 	/*
 	 * Flush space by above mentioned methods and by:
 	 * - Running delayed iputs
-	 * - Commiting transaction
+	 * - Committing transaction
 	 *
-	 * Can be interruped by fatal signal.
+	 * Can be interrupted by a fatal signal.
 	 */
 	BTRFS_RESERVE_FLUSH_DATA,
 	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
@@ -2758,7 +2758,7 @@ enum btrfs_reserve_flush_enum {
 	 * Pretty much the same as FLUSH_ALL, but can also steal space from
 	 * global rsv.
 	 *
-	 * Can be interruped by fatal signal.
+	 * Can be interrupted by a fatal signal.
 	 */
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 56642ca7af10..2059d1504149 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -89,7 +89,7 @@
  *    ->outstanding_extents += 1 (current value is 1)
  *
  *  -> set_delalloc
- *    ->outstanding_extents += 1 (currrent value is 2)
+ *    ->outstanding_extents += 1 (current value is 2)
  *
  *  -> btrfs_delalloc_release_extents()
  *    ->outstanding_extents -= 1 (current value is 1)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d05f73530af7..d029be40ea6f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -37,7 +37,7 @@
  * - Write duplication
  *
  *   All new writes will be written to both target and source devices, so even
- *   if replace gets canceled, sources device still contans up-to-date data.
+ *   if replace gets canceled, sources device still contains up-to-date data.
  *
  *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()
  *   Start:		btrfs_dev_replace_start()
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3d5c35e4cb76..0002e7cb89c7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1425,7 +1425,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
  *		    bytenr of the parent block. Since new extents are always
  *		    created with indirect references, this will only be the case
  *		    when relocating a shared extent. In that case, root_objectid
- *		    will be BTRFS_TREE_RELOC_OBJECTID. Otheriwse, parent must
+ *		    will be BTRFS_TREE_RELOC_OBJECTID. Otherwise, parent must
  *		    be 0
  *
  * @root_objectid:  The id of the root where this modification has originated,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d12f09b88367..6f023f800bd6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2650,7 +2650,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	 * For subapge metadata case, all btrfs_page_* helpers need page to
 	 * have page::private populated.
 	 * But we can have rare case where the last eb in the page is only
-	 * referred by the IO, and it gets released immedately after it's
+	 * referred by the IO, and it gets released immediately after it's
 	 * read and verified.
 	 *
 	 * This can detach the page private completely.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a5a8dac334e8..a83b178aed88 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -618,7 +618,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * @file_start:  offset in file this bio begins to describe
  * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
  *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contains potentially discontigous bio vecs
+ *		 means this bio can contain potentially discontiguous bio vecs
  *		 so the logical offset of each should be calculated separately.
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 93cf13973274..ee1e923cb870 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2765,7 +2765,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	/*
 	 * If we dropped an inline extent here, we know the range where it is
 	 * was not marked with the EXTENT_DELALLOC_NEW bit, so we update the
-	 * number of bytes only for that range contaning the inline extent.
+	 * number of bytes only for that range containing the inline extent.
 	 * The remaining of the range will be processed when clearning the
 	 * EXTENT_DELALLOC_BIT bit through the ordered extent completion.
 	 */
@@ -4095,7 +4095,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 * This is a placeholder inode for a subvolume we didn't have a
 	 * reference to at the time of the snapshot creation.  In the meantime
 	 * we could have renamed the real subvol link into our snapshot, so
-	 * depending on btrfs_del_root_ref to return -ENOENT here is incorret.
+	 * depending on btrfs_del_root_ref to return -ENOENT here is incorrect.
 	 * Instead simply lookup the dir_index_item for this entry so we can
 	 * remove it.  Otherwise we know we have a ref to the root and we can
 	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7739461533d..49cfa9772c1b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2897,7 +2897,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 				err = PTR_ERR(subvol_name_ptr);
 				goto free_parent;
 			}
-			/* subvol_name_ptr is already NULL termined */
+			/* subvol_name_ptr is already nul terminated */
 			subvol_name = (char *)kbasename(subvol_name_ptr);
 		}
 	} else {
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 5fafc5e89bb7..313d9d685adb 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,7 +57,7 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 /*
  * Try-lock for read.
  *
- * Retrun 1 if the rwlock has been taken, 0 otherwise
+ * Return 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
@@ -72,7 +72,7 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 /*
  * Try-lock for write.
  *
- * Retrun 1 if the rwlock has been taken, 0 otherwise
+ * Return 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b1b377ad99a0..cd5d5b5b492c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -302,7 +302,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
- * @page:	 The invovled page for the opeartion.
+ * @page:	 The invovled page for the operation.
  *		 For uncompressed buffered IO, the page status also needs to be
  *		 updated to indicate whether the pending ordered io is finished.
  *		 Can be NULL for direct IO and compressed write.
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 2dcb1cb21634..a17e53e700b1 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -348,7 +348,7 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 
 		/*
 		 * This is not strictly necessary as the property should be
-		 * valid, but in case it isn't, don't propagate it futher.
+		 * valid, but in case it isn't, don't propagate it further.
 		 */
 		ret = h->validate(value, strlen(value));
 		if (ret)
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3ded812f522c..d72885903b8c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2521,7 +2521,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	int ret = 0;
 
 	/*
-	 * If quotas get disabled meanwhile, the resouces need to be freed and
+	 * If quotas get disabled meanwhile, the resources need to be freed and
 	 * we can't just exit here.
 	 */
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6af901539ef2..34ea36337c39 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2420,7 +2420,7 @@ static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *su
  * the csum into @csum.
  *
  * The search source is sctx->csum_list, which is a pre-populated list
- * storing bytenr ordered csum ranges.  We're reponsible to cleanup any range
+ * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
  * that is before @logical.
  *
  * Return 0 if there is no csum for the range.
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bd69db72acc5..cdaa00067f81 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6507,7 +6507,7 @@ static int changed_extent(struct send_ctx *sctx,
 	 * updates the inode item, but it only changes the iversion (sequence
 	 * field in the inode item) of the inode, so if a file is deduplicated
 	 * the same amount of times in both the parent and send snapshots, its
-	 * iversion becames the same in both snapshots, whence the inode item is
+	 * iversion becomes the same in both snapshots, whence the inode item is
 	 * the same on both snapshots.
 	 */
 	if (sctx->cur_ino != sctx->cmp_key->objectid)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 42d0fa2092d4..f26fdb7a17e8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -389,7 +389,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 
 		ticket = list_first_entry(head, struct reserve_ticket, list);
 
-		/* Check and see if our ticket can be satisified now. */
+		/* Check and see if our ticket can be satisfied now. */
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
 		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
 					 flush)) {
@@ -961,7 +961,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 * if it doesn't feel like the space reclaimed by the commit
 		 * would result in the ticket succeeding.  However if we have a
 		 * smaller ticket in the queue it may be small enough to be
-		 * satisified by committing the transaction, so if any
+		 * satisfied by committing the transaction, so if any
 		 * subsequent ticket is smaller than the first ticket go ahead
 		 * and send us back for another loop through the enospc flushing
 		 * code.
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c0aefe6dee0b..319fed82d741 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -557,7 +557,7 @@ int btrfs_test_extent_map(void)
 		{
 			/*
 			 * Test a chunk with 2 data stripes one of which
-			 * interesects the physical address of the super block
+			 * intersects the physical address of the super block
 			 * is correctly recognised.
 			 */
 			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 80e962788396..582695cee9d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -717,7 +717,7 @@ static struct btrfs_fs_devices *find_fsid_changed(
 
 	/*
 	 * Handles the case where scanned device is part of an fs that had
-	 * multiple successful changes of FSID but curently device didn't
+	 * multiple successful changes of FSID but currently device didn't
 	 * observe it. Meaning our fsid will be different than theirs. We need
 	 * to handle two subcases :
 	 *  1 - The fs still continues to have different METADATA/FSID uuids.
@@ -1550,7 +1550,7 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * check to ensure dev extents are not double allocated.
  * This makes the function safe to allocate dev extents but may not report
  * correct usable device space, as device extent freed in current transaction
- * is not reported as avaiable.
+ * is not reported as available.
  */
 static int find_free_dev_extent_start(struct btrfs_device *device,
 				u64 num_bytes, u64 search_start, u64 *start,
@@ -6152,7 +6152,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	offset = logical - em->start;
 	/* Len of a stripe in a chunk */
 	stripe_len = map->stripe_len;
-	/* Stripe wher this block falls in */
+	/* Stripe where this block falls in */
 	stripe_nr = div64_u64(offset, stripe_len);
 	/* Offset of stripe in the chunk */
 	stripe_offset = stripe_nr * stripe_len;
@@ -7863,7 +7863,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 	}
 
-	/* Make sure no dev extent is beyond device bondary */
+	/* Make sure no dev extent is beyond device boundary */
 	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 15843a858bf6..6f72569a3806 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -81,7 +81,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	 *   *: Special case, no superblock is written
 	 *   0: Use write pointer of zones[0]
 	 *   1: Use write pointer of zones[1]
-	 *   C: Compare super blcoks from zones[0] and zones[1], use the latest
+	 *   C: Compare super blocks from zones[0] and zones[1], use the latest
 	 *      one determined by generation
 	 *   x: Invalid state
 	 */
@@ -421,7 +421,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		}
 
 		/*
-		 * If zones[0] is conventional, always use the beggining of the
+		 * If zones[0] is conventional, always use the beginning of the
 		 * zone to record superblock. No need to validate in that case.
 		 */
 		if (zone_info->sb_zones[BTRFS_NR_SB_LOG_ZONES * i].type ==
-- 
2.29.2

