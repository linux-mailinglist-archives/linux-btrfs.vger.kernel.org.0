Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C186499A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLLHhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiLLHhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:37:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7D10CF
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2YXYyBbzYOsoXdK1DYx+MW1FjFMpkGEozg/EUfT1UvI=; b=dj7FF/71ETuOYDZl1vOu6NOpgV
        KrMRw9yZYS0h1wPyoTUl/qr5dJChh27FJl3QQnhVVXv6x7kkCrRWad2R9y9cV7J++fToF03DHxG6F
        eF4NoWwIO+0LVq192aNHnOIS+To4H0SLfiC1NuFMq4c2liruzGcSGMtHuOuWG29z0T/jEeGVXXPHt
        gKcK3KgerCt51E841gxz+wUEF9LXRxDvUnB1BwjjOEcxfWM+WRahXZNvRHcWnUT51gmwclg4jiP4E
        tv4rSRj7VK28slrQHjpsXbdJ8XlRwKH1PA8qRY5Lh3ZnUKpWvNOCeGvrwsqt7s9L0QQl2j1up07o5
        PW28WZyg==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4dNm-009WVv-Cl; Mon, 12 Dec 2022 07:37:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: don't rely on unchanging ->bi_bdev for zone append remaps
Date:   Mon, 12 Dec 2022 08:37:23 +0100
Message-Id: <20221212073724.12637-7-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_physical_zoned relies on a bio->bi_bdev samples in the
bio_end_io handler to find the reverse map for remapping the zone append
write, but stacked block device drivers can and usually do change bi_bdev
when sending on the bio to a lower device.  This can happen e.g. with the
nvme-multipath driver when a NVMe SSD sets the shared namespace bit.

But there is no real need for the bdev in btrfs_record_physical_zoned,
as it is only passed to btrfs_rmap_block, which uses it to pick the
mapping to report if there are multiple reverse mappings.  As zone
writes can only do simple non-mirror writes right now, and anything
more complex will use the stripe tree there is no chance of the multiple
mappings case actually happening.

Instead open code the subset of btrfs_rmap_block in
btrfs_record_physical_zoned, which also removes a memory allocation and
remove the bdev field in the ordered extent.

Fixes: d8e3fb106f39 ("btrfs: zoned: use ZONE_APPEND write for zoned mode")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/ordered-data.h |  1 -
 fs/btrfs/zoned.c        | 47 +++++++++++++++++++++--------------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a3a3e0e9484c6..94749227a73616 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3162,8 +3162,8 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	/* A valid bdev implies a write on a sequential zone */
-	if (ordered_extent->bdev) {
+	/* A valid ->physical implies a write on a sequential zone */
+	if (ordered_extent->physical != (u64)-1) {
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->logical,
 					ordered_extent->disk_num_bytes);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 71f200b14a9369..7ab06aaeae83a1 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -157,7 +157,6 @@ struct btrfs_ordered_extent {
 	 * command in a workqueue context
 	 */
 	u64 physical;
-	struct block_device *bdev;
 };
 
 static inline void
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index af063089ad3465..9782a40985923f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1671,8 +1671,6 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 		return;
 
 	ordered->physical = physical;
-	ordered->bdev = bbio->bio.bi_bdev;
-
 	btrfs_put_ordered_extent(ordered);
 }
 
@@ -1684,43 +1682,46 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	struct extent_map *em;
 	struct btrfs_ordered_sum *sum;
 	u64 orig_logical = ordered->logical;
-	u64 *logical = NULL;
-	int nr, stripe_len;
+	struct map_lookup *map;
+	u64 physical = ordered->physical;
+	u64 chunk_start_phys;
+	u64 logical;
 
-	/* Zoned devices should not have partitions. So, we can assume it is 0 */
-	ASSERT(!bdev_is_partition(ordered->bdev));
-	if (WARN_ON(!ordered->bdev))
+	em = btrfs_get_chunk_map(fs_info, orig_logical, 1);
+	if (IS_ERR(em))
 		return;
+	map = em->map_lookup;
+	chunk_start_phys = map->stripes[0].physical;
 
-	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, ordered->bdev,
-				     ordered->physical, &logical, &nr,
-				     &stripe_len)))
-		goto out;
-
-	WARN_ON(nr != 1);
+	if (WARN_ON_ONCE(map->num_stripes > 1) ||
+	    WARN_ON_ONCE((map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0) ||
+	    WARN_ON_ONCE(physical < chunk_start_phys) ||
+	    WARN_ON_ONCE(physical > chunk_start_phys + em->orig_block_len)) {
+		free_extent_map(em);
+		return;
+	}
+	logical = em->start + (physical - map->stripes[0].physical);
+	free_extent_map(em);
 
-	if (orig_logical == *logical)
-		goto out;
+	if (orig_logical == logical)
+		return;
 
-	ordered->logical = *logical;
+	ordered->logical = logical;
 
 	em_tree = &inode->extent_tree;
 	write_lock(&em_tree->lock);
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
-	em->block_start = *logical;
+	em->block_start = logical;
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
 
 	list_for_each_entry(sum, &ordered->list, list) {
-		if (*logical < orig_logical)
-			sum->bytenr -= orig_logical - *logical;
+		if (logical < orig_logical)
+			sum->bytenr -= orig_logical - logical;
 		else
-			sum->bytenr += *logical - orig_logical;
+			sum->bytenr += logical - orig_logical;
 	}
-
-out:
-	kfree(logical);
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.35.1

