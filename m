Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E9517DA3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiECGzi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiECGxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC21659F
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBC71210ED
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+didSZXvx5igu9zs4TZWRzeOEjxIHmQg74/Y03/DS60=;
        b=P/VCgHRvMMKHJcrjTuXrtJMJ89KG9R1Z8bWTHFZaYfR33j/b07zk3x8ycmtDIkLypTRgGS
        LJmSzpoDU7emQQ4jzy5t1Adgy5gXgPTeKVAY+b0plcHB0l8WZL6KRBP38OfxaKQqkLWBsW
        eZ1D9SkUIef5eCc2n7LEIzCFhtZdlyY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 327D613AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Ot6AazQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record corrupted sectors
Date:   Tue,  3 May 2022 14:49:49 +0800
Message-Id: <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
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

This patch will introduce a new infrastructure, btrfs_read_repair_ctrl,
to record exactly which sectors are corrupted at read time, and hold
other misc members for read time repair.

The new structure is going to be an on-stack structure for
end_bio_extent_readpage().

This new infrastructure will need the following new memory:

- For btrfs_read_repair_ctrl structure itself
  We use on-stack memory of end_bio_extent_readpage().
  Currently end_bio_extent_readpage() is the highest level endio
  function, thus there will be no more endio called.
  The extra ~100 bytes should be safe enough.

- For the extra bitmaps
  We use btrfs_bio::read_repair_{cur|prev}_bitmap.
  This will add extra 16 bytes to btrfs_bio.

  This is unavoidable, or we need to allocate extra memory at endio
  function which can be dead lock prone.

  Furthermore, pre-allocating bitmap has a hidden benefit, if we're
  submitting a large read and failed to allocated enough memory for
  bitmap, we fail the bio, and VFS layer will automatically retry
  with smaller read range, giving us a higher chance to succeed in
  next try.

Currently we only allocate the bitmaps and initialize various members,
no real work done yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/extent_io.c   | 20 ++++++++--
 fs/btrfs/inode.c       | 13 +++++++
 fs/btrfs/read-repair.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h | 47 ++++++++++++++++++++++
 fs/btrfs/volumes.h     |  4 ++
 6 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..0b2605c750ca 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o read-repair.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 240277cdccd2..0a7dfb638e0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -29,6 +29,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "read-repair.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -2738,7 +2739,8 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static blk_status_t submit_data_read_repair(struct inode *inode,
+static blk_status_t submit_data_read_repair(struct btrfs_read_repair_ctrl *ctrl,
+					    struct inode *inode,
 					    struct bio *failed_bio,
 					    u32 bio_offset,
 					    const struct bio_vec *bvec,
@@ -2752,6 +2754,9 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
+	/* The failed offset should be the file offset of the failed bio. */
+	const u64 failed_offset = page_offset(bio_first_page_all(failed_bio)) +
+				  bio_first_bvec_all(failed_bio)->bv_offset;
 	int error = 0;
 	int i;
 
@@ -2785,6 +2790,13 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 			goto next;
 		}
 
