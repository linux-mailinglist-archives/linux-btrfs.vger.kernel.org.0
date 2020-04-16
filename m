Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4D1AD221
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgDPVqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728432AbgDPVqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F14C061A0F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ng8so134138pjb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79OcIzy+6HmtVaphSQyJYy+wHlPhCxgL24bRSUnXELA=;
        b=uQK186ASynPJVw5oZ0lTcr/ni4fFWJowDoY881ZtDevq4A7HMcmjPsN4AGrQfvqz9N
         +qqzH7CmxLpQ9ifyB1LaHNJpR+eutLjSvy8Rsd4v/go6JARh2LwzBMBIe1cyIG1EdYUL
         4+kT/96JmiYPkwfkPraxjj+YDotI8GH4me+yClt4b6mVgQ+l5qnmPbdoE3B0ZrQGoFA4
         pD0uNfqu8eX4hlkRG3bC0K/KyT3/KlGXqWFb3+Nb5PfWBOP6KJMgqdCR7LHmvtR46Mt2
         SRjFj4+P22zrBH0jrylOBljp+2nvUWDb2St7BZR8WVk1kjeDc4TUGqyvHEW5+ps8dnW5
         vnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79OcIzy+6HmtVaphSQyJYy+wHlPhCxgL24bRSUnXELA=;
        b=k6mMKm76eOw8bis2XgTl7btUqWt/Qq7Ql/AetoMQazE/7ad5uejUswBfdLiVwdOHkE
         FWRNUfnmQ7zlS306zQ4iBDODop24fY1lXUzLu5vLRQIqegV2cxEhZ5WK6wGBHt4caOwm
         DCUgKT91WLz0ZyKCclu/DudJ0eceT3T7jl77NHF1K7qkXlRPJz+e0K7DWNoPVQWoleYw
         da7VRa+3CTIm5qJHJ1kavqo/P905H4y5nZCk85htgkvb4APt1a+BvDJ1XEVZxWmdVrn4
         x79yTTOhx4mi37133sfG2VOkUFVKcRfhWgFeB+iPkj05OtbIypqu1qkRfqFKNe5gWneJ
         kaBg==
X-Gm-Message-State: AGi0PuaxT+lPbsRpolLXFUxvAGbQYbt0z7RfIaQsuNaMyjCWrOhvblul
        5bb2xW69loF/yYax5uVNgZQHebl0nS0=
X-Google-Smtp-Source: APiQypLkMsXR3cj3lu5+np8hu2Zqy1QjOz7aqEmFLMXTm63/EeYr99FsmsB5R6U40JB6YekK+kpHow==
X-Received: by 2002:a17:902:b783:: with SMTP id e3mr267722pls.217.1587073596935;
        Thu, 16 Apr 2020 14:46:36 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:36 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/15] btrfs: fix double __endio_write_update_ordered in direct I/O
Date:   Thu, 16 Apr 2020 14:46:13 -0700
Message-Id: <594c8cb6dd64cebdf5e01016ce823e1be00fc7ab.1587072977.git.osandov@fb.com>
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

In btrfs_submit_direct(), if we fail to allocate the btrfs_dio_private,
we complete the ordered extent range. However, we don't mark that the
range doesn't need to be cleaned up from btrfs_direct_IO() until later.
Therefore, if we fail to allocate the btrfs_dio_private, we complete the
ordered extent range twice. We could fix this by updating
unsubmitted_oe_range earlier, but it's cleaner to reorganize the code so
that creating the btrfs_dio_private and submitting the bios are
separate, and once the btrfs_dio_private is created, cleanup always
happens through the btrfs_dio_private.

Fixes: f28a49287817 ("Btrfs: fix leaking of ordered extents after direct IO write error")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 174 ++++++++++++++++++-----------------------------
 1 file changed, 66 insertions(+), 108 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b628c319a5b6..f6ce9749adb6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7903,14 +7903,60 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	return ret;
 }
 
