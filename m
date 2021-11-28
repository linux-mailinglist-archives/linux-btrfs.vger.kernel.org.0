Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3564604D3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhK1F6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhK1F4r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54FF61FD45;
        Sun, 28 Nov 2021 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hb8NPmLXUMyExLegY106tgMVQ5lBVGfGfpKn8sWn6Dg=;
        b=B94DEOVOnwR7DaAclG8BlMzOYOhVTblNd3tH9dTx8OJGcZmeTV8FOFdLI+Dlqw/7pE2kkM
        /KjQG5DXoG7S94tPsf/dmkF7msB4TlbBVCgSkmbYK9DtRNIaaRLRI5vnJ+/w+Jl+MljLH4
        pSizTfCGRt3jhvtN4+FBSinm/sJLG30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F2DA13446;
        Sun, 28 Nov 2021 05:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONQeDFoZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 09/11] btrfs: remove bio split operations in btrfs_submit_direct()
Date:   Sun, 28 Nov 2021 13:52:57 +0800
Message-Id: <20211128055259.39249-10-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since btrfs_map_bio() will handle the split, there is no need to do the
split in btrfs_submit_direct() anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 116 +++++++++--------------------------------------
 1 file changed, 22 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1bf56c2b4bd9..24c8bb6d8543 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8202,22 +8202,16 @@ static void btrfs_end_dio_bio(struct bio *bio)
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
@@ -8291,20 +8285,9 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 {
 	struct inode *inode = iter->inode;
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
-			     BTRFS_BLOCK_GROUP_RAID56_MASK);
 	struct btrfs_dio_private *dip;
 	struct bio *bio;
-	u64 start_sector;
-	int async_submit = 0;
-	u64 submit_len;
-	u64 clone_offset = 0;
-	u64 clone_len;
-	u64 logical;
-	int ret;
 	blk_status_t status;
-	struct btrfs_io_geometry geom;
 	struct btrfs_dio_data *dio_data = iter->iomap.private;
 	struct extent_map *em = NULL;
 
@@ -8331,84 +8314,29 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
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
-
-		/*
-		 * Increase the count before we submit the bio so we know
-		 * the end IO handler won't happen before we increase the
-		 * count. Otherwise, the dip might get freed before we're
-		 * done setting it up.
-		 *
-		 * We transfer the initial reference to the last bio, so we
-		 * don't need to increment the reference count for the last one.
-		 */
-		if (submit_len > 0) {
-			refcount_inc(&dip->refs);
-			/*
-			 * If we are submitting more than one bio, submit them
-			 * all asynchronously. The exception is RAID 5 or 6, as
-			 * asynchronous checksums make it difficult to collect
-			 * full stripe writes.
-			 */
-			if (!raid56)
-				async_submit = 1;
-		}
+	/*
+	 * This will never fail as it's passing GPF_NOFS and
+	 * the allocation is backed by btrfs_bioset.
+	 */
+	bio = btrfs_bio_clone(dio_bio);
+	bio->bi_private = dip;
+	bio->bi_end_io = btrfs_end_dio_bio;
 
-		status = btrfs_submit_dio_bio(bio, inode, file_offset,
-						async_submit);
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		status = extract_ordered_extent(BTRFS_I(inode), bio,
+						file_offset);
 		if (status) {
 			bio_put(bio);
-			if (submit_len > 0)
-				refcount_dec(&dip->refs);
-			goto out_err_em;
+			goto out_err;
 		}
+	}
 
-		dio_data->submitted += clone_len;
-		clone_offset += clone_len;
-		start_sector += clone_len >> 9;
-		file_offset += clone_len;
-
-		free_extent_map(em);
-	} while (submit_len > 0);
+	status = btrfs_submit_dio_bio(bio, inode, file_offset);
+	if (status) {
+		bio_put(bio);
+		goto out_err_em;
+	}
+	dio_data->submitted += dio_bio->bi_iter.bi_size;
 	return;
 
 out_err_em:
-- 
2.34.0

