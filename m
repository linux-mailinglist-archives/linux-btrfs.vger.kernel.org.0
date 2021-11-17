Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88BA454E62
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhKQUXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbhKQUXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:03 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FAC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:04 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id 8so3893154qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+tU5Hk9m1KO64+xVReW2Yaf9drjl1ZINo1hzu/HhZ0=;
        b=LbvbrDx768RBA6QUe1JAHSnbdsbghFdhoQTllM5vvM72DWEymz7sxYz/WPrnwQLmLH
         p7Wty9R8KDphSzrj4SrxdZYZ+3gYVQsOFltVr4gGb6VHCxJmf+xy3fAKV/HMzjwqBtQh
         B6IffU+leCiSPzWt8b+dr+SS7pMYnjH1tmW/WL2n4dDTYIWoVrvNG00XUSKjMOWFzB+G
         QrFqvrNrFo+sPxuWjiDcqyIkmsNjMxHhzyaZGYfwvnXBEbdX/eEsQPX3FW44/rTsUN+E
         eI1ieIDX10lqC1ErzydCqpDe/pm6Qq9LDsePKL6d4lnKjDLhkXVMBtEFqLr0IHyRjTYo
         iN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+tU5Hk9m1KO64+xVReW2Yaf9drjl1ZINo1hzu/HhZ0=;
        b=klvcjjKKJwJ8+XnE3hSz/4kb+mGasgz5zRpNkwlQZ1NVr2W3F0+YCzLZ3qXorB/JUt
         NuHLmtsp62OkHZKqhzHlrV75juTOOfEUdx/OUnwHTxu2yQkBMVpVJP70R1+1iQooDIf+
         +7+R3nRACdkG4Q4tiLMpG6Swmqo6vVtKguwPVDmXC0h+RhDqzhEmybWSgrjRp+UgtzM7
         PAVx/lSwN9T6ZHHB6orEBrHCwbXuq+X/Ds1ynEAVVLnPf76woYTs8ovV0LG7YxPIXm9F
         npohY4h0pM55EYtlzQILbQrCjB/ZB9O8Kj41DNolggdv9BfFiOXKJ30WN/1COIAEICoi
         +Rdg==
X-Gm-Message-State: AOAM532PFSvYURd2ZD6gOyqIUoaFWgoXe3BAhSqXjYUCXJ88ibj8eZ2D
        byDlc7C+NTyjbcV1I9nh75Q9CkQC0+aqjQ==
X-Google-Smtp-Source: ABdhPJyQ1w6PPCTdo8y5lPYkCFsH/cTJzi4+hgYduZEngXkcDOeqCksmkMlluBRR2jk4ti9eNxD2gA==
X-Received: by 2002:ac8:7f4f:: with SMTP id g15mr20268654qtk.309.1637180403614;
        Wed, 17 Nov 2021 12:20:03 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:03 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 03/17] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Wed, 17 Nov 2021 12:19:13 -0800
Message-Id: <3e142cc82fbabe36bbb0862f0fd702d1c8a58f48.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_csum_one_bio() loops over each filesystem block in the bio while
keeping a cursor of its current logical position in the file in order to
look up the ordered extent to add the checksums to. However, this
doesn't make much sense for compressed extents, as a sector on disk does
not correspond to a sector of decompressed file data. It happens to work
because 1) the compressed bio always covers one ordered extent and 2)
the size of the bio is always less than the size of the ordered extent.
However, the second point will not always be true for encoded writes.

Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
it can assume that the bio only covers one ordered extent. Since we're
already changing the signature, let's get rid of the contig parameter
and make it implied by the offset parameter, similar to the change we
recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
nr_sectors to blockcount to make it clear that it's the number of
filesystem blocks, not the number of 512-byte sectors.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  3 ++-
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 32 ++++++++++++++------------------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 32da97c3c19d..73350f524fb8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -590,7 +590,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		if (submit) {
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				if (ret)
 					goto finish_cb;
 			}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f1dd2486dcb3..9fd677f2ce15 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3169,7 +3169,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 0f2e2ab34828..6203c85f5a1b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -613,28 +613,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
- * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contain potentially discontiguous bio vecs
- *		 so the logical offset of each should be calculated separately.
+ * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
+ *               file offsets are determined from the page offsets in the bio.
+ *               Otherwise, this is the starting file offset of the bio vecs in
+ *               @bio, which must be contiguous.
+ * @one_ordered: If true, @bio only refers to one ordered extent.
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
+	const bool use_page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	int index;
-	int nr_sectors;
+	int blockcount;
 	unsigned long total_bytes = 0;
 	unsigned long this_sum_bytes = 0;
 	int i;
-	u64 offset;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -648,18 +648,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	if (contig)
-		offset = file_start;
-	else
-		offset = 0; /* shut up gcc */
-
 	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!contig)
+		if (use_page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 
 		if (!ordered) {
@@ -678,13 +673,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 			}
 		}
 
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
+		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
 						 bvec.bv_len + fs_info->sectorsize
 						 - 1);
 
-		for (i = 0; i < nr_sectors; i++) {
-			if (offset >= ordered->file_offset + ordered->num_bytes ||
-			    offset < ordered->file_offset) {
+		for (i = 0; i < blockcount; i++) {
+			if (!one_ordered &&
+			    !in_range(offset, ordered->file_offset,
+				      ordered->num_bytes)) {
 				unsigned long bytes_left;
 
 				sums->len = this_sum_bytes;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 91f7ed27e421..0bd992835cf5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2308,7 +2308,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 					   u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
 
 /*
@@ -2560,7 +2560,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -8162,7 +8162,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 						     struct bio *bio,
 						     u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -8219,7 +8219,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.34.0

