Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD73533B20
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiEYK7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEYK7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BD60DAA
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 386EA1F939
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPgGQaBx42+FFSytUF+AYTxNU8PghcfTRiSn/ex/szw=;
        b=Onb5m7PBfap7LwmKNG8YnTbTTXJu5LKSyK22fGo39ivrSyvepf6NKyDkJ52mRvBUyzP7iX
        rBlw+JLDbPFRGzRLAWAFoDqAgT3eJRTYhrNLqX0vFRcMMNfivTUlvlZVSE9rNrzIToMzJA
        gHgNTr9c2E7fjE2cRH5Ms/Maz8AceHE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87EB313ADF
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GFJKFB4MjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 10:59:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Date:   Wed, 25 May 2022 18:59:14 +0800
Message-Id: <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653476251.git.wqu@suse.com>
References: <cover.1653476251.git.wqu@suse.com>
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

The new read repair infrastructure is consist of the following 3 parts:

- btrfs_read_repair_ctrl
  Record a continous corrupted range.
  Will mostly be on-stack structure for the top-level endio function.

- btrfs_read_repair_add_sector()
  This function is called each time we hit a bad sector.

  This function itself will check if the bad sector can be merged with
  the existing bad range.

  If not, call btrfs_read_repair_finish() to finish the current range
  first, and then add the new sector into the now empty
  btrfs_read_repair_ctrl.

  Will return -EIO if there is any range failed to be repaired.

- btrfs_read_repair_finish()
  This function should be called before the endio function exit.

  This function will iterate through all the mirrors, trying to grab
  the correct data.

  If we grabbed a correct sector, we will queue it for later writeback
  into the bad mirror.

To hold the original bad sectors, we have two bios, one named
@bad_sectors. Although it's a bio, we only utilize the bio_vec
infrastructure to hold all the initial bad sectors.

It's the @io_bio we really utilize to submit new read and write.

For io_bio, the usage is pretty much the same as
btrfs_read_repair_add_sector().

