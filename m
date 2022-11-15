Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800B6294A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiKOJoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 04:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiKOJoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 04:44:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB722BC1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V1a4AnsygGMVSPZg/Iw5R3wth4lF7KqftsfrdjbuObw=; b=rUY6DMrmEn82iynzYbPDQVTeb5
        dKuaBiCq/YFdZSqDQqKqJRunnQndo7RBDtEZ9nu3DWNVUxRZUoXBqCTHI8gmadmQgp9vzIBw5XMAB
        tliZCMx349umghJ49WGksBoSK9J2y/cdb2vCLPOkciW+WXN6ebtv+VQ27CnGZO+0dExHr7X+o/hGT
        5U59HCrEV1Onzf1ofJN7kY3bKETAvfHEoYYzCVHLtQfcO9QNE4bYLA04Gq9S7rxJpTicl4gcibOGo
        MnJdYBDXmV9t2PgT1qApHJkGeSDsbwvO1v3BOzf5CGpwVCTx2fXDiQjhG9vQhc7xCmgw76T7rgEsw
        SKIlkL8w==;
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ousUI-009Wr0-IU; Tue, 15 Nov 2022 09:44:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: split the bio submission path into a separate file
Date:   Tue, 15 Nov 2022 10:44:05 +0100
Message-Id: <20221115094407.1626250-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115094407.1626250-1-hch@lst.de>
References: <20221115094407.1626250-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The code used by btrfs_submit_bio only interacts with the rest of
volumes.c through __btrfs_map_block (which itself is a more generic
version of two exported helpers) and does not really have anything
to do with volumes.c.  Create a new bio.c file and a bio.h header
going along with it for the btrfs_bio-based storage layer, which
will grow even more going forward.

Also update the file with my copyright notice given that a large
part of the moved code was written or rewritten by me.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/bio.c         | 291 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/bio.h         | 126 ++++++++++++++++++
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/ctree.c       |   1 +
 fs/btrfs/disk-io.c     |   2 +-
 fs/btrfs/extent-tree.c |   1 +
 fs/btrfs/extent_io.c   |   2 +-
 fs/btrfs/file-item.c   |   2 +-
 fs/btrfs/inode.c       |   2 +-
 fs/btrfs/relocation.c  |   1 +
 fs/btrfs/super.c       |   2 +-
 fs/btrfs/tree-log.c    |   1 +
 fs/btrfs/volumes.c     | 296 +----------------------------------------
 fs/btrfs/volumes.h     | 111 +---------------
 15 files changed, 438 insertions(+), 404 deletions(-)
 create mode 100644 fs/btrfs/bio.c
 create mode 100644 fs/btrfs/bio.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 84fb3b4c35b07..555c962fdad66 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o
