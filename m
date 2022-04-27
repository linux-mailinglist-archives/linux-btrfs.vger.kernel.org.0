Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6EE511246
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358727AbiD0HWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiD0HWh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A445F8D8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB0131F380
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxX8Gw2ig5jVN4+8xk1Yxr4Pj1aRWuLt0NHco2+i56w=;
        b=dlAzaGxISw7rJ7LH3xI5BCGBJQM9ip+oaho7I2eQewEsMPes2jgisy0KG+7vVrLTQBCqcD
        eSPAPwk9NEDv2dKlXatHyQCa6HAowDAoUDYntrwogyHMN0CgLNSW71W1xHAxDONx/egyy8
        ffaTldb+vb949FR6TnoZuMUth7RnFF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F178013A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OIkgLXzuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 08/12] btrfs: switch buffered read to the new btrfs_read_repair_* based repair routine
Date:   Wed, 27 Apr 2022 15:18:54 +0800
Message-Id: <7782502d2dc775c941f2f9e5309cbb9288034a53.1651043618.git.wqu@suse.com>
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

Instead of reply on failrec and failure_tree, we use the new
btrfs_read_repair_ctrl to do the repair.

The read time repair will have a different timing now:

- Function end_bio_extent_readpage() verifies the csum
  This is the same as usual.

- Function submit_data_read_repair() will call read_repair_add_sector()
  This function will only record the corrupted sectors.

- When all the bvec are iterated, call read_repair_finish() to do the
  repair
  Which will assemble the bios, submit them, wait for them to finish,
  and re-check the csum for all the remaining mirrors.

Now this means, end_bio_extent_readpage() will handle all the read
pair in-house, without re-entry the same endio calls.

Now switch data read path to btrfs_read_repair* based solution.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 82 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbdd8d1a966a..d747a2e1fe0e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2732,11 +2732,22 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
+static int get_next_mirror(int cur_mirror, int num_copy)
+{
+	return (cur_mirror + 1 > num_copy) ? (cur_mirror + 1 - num_copy) :
+		cur_mirror + 1;
+}
+
 static int get_prev_mirror(int cur_mirror, int num_copy)
 {
 	return (cur_mirror - 1 <= 0) ? (num_copy) : cur_mirror - 1;
 }
 
+static bool bitmap_all_zero(unsigned long *bitmap, int nbits)
+{
+	return (find_first_bit(bitmap, nbits) == nbits);
+}
+
 static struct page *read_repair_get_sector(struct btrfs_read_repair_ctrl *ctrl,
 					   int sector_nr, unsigned int *pgoff)
 {
@@ -2987,7 +2998,8 @@ static void read_repair_from_one_mirror(struct btrfs_read_repair_ctrl *ctrl,
 
 static int read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
-				  struct bio *failed_bio, u32 bio_offset)
+				  struct bio *failed_bio, u32 bio_offset,
+				  u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
@@ -3010,6 +3022,7 @@ static int read_repair_add_sector(struct inode *inode,
 		ctrl->bio_size = btrfs_bio(failed_bio)->iter.bi_size;
 		ASSERT(ctrl->bio_size);
 		ASSERT(IS_ALIGNED(ctrl->bio_size, fs_info->sectorsize));
+		ctrl->file_offset = file_offset - bio_offset;
 		ctrl->error = false;
 		ctrl->inode = inode;
 		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
@@ -3047,9 +3060,53 @@ static int read_repair_add_sector(struct inode *inode,
 
 static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
+	struct btrfs_fs_info *fs_info;
+	unsigned int nbits;
+	u32 sectorsize;
+	int bit;
+	int i;
+
 	if (!ctrl->initialized)
 		return;
 
+	/*
+	 * Got a critical -ENOMEM error preivously, no repair should have been
+	 * attempted.
+	 */
+	if (ctrl->error) {
+		ASSERT(bio_list_empty(&ctrl->bios));
+		ASSERT(atomic_read(&ctrl->io_bytes) == 0);
+		goto mark_error;
+	}
+
+	ASSERT(ctrl->inode);
+	fs_info = btrfs_sb(ctrl->inode->i_sb);
+	nbits = ctrl->bio_size >> fs_info->sectorsize_bits;
+	sectorsize = fs_info->sectorsize;
+
+	/* Go through each remaining mirrors to do the repair */
+	for (i = get_next_mirror(ctrl->init_mirror, ctrl->num_copies);
+	     i != ctrl->init_mirror; i = get_next_mirror(i, ctrl->num_copies)) {
+		read_repair_from_one_mirror(ctrl, ctrl->inode, i);
+
+		/* Check the error bitmap to see if no more corrupted sectors */
+		if (bitmap_all_zero(ctrl->cur_bad_bitmap, nbits))
+			break;
+	}
+mark_error:
+	/* Finish the unrecovered bad sectors */
+	for_each_set_bit(bit, ctrl->cur_bad_bitmap, nbits) {
+		struct page *page;
+		unsigned int pgoff;
+		u64 file_offset = (bit << fs_info->sectorsize_bits) +
+				  ctrl->file_offset;
+
+		page = read_repair_get_sector(ctrl, bit, &pgoff);
+
+		end_page_read(page, false, file_offset, sectorsize);
+		unlock_extent_cached_atomic(&BTRFS_I(ctrl->inode)->io_tree,
+				file_offset, file_offset + sectorsize - 1, NULL);
+	}
 	kfree(ctrl->cur_bad_bitmap);
 	kfree(ctrl->prev_bad_bitmap);
 	ctrl->cur_bad_bitmap = NULL;
@@ -3057,6 +3114,8 @@ static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 	ctrl->initialized = false;
 	ctrl->error = false;
 	ctrl->failed_bio = NULL;
+	ASSERT(bio_list_empty(&ctrl->bios));
+	ASSERT(atomic_read(&ctrl->io_bytes) == 0);
 }
 
 static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
@@ -3067,7 +3126,6 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 					    int failed_mirror,
 					    unsigned int error_bitmap)
 {
-	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page *page = bvec->bv_page;
 	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
@@ -3107,22 +3165,14 @@ static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
 			goto next;
 		}
 
-		/*
-		 * We currently only set the bitmap, no real repair, thus can
-		 * ignore the error for now.
-		 */
-		read_repair_add_sector(inode, ctrl, failed_bio,
-				       bio_offset + offset);
-		ret = btrfs_repair_one_sector(inode, failed_bio,
-				bio_offset + offset,
-				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
+		ret = read_repair_add_sector(inode, ctrl, failed_bio,
+					     bio_offset + offset,
+					     start + offset);
 		if (!ret) {
 			/*
-			 * We have submitted the read repair, the page release
-			 * will be handled by the endio function of the
-			 * submitted repair bio.
-			 * Thus we don't need to do any thing here.
+			 * We have recorded the corrupted sector, will submit
+			 * read bios and handle the page status update later
+			 * in read_repair_finish().
 			 */
 			continue;
 		}
-- 
2.36.0

