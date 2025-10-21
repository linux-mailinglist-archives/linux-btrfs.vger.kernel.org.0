Return-Path: <linux-btrfs+bounces-18094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6DDBF4ECD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C024A3AFC7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE478274B37;
	Tue, 21 Oct 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YXaZetvv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cw/NFiJe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512222156F
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031318; cv=none; b=maLtxMwBwWPMci7q88fJGS6bvFbFcOrWrkQecqW1iQL4qsDDcHVo6KZRcqh1Fipsd23Ovrq78aZoSINhud26CbpyQZnN9amrKXhpqrMdByKnpi1s6Fe9q8fhrN3ShaEcCz0qkL/d7VUxGWJD+DyU1db3nMiNA3nQqlmtaps6J3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031318; c=relaxed/simple;
	bh=gNoJ1PdX9NsCTrMJKXvWnWYb9XcaG8PG2SM2uCu0DWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRY2dPylvkrmxXdLNHKaAZYYjLeNaynxcgVFW9JUi5LA8YJ0HiN4IMh2SgG0nmdtAK1ZqGsHNMZKHQog0XZmT0cZkBMXbdlOHAJqbSY3nQIGg9NE5cCsTUTYy8qKXcq8ts5S5P665VohzJq1/6DMWmEFvqTNKSZb1u3i00Bpvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YXaZetvv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Cw/NFiJe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA9BE211FB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtPNVRWWwCJySQhV/0VNBWN8v52UmSw4HevlsVLf1cI=;
	b=YXaZetvv6NxvMifOljWADUIkvYUewkagDbwZrihDf8LqfKRotqm3zHYb8dGD4rEYMQSyoJ
	88nJi2iwD6G//kGAyt13+ZS92OW28WULcYH8yWZeNoOwxclKJS32d0HPd6ZRS2MMBv9f2i
	LfLc/oYbNsrcrl8TqJ1PDuKIXgbQHzM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtPNVRWWwCJySQhV/0VNBWN8v52UmSw4HevlsVLf1cI=;
	b=Cw/NFiJebOV0M2epfB3DDewv7wIaNrvUnwBpiigNS42Vsk7mrA6MKorGAPGHdA6y57DBMf
	0oaObE30X/bDRytNNazzaJDjz/IB/GF4G4KTCKUc3xc2ItET8gQlxalp8UR3nsOBeq+3UC
	6L9A50+9ZHfwDyETgsjvlh1fKTx3Q/E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6FCA13A38
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +O0cKoM092hpSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: allocate bounce pages for direct IO
Date: Tue, 21 Oct 2025 17:51:15 +1030
Message-ID: <2d2faa4c2393015d225a27e4a729fd19216467e6.1761030762.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761030762.git.wqu@suse.com>
References: <cover.1761030762.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG REPORT]
There is a bug report about that direct IO can lead to different
contents of md-raid arrays.

[IMPACT ON BTRFS]
It's exactly the situation we fixed for direct IO in commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum"), however we still leave a hole for nodatasum cases.

The original idea is, since there is nodatasum users are all on their
own to keep everything consistent, and probably care more about
performance than consistency.

Thus we still go the true zero-copy method for direct IO (which is only
possible for inodes without data checksum).
But this means for nodatasum cases, RAID1* and RAID56 are still
vulnerable to volatile direct buffers (modified by user space during
writeback), resulting unreliable data depending on which mirror is read
from.

[ENHANCEMENT]
Follow bcachefs to use bounce pages for direct IO.
This means we will allocate new pages (thus no one else can modify) and
new btrfs bio(s) to do the real IO.

For read bio(s), the content will be copied back to the dio bio.
For write bios(s), the content will be copied to the new btrfs bio
before submission.

And since the iomap dio passed in can be pretty large (if backed by
large folios, it can easily go larger than PAGE_SIZE * BIO_MAX_VECS),
thus we may need to split into multiple btrfs bios to fulfill a single
iomap dio bio.

[BENCHMARK]
The benchmark is a simple one, doing direct IO reads/writes with 1MiB
block size, the file size is 4GiB:

                |  Nodatasum   | Device speed |