+	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
new file mode 100644
index 0000000000000..194b927ef9ee4
--- /dev/null
+++ b/fs/btrfs/bio.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ * Copyright (C) 2022 Christoph Hellwig.
+ */
+#include <linux/bio.h>
+#include "bio.h"
+#include "ctree.h"
+#include "volumes.h"
+#include "raid56.h"
+#include "async-thread.h"
+#include "check-integrity.h"
+#include "dev-replace.h"
+#include "rcu-string.h"
+#include "zoned.h"
+
+static struct bio_set btrfs_bioset;
+
+/*
+ * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
+ * is already initialized by the block layer.
+ */
+static inline void btrfs_bio_init(struct btrfs_bio *bbio,
+				  btrfs_bio_end_io_t end_io, void *private)
+{
+	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->end_io = end_io;
+	bbio->private = private;
+}
+
+/*
+ * Allocate a btrfs_bio structure.  The btrfs_bio is the main I/O container for
+ * btrfs, and is used for all I/O submitted through btrfs_submit_bio.
+ *
+ * Just like the underlying bio_alloc_bioset it will not fail as it is backed by
+ * a mempool.
+ */
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    btrfs_bio_end_io_t end_io, void *private)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
+	btrfs_bio_init(btrfs_bio(bio), end_io, private);
+	return bio;
+}
+
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    btrfs_bio_end_io_t end_io, void *private)
+{
+	struct bio *bio;
+	struct btrfs_bio *bbio;
+
+	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
+
+	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio, end_io, private);
+
+	bio_trim(bio, offset >> 9, size >> 9);
+	bbio->iter = bio->bi_iter;
+	return bio;
+}
+
+static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
+{
+	if (!dev || !dev->bdev)
+		return;
+	if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != BLK_STS_TARGET)
+		return;
+
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+	if (!(bio->bi_opf & REQ_RAHEAD))
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
+	if (bio->bi_opf & REQ_PREFLUSH)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
+}
+
+static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
+						struct bio *bio)
+{
+	if (bio->bi_opf & REQ_META)
+		return fs_info->endio_meta_workers;
+	return fs_info->endio_workers;
+}
+
+static void btrfs_end_bio_work(struct work_struct *work)
+{
+	struct btrfs_bio *bbio =
+		container_of(work, struct btrfs_bio, end_io_work);
+
+	bbio->end_io(bbio);
+}
+
+static void btrfs_simple_end_io(struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	btrfs_bio_counter_dec(fs_info);
+
+	if (bio->bi_status)
+		btrfs_log_dev_io_error(bio, bbio->device);
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
+		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
+	} else {
+		bbio->end_io(bbio);
+	}
+}
+
+static void btrfs_raid56_end_io(struct bio *bio)
+{
+	struct btrfs_io_context *bioc = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	btrfs_bio_counter_dec(bioc->fs_info);
+	bbio->mirror_num = bioc->mirror_num;
+	bbio->end_io(bbio);
+
+	btrfs_put_bioc(bioc);
+}
+
+static void btrfs_orig_write_end_io(struct bio *bio)
+{
+	struct btrfs_io_stripe *stripe = bio->bi_private;
+	struct btrfs_io_context *bioc = stripe->bioc;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	btrfs_bio_counter_dec(bioc->fs_info);
+
+	if (bio->bi_status) {
+		atomic_inc(&bioc->error);
+		btrfs_log_dev_io_error(bio, stripe->dev);
+	}
+
+	/*
+	 * Only send an error to the higher layers if it is beyond the tolerance
+	 * threshold.
+	 */
+	if (atomic_read(&bioc->error) > bioc->max_errors)
+		bio->bi_status = BLK_STS_IOERR;
+	else
+		bio->bi_status = BLK_STS_OK;
+
+	bbio->end_io(bbio);
+	btrfs_put_bioc(bioc);
+}
+
+static void btrfs_clone_write_end_io(struct bio *bio)
+{
+	struct btrfs_io_stripe *stripe = bio->bi_private;
+
+	if (bio->bi_status) {
+		atomic_inc(&stripe->bioc->error);
+		btrfs_log_dev_io_error(bio, stripe->dev);
+	}
+
+	/* Pass on control to the original bio this one was cloned from */
+	bio_endio(stripe->bioc->orig_bio);
+	bio_put(bio);
+}
+
+static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
+{
+	if (!dev || !dev->bdev ||
+	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
+	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
+	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
+		bio_io_error(bio);
+		return;
+	}
+
+	bio_set_dev(bio, dev->bdev);
+
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+		if (btrfs_dev_is_sequential(dev, physical)) {
+			u64 zone_start = round_down(physical,
+						    dev->fs_info->zone_size);
+
+			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		} else {
+			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
+			bio->bi_opf |= REQ_OP_WRITE;
+		}
+	}
+	btrfs_debug_in_rcu(dev->fs_info,
+	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
+		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
+		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
+		dev->devid, bio->bi_iter.bi_size);
+
+	btrfsic_check_bio(bio);
+	submit_bio(bio);
+}
+
+static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
+{
+	struct bio *orig_bio = bioc->orig_bio, *bio;
+
+	ASSERT(bio_op(orig_bio) != REQ_OP_READ);
+
+	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
+	if (dev_nr == bioc->num_stripes - 1) {
+		bio = orig_bio;
+		bio->bi_end_io = btrfs_orig_write_end_io;
+	} else {
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		bio_inc_remaining(orig_bio);
+		bio->bi_end_io = btrfs_clone_write_end_io;
+	}
+
+	bio->bi_private = &bioc->stripes[dev_nr];
+	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
+	bioc->stripes[dev_nr].bioc = bioc;
+	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
+}
+
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
+{
+	u64 logical = bio->bi_iter.bi_sector << 9;
+	u64 length = bio->bi_iter.bi_size;
+	u64 map_length = length;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap;
+	int ret;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				&bioc, &smap, &mirror_num, 1);
+	if (ret) {
+		btrfs_bio_counter_dec(fs_info);
+		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+		return;
+	}
+
+	if (map_length < length) {
+		btrfs_crit(fs_info,
+			   "mapping failed logical %llu bio len %llu len %llu",
+			   logical, length, map_length);
+		BUG();
+	}
+
+	if (!bioc) {
+		/* Single mirror read/write fast path */
+		btrfs_bio(bio)->mirror_num = mirror_num;
+		btrfs_bio(bio)->device = smap.dev;
+		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
+		bio->bi_private = fs_info;
+		bio->bi_end_io = btrfs_simple_end_io;
+		btrfs_submit_dev_bio(smap.dev, bio);
+	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/* Parity RAID write or read recovery */
+		bio->bi_private = bioc;
+		bio->bi_end_io = btrfs_raid56_end_io;
+		if (bio_op(bio) == REQ_OP_READ)
+			raid56_parity_recover(bio, bioc, mirror_num);
+		else
+			raid56_parity_write(bio, bioc);
+	} else {
+		/* Write to multiple mirrors */
+		int total_devs = bioc->num_stripes;
+		int dev_nr;
+
+		bioc->orig_bio = bio;
+		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+			btrfs_submit_mirrored_bio(bioc, dev_nr);
+	}
+}
+
+int __init btrfs_bioset_init(void)
+{
+	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_bio, bio),
+			BIOSET_NEED_BVECS))
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold btrfs_bioset_exit(void)
+{
+	bioset_exit(&btrfs_bioset);
+}
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
new file mode 100644
index 0000000000000..4aa3bfc753911
--- /dev/null
+++ b/fs/btrfs/bio.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ * Copyright (C) 2022 Christoph Hellwig.
+ */
+#ifndef BTRFS_BIO_H
+#define BTRFS_BIO_H
+
+#include <linux/bio.h>
+#include <linux/workqueue.h>
+#include "parent-check.h"
+
+struct btrfs_bio;
+struct btrfs_fs_info;
+
+#define BTRFS_BIO_INLINE_CSUM_SIZE	64
+
+/*
+ * Maximum number of sectors for a single bio to limit the size of the
+ * checksum array.  This matches the number of bio_vecs per bio and thus the
+ * I/O size for buffered I/O.
+ */
+#define BTRFS_MAX_BIO_SECTORS		(256)
+
+typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
+
+/*
+ * Additional info to pass along bio.
+ *
+ * Mostly for btrfs specific features like csum and mirror_num.
+ */
+struct btrfs_bio {
+	unsigned int mirror_num:7;
+
+	/*
+	 * Extra indicator for metadata bios.
+	 * For some btrfs bios they use pages without a mapping, thus
+	 * we can not rely on page->mapping->host to determine if
+	 * it's a metadata bio.
+	 */
+	unsigned int is_metadata:1;
+	struct bvec_iter iter;
+
+	/* for direct I/O */
+	u64 file_offset;
+
+	/* @device is for stripe IO submission. */
+	struct btrfs_device *device;
+	union {
+		/* For data checksum verification. */
+		struct {
+			u8 *csum;
+			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+		};
+
+		/* For metadata parentness verification. */
+		struct btrfs_tree_parent_check parent_check;
+	};
+
+	/* End I/O information supplied to btrfs_bio_alloc */
+	btrfs_bio_end_io_t end_io;
+	void *private;
+
+	/* For read end I/O handling */
+	struct work_struct end_io_work;
+
+	/*
+	 * This member must come last, bio_alloc_bioset will allocate enough
+	 * bytes for entire btrfs_bio but relies on bio being last.
+	 */
+	struct bio bio;
+};
+
+static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
+{
+	return container_of(bio, struct btrfs_bio, bio);
+}
+
+int __init btrfs_bioset_init(void);
+void __cold btrfs_bioset_exit(void);
+
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+			    btrfs_bio_end_io_t end_io, void *private);
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
+				    btrfs_bio_end_io_t end_io, void *private);
+
+
+static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
+{
+	bbio->bio.bi_status = status;
+	bbio->end_io(bbio);
+}
+
+static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
+{
+	if (bbio->is_metadata)
+		return;
+	if (bbio->csum != bbio->csum_inline) {
+		kfree(bbio->csum);
+		bbio->csum = NULL;
+	}
+}
+
+/*
+ * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
+ *
+ * bvl        - struct bio_vec
+ * bbio       - struct btrfs_bio
+ * iters      - struct bvec_iter
+ * bio_offset - unsigned int
+ */
+#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
+	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
+	     (iter).bi_size &&					\
+	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
+	     (bio_offset) += fs_info->sectorsize,			\
+	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
+	     (fs_info)->sectorsize))
+
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num);
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num);
+
+#endif /* BTRFS_BIO_H */
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 30adf430241e1..5122ca79f7ea4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -27,7 +27,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "volumes.h"
+#include "bio.h"
 #include "ordered-data.h"
 #include "compression.h"
 #include "extent_io.h"
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f75e398d7b712..23b1443988ee3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -22,6 +22,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "relocation.h"
+#include "parent-check.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 91a088210e5ad..d5be259845d10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -23,7 +23,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "volumes.h"
+#include "bio.h"
 #include "print-tree.h"
 #include "locking.h"
 #include "tree-log.h"
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 17f599027c3de..900be08ade699 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -42,6 +42,7 @@
 #include "root-tree.h"
 #include "file-item.h"
 #include "orphan.h"
