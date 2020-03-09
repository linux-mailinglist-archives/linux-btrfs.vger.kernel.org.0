Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE34C17EB43
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCIVdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCIVdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 2so5412871pfg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kY5d0Vy2decVSrxj3t+VpyDeiZStYIOSlicK34Gnp4I=;
        b=BTe/611gO3is1U2gJgHze1PZow8ZLyt44eOrxGwmF7orfQLZMhjWQni1QxnC0fT0KV
         JDzvzZ+ZjQC/H1mP8ZF3NnWxnyMBcZ38qv0QtZvhYZszewK1Q+WkWWXihaeP55UDvosO
         I9OKWTcSydXxor+MlmI9fzsUjM1BBzlVMmVEIvlfZ+Hod8PHOe6yMoSSwv1sSXooDSYi
         oKr4zoBjEwzQgxIhE5cp9y1M3ZBHY8bCBY1ku0Q7bzlob05lBTSbuy2Cbvqum+IcpmNS
         tU3og7mCx+ArBMuIAa4YbWuwg2gXZ8fFcr9NTMjADvtCld1BAkM7YPghnCkj7TnUEVWU
         cClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kY5d0Vy2decVSrxj3t+VpyDeiZStYIOSlicK34Gnp4I=;
        b=Re/es4RPySQXaCERO3jQjcRZiJ0GGICiQt4GpDBw3qAUwg8Lx84tuFIXv7+tyMMnIm
         uFNln8r93ChPY5r/8fIicakCUwHtykUyo/xJnJ0qBm7O8CsO0rhlVlfGCEogQAg/mF03
         X+3X4MkGea7m8BWczaZH3cyNmmshOCr4H2dIXlKqxJwkjWUd8Xq4KgXwl7LzkNqGpWZY
         4UxLzShtt7agqZ+K6e0zzEqnAnC3aR1eHmAWXEzOECFnhwdAgnfH+tfzSR7vGScAKVFx
         yjQUtAbNVLeY25eG5mrv/KXO0BiiASEZ0HbgZDRc9I8VTxkEojTtHwOOr9Um91z+uFZT
         4g+g==
X-Gm-Message-State: ANhLgQ0pq+PLR4BXDiTfNo+7/JtoLX1z9XaqlzzdeQeRbVYz1PX8igkw
        /uTD75MqsfzLXoo/sfE5GH+LhYQKCdg=
X-Google-Smtp-Source: ADFU+vtaNrJL1vJLZFCCeiDoI9x8i3z425WM/AxpZCx6g0gvap9IGxKbeA71tKemKksNm0UQyBSKug==
X-Received: by 2002:a62:6807:: with SMTP id d7mr17645546pfc.230.1583789588557;
        Mon, 09 Mar 2020 14:33:08 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:08 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
Date:   Mon,  9 Mar 2020 14:32:38 -0700
Message-Id: <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In the worst case, there are _4_ layers of bios in the Btrfs direct I/O
path:

1. The bio created by the generic direct I/O code (dio_bio).
2. A clone of dio_bio we create in btrfs_submit_direct() to represent
   the entire direct I/O range (orig_bio).
3. A partial clone of orig_bio limited to the size of a RAID stripe that
   we create in btrfs_submit_direct_hook().
4. Clones of each of those split bios for each RAID stripe that we
   create in btrfs_map_bio().

As of the previous commit, the second layer (orig_bio) is no longer
needed for anything: we can split dio_bio instead, and complete dio_bio
directly when all of the cloned bios complete. This lets us clean up a
bunch of cruft, including dip->subio_endio and dip->errors (we can use
dio_bio->bi_status instead). It also enables the next big cleanup of
direct I/O read repair.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 213 +++++++++++++++--------------------------------
 1 file changed, 66 insertions(+), 147 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4a2e44f3e66e..40c1562704e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -54,11 +54,8 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
-#define BTRFS_DIO_ORIG_BIO_SUBMITTED	0x1
-
 struct btrfs_dio_private {
 	struct inode *inode;
-	unsigned long flags;
 	u64 logical_offset;
 	u64 disk_bytenr;
 	u64 bytes;
@@ -69,22 +66,9 @@ struct btrfs_dio_private {
 	 */
 	refcount_t refs;
 
-	/* IO errors */
-	int errors;
-
-	/* orig_bio is our btrfs_io_bio */
-	struct bio *orig_bio;
-
 	/* dio_bio came from fs/direct-io.c */
 	struct bio *dio_bio;
 
-	/*
-	 * The original bio may be split to several sub-bios, this is
-	 * done during endio of sub-bios
-	 */
-	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
-			blk_status_t);
-
 	/* Checksums. */
 	u8 sums[];
 };
