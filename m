Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE666517D9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiECGyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiECGx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1E261C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF221F38D
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEf3uWifOwvB/k5a5fDIIdL/w4x1xcClyINtjIUzaL8=;
        b=rlKrGUbKArVbHz1Zp1Uw084J3yb31g9a9EczKipoAMLdp4iJvAg2aF0EQNhKck/qeQWMp8
        DIJYGXBuPCanJXtMLy00RTYncXKuLHBKsd0LzujUK/zJmpaxRiWzk3vVuFS3eoOAT2LW8E
        58HjaqvFUCIUW9QVMOfMwVtn4x73tOc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0628E13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aINVMq3QcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/13] btrfs: introduce a helper to repair from one mirror
Date:   Tue,  3 May 2022 14:49:51 +0800
Message-Id: <c6a6a6cf51b0b416d6ff83c187b510bbfec59df5.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, read_repair_from_one_mirror(), will repair the data by:

- Assemble a bio and submit it for all corrupted sectors
  During the procedure, we will try to merge as many sectors as possible
  into one bio.
  If not mergeable, then we submit current bio (if we have one), then
  allocate a new one with read_repair_bioset.

  The extra bioset is to prevent allocating a btrfs_bio while the
  btrfs_bioset mempool is waiting for us to release the current one.

  Also to make sector iteration easier, we introduce a new helper,
  btrfs_bio_for_each_sector() to make our life much eaiser.

- Submit the last bio wait for all submitted bios to finish
  Here we don't want to waste time on re-search the csum, thus we use
  btrfs_map_bio() directly.

- Each successful read will clear the bit in
  btrfs_bio::read_repair_cur_bitmap

- Verify each sector of the newly read data
  We have several different combinations:

  * The read failed for one sector
    We just keep the bit in @cur_bad_bitmap, and leave it for next
    mirror.

  * The read succeeded, and the original bio has no data checksum
    We consider this a win, clear the error bit and update the page
    status

  * The read succeeded, but csum still mismatches
    Leave the error bit for next mirror.

  * The read succeeded, and csum matches
    Clear the error bit and update the page status.

- Queue the repaired data to write back to the bad mirror
  And output the a message to indicate the block got repaired.
  This message has changed a little, since we're going with mirror
  based repair, we don't care about the device.

  Thus now we only output root/ino/file_off/logical and good mirror
  number.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c   |  39 +++++------
 fs/btrfs/extent_io.h   |   4 ++
 fs/btrfs/read-repair.c | 150 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 163 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0a7dfb638e0f..3ca366742ce6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2325,9 +2325,9 @@ int free_io_failure(struct extent_io_tree *failure_tree,
  * currently, there can be no more than two copies of every data bit. thus,
  * exactly one rewrite is required.
  */
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num)
 {
 	struct btrfs_device *dev;
 	struct bio_vec bvec;
@@ -2419,8 +2419,9 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
+		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
+					      start, p, start - page_offset(p),
+					      mirror_num);
 		if (ret)
 			break;
 		start += PAGE_SIZE;
@@ -2470,9 +2471,9 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 		num_copies = btrfs_num_copies(fs_info, failrec->logical,
 					      failrec->len);
 		if (num_copies > 1)  {
-			repair_io_failure(fs_info, ino, start, failrec->len,
-					  failrec->logical, page, pg_offset,
-					  failrec->failed_mirror);
+			btrfs_repair_io_failure(fs_info, ino, start,
+					failrec->len, failrec->logical,
+					page, pg_offset, failrec->failed_mirror);
 		}
 	}
 
@@ -2631,7 +2632,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	 *
 	 * Since we're only doing repair for one sector, we only need to get
 	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
+	 * everything for btrfs_repair_io_failure() to do the rest for us.
 	 */
 	ASSERT(failed_mirror);
 	failrec->failed_mirror = failed_mirror;
@@ -2711,7 +2712,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 	return BLK_STS_OK;
 }
 
-static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
+void btrfs_end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 
@@ -2817,7 +2818,7 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 		if (!error)
 			error = ret;
 next:
-		end_page_read(page, uptodate, start + offset, sectorsize);
+		btrfs_end_page_read(page, uptodate, start + offset, sectorsize);
 		if (uptodate)
 			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
 					start + offset,
@@ -3162,7 +3163,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		bio_offset += len;
 
 		/* Update page status and unlock */
-		end_page_read(page, uptodate, start, len);
+		btrfs_end_page_read(page, uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, PageUptodate(page));
 	}
