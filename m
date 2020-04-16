Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1571AD22A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgDPVqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728502AbgDPVqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E66EC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y22so128978pll.4
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3okAhFxQRqXu9Xbi5lkgf8F20SY8dnh0Hv+G7Nc7qg=;
        b=GxdvYJ6MXkdjZPnvhbAEePNkb92RXnhHJ/557YokFEye3f0QKzJzxXKDp2d0OicFLE
         MXUgPcT0c5J5sC9HzYBkeURfoo1CUOo0/s9sQzD+DjFYl+cN+2OTj7VrHHBR6wKPgEjH
         Qo0AAcCruCJUJG8yGDA6FmUhdfaJI+8iXYsI4o9jgy04wnAu+QhCUoqu2CLLFWGfCx9H
         LGkDsblgZ5Sp1stbiUk+lAd4WA/sI+cfLqtvOvkk9YwAIxrUaF8IOmptzITgVhV2m4al
         BJxpxFqqgvGwh6yFBdJoc4VYfHmXLzJD/3h1I7SvLN2fhMveFvuw4swk2xo7QMhXEkUH
         /Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3okAhFxQRqXu9Xbi5lkgf8F20SY8dnh0Hv+G7Nc7qg=;
        b=ZQyhBdWET5+vf39IxeuAxXNEoaoDbh3FdEX0X1sPMnUP2A7k3Un+FL1uVQQ1z0+F9Z
         vg8GrdwvE5EnP8NPI8griNOdjnjELuj/wKOd1p9Mm3pF8NIK6IN7QnzXLc+XLM6iSjPY
         qDNxVAefXdR96UXoqDKk9yaEqKKrPpkRapZKET+77ErRra+XWrl6QFIMRx5A7AmuIzuD
         CW0MBssS6Va9tJVcqFTScP+ckXwHzVJ5SRg5V8ZpOelNTsf/jqLqgdj6thv0e9vWgrVW
         BojhvBebBgXIwyeVEqShFjMKhrhaYR1GzeMSMN0B8LlwP9pc4FqdqhqSeTO8dnsrrpcw
         +Lew==
X-Gm-Message-State: AGi0PuYVeYtMuA3z/2v1cC0EcxQyY6u7g8x2H/JFjrOlipBG8DE/+och
        +mjyqF4DAZv+4AB4K2PeLlk8SDCXH6U=
X-Google-Smtp-Source: APiQypL8/P8d9rM7VRBSOZ2vplvsX/Bn1ZmQgSVEQmhK0Eb+loUgtkD0NwlUFTfyzzt7uaz0bdFF5g==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id n11mr374330pjp.99.1587073607060;
        Thu, 16 Apr 2020 14:46:47 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:46 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/15] btrfs: get rid of one layer of bios in direct I/O
Date:   Thu, 16 Apr 2020 14:46:22 -0700
Message-Id: <bd8015bf0064f084c371ceee399383d791c807db.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/btrfs_inode.h |  16 ----
 fs/btrfs/inode.c       | 185 +++++++++++++++--------------------------
 2 files changed, 65 insertions(+), 136 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 94476a8be4cc..3fb2f5a11ee3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -294,11 +294,8 @@ static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	return ret;
 }
 
-#define BTRFS_DIO_ORIG_BIO_SUBMITTED	0x1
-
 struct btrfs_dio_private {
 	struct inode *inode;
-	unsigned long flags;
 	u64 logical_offset;
 	u64 disk_bytenr;
 	u64 bytes;
@@ -309,22 +306,9 @@ struct btrfs_dio_private {
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
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fe87c465b13c..79b884d2f3ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7356,6 +7356,29 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	return ret;
 }
 
+static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
+{
+	/*
+	 * This implies a barrier so that stores to dio_bio->bi_status before
+	 * this and loads of dio_bio->bi_status after this are fully ordered.
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
@@ -7678,8 +7701,9 @@ static blk_status_t __btrfs_subio_endio_read(struct inode *inode,
 	return err;
 }
 
-static blk_status_t btrfs_subio_endio_read(struct inode *inode,
-		struct btrfs_io_bio *io_bio, blk_status_t err)
+static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
+					     struct btrfs_io_bio *io_bio,
+					     blk_status_t err)
 {
 	bool skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
 
@@ -7693,28 +7717,6 @@ static blk_status_t btrfs_subio_endio_read(struct inode *inode,
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
@@ -7758,21 +7760,6 @@ static void __endio_write_update_ordered(struct inode *inode,
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
@@ -7796,31 +7783,16 @@ static void btrfs_end_dio_bio(struct bio *bio)
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
@@ -7883,7 +7855,6 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	size_t dip_size;
 	struct btrfs_dio_private *dip;
-	struct bio *bio;
 
 	dip_size = sizeof(*dip);
 	if (!write && csum) {
@@ -7899,15 +7870,10 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	if (!dip)
 		return NULL;
 
-	bio = btrfs_bio_clone(dio_bio);
-	bio->bi_private = dip;
-	btrfs_io_bio(bio)->logical = file_offset;
-
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
 	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
-	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
 	refcount_set(&dip->refs, 1);
 
@@ -7918,11 +7884,6 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 			dip->bytes;
 		dio_data->unsubmitted_oe_range_start =
 			dio_data->unsubmitted_oe_range_end;
-
-		bio->bi_end_io = btrfs_endio_direct_write;
-	} else {
-		bio->bi_end_io = btrfs_endio_direct_read;
-		dip->subio_endio = btrfs_subio_endio_read;
 	}
 	return dip;
 }
@@ -7933,9 +7894,10 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
+			     BTRFS_BLOCK_GROUP_RAID56_MASK);
 	struct btrfs_dio_private *dip;
 	struct bio *bio;
-	struct bio *orig_bio;
 	u64 start_sector;
 	int async_submit = 0;
 	u64 submit_len;
@@ -7967,89 +7929,72 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			goto out_err;
 	}
 
-	orig_bio = dip->orig_bio;
-	start_sector = orig_bio->bi_iter.bi_sector;
-	submit_len = orig_bio->bi_iter.bi_size;
-	ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
-				    start_sector << 9, submit_len, &geom);
-	if (ret)
-		goto out_err;
+	start_sector = dio_bio->bi_iter.bi_sector;
+	submit_len = dio_bio->bi_iter.bi_size;
 
-	if (geom.len >= submit_len) {
-		bio = orig_bio;
-		dip->flags |= BTRFS_DIO_ORIG_BIO_SUBMITTED;
-		goto submit;
-	}
-
-	/* async crcs make it difficult to collect full stripe writes. */
-	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
-		async_submit = 0;
-	else
-		async_submit = 1;
-
-	/* bio split */
-	ASSERT(geom.len <= INT_MAX);
 	do {
+		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
+					    start_sector << 9, submit_len,
+					    &geom);
+		if (ret) {
+			status = errno_to_blk_status(ret);
+			goto out_err;
+		}
+		ASSERT(geom.len <= INT_MAX);
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
+		if (submit_len > 0) {
+			refcount_inc(&dip->refs);
+			/*
+			 * If we are submitting more than one bio, submit them
+			 * all asynchronously. The exception is RAID 5 or 6, as
+			 * asynchronous checksums make it difficult to collect
+			 * full stripe writes.
+			 */
+			if (!raid56)
+				async_submit = 1;
+		}
 
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
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-- 
2.26.1