@@ -7400,6 +7384,29 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	return ret;
 }
 
+static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
+{
+	/*
+	 * This implies a barrier so that stores to dio_bio->bi_status before
+	 * this and the following load are fully ordered.
+	 */
+	if (!refcount_dec_and_test(&dip->refs))
+		return;
+
+	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
+		__endio_write_update_ordered(dip->inode, dip->logical_offset,
+					     dip->bytes,
+					     !dip->dio_bio->bi_status);
+	} else {
+		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
+			      dip->logical_offset,
+			      dip->logical_offset + dip->bytes - 1);
+	}
+
+	dio_end_io(dip->dio_bio);
+	kfree(dip);
+}
+
 static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 						 struct bio *bio,
 						 int mirror_num)
@@ -7722,8 +7729,9 @@ static blk_status_t __btrfs_subio_endio_read(struct inode *inode,
 	return err;
 }
 
-static blk_status_t btrfs_subio_endio_read(struct inode *inode,
-		struct btrfs_io_bio *io_bio, blk_status_t err)
+static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
+					     struct btrfs_io_bio *io_bio,
+					     blk_status_t err)
 {
 	bool skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
 
@@ -7737,28 +7745,6 @@ static blk_status_t btrfs_subio_endio_read(struct inode *inode,
 	}
 }
 
-static void btrfs_endio_direct_read(struct bio *bio)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct inode *inode = dip->inode;
-	struct bio *dio_bio;
-	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
-	blk_status_t err = bio->bi_status;
-
-	if (dip->flags & BTRFS_DIO_ORIG_BIO_SUBMITTED)
-		err = btrfs_subio_endio_read(inode, io_bio, err);
-
-	unlock_extent(&BTRFS_I(inode)->io_tree, dip->logical_offset,
-		      dip->logical_offset + dip->bytes - 1);
-	dio_bio = dip->dio_bio;
-
-	kfree(dip);
-
-	dio_bio->bi_status = err;
-	dio_end_io(dio_bio);
-	bio_put(bio);
-}
-
 static void __endio_write_update_ordered(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
@@ -7802,21 +7788,6 @@ static void __endio_write_update_ordered(struct inode *inode,
 	}
 }
 
-static void btrfs_endio_direct_write(struct bio *bio)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct bio *dio_bio = dip->dio_bio;
-
-	__endio_write_update_ordered(dip->inode, dip->logical_offset,
-				     dip->bytes, !bio->bi_status);
-
-	kfree(dip);
-
-	dio_bio->bi_status = bio->bi_status;
-	dio_end_io(dio_bio);
-	bio_put(bio);
-}
-
 static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 				    struct bio *bio, u64 offset)
 {
@@ -7840,31 +7811,16 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   (unsigned long long)bio->bi_iter.bi_sector,
 			   bio->bi_iter.bi_size, err);
 
-	if (dip->subio_endio)
-		err = dip->subio_endio(dip->inode, btrfs_io_bio(bio), err);
-
-	if (err) {
-		/*
-		 * We want to perceive the errors flag being set before
-		 * decrementing the reference count. We don't need a barrier
-		 * since atomic operations with a return value are fully
-		 * ordered as per atomic_t.txt
-		 */
-		dip->errors = 1;
+	if (bio_op(bio) == REQ_OP_READ) {
+		err = btrfs_check_read_dio_bio(dip->inode, btrfs_io_bio(bio),
+					       err);
 	}
 
-	/* if there are more bios still pending for this dio, just exit */
-	if (!refcount_dec_and_test(&dip->refs))
-		goto out;
+	if (err)
+		dip->dio_bio->bi_status = err;
 
-	if (dip->errors) {
-		bio_io_error(dip->orig_bio);
-	} else {
-		dip->dio_bio->bi_status = BLK_STS_OK;
-		bio_endio(dip->orig_bio);
-	}
-out:
 	bio_put(bio);
+	btrfs_dio_private_put(dip);
 }
 
 static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
@@ -7920,98 +7876,77 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio *bio;
-	struct bio *orig_bio = dip->orig_bio;
-	u64 start_sector = orig_bio->bi_iter.bi_sector;
+	struct bio *dio_bio = dip->dio_bio;
+	u64 start_sector = dio_bio->bi_iter.bi_sector;
 	u64 file_offset = dip->logical_offset;
 	int async_submit = 0;
-	u64 submit_len;
+	u64 submit_len = dio_bio->bi_iter.bi_size;
 	int clone_offset = 0;
 	int clone_len;
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
 
