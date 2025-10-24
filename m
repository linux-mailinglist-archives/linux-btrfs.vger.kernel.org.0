Return-Path: <linux-btrfs+bounces-18279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE05C05AB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E6B19A86A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C731065B;
	Fri, 24 Oct 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qeQeJG19";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i6u++FXr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DF3126B2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303018; cv=none; b=ETqGoOpIwF58C2mZf0IcIVb87EGWjGFwN/Px0guk6ilgA/tI5ZhOd4boSTC8TCl+DvZso/iVmmR+73Y/U5VIdW1Pa3/pgXHZ9f25bD+oMz9Q5izFr+L5XHueyNtOeWcGjUe4Vxc4glLg3I3+BEgOBSD/FFqVBIxxqFItFNaYZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303018; c=relaxed/simple;
	bh=KaTy1EkQa4rAqdYhSBvAL7VQ//K5CTt3XLhtQjLNbIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv3bqcEuYoflgvYjuM+SXFY60xYvyo05aVOpgPwsUq1Y48sCGfS7VgV34ouit7hyXAfwPyTVELNGrze2NVdbFSKPL/JAEX08DcyS6tRXPVdwE0byJ8AWOLVyNcuJbjbtsJ3tlYzC/fu6EUwQS6Bum9mwAlQ5s1aTRtjmY5H1F3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qeQeJG19; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i6u++FXr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E44D211C8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgSb5ZsE2c0pqQsc4yTvZZxbbijD4IRsGZmNbRHCWiQ=;
	b=qeQeJG19rchTQ3fvlArZTB7xbpRfTBSizALiu5/5Jvvco3vst4trbKu9sr3P5c3ey+Avij
	qgpULfVZ8C8g6QkUpLcHrWfNPQQ0MagRjQdeMCsvcHaP65/KtINH3n//nTvdAi7GLFEpSv
	TayXpqQPHXtasc0AWr7zQHNo2RWGr0s=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=i6u++FXr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761302999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgSb5ZsE2c0pqQsc4yTvZZxbbijD4IRsGZmNbRHCWiQ=;
	b=i6u++FXrO8I6TXhiwOAWtjEp6+gynUzWfxqAF/LZ2QF9BNlFBvmLSuC9VXyJ7kBJqel/sG
	pXgL9qpctT+dZDfertgHpZEo2R/FPtaPjf2AttU3Jh2PPdI/Eri66yGK8VJ6xn+JvvmTOC
	4svBFEg6EppiOoYeQwjcZUfgQspnCHI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD52D13A38
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLpCG9ZZ+2iaZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: make sure all btrfs_bio::end_io is called in task context
Date: Fri, 24 Oct 2025 21:19:32 +1030
Message-ID: <f1c6a2bdd97d9d680e09c30f53cabf424d8dd42e.1761302592.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761302592.git.wqu@suse.com>
References: <cover.1761302592.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E44D211C8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

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
 fs/btrfs/bio.c | 62 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa..18272ef4b4d8 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -100,6 +100,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
+	/* Make sure we're already in task context. */
+	ASSERT(in_task());
+
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
@@ -317,15 +320,20 @@ static struct workqueue_struct *btrfs_end_io_wq(const struct btrfs_fs_info *fs_i
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
@@ -339,14 +347,8 @@ static void btrfs_simple_end_io(struct bio *bio)
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
@@ -354,6 +356,9 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	struct btrfs_io_context *bioc = bio->bi_private;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 
+	/* RAID56 endio is always handled in workqueue. */
+	ASSERT(in_task());
+
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
@@ -364,11 +369,12 @@ static void btrfs_raid56_end_io(struct bio *bio)
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
 
@@ -393,8 +399,18 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	btrfs_put_bioc(bioc);
 }
 
-static void btrfs_clone_write_end_io(struct bio *bio)
+static void btrfs_orig_write_end_io(struct bio *bio)
 {
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	INIT_WORK(&bbio->end_io_work, orig_write_end_io_work);
+	queue_work(btrfs_end_io_wq(bbio->fs_info, bio), &bbio->end_io_work);
+}
+
+static void clone_write_end_io_work(struct work_struct *work)
+{
+	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
+	struct bio *bio = &bbio->bio;
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 
 	if (bio->bi_status) {
@@ -409,6 +425,14 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+static void btrfs_clone_write_end_io(struct bio *bio)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	INIT_WORK(&bbio->end_io_work, clone_write_end_io_work);
+	queue_work(btrfs_end_io_wq(bbio->fs_info, bio), &bbio->end_io_work);
+}
+
 static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
 	if (!dev || !dev->bdev ||
@@ -463,8 +487,10 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 		bio = orig_bio;
 		bio->bi_end_io = btrfs_orig_write_end_io;
 	} else {
-		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		/* We need to use endio_work to run end_io in task context. */
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &btrfs_bioset);
 		bio_inc_remaining(orig_bio);
+		btrfs_bio_init(btrfs_bio(bio), bioc->fs_info, NULL, NULL);
 		bio->bi_end_io = btrfs_clone_write_end_io;
 	}
 
-- 
2.51.0


