Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1755918FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 08:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiHMGAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 02:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiHMGAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 02:00:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5643306
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 23:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A55E2033F;
        Sat, 13 Aug 2022 06:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660370444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RA0lprbYJ0G4qhpl0Sxsdc7JWIh+uc6x4fNMJJWGSSY=;
        b=L5SosPmGDb7SSnLpyq6S4ZDJEIDnfPuk/fY5qljV36ILh/4yevewCQS5gPg/iDjwIK9HGI
        x5260OvzezlfDXFT+M2OO4AJzJsqcfFxuSG1NsWBo2RDVIHA3b/loXq56z+6zP1rK3FtBP
        cSyR7DRMMDJ6bSzdHqtBzPlW+eyNbR0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D18831341F;
        Sat, 13 Aug 2022 06:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ei20Jgo+92JEdQAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 13 Aug 2022 06:00:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] Revert "btrfs: fix repair of compressed extents" and "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Date:   Sat, 13 Aug 2022 14:00:25 +0800
Message-Id: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This reverts commit 81bd9328ab9f9bf818923b92a64896fd4cf58f2b.
This reverts commit 7aa51232e2046cdd719a2f5c9a4537b84554d5a4.

[BUG]
Zygo reported on latest devel branch, he can hit ASSERT()/BUG_ON()
caused crash when doing RAID5 recovery (intentionally corrupt one disk,
and let btrfs to recovery the data during read/scrub).

And The following minimal reproducer can cause extent state leakage at
rmmod time:

  mkfs.btrfs -f -d raid5 -m raid5 $dev1 $dev2 $dev3 -b 1G > /dev/null
  mount $dev1 $mnt
  fsstress -w -d $mnt -n 25 -s 1660807876
  sync
  fssum -A -f -w /tmp/fssum.saved $mnt
  umount $mnt

  # Wipe the dev1 but keeps its super block
  xfs_io -c "pwrite -S 0x0 1m 1023m" $dev1
  mount $dev1 $mnt
  fssum -r /tmp/fssum.saved $mnt > /dev/null
  umount $mnt
  rmmod btrfs

This will lead to the following extent states leakage:

 BTRFS: state leak: start 499712 end 503807 state 5 in tree 1 refs 1
 BTRFS: state leak: start 495616 end 499711 state 5 in tree 1 refs 1
 BTRFS: state leak: start 491520 end 495615 state 5 in tree 1 refs 1
 BTRFS: state leak: start 487424 end 491519 state 5 in tree 1 refs 1
 BTRFS: state leak: start 483328 end 487423 state 5 in tree 1 refs 1
 BTRFS: state leak: start 479232 end 483327 state 5 in tree 1 refs 1
 BTRFS: state leak: start 475136 end 479231 state 5 in tree 1 refs 1
 BTRFS: state leak: start 471040 end 475135 state 5 in tree 1 refs 1

