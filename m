Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B534E7033
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiCYJoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358525AbiCYJoo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B8BE1C
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:43:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E262A210FD
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648201388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1a39JYTjtmxErxLOK9mcGVkpWKG3ju7zy71bZMfL/w=;
        b=I+SSVMTxnHyJmlNNrCvVydwGMNCkE6b1VHhVNTGeL/T+/sjekk0ez/QCTAVdlWjZD5ZnyW
        t4NWpLZ+nxWXzwqbXS3rIq60mD5ZPhp2oZiFXeqG3DXwLoRrdRLJS3bdo9FGdtWcniTOuM
        qPDQlBewbAY+gAzcQYG7wLcV8K62dD4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5114E132E9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMVBCKyOPWInCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Date:   Fri, 25 Mar 2022 17:42:49 +0800
Message-Id: <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648201268.git.wqu@suse.com>
References: <cover.1648201268.git.wqu@suse.com>
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

[CRYPTIC READ REPAIR]
Currently if we hit a sector with mismatched csum, even we're already in
endio workqueue, we still submit a new bio to read the same sector with
different mirror number.

And let the endio function to handle the new bio again.

Such iterative call is not only harder to grasp, but also require extra
failure record mechanism to record which mirror has corrupted data.

[SYNCHRONOUS REPAIR ADVANTAGE]
However in scrub, we go another way by waiting for read from other
mirrors.

Such synchronous repair makes code much easier to read, and requires no
extra failure record.

Another advantage is, we no longer need the submit_bio_hook for
submit_read_repair().

As the new repair bio only needs to go through btrfs_map_bio() thus we
don't need different handling for submitting the repair bio.

[SYNCHRONOUS REPAIR DISADVANTAGE]
The biggest problem for synchronous repair is performance.
Scrub can afford it as it's running in background.

But for regular read, if we wait for synchronous repair it can be as
slow as a snail for the worst case.

If we have a 128K bio, and all data are corrupted, requiring read from
other copy.

Synchronous repair will repair the first sector, then the 2nd, until the
32th sector, greatly slow down the read.

[REASON FOR RFC]
I'm not sure if such huge performance downgrade can be acceptable for
end-users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 111 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/extent_io.h |   3 +-
 fs/btrfs/inode.c     |  25 +---------
 3 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53b59944013f..3c80695d5627 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2627,11 +2627,47 @@ static bool btrfs_check_repairable(struct inode *inode,
 	return true;
 }
 
+static void submit_bio_wait_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
+static int submit_wait_mirror(struct inode *inode, struct bio *repair_bio,
+			      int mirror)
+{
+	blk_status_t ret;
+	DECLARE_COMPLETION_ONSTACK(done);
+
+	repair_bio->bi_opf = REQ_OP_READ;
+	repair_bio->bi_private = &done;
+	repair_bio->bi_end_io = submit_bio_wait_endio;
+	repair_bio->bi_opf |= REQ_SYNC;
+
+	/*
+	 * All users of read-repair is for data read, and already in their own
+	 * workqueue, with btrfs_bio(repair_bio)->csum already properly filled.
+	 * So here we just need to map and submit it.
+	 */
+	ret = btrfs_map_bio(BTRFS_I(inode)->root->fs_info, repair_bio, mirror);
+	if (ret < 0) {
+		repair_bio->bi_status = ret;
+		bio_endio(repair_bio);
+		return ret;
+	}
+
+	wait_for_completion_io(&done);
+	return blk_status_to_errno(repair_bio->bi_status);
+}
+
+/*
+ * Repair one corrupted sector.
+ *
+ * This function will only return after he repair finished.
+ */
 int btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook)
