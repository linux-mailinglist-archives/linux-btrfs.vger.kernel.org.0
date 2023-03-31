Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F736D14E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCaBUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaBUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 21:20:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0602CDD1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 18:20:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 636A91FE33
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680225635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Yl8TKvauQNwCGQ8I4xWnrfQ9fyqWfJyJD/DHblGE7o=;
        b=FpkReN/v/ADrV5HGJaurgewN20J37YeV3yI3MX07DY7koKFsLE47PYUwGd/oMW/iGBTOqX
        kc2oJjJHOUG5pdvtB+HA5YJb5sJiCYhtUuu/IH7GFjDXytQrG3pc2nwU/6wVqJYoS58tBP
        iAx9v8zrKW1NGjdj/nrHsQ9PrwQKEUA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C611E13451
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aMfxJGI1JmSKWAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:20:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 02/12] btrfs: introduce btrfs_bio::fs_info member
Date:   Fri, 31 Mar 2023 09:20:05 +0800
Message-Id: <9a96394d97db24ad695b7f89f2d28563ea9d6313.1680225140.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680225140.git.wqu@suse.com>
References: <cover.1680225140.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we're doing a lot of work for btrfs_bio:

- Checksum verification for data read bios
- Bio splits if it crosses stripe boundary
- Read repair for data read bios

However for the incoming scrub patches, we don't want those extra
functionality at all, just pure logical + mirror -> physical mapping
ability.

Thus here we do the following changes:

- Introduce btrfs_bio::fs_info
  This is for the new scrub specific btrfs_bio, which would not
  populate btrfs_bio::inode.
  Thus we need such new member to grab a fs_info

  This new member would always be populated.

- Replace @inode argument with @fs_info for btrfs_bio_init() and its
  caller
  Since @inode is no longer a mandatory member, replace it with
  @fs_info, and let involved users populate @inode.

- Skip checksum verification and geneartion if @bbio->inode is NULL

- Add extra ASSERT()s
  To make sure:

  * bbio->inode is properly set for involved read repair path
  * if @file_offset is set, bbio->inode is also populated

- Grab @fs_info from @bbio directly
  We can no longer go @bbio->inode->root->fs_info, as bbio->inode can be
  NULL. This involves:

  * btrfs_simple_end_io()
  * should_async_write()
  * btrfs_wq_submit_bio()
  * btrfs_use_zone_append()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 42 +++++++++++++++++++++++++-----------------
 fs/btrfs/bio.h         | 12 +++++++++---
 fs/btrfs/compression.c |  3 ++-
 fs/btrfs/extent_io.c   |  3 ++-
 fs/btrfs/inode.c       | 13 +++++++++----
 fs/btrfs/zoned.c       |  4 ++--
 6 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edb..fb87f1c35e22 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -31,11 +31,11 @@ struct btrfs_failed_bio {
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
  */
-void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 		    btrfs_bio_end_io_t end_io, void *private)
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
-	bbio->inode = inode;
+	bbio->fs_info = fs_info;
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
@@ -49,7 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
  * a mempool.
  */
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-				  struct btrfs_inode *inode,
+				  struct btrfs_fs_info *fs_info,
 				  btrfs_bio_end_io_t end_io, void *private)
 {
 	struct btrfs_bio *bbio;
@@ -57,7 +57,7 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, inode, end_io, private);
+	btrfs_bio_init(bbio, fs_info, end_io, private);
 	return bbio;
 }
 
@@ -78,8 +78,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 				GFP_NOFS, &btrfs_clone_bioset);
 	}
 	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio, orig_bbio->inode, NULL, orig_bbio);
-
+	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
+	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
 	if (!(orig_bbio->bio.bi_opf & REQ_BTRFS_ONE_ORDERED))
 		orig_bbio->file_offset += map_length;
@@ -230,7 +230,8 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
 
 	repair_bbio = btrfs_bio(repair_bio);
-	btrfs_bio_init(repair_bbio, failed_bbio->inode, NULL, fbio);
+	btrfs_bio_init(repair_bbio, fs_info, NULL, fbio);
+	repair_bbio->inode = failed_bbio->inode;
 	repair_bbio->file_offset = failed_bbio->file_offset + bio_offset;
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
@@ -249,6 +250,9 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	struct btrfs_failed_bio *fbio = NULL;
 	u32 offset = 0;
 
+	/* Read-repair requires the inode field to be set by the submitter. */
+	ASSERT(inode);
+
 	/*
 	 * Hand off repair bios to the repair code as there is no upper level
 	 * submitter for them.
@@ -309,17 +313,17 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
 	/* Metadata reads are checked and repaired by the submitter. */
-	if (bbio->bio.bi_opf & REQ_META)
-		bbio->end_io(bbio);
-	else
+	if (bbio->inode && !(bbio->bio.bi_opf & REQ_META))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
+	else
+		bbio->end_io(bbio);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_device *dev = bio->bi_private;
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
@@ -343,7 +347,8 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
+	if (bio_op(bio) == REQ_OP_READ && bbio->inode &&
+	    !(bbio->bio.bi_opf & REQ_META))
 		btrfs_check_read_bio(bbio, NULL);
 	else
 		btrfs_orig_bbio_end_io(bbio);
