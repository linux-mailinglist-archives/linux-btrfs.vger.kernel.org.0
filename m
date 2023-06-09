Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B443728F23
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFIEzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 00:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjFIEzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 00:55:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45030E8
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 21:55:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09BD668C4E; Fri,  9 Jun 2023 06:55:17 +0200 (CEST)
Date:   Fri, 9 Jun 2023 06:55:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allocate dummy ordereded_sums objects for
 nocsum I/O on zoned file systems
Message-ID: <20230609045516.GA31024@lst.de>
References: <20230608121410.275766-1-hch@lst.de> <20230608121410.275766-2-hch@lst.de> <20230608154015.GK28933@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20230608154015.GK28933@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 05:40:15PM +0200, David Sterba wrote:
> This patch is still in the devlopment queue so I don't want to do a
> separate fix. Please send an incremental update that cleanly applies to
> the patch.
> 
> There's a minor conflict in context of btrfs_finish_ordered_zoned in
> zoned.c which only sets up the fs_info, so trivial to fix but the new
> helper btrfs_alloc_dummy_sum() uses bbio->ordered which is not available
> at this time and was added in a different series ("btrfs: add an
> ordered_extent pointer to struct btrfs_bio").
> 
> Due to that there may be a cascading change needed in other patches in
> misc-next but that should be fixable, the logic of adding bbio::ordered
> is clear.

Ok.  Here is a stash of patches:

 1) incremental diff
 2) complete replacement for that commit with the incremental
    diff included

And then new version of the two later patches affected by the squashing:

 3) btrfs: defer splitting of ordered extents until I/O completion
 4) btrfs: add an ordered_extent pointer to struct btrfs_bio

A git tree with all this is also available here:

    git://git.infradead.org/users/hch/misc.git btrfs-zoned-fixes

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-zoned-fixes

Note that this is based of misc-next as of last night CET, but misc-next
has been rebased since then.

--azLHFNyN32YCQGCU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="incremental.diff"

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 0ce48bf26002ad..54cfab7394d377 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -686,6 +686,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
 				goto fail_put_bio;
+		} else if (use_append) {
+			ret = btrfs_alloc_dummy_sum(bbio);
+			if (ret)
+				goto fail_put_bio;
 		}
 	}
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2e7d5ec6c9a68c..0cb4a9921d21ed 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -830,6 +830,29 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	return 0;
 }
 
+/*
+ * Nodatasum I/O on zoned file systems still requires an btrfs_ordered_sum to
+ * record the updated logical address on Zone Append completion.
+ * Allocate just the structure with an empty sums array here for that case.
+ */
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
+{
+	struct btrfs_ordered_extent *ordered =
+		btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
+
+	if (WARN_ON_ONCE(!ordered))
+		return BLK_STS_IOERR;
+
+	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
+	if (!bbio->sums)
+		return BLK_STS_RESOURCE;
+	bbio->sums->len = bbio->bio.bi_iter.bi_size;
+	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	btrfs_add_ordered_sum(ordered, bbio->sums);
+	btrfs_put_ordered_extent(ordered);
+	return 0;
+}
+
 /*
  * Remove one checksum overlapping a range.
  *
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 6be8725cd57474..4ec669b690080a 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -50,6 +50,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
 			     bool nowait);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 24c997c51e1e9a..b55b0d4ee86f85 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1667,14 +1667,15 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 {
-	struct extent_map_tree *em_tree = &BTRFS_I(ordered->inode)->extent_tree;
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	struct btrfs_ordered_sum *sum =
 		list_first_entry(&ordered->list, typeof(*sum), list);
 	u64 logical = sum->logical;
 
 	if (ordered->disk_bytenr == logical)
-		return;
+		goto out;
 
 	ordered->disk_bytenr = logical;
 
@@ -1684,6 +1685,19 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	em->block_start = logical;
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
+
+out:
+	/*
+	 * If we end up here for nodatasum I/O, the btrfs_ordered_sum structures
+	 * were allocated by btrfs_alloc_dummy_sum only to record the logical
+	 * addresses and don't contain actual checksums.  We thus must free them
+	 * here so that we don't attempt to log the csums later.
+	 */
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &inode->root->fs_info->fs_state)) {
+		list_del(&sum->list);
+		kfree(sum);
+	}
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,

