Return-Path: <linux-btrfs+bounces-18391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2EC1851A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C30E05037A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031B2FFDFF;
	Wed, 29 Oct 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GLcnkZT4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GLcnkZT4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476912FE59F
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716099; cv=none; b=EWKBsfBHhuApRAczZCJp3IR8/nBP38hntuNPOWc10rj2rRYi7CjxAgQwUQPJzmQbo35vtvChlm/WCT4oA5U7Okuo/AVI/G/6oZwtOz5K29fbsxOuIdONI/U0wpOdm301zcENytMEpEQC8zuVH63QOb9SuaZRWy9WeRiHRs8E/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716099; c=relaxed/simple;
	bh=Ue1g/Vlk/caAXU92zWfGGuYuESD4Ivod7chvaauwQHU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANSPwO/9SONjtdGxKzp5NiSfJZ8jWsnj3NC3XUxI8jGlAW/ul7U/MTFTaG0Iy4J0z0KiZ2SoXnJ0p847i0DDBQLwGXqjWu/RIHJRpeahf4MCnJFjpmMFMEY7YvD3KX1jSDgpa32eFUAiM1g2n3gHyrC3ptbjBIjnyUhYTiOxAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GLcnkZT4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GLcnkZT4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F342B21DD4
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzBD3K4iXVM3yar5LxVXyDXgpRssulg5rtNHmqi1D/E=;
	b=GLcnkZT4ASW3gjpMVxZcWg0eytbbq1ZWBqp9i3N8Zv2LvaIkEKaKBLpdZztzLS9ZRAtYfs
	5ulo/xX3ccIzzJJDfACEW4KS29Ia3AOKv91axURoe9NmdB2lhfrxyix5R4fWksrLUzoCvY
	0S50bs1ZNgpEP9CbXWDTWVcPxv+4i6E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GLcnkZT4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzBD3K4iXVM3yar5LxVXyDXgpRssulg5rtNHmqi1D/E=;
	b=GLcnkZT4ASW3gjpMVxZcWg0eytbbq1ZWBqp9i3N8Zv2LvaIkEKaKBLpdZztzLS9ZRAtYfs
	5ulo/xX3ccIzzJJDfACEW4KS29Ia3AOKv91axURoe9NmdB2lhfrxyix5R4fWksrLUzoCvY
	0S50bs1ZNgpEP9CbXWDTWVcPxv+4i6E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35A2C13886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAO8OXGnAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs: remove btrfs_fs_info::compressed_write_workers
Date: Wed, 29 Oct 2025 16:04:15 +1030
Message-ID: <bc72c2cc2e26773c363b8580895b45d909b4e1ac.1761715650.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: F342B21DD4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

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
index 8c3899832a1a..ef6e4d1662cc 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -319,22 +319,6 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
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
@@ -345,9 +329,15 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
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
@@ -400,7 +390,6 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->compressed_folios = compressed_folios;
 	cb->compressed_len = ordered->disk_num_bytes;
 	cb->writeback = writeback;
-	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_folios = nr_folios;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 062ebd9c2d32..c1a6c76827da 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -63,11 +63,8 @@ struct compressed_bio {
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
index 46b715f3447b..6a1fa3b08b3f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1774,8 +1774,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 		destroy_workqueue(fs_info->endio_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
-	if (fs_info->compressed_write_workers)
-		destroy_workqueue(fs_info->compressed_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
@@ -1987,8 +1985,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
 				      max_active, 2);
-	fs_info->compressed_write_workers =
-		alloc_workqueue("btrfs-compressed-write", flags, max_active);
 	fs_info->endio_freespace_worker =
 		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
 				      max_active, 0);
@@ -2004,7 +2000,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	if (!(fs_info->workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
-	      fs_info->compressed_write_workers &&
 	      fs_info->endio_write_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
@@ -4291,7 +4286,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * When finishing a compressed write bio we schedule a work queue item
-	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * to finish an ordered extent - end_bbio_compressed_write()
 	 * calls btrfs_finish_ordered_extent() which in turns does a call to
 	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
 	 * completion either in the endio_write_workers work queue or in the
@@ -4299,7 +4294,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
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


