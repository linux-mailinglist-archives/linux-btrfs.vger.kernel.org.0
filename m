Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34A0517DB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiECG4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiECGxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4C2614
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1958210EA
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzxOkWA7SEeLnlfuZoBPzzB1+J5tVtbez35bQHhpDJ0=;
        b=l71NmSB6VJRirRkDl98OvfQenyfOv8gE9O5doj6ea92KmTOpi5vL+DlLvVtKdyhRCPsN/Y
        2lErAuHD1wg+/CAHBkumK9pNbS22NWLCr7qrEVN2A9D8F1oA6IQR3GU/QrE9Hk/Eia5dmb
        aTzRbTM7dObeUL4HhIhyBcu+pRQBVcQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C4EE13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eJK4N6zQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/13] btrfs: add a helper to queue a corrupted sector for read repair
Date:   Tue,  3 May 2022 14:49:50 +0800
Message-Id: <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
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

The new helper, read_repair_bio_add_sector(), will either:

- Add the sector range into btrfs_read_repair_ctrl::cur_bio
  If we have the bio allocated and the sector range is adjacent to the
  bio.

- Allocate a new btrfs_read_repair_bio and add the page sector range to
  it
  If we have btrfs_read_repair_ctrl::cur_bio, we will first submit it,
  then allocate a new one.

This patch will also introduce a new type of bioset specifically for
read repair, the reasons are:

- A lot of extra members in btrfs_bio makes no sense for read repair

- Possible mempool deadlock under heavy memory pressure.
  We may have exhausted the last btrfs_bio in the mempool, and we will
  fail to allocate a new btrfs_bio in our endio function.

  This problem is already there for a long time in the existing read
  repair code, in the endio function we're allocating new btrfs_bio for
  each corrupted sector, which is way worse.

Thus in this patch we introduce a new bioset specifically for read repair
usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/read-repair.c | 117 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h |  33 ++++++++++++
 fs/btrfs/super.c       |   9 +++-
 3 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index 048bb7c16c56..f75842dcdd02 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -5,6 +5,8 @@
 #include "volumes.h"
 #include "read-repair.h"
 
+static struct bio_set read_repair_bioset;
+
 int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
 				    struct btrfs_bio *bbio)
 {
@@ -52,6 +54,8 @@ void btrfs_read_repair_add_sector(struct inode *inode,
 		ASSERT(ctrl->init_mirror);
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
 						    sectorsize);
+		init_waitqueue_head(&ctrl->io_wait);
+		atomic_set(&ctrl->io_bytes, 0);
 		/*
 		 * We use btrfs_bio::read_repair_bitmaps, which should be
 		 * preallocated before submission.
@@ -74,6 +78,104 @@ void btrfs_read_repair_add_sector(struct inode *inode,
 		btrfs_bio(failed_bio)->read_repair_cur_bitmap);
 }
 
+static struct btrfs_read_repair_bio *repair_bio(struct bio *bio)
+{
+	return container_of(bio, struct btrfs_read_repair_bio, bio);
+}
+
+static void read_repair_end_bio(struct bio *bio)
+{
+	struct btrfs_read_repair_ctrl *ctrl = bio->bi_private;
+	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	const u64 logical = repair_bio(bio)->logical;
+	u32 offset = 0;
+	bool uptodate = (bio->bi_status == BLK_STS_OK);
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		unsigned long *bitmap =
+			btrfs_bio(ctrl->failed_bio)->read_repair_cur_bitmap;
+		/*
+		 * If we have a successful read, clear the error bit.
+		 * In read_repair_finish(), we will re-check the csum
+		 * (if exists) later.
+		 */
+		if (uptodate)
+			clear_bit((logical + offset - ctrl->logical) >>
+				fs_info->sectorsize_bits, bitmap);
+		offset += bvec->bv_len;
+	}
+	atomic_sub(offset, &ctrl->io_bytes);
+	wake_up(&ctrl->io_wait);
+	bio_put(bio);
+}
+
+/* Add a sector into the read repair bios list for later submission */
+static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
+				       struct page *page, unsigned int pgoff,
+				       int sector_nr, int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
+	struct btrfs_read_repair_bio *rbio;
+	struct bio *bio;
+	int ret;
+
+	/* Check if the sector can be added to the last bio */
+	if (ctrl->cur_bio) {
+		bio = ctrl->cur_bio;
+		rbio = repair_bio(bio);
+
+		ASSERT(rbio->logical);
+		if (rbio->logical + bio->bi_iter.bi_size ==
+		    ctrl->logical + (sector_nr << fs_info->sectorsize_bits))
+			goto add;
+
+		ASSERT(bio_op(bio) == REQ_OP_READ);
+		ASSERT(bio->bi_private == ctrl);
+		ASSERT(bio->bi_end_io == read_repair_end_bio);
+		ASSERT(repair_bio(bio)->logical >= ctrl->logical &&
+		       repair_bio(bio)->logical + bio->bi_iter.bi_size <=
+		       ctrl->logical + ctrl->bio_size);
+		/*
+		 * The current bio is not adjacent to the current range,
+		 * just submit it.
+		 *
+		 * Our endio is super atomic, and we don't want to waste time on
+		 * lookup data csum. So here we just call btrfs_map_bio()
+		 * directly.
+		 */
+		ret = btrfs_map_bio(fs_info, bio, mirror);
+		if (ret) {
+			bio->bi_status = ret;
+			bio_endio(bio);
+		}
+		ctrl->cur_bio = NULL;
+	}
+	ASSERT(ctrl->cur_bio == NULL);
+	bio = bio_alloc_bioset(NULL, BIO_MAX_VECS, 0, GFP_NOFS,
+			       &read_repair_bioset);
+	/* It's backed by mempool, thus should not fail */
+	ASSERT(bio);
+
+	rbio = repair_bio(bio);
+	rbio->logical = ctrl->logical + (sector_nr << fs_info->sectorsize_bits);
+	bio->bi_opf = REQ_OP_READ;
+	bio->bi_iter.bi_sector = rbio->logical >> SECTOR_SHIFT;
+	bio->bi_private = ctrl;
+	bio->bi_end_io = read_repair_end_bio;
+	ctrl->cur_bio = bio;
+
+add:
+	ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
+	/*
+	 * We allocated the read bio with enough bvecs to contain
+	 * the original bio, thus it should not fail to add a sector.
+	 */
+	ASSERT(ret == fs_info->sectorsize);
+	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
+}
+
 void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 {
 	if (!ctrl->failed_bio)
@@ -86,3 +188,18 @@ void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
 	ctrl->error = false;
 	ctrl->failed_bio = NULL;
 }