--azLHFNyN32YCQGCU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-btrfs-optimize-the-logical-to-physical-mapping-for-z.patch"

From 9457d75e22b7020846bfbd15f805892cee99f027 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 24 May 2023 17:03:08 +0200
Subject: btrfs: optimize the logical to physical mapping for zoned writes

The current code to store the final logical to physical mapping for a
zone append write in the extent tree is rather inefficient.  It first has
to split the ordered extent so that there is one ordered extent per bio,
so that it can look up the ordered extent on I/O completion in
btrfs_record_physical_zoned and store the physical LBA returned by the
block driver in the ordered extent.

btrfs_rewrite_logical_zoned then has to do a lookup in the chunk tree to
see what physical address the logical address for this bio / ordered
extent is mapped to, and then rewrite it in the extent tree.

To optimize this process, we can store the physical address assigned in
the chunk tree to the original logical address and a pointer to
btrfs_ordered_sum structure the in the btrfs_bio structure, and then use
this information to rewrite the logical address in the btrfs_ordered_sum
structure directly at I/O completion time in btrfs_record_physical_zoned.
btrfs_rewrite_logical_zoned then simply updates the logical address in
the extent tree and the ordered_extent itself.

The code in btrfs_rewrite_logical_zoned now runs for all data I/O
completions in zoned file systems, which is fine as there is no remapping
to do for non-append writes to conventional zones or for relocation, and
the overhead for quickly breaking out of the loop is very low.

Because zoned file systems now need the ordereded_sums structure to
record the actual write location returned by zone append, allocate dummy
structures without the csum array for them when the I/O doesn't use
checksums, and free them when completing the ordered_extent.

Note that the btrfs_bio doesn't grow as the new field are places into
a union that is so far not used for data writes and has plenty of space
left in it.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c          |  5 ++++
 fs/btrfs/bio.h          | 17 ++++++++++--
 fs/btrfs/file-item.c    | 30 ++++++++++++++++++++
 fs/btrfs/file-item.h    |  1 +
 fs/btrfs/inode.c        |  6 +---
 fs/btrfs/ordered-data.c |  1 -
 fs/btrfs/ordered-data.h |  6 ----
 fs/btrfs/zoned.c        | 61 +++++++++++++++--------------------------
 8 files changed, 73 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ea6c81f9d1a36e..54cfab7394d377 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -431,6 +431,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
 		ASSERT(btrfs_dev_is_sequential(dev, physical));
+		btrfs_bio(bio)->orig_physical = physical;
 		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 	}
 	btrfs_debug_in_rcu(dev->fs_info,
@@ -685,6 +686,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
 				goto fail_put_bio;
+		} else if (use_append) {
+			ret = btrfs_alloc_dummy_sum(bbio);
+			if (ret)
+				goto fail_put_bio;
 		}
 	}
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index a8eca3a6567320..8a29980159b404 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -39,8 +39,8 @@ struct btrfs_bio {
 
 	union {
 		/*
-		 * Data checksumming and original I/O information for internal
-		 * use in the btrfs_submit_bio machinery.
+		 * For data reads: checksumming and original I/O information.
+		 * (for internal use in the btrfs_submit_bio machinery only)
 		 */
 		struct {
 			u8 *csum;
@@ -48,7 +48,18 @@ struct btrfs_bio {
 			struct bvec_iter saved_iter;
 		};
 
-		/* For metadata parentness verification. */
+		/*
+		 * For data writes:
+		 * - pointer to the checksums for this bio
+		 * - original physical address from the allocator
+		 *   (for zone append only)
+		 */
+		struct {
+			struct btrfs_ordered_sum *sums;
+			u64 orig_physical;
+		};
+
+		/* For metadata reads: parentness verification. */
 		struct btrfs_tree_parent_check parent_check;
 	};
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 415e50904db311..0cb4a9921d21ed 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -818,11 +818,41 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	}
 	this_sum_bytes = 0;
+
+	/*
+	 * The ->sums assignment is for zoned writes, where a bio never spans
+	 * ordered extents and is only done unconditionally because that's cheaper
+	 * than a branch.
+	 */
+	bbio->sums = sums;
 	btrfs_add_ordered_sum(ordered, sums);
 	btrfs_put_ordered_extent(ordered);
 	return 0;
 }
 