+			    u64 start, int failed_mirror)
 {
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2641,6 +2677,9 @@ int btrfs_repair_one_sector(struct inode *inode,
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
 	struct btrfs_bio *repair_bbio;
+	int i;
+	int num_copies;
+	bool found_good = false;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
@@ -2657,12 +2696,12 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
+	num_copies = btrfs_num_copies(fs_info, failrec->logical,
+				      fs_info->sectorsize);
+	ASSERT(num_copies > 1);
 	repair_bio = btrfs_bio_alloc(1);
 	repair_bbio = btrfs_bio(repair_bio);
-	repair_bio->bi_opf = REQ_OP_READ;
-	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-	repair_bio->bi_private = failed_bio->bi_private;
 
 	if (failed_bbio->csum) {
 		const u32 csum_size = fs_info->csum_size;
@@ -2679,13 +2718,36 @@ int btrfs_repair_one_sector(struct inode *inode,
 		    "repair read error: submitting new read to mirror %d",
 		    failrec->this_mirror);
 
-	/*
-	 * At this point we have a bio, so any errors from submit_bio_hook()
-	 * will be handled by the endio on the repair_bio, so we can't return an
-	 * error here.
-	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
-	return BLK_STS_OK;
+	for (i = 1; i < num_copies; i++) {
+		int mirror;
+		int ret;
+
+		mirror = failed_mirror + i;
+		if (mirror > num_copies)
+			mirror -= num_copies;
+		ASSERT(mirror <= num_copies);
+
+		ret = submit_wait_mirror(inode, repair_bio, mirror);
+		/* Failed to submit, try next mirror */
+		if (ret < 0)
+			continue;
+
+		/* Verify the checksum */
+		if (failed_bbio->csum)
+			ret = btrfs_check_data_sector(fs_info, page, pgoff,
+						      repair_bbio->csum);
+		if (ret == 0) {
+			found_good = true;
+			break;
+		}
+	}
+	if (!found_good)
+		return -EIO;
+
+	/* Don't forget the cleaer the failure record */
+	clean_io_failure(BTRFS_I(inode)->root->fs_info, failure_tree, tree, start,
+			 page, btrfs_ino(BTRFS_I(inode)), pgoff);
+	return 0;
 }
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
@@ -2720,8 +2782,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
-				      unsigned int error_bitmap,
-				      submit_bio_hook_t *submit_bio_hook)
+				      unsigned int error_bitmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u32 sectorsize = fs_info->sectorsize;
@@ -2759,15 +2820,10 @@ static blk_status_t submit_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, submit_bio_hook);
+				failed_mirror);
 		if (!ret) {
-			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
-			 */
-			continue;
+			uptodate = true;
+			goto next;
 		}
 		/*
 		 * Repair failed, just record the error but still continue.
@@ -2994,7 +3050,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
@@ -3021,8 +3076,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
 			bbio->mirror_num);
-		tree = &BTRFS_I(inode)->io_tree;
-		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
@@ -3057,11 +3110,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			}
 			if (ret)
 				uptodate = false;
-			else
-				clean_io_failure(BTRFS_I(inode)->root->fs_info,
-						 failure_tree, tree, start,
-						 page,
-						 btrfs_ino(BTRFS_I(inode)), 0);
 		}
 
 		if (likely(uptodate))
@@ -3082,8 +3130,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 */
 			submit_read_repair(inode, bio, bio_offset, page,
 					   start - page_offset(page), start,
-					   end, mirror, error_bitmap,
-					   btrfs_submit_data_bio);
+					   end, mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 151e9da5da2d..a8517ffc92cd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -305,8 +305,7 @@ struct io_failure_record {
 int btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook);
+			    u64 start, int failed_mirror);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3ba1315784f6..b11faafabe01 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7761,27 +7761,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	kfree(dip);
 }
 
-static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-					  int mirror_num,
-					  unsigned long bio_flags)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	blk_status_t ret;
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		return ret;
-
-	refcount_inc(&dip->refs);
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	if (ret)
-		refcount_dec(&dip->refs);
-	return ret;
-}
-
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
@@ -7818,12 +7797,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 				int ret;
 
 				ASSERT((start - orig_file_offset) < UINT_MAX);
+
 				ret = btrfs_repair_one_sector(inode,
 						&bbio->bio,
 						start - orig_file_offset,
 						bvec.bv_page, pgoff,
-						start, bbio->mirror_num,
-						submit_dio_repair_bio);
+						start, bbio->mirror_num);
 				if (ret)
 					err = errno_to_blk_status(ret);
 			}
-- 
2.35.1