@@ -3695,14 +3696,14 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
-			end_page_read(page, true, cur, iosize);
+			btrfs_end_page_read(page, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end);
-			end_page_read(page, false, cur, end + 1 - cur);
+			btrfs_end_page_read(page, false, cur, end + 1 - cur);
 			ret = PTR_ERR(em);
 			break;
 		}
@@ -3783,7 +3784,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
-			end_page_read(page, true, cur, iosize);
+			btrfs_end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3792,7 +3793,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (test_range_bit(tree, cur, cur_end,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			unlock_extent(tree, cur, cur + iosize - 1);
-			end_page_read(page, true, cur, iosize);
+			btrfs_end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3802,7 +3803,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
 			unlock_extent(tree, cur, cur + iosize - 1);
-			end_page_read(page, false, cur, iosize);
+			btrfs_end_page_read(page, false, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3820,7 +3821,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			 * will never be unlocked.
 			 */
 			unlock_extent(tree, cur, end);
-			end_page_read(page, false, cur, end + 1 - cur);
+			btrfs_end_page_read(page, false, cur, end + 1 - cur);
 			goto out;
 		}
 		cur = cur + iosize;
@@ -5854,7 +5855,7 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
 			return true;
 		/*
 		 * Even there is no eb refs here, we may still have
-		 * end_page_read() call relying on page::private.
+		 * btrfs_end_page_read() call relying on page::private.
 		 */
 		if (atomic_read(&subpage->readers))
 			return true;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b390ec79f9a8..1cf9c0bdbbdf 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -294,6 +294,10 @@ int btrfs_repair_one_sector(struct inode *inode,
 			    struct page *page, unsigned int pgoff,
 			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook);
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num);
+void btrfs_end_page_read(struct page *page, bool uptodate, u64 start, u32 len);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index f75842dcdd02..3169f01e961b 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -4,6 +4,7 @@
 #include "ctree.h"
 #include "volumes.h"
 #include "read-repair.h"
+#include "btrfs_inode.h"
 
 static struct bio_set read_repair_bioset;
 
@@ -111,6 +112,31 @@ static void read_repair_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
+static void read_repair_submit_bio(struct btrfs_read_repair_ctrl *ctrl,
+				   struct btrfs_read_repair_bio *rbio,
+				   int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	blk_status_t ret;
+
+	ASSERT(bio_op(&rbio->bio) == REQ_OP_READ);
+	ASSERT(rbio->bio.bi_private == ctrl);
+	ASSERT(rbio->bio.bi_end_io == read_repair_end_bio);
+	ASSERT(rbio->logical >= ctrl->logical &&
+	       rbio->logical + rbio->bio.bi_iter.bi_size <=
+	       ctrl->logical + ctrl->bio_size);
+	/*
+	 * Our endio is super atomic, and we don't want to waste time on
+	 * lookup data csum. So here we just call btrfs_map_bio()
+	 * directly.
+	 */
+	ret = btrfs_map_bio(fs_info, &rbio->bio, mirror);
+	if (ret) {
+		rbio->bio.bi_status = ret;
+		bio_endio(&rbio->bio);
+	}
+}
+
 /* Add a sector into the read repair bios list for later submission */
 static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 				       struct page *page, unsigned int pgoff,
@@ -131,21 +157,11 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 		    ctrl->logical + (sector_nr << fs_info->sectorsize_bits))
 			goto add;
 
-		ASSERT(bio_op(bio) == REQ_OP_READ);
-		ASSERT(bio->bi_private == ctrl);
-		ASSERT(bio->bi_end_io == read_repair_end_bio);
-		ASSERT(repair_bio(bio)->logical >= ctrl->logical &&
-		       repair_bio(bio)->logical + bio->bi_iter.bi_size <=
-		       ctrl->logical + ctrl->bio_size);
 		/*
 		 * The current bio is not adjacent to the current range,
 		 * just submit it.
-		 *
-		 * Our endio is super atomic, and we don't want to waste time on
-		 * lookup data csum. So here we just call btrfs_map_bio()
-		 * directly.
 		 */
-		ret = btrfs_map_bio(fs_info, bio, mirror);
+		read_repair_submit_bio(ctrl, rbio, mirror);
 		if (ret) {
 			bio->bi_status = ret;
 			bio_endio(bio);
@@ -176,6 +192,118 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
 }
 
