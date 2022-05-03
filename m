Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6E517D9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiECGyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiECGx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF25167FE
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AFEE210ED
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb5NUbnZMOg7TL4OHvnc10p+2sT0LtSeYXu26S1MWBY=;
        b=SN55G5DOZ380Ky6ybU7yahR9cIE/7zlghkuh5xLry3XlzMGsM0eewEFCc4IvEJzM5uqDrx
        eu+Bun2lKsTQh89YxJ3c+Oe8k0Qv6x/t5jqGCUxGO4IJxwhBilqO+W71VchH7peJGlZh7w
        +8ajv4DKQCFeIXi878ahmzZlEN3igek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B563B13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6O9gIbDQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/13] btrfs: switch buffered read to the new read repair routine
Date:   Tue,  3 May 2022 14:49:54 +0800
Message-Id: <a21879f3255dc26029e9ebc4a331fa5365523f27.1651559986.git.wqu@suse.com>
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

Instead of reply on failrec and failure_tree, we use the new
btrfs_read_repair_ctrl to do the repair.

The read time repair will have a different timing now:

- Function btrfs_submit_data_bio() will pre-allocate the bitmaps
  So if we failed to grab enough memory, the data read bio will fail
  early with ENOMEM, and VFS will retry with much smaller range,
  allowing us to have a higher chance to get memory allocated in next
  try.

- Function end_bio_extent_readpage() verifies the csum
  This is the same as usual.

- Function submit_data_read_repair() will call
  btrfs_read_repair_add_sector()
  This function will only record the corrupted sectors.

- After all the bvec are iterated, call btrfs_read_repair_finish() to
  do the repair
  Which will assemble needed bios, submit them, wait for them to finish,
  and re-check the csum for all the remaining mirrors.

Now this means, end_bio_extent_readpage() will handle all the read
pair in-house, without re-entry the same endio calls.

Currently this only works for buffered data read path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c   | 68 +++++++++++++-----------------------------
 fs/btrfs/read-repair.c | 61 +++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3ca366742ce6..9077f0b06b92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2740,15 +2740,11 @@ void btrfs_end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
-					    struct inode *inode,
-					    struct bio *failed_bio,
-					    u32 bio_offset,
-					    const struct bio_vec *bvec,
-					    int failed_mirror,
-					    unsigned int error_bitmap)
-{
-	const unsigned int pgoff = bvec->bv_offset;
+static void submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
+				    struct inode *inode, struct bio *failed_bio,
+				    u32 bio_offset, const struct bio_vec *bvec,
+				    int failed_mirror, unsigned int error_bitmap)
+{
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page *page = bvec->bv_page;
 	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
@@ -2758,7 +2754,6 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 	/* The failed offset should be the file offset of the failed bio. */
 	const u64 failed_offset = page_offset(bio_first_page_all(failed_bio)) +
 				  bio_first_bvec_all(failed_bio)->bv_offset;
-	int error = 0;
 	int i;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2780,7 +2775,6 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 		const unsigned int offset = i * sectorsize;
 		struct extent_state *cached = NULL;
 		bool uptodate = false;
-		int ret;
 
 		if (!(error_bitmap & (1U << i))) {
 			/*
@@ -2788,48 +2782,28 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 			 * and unlock the range.
 			 */
 			uptodate = true;
-			goto next;
+			btrfs_end_page_read(page, uptodate, start + offset,
+					    sectorsize);
+			if (uptodate)
+				set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+						start + offset,
+						start + offset + sectorsize - 1,
+						&cached, GFP_ATOMIC);
+			unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+					start + offset,
+					start + offset + sectorsize - 1,
+					&cached);
+			continue;
 		}
 
 		/*
-		 * Currently we only update the bitmap and do nothing in
-		 * btrfs_read_repair_finish(), thus it can co-exist with the
-		 * old code.
+		 * The page read end and extent unlock will be handled in
+		 * btrfs_read_repair_finish().
 		 */
 		btrfs_read_repair_add_sector(inode, ctrl, failed_bio,
-					     bio_offset + offset, failed_offset);
-		ret = btrfs_repair_one_sector(inode, failed_bio,
-				bio_offset + offset,
-				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
-		if (!ret) {
-			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
-			 */
-			continue;
-		}
-		/*
-		 * Repair failed, just record the error but still continue.
-		 * Or the remaining sectors will not be properly unlocked.
-		 */
-		if (!error)
-			error = ret;
-next:
-		btrfs_end_page_read(page, uptodate, start + offset, sectorsize);
-		if (uptodate)
-			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
-					start + offset,
-					start + offset + sectorsize - 1,
-					&cached, GFP_ATOMIC);
-		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
-				start + offset,
-				start + offset + sectorsize - 1,
-				&cached);
+					     bio_offset + offset,
+					     failed_offset);
 	}
