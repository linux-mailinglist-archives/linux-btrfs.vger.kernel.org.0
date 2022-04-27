Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13826511247
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358731AbiD0HWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358725AbiD0HWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D965FF27
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1C431F38D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiUsNQCMVhUoPB8jzlf9GTkqWQfJtNWfXWL978CXv9s=;
        b=CLPgQ0S3rwGTABVUZVoZ3VzYNrF/syAXd5ekRdjSwsG87Lnq5y7Vv05dtVs828yW51j+2V
        qCp2x9Pth9OTWiM4/vjTUOX/+ODy4s066lsiO0E4B+xl1ySKVM0O9hHnWtu04Ww3Gwsan8
        nycxXAW5JF35T1mz1AnfQuAAhMTYOV0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2371113A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oBhwNn3uaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 09/12] btrfs: switch direct IO routine to use btrfs_read_repair_ctrl
Date:   Wed, 27 Apr 2022 15:18:55 +0800
Message-Id: <b587519185b4890a23f0c7a106b9bac7501cbe1f.1651043618.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The framework of btrfs_read_repair_ctrl has already taken dio into
consideration, we just need to skip all the page status/extent state
update for DIO.

This patch will introduce a new bool member,
btrfs_read_repair_contrl::dio, to indicate if we're doing read repair
for dio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 68 +++++++++++++++++++++++++++++---------------
 fs/btrfs/extent_io.h | 11 +++++++
 fs/btrfs/inode.c     | 32 ++++++---------------
 3 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d747a2e1fe0e..515de39e70f7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2790,7 +2790,7 @@ static void read_repair_end_bio(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		/*
 		 * If we have a successful read, clear the error bit.
-		 * In read_repair_finish(), we will re-check the csum
+		 * In btrfs_read_repair_finish(), we will re-check the csum
 		 * (if exists) later.
 		 */
 		if (uptodate)
@@ -2978,14 +2978,16 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 		 */
 		read_repair_bio_add_sector(ctrl, bit, REQ_OP_WRITE);
 
-		/* Also update the page status */
-		end_page_read(page, true, file_offset, sectorsize);
-		set_extent_uptodate(&BTRFS_I(inode)->io_tree,
-				file_offset, file_offset + sectorsize - 1,
-				&cached, GFP_ATOMIC);
-		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
-				file_offset, file_offset + sectorsize - 1,
-				&cached);
+		if (!ctrl->dio) {
+			/* Also update the page status */
+			end_page_read(page, true, file_offset, sectorsize);
+			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
+					file_offset, file_offset + sectorsize - 1,
+					&cached, GFP_ATOMIC);
+			unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
+					file_offset, file_offset + sectorsize - 1,
+					&cached);
+		}
 	}
 
 	/* Submit and wait for all bios in the bios list */
@@ -2996,10 +2998,10 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 }
 