+/*
+ * Nodatasum I/O on zoned file systems still requires an btrfs_ordered_sum to
+ * record the updated logical address on Zone Append completion.
+ * Allocate just the structure with an empty sums array here for that case.
+ */
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
+{
+	struct btrfs_ordered_extent *ordered =
+		btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
+
+	if (WARN_ON_ONCE(!ordered))
+		return BLK_STS_IOERR;
+
+	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
+	if (!bbio->sums)
+		return BLK_STS_RESOURCE;
+	bbio->sums->len = bbio->bio.bi_iter.bi_size;
+	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	btrfs_add_ordered_sum(ordered, bbio->sums);
+	btrfs_put_ordered_extent(ordered);
+	return 0;
+}
+
 /*
  * Remove one checksum overlapping a range.
  *
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 6be8725cd57474..4ec669b690080a 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -50,6 +50,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
 			     bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d693ed70842816..2e5e0b105be5e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3301,14 +3301,10 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	/* A valid ->physical implies a write on a sequential zone. */
-	if (ordered_extent->physical != (u64)-1) {
+	if (btrfs_is_zoned(fs_info)) {
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
-	} else if (btrfs_is_data_reloc_root(inode->root)) {
-		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
-					ordered_extent->disk_num_bytes);
 	}
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a9778a91511e19..324a5a8c844a72 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -209,7 +209,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
-	entry->physical = (u64)-1;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 	entry->flags = flags;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index ebc980ac967ad4..dc700aa515b58b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -151,12 +151,6 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
-
-	/*
-	 * Used to reverse-map physical address returned from ZONE_APPEND write
-	 * command in a workqueue context
-	 */
-	u64 physical;
 };
 
 static inline void
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eca49e6e0e5f50..b55b0d4ee86f85 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1657,51 +1657,28 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 	const u64 physical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
-	struct btrfs_ordered_extent *ordered;
+	struct btrfs_ordered_sum *sum = bbio->sums;
 
-	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-	if (WARN_ON(!ordered))
-		return;
-
-	ordered->physical = physical;
-	btrfs_put_ordered_extent(ordered);
+	if (physical < bbio->orig_physical)
+		sum->logical -= bbio->orig_physical - physical;
+	else
+		sum->logical += physical - bbio->orig_physical;
 }
 
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map_tree *em_tree;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
-	struct btrfs_ordered_sum *sum;
-	u64 orig_logical = ordered->disk_bytenr;
-	struct map_lookup *map;
-	u64 physical = ordered->physical;
-	u64 chunk_start_phys;
-	u64 logical;
+	struct btrfs_ordered_sum *sum =
+		list_first_entry(&ordered->list, typeof(*sum), list);
+	u64 logical = sum->logical;
 
-	em = btrfs_get_chunk_map(fs_info, orig_logical, 1);
-	if (IS_ERR(em))
-		return;
-	map = em->map_lookup;
-	chunk_start_phys = map->stripes[0].physical;
-
-	if (WARN_ON_ONCE(map->num_stripes > 1) ||
-	    WARN_ON_ONCE((map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0) ||
-	    WARN_ON_ONCE(physical < chunk_start_phys) ||
-	    WARN_ON_ONCE(physical > chunk_start_phys + em->orig_block_len)) {
-		free_extent_map(em);
-		return;
-	}
-	logical = em->start + (physical - map->stripes[0].physical);
-	free_extent_map(em);
-
-	if (orig_logical == logical)
-		return;
+	if (ordered->disk_bytenr == logical)
+		goto out;
 
 	ordered->disk_bytenr = logical;
 
-	em_tree = &inode->extent_tree;
 	write_lock(&em_tree->lock);
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
@@ -1709,11 +1686,17 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
 
-	list_for_each_entry(sum, &ordered->list, list) {
-		if (logical < orig_logical)
-			sum->logical -= orig_logical - logical;
-		else
-			sum->logical += logical - orig_logical;
+out:
+	/*
+	 * If we end up here for nodatasum I/O, the btrfs_ordered_sum structures
+	 * were allocated by btrfs_alloc_dummy_sum only to record the logical
+	 * addresses and don't contain actual checksums.  We thus must free them
+	 * here so that we don't attempt to log the csums later.
+	 */
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &inode->root->fs_info->fs_state)) {
+		list_del(&sum->list);
+		kfree(sum);
 	}
 }
 
