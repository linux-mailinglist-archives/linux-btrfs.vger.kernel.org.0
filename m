Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7552A550
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbiEQOvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349423AbiEQOvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3818344
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MiF+up1PWtRjoyl+3XwNYyLOLXbkV1SH0JPshhk6Nuk=; b=Q7+wgENfApM2ErnVraCyHqyTDu
        dr60Aco0FEmpWk4zVNE+Kc/cVI8sQhcUBJBouTd07CkiguM9ivq8ICUWpHwKWUZowVzseQxGtxxD9
        eDOQZ3oLvryVHU5oT4YFU5EXRIhfawVk/voMOG77D16sxBs9tGkVIe9FdEJhy8P7MhJp+/2UuAJCJ
        tEBLyiKqyKXSHtKLW2LHLrm4JoAGjxJ1aa8hWvqPu+5CvpHNMJIKRpQuK2q53v4U91MxZaBHRlmwD
        4TDM0HNtIKQAJVjRR6u6cIuHQymyTBZEq2FxZiG04uLcI5T9hEc/GDpVmHVUn1sgvfo5kAVP2YszL
        YZq6t9ZQ==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXi-00EXH4-W5; Tue, 17 May 2022 14:51:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 12/15] btrfs: add new read repair infrastructure
Date:   Tue, 17 May 2022 16:50:36 +0200
Message-Id: <20220517145039.3202184-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

This adds a new read repair implementation for btrfs.  It is synchronous
in that the end I/O handlers call them, and will get back the results
instead of potentially getting multiple concurrent calls back into the
original end I/O handler.  The synchronous nature has the following
advantages:

 - there is no need for a per-I/O tree of I/O failures, as everything
   related to the I/O failure can be handled locally
 - not having separate repair end I/O helpers will in the future help
   to reuse the direct I/O bio from iomap for the actual submission and
   thus remove the btrfs_dio_private infrastructure

