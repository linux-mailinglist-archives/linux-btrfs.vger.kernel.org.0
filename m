Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7C517D9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiECGyV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiECGx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8115832
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362C61F74B
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWlIXO23WYm8T1KNNGKX01v+//1m4tGiPNyFK1/EAMk=;
        b=oa0hI3Kl2tCoaNXNdmIwQ3zJLRp9v6jBSyEl+B3SlS6Wh5k7FENgFXkPgNmwADIDJynEJq
        IBH+Q5UsUjrH4sAhBnKlaousfAByL70lBupNcf/NVKnFXrd4zcY9Xv7JMQ63JCMO0BqwU9
        hnGct6Bzh5GfeiKU90WYFheVSCrxeWg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A9E13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKruG7HQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/13] btrfs: switch direct IO routine to use btrfs_read_repair_ctrl
Date:   Tue,  3 May 2022 14:49:55 +0800
Message-Id: <428aa157c4ecf406e0dc1ca43ed8d48b93169e97.1651559986.git.wqu@suse.com>
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

The framework of btrfs_read_repair_ctrl has already taken dio into
consideration, we just need to skip all the page status/extent state
update for DIO.

This patch will introduce a new bool member,
btrfs_read_repair_contrl::is_dio, to indicate if we're doing read repair
for dio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       | 38 ++++++++++++++-----------------------
 fs/btrfs/read-repair.c | 43 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/read-repair.h |  6 ++++--
 4 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9077f0b06b92..0c04ac711c8d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2802,7 +2802,7 @@ static void submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 		 */
 		btrfs_read_repair_add_sector(inode, ctrl, failed_bio,
 					     bio_offset + offset,
-					     failed_offset);
+					     failed_offset, false);
 	}
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24f6f30ea77f..dc3de3d705e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7817,26 +7817,11 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
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
 {
+	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
@@ -7866,20 +7851,16 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
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
-					err = errno_to_blk_status(ret);
+				btrfs_read_repair_add_sector(inode, &ctrl,
+						&bbio->bio, bio_offset, start,
+						true);
 			}
 			ASSERT(bio_offset + sectorsize > bio_offset);
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
 		}
 	}
+	err = errno_to_blk_status(btrfs_read_repair_finish(&ctrl));
 	return err;
 }
 
@@ -8081,6 +8062,15 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_bio(bio)->file_offset = file_offset;
+		if (bio_op(bio) == REQ_OP_READ) {
+			ret = btrfs_read_repair_alloc_bitmaps(fs_info,
+							      btrfs_bio(bio));
+			if (ret) {
+				status = errno_to_blk_status(ret);
+				bio_put(bio);
+				goto out_err;
+			}
+		}
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index 2e03de17c2b8..2e18dfc69bc0 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -32,7 +32,7 @@ int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
 void btrfs_read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
 				  struct bio *failed_bio, u32 bio_offset,
-				  u64 file_offset)
+				  u64 file_offset, bool is_dio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
@@ -51,6 +51,7 @@ void btrfs_read_repair_add_sector(struct inode *inode,
 		ASSERT(IS_ALIGNED(ctrl->bio_size, fs_info->sectorsize));
 		ctrl->inode = inode;
 		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
+		ctrl->is_dio = is_dio;
 		/* At endio time, btrfs_bio::mirror should never be 0. */
 		ASSERT(ctrl->init_mirror);
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
@@ -73,6 +74,7 @@ void btrfs_read_repair_add_sector(struct inode *inode,
 
 	ASSERT(ctrl->inode);
 	ASSERT(ctrl->inode == inode);
+	ASSERT(ctrl->is_dio == is_dio);
 	/*
 	 * The leading half of the bitmap is for current corrupted bits.
 	 * Thus we can just set the bit without any extra offset.
@@ -343,14 +345,19 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 							     ctrl->num_copies),
 					REQ_OP_WRITE);
 
-		/* Update the page status and extent locks. */
-		btrfs_end_page_read(bvec.bv_page, true, file_offset, sectorsize);
-		set_extent_uptodate(&binode->io_tree,
-				file_offset, file_offset + sectorsize - 1,
-				&cached, GFP_ATOMIC);
-		unlock_extent_cached_atomic(&binode->io_tree,
-				file_offset, file_offset + sectorsize - 1,
-				&cached);
+		if (!ctrl->is_dio) {
+			/* Update the page status and extent locks. */
+			btrfs_end_page_read(bvec.bv_page, true, file_offset,
+					    sectorsize);
+			set_extent_uptodate(&binode->io_tree,
+					file_offset,
+					file_offset + sectorsize - 1,
+					&cached, GFP_ATOMIC);
+			unlock_extent_cached_atomic(&binode->io_tree,
+					file_offset,
+					file_offset + sectorsize - 1,
+					&cached);
+		}
 	}
 	/* Submit the last write bio from above loop and wait for them. */
 	if (ctrl->cur_bio)
@@ -360,19 +367,20 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 	wait_event(ctrl->io_wait, atomic_read(&ctrl->io_bytes) == 0);
 }
 
-void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
 	struct btrfs_fs_info *fs_info;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	unsigned long *cur_bitmap;
 	unsigned int nbits;
+	bool has_error = true;
 	u32 sectorsize;
 	int bit = 0;
 	int i;
 
 	if (!ctrl->failed_bio)
-		return;
+		return 0;
 
 	ASSERT(ctrl->inode);
 	fs_info = btrfs_sb(ctrl->inode->i_sb);
@@ -394,6 +402,10 @@ void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 			break;
 	}
 
+	/* Direct IO should not touch page status nor extent lock, exit now. */
+	if (ctrl->is_dio)
+		goto out;
+
 	/* Finish the unrecovered bad sectors */
 	btrfs_bio_for_each_sector(fs_info, bvec, btrfs_bio(ctrl->failed_bio),
 				  iter, bit) {
@@ -412,6 +424,8 @@ void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 	}
 
 out:
+	if (cur_bitmap)
+		has_error = !bitmap_all_zero(cur_bitmap, nbits);
 	ASSERT(!ctrl->cur_bio);
 	ASSERT(atomic_read(&ctrl->io_bytes) == 0);
 	kfree(btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap);
@@ -420,6 +434,13 @@ void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 	btrfs_bio(ctrl->failed_bio)->read_repair_prev_bitmap = NULL;
 	ctrl->error = false;
 	ctrl->failed_bio = NULL;
+	/*
+	 * The return value is only for Direct IO to indicate if we have
+	 * corrupted sector unrepaired.
+	 */
+	if (has_error)
+		return -EIO;
+	return 0;
 }
 
 void __cold btrfs_read_repair_exit(void)
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
index 6cc816e2ce4a..fd0117295bc5 100644
--- a/fs/btrfs/read-repair.h
+++ b/fs/btrfs/read-repair.h
@@ -44,6 +44,8 @@ struct btrfs_read_repair_ctrl {
 	bool error;
 
 	bool is_raid56;
+
+	bool is_dio;
 };
 
 int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
@@ -75,8 +77,8 @@ struct btrfs_read_repair_bio {
 void btrfs_read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
 				  struct bio *failed_bio, u32 bio_offset,
-				  u64 file_offset);
-void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
+				  u64 file_offset, bool is_dio);
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
 int __init btrfs_read_repair_init(void);
 void __cold btrfs_read_repair_exit(void);
 #endif
-- 
2.36.0