-	submit_len = orig_bio->bi_iter.bi_size;
-	ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
-				    start_sector << 9, submit_len, &geom);
-	if (ret)
-		goto out_err;
-
-	if (geom.len >= submit_len) {
-		bio = orig_bio;
-		dip->flags |= BTRFS_DIO_ORIG_BIO_SUBMITTED;
-		goto submit;
-	}
-
 	/* async crcs make it difficult to collect full stripe writes. */
 	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		async_submit = 0;
 	else
 		async_submit = 1;
 
-	/* bio split */
 	ASSERT(geom.len <= INT_MAX);
 	do {
+		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
+					    start_sector << 9, submit_len,
+					    &geom);
+		if (ret) {
+			status = errno_to_blk_status(ret);
+			goto out_err;
+		}
+
 		clone_len = min_t(int, submit_len, geom.len);
 
 		/*
 		 * This will never fail as it's passing GPF_NOFS and
 		 * the allocation is backed by btrfs_bioset.
 		 */
-		bio = btrfs_bio_clone_partial(orig_bio, clone_offset,
-					      clone_len);
+		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
-		if (submit_len == 0)
-			break;
 
 		/*
 		 * Increase the count before we submit the bio so we know
 		 * the end IO handler won't happen before we increase the
 		 * count. Otherwise, the dip might get freed before we're
 		 * done setting it up.
+		 *
+		 * We transfer the initial reference to the last bio, so we
+		 * don't need to increment the reference count for the last one.
 		 */
-		refcount_inc(&dip->refs);
+		if (submit_len > 0)
+			refcount_inc(&dip->refs);
 
 		status = btrfs_submit_dio_bio(bio, inode, file_offset,
 						async_submit);
 		if (status) {
 			bio_put(bio);
-			refcount_dec(&dip->refs);
+			if (submit_len > 0)
+				refcount_dec(&dip->refs);
 			goto out_err;
 		}
 
 		clone_offset += clone_len;
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
-
-		ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
-				      start_sector << 9, submit_len, &geom);
-		if (ret)
-			goto out_err;
 	} while (submit_len > 0);
+	return;
 
-submit:
-	status = btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
-	if (!status)
-		return;
-
-	if (bio != orig_bio)
-		bio_put(bio);
 out_err:
-	dip->errors = 1;
-	/*
-	 * Before atomic variable goto zero, we must  make sure dip->errors is
-	 * perceived to be set. This ordering is ensured by the fact that an
-	 * atomic operations with a return value are fully ordered as per
-	 * atomic_t.txt
-	 */
-	if (refcount_dec_and_test(&dip->refs))
-		bio_io_error(dip->orig_bio);
+	dip->dio_bio->bi_status = status;
+	btrfs_dio_private_put(dip);
 }
 
 static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
@@ -8019,13 +7954,9 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 {
 	struct btrfs_dio_private *dip = NULL;
 	size_t dip_size;
-	struct bio *bio = NULL;
-	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 
-	bio = btrfs_bio_clone(dio_bio);
-
 	dip_size = sizeof(*dip);
 	if (!write && csum) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -8049,7 +7980,6 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		 * bio_endio()/bio_io_error() against dio_bio.
 		 */
 		dio_end_io(dio_bio);
-		bio_put(bio);
 		return;
 	}
 
@@ -8057,12 +7987,8 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
 	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
-	bio->bi_private = dip;
-	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
 	refcount_set(&dip->refs, 1);
-	io_bio = btrfs_io_bio(bio);
-	io_bio->logical = file_offset;
 
 	if (write) {
 		/*
@@ -8076,26 +8002,19 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			dip->bytes;
 		dio_data->unsubmitted_oe_range_start =
 			dio_data->unsubmitted_oe_range_end;
-		bio->bi_end_io = btrfs_endio_direct_write;
-	} else {
-		bio->bi_end_io = btrfs_endio_direct_read;
-		dip->subio_endio = btrfs_subio_endio_read;
+	} else if (csum) {
+		blk_status_t status;
 
-		if (csum) {
-			blk_status_t status;
-
-			/*
-			 * Load the csums up front to reduce csum tree searches
-			 * and contention when submitting bios.
-			 */
-			status = btrfs_lookup_bio_sums(inode, dio_bio,
-						       file_offset, dip->sums);
-			if (status != BLK_STS_OK) {
-				dip->errors = 1;
-				if (refcount_dec_and_test(&dip->refs))
-					bio_io_error(dip->orig_bio);
-				return;
-			}
+		/*
+		 * Load the csums up front to reduce csum tree searches and
+		 * contention when submitting bios.
+		 */
+		status = btrfs_lookup_bio_sums(inode, dio_bio, file_offset,
+					       dip->sums);
+		if (status != BLK_STS_OK) {
+			dip->dio_bio->bi_status = status;
+			btrfs_dio_private_put(dip);
+			return;
 		}
 	}
 
-- 
2.25.1

