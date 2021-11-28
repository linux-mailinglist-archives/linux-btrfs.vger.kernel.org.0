Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162644604CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhK1F6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhK1F4n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EDD51FD36;
        Sun, 28 Nov 2021 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9OeTUH5YPlOoejJ4fN/vPvwJ6mLW4jcHaXUbjR6gNgY=;
        b=fJJanMZMTmwhQASz5qnU51HcO0/quzgrKGAAsoirnW2kZ1h0Ol72jVdL3N8OB55hbNF8Wk
        OUB9XEf2C1pQJy9ZzZyandd+liaDymxkgfc6bDDMH2r1CirhpvHQd8RPSR51g4uKLzOuMv
        7PRW5TecbMWqd+u/0TESy6mFXj/JUY8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6693413446;
        Sun, 28 Nov 2021 05:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHPHDVYZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 06/11] btrfs: make end_bio_extent_readpage() to handle split bio properly
Date:   Sun, 28 Nov 2021 13:52:54 +0800
Message-Id: <20211128055259.39249-7-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This involves the following modifications:

- Use bio_for_each_segment() instead of bio_for_each_segment_all()
  bio_for_each_segment_all() will iterate all bvecs, even if they are
  not referred by current bi_iter.

  *_all() variant can only be used if the bio is never split.

  Change it to bio_for_each_segment() call so we won't have endio called
  on the same range by both split and parent bios.

- Make check_data_csum() to take bbio->offset_to_original into
  consideration
  Since btrfs bio can be split now, split/original bio can all start
  with some offset to the original logical bytenr.

  Take btrfs_bio::offset_to_original into consideration to get correct
  checksum offset.

- Remove the BIO_CLONED ASSERT() in submit_read_repair()

For metadata path, there is no change as they only rely on file offset,
doesn't care about btrfs_bio at all.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 34 +++++++++++++++++++---------------
 fs/btrfs/inode.c     | 23 +++++++++++++++++++++--
 fs/btrfs/volumes.h   |  3 ++-
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 34195891b0b5..67965faeef47 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2735,10 +2735,9 @@ static blk_status_t submit_read_repair(struct inode *inode,
 	ASSERT(error_bitmap);
 
 	/*
-	 * We only get called on buffered IO, thus page must be mapped and bio
-	 * must not be cloned.
-	 */
-	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
+	 * We only get called on buffered IO, thus page must be mapped
+	*/
+	ASSERT(page->mapping);
 
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
@@ -2992,7 +2991,8 @@ static struct extent_buffer *find_extent_buffer_readpage(
  */
 static void end_bio_extent_readpage(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
@@ -3003,11 +3003,15 @@ static void end_bio_extent_readpage(struct bio *bio)
 	u32 bio_offset = 0;
 	int mirror;
 	int ret;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	/*
+	 * We should have saved the orignal bi_iter, and then start iterating
+	 * using that saved iter, as at endio time bi_iter is not reliable.
+	 */
+	ASSERT(bbio->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, bbio->iter) {
 		bool uptodate = !bio->bi_status;
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
@@ -3030,19 +3034,19 @@ static void end_bio_extent_readpage(struct bio *bio)
 		 * for unaligned offsets, and an error if they don't add up to
 		 * a full sector.
 		 */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(bvec.bv_offset, sectorsize))
 			btrfs_err(fs_info,
 		"partial page read in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
+				  bvec.bv_offset, bvec.bv_len);
+		else if (!IS_ALIGNED(bvec.bv_offset + bvec.bv_len,
 				     sectorsize))
 			btrfs_info(fs_info,
 		"incomplete page read with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+				   bvec.bv_offset, bvec.bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
-		len = bvec->bv_len;
+		start = page_offset(page) + bvec.bv_offset;
+		end = start + bvec.bv_len - 1;
+		len = bvec.bv_len;
 
 		mirror = bbio->mirror_num;
 		if (likely(uptodate)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e6901aeeb89..1bf56c2b4bd9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3220,6 +3220,24 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+static u8 *bbio_get_real_csum(struct btrfs_fs_info *fs_info,
+			      struct btrfs_bio *bbio)
+{
+	u8 *ret;
+
+	/* Split bbio needs to grab csum from its parent */
+	if (bbio->is_split_bio)
+		ret = btrfs_bio(bbio->parent)->csum;
+	else
+		ret = bbio->csum;
+
+	if (ret == NULL)
+		return ret;
+
+	return ret + (bbio->offset_to_original >> fs_info->sectorsize_bits) *
+		     fs_info->csum_size;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3247,7 +3265,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
-	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
+	csum_expected = bbio_get_real_csum(fs_info, bbio) +
+			offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -3305,7 +3324,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 	 * Normally this should be covered by above check for compressed read
 	 * or the next check for NODATASUM.  Just do a quicker exit here.
 	 */
-	if (bbio->csum == NULL)
+	if (bbio_get_real_csum(fs_info, bbio) == NULL)
 		return 0;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index baccf895a544..38028926c679 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -401,7 +401,8 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 {
-	if (bbio->csum != bbio->csum_inline) {
+	/* Only free the csum if we're not a split bio */
+	if (!bbio->is_split_bio && bbio->csum != bbio->csum_inline) {
 		kfree(bbio->csum);
 		bbio->csum = NULL;
 	}
-- 
2.34.0

