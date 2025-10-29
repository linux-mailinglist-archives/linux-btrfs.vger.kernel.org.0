Return-Path: <linux-btrfs+bounces-18390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ADEC1851D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF641AA3067
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC42FB60E;
	Wed, 29 Oct 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GG4J80fU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GG4J80fU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82A2FD1AA
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716099; cv=none; b=XsyBpLNdIp6oEMxX2YEOK/LGA0M2Ad6TE+5iDZg0I2JaUzZS4O3qGql7f5B3vg2n2NUSz1zOOwTgGSbolv5co3C8RlAog9KdDl9/OWa4VLtzBQESGW0AkbuXdnfnelHrK5kRYPU5A1hDyVGovsiUL/Q0zZXKZ0f2tnnkcadGN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716099; c=relaxed/simple;
	bh=V6tpIvAL3jPXzQf3O2x7YljNbxdPxSoYawIVFTe8AFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7mZI23uGrA/0NdfTzR+N7Je66Uy/AO/SLjssXnGV49B9HiUfZIFBH/ybNOFKA8ksZaUcx/siXzbU23TukNAm8dJB/ZlW5xNyZljPimWnbL/kio+l18xWVq40D+gQO6R1G7NmxavwRqv/YsK1HMNc6dQ+LwGjJhEMV06jkh0u1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GG4J80fU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GG4J80fU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B319D1FD95
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9OhPYVM+/xypoXONUut4HikM16FCGhB8HnMyf1X6YU=;
	b=GG4J80fULDbS5gwnRm02SrGw8iQJwBjNYBVVEi+bKMyYd6rrFRGArgRmhHv8ZEaJ8tZiel
	//oK1XScRUW+FFRFbkXK4QGrTKkSA23O4LYDZM6cEw84cvWu++ZoQB3cf3NxCVCFmBUThy
	QdyMUO1bzexxQfPDpDoYaARA2NWrzsg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GG4J80fU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9OhPYVM+/xypoXONUut4HikM16FCGhB8HnMyf1X6YU=;
	b=GG4J80fULDbS5gwnRm02SrGw8iQJwBjNYBVVEi+bKMyYd6rrFRGArgRmhHv8ZEaJ8tZiel
	//oK1XScRUW+FFRFbkXK4QGrTKkSA23O4LYDZM6cEw84cvWu++ZoQB3cf3NxCVCFmBUThy
	QdyMUO1bzexxQfPDpDoYaARA2NWrzsg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAD8013886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UHFfKnCnAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs: make sure all btrfs_bio::end_io is called in task context
Date: Wed, 29 Oct 2025 16:04:14 +1030
Message-ID: <0e403d39d93ab17576c65827d7e3cc49acd12354.1761715650.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761715649.git.wqu@suse.com>
References: <cover.1761715649.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B319D1FD95
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

[BACKGROUND]
Btrfs has a lot of different bi_end_io functions, to handle different
raid profiles. But they introduced a lot of different context for
btrfs_bio::end_io() calls:

- Simple read bios
  Run in task context, backed by either endio_meta_workers or
  endio_workers.

- Simple write bios
  Run in irq context.

- RAID56 write or rebuild bios
  Run in task context, backed by rmw_workers.

- Mirrored write bios
  Run in irq context.

This is very inconsistent, and contributes to the huge amount of
workqueues used in btrfs.

[ENHANCEMENT]
Make all above bios to call their btrfs_bio::end_io() in task context,
backed by either endio_meta_workers for metadata, or endio_workers for
data.

For simple write bios, merge the handling into simple_end_io_work().

For mirrored write bios, it will be a little more complex, since both
the original or the cloned bios can run the final btrfs_bio::end_io().

Here we make sure the cloned bios are using btrfs_bioset, to reuse the
end_io_work, and run both original and cloned work inside the workqueue.

And add extra ASSERT()s to make sure btrfs_bio_end_io() is running in
task context.