+#include "parent-check.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65ba5c3658cf6..95d54b5834c09 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -20,7 +20,7 @@
 #include "extent_map.h"
 #include "ctree.h"
 #include "btrfs_inode.h"
-#include "volumes.h"
+#include "bio.h"
 #include "check-integrity.h"
 #include "locking.h"
 #include "rcu-string.h"
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 352bbb33b76f0..5de73466b2ca2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -14,7 +14,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "volumes.h"
+#include "bio.h"
 #include "print-tree.h"
 #include "compression.h"
 #include "fs.h"
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4248e6cabbdcb..905ea19df125b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -43,7 +43,7 @@
 #include "ordered-data.h"
 #include "xattr.h"
 #include "tree-log.h"
-#include "volumes.h"
+#include "bio.h"
 #include "compression.h"
 #include "locking.h"
 #include "free-space-cache.h"
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index aa80e51bc8ca4..5e15796aa6dc3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -35,6 +35,7 @@
 #include "file-item.h"
 #include "relocation.h"
 #include "super.h"
+#include "parent-check.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ea83dd9f735a6..93f52ee85f6fe 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -35,7 +35,7 @@
 #include "print-tree.h"
 #include "props.h"
 #include "xattr.h"
-#include "volumes.h"
+#include "bio.h"
 #include "export.h"
 #include "compression.h"
 #include "rcu-string.h"
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c9a8cbe837fef..2c4dd2b5369cf 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -29,6 +29,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "orphan.h"
+#include "parent-check.h"
 
 #define MAX_CONFLICT_INODES 10
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e51fd5f1042a6..acab20f2863d5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5,12 +5,9 @@
 
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
-#include <linux/bio.h>
 #include <linux/slab.h>
