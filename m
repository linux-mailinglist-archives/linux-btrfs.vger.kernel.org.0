Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54412CB548
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgLBGt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbgLBGt6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1L7AU8lT4bcUIwOOLLllfpn90gWuMD0UJ0DFn53ZUA=;
        b=aE79wDQu0IZ8drq+ur21VWFWxWjf53+lVD0sN/+tIDz/Ip5JL5J+bm2ntU3/53dvXe1uN2
        rSMgiVI7VsHlNpxm3npzrENvgsfHXcqjysXGP6ncCQCi+jiJbmlgxQiK9VwR8o2Se1g8Mf
        FvVUV+wcBkiZ5+/6PCnWw8BOeULnU3U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 629AAAED6;
        Wed,  2 Dec 2020 06:48:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 09/15] btrfs: file-item: remove the btrfs_find_ordered_sum() call in btrfs_lookup_bio_sums()
Date:   Wed,  2 Dec 2020 14:48:05 +0800
Message-Id: <20201202064811.100688-10-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_lookup_bio_sums() is only called for read bios.
While btrfs_find_ordered_sum() is to search ordered extent sums, which
is only for write path.

This means to read a page we either:
- Submit read bio if it's no uptodate
  This means we only need to search csum tree for csums.

- The page is already uptodate
  It can be marked uptodate for previous read, or being marked dirty.
  As we always mark page uptodate for dirty page.
  In that case, we don't need to submit read bio at all, thus no need
  to search any csum.

So this patch will remove the btrfs_find_ordered_sum() call in
btrfs_lookup_bio_sums().
And since btrfs_lookup_bio_sums() is the only caller for
btrfs_find_ordered_sum(), also remove the implementation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c    | 16 ++++++++++-----
 fs/btrfs/ordered-data.c | 44 -----------------------------------------
 fs/btrfs/ordered-data.h |  2 --
 3 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8fa98d55fcfd..3df13d0446b9 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -239,7 +239,8 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 }
 
 /**
- * btrfs_lookup_bio_sums - Look up checksums for a bio.
+ * btrfs_lookup_bio_sums - Look up checksums for a read bio.
+ *
  * @inode: inode that the bio is for.
  * @bio: bio to look up.
  * @offset: Unless (u64)-1, look up checksums for this offset in the file.
@@ -274,6 +275,15 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
 		return BLK_STS_OK;
 
+	/*
+	 * This function is only called for read bio.
+	 *
+	 * This means several things:
+	 * - All of our csums should only be in csum tree
+	 *   No ordered extents csums. As ordered extents are only for write
+	 *   path.
+	 */
+	ASSERT(bio_op(bio) == REQ_OP_READ);
 	path = btrfs_alloc_path();
 	if (!path)
 		return BLK_STS_RESOURCE;
@@ -324,10 +334,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 
 		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-		count = btrfs_find_ordered_sum(BTRFS_I(inode), offset,
-					       disk_bytenr, csum, nblocks);
-		if (count)
-			goto found;
 
 		if (!item || disk_bytenr < item_start_offset ||
 		    disk_bytenr >= item_last_offset) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 0d61f9fefc02..79d366a36223 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -854,50 +854,6 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	return entry;
 }
 
-/*
- * search the ordered extents for one corresponding to 'offset' and
- * try to find a checksum.  This is used because we allow pages to
- * be reclaimed before their checksum is actually put into the btree
- */
-int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
-			   u64 disk_bytenr, u8 *sum, int len)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_sum *ordered_sum;
-	struct btrfs_ordered_extent *ordered;
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
-	unsigned long num_sectors;
-	unsigned long i;
-	const u32 csum_size = fs_info->csum_size;
-	int index = 0;
-
-	ordered = btrfs_lookup_ordered_extent(inode, offset);
-	if (!ordered)
-		return 0;
-
-	spin_lock_irq(&tree->lock);
-	list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
-		if (disk_bytenr >= ordered_sum->bytenr &&
-		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
-			i = (disk_bytenr - ordered_sum->bytenr) >>
-			    fs_info->sectorsize_bits;
-			num_sectors = ordered_sum->len >> fs_info->sectorsize_bits;
-			num_sectors = min_t(int, len - index, num_sectors - i);
-			memcpy(sum + index, ordered_sum->sums + i * csum_size,
-			       num_sectors * csum_size);
-
-			index += (int)num_sectors * csum_size;
-			if (index == len)
-				goto out;
-			disk_bytenr += num_sectors * fs_info->sectorsize;
-		}
-	}
-out:
-	spin_unlock_irq(&tree->lock);
-	btrfs_put_ordered_extent(ordered);
-	return index;
-}
-
 /*
  * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
  * ordered extents in it are run to completion.
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 367269effd6a..0bfa82b58e23 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -183,8 +183,6 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		u64 len);
 void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 					   struct list_head *list);
-int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
-			   u64 disk_bytenr, u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-- 
2.29.2