-- 
2.39.2


--azLHFNyN32YCQGCU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-btrfs-defer-splitting-of-ordered-extents-until-I-O-c.patch"

From a6df812af6f23df7d8e2cfe12e3b85a280362a02 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 8 Jun 2023 19:46:50 +0200
Subject: btrfs: defer splitting of ordered extents until I/O completion

The btrfs zoned completion code currently needs an ordered_extent and
extent_map per bio so that it can account for the non-predictable
write location from Zone Append.  To archive that it currently splits
the ordered_extent and extent_map at I/O submission time, and then
records the actual physical address in the ->physical field of the
ordered_extent.

This patch instead switches to record the "original" physical address
that the btrfs allocator assigned in spare space in the btrfs_bio,
and then rewrites the logical address in the btrfs_ordered_sum
structure at I/O completion time.  This allows the ordered extent
completion handler to simply walk the list of ordered csums and
split the ordered extent as needed.  This removes an extra ordered
extent and extent_map lookup and manipulation during the I/O
submission path, and instead batches it in the I/O completion path
where we need to touch these anyway.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c          | 17 ----------
 fs/btrfs/btrfs_inode.h  |  2 --
 fs/btrfs/inode.c        | 18 +++++++----
 fs/btrfs/ordered-data.h |  1 +
 fs/btrfs/zoned.c        | 70 ++++++++++++++++++++++++++++++++++-------
 fs/btrfs/zoned.h        |  6 ++--
 6 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 54cfab7394d377..56c7bc598ebabc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -61,20 +61,6 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
-static blk_status_t btrfs_bio_extract_ordered_extent(struct btrfs_bio *bbio)
-{
-	struct btrfs_ordered_extent *ordered;
-	int ret;
-
-	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
-	ret = btrfs_extract_ordered_extent(bbio, ordered);
-	btrfs_put_ordered_extent(ordered);
-
-	return errno_to_blk_status(ret);
-}
-
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length, bool use_append)
@@ -667,9 +653,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_bio_extract_ordered_extent(bbio);
-			if (ret)
-				goto fail_put_bio;
 		}
 
 		/*
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 08c99602339408..8abf96cfea8fae 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -410,8 +410,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
-				 struct btrfs_ordered_extent *ordered);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5eef1c78b42d0d..ae733fcec24580 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2714,8 +2714,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
-				 struct btrfs_ordered_extent *ordered)
+static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
+					struct btrfs_ordered_extent *ordered)
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
@@ -3180,7 +3180,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  * an ordered extent if the range of bytes in the file it covers are
  * fully written.
  */
-int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
+int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
 	struct btrfs_root *root = inode->root;
@@ -3215,11 +3215,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (btrfs_is_zoned(fs_info)) {
-		btrfs_rewrite_logical_zoned(ordered_extent);
+	if (btrfs_is_zoned(fs_info))
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
-	}
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
@@ -3387,6 +3385,14 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	return ret;
 }
 
+int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
+{
+	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
+	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
+		btrfs_finish_ordered_zoned(ordered);
+	return btrfs_finish_one_ordered(ordered);
+}
+
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 0ae0f52c148f23..828bb039634ac7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -161,6 +161,7 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 	t->last = NULL;
 }
 
+int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent);
 int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b55b0d4ee86f85..3672388455815f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "super.h"
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
@@ -1665,17 +1666,11 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 		sum->logical += physical - bbio->orig_physical;
 }
 