-static int read_repair_add_sector(struct inode *inode,
-				  struct btrfs_read_repair_ctrl *ctrl,
-				  struct bio *failed_bio, u32 bio_offset,
-				  u64 file_offset)
+int btrfs_read_repair_add_sector(struct inode *inode,
+				 struct btrfs_read_repair_ctrl *ctrl,
+				 struct bio *failed_bio, u32 bio_offset,
+				 u64 file_offset, bool dio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
@@ -3025,6 +3027,7 @@ static int read_repair_add_sector(struct inode *inode,
 		ctrl->file_offset = file_offset - bio_offset;
 		ctrl->error = false;
 		ctrl->inode = inode;
+		ctrl->dio = dio;
 		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
 						    sectorsize);
@@ -3054,20 +3057,29 @@ static int read_repair_add_sector(struct inode *inode,
 
 	ASSERT(ctrl->inode);
 	ASSERT(ctrl->inode == inode);
+	ASSERT(ctrl->dio == dio);
 	set_bit(bio_offset >> fs_info->sectorsize_bits, ctrl->cur_bad_bitmap);
 	return 0;
 }
 
-static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
+/*
+ * Handle all the recorded corrupted sectors.
+ *
+ * Return 0 if we repaired all corrupted sectors.
+ * Return -EIO if we can not repair all corrupted sectors, this is mostly for
+ * dio routine, as we can not just mark page error for dio.
+ */
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
 	struct btrfs_fs_info *fs_info;
 	unsigned int nbits;
 	u32 sectorsize;
+	bool has_error = false;
 	int bit;
 	int i;
 
 	if (!ctrl->initialized)
-		return;
+		return 0;
 
 	/*
 	 * Got a critical -ENOMEM error preivously, no repair should have been
@@ -3101,11 +3113,14 @@ static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 		u64 file_offset = (bit << fs_info->sectorsize_bits) +
 				  ctrl->file_offset;
 
-		page = read_repair_get_sector(ctrl, bit, &pgoff);
+		if (!ctrl->dio) {
+			page = read_repair_get_sector(ctrl, bit, &pgoff);
 
-		end_page_read(page, false, file_offset, sectorsize);
-		unlock_extent_cached_atomic(&BTRFS_I(ctrl->inode)->io_tree,
+			end_page_read(page, false, file_offset, sectorsize);
+			unlock_extent_cached_atomic(&BTRFS_I(ctrl->inode)->io_tree,
 				file_offset, file_offset + sectorsize - 1, NULL);
+		}
+		has_error = true;
 	}
 	kfree(ctrl->cur_bad_bitmap);
 	kfree(ctrl->prev_bad_bitmap);
@@ -3116,6 +3131,9 @@ static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 	ctrl->failed_bio = NULL;
 	ASSERT(bio_list_empty(&ctrl->bios));
 	ASSERT(atomic_read(&ctrl->io_bytes) == 0);
+	if (has_error)
+		return -EIO;
+	return 0;
 }
 
 static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
@@ -3165,14 +3183,14 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 			goto next;
 		}
 
-		ret = read_repair_add_sector(inode, ctrl, failed_bio,
-					     bio_offset + offset,
-					     start + offset);
+		ret = btrfs_read_repair_add_sector(inode, ctrl, failed_bio,
+						   bio_offset + offset,
+						   start + offset, false);
 		if (!ret) {
 			/*
 			 * We have recorded the corrupted sector, will submit
 			 * read bios and handle the page status update later
-			 * in read_repair_finish().
+			 * in btrfs_read_repair_finish().
 			 */
 			continue;
 		}
@@ -3534,7 +3552,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	read_repair_finish(&ctrl);
+	/*
+	 * For buffered read, we don't care about the return value, as we just
+	 * mark all the corrupted sectors errors if repair failed.
+	 */
+	btrfs_read_repair_finish(&ctrl);
 	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e056ebc7ae01..f829e6899fad 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -153,8 +153,19 @@ struct btrfs_read_repair_ctrl {
 	 */
 	bool error;
 	bool initialized;
+
+	/*
+	 * For dio case, we just skip all page status and extent status
+	 * update.
+	 */
+	bool dio;
 };
 
+int btrfs_read_repair_add_sector(struct inode *inode,
+				 struct btrfs_read_repair_ctrl *ctrl,
+				 struct bio *failed_bio, u32 bio_offset,
+				 u64 file_offset, bool dio);
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 355e559358a3..b7cd11e403ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7809,22 +7809,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	kfree(dip);
 }
 
-static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num, unsigned long bio_flags)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
-		return;
-
-	refcount_inc(&dip->refs);
-	if (btrfs_map_bio(fs_info, bio, mirror_num))
-		refcount_dec(&dip->refs);
-}
-
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
@@ -7835,10 +7819,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
+	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
+	int ret;
 
 	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
 		unsigned int i, nr_sectors, pgoff;
@@ -7858,13 +7844,10 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 						 btrfs_ino(BTRFS_I(inode)),
 						 pgoff);
 			} else {
-				int ret;
-
-				ret = btrfs_repair_one_sector(inode, &bbio->bio,
-						bio_offset, bvec.bv_page, pgoff,
-						start, bbio->mirror_num,
-						submit_dio_repair_bio);
-				if (ret)
+				ret = btrfs_read_repair_add_sector(inode, &ctrl,
+						&bbio->bio, bio_offset, start,
+						true);
+				if (ret && !err)
 					err = errno_to_blk_status(ret);
 			}
 			ASSERT(bio_offset + sectorsize > bio_offset);
@@ -7872,6 +7855,9 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			pgoff += sectorsize;
 		}
 	}
+	ret = btrfs_read_repair_finish(&ctrl);
+	if (ret && !err)
+		err = errno_to_blk_status(ret);
 	return err;
 }
 
-- 
2.36.0