-#include <linux/blkdev.h>
 #include <linux/ratelimit.h>
 #include <linux/kthread.h>
-#include <linux/raid/pq.h>
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
@@ -23,8 +20,6 @@
 #include "print-tree.h"
 #include "volumes.h"
 #include "raid56.h"
-#include "async-thread.h"
-#include "check-integrity.h"
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
@@ -41,8 +36,6 @@
 #include "scrub.h"
 #include "super.h"
 
-static struct bio_set btrfs_bioset;
-
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -255,11 +248,6 @@ out_overflow:;
 static int init_first_rw_device(struct btrfs_trans_handle *trans);
 static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
-static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op, u64 logical, u64 *length,
-			     struct btrfs_io_context **bioc_ret,
-			     struct btrfs_io_stripe *smap,
-			     int *mirror_num_ret, int need_raid_map);
 
 /*
  * Device locking
@@ -6364,11 +6352,11 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 			stripe_offset + stripe_nr * map->stripe_len;
 }
 
-static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op, u64 logical, u64 *length,
-			     struct btrfs_io_context **bioc_ret,
-			     struct btrfs_io_stripe *smap,
-			     int *mirror_num_ret, int need_raid_map)
+int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 *length,
+		      struct btrfs_io_context **bioc_ret,
+		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
+		      int need_raid_map)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6651,266 +6639,6 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 				 NULL, NULL, 1);
 }
 
-/*
- * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
- * is already initialized by the block layer.
- */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio,
-				  btrfs_bio_end_io_t end_io, void *private)
-{
-	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
-	bbio->end_io = end_io;
-	bbio->private = private;
-}
-
-/*
- * Allocate a btrfs_bio structure.  The btrfs_bio is the main I/O container for
- * btrfs, and is used for all I/O submitted through btrfs_submit_bio.
- *
- * Just like the underlying bio_alloc_bioset it will not fail as it is backed by
- * a mempool.
- */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-			    btrfs_bio_end_io_t end_io, void *private)
-{
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio), end_io, private);
-	return bio;
-}
-
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    btrfs_bio_end_io_t end_io, void *private)
-{
-	struct bio *bio;
-	struct btrfs_bio *bbio;
-
-	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
-
-	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
-	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, end_io, private);
-
-	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
-	return bio;
-}
-
-static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
-{
-	if (!dev || !dev->bdev)
-		return;
-	if (bio->bi_status != BLK_STS_IOERR && bio->bi_status != BLK_STS_TARGET)
-		return;
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
-	if (!(bio->bi_opf & REQ_RAHEAD))
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERRS);
-	if (bio->bi_opf & REQ_PREFLUSH)
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
-}
-
-static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
-						struct bio *bio)
-{
-	if (bio->bi_opf & REQ_META)
-		return fs_info->endio_meta_workers;
-	return fs_info->endio_workers;
-}
-
-static void btrfs_end_bio_work(struct work_struct *work)
-{
-	struct btrfs_bio *bbio =
-		container_of(work, struct btrfs_bio, end_io_work);
-
-	bbio->end_io(bbio);
-}
-
-static void btrfs_simple_end_io(struct bio *bio)
-{
-	struct btrfs_fs_info *fs_info = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-
-	btrfs_bio_counter_dec(fs_info);
-
-	if (bio->bi_status)
-		btrfs_log_dev_io_error(bio, bbio->device);
-
-	if (bio_op(bio) == REQ_OP_READ) {
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
-	} else {
-		bbio->end_io(bbio);
-	}
-}
-
-static void btrfs_raid56_end_io(struct bio *bio)
-{
-	struct btrfs_io_context *bioc = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-
-	btrfs_bio_counter_dec(bioc->fs_info);
-	bbio->mirror_num = bioc->mirror_num;
-	bbio->end_io(bbio);
-
-	btrfs_put_bioc(bioc);
-}
-
-static void btrfs_orig_write_end_io(struct bio *bio)
-{
-	struct btrfs_io_stripe *stripe = bio->bi_private;
-	struct btrfs_io_context *bioc = stripe->bioc;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-
-	btrfs_bio_counter_dec(bioc->fs_info);
-
-	if (bio->bi_status) {
-		atomic_inc(&bioc->error);
-		btrfs_log_dev_io_error(bio, stripe->dev);
-	}
-
-	/*
-	 * Only send an error to the higher layers if it is beyond the tolerance
-	 * threshold.
-	 */
-	if (atomic_read(&bioc->error) > bioc->max_errors)
-		bio->bi_status = BLK_STS_IOERR;
-	else
-		bio->bi_status = BLK_STS_OK;
-
-	bbio->end_io(bbio);
-	btrfs_put_bioc(bioc);
-}
-
-static void btrfs_clone_write_end_io(struct bio *bio)
-{
-	struct btrfs_io_stripe *stripe = bio->bi_private;
-
-	if (bio->bi_status) {
-		atomic_inc(&stripe->bioc->error);
-		btrfs_log_dev_io_error(bio, stripe->dev);
-	}
-
-	/* Pass on control to the original bio this one was cloned from */
-	bio_endio(stripe->bioc->orig_bio);
-	bio_put(bio);
-}
-
-static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
-{
-	if (!dev || !dev->bdev ||
-	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
-	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
-	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-		bio_io_error(bio);
-		return;
-	}
-
-	bio_set_dev(bio, dev->bdev);
-
-	/*
-	 * For zone append writing, bi_sector must point the beginning of the
-	 * zone
-	 */
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-
-		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical,
-						    dev->fs_info->zone_size);
-
-			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
-		} else {
-			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
-			bio->bi_opf |= REQ_OP_WRITE;
-		}
-	}
-	btrfs_debug_in_rcu(dev->fs_info,
-	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
-		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
-		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
-		dev->devid, bio->bi_iter.bi_size);
-
-	btrfsic_check_bio(bio);
-	submit_bio(bio);
-}
-
-static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
-{
-	struct bio *orig_bio = bioc->orig_bio, *bio;
-
-	ASSERT(bio_op(orig_bio) != REQ_OP_READ);
-
-	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
-	if (dev_nr == bioc->num_stripes - 1) {
-		bio = orig_bio;
-		bio->bi_end_io = btrfs_orig_write_end_io;
-	} else {
-		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
-		bio_inc_remaining(orig_bio);
-		bio->bi_end_io = btrfs_clone_write_end_io;
-	}
-
-	bio->bi_private = &bioc->stripes[dev_nr];
-	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
-	bioc->stripes[dev_nr].bioc = bioc;
-	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
-}
-
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
-{
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	u64 length = bio->bi_iter.bi_size;
-	u64 map_length = length;
-	struct btrfs_io_context *bioc = NULL;
-	struct btrfs_io_stripe smap;
-	int ret;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, &smap, &mirror_num, 1);
-	if (ret) {
-		btrfs_bio_counter_dec(fs_info);
-		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-		return;
-	}
-
-	if (map_length < length) {
-		btrfs_crit(fs_info,
-			   "mapping failed logical %llu bio len %llu len %llu",
-			   logical, length, map_length);
-		BUG();
-	}
-
-	if (!bioc) {
-		/* Single mirror read/write fast path */
-		btrfs_bio(bio)->mirror_num = mirror_num;
-		btrfs_bio(bio)->device = smap.dev;
-		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-		bio->bi_private = fs_info;
-		bio->bi_end_io = btrfs_simple_end_io;
-		btrfs_submit_dev_bio(smap.dev, bio);
-	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		/* Parity RAID write or read recovery */
-		bio->bi_private = bioc;
-		bio->bi_end_io = btrfs_raid56_end_io;
-		if (bio_op(bio) == REQ_OP_READ)
-			raid56_parity_recover(bio, bioc, mirror_num);
-		else
-			raid56_parity_write(bio, bioc);
-	} else {
-		/* Write to multiple mirrors */
-		int total_devs = bioc->num_stripes;
-		int dev_nr;
-
-		bioc->orig_bio = bio;
-		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
-			btrfs_submit_mirrored_bio(bioc, dev_nr);
-	}
-}
-
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 				      const struct btrfs_fs_devices *fs_devices)
 {
@@ -8440,17 +8168,3 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 
 	return true;
 }
