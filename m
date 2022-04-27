Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD9511242
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358715AbiD0HWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357783AbiD0HWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570215E743
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E795210E1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sh8FfbYi+a6qBsyRlzi8CYom7sAbRwqbo7182kUDxuQ=;
        b=RpUaBxBxJNnezZKmYQtQY8szsBjxbgqGc7wn2yZGkRku91MkM8Lzr7U7YpKB0+zF5i828B
        2CryWZDhreKzjRDwqaYmmHIqZmpVDf2nCcfpi5zVVrLbTuvlwD4g4tvHYb/tUm/AaoDPEG
        iyARPAC3J/j5E3oU//LOAMgSgeW6ep0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53E4813A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPOyBnjuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record corrupted sectors
Date:   Wed, 27 Apr 2022 15:18:50 +0800
Message-Id: <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
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

This patch will introduce a new infrastructure, btrfs_read_repair_ctrl,
to record exactly which sectors are corrupted at read time, and hold
other misc members for read time repair.

The new structure is going to be an on-stack structure for
end_bio_extent_readpage().

It would increase the stack memory usage (would be around 100 bytes),
but considering end_bio_extent_readpage() is the highest level endio
function and it's executed in a workqueue, the extra stack memory usage
should be OK.

Currently we only allocate two bitmaps and initialize various members,
no real work done yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 86 ++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_io.h | 46 ++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f273ef966bd..6304f694c8d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2732,7 +2732,79 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_data_read_repair(struct inode *inode,
+static int read_repair_add_sector(struct inode *inode,
+				  struct btrfs_read_repair_ctrl *ctrl,
+				  struct bio *failed_bio, u32 bio_offset)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	if (!ctrl->initialized) {
+		const u32 sectorsize = fs_info->sectorsize;
+
+		ASSERT(ctrl->cur_bad_bitmap == NULL &&
+		       ctrl->prev_bad_bitmap == NULL);
+		/*
+		 * failed_bio->bi_iter is not reliable at endio time, thus we
+		 * must rely on btrfs_bio::iter to grab the original logical
+		 * bytenr.
+		 */
+		ASSERT(btrfs_bio(failed_bio)->iter.bi_size);
+
+		ctrl->initialized = true;
+		ctrl->failed_bio = failed_bio;
+		ctrl->logical = btrfs_bio(failed_bio)->iter.bi_sector <<
+				SECTOR_SHIFT;
+		ctrl->bio_size = btrfs_bio(failed_bio)->iter.bi_size;
+		ASSERT(ctrl->bio_size);
+		ASSERT(IS_ALIGNED(ctrl->bio_size, fs_info->sectorsize));
+		ctrl->error = false;
+		ctrl->inode = inode;
+		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
+		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
+						    sectorsize);
+
+		ctrl->cur_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
+					fs_info->sectorsize_bits, GFP_NOFS);
+		ctrl->prev_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
+					fs_info->sectorsize_bits, GFP_NOFS);
+		/* Just set the error bit, so we will never try repair */
+		if (!ctrl->cur_bad_bitmap || !ctrl->prev_bad_bitmap) {
+			kfree(ctrl->cur_bad_bitmap);
+			kfree(ctrl->prev_bad_bitmap);
+			ctrl->cur_bad_bitmap = NULL;
+			ctrl->prev_bad_bitmap = NULL;
+			ctrl->error = true;
+		}
+	}
+	/*
+	 * We failed to allocate memory for bitmaps, some range has already been
+	 * marked error, no need to try repair anymore.
+	 */
+	if (ctrl->error)
+		return -ENOMEM;
+
+	ASSERT(ctrl->inode);
+	ASSERT(ctrl->inode == inode);
+	set_bit(bio_offset >> fs_info->sectorsize_bits, ctrl->cur_bad_bitmap);
+	return 0;
+}
+
+static void read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
+{
+	if (!ctrl->initialized)
+		return;
+
+	kfree(ctrl->cur_bad_bitmap);
+	kfree(ctrl->prev_bad_bitmap);
+	ctrl->cur_bad_bitmap = NULL;
+	ctrl->prev_bad_bitmap = NULL;
+	ctrl->initialized = false;
+	ctrl->error = false;
+	ctrl->failed_bio = NULL;
+}
+
+static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
+					    struct inode *inode,
 					    struct bio *failed_bio,
 					    u32 bio_offset,
 					    const struct bio_vec *bvec,
@@ -2779,6 +2851,12 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 			goto next;
 		}
 
+		/*
+		 * We currently only set the bitmap, no real repair, thus can
+		 * ignore the error for now.
+		 */
+		read_repair_add_sector(inode, ctrl, failed_bio,
+				       bio_offset + offset);
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
@@ -3015,6 +3093,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
  */
 static void end_bio_extent_readpage(struct bio *bio)
 {
+	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
@@ -3103,8 +3182,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
+			submit_data_read_repair(&ctrl, inode, bio, bio_offset,
+						bvec, mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
@@ -3149,6 +3228,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
+	read_repair_finish(&ctrl);
 	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b390ec79f9a8..eff008ba194f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/fiemap.h>
 #include <linux/btrfs_tree.h>
+#include <linux/bitmap.h>
 #include "ulist.h"
 
 /*
@@ -102,6 +103,51 @@ struct extent_buffer {
 #endif
 };
 
+/* Strucutre for data read time repair. */
+struct btrfs_read_repair_ctrl {
+	struct inode *inode;
+
+	/* The initial failed bio, we will grab page/pgoff from it */
+	struct bio *failed_bio;
+
+	/* Currently bad bitmap. */
+	unsigned long *cur_bad_bitmap;
+
+	/*
+	 * Bad bitmap for previous mirror, the diff between
+	 * @cur_bad_bitmap and @prev_bad_bitmap shows the
+	 * repaired range, that will be used to writeback
+	 * the repaired data to corrupted mirror.
+	 */
+	unsigned long *prev_bad_bitmap;
+
+	/* The logical bytenr of the original bio. */
+	u64 logical;
+
+	/* File offset of the original bio. */
+	u64 file_offset;
+
+	/* The original bio size for the whole read. */
+	u32 bio_size;
+
+	/* Current mirror number we're reading from. */
+	u8 cur_mirror;
+
+	/* Initial mirror number we hit the first error. */
+	u8 init_mirror;
+
+	/* How many copies we have. */
+	u8 num_copies;
+
+	/*
+	 * If we hit fatal error during repair, if so we will not try any
+	 * repair but directly mark all existing and future bad range as
+	 * error.
+	 */
+	bool error;
+	bool initialized;
+};
+
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
-- 
2.36.0