-void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
+static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
+					u64 logical)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
-	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct extent_map_tree *em_tree = &BTRFS_I(ordered->inode)->extent_tree;
 	struct extent_map *em;
-	struct btrfs_ordered_sum *sum =
-		list_first_entry(&ordered->list, typeof(*sum), list);
-	u64 logical = sum->logical;
-
-	if (ordered->disk_bytenr == logical)
-		goto out;
 
 	ordered->disk_bytenr = logical;
 
@@ -1685,6 +1680,54 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	em->block_start = logical;
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
+}
+
+static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
+				      u64 logical, u64 len)
+{
+	struct btrfs_ordered_extent *new;
+
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags) &&
+	    split_extent_map(BTRFS_I(ordered->inode), ordered->file_offset,
+			     ordered->num_bytes, len))
+		return false;
+
+	new = btrfs_split_ordered_extent(ordered, len);
+	if (IS_ERR(new))
+		return false;
+
+	if (new->disk_bytenr != logical)
+		btrfs_rewrite_logical_zoned(new, logical);
+	btrfs_finish_one_ordered(new);
+	return true;
+}
+
+void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_ordered_sum *sum =
+		list_first_entry(&ordered->list, typeof(*sum), list);
+	u64 logical = sum->logical;
+	u64 len = sum->len;
+
+	while (len < ordered->disk_num_bytes) {
+		sum = list_next_entry(sum, list);
+		if (sum->logical == logical + len) {
+			len += sum->len;
+			continue;
+		}
+		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
+			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
+			btrfs_err(fs_info, "failed to split ordered extent\n");
+			goto out;
+		}
+		logical = sum->logical;
+		len = sum->len;
+	}
+
+	if (ordered->disk_bytenr != logical)
+		btrfs_rewrite_logical_zoned(ordered, logical);
 
 out:
 	/*
@@ -1694,9 +1737,12 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	 * here so that we don't attempt to log the csums later.
 	 */
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &inode->root->fs_info->fs_state)) {
-		list_del(&sum->list);
-		kfree(sum);
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
+		while ((sum = list_first_entry_or_null(&ordered->list,
+						       typeof(*sum), list))) {
+			list_del(&sum->list);
+			kfree(sum);
+		}
 	}
 }
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 3058ef559c9813..27322b926038c2 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -30,6 +30,8 @@ struct btrfs_zoned_device_info {
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
+void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
@@ -56,7 +58,6 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
-void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret);
@@ -188,9 +189,6 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-static inline void btrfs_rewrite_logical_zoned(
-				struct btrfs_ordered_extent *ordered) { }
-
 static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 			       struct extent_buffer *eb,
 			       struct btrfs_block_group **cache_ret)
-- 
2.39.2


--azLHFNyN32YCQGCU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-btrfs-add-an-ordered_extent-pointer-to-struct-btrfs_.patch"

From 8807a2e457fc7deba266d191681960d4666d9e8e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 31 May 2023 09:54:02 +0200
Subject: btrfs: add an ordered_extent pointer to struct btrfs_bio

Add a pointer to the ordered_extent to the existing union in struct
btrfs_bio, so all code dealing with data write bios can just use a
pointer dereference to retrieve the ordered_extent instead of doing
multiple rbtree lookups per I/O.

The reference to this ordered_extent is dropped at end I/O time,
which implies that an extra one must be acquired when the bio is split.
This also requires moving the btrfs_extract_ordered_extent call into
btrfs_split_bio so that the invariant of always having a valid
ordered_extent reference for the btrfs_bio is kept.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c         | 42 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h         |  9 +++------
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file-item.c   |  9 +--------
 fs/btrfs/inode.c       |  8 +++++---
 6 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e4b4dd80673d32..8c30febc46ef8f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -33,6 +33,11 @@ static inline bool is_data_bbio(struct btrfs_bio *bbio)
 	return bbio->inode && is_data_inode(&bbio->inode->vfs_inode);
 }
 