-
-int __init btrfs_bioset_init(void)
-{
-	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_bio, bio),
-			BIOSET_NEED_BVECS))
-		return -ENOMEM;
-	return 0;
-}
-
-void __cold btrfs_bioset_exit(void)
-{
-	bioset_exit(&btrfs_bioset);
-}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7467df319d3b2..b4ce6183bbf59 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -6,12 +6,10 @@
 #ifndef BTRFS_VOLUMES_H
 #define BTRFS_VOLUMES_H
 
-#include <linux/bio.h>
 #include <linux/sort.h>
 #include <linux/btrfs.h>
 #include "async-thread.h"
 #include "messages.h"
-#include "parent-check.h"
 #include "rcu-string.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
@@ -373,8 +371,6 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 };
 
-#define BTRFS_BIO_INLINE_CSUM_SIZE	64
-
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
 			- sizeof(struct btrfs_chunk))		\
 			/ sizeof(struct btrfs_stripe) + 1)
@@ -384,107 +380,6 @@ struct btrfs_fs_devices {
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
-/*
- * Maximum number of sectors for a single bio to limit the size of the
- * checksum array.  This matches the number of bio_vecs per bio and thus the
- * I/O size for buffered I/O.
- */
-#define BTRFS_MAX_BIO_SECTORS				(256)
-
-typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
-
-/*
- * Additional info to pass along bio.
- *
- * Mostly for btrfs specific features like csum and mirror_num.
- */
-struct btrfs_bio {
-	unsigned int mirror_num:7;
-
-	/*
-	 * Extra indicator for metadata bios.
-	 * For some btrfs bios they use pages without a mapping, thus
-	 * we can not rely on page->mapping->host to determine if
-	 * it's a metadata bio.
-	 */
-	unsigned int is_metadata:1;
-	struct bvec_iter iter;
-
-	/* for direct I/O */
-	u64 file_offset;
-
-	/* @device is for stripe IO submission. */
-	struct btrfs_device *device;
-	union {
-		/* For data checksum verification. */
-		struct {
-			u8 *csum;
-			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
-		};
-
-		/* For metadata parentness verification. */
-		struct btrfs_tree_parent_check parent_check;
-	};
-
-	/* End I/O information supplied to btrfs_bio_alloc */
-	btrfs_bio_end_io_t end_io;
-	void *private;
-
-	/* For read end I/O handling */
-	struct work_struct end_io_work;
-
-	/*
-	 * This member must come last, bio_alloc_bioset will allocate enough
-	 * bytes for entire btrfs_bio but relies on bio being last.
-	 */
-	struct bio bio;
-};
-
-static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
-{
-	return container_of(bio, struct btrfs_bio, bio);
-}
-
-int __init btrfs_bioset_init(void);
-void __cold btrfs_bioset_exit(void);
-
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-			    btrfs_bio_end_io_t end_io, void *private);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
-				    btrfs_bio_end_io_t end_io, void *private);
-
-static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
-{
-	bbio->bio.bi_status = status;
-	bbio->end_io(bbio);
-}
-
-static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-{
-	if (bbio->is_metadata)
-		return;
-	if (bbio->csum != bbio->csum_inline) {
-		kfree(bbio->csum);
-		bbio->csum = NULL;
-	}
-}
-
-/*
- * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
- *
- * bvl        - struct bio_vec
- * bbio       - struct btrfs_bio
- * iters      - struct bvec_iter
- * bio_offset - unsigned int
- */
-#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
-	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
-	     (iter).bi_size &&					\
-	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
-	     (bio_offset) += fs_info->sectorsize,			\
-	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
-	     (fs_info)->sectorsize))
-
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	union {
@@ -641,6 +536,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
+int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 *length,
+		      struct btrfs_io_context **bioc_ret,
+		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
+		      int need_raid_map);
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
 					       u32 *num_stripes);
@@ -652,7 +552,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