If we can merge the target sector, then that's the best case.
If not, then we submit the current @io_bio, wait for it, and allocate a
new bio for the next usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/extent_io.c   |   2 +-
 fs/btrfs/extent_io.h   |   1 +
 fs/btrfs/read-repair.c | 328 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h |  48 ++++++
 5 files changed, 379 insertions(+), 2 deletions(-)
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
index 1083d6cfa858..160dedb078fd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2735,7 +2735,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static void end_sector_io(struct page *page, u64 offset, bool uptodate)
+void end_sector_io(struct page *page, u64 offset, bool uptodate)
 {
 	struct inode *inode = page->mapping->host;
 	u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6cdcea1551a6..e3f9db50983d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -250,6 +250,7 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
+void end_sector_io(struct page *page, u64 offset, bool uptodate);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
new file mode 100644
index 000000000000..26f59439fc5c
--- /dev/null
+++ b/fs/btrfs/read-repair.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bio.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "read-repair.h"
+#include "btrfs_inode.h"
+
+static int get_next_mirror(int mirror, int num_copies)
+{
+	if (mirror + 1 > num_copies)
+		return mirror + 1 - num_copies;
+	return mirror + 1;
+}
+
+static int get_prev_mirror(int mirror, int num_copies)
+{
+	if (mirror - 1 == 0)
+		return num_copies;
+	return mirror - 1;
+}
+static void init_new_ctrl(struct inode *inode,
+			  struct btrfs_read_repair_ctrl *ctrl,
+			  u64 logical, u64 file_offset, u8 *csum,
+			  int failed_mirror, bool is_dio)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	ASSERT(!ctrl->inode);
+	ASSERT(!ctrl->logical);
+	ASSERT(!ctrl->bad_sectors);
+	ASSERT(!ctrl->io_bio);
+	ASSERT(!ctrl->len);
+
+	ctrl->inode = inode;
+	ctrl->logical = logical;
+	ctrl->num_copies = btrfs_num_copies(fs_info, logical,
+					    fs_info->sectorsize);
+	ctrl->is_raid56 = btrfs_is_parity_mirror(fs_info, logical,
+						 fs_info->sectorsize);
+	ctrl->is_dio = is_dio;
+	ctrl->file_offset = file_offset;
+	ctrl->failed_mirror = failed_mirror;
+	ctrl->csum = csum;
+	ctrl->bad_sectors = bio_alloc(NULL, BITS_PER_LONG, REQ_OP_READ, GFP_NOFS);
+	ctrl->bad_sectors->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+
+	ctrl->io_bio = btrfs_bio_alloc(BITS_PER_LONG);
+}
+
+int btrfs_read_repair_add_sector(struct inode *inode,
+				 struct btrfs_read_repair_ctrl *ctrl,
+				 struct page *page, unsigned int pgoff,
+				 u64 logical, u64 file_offset, u8 *csum,
+				 int failed_mirror, bool is_dio)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const u32 size_limit = BITS_PER_LONG << fs_info->sectorsize_bits;
+	int ret = 0;
+
+	/* Mirror number should not be 0. */
+	ASSERT(failed_mirror);
+
+	/* Not initialized, initialize an empty one. */
+	if (!ctrl->inode) {
+		const int num_copies = btrfs_num_copies(fs_info, logical,
+							fs_info->sectorsize);
+
+		/* No more copies, can not repair. */
+		if (num_copies <= 1) {
+			if (!is_dio)
+				end_sector_io(page, file_offset, false);
+			return -EIO;
+		}
+
+		init_new_ctrl(inode, ctrl, logical, file_offset, csum,
+			      failed_mirror, is_dio);
+	}
+
+	/* Not continuous with the exiting range, finish the current one. */
+	if (ctrl->logical + ctrl->len != logical ||
+	    ctrl->failed_mirror != failed_mirror) {
+		ret = btrfs_read_repair_finish(ctrl);
+		init_new_ctrl(inode, ctrl, logical, file_offset, csum,
+			      failed_mirror, is_dio);
+	}
+
+	/* Continuous, just add the page into the current bio. */
+	ASSERT(ctrl->bad_sectors);
+	ASSERT(ctrl->len < size_limit);
+	bio_add_page(ctrl->bad_sectors, page, fs_info->sectorsize, pgoff);
+
+	ctrl->len += fs_info->sectorsize;
+	set_bit((logical - ctrl->logical) >> fs_info->sectorsize_bits,
+		&ctrl->bad_bitmap);
+	if (ctrl->len >= size_limit)
+		ret = btrfs_read_repair_finish(ctrl);
+	return ret;
+}
+
+/*
+ * Iterate through a bio on a per-sector basis.
+ */
+#define bio_for_each_sector(fs_info, bvl, bio, iter, bio_offset)	\
+	for ((iter) = bio->bi_iter, (bio_offset) = 0;			\
+	     (iter).bi_size &&						\
+	     (((bvl) = bio_iter_iovec((bio), (iter))), 1);		\
+	     (bio_offset) += fs_info->sectorsize,			\
+	     bio_advance_iter_single(bio, &(iter),			\
+	     (fs_info)->sectorsize))
+
+static void io_bio_submit(struct btrfs_read_repair_ctrl *ctrl, int mirror,
+			  int opf)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bio *io_bio = ctrl->io_bio;
+	u64 io_logical;
+	u32 io_size;
+	int ret;
+
+	ASSERT(io_bio);
+	io_logical = io_bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	io_size = io_bio->bi_iter.bi_size;
+	/* Not yet utilized, just keep it for later usage. */
+	if (io_size == 0) {
+		io_bio->bi_iter.bi_sector = 0;
+		return;
+	}
+
+	io_bio->bi_opf = opf;
+	ret = btrfs_map_bio_wait(fs_info, ctrl->io_bio, mirror);
+	/* Read succeeded, clear the bad bits. */
+	if ((opf & REQ_OP_MASK) == REQ_OP_READ && !ret)
+		bitmap_clear(&ctrl->bad_bitmap,
+			(io_logical - ctrl->logical) >> fs_info->sectorsize_bits,
+			io_size >> fs_info->sectorsize_bits);
+	ctrl->io_bio = btrfs_bio_alloc(BITS_PER_LONG);
+	/* Leave bi_sector uninitialized. */
+	ctrl->io_bio->bi_iter.bi_sector = 0;
+}
+
+static void io_add_or_submit(struct btrfs_read_repair_ctrl *ctrl, int mirror,
+			   u64 logical, struct page *page, unsigned int pgoff,
+			   int opf)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bio *io_bio = ctrl->io_bio;
+
+	/* Uninitialized. */
+	if (io_bio->bi_iter.bi_sector == 0) {
+		ASSERT(io_bio->bi_iter.bi_size == 0);
+		io_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+		io_bio->bi_opf = opf;
+		bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
+		return;
+	}
+
+	/* Continuous, add the page */
+	if ((io_bio->bi_iter.bi_sector << SECTOR_SHIFT) +
+	     io_bio->bi_iter.bi_size == logical) {
+		bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
+		return;
+	}
+
+	/* Not continuous, submit first. */
+	io_bio_submit(ctrl, mirror, opf);
+	io_bio = ctrl->io_bio;
+	io_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+	bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
+}
+
+static void writeback_good_mirror(struct btrfs_read_repair_ctrl *ctrl,
+				  int mirror, u64 logical,
+				  struct page *page, unsigned int pgoff)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bio *io_bio = ctrl->io_bio;
+
+
+	if (btrfs_repair_one_zone(fs_info, ctrl->logical))
+		return;
+
+	/*
+	 * For RAID56, we can not just write the bad data back, as
+	 * any write will trigger RMW and read back the corrrupted
+	 * on-disk stripe, causing further damage.
+	 * So here we do special repair for raid56.
+	 *
+	 * And unfortunately, this repair is very low level and not
+	 * compatible with the rest of the mirror based repair.
+	 * So it's still done in synchronous mode using
+	 * btrfs_repair_io_failure().
+	 */
+	if (ctrl->is_raid56) {
+		const u64 file_offset = logical - ctrl->logical +
+					ctrl->file_offset;
+		btrfs_repair_io_failure(fs_info,
+				btrfs_ino(BTRFS_I(ctrl->inode)), file_offset,
+				fs_info->sectorsize, logical, page, pgoff,
+				mirror);
+		return;
+	}
+
+	ASSERT(io_bio);
+	io_add_or_submit(ctrl, mirror, logical, page, pgoff, REQ_OP_WRITE);
+}
+
+static void repair_from_mirror(struct btrfs_read_repair_ctrl *ctrl, int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	unsigned long old_bitmap = ctrl->bad_bitmap;
+	const int prev_mirror = get_prev_mirror(mirror, ctrl->num_copies);
+	int nr_sector;
+	u32 offset;
+	int ret;
+
+	/*
+	 * Reset the io_bio logial bytenr so later io_add_or_submit() can do
+	 * correct check on the logical bytenr.
+	 */
+	ctrl->io_bio->bi_iter.bi_sector = 0;
+
+	/* Add all bad sectors into io_bio. */
+	bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter, offset) {
+		u64 logical = ctrl->logical + offset;
+
+		nr_sector = offset >> fs_info->sectorsize_bits;
+
+		/* Good sectors, no need to handle. */
+		if (!test_bit(nr_sector, &ctrl->bad_bitmap))
+			continue;
+
+		io_add_or_submit(ctrl, mirror, logical, bv.bv_page,
+				 bv.bv_offset, REQ_OP_READ | REQ_SYNC);
+	}
+	io_bio_submit(ctrl, mirror, REQ_OP_READ | REQ_SYNC);
+
+	/* Check the newly read data. */
+	bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter, offset) {
+		u8 *csum_expected;
+		u8 csum[BTRFS_CSUM_SIZE];
+
+		nr_sector = offset >> fs_info->sectorsize_bits;
+
+		/* Originally good sector or read failed, skip. */
+		if (!test_bit(nr_sector, &old_bitmap) ||
+		    test_bit(nr_sector, &ctrl->bad_bitmap))
+			continue;
+
+		/* No data csum, only need to repair. */
+		if (!ctrl->csum)
+			goto repair;
+
+		/*
+		 * The remaining case is successful read with csum, need
+		 * recheck the csum.
+		 */
+		csum_expected = btrfs_csum_ptr(fs_info, ctrl->csum, offset);
+		ret = btrfs_check_sector_csum(fs_info, bv.bv_page,
+				bv.bv_offset, csum, csum_expected);
+		if (ret) {
+			set_bit(nr_sector, &ctrl->bad_bitmap);
+			continue;
+		}
+repair:
+		/*
+		 * This sector is properly fixed, write it back to previous
+		 * bad mirror.
+		 */
+		writeback_good_mirror(ctrl, prev_mirror, ctrl->logical + offset,
+				bv.bv_page, bv.bv_offset);
+	}
+	/* Submit the last write bio. */
+	io_bio_submit(ctrl, mirror, REQ_OP_WRITE);
+}
+
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
+{
+	struct btrfs_fs_info *fs_info;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	u32 offset;
+	int nr_sectors;
+	int mirror;
+	int ret = -EIO;
+
+	if (!ctrl->inode)
+		return 0;
+
+	fs_info = btrfs_sb(ctrl->inode->i_sb);
+	nr_sectors = ctrl->len >> fs_info->sectorsize_bits;
+	ASSERT(ctrl->len);
+	/* All sectors should be bad initially. */
+	ASSERT(find_first_zero_bit(&ctrl->bad_bitmap, nr_sectors) == nr_sectors);
+
+	for (mirror = get_next_mirror(ctrl->failed_mirror, ctrl->num_copies);
+	     mirror != ctrl->failed_mirror;
+	     mirror = get_next_mirror(mirror, ctrl->num_copies)) {
+		repair_from_mirror(ctrl, mirror);
+
+		/* All repaired*/
+		if (find_first_bit(&ctrl->bad_bitmap, nr_sectors) == nr_sectors) {
+			ret = 0;
+			break;
+		}
+	}
+
+	/* DIO doesn't need any page status/extent update.*/
+	if (!ctrl->is_dio) {
+		/* Unlock all the pages and unlock the extent range. */
+		bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter,
+				    offset) {
+			bool uptodate = !test_bit(offset >>
+						  fs_info->sectorsize_bits,
+						  &ctrl->bad_bitmap);
+
+			end_sector_io(bv.bv_page, ctrl->file_offset + offset,
+				      uptodate);
+		}
+	}
+	bio_put(ctrl->bad_sectors);
+	if (ctrl->io_bio)
+		bio_put(ctrl->io_bio);
+	memset(ctrl, 0, sizeof(*ctrl));
+	return ret;
+}
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
new file mode 100644
index 000000000000..87219c786109
--- /dev/null
+++ b/fs/btrfs/read-repair.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_READ_REPAIR_H
+#define BTRFS_READ_REPAIR_H
+
+#include <linux/blk_types.h>
+#include <linux/fs.h>
+
+struct btrfs_read_repair_ctrl {
+	struct inode *inode;
+
+	/* The logical bytenr of the firts corrupted sector. */
+	u64 logical;
+
+	/* The file offset of the first corrupted sector. */
+	u64 file_offset;
+
+	/* The checksum for the corrupted sectors. */
+	u8 *csum;
+
+	/* Current length of the corrupted range. */
+	u32 len;
+
+	int failed_mirror;
+	int num_copies;
+	unsigned long bad_bitmap;
+	bool is_raid56;
+	bool is_dio;
+
+	/* This is only to hold all the initial bad continuous sectors. */
+	struct bio *bad_sectors;
+
+	/*
+	 * The bio we use to do the real IO.
+	 * This bio has to be btrfs_bio, as btrfs_map_bio() will utilize
+	 * btrfs_bio()->device.
+	 */
+	struct bio *io_bio;
+};
+
+int btrfs_read_repair_add_sector(struct inode *inode,
+				 struct btrfs_read_repair_ctrl *ctrl,
+				 struct page *page, unsigned int pgoff,
+				 u64 logical, u64 file_offset, u8 *csum,
+				 int failed_mirror, bool is_dio);
+int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
+
+#endif
-- 
2.36.1

