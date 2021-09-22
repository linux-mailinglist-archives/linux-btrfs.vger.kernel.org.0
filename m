Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32FF4143BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhIVI3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 04:29:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhIVI26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 04:28:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8671FF53
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632299248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWIUS+nDMssvvTpYVT8SUvsXwq1+CGJJ6uR16vVBlOQ=;
        b=n+tNOXdlVtXuIKDF7WKhbeeHQqejm6nxugCccHUY/LXJTepd5rZ5+guG4gEICZMfKBuiUX
        0Iacyd8PMGZcSJD8gujV+GvpLKSjOsTkK2cu7ZlBUYtZLd1NGUsPkjm7SzcNQ+Q/I0wqu0
        TB+O8e5DN0vsmYWEEBgZa5pL3mRlufE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B901E13D65
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4EKWHu/oSmEPDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/3] btrfs: replace btrfs_bio::device member with stripe_num
Date:   Wed, 22 Sep 2021 16:27:06 +0800
Message-Id: <20210922082706.55650-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922082706.55650-1-wqu@suse.com>
References: <20210922082706.55650-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Structure btrfs_bio uses @device member to record which the underlying
physical device is for each stripe.

However btrfs_bio::device is only utilized by two types of call sites:

- btrfs_end_bio()
- check_data_sum() and check_compressed_csum()

Both types of call sites are just to update device status.

For btrfs_end_bio(), in the context we can easily grab bioc from
btrfs_bio, and with the new @stripe_num member, we can easily grab the
stripe and its device.

This is as good as the original code.

For check_data_sum() and check_compressed_csum(), we have
btrfs_bio::mirror_num, and can afford to do a logical->physical mapping
lookup to grab the device.

Unfortunately this path is not as good as the original code, as we can't
distinguish target and source device for dev-replace.

But this should save us 8 bytes from btrfs_bio, thus I still think the
benefit can cover the shortcoming.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  6 ++----
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent_io.c   |  2 --
 fs/btrfs/inode.c       | 30 +++++++++++++++++++++++++++---
 fs/btrfs/raid56.c      |  1 -
 fs/btrfs/volumes.c     |  6 ++++--
 fs/btrfs/volumes.h     | 10 +++++++---
 7 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2a86a2a1494b..28c35f58c2cd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -179,10 +179,8 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 			if (memcmp(&csum, cb_sum, csum_size) != 0) {
 				btrfs_print_data_csum_error(inode, disk_start,
 						csum, cb_sum, cb->mirror_num);
-				if (btrfs_bio(bio)->device)
-					btrfs_dev_stat_inc_and_print(
-						btrfs_bio(bio)->device,
-						BTRFS_DEV_STAT_CORRUPTION_ERRS);
+				btrfs_dev_stat_inc_and_print_by_bbio(fs_info,
+								btrfs_bio(bio));
 				return -EIO;
 			}
 			cb_sum += csum_size;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 522ded06fd85..515750bb7a8e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3141,6 +3141,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
+void btrfs_dev_stat_inc_and_print_by_bbio(struct btrfs_fs_info *fs_info,
+					  struct btrfs_bio *bbio);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c56973f7daae..127885f5413a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3331,8 +3331,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			ret = PTR_ERR(device);
 			goto error;
 		}
-
-		btrfs_bio(bio)->device = device;
 	}
 	return 0;
 error:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a643be30c18a..29945ff4002c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3206,6 +3206,32 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * This is a cold path for csum mismatch case, we can afford to a
+ * logical->physical address lookup to locate the device using mirror_num.
+ */
+void btrfs_dev_stat_inc_and_print_by_bbio(struct btrfs_fs_info *fs_info,
+					  struct btrfs_bio *bbio)
+{
+	struct btrfs_io_context *bioc;
+	struct btrfs_device *dev;
+	u64 logical = bbio->logical;
+	u64 length = fs_info->sectorsize;
+	unsigned int mirror_num = bbio->mirror_num;
+	int ret;
+
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical, &length, &bioc,
+			      mirror_num);
+	/* Failed to do such map, just skip the dev status update */
+	if (ret < 0)
+		return;
+	dev = bioc->stripes[0].dev;
+	btrfs_put_bioc(bioc);
+	if (dev)
+		btrfs_dev_stat_inc_and_print(dev,
+					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3248,9 +3274,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
 				    bbio->mirror_num);
-	if (bbio->device)
-		btrfs_dev_stat_inc_and_print(bbio->device,
-					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
+	btrfs_dev_stat_inc_and_print_by_bbio(fs_info, bbio);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 02aa3fbb8108..28ef777ce51f 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1105,7 +1105,6 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* put a new bio on the list */
 	bio = btrfs_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
-	btrfs_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
 	bio->bi_iter.bi_sector = disk_start >> 9;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0c907a3eb3a7..b66e336dbe5e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6573,8 +6573,10 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bioc->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			struct btrfs_device *dev = btrfs_bio(bio)->device;
+			struct btrfs_bio *bbio = btrfs_bio(bio);
+			struct btrfs_device *dev;
 
+			dev = bioc->stripes[bbio->stripe_num].dev;
 			ASSERT(dev->bdev);
 			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
@@ -6627,7 +6629,7 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	const u64 physical = bioc->stripes[stripe_nr].physical;
 
 	btrfs_bio(bio)->bioc = bioc;
-	btrfs_bio(bio)->device = dev;
+	btrfs_bio(bio)->stripe_num = stripe_nr;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 384c483d2cef..5bae94843e49 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -310,11 +310,15 @@ struct btrfs_fs_devices {
  */
 struct btrfs_bio {
 	unsigned int mirror_num;
+	/*
+	 * @stripe_num is for stripe IO submission, under most case it should
+	 * be the same as @mirror_num, but for dev replace case it can be
+	 * different as we need to submit the bio to both source and target
+	 * device.
+	 */
+	unsigned int stripe_num;
 
 	struct btrfs_io_context *bioc;
-
-	/* @device is for stripe IO submission. */
-	struct btrfs_device *device;
 	u64 logical;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
-- 
2.33.0