+		/*
+		 * Currently we only update the bitmap and do nothing in
+		 * btrfs_read_repair_finish(), thus it can co-exist with the
+		 * old code.
+		 */
+		btrfs_read_repair_add_sector(inode, ctrl, failed_bio,
+					     bio_offset + offset, failed_offset);
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
@@ -3021,6 +3033,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
  */
 static void end_bio_extent_readpage(struct bio *bio)
 {
+	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
@@ -3109,8 +3122,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
+			submit_data_read_repair(&ctrl, inode, bio, bio_offset,
+						bvec, mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
@@ -3155,6 +3168,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
+	btrfs_read_repair_finish(&ctrl);
 	btrfs_bio_free_csum(bbio);
 	bio_put(bio);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f4dfb79fafce..24f6f30ea77f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "read-repair.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2586,6 +2587,18 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
+	if (bio_op(bio) == REQ_OP_READ) {
+		int tmp;
+
+		/* Allocate the extra bitmap for read time repair. */
+		tmp = btrfs_read_repair_alloc_bitmaps(fs_info, btrfs_bio(bio));
+		if (tmp) {
+			ret = errno_to_blk_status(tmp);
+			goto out;
+		}
+	}
+
+
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		struct page *page = bio_first_bvec_all(bio)->bv_page;
 		loff_t file_offset = page_offset(page);
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
new file mode 100644
index 000000000000..048bb7c16c56
--- /dev/null
+++ b/fs/btrfs/read-repair.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bio.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "read-repair.h"
+
+int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
+				    struct btrfs_bio *bbio)
+{
+	const u32 nbits = bbio->bio.bi_iter.bi_size >> fs_info->sectorsize_bits;
+
+	ASSERT(nbits);
+	ASSERT(!bbio->read_repair_cur_bitmap &&
+	       !bbio->read_repair_prev_bitmap);
+	bbio->read_repair_cur_bitmap = bitmap_alloc(nbits, GFP_NOFS);
+	bbio->read_repair_prev_bitmap = bitmap_alloc(nbits, GFP_NOFS);
+	if (!bbio->read_repair_cur_bitmap ||
+	    !bbio->read_repair_prev_bitmap) {
+		kfree(bbio->read_repair_cur_bitmap);
+		kfree(bbio->read_repair_prev_bitmap);
+		bbio->read_repair_cur_bitmap = NULL;
+		bbio->read_repair_prev_bitmap = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void btrfs_read_repair_add_sector(struct inode *inode,
+				  struct btrfs_read_repair_ctrl *ctrl,
+				  struct bio *failed_bio, u32 bio_offset,
+				  u64 file_offset)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	/* Not yet initialized. */
+	if (!ctrl->failed_bio) {
+		const u32 sectorsize = fs_info->sectorsize;
+
+		/* We should have a valid logical bytenr. */
+		ASSERT(btrfs_bio(failed_bio)->iter.bi_sector);
+		ctrl->failed_bio = failed_bio;
+		ctrl->logical = btrfs_bio(failed_bio)->iter.bi_sector <<
+				SECTOR_SHIFT;
+		ctrl->file_offset = file_offset;
+		ctrl->bio_size = btrfs_bio(failed_bio)->iter.bi_size;
+		ASSERT(ctrl->bio_size);
+		ASSERT(IS_ALIGNED(ctrl->bio_size, fs_info->sectorsize));
+		ctrl->inode = inode;
+		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
+		/* At endio time, btrfs_bio::mirror should never be 0. */
+		ASSERT(ctrl->init_mirror);
+		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
+						    sectorsize);
+		/*
+		 * We use btrfs_bio::read_repair_bitmaps, which should be
+		 * preallocated before submission.
+		 * If not, we hit -ENOMEM and no need to do any repair.
+		 */
+		if (!btrfs_bio(failed_bio)->read_repair_cur_bitmap ||
+		    !btrfs_bio(failed_bio)->read_repair_prev_bitmap)
+			ctrl->error = true;
+	}
+	if (ctrl->error)
+		return;
+
+	ASSERT(ctrl->inode);
+	ASSERT(ctrl->inode == inode);
+	/*
+	 * The leading half of the bitmap is for current corrupted bits.
+	 * Thus we can just set the bit without any extra offset.
+	 */
+	set_bit(bio_offset >> fs_info->sectorsize_bits,
+		btrfs_bio(failed_bio)->read_repair_cur_bitmap);
+}
+
+void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
+{
+	if (!ctrl->failed_bio)
+		return;
+
+	kfree(btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap);
+	kfree(btrfs_bio(ctrl->failed_bio)->read_repair_prev_bitmap);
+	btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap = NULL;
+	btrfs_bio(ctrl->failed_bio)->read_repair_prev_bitmap = NULL;
+	ctrl->error = false;
+	ctrl->failed_bio = NULL;
+}
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
new file mode 100644
index 000000000000..42a251f1300b
--- /dev/null
+++ b/fs/btrfs/read-repair.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_READ_REPAIR_H
+#define BTRFS_READ_REPAIR_H
+
+#include <linux/blk_types.h>
+#include <linux/fs.h>
+#include <linux/bitmap.h>
+
+/* Strucutre for data read time repair. */
+struct btrfs_read_repair_ctrl {
+	struct inode *inode;
+
+	/* The initial failed bio, we will grab page/pgoff from it */
+	struct bio *failed_bio;
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
+	/* Initial mirror number we hit the first error. */
+	u8 init_mirror;
+
+	/* How many copies we have. */
+	u8 num_copies;
+
+	/*
+	 * This is for bitmap allocation failure.
+	 * This means the btrfs_bio::read_repair_*_bitmap allocation failed
+	 * at bio allocation time.
+	 */
+	bool error;
+};
+
+int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
+				    struct btrfs_bio *bbio);
+void btrfs_read_repair_add_sector(struct inode *inode,
+				  struct btrfs_read_repair_ctrl *ctrl,
+				  struct bio *failed_bio, u32 bio_offset,
+				  u64 file_offset);
+void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
+#endif
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 197877e684df..420a4b8eefd0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -337,6 +337,10 @@ struct btrfs_bio {
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
 	struct bvec_iter iter;
 
+	/* Bitmaps used for read time repair. */
+	unsigned long *read_repair_cur_bitmap;
+	unsigned long *read_repair_prev_bitmap;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
-- 
2.36.0