@@ -565,7 +570,7 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	 * in order.
 	 */
 	if (bbio->bio.bi_opf & REQ_META) {
-		struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+		struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 		if (btrfs_is_zoned(fs_info))
 			return false;
@@ -585,7 +590,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_io_stripe *smap, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct async_submit_bio *async;
 
 	async = kmalloc(sizeof(*async), GFP_NOFS);
@@ -609,7 +614,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 {
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct btrfs_bio *orig_bbio = bbio;
 	struct bio *bio = &bbio->bio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
@@ -642,7 +647,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 * Save the iter for the end_io handler and preload the checksums for
 	 * data reads.
 	 */
-	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META)) {
+	if (bio_op(bio) == REQ_OP_READ && inode && !(bio->bi_opf & REQ_META)) {
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
@@ -662,7 +667,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		 * Csum items for reloc roots have already been cloned at this
 		 * point, so they are handled as part of the no-checksum case.
 		 */
-		if (!(inode->flags & BTRFS_INODE_NODATASUM) &&
+		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
 		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
 		    !btrfs_is_data_reloc_root(inode->root)) {
 			if (should_async_write(bbio) &&
@@ -691,6 +696,9 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 {
+	/* If bbio->inode is not populated, its file_offset must be 0. */
+	ASSERT(bbio->inode || bbio->file_offset == 0);
+
 	while (!btrfs_submit_chunk(bbio, mirror_num))
 		;
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dbf125f6fa33..e54eaee81f8f 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -30,7 +30,10 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
-	/* Inode and offset into it that this I/O operates on. */
+	/*
+	 * Inode and offset into it that this I/O operates on.
+	 * Only set for data I/O.
+	 */
 	struct btrfs_inode *inode;
 	u64 file_offset;
 
@@ -58,6 +61,9 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
+	/* File system that this I/O operates on. */
+	struct btrfs_fs_info *fs_info;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
@@ -73,10 +79,10 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 int __init btrfs_bioset_init(void);
 void __cold btrfs_bioset_exit(void);
 
-void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
+void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 		    btrfs_bio_end_io_t end_io, void *private);
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-				  struct btrfs_inode *inode,
+				  struct btrfs_fs_info *fs_info,
 				  btrfs_bio_end_io_t end_io, void *private);
 
 static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 44c4276741ce..50183e599213 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -69,7 +69,8 @@ static struct compressed_bio *alloc_compressed_bio(struct btrfs_inode *inode,
 
 	bbio = btrfs_bio(bio_alloc_bioset(NULL, BTRFS_MAX_COMPRESSED_PAGES, op,
 					  GFP_NOFS, &btrfs_compressed_bioset));
-	btrfs_bio_init(bbio, inode, end_io, NULL);
+	btrfs_bio_init(bbio, inode->root->fs_info, end_io, NULL);
+	bbio->inode = inode;
 	bbio->file_offset = start;
 	return to_compressed_bio(bbio);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1221f699ffc5..9ee39c588125 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -898,9 +898,10 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *bbio;
 
-	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, fs_info,
 			       bio_ctrl->end_io_func, NULL);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	bbio->inode = inode;
 	bbio->file_offset = file_offset;
 	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 76d93b9e94a9..da540fd5b4b7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7754,7 +7754,9 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
 
-	btrfs_bio_init(bbio, BTRFS_I(iter->inode), btrfs_dio_end_io, bio->bi_private);
+	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
+		       btrfs_dio_end_io, bio->bi_private);
+	bbio->inode = BTRFS_I(iter->inode);
 	bbio->file_offset = file_offset;
 
 	dip->file_offset = file_offset;
@@ -9924,6 +9926,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.pending = ATOMIC_INIT(1),
 	};
@@ -9932,9 +9935,10 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 	init_waitqueue_head(&priv.wait);
 
-	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
-			      btrfs_encoded_read_endio, &priv);
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
+			       btrfs_encoded_read_endio, &priv);
 	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	bbio->inode = inode;
 
 	do {
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
@@ -9943,9 +9947,10 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			atomic_inc(&priv.pending);
 			btrfs_submit_bio(bbio, 0);
 
-			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
+			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
 					       btrfs_encoded_read_endio, &priv);
 			bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+			bbio->inode = inode;
 			continue;
 		}
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 45d04092f2f8..a9b32ba6b2ce 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1640,14 +1640,14 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
 	u64 start = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct btrfs_block_group *cache;
 	bool ret = false;
 
 	if (!btrfs_is_zoned(fs_info))
 		return false;
 
-	if (!is_data_inode(&inode->vfs_inode))
+	if (!inode || !is_data_inode(&inode->vfs_inode))
 		return false;
 
 	if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE)
-- 
2.39.2

