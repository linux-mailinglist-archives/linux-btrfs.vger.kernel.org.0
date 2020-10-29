Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0230529E3EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgJ2HXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:23:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgJ2HXn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603955548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLTk1fYoxp60o0msox4B2Yquck+MiyazKsSYuQ/mpmM=;
        b=S/MfUwABN5Lo27d9IiBXHkvT0eIFQVF/d54KVzXHDzBZmY+mqzAU0S5/0I4DqfQ0CQFDh5
        YrDDswPDMgdCYdtoLAet4wBn5Psc5KBfWIFuEOCrN9xsXTX+9ZsorQDD3iIXayS2AgwamW
        dYntQM/DQp36l/f0RAAf03doWSk4JhM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12A48AFB2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 07:12:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: file-item: remove the btrfs_find_ordered_sum() call in btrfs_lookup_bio_sums()
Date:   Thu, 29 Oct 2020 15:12:17 +0800
Message-Id: <20201029071218.49860-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029071218.49860-1-wqu@suse.com>
References: <20201029071218.49860-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_lookup_bio_sums() is only called for read bios.
While btrfs_find_ordered_sum() is to search ordered extent sums, which
is only for write path.

This means the call for btrfs_find_ordered_sum() in fact makes no sense.

So this patch will remove the btrfs_find_ordered_sum() call in
btrfs_lookup_bio_sums().
And since btrfs_lookup_bio_sums() is the only caller for
btrfs_find_ordered_sum(), also remove the implementation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c    | 16 +++++++++-----
 fs/btrfs/ordered-data.c | 46 -----------------------------------------
 fs/btrfs/ordered-data.h |  2 --
 3 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index fbc60948b2c4..acacdd0bfe2c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -240,7 +240,8 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 }
 
 /**
- * btrfs_lookup_bio_sums - Look up checksums for a bio.
+ * btrfs_lookup_bio_sums - Look up checksums for a read bio.
+ *
  * @inode: inode that the bio is for.
  * @bio: bio to look up.
  * @offset: Unless (u64)-1, look up checksums for this offset in the file.
@@ -272,6 +273,15 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	int count = 0;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
+	/*
+	 * This function is only called for read bio.
+	 *
+	 * This means several things:
+	 * - All of our csums should only be csum tree
+	 *   No ordered extents csums. As ordered extents are only for write
+	 *   path.
+	 */
+	ASSERT(bio_op(bio) == REQ_OP_READ);
 	path = btrfs_alloc_path();
 	if (!path)
 		return BLK_STS_RESOURCE;
@@ -322,10 +332,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 
 		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
-					       csum, nblocks);
-		if (count)
-			goto found;
 
 		if (!item || disk_bytenr < item_start_offset ||
 		    disk_bytenr >= item_last_offset) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ebac13389e7e..2a841832da49 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -798,52 +798,6 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
 	return entry;
 }
 
-/*
- * search the ordered extents for one corresponding to 'offset' and
- * try to find a checksum.  This is used because we allow pages to
- * be reclaimed before their checksum is actually put into the btree
- */
-int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_ordered_sum *ordered_sum;
-	struct btrfs_ordered_extent *ordered;
-	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
-	unsigned long num_sectors;
-	unsigned long i;
-	u32 sectorsize = btrfs_inode_sectorsize(inode);
-	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	int index = 0;
-
-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), offset);
-	if (!ordered)
-		return 0;
-
-	spin_lock_irq(&tree->lock);
-	list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
-		if (disk_bytenr >= ordered_sum->bytenr &&
-		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
-			i = (disk_bytenr - ordered_sum->bytenr) >>
-			    inode->i_sb->s_blocksize_bits;
-			num_sectors = ordered_sum->len >>
-				      inode->i_sb->s_blocksize_bits;
-			num_sectors = min_t(int, len - index, num_sectors - i);
-			memcpy(sum + index, ordered_sum->sums + i * csum_size,
-			       num_sectors * csum_size);
-
-			index += (int)num_sectors * csum_size;
-			if (index == len)
-				goto out;
-			disk_bytenr += num_sectors * sectorsize;
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
index d61ea9c880a3..051a806d186a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -174,8 +174,6 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
 		u64 len);
-int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
-- 
2.29.1