-static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
+/*
+ * If this succeeds, the btrfs_dio_private is responsible for cleaning up locked
+ * or ordered extents whether or not we submit any bios.
+ */
+static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
+							  struct inode *inode,
+							  loff_t file_offset)
 {
-	struct inode *inode = dip->inode;
+	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	struct btrfs_dio_private *dip;
+	struct bio *bio;
+
+	dip = kzalloc(sizeof(*dip), GFP_NOFS);
+	if (!dip)
+		return NULL;
+
+	bio = btrfs_bio_clone(dio_bio);
+	bio->bi_private = dip;
+	btrfs_io_bio(bio)->logical = file_offset;
+
+	dip->private = dio_bio->bi_private;
+	dip->inode = inode;
+	dip->logical_offset = file_offset;
+	dip->bytes = dio_bio->bi_iter.bi_size;
+	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
+	dip->orig_bio = bio;
+	dip->dio_bio = dio_bio;
+	atomic_set(&dip->pending_bios, 1);
+
+	if (write) {
+		struct btrfs_dio_data *dio_data = current->journal_info;
+
+		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
+			dip->bytes;
+		dio_data->unsubmitted_oe_range_start =
+			dio_data->unsubmitted_oe_range_end;
+
+		bio->bi_end_io = btrfs_endio_direct_write;
+	} else {
+		bio->bi_end_io = btrfs_endio_direct_read;
+		dip->subio_endio = btrfs_subio_endio_read;
+	}
+	return dip;
+}
+
+static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
+				loff_t file_offset)
+{
+	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_dio_private *dip;
 	struct bio *bio;
-	struct bio *orig_bio = dip->orig_bio;
-	u64 start_sector = orig_bio->bi_iter.bi_sector;
-	u64 file_offset = dip->logical_offset;
+	struct bio *orig_bio;
+	u64 start_sector;
 	int async_submit = 0;
 	u64 submit_len;
 	int clone_offset = 0;
@@ -7919,11 +7965,24 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
 
+	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
+	if (!dip) {
+		if (!write) {
+			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
+				file_offset + dio_bio->bi_iter.bi_size - 1);
+		}
+		dio_bio->bi_status = BLK_STS_RESOURCE;
+		dio_end_io(dio_bio);
+		return;
+	}
+
+	orig_bio = dip->orig_bio;
+	start_sector = orig_bio->bi_iter.bi_sector;
 	submit_len = orig_bio->bi_iter.bi_size;
 	ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
 				    start_sector << 9, submit_len, &geom);
 	if (ret)
-		return -EIO;
+		goto out_err;
 
 	if (geom.len >= submit_len) {
 		bio = orig_bio;
@@ -7986,7 +8045,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 submit:
 	status = btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
 	if (!status)
-		return 0;
+		return;
 
 	if (bio != orig_bio)
 		bio_put(bio);
@@ -8000,107 +8059,6 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	 */
 	if (atomic_dec_and_test(&dip->pending_bios))
 		bio_io_error(dip->orig_bio);
-
-	/* bio_end_io() will handle error, so we needn't return it */
-	return 0;
-}
-
-static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
-				loff_t file_offset)
-{
-	struct btrfs_dio_private *dip = NULL;
-	struct bio *bio = NULL;
-	struct btrfs_io_bio *io_bio;
-	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
-	int ret = 0;
-
-	bio = btrfs_bio_clone(dio_bio);
-
-	dip = kzalloc(sizeof(*dip), GFP_NOFS);
-	if (!dip) {
-		ret = -ENOMEM;
-		goto free_ordered;
-	}
-
-	dip->private = dio_bio->bi_private;
-	dip->inode = inode;
-	dip->logical_offset = file_offset;
-	dip->bytes = dio_bio->bi_iter.bi_size;
-	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
-	bio->bi_private = dip;
-	dip->orig_bio = bio;
-	dip->dio_bio = dio_bio;
-	atomic_set(&dip->pending_bios, 1);
-	io_bio = btrfs_io_bio(bio);
-	io_bio->logical = file_offset;
-
-	if (write) {
-		bio->bi_end_io = btrfs_endio_direct_write;
-	} else {
-		bio->bi_end_io = btrfs_endio_direct_read;
-		dip->subio_endio = btrfs_subio_endio_read;
-	}
-
-	/*
-	 * Reset the range for unsubmitted ordered extents (to a 0 length range)
-	 * even if we fail to submit a bio, because in such case we do the
-	 * corresponding error handling below and it must not be done a second
-	 * time by btrfs_direct_IO().
-	 */
-	if (write) {
-		struct btrfs_dio_data *dio_data = current->journal_info;
-
-		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
-			dip->bytes;
-		dio_data->unsubmitted_oe_range_start =
-			dio_data->unsubmitted_oe_range_end;
-	}
-
-	ret = btrfs_submit_direct_hook(dip);
-	if (!ret)
-		return;
-
-	btrfs_io_bio_free_csum(io_bio);
-
-free_ordered:
-	/*
-	 * If we arrived here it means either we failed to submit the dip
-	 * or we either failed to clone the dio_bio or failed to allocate the
-	 * dip. If we cloned the dio_bio and allocated the dip, we can just
-	 * call bio_endio against our io_bio so that we get proper resource
-	 * cleanup if we fail to submit the dip, otherwise, we must do the
-	 * same as btrfs_endio_direct_[write|read] because we can't call these
-	 * callbacks - they require an allocated dip and a clone of dio_bio.
-	 */
-	if (bio && dip) {
-		bio_io_error(bio);
-		/*
-		 * The end io callbacks free our dip, do the final put on bio
-		 * and all the cleanup and final put for dio_bio (through
-		 * dio_end_io()).
-		 */
-		dip = NULL;
-		bio = NULL;
-	} else {
-		if (write)
-			__endio_write_update_ordered(inode,
-						file_offset,
-						dio_bio->bi_iter.bi_size,
-						false);
-		else
-			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
-			      file_offset + dio_bio->bi_iter.bi_size - 1);
-
-		dio_bio->bi_status = BLK_STS_IOERR;
-		/*
-		 * Releases and cleans up our dio_bio, no need to bio_put()
-		 * nor bio_endio()/bio_io_error() against dio_bio.
-		 */
-		dio_end_io(dio_bio);
-	}
-	if (bio)
-		bio_put(bio);
-	kfree(dip);
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-- 
2.26.1