[CAUSE]
Since commit 7aa51232e204 ("btrfs: pass a btrfs_bio to
btrfs_repair_one_sector"), we always use btrfs_bio->file_offset to
determine the file offset of a page.

But that usage assume that, one bio has all its page having a continuous
page offsets.

Unfortunately that's not true, btrfs only requires the logical bytenr
continuous when assembling its bios.

From above script, we have one bio looks like this:
  fssum-27671  submit_one_bio: bio logical=217739264 len=36864
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=466944 <<<
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=724992 <<<
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=729088
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=733184
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=737280
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=741376
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=745472
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=749568
  fssum-27671  submit_one_bio:   r/i=5/261 page_offset=753664

Note that the 1st and the 2nd page has non-continuous page offsets.

This means, at repair time, we will have completely wrong file offset
passed in:

   kworker/u32:2-19927  btrfs_repair_one_sector: r/i=5/261 page_off=729088 file_off=475136 bio_offset=8192

Since the file offset is incorrect, we latter incorrectly set the extent
states, and no way to really release them.

Thus later it causes the leakage.

In fact, this can be even worse, since the file offset is incorrect, we
can hit cases like the incorrect file offset belongs to a HOLE, and
later cause btrfs_num_copies() to trigger error, finally hit
BUG_ON()/ASSERT() later.

[FIX]
To fix the problem, we need to revert commit 7aa51232e204 ("btrfs: pass
a btrfs_bio to btrfs_repair_one_sector"), but unfortunately later commit
81bd9328ab9f ("btrfs: fix repair of compressed extents") has a
dependency on that commit.

Thus we have to revert both commits to fix the problem.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 171 +++++++++++++++++++++++++++--------------
 fs/btrfs/compression.h |   7 ++
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent_io.c   |  93 +++++++++++++---------
 fs/btrfs/extent_io.h   |   8 +-
 fs/btrfs/inode.c       |  12 +--
 6 files changed, 186 insertions(+), 107 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e84d22c5c6a8..5f82151454cb 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -136,14 +136,66 @@ static int compression_decompress(int type, struct list_head *ws,
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
+static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
+				      unsigned long disk_size)
+{
+	return sizeof(struct compressed_bio) +
+		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * fs_info->csum_size;
+}
+
+static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
+				 u64 disk_start)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 csum_size = fs_info->csum_size;
+	const u32 sectorsize = fs_info->sectorsize;
+	struct page *page;
+	unsigned int i;
+	u8 csum[BTRFS_CSUM_SIZE];
+	struct compressed_bio *cb = bio->bi_private;
+	u8 *cb_sum = cb->sums;
+
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
+		return 0;
+
+	for (i = 0; i < cb->nr_pages; i++) {
+		u32 pg_offset;
+		u32 bytes_left = PAGE_SIZE;
+		page = cb->compressed_pages[i];
+
+		/* Determine the remaining bytes inside the page first */
+		if (i == cb->nr_pages - 1)
+			bytes_left = cb->compressed_len - i * PAGE_SIZE;
+
+		/* Hash through the page sector by sector */
+		for (pg_offset = 0; pg_offset < bytes_left;
+		     pg_offset += sectorsize) {
+			int ret;
+
+			ret = btrfs_check_sector_csum(fs_info, page, pg_offset,
+						      csum, cb_sum);
+			if (ret) {
+				btrfs_print_data_csum_error(inode, disk_start,
+						csum, cb_sum, cb->mirror_num);
+				if (btrfs_bio(bio)->device)
+					btrfs_dev_stat_inc_and_print(
+						btrfs_bio(bio)->device,
+						BTRFS_DEV_STAT_CORRUPTION_ERRS);
+				return -EIO;
+			}
+			cb_sum += csum_size;
+			disk_start += sectorsize;
+		}
+	}
+	return 0;
+}
+
 static void finish_compressed_bio_read(struct compressed_bio *cb)
 {
 	unsigned int index;
 	struct page *page;
 
-	if (cb->status == BLK_STS_OK)
-		cb->status = errno_to_blk_status(btrfs_decompress_bio(cb));
-
 	/* Release the compressed pages */
 	for (index = 0; index < cb->nr_pages; index++) {
 		page = cb->compressed_pages[index];
@@ -161,54 +213,59 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
 	kfree(cb);
 }
 
-/*
- * Verify the checksums and kick off repair if needed on the uncompressed data
- * before decompressing it into the original bio and freeing the uncompressed
- * pages.
+/* when we finish reading compressed pages from the disk, we
+ * decompress them and then run the bio end_io routines on the
+ * decompressed pages (in the inode address space).
+ *
+ * This allows the checksumming and other IO error handling routines
+ * to work normally
+ *
+ * The compressed pages are freed here, and it must be run
+ * in process context
  */
 static void end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
-	struct inode *inode = cb->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *bi = BTRFS_I(inode);
-	bool csum = !(bi->flags & BTRFS_INODE_NODATASUM) &&
-		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-	blk_status_t status = bio->bi_status;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	u32 offset;
-
-	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
-		u64 start = bbio->file_offset + offset;
-
-		if (!status &&
-		    (!csum || !btrfs_check_data_csum(inode, bbio, offset,
-						     bv.bv_page, bv.bv_offset))) {
-			clean_io_failure(fs_info, &bi->io_failure_tree,
-					 &bi->io_tree, start, bv.bv_page,
-					 btrfs_ino(bi), bv.bv_offset);
-		} else {
-			int ret;
+	struct inode *inode;
+	unsigned int mirror = btrfs_bio(bio)->mirror_num;
+	int ret = 0;
 
-			refcount_inc(&cb->pending_ios);
-			ret = btrfs_repair_one_sector(inode, bbio, offset,
-						      bv.bv_page, bv.bv_offset,
-						      btrfs_submit_data_read_bio);
-			if (ret) {
-				refcount_dec(&cb->pending_ios);
-				status = errno_to_blk_status(ret);
-			}
-		}
-	}
+	if (bio->bi_status)
+		cb->status = bio->bi_status;
 
