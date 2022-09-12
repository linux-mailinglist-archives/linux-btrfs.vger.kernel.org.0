Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F55B5BF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiILOLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiILOLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:11:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01ED2018E
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DgimGcvF+UULhOXaZOEh1JaLAiDqGEZwQVC9KxkQLeY=; b=vP+dwy06aVjtOCc0PEA7yS5vId
        7ECqik5QS3xWhVPdF7DpJBiE8C5eC1doB51+6ukPkXc5KJcNJAtPN6Rc4YbpqXo/DymLNLAc+CoAA
        8U2qB8OZmOjFUnt2RZz5CRtNvpYek85em6SOTo5vLEvHJ8ZtfFpdWlbDBGQLOcyvojLnz6t6DFIS5
        P7tWK2peVlG6yAX+QlBaZp8krVTqpPZ62aUxYMB0pED+6KKbP57DGPma9W0NZlMOxXh4iUT4BAlI2
        e5lMip3pbqAhoT7bI9AIf1uGfW1hG3gM6VwUPWQd7uwVmMG78Mxihpshye0him2eXl1iV5jO/zNhP
        vrCx8UpA==;
Received: from [2001:4bb8:198:a30e:bb46:613c:209e:f1ad] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk9t-00AWQV-RO; Mon, 12 Sep 2022 14:11:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: split the bio submission path into a separate file
Date:   Mon, 12 Sep 2022 16:11:20 +0200
Message-Id: <20220912141121.3744931-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912141121.3744931-1-hch@lst.de>
References: <20220912141121.3744931-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/bio.c         | 290 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/bio.h         | 103 ++++++++++++++
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/disk-io.c     |   2 +-
 fs/btrfs/extent_io.c   |   2 +-
 fs/btrfs/file-item.c   |   2 +-
 fs/btrfs/inode.c       |   2 +-
 fs/btrfs/super.c       |   2 +-
 fs/btrfs/volumes.c     | 296 +----------------------------------------
 fs/btrfs/volumes.h     |  91 +------------
 11 files changed, 410 insertions(+), 384 deletions(-)
 create mode 100644 fs/btrfs/bio.c
 create mode 100644 fs/btrfs/bio.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea3..f28ec049ae419 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o bio.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
new file mode 100644
index 0000000000000..2bf17274caf75
--- /dev/null
+++ b/fs/btrfs/bio.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ * Copyright (C) 2022 Christoph Hellwig.
+ */
+#include <linux/bio.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "raid56.h"
+#include "async-thread.h"
+#include "check-integrity.h"
+#include "rcu-string.h"
+#include "zoned.h"
+#include "bio.h"
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
+		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
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
index 0000000000000..47f356aecd398
--- /dev/null
+++ b/fs/btrfs/bio.h
@@ -0,0 +1,103 @@
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
+	unsigned int mirror_num;
+
+	/* for direct I/O */
+	u64 file_offset;
+
+	/* @device is for stripe IO submission. */
+	struct btrfs_device *device;
+	u8 *csum;
+	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+	struct bvec_iter iter;
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
+static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
+{
+	bbio->bio.bi_status = status;
+	bbio->end_io(bbio);
+}
+
+static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
+{
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
index 1c77de3239bc4..4f9dc4115401f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -24,7 +24,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "volumes.h"
+#include "bio.h"
 #include "ordered-data.h"
 #include "compression.h"
 #include "extent_io.h"
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f2b875b93ddfb..e3419d2d32295 100644
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
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cea7d09c2dc1d..a16442eadb02c 100644
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
index 29999686d234c..b0cda6ac12bd6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -13,7 +13,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "volumes.h"
+#include "bio.h"
 #include "print-tree.h"
 #include "compression.h"
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10849db7f3a58..a98257ea6e907 100644
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
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb0ae7e396ef4..50de5abf74446 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -34,7 +34,7 @@
 #include "print-tree.h"
 #include "props.h"
 #include "xattr.h"
-#include "volumes.h"
+#include "bio.h"
 #include "export.h"
 #include "compression.h"
 #include "rcu-string.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 94ba46d579205..ebc1ebc0f5304 100644
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
@@ -34,8 +29,6 @@
 #include "discard.h"
 #include "zoned.h"
 
-static struct bio_set btrfs_bioset;
-
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -248,11 +241,6 @@ out_overflow:;
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
@@ -6358,11 +6346,11 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
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
@@ -6645,266 +6633,6 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
-		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
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
@@ -8404,17 +8132,3 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 
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
index f19a1cd1bfcf2..266812ae51b8c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -343,8 +343,6 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 };
 
-#define BTRFS_BIO_INLINE_CSUM_SIZE	64
-
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
 			- sizeof(struct btrfs_chunk))		\
 			/ sizeof(struct btrfs_stripe) + 1)
@@ -354,89 +352,6 @@ struct btrfs_fs_devices {
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
-	unsigned int mirror_num;
-
-	/* for direct I/O */
-	u64 file_offset;
-
-	/* @device is for stripe IO submission. */
-	struct btrfs_device *device;
-	u8 *csum;
-	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
-	struct bvec_iter iter;
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
@@ -586,6 +501,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -597,7 +517,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