-	return errno_to_blk_status(error);
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index e1b11990a480..2e03de17c2b8 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -250,6 +250,18 @@ static int get_prev_mirror(int cur_mirror, int num_copy)
 	     ((bvl = bio_iter_iovec((&bbio->bio), (iter))), 1);	\
 	     bit++, bio_advance_iter_single((&bbio->bio), 	\
 		     &(iter), fs_info->sectorsize))
+static int get_next_mirror(int cur_mirror, int num_copy)
+{
+	/* In the context of read-repair, we never use 0 as mirror_num. */
+	ASSERT(cur_mirror);
+	return (cur_mirror + 1 > num_copy) ? (cur_mirror + 1 - num_copy) :
+		cur_mirror + 1;
+}
+
+static bool bitmap_all_zero(unsigned long *bitmap, int nbits)
+{
+	return (find_first_bit(bitmap, nbits) == nbits);
+}
 
 static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 					struct inode *inode, int mirror)
@@ -350,9 +362,58 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 
 void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
+	struct btrfs_fs_info *fs_info;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+	unsigned long *cur_bitmap;
+	unsigned int nbits;
+	u32 sectorsize;
+	int bit = 0;
+	int i;
+
 	if (!ctrl->failed_bio)
 		return;
 
+	ASSERT(ctrl->inode);
+	fs_info = btrfs_sb(ctrl->inode->i_sb);
+	nbits = ctrl->bio_size >> fs_info->sectorsize_bits;
+	sectorsize = fs_info->sectorsize;
+	cur_bitmap = btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap;
+
+	/* The original bio has no bitmap allocated, error out. */
+	if (ctrl->error)
+		goto out;
+
+	/* Go through each remaining mirrors to do the repair */
+	for (i = get_next_mirror(ctrl->init_mirror, ctrl->num_copies);
+	     i != ctrl->init_mirror; i = get_next_mirror(i, ctrl->num_copies)) {
+		read_repair_from_one_mirror(ctrl, ctrl->inode, i);
+
+		/* Check the error bitmap to see if no more corrupted sectors */
+		if (bitmap_all_zero(cur_bitmap, nbits))
+			break;
+	}
+
+	/* Finish the unrecovered bad sectors */
+	btrfs_bio_for_each_sector(fs_info, bvec, btrfs_bio(ctrl->failed_bio),
+				  iter, bit) {
+		struct extent_io_tree *io_tree = &BTRFS_I(ctrl->inode)->io_tree;
+		const u64 file_offset = (bit << fs_info->sectorsize_bits) +
+					ctrl->file_offset;
+
+		/* Skip good sectors. */
+		if (!test_bit(bit, cur_bitmap))
+			continue;
+
+		btrfs_end_page_read(bvec.bv_page, false, file_offset,
+				    sectorsize);
+		unlock_extent_cached_atomic(io_tree, file_offset,
+				file_offset + sectorsize - 1, NULL);
+	}
+
+out:
+	ASSERT(!ctrl->cur_bio);
+	ASSERT(atomic_read(&ctrl->io_bytes) == 0);
 	kfree(btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap);
 	kfree(btrfs_bio(ctrl->failed_bio)->read_repair_prev_bitmap);
 	btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap = NULL;
-- 
2.36.0