----------------+--------------+--------------+
Read (Vanilla)  | 2064.6 GiB/s | 2582.8 GiB/s |
Read (Patched)  | 1719.0 GiB/s | 2556.7 GiB/s |
Diff            | -16.7 %      | -1%          |
----------------+--------------+--------------+
Write (Vanilla) | 2424.8 GiB/s | 2309.6 GiB/s |
Write (Patched) | 1800.2 GiB/s | 2232.7 GiB/s |
Diff            | -25.7 %      | -3%          |

Since we're doing extra page allocation and data copy, the performance
is affected but to me the cost is acceptable to avoid mirror content
mismatch.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/direct-io.c | 293 +++++++++++++++++++++++++++++++++----------
 1 file changed, 230 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..1388d96c8d15 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -20,14 +20,32 @@ struct btrfs_dio_data {
 };
 
 struct btrfs_dio_private {
+	/* Saved iter for read bios to copy their data back. */
+	struct bvec_iter saved_src_iter;
+
 	/* Range of I/O */
-	u64 file_offset;
 	u32 bytes;
+	u64 file_offset;
 
 	/* This must be last */
 	struct btrfs_bio bbio;
 };
 
+/* Record the amount of bounce bios. */
+struct bounce_ctl {
+	/* The original bio from iomap dio. */
+	struct bio *src;
+
+	/* Procetects @ret update. */
+	spinlock_t lock;
+
+	/* Number of pending bounce btrfs bios*/
+	atomic_t pending;
+
+	/* Record the first hit error. */
+	int ret;
+};
+
 static struct bio_set btrfs_dio_bioset;
 
 static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
@@ -640,33 +658,6 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
-static void btrfs_dio_end_io(struct btrfs_bio *bbio)
-{
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_inode *inode = bbio->inode;
-	struct bio *bio = &bbio->bio;
-
-	if (bio->bi_status) {
-		btrfs_warn(inode->root->fs_info,
-		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
-			   btrfs_ino(inode), bio->bi_opf,
-			   dip->file_offset, dip->bytes, bio->bi_status);
-	}
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
-					    !bio->bi_status);
-	} else {
-		btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
-					dip->file_offset + dip->bytes - 1, NULL);
-	}
-
-	bbio->bio.bi_private = bbio->private;
-	iomap_dio_bio_end_io(bio);
-}
-
 static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 					struct btrfs_ordered_extent *ordered)
 {
@@ -705,46 +696,223 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	return 0;
 }
 