Because submitting many sector size synchronous I/Os would be very
slow when multiple sectors (or a whole read) fail, this new code instead
submits a single read and repair write bio for each contiguous section.
It uses clone of the bio to do that and thus does not need to allocate
any extra bio_vecs.  Note that this cloning is open coded instead of
using the block layer clone helpers as the clone is based on the save
iter in the btrfs_bio, and not bio.bi_iter, which at the point that the
repair code is called has been advanced by the low-level driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/read-repair.c | 211 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h |  33 +++++++
 fs/btrfs/super.c       |   9 +-
 4 files changed, 252 insertions(+), 3 deletions(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea3..0b2605c750cab 100644
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
diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
new file mode 100644
index 0000000000000..3ac93bfe09e4f
--- /dev/null
+++ b/fs/btrfs/read-repair.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Christoph Hellwig.
+ */
+#include "ctree.h"
+#include "volumes.h"
+#include "read-repair.h"
+#include "btrfs_inode.h"
+
+static struct bio_set read_repair_bioset;
+
+static int next_mirror(struct btrfs_read_repair *rr, int cur_mirror)
+{
+	if (cur_mirror == rr->num_copies)
+		return cur_mirror + 1 - rr->num_copies;
+	return cur_mirror + 1;
+}
+
+static int prev_mirror(struct btrfs_read_repair *rr, int cur_mirror)
+{
+	if (cur_mirror == 1)
+		return rr->num_copies;
+	return cur_mirror - 1;
+}
+
+/*
+ * Clone a new bio from the src_bbio, using the saved iter in the btrfs_bio
+ * instead of bi_iter.
+ */
+static struct btrfs_bio *btrfs_repair_bio_clone(struct btrfs_bio *src_bbio,
+		u64 offset, u32 size, unsigned int op)
+{
+	struct btrfs_bio *bbio;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(NULL, 0, op | REQ_SYNC, GFP_NOFS,
+			       &read_repair_bioset);
+	bio_set_flag(bio, BIO_CLONED);
+
+	bio->bi_io_vec = src_bbio->bio.bi_io_vec;
+	bio->bi_iter = src_bbio->iter;
+	bio_advance(bio, offset);
+	bio->bi_iter.bi_size = size;
+
+	bbio = btrfs_bio(bio);
+	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->iter = bbio->bio.bi_iter;
+	bbio->file_offset = src_bbio->file_offset + offset;
+
+	return bbio;
+}
+
+static void btrfs_repair_one_mirror(struct btrfs_bio *read_bbio,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		int bad_mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *bi = BTRFS_I(inode);
+	u64 logical = read_bbio->iter.bi_sector << SECTOR_SHIFT;
+	u64 file_offset = read_bbio->file_offset;
+	struct btrfs_bio *write_bbio;
+	blk_status_t ret;
+
+	/*
+	 * For zoned file systems repair has to relocate the whole zone.
+	 */
+	if (btrfs_repair_one_zone(fs_info, logical))
+		return;
+
+	/*
+	 * For RAID56, we can not just write the bad data back, as any write
+	 * will trigger RMW and read back the corrrupted on-disk stripe, causing
+	 * further damage.
+	 *
+	 * Perform a special low-level repair that bypasses btrfs_map_bio.
+	 */
+	if (btrfs_is_parity_mirror(fs_info, logical, fs_info->sectorsize)) {
+		struct bvec_iter iter;
+		struct bio_vec bv;
+		u32 offset;
+
+		btrfs_bio_for_each_sector(fs_info, bv, read_bbio, iter, offset)
+			btrfs_repair_io_failure(fs_info, btrfs_ino(bi),
+					file_offset + offset,
+					fs_info->sectorsize,
+					logical + offset,
+					bv.bv_page, bv.bv_offset,
+					bad_mirror);
+		return;
+	}
+
+	/*
+	 * Otherwise just clone the whole bio and write it back to the
+	 * previously bad mirror.
+	 */
+	write_bbio = btrfs_repair_bio_clone(read_bbio, 0,
+			read_bbio->iter.bi_size, REQ_OP_WRITE);
+	ret = btrfs_map_bio_wait(fs_info, &write_bbio->bio, bad_mirror);
+	bio_put(&write_bbio->bio);
+
+	btrfs_info_rl(fs_info,
+		"%s: root %lld ino %llu off %llu logical %llu/%u from good mirror %d",
+		ret ? "failed to correct read error" : "read error corrected",
+		bi->root->root_key.objectid, btrfs_ino(bi),
+		file_offset, logical, read_bbio->iter.bi_size, bad_mirror);
+}
+
+static bool btrfs_repair_read_bio(struct btrfs_bio *bbio,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		int read_mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u32 start_offset = bbio->file_offset - failed_bbio->file_offset;
+	u8 csum[BTRFS_CSUM_SIZE];
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	u32 offset;
+
+	if (btrfs_map_bio_wait(fs_info, &bbio->bio, read_mirror))
+		return false;
+
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		return true;
+
+	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
+		u8 *expected_csum =
+			btrfs_csum_ptr(fs_info, failed_bbio->csum,
+					start_offset + offset);
+
+		if (btrfs_check_data_sector(fs_info, bv.bv_page, bv.bv_offset,
+				csum, expected_csum))
+			return false;
+	}
+
+	return true;
+}
+
+bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		u64 end_offset, repair_endio_t endio)
+{
+	u8 bad_mirror = failed_bbio->mirror_num;
+	u8 read_mirror = next_mirror(rr, bad_mirror);
+	struct btrfs_bio *read_bbio = NULL;
+	bool uptodate = false;
+
+	do {
+		if (read_bbio)
+			bio_put(&read_bbio->bio);
+		read_bbio = btrfs_repair_bio_clone(failed_bbio,
+				rr->start_offset, end_offset - rr->start_offset,
+				REQ_OP_READ);
+		if (btrfs_repair_read_bio(read_bbio, failed_bbio, inode,
+				read_mirror)) {
+			do {
+		    		btrfs_repair_one_mirror(read_bbio, failed_bbio,
+						inode, bad_mirror);
+			} while ((bad_mirror = prev_mirror(rr, bad_mirror)) !=
+					failed_bbio->mirror_num);
+			uptodate = true;
+			break;
+		}
+		bad_mirror = read_mirror;
+		read_mirror = next_mirror(rr, bad_mirror);
+	} while (read_mirror != failed_bbio->mirror_num);
+
+	if (endio)
+		endio(read_bbio, inode, uptodate);
+	bio_put(&read_bbio->bio);
+
+	rr->in_use = false;
+	return uptodate;
+}
+
+bool btrfs_read_repair_add(struct btrfs_read_repair *rr,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		u64 start_offset)
+{
+	if (rr->in_use)
+		return true;
+
+	if (!rr->num_copies) {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		rr->num_copies = btrfs_num_copies(fs_info,
+				failed_bbio->iter.bi_sector << SECTOR_SHIFT,
+				failed_bbio->iter.bi_size);
+	}
+
+	/*
+	 * If there is no other copy of the data to recovery from, give up now
+	 * and don't even try to build up a larget batch.
+	 */
+	if (rr->num_copies < 2)
+		return false;
+
+	rr->in_use = true;
+	rr->start_offset = start_offset;
+	return true;
+}
+
+void btrfs_read_repair_exit(void)
+{
+	bioset_exit(&read_repair_bioset);
+}
+
+int __init btrfs_read_repair_init(void)
+{
+	return bioset_init(&read_repair_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_bio, bio), 0);
+}
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
new file mode 100644
index 0000000000000..e371790af2b3e
--- /dev/null
+++ b/fs/btrfs/read-repair.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BTRFS_READ_REPAIR_H
+#define BTRFS_READ_REPAIR_H
+
+struct btrfs_read_repair {
+	u64 start_offset;
+	bool in_use;
+	int num_copies;
+};
+
+typedef void (*repair_endio_t)(struct btrfs_bio *repair_bbio,
+		struct inode *inode, bool uptodate);
+
+bool btrfs_read_repair_add(struct btrfs_read_repair *rr,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		u64 bio_offset);
+bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		u64 end_offset, repair_endio_t end_io);
+static inline bool btrfs_read_repair_end(struct btrfs_read_repair *rr,
+		struct btrfs_bio *failed_bbio, struct inode *inode,
+		u64 end_offset, repair_endio_t endio)
+{
+	if (!rr->in_use)
+		return true;
+	return __btrfs_read_repair_end(rr, failed_bbio, inode, end_offset,
+			endio);
+}
+
+int __init btrfs_read_repair_init(void);
+void btrfs_read_repair_exit(void);
+
+#endif /* BTRFS_READ_REPAIR_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b1fdc6a26c76e..b33ad892c3058 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -48,6 +48,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "qgroup.h"
+#include "read-repair.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
@@ -2641,10 +2642,12 @@ static int __init init_btrfs_fs(void)
 	err = extent_io_init();
 	if (err)
 		goto free_cachep;
-
-	err = extent_state_cache_init();
+	err = btrfs_read_repair_init();
 	if (err)
 		goto free_extent_io;
+	err = extent_state_cache_init();
+	if (err)
+		goto free_read_repair;
 
 	err = extent_map_init();
 	if (err)
@@ -2708,6 +2711,8 @@ static int __init init_btrfs_fs(void)
 	extent_map_exit();
 free_extent_state_cache:
 	extent_state_cache_exit();
+free_read_repair:
+	btrfs_read_repair_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
-- 
2.30.2