+static int get_prev_mirror(int cur_mirror, int num_copy)
+{
+	/* In the context of read-repair, we never use 0 as mirror_num. */
+	ASSERT(cur_mirror);
+	return (cur_mirror - 1 <= 0) ? (num_copy) : cur_mirror - 1;
+}
+
+/*
+ * A helper to iterate every sector of a btrfs_bio (@bbio).
+ *
+ * @bvl and @iter follow the same usage from __bio_for_each_segment().
+ * @bit will indicate the sector number inside the bbio.
+ */
+#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bit)\
+	for ((iter) = (bbio->iter), bit = 0;			\
+	     (iter).bi_size &&					\
+	     ((bvl = bio_iter_iovec((&bbio->bio), (iter))), 1);	\
+	     bit++, bio_advance_iter_single((&bbio->bio), 	\
+		     &(iter), fs_info->sectorsize))
+
+static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
+					struct inode *inode, int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const int nbits = ctrl->bio_size >> fs_info->sectorsize_bits;
+	const u32 sectorsize = fs_info->sectorsize;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	unsigned long *cur_bitmap =
+		btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap;
+	unsigned long *prev_bitmap =
+		btrfs_bio(ctrl->failed_bio)->read_repair_prev_bitmap;
+	int bit;
+
+	/* We shouldn't have any pending IO */
+	ASSERT(!ctrl->cur_bio && atomic_read(&ctrl->io_bytes) == 0);
+
+	/*
+	 * @cur_bad_bitmap contains the corrupted sectors, save it to
+	 * @prev_bad_bitmap.
+	 * Now @cur_bad_bitmap is our workspace bitmap.
+	 */
+	bitmap_copy(prev_bitmap, cur_bitmap, nbits);
+
+	btrfs_bio_for_each_sector(fs_info, bvec, btrfs_bio(ctrl->failed_bio),
+				  iter, bit) {
+		/* Skip good sectors. */
+		if (!test_bit(bit, cur_bitmap))
+			continue;
+		/* Queue and submit bad sectors. */
+		read_repair_bio_add_sector(ctrl, bvec.bv_page, bvec.bv_offset,
+					   bit, mirror);
+	}
+	/* Submit the last assembled bio and wait for all bios to finish. */
+	ASSERT(ctrl->cur_bio);
+	read_repair_submit_bio(ctrl, repair_bio(ctrl->cur_bio), mirror);
+	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
+
+	/* Now re-verify the newly read out data */
+	btrfs_bio_for_each_sector(fs_info, bvec, btrfs_bio(ctrl->failed_bio),
+				  iter, bit) {
+		struct btrfs_inode *binode = BTRFS_I(ctrl->inode);
+		const u64 file_offset = ctrl->file_offset +
+					(bit << fs_info->sectorsize_bits);
+		const u64 logical = ctrl->logical +
+				    (bit << fs_info->sectorsize_bits);
+		struct extent_state *cached = NULL;
+		u8 *csum = NULL;
+		int ret;
+
+		/* Skip already good sectors. */
+		if (!test_bit(bit, prev_bitmap))
+			continue;
+		/* Still bad sectors will be kept for next mirror. */
+		if (test_bit(bit, cur_bitmap))
+			continue;
+
+		if (btrfs_bio(ctrl->failed_bio)->csum)
+			csum = btrfs_bio(ctrl->failed_bio)->csum +
+				bit * fs_info->csum_size;
+		/* No csum, and we got a good read, the data is good now. */
+		if (!csum)
+			goto uptodate;
+
+		ret = btrfs_check_data_sector(fs_info, bvec.bv_page,
+					      bvec.bv_offset, csum);
+		if (ret) {
+			/* Csum mismatch, needs retry in next mirror. */
+			set_bit(bit, cur_bitmap);
+			continue;
+		}
+uptodate:
+		/*
+		 * We repaired one sector, write the correct data back to the bad
+		 * mirror.
+		 */
+		btrfs_repair_io_failure(fs_info, btrfs_ino(binode), file_offset,
+					sectorsize, logical, bvec.bv_page,
+					bvec.bv_offset,
+					get_prev_mirror(mirror, ctrl->num_copies));
+
+		/* Update the page status and extent locks. */
+		btrfs_end_page_read(bvec.bv_page, true, file_offset, sectorsize);
+		set_extent_uptodate(&binode->io_tree,
+				file_offset, file_offset + sectorsize - 1,
+				&cached, GFP_ATOMIC);
+		unlock_extent_cached_atomic(&binode->io_tree,
+				file_offset, file_offset + sectorsize - 1,
+				&cached);
+	}
+}
+
 void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
 	if (!ctrl->failed_bio)
-- 
2.36.0

