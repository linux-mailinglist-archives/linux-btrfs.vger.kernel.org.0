Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB32917EB38
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCIVc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:32:58 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54214 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCIVc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:32:58 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so454531pjb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQc3aFeIrpusXZKg49W5UBHhGHHY0qVGeT8e5E9a2kY=;
        b=m6K6/9B4OXtjItDRbM4S2FH5bbJSEMD61c9fPyG4gcsHY9/PMdblSnVOvqtbiAVPa1
         7H/AGNc5uAPLgyF7g8Sf/zNIAjDMU+28+sDKqc0/wlp/dWWVIPkixrC3fJMMk7KR+GZ1
         mFJLhAgQIeXeU1DWVWXBFYkoPQa6ka/0ZmEg+ajLGcD20hLjwtGPokdnwH4OVJo5GpyF
         GclRl//IMZyUzcwN64GXq5VUgYafvbdqw62XzmEONSxSxKzYH4WIzW9bXvHMhFG/ycn2
         NzNxJPZlBtGypwUp+AjZX6SH53Z93VRz89G2YCntRcMaMi0jZyXLgqxs5BA4kiMFTCNB
         0obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQc3aFeIrpusXZKg49W5UBHhGHHY0qVGeT8e5E9a2kY=;
        b=mzWL3343YXAoIa6ntAzpRfyIdWESuknL9uV3f1tDlCbLgWQ1YNhareTlTvCrjjMxbf
         ScCRFRlAEEh5haR6rYNDnLVGmzYs5tezMDScR6rXpIEi9Gy3yy0LXQsLqsUkK0aqyLz6
         SXhvyJ20ep3DgsYyE9HpbaaBnxhW+AiMGdpVheUG5BVQioqsFvc/2sqbi/V0tAbJSY7x
         odKy1Tth+3MMToC7Iws+sZI4BTkNv/dPZ0gAMdpVroTfsrPqim8G0Chfaq80CM2hmXUj
         YsjtcVECEs7kPnJ1iW5qq5zuF9suBphLFVtbWBSuO8k3C15eY3GwSe10SDvUzkC2SA6u
         SFUQ==
X-Gm-Message-State: ANhLgQ1VFp2yin/HzFxbSUacqVK+Rzkhmy1hcClLfL34YqkIHehcgF8a
        BzZL8JW+HAV/daXJCxrvk00tpRFqDrg=
X-Google-Smtp-Source: ADFU+vshQ355ZZQbguOuznK1w83WQpNaFhAijRnMsQ1bff2rkHI2CQqYqWLxTb2jjovGvEB773Wq+w==
X-Received: by 2002:a17:90a:e012:: with SMTP id u18mr556881pjy.190.1583789576811;
        Mon, 09 Mar 2020 14:32:56 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:56 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/15] btrfs: fix double __endio_write_update_ordered in direct I/O
Date:   Mon,  9 Mar 2020 14:32:28 -0700
Message-Id: <b4b45179cc951dde98feea48723572683daf7fb3.1583789410.git.osandov@fb.com>
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

In btrfs_submit_direct(), if we fail to allocate the btrfs_dio_private,
we complete the ordered extent range. However, we don't mark that the
range doesn't need to be cleaned up from btrfs_direct_IO() until later.
Therefore, if we fail to allocate the btrfs_dio_private, we complete the
ordered extent range twice. We could fix this by updating
unsubmitted_oe_range earlier, but it's simpler to always clean up via
the bio once the btrfs_dio_private is allocated and leave it for
btrfs_direct_IO() before that.

Fixes: f28a49287817 ("Btrfs: fix leaking of ordered extents after direct IO write error")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 92 ++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d48a2010f24a..8e986056be3c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7912,7 +7912,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	return ret;
 }
 
-static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
+static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -7932,7 +7932,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
 				    start_sector << 9, submit_len, &geom);
 	if (ret)
-		return -EIO;
+		goto out_err;
 
 	if (geom.len >= submit_len) {
 		bio = orig_bio;
@@ -7995,7 +7995,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 submit:
 	status = btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
 	if (!status)
-		return 0;
+		return;
 
 	if (bio != orig_bio)
 		bio_put(bio);
@@ -8009,9 +8009,6 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	 */
 	if (atomic_dec_and_test(&dip->pending_bios))
 		bio_io_error(dip->orig_bio);
-
-	/* bio_end_io() will handle error, so we needn't return it */
-	return 0;
 }
 
 static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
@@ -8021,14 +8018,24 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	struct bio *bio = NULL;
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
-	int ret = 0;
 
 	bio = btrfs_bio_clone(dio_bio);
 
 	dip = kzalloc(sizeof(*dip), GFP_NOFS);
 	if (!dip) {
-		ret = -ENOMEM;
-		goto free_ordered;
+		if (!write) {
+			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
+				file_offset + dio_bio->bi_iter.bi_size - 1);
+		}
+
+		dio_bio->bi_status = BLK_STS_RESOURCE;
+		/*
+		 * Releases and cleans up our dio_bio, no need to bio_put() nor
+		 * bio_endio()/bio_io_error() against dio_bio.
+		 */
+		dio_end_io(dio_bio);
+		bio_put(bio);
+		return;
 	}
 
 	dip->private = dio_bio->bi_private;
@@ -8044,72 +8051,25 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	io_bio->logical = file_offset;
 
 	if (write) {
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
+		/*
+		 * At this point, the btrfs_dio_private is responsible for
+		 * cleaning up the ordered extents whether or not we submit any
+		 * bios.
+		 */
 		struct btrfs_dio_data *dio_data = current->journal_info;
 
 		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
 			dip->bytes;
 		dio_data->unsubmitted_oe_range_start =
 			dio_data->unsubmitted_oe_range_end;
-	}
-
-	ret = btrfs_submit_direct_hook(dip);
-	if (!ret)
-		return;
-
-	btrfs_io_bio_free_csum(io_bio);
 
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
+		bio->bi_end_io = btrfs_endio_direct_write;
 	} else {
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
+		bio->bi_end_io = btrfs_endio_direct_read;
+		dip->subio_endio = btrfs_subio_endio_read;
 	}
-	if (bio)
-		bio_put(bio);
-	kfree(dip);
+
+	btrfs_submit_direct_hook(dip);
 }
 
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-- 
2.25.1