-	if (status)
-		cb->status = status;
+	if (!refcount_dec_and_test(&cb->pending_ios))
+		goto out;
 
-	if (refcount_dec_and_test(&cb->pending_ios))
-		finish_compressed_bio_read(cb);
-	btrfs_bio_free_csum(bbio);
+	/*
+	 * Record the correct mirror_num in cb->orig_bio so that
+	 * read-repair can work properly.
+	 */
+	btrfs_bio(cb->orig_bio)->mirror_num = mirror;
+	cb->mirror_num = mirror;
+
+	/*
+	 * Some IO in this cb have failed, just skip checksum as there
+	 * is no way it could be correct.
+	 */
+	if (cb->status != BLK_STS_OK)
+		goto csum_failed;
+
+	inode = cb->inode;
+	ret = check_compressed_csum(BTRFS_I(inode), bio,
+				    bio->bi_iter.bi_sector << 9);
+	if (ret)
+		goto csum_failed;
+
+	/* ok, we're the last bio for this extent, lets start
+	 * the decompression.
+	 */
+	ret = btrfs_decompress_bio(cb);
+
+csum_failed:
+	if (ret)
+		cb->status = errno_to_blk_status(ret);
+	finish_compressed_bio_read(cb);
+out:
 	bio_put(bio);
 }
 
@@ -401,7 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
-	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
+	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
 	refcount_set(&cb->pending_ios, 1);
@@ -409,6 +466,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->inode = &inode->vfs_inode;
 	cb->start = start;
 	cb->len = len;
+	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
 	cb->writeback = writeback;
@@ -677,6 +735,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	blk_status_t ret;
 	int ret2;
 	int i;
+	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
 
@@ -694,7 +753,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
-	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);
+	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb) {
 		ret = BLK_STS_RESOURCE;
 		goto out;
@@ -703,6 +762,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	refcount_set(&cb->pending_ios, 1);
 	cb->status = BLK_STS_OK;
 	cb->inode = inode;
+	cb->mirror_num = mirror_num;
+	sums = cb->sums;
 
 	cb->start = em->orig_start;
 	em_len = em->len;
@@ -785,25 +846,19 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			submit = true;
 
 		if (submit) {
-			/* Save the original iter for read repair */
-			if (bio_op(comp_bio) == REQ_OP_READ)
-				btrfs_bio(comp_bio)->iter = comp_bio->bi_iter;
-
-			/*
-			 * Save the initial offset of this chunk, as there
-			 * is no direct correlation between compressed pages and
-			 * the original file offset.  The field is only used for
-			 * priting error messages.
-			 */
-			btrfs_bio(comp_bio)->file_offset = file_offset;
+			unsigned int nr_sectors;
 
-			ret = btrfs_lookup_bio_sums(inode, comp_bio, NULL);
+			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 			if (ret) {
 				comp_bio->bi_status = ret;
 				bio_endio(comp_bio);
 				break;
 			}
 
+			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
+						  fs_info->sectorsize);
+			sums += fs_info->csum_size * nr_sectors;
+
 			ASSERT(comp_bio->bi_iter.bi_size);
 			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 			comp_bio = NULL;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 1aa02903de69..e94cd36e7d7e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -59,12 +59,19 @@ struct compressed_bio {
 
 	/* IO errors */
 	blk_status_t status;
+	int mirror_num;
 
 	union {
 		/* For reads, this is the bio we are copying the data into */
 		struct bio *orig_bio;
 		struct work_struct write_end_work;
 	};
+
+	/*
+	 * the start of a variable length array of checksums only
+	 * used by reads
+	 */
+	u8 sums[];
 };
 
 static inline unsigned int btrfs_compress_type(unsigned int type_level)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..c567c73f7509 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3293,8 +3293,6 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfae67c593c5..bc30c0a4a7f2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -182,7 +182,6 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
-	struct bio_vec *bv;
 	struct inode *inode;
 	int mirror_num;
 
@@ -190,15 +189,12 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 		return;
 
 	bio = bio_ctrl->bio;
-	bv = bio_first_bvec_all(bio);
-	inode = bv->bv_page->mapping->host;
+	inode = bio_first_page_all(bio)->mapping->host;
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
-
 	if (!is_data_inode(inode))
 		btrfs_submit_metadata_bio(inode, bio, mirror_num);
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
@@ -2539,16 +2535,18 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 }
 
 static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     struct btrfs_bio *bbio,
