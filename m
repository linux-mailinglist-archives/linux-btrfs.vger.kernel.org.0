Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06E9468F2E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhLFCdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhLFCdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54FDB1FD5F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtXkiQjVq07s6cIpFoM/BWXTJJ8eZBowQdaODkesbCA=;
        b=tqku+oL9slTxuR+IEmACkyfK6N5gw/ynoyEhnDg+v8L/bc/XzY5asKyGnv7848n866pzTN
        sFIjUqFj0+O1VA7Efx1jCD9pOweuSxT4b8/OExhZa0maQ+fUw7pKolAnOYdhs/KO7ib8nT
        p7yJ+6I6SFWBF7dwl9rATpy0rJCpKZ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8DCB13451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAqHHLd1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/17] btrfs: remove the stripe boundary calculation for direct IO
Date:   Mon,  6 Dec 2021 10:29:36 +0800
Message-Id: <20211206022937.26465-17-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_submit_direct() we have a do {} while () loop to handle the bio
split due to stripe boundary.

Since btrfs_map_bio() can handle it for us now, there is no need to
manually do the split anymore.

Also since we don't need to split bio, there is no special check for
RAID56 anymore, make btrfs_submit_dio_bio() to have the same rule as
btrfs_submit_data_bio() for async submit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 113 ++++++++++-------------------------------------
 1 file changed, 24 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 186304c69900..8ffec0fe6c4e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8222,22 +8222,16 @@ static void btrfs_end_dio_bio(struct bio *bio)
 }
 
 static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
-		struct inode *inode, u64 file_offset, int async_submit)
+		struct inode *inode, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
 	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
+	bool async_submit;
 	blk_status_t ret;
 
-	/*
-	 * Check btrfs_submit_data_bio() for rules about async submit.
-	 *
-	 * The only exception is for RAID56, when there are more than one bios
-	 * to submit, async submit seems to make it harder to collect csums
-	 * for the full stripe.
-	 */
-	if (async_submit)
-		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
+	/* Check btrfs_submit_data_bio() for rules about async submit. */
+	async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
 	if (!write)
 		btrfs_bio(bio)->endio_type = BTRFS_WQ_ENDIO_DATA;
@@ -8311,25 +8305,12 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	struct inode *inode = iter->inode;
+	struct btrfs_dio_data *dio_data = iter->iomap.private;
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
-			     BTRFS_BLOCK_GROUP_RAID56_MASK);
 	struct btrfs_dio_private *dip;
 	struct bio *bio;
 	const u32 length = dio_bio->bi_iter.bi_size;
-	u32 submitted_bytes = 0;
-	u64 start_sector;
-	int async_submit = 0;
-	u64 submit_len;
-	u64 clone_offset = 0;
-	u64 clone_len;
-	u64 logical;
-	int ret;
 	blk_status_t status;
-	struct btrfs_io_geometry geom;
-	struct btrfs_dio_data *dio_data = iter->iomap.private;
-	struct extent_map *em = NULL;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset, length);
 	if (!dip) {
@@ -8353,80 +8334,34 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 			goto out_err;
 	}
 
-	start_sector = dio_bio->bi_iter.bi_sector;
-	submit_len = dio_bio->bi_iter.bi_size;
-
-	do {
-		logical = start_sector << 9;
-		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
-		if (IS_ERR(em)) {
-			status = errno_to_blk_status(PTR_ERR(em));
-			em = NULL;
-			goto out_err_em;
-		}
-		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
-					    logical, &geom);
-		if (ret) {
-			status = errno_to_blk_status(ret);
-			goto out_err_em;
-		}
-
-		clone_len = min(submit_len, geom.len);
-		ASSERT(clone_len <= UINT_MAX);
-
-		/*
-		 * This will never fail as it's passing GPF_NOFS and
-		 * the allocation is backed by btrfs_bioset.
-		 */
-		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
-		bio->bi_private = dip;
-		bio->bi_end_io = btrfs_end_dio_bio;
-
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			status = extract_ordered_extent(BTRFS_I(inode), bio,
-							file_offset);
-			if (status) {
-				bio_put(bio);
-				goto out_err;
-			}
-		}
-
-		ASSERT(submit_len >= clone_len);
-		submit_len -= clone_len;
+	/*
+	 * This will never fail as it's passing GPF_NOFS and
+	 * the allocation is backed by btrfs_bioset.
+	 */
+	bio = btrfs_bio_clone(dio_bio);
+	bio->bi_private = dip;
+	bio->bi_end_io = btrfs_end_dio_bio;
 
-		if (submit_len > 0) {
-			/*
-			 * If we are submitting more than one bio, submit them
-			 * all asynchronously. The exception is RAID 5 or 6, as
-			 * asynchronous checksums make it difficult to collect
-			 * full stripe writes.
-			 */
-			if (!raid56)
-				async_submit = 1;
-		}
 
-		status = btrfs_submit_dio_bio(bio, inode, file_offset,
-						async_submit);
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		status = extract_ordered_extent(BTRFS_I(inode), bio,
+						file_offset);
 		if (status) {
 			bio_put(bio);
-			goto out_err_em;
+			goto out_err;
 		}
-
-		submitted_bytes += clone_len;
-		dio_data->submitted += clone_len;
-		clone_offset += clone_len;
-		start_sector += clone_len >> 9;
-		file_offset += clone_len;
-
-		free_extent_map(em);
-	} while (submit_len > 0);
+	}
+	status = btrfs_submit_dio_bio(bio, inode, file_offset);
+	if (status) {
+		bio_put(bio);
+		goto out_err;
+	}
+	dio_data->submitted += length;
 	return;
 
-out_err_em:
-	free_extent_map(em);
 out_err:
 	dip->dio_bio->bi_status = status;
-	dio_private_finish(dip, status, length - submitted_bytes);
+	dio_private_finish(dip, status, length);
 }
 
 const struct iomap_ops btrfs_dio_iomap_ops = {
-- 
2.34.1