-static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
-				loff_t file_offset)
+
+static void put_bounce_bio_ctl(struct bounce_ctl *bounce_ctl, int ret)
 {
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_ctl->lock, flags);
+	if (!bounce_ctl->ret)
+		bounce_ctl->ret = ret;
+	spin_unlock_irqrestore(&bounce_ctl->lock, flags);
+
+	if (atomic_dec_and_test(&bounce_ctl->pending)) {
+		bounce_ctl->src->bi_status = errno_to_blk_status(bounce_ctl->ret);
+		iomap_dio_bio_end_io(bounce_ctl->src);
+		kfree(bounce_ctl);
+	}
+}
+
+static void dio_end_write_copied_bio(struct btrfs_bio *bbio)
+{
+	struct bounce_ctl *bounce_ctl = bbio->private;
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_dio_data *dio_data = iter->private;
+	struct btrfs_inode *inode = bbio->inode;
+	struct bio *bio = &bbio->bio;
+	int ret;
 
-	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
-		       btrfs_dio_end_io, bio->bi_private);
-	bbio->inode = BTRFS_I(iter->inode);
-	bbio->file_offset = file_offset;
-
-	dip->file_offset = file_offset;
-	dip->bytes = bio->bi_iter.bi_size;
-
-	dio_data->submitted += bio->bi_iter.bi_size;
-
-	/*
-	 * Check if we are doing a partial write.  If we are, we need to split
-	 * the ordered extent to match the submitted bio.  Hang on to the
-	 * remaining unfinishable ordered_extent in dio_data so that it can be
-	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
-	 * remaining pages is blocked on the outstanding ordered extent.
-	 */
-	if (iter->flags & IOMAP_WRITE) {
-		int ret;
-
-		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
-		if (ret) {
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
-						    file_offset, dip->bytes,
-						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
-			iomap_dio_bio_end_io(bio);
-			return;
-		}
+	ret = blk_status_to_errno(bio->bi_status);
+	if (ret) {
+		btrfs_warn(inode->root->fs_info,
+		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
 	}
 
-	btrfs_submit_bbio(bbio, 0);
+	btrfs_finish_ordered_extent(bbio->ordered, NULL,
+				    dip->file_offset, dip->bytes,
+				    !bio->bi_status);
+	bio_free_pages(bio);
+	bio_put(bio);
+	put_bounce_bio_ctl(bounce_ctl, ret);
+}
+
+static void dio_end_read_copied_bio(struct btrfs_bio *bbio)
+{
+	struct bounce_ctl *bounce_ctl = bbio->private;
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_inode *inode = bbio->inode;
+	struct bio *bio = &bbio->bio;
+	struct bvec_iter iter = { .bi_size = dip->bytes };
+	int ret;
+
+	ret = blk_status_to_errno(bio->bi_status);
+	if (ret) {
+		btrfs_warn(inode->root->fs_info,
+		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
+	}
+
+	/* Copy the whole bounce bio into the saved src location. */
+	bio_copy_data_iter(bounce_ctl->src, &dip->saved_src_iter, bio, &iter);
+	btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
+				dip->file_offset + dip->bytes - 1, NULL);
+	bio_free_pages(bio);
+	bio_put(bio);
+	put_bounce_bio_ctl(bounce_ctl, ret);
+}
+
+static struct btrfs_bio *alloc_bounce_bbio(struct btrfs_inode *inode,
+					   struct bio *src,
+					   struct bounce_ctl *bounce_ctl,
+					   btrfs_bio_end_io_t end_io,
+					   u64 logical, u64 file_offset)
+{
+	struct btrfs_dio_private *dip;
+	struct btrfs_bio *new_bbio;
+	struct bio *new_bio;
+	unsigned int vcnt = min(round_up(src->bi_iter.bi_size, PAGE_SIZE) >> PAGE_SHIFT,
+				BIO_MAX_VECS);
+
+	new_bio = bio_alloc_bioset(NULL, vcnt, src->bi_opf, GFP_NOFS, &btrfs_dio_bioset);
+	new_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+
+	new_bbio = btrfs_bio(new_bio);
+	btrfs_bio_init(new_bbio, inode->root->fs_info, end_io, bounce_ctl);
+	new_bbio->inode = inode;
+	new_bbio->file_offset = file_offset;
+
+	dip = container_of(new_bbio, struct btrfs_dio_private, bbio);
+	dip->file_offset = file_offset;
+	atomic_inc(&bounce_ctl->pending);
+	return new_bbio;
+}
+
+static void submit_bounce_bbio(struct btrfs_dio_data *dio_data, struct btrfs_bio *bounce_bbio,
+			       struct bio *src)
+{
+	const bool is_write = (btrfs_op(&bounce_bbio->bio) == BTRFS_MAP_WRITE);
+	const unsigned int size = bounce_bbio->bio.bi_iter.bi_size;
+	struct bounce_ctl *bounce_ctl = bounce_bbio->private;
+	struct btrfs_dio_private *dip = container_of(bounce_bbio,
+						     struct btrfs_dio_private, bbio);
+
+	ASSERT(size <= src->bi_iter.bi_size);
+	dio_data->submitted += size;
+	dip->bytes = size;
+	if (is_write) {
+		struct bvec_iter iter = { .bi_size = size };
+		int ret;
+
+		/* Copy the remaining part of src into the beginning of the bounce bbio. */
+		bio_copy_data_iter(&bounce_bbio->bio, &iter, src, &src->bi_iter);
+
+		/*
+		 * Check if we are doing a partial write.  If we are, we need to split
+		 * the ordered extent to match the submitted bio.  Hang on to the
+		 * remaining unfinishable ordered_extent in dio_data so that it can be
+		 * cancelled in iomap_end to avoid a deadlock wherein faulting the
+		 * remaining pages is blocked on the outstanding ordered extent.
+		 */
+		ret = btrfs_extract_ordered_extent(bounce_bbio, dio_data->ordered);
+		if (ret) {
+			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+						    bounce_bbio->file_offset, size, false);
+			bio_free_pages(&bounce_bbio->bio);
+			bio_put(&bounce_bbio->bio);
+			put_bounce_bio_ctl(bounce_ctl, ret);
+			return;
+		}
+	} else {
+		struct btrfs_dio_private *dip = container_of(bounce_bbio,
+							     struct btrfs_dio_private, bbio);
+
+		/*
+		 * Save the iter and size so that we can copy the content back
+		 * to the correct position at endio.
+		 */
+		dip->saved_src_iter = src->bi_iter;
+		bio_advance(src, size);
+	}
+	btrfs_submit_bbio(bounce_bbio, 0);
+}
+
+static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *src,
+				loff_t file_offset)
+{
+	struct btrfs_inode *inode = BTRFS_I(iter->inode);
+	struct btrfs_dio_data *dio_data = iter->private;
+	struct btrfs_bio *bounce_bbio = NULL;
+	struct bounce_ctl *bounce_ctl;
+	const bool is_write = (btrfs_op(src) == BTRFS_MAP_WRITE);
+	btrfs_bio_end_io_t end_io;
+	const unsigned int src_size = src->bi_iter.bi_size;
+	const u64 logical = src->bi_iter.bi_sector << SECTOR_SHIFT;
+	unsigned int cur = 0;
+	int ret = 0;
+
+	if (is_write)
+		end_io = dio_end_write_copied_bio;
+	else
+		end_io = dio_end_read_copied_bio;
+
+	bounce_ctl = kzalloc(sizeof(struct bounce_ctl), GFP_NOFS);
+	if (!bounce_ctl) {
+		ret = -ENOMEM;
+		src->bi_status = errno_to_blk_status(ret);
+		iomap_dio_bio_end_io(src);
+		return;
+	}
+	bounce_ctl->src = src;
+	spin_lock_init(&bounce_ctl->lock);
+	/*
+	 * Set the initial value to 1 so that the iomap bio can only finish
+	 * after every bounce bio is submitted.
+	 */
+	atomic_set(&bounce_ctl->pending, 1);
+
+	while (cur < src_size) {
+		struct page *page;
+		unsigned int size = min(src_size - cur, PAGE_SIZE);
+
+		if (!bounce_bbio)
+			bounce_bbio = alloc_bounce_bbio(inode, src, bounce_ctl, end_io,
+							logical + cur, file_offset + cur);
+		page = alloc_page(GFP_NOFS);
+		if (!page) {
+			ret = -ENOMEM;
+			submit_bounce_bbio(dio_data, bounce_bbio, src);
+			goto error;
+		}
+		ret = bio_add_page(&bounce_bbio->bio, page, size, 0);
+		if (ret != size) {
+			submit_bounce_bbio(dio_data, bounce_bbio, src);
+			bounce_bbio = NULL;
+			continue;
+		}
+		ret = 0;
+		cur += size;
+	}
+	if (bounce_bbio)
+		submit_bounce_bbio(dio_data, bounce_bbio, src);
+
+	put_bounce_bio_ctl(bounce_ctl, 0);
+	return;
+error:
+	/*
+	 * Errored out halfway, cleanup the remaining part which is not covered by
+	 * any bbio.
+	 */
+	if (is_write)
+		btrfs_mark_ordered_io_finished(inode, NULL, file_offset + cur,
+					       src_size - cur, false);
+	else
+		btrfs_unlock_dio_extent(&inode->io_tree, file_offset + cur,
+					file_offset + src_size - 1, NULL);
+	put_bounce_bio_ctl(bounce_ctl, ret);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -754,7 +922,6 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_dio_submit_io,
-	.bio_set		= &btrfs_dio_bioset,
 };
 
 static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.51.0