-							     unsigned int bio_offset)
+							     u64 start,
+							     int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	u64 start = bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
+	struct extent_map *em;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
+	u64 logical;
 
 	failrec = get_state_failrec(failure_tree, start);
 	if (!IS_ERR(failrec)) {
@@ -2560,7 +2558,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		 * (e.g. with a list for failed_mirror) to make
 		 * clean_io_failure() clean all those errors at once.
 		 */
-		ASSERT(failrec->this_mirror == bbio->mirror_num);
+		ASSERT(failrec->this_mirror == failed_mirror);
 		ASSERT(failrec->len == fs_info->sectorsize);
 		return failrec;
 	}
@@ -2571,15 +2569,43 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 
 	failrec->start = start;
 	failrec->len = sectorsize;
-	failrec->failed_mirror = bbio->mirror_num;
-	failrec->this_mirror = bbio->mirror_num;
-	failrec->logical = (bbio->iter.bi_sector << SECTOR_SHIFT) + bio_offset;
+	failrec->failed_mirror = failed_mirror;
+	failrec->this_mirror = failed_mirror;
+	failrec->compress_type = BTRFS_COMPRESS_NONE;
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, start, failrec->len);
+	if (!em) {
+		read_unlock(&em_tree->lock);
+		kfree(failrec);
+		return ERR_PTR(-EIO);
+	}
+
+	if (em->start > start || em->start + em->len <= start) {
+		free_extent_map(em);
+		em = NULL;
+	}
+	read_unlock(&em_tree->lock);
+	if (!em) {
+		kfree(failrec);
+		return ERR_PTR(-EIO);
+	}
+
+	logical = start - em->start;
+	logical = em->block_start + logical;
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		logical = em->block_start;
+		failrec->compress_type = em->compress_type;
+	}
 
 	btrfs_debug(fs_info,
-		    "new io failure record logical %llu start %llu",
-		    failrec->logical, start);
+		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
+		    logical, start, failrec->len);
 
