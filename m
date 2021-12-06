Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353F6468F20
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhLFCdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhLFCd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62FC22113A
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+zGBM1gqHgKQWyoi24+8Uyk8gZMM2E7c/dXw8LXUTM=;
        b=qFdLUFbTpN3DOssj+L7CsfcJ753D6PLxkRA4prX+R3iIGO+55doBigEnXqNGsDrDSwHEe8
        SqWcj4YNdmA+6dRpp5e+iBop7bmTlWqE0m5b4YF0Tzkq2Jjzgac6PAWC3GpTypoM1haJL2
        EPs9ZezhTfCESzaufQTydJEQ68iFyrA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6FD113451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPIPIKd1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:29:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/17] btrfs: save bio::bi_iter into btrfs_bio::iter before any endio
Date:   Mon,  6 Dec 2021 10:29:22 +0800
Message-Id: <20211206022937.26465-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_bio::iter is only utilized by direct IO.

But later we will utilize btrfs_bio::iter to record the original
bi_iter, for all endio functions to iterate the original range.

Thus this patch will introduce a new helper, btrfs_bio_save_iter(), to
save bi_iter into btrfs_bio::iter.

All path that can lead to an bio_endio() call needs such
btrfs_bio_save_iter() call.

Under most common case, there will be a btrfs_map_bio() call to handle
submitted bios.

While for other error out paths, we need to call btrfs_bio_save_iter()
manually, or later endio functions will ASSERT() on empty
btrfs_bio::iter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  3 +++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/extent_io.c   |  7 +++++++
 fs/btrfs/raid56.c      |  2 ++
 fs/btrfs/volumes.c     |  1 +
 fs/btrfs/volumes.h     | 17 +++++++++++++++++
 6 files changed, 32 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e776956d5bc9..cc8d13369f53 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -870,6 +870,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
+	/* Save bi_iter so that end_bio_extent_readpage() won't freak out. */
+	btrfs_bio_save_iter(btrfs_bio(bio));
+
 	while (cur_disk_byte < disk_bytenr + compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..76b3fbcb91eb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -817,6 +817,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	/* If an error occurred we just want to clean up the bio and move on */
 	if (async->status) {
 		async->bio->bi_status = async->status;
+		btrfs_bio_save_iter(btrfs_bio(async->bio));
 		bio_endio(async->bio);
 		return;
 	}
@@ -949,6 +950,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 
 out_w_error:
 	bio->bi_status = ret;
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	bio_endio(bio);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a67f4b3986b..efd109caf95b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -175,6 +175,11 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
+	/*
+	 * This for later endio on errors, as later endio functions will rely
+	 * on btrfs_bio::iter.
+	 */
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	if (is_data_inode(tree->private_data))
 		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
@@ -192,6 +197,7 @@ static void end_write_bio(struct extent_page_data *epd, int ret)
 
 	if (bio) {
 		bio->bi_status = errno_to_blk_status(ret);
+		btrfs_bio_save_iter(btrfs_bio(bio));
 		bio_endio(bio);
 		epd->bio_ctrl.bio = NULL;
 	}
@@ -3355,6 +3361,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 error:
 	bio_ctrl->bio = NULL;
 	bio->bi_status = errno_to_blk_status(ret);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	bio_endio(bio);
 	return ret;
 }
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..13e726c88a81 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1731,6 +1731,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 		return PTR_ERR(rbio);
 	}
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 	rbio->operation = BTRFS_RBIO_WRITE;
 
@@ -2135,6 +2136,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f38c230111be..cdf5725f1f32 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6794,6 +6794,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	map_length = length;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
 	if (ret) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..c038fb1e36d5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -334,6 +334,12 @@ struct btrfs_bio {
 	struct btrfs_device *device;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+	/*
+	 * Saved bio::bi_iter before submission.
+	 *
+	 * This allows us to interate the cloned/split bio properly, as at
+	 * endio time bio::bi_iter is no longer reliable.
+	 */
 	struct bvec_iter iter;
 
 	/*
@@ -356,6 +362,17 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 	}
 }
 
+/*
+ * To save bbio::bio->bi_iter into bbio::iter so for callers who need the
+ * original bi_iter can access the original part of the bio.
+ * This is especially important for the incoming split btrfs_bio, which needs
+ * to call its endio for and only for the split range.
+ */
+static inline void btrfs_bio_save_iter(struct btrfs_bio *bbio)
+{
+	bbio->iter = bbio->bio.bi_iter;
+}
+
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	u64 physical;
-- 
2.34.1