+static bool bbio_has_ordered_extent(struct btrfs_bio *bbio)
+{
+	return is_data_bbio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE;
+}
+
 /*
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
@@ -88,11 +93,40 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
 	orig_bbio->file_offset += map_length;
-
+	if (bbio_has_ordered_extent(bbio)) {
+		refcount_inc(&orig_bbio->ordered->refs);
+		bbio->ordered = orig_bbio->ordered;
+	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
 
+/* Free a bio that was never submitted to the underlying device. */
+static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
+{
+	if (bbio_has_ordered_extent(bbio))
+		btrfs_put_ordered_extent(bbio->ordered);
+	bio_put(&bbio->bio);
+}
+
+static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
+{
+	if (bbio_has_ordered_extent(bbio)) {
+		struct btrfs_ordered_extent *ordered = bbio->ordered;
+
+		bbio->end_io(bbio);
+		btrfs_put_ordered_extent(ordered);
+	} else {
+		bbio->end_io(bbio);
+	}
+}
+
+void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
+{
+	bbio->bio.bi_status = status;
+	__btrfs_bio_end_io(bbio);
+}
+
 static void btrfs_orig_write_end_io(struct bio *bio);
 
 static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
@@ -121,12 +155,12 @@ static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
 
 		if (bbio->bio.bi_status)
 			btrfs_bbio_propagate_error(bbio, orig_bbio);
-		bio_put(&bbio->bio);
+		btrfs_cleanup_bio(bbio);
 		bbio = orig_bbio;
 	}
 
 	if (atomic_dec_and_test(&bbio->pending_ios))
-		bbio->end_io(bbio);
+		__btrfs_bio_end_io(bbio);
 }
 
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
@@ -683,7 +717,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 fail_put_bio:
 	if (map_length < length)
-		bio_put(bio);
+		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
 	btrfs_bio_end_io(orig_bbio, ret);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 52e7962103fff2..ca79decee0607f 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -50,11 +50,13 @@ struct btrfs_bio {
 
 		/*
 		 * For data writes:
+		 * - ordered extent covering the bio
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
 		 */
 		struct {
+			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			u64 orig_physical;
 		};
@@ -95,12 +97,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  struct btrfs_fs_info *fs_info,
 				  btrfs_bio_end_io_t end_io, void *private);
-
-static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
-{
-	bbio->bio.bi_status = status;
-	bbio->end_io(bbio);
-}
+void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index aafc846bcd4fb6..ce4be0f21c5cf8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -303,10 +303,10 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
+	cb->bbio.ordered = ordered;
 	btrfs_add_compressed_bio_pages(cb);
 
 	btrfs_submit_bio(&cb->bbio, 0);
-	btrfs_put_ordered_extent(ordered);
 }
 
 /*
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 35141a223a3ec5..ad536eaf02b00c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -835,7 +835,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
-			btrfs_put_ordered_extent(ordered);
+			bbio->ordered = ordered;
 		}
 
 		/*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 782bbf081c26b5..cbacaa80526c3f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -799,19 +799,12 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
  */
 blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
 {
-	struct btrfs_ordered_extent *ordered =
-		btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-
-	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
-
 	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
 	if (!bbio->sums)
 		return BLK_STS_RESOURCE;
 	bbio->sums->len = bbio->bio.bi_iter.bi_size;
 	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
-	btrfs_add_ordered_sum(ordered, bbio->sums);
-	btrfs_put_ordered_extent(ordered);
+	btrfs_add_ordered_sum(bbio->ordered, bbio->sums);
 	return 0;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c55fd059431584..7352b8c23b3b7d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2716,8 +2716,11 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 		return -EINVAL;
 
 	/* No need to split if the ordered extent covers the entire bio. */
-	if (ordered->disk_num_bytes == len)
+	if (ordered->disk_num_bytes == len) {
+		refcount_inc(&ordered->refs);
+		bbio->ordered = ordered;
 		return 0;
+	}
 
 	/*
 	 * Don't split the extent_map for NOCOW extents, as we're writing into
@@ -2734,8 +2737,7 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	new = btrfs_split_ordered_extent(ordered, len);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
-	btrfs_put_ordered_extent(new);
-
+	bbio->ordered = new;
 	return 0;
 }
 
-- 
2.39.2


--azLHFNyN32YCQGCU--