-	failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical, sectorsize);
+	failrec->logical = logical;
+	free_extent_map(em);
+
+	failrec->num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
 	if (failrec->num_copies == 1) {
 		/*
 		 * We only have a single copy of the data, so don't bother with
@@ -2609,16 +2635,17 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
-int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
-			    u32 bio_offset, struct page *page, unsigned int pgoff,
+int btrfs_repair_one_sector(struct inode *inode,
+			    struct bio *failed_bio, u32 bio_offset,
+			    struct page *page, unsigned int pgoff,
+			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook)
 {
-	u64 start = failed_bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct bio *failed_bio = &failed_bbio->bio;
+	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
 	struct btrfs_bio *repair_bbio;
@@ -2628,7 +2655,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, failed_bbio, bio_offset);
+	failrec = btrfs_get_io_failure_record(inode, start, failed_mirror);
 	if (IS_ERR(failrec))
 		return PTR_ERR(failrec);
 
@@ -2678,7 +2705,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 * will be handled by the endio on the repair_bio, so we can't return an
 	 * error here.
 	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, 0);
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->compress_type);
 	return BLK_STS_OK;
 }
 
@@ -2724,10 +2751,9 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 				    offset + sectorsize - 1, &cached);
 }
 
-static void submit_data_read_repair(struct inode *inode,
-				    struct btrfs_bio *failed_bbio,
+static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
 				    u32 bio_offset, const struct bio_vec *bvec,
-				    unsigned int error_bitmap)
+				    int failed_mirror, unsigned int error_bitmap)
 {
 	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2738,7 +2764,7 @@ static void submit_data_read_repair(struct inode *inode,
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
 	int i;
 
-	BUG_ON(bio_op(&failed_bbio->bio) == REQ_OP_WRITE);
+	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
 	/* This repair is only for data */
 	ASSERT(is_data_inode(inode));
@@ -2750,7 +2776,7 @@ static void submit_data_read_repair(struct inode *inode,
 	 * We only get called on buffered IO, thus page must be mapped and bio
 	 * must not be cloned.
 	 */
-	ASSERT(page->mapping && !bio_flagged(&failed_bbio->bio, BIO_CLONED));
+	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
 
 	/* Iterate through all the sectors in the range */
 	for (i = 0; i < nr_bits; i++) {
@@ -2767,9 +2793,10 @@ static void submit_data_read_repair(struct inode *inode,
 			goto next;
 		}
 
-		ret = btrfs_repair_one_sector(inode, failed_bbio,
-				bio_offset + offset, page, pgoff + offset,
-				btrfs_submit_data_read_bio);
+		ret = btrfs_repair_one_sector(inode, failed_bio,
+				bio_offset + offset,
+				page, pgoff + offset, start + offset,
+				failed_mirror, btrfs_submit_data_read_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
@@ -3086,10 +3113,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * Only try to repair bios that actually made it to a
 			 * device.  If the bio failed to be submitted mirror
 			 * is 0 and we need to fail it without retrying.
-			 *
-			 * This also includes the high level bios for compressed
-			 * extents - these never make it to a device and repair
-			 * is already handled on the lower compressed bio.
 			 */
 			if (mirror > 0)
 				repair = true;
@@ -3107,8 +3130,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bbio, bio_offset, bvec,
-						error_bitmap);
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
 		} else {
 			/* Update page status and unlock */
 			end_page_read(page, uptodate, start, len);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4bc72a87b9a9..280af70c0495 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -57,7 +57,6 @@ enum {
 #define BITMAP_LAST_BYTE_MASK(nbits) \
 	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
 
-struct btrfs_bio;
 struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
@@ -261,13 +260,16 @@ struct io_failure_record {
 	u64 start;
 	u64 len;
 	u64 logical;
+	enum btrfs_compression_type compress_type;
 	int this_mirror;
 	int failed_mirror;
 	int num_copies;
 };
 
-int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
-			    u32 bio_offset, struct page *page, unsigned int pgoff,
+int btrfs_repair_one_sector(struct inode *inode,
+			    struct bio *failed_bio, u32 bio_offset,
+			    struct page *page, unsigned int pgoff,
+			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f0c97d25b4a0..691a849cd6c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2749,9 +2749,6 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 		return;
 	}
 
-	/* Save the original iter for read repair */
-	btrfs_bio(bio)->iter = bio->bi_iter;
-
 	/*
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
@@ -8008,8 +8005,9 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		} else {
 			int ret;
 
-			ret = btrfs_repair_one_sector(inode, bbio, offset,
-					bv.bv_page, bv.bv_offset,
+			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
+					bv.bv_page, bv.bv_offset, start,
+					bbio->mirror_num,
 					submit_dio_repair_bio);
 			if (ret)
 				err = errno_to_blk_status(ret);
@@ -8058,10 +8056,6 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 	struct btrfs_dio_private *dip = bio->bi_private;
 	blk_status_t ret;
 
-	/* Save the original iter for read repair */
-	if (btrfs_op(bio) == BTRFS_MAP_READ)
-		btrfs_bio(bio)->iter = bio->bi_iter;
-
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		goto map;
 
-- 
2.37.1

