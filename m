Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A470F9A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjEXPDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjEXPDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B9130
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MLEeYT09QyWzBWXSCqMYMm+TXFGXyQiej/Y2eq7vTfk=; b=YVIy0wcWBPUtdrJjLI2QI76hXB
        lOaEwB2ZrKVOvCNyAngS4I0Iadasan7dpHoChSC+IKhEyOjdjR8duBfmjWlBBUR3RGejWpVrAiz2k
        6v7JAf6GxVRzOtGqlwRQXppXgl/RgE/VOvsjjP45aGUzTyANtFPVu0yI1l7w31USNyqgDAMEvvOVA
        1UVwGGpNmWh2JOFEgEM+SgDtnOuWRF5U6E7fqgswWtmKiGDR1wx9vbwwXtxX9Y9qf/SVOUiM5APm9
        wdq6AyN5yY75ezbO1OZLVYvYVmXSTj9jx713Pbq79KR1L0ntfSc5uljlS9ziCe3lck2vkFkQ4R0EE
        MRDZi8KA==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1Y-00Dmby-0T;
        Wed, 24 May 2023 15:03:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs: optimize the logical to physical mapping for zoned writes
Date:   Wed, 24 May 2023 17:03:08 +0200
Message-Id: <20230524150317.1767981-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Note that the btrfs_bio doesn't grow as the new field are places into
a union that is so far not used for data writes and has plenty of space
left in it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c          |  1 +
 fs/btrfs/bio.h          | 17 +++++++++++---
 fs/btrfs/file-item.c    |  7 ++++++
 fs/btrfs/inode.c        |  6 +----
 fs/btrfs/ordered-data.c |  1 -
 fs/btrfs/ordered-data.h |  6 -----
 fs/btrfs/zoned.c        | 51 ++++++++---------------------------------
 7 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5fad6e032e6c76..8a4d3b707dd1b2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -431,6 +431,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		u64 zone_start = round_down(physical, dev->fs_info->zone_size);
 
 		ASSERT(btrfs_dev_is_sequential(dev, physical));
+		btrfs_bio(bio)->orig_physical = physical;
 		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 	}
 	btrfs_debug_in_rcu(dev->fs_info,
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
index ca321126816e94..96b54d73ba376d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -818,6 +818,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	}
 	this_sum_bytes = 0;
+
+	/*
+	 * The ->sums assignment is for zoned writes, where a bio never spans
+	 * ordered extents and only done unconditionally because that's cheaper
+	 * than a branch.
+	 */
+	bbio->sums = sums;
 	btrfs_add_ordered_sum(ordered, sums);
 	btrfs_put_ordered_extent(ordered);
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 253ad6206179ce..2eee57d07d3632 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3302,14 +3302,10 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
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
index 76411d96fa7afc..e838c2037634c2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1657,64 +1657,33 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
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
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map_tree *em_tree;
+	struct extent_map_tree *em_tree = &BTRFS_I(ordered->inode)->extent_tree;
 	struct extent_map *em;
-	struct btrfs_ordered_sum *sum;
-	u64 orig_logical = ordered->disk_bytenr;
-	struct map_lookup *map;
-	u64 physical = ordered->physical;
-	u64 chunk_start_phys;
-	u64 logical;
-
-	em = btrfs_get_chunk_map(fs_info, orig_logical, 1);
-	if (IS_ERR(em))
-		return;
-	map = em->map_lookup;
-	chunk_start_phys = map->stripes[0].physical;
+	struct btrfs_ordered_sum *sum =
+		list_first_entry(&ordered->list, typeof(*sum), list);
+	u64 logical = sum->logical;
 
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
+	if (ordered->disk_bytenr == logical)
 		return;
 
 	ordered->disk_bytenr = logical;
 
-	em_tree = &inode->extent_tree;
 	write_lock(&em_tree->lock);
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
 	em->block_start = logical;
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
-
-	list_for_each_entry(sum, &ordered->list, list) {
-		if (logical < orig_logical)
-			sum->logical -= orig_logical - logical;
-		else
-			sum->logical += logical - orig_logical;
-	}
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.39.2