This not only unifies the context for btrfs_bio::end_io() functions, but
also opens a new door for further btrfs_bio::end_io() related cleanups.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 64 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 6028d8f0c8fc..5a5f23332c2e 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -102,6 +102,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
+	/* Make sure we're already in task context. */
+	ASSERT(in_task());
+
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
@@ -318,15 +321,20 @@ static struct workqueue_struct *btrfs_end_io_wq(const struct btrfs_fs_info *fs_i
 	return fs_info->endio_workers;
 }
 
-static void btrfs_end_bio_work(struct work_struct *work)
+static void simple_end_io_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
+	struct bio *bio = &bbio->bio;
 
-	/* Metadata reads are checked and repaired by the submitter. */
-	if (is_data_bbio(bbio))
-		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
-	else
-		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
+	if (bio_op(bio) == REQ_OP_READ) {
+		/* Metadata reads are checked and repaired by the submitter. */
+		if (is_data_bbio(bbio))
+			return btrfs_check_read_bio(bbio, bbio->bio.bi_private);
+		return btrfs_bio_end_io(bbio, bbio->bio.bi_status);
+	}
+	if (bio_is_zone_append(bio) && !bio->bi_status)
+		btrfs_record_physical_zoned(bbio);
+	btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
@@ -340,14 +348,8 @@ static void btrfs_simple_end_io(struct bio *bio)
 	if (bio->bi_status)
 		btrfs_log_dev_io_error(bio, dev);
 
-	if (bio_op(bio) == REQ_OP_READ) {
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
-	} else {
-		if (bio_is_zone_append(bio) && !bio->bi_status)
-			btrfs_record_physical_zoned(bbio);
-		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
-	}
+	INIT_WORK(&bbio->end_io_work, simple_end_io_work);
+	queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 }
 
 static void btrfs_raid56_end_io(struct bio *bio)
@@ -355,6 +357,9 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	struct btrfs_io_context *bioc = bio->bi_private;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 
+	/* RAID56 endio is always handled in workqueue. */
+	ASSERT(in_task());
+
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
@@ -365,11 +370,12 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
-static void btrfs_orig_write_end_io(struct bio *bio)
+static void orig_write_end_io_work(struct work_struct *work)
 {
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
+	struct bio *bio = &bbio->bio;
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 	struct btrfs_io_context *bioc = stripe->bioc;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 
@@ -394,8 +400,18 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
-static void btrfs_clone_write_end_io(struct bio *bio)
+static void btrfs_orig_write_end_io(struct bio *bio)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	INIT_WORK(&bbio->end_io_work, orig_write_end_io_work);
+	queue_work(btrfs_end_io_wq(bbio->inode->root->fs_info, bio), &bbio->end_io_work);
+}
+
+static void clone_write_end_io_work(struct work_struct *work)
+{
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
+	struct bio *bio = &bbio->bio;
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 
 	if (bio->bi_status) {
@@ -410,6 +426,14 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+static void btrfs_clone_write_end_io(struct bio *bio)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	INIT_WORK(&bbio->end_io_work, clone_write_end_io_work);
+	queue_work(btrfs_end_io_wq(bbio->inode->root->fs_info, bio), &bbio->end_io_work);
+}
+
 static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
 	if (!dev || !dev->bdev ||
@@ -456,6 +480,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 {
 	struct bio *orig_bio = bioc->orig_bio, *bio;
+	struct btrfs_bio *orig_bbio = btrfs_bio(orig_bio);
 
 	ASSERT(bio_op(orig_bio) != REQ_OP_READ);
 
@@ -464,8 +489,11 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 		bio = orig_bio;
 		bio->bi_end_io = btrfs_orig_write_end_io;
 	} else {
-		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		/* We need to use endio_work to run end_io in task context. */
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &btrfs_bioset);
 		bio_inc_remaining(orig_bio);
+		btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode,
+			       orig_bbio->file_offset, NULL, NULL);
 		bio->bi_end_io = btrfs_clone_write_end_io;
 	}
 
-- 
2.51.0