+
+void __cold btrfs_read_repair_exit(void)
+{
+	bioset_exit(&read_repair_bioset);
+}
+
+int __init btrfs_read_repair_init(void)
+{
+	int ret;
+
+	ret = bioset_init(&read_repair_bioset, BIO_POOL_SIZE,
+			  offsetof(struct btrfs_read_repair_bio, bio),
+			  BIOSET_NEED_BVECS);
+	return ret;
+}
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
index 42a251f1300b..3e1430489f89 100644
--- a/fs/btrfs/read-repair.h
+++ b/fs/btrfs/read-repair.h
@@ -14,6 +14,13 @@ struct btrfs_read_repair_ctrl {
 	/* The initial failed bio, we will grab page/pgoff from it */
 	struct bio *failed_bio;
 
+	/* Currently assembled bio for read/write */
+	struct bio *cur_bio;
+
+	wait_queue_head_t io_wait;
+
+	atomic_t io_bytes;
+
 	/* The logical bytenr of the original bio. */
 	u64 logical;
 
@@ -39,9 +46,35 @@ struct btrfs_read_repair_ctrl {
 
 int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
 				    struct btrfs_bio *bbio);
+
+/*
+ * Extra info for read repair bios.
+ *
+ * Read repair bios requires less info compared to btrfs_bio:
+ * - No need for csum
+ * - No need for mirror_num
+ * - No need for file_offset
+ *   They can all be fetched from the btrfs_read_repair_ctrl stored in
+ *   bi_private.
+ *
+ * - No need for iter
+ *   We use logical bytenr from btrfs_read_repair_bio::logical.
+ *   For bio iteration, our read repair bio will never cross stripe boundary,
+ *   thus we can use regular bio_for_each_segment_all().
+ *
+ * - No need for device
+ *   We just don't care at all.
+ */
+struct btrfs_read_repair_bio {
+	u64 logical;
+	struct bio bio;
+};
+
 void btrfs_read_repair_add_sector(struct inode *inode,
 				  struct btrfs_read_repair_ctrl *ctrl,
 				  struct bio *failed_bio, u32 bio_offset,
 				  u64 file_offset);
 void btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
+int __init btrfs_read_repair_init(void);
+void __cold btrfs_read_repair_exit(void);
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 206f44005c52..db476e675962 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -48,6 +48,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "qgroup.h"
+#include "read-repair.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
@@ -2642,10 +2643,12 @@ static int __init init_btrfs_fs(void)
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
@@ -2709,6 +2712,8 @@ static int __init init_btrfs_fs(void)
 	extent_map_exit();
 free_extent_state_cache:
 	extent_state_cache_exit();
+free_read_repair:
+	btrfs_read_repair_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
-- 
2.36.0

