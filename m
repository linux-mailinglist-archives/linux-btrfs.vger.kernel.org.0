Return-Path: <linux-btrfs+bounces-18278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC3C05AA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E65919A862E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B53126B3;
	Fri, 24 Oct 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YC7hDdBR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C19adLp1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0E311949
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303012; cv=none; b=o/jWwmNcYhHSiuzDQdxh7GXbm8WNvgZ9STIONHr+XOCiK0yL1PMY5730LwnZ+g178HDhF9i1hmvE41ktutjLPBP2keeQV53kP/GTSwdIRRAP1Pxxcos9OrcRB3rBKOe7OVYV0saYCCYdt7LHcphWjJSoRlSzIUznOEqpBXrnGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303012; c=relaxed/simple;
	bh=Jh/PZyugb9dgUHSGZju4shOV9LYfr5FOdjWQlhNhP8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La4C54QacDbriiKNtEM5eGG19OHwvFpfcCjlG0vNmqf+cRf1SkeZ/PCaZpyJQRjTrj3pF1WytyuHH33D/nj6a1sBBn4cHkEA19LAFwkUAiGecCm7a3Y1N1OdTKg0V3IpO2YpvBaROnrnyXga7ux5UQls4oijcEU3UqbhiMT3v9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YC7hDdBR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C19adLp1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE6211F388
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI8Kv2zE422EpC9eo2MFjlqMGPAfbu5u86ZyqHhh64Y=;
	b=YC7hDdBRV5yiNYw5PPWQGsQYfxShSuuBUEfigVwku6VJgnRSjYMY1LiTROFRqFZQ21ktK0
	+RQUjogIoBIGf5/++Dn8V1Fu/lCO8UjDT4xeLSGLBvoHfN8zLgXW+LGN4UOCmg8l+KpkYF
	GpiTgjFHtRCQ94RuW4KH90+3lXN+g/w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761303000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI8Kv2zE422EpC9eo2MFjlqMGPAfbu5u86ZyqHhh64Y=;
	b=C19adLp1R8R62jsl+B6LswQ/lEq5ZuLz9yP/vGLvNxm8dlcXPhE+aFv5keYJr1E0WW5CEE
	q4tNQsq21hodE14TyEmEMRkwKsTaUrDZj1pM4VFQ8ajcPkjsQyMZaqbbVth6/LODk24a0x
	iq4q6PqRrOwzRuUT78LrxJRAU3DgK3U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6DCD13A8E
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Pm5KddZ+2iaZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:49:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: remove btrfs_fs_info::compressed_write_workers
Date: Fri, 24 Oct 2025 21:19:33 +1030
Message-ID: <95d75af0b5a20e9fde6ace86f5a015e52982ab50.1761302592.git.wqu@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The reason why end_bbio_compressed_write() queues a work into
compressed_write_workers wq is for end_compressed_writeback() call, as
it will grab all the involved folioes and clear the writeback flags,
which may sleep.

However now we always run btrfs_bio::end_io() in task context, there is
no need to queue the work anymore.

Just remove btrfs_fs_info::compressed_write_workers and
compressed_bio::write_end_work.

There is a comment about the works queued into
compressed_write_workers, now change to flush endio wq instead, which is
responsible to handle all data endio functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 27 ++++++++-------------------
 fs/btrfs/compression.h |  7 ++-----
 fs/btrfs/disk-io.c     |  9 ++-------
 fs/btrfs/fs.h          |  1 -
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..2d7992e0145a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -321,22 +321,6 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 	/* the inode may be gone now */
 }
 
-static void btrfs_finish_compressed_write_work(struct work_struct *work)
-{
-	struct compressed_bio *cb =
-		container_of(work, struct compressed_bio, write_end_work);
-
-	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
-				    cb->bbio.bio.bi_status == BLK_STS_OK);
-
-	if (cb->writeback)
-		end_compressed_writeback(cb);
-	/* Note, our inode could be gone now */
-
-	btrfs_free_compressed_folios(cb);
-	bio_put(&cb->bbio.bio);
-}
-
 /*
  * Do the cleanup once all the compressed pages hit the disk.  This will clear
  * writeback on the file pages and free the compressed pages.
@@ -347,9 +331,15 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
-	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
+	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
+				    cb->bbio.bio.bi_status == BLK_STS_OK);
+
+	if (cb->writeback)
+		end_compressed_writeback(cb);
+	/* Note, our inode could be gone now */
+	btrfs_free_compressed_folios(cb);
+	bio_put(&cb->bbio.bio);
 }
 
 static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
@@ -402,7 +392,6 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->compressed_folios = compressed_folios;
 	cb->compressed_len = ordered->disk_num_bytes;
 	cb->writeback = writeback;
-	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_folios = nr_folios;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eba188a9e3bb..2ebf94794f0d 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -65,11 +65,8 @@ struct compressed_bio {
 	/* Whether this is a write for writeback. */
 	bool writeback;
 
-	union {
-		/* For reads, this is the bio we are copying the data into */
-		struct btrfs_bio *orig_bbio;
-		struct work_struct write_end_work;
-	};
+	/* For reads, this is the bio we are copying the data into */
+	struct btrfs_bio *orig_bbio;
 
 	/* Must be last. */
 	struct btrfs_bio bbio;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..c96051343450 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1773,8 +1773,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 		destroy_workqueue(fs_info->endio_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
-	if (fs_info->compressed_write_workers)
-		destroy_workqueue(fs_info->compressed_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
@@ -1986,8 +1984,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
 				      max_active, 2);
-	fs_info->compressed_write_workers =
-		alloc_workqueue("btrfs-compressed-write", flags, max_active);
 	fs_info->endio_freespace_worker =
 		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
 				      max_active, 0);
@@ -2003,7 +1999,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	if (!(fs_info->workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
-	      fs_info->compressed_write_workers &&
 	      fs_info->endio_write_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
@@ -4290,7 +4285,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * When finishing a compressed write bio we schedule a work queue item
-	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * to finish an ordered extent - end_bbio_compressed_write()
 	 * calls btrfs_finish_ordered_extent() which in turns does a call to
 	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
 	 * completion either in the endio_write_workers work queue or in the
@@ -4298,7 +4293,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 * below, so before we flush them we must flush this queue for the
 	 * workers of compressed writes.
 	 */
-	flush_workqueue(fs_info->compressed_write_workers);
+	flush_workqueue(fs_info->endio_workers);
 
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ad389fb1c01a..2e705025a8a5 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -654,7 +654,6 @@ struct btrfs_fs_info {
 	struct workqueue_struct *endio_workers;
 	struct workqueue_struct *endio_meta_workers;
 	struct workqueue_struct *rmw_workers;
-	struct workqueue_struct *compressed_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
-- 
2.51.0


