Return-Path: <linux-btrfs+bounces-7315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882F95660B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711B2B21BC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D115C122;
	Mon, 19 Aug 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQXygaYm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQXygaYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EA1534EC
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057542; cv=none; b=dm3IGTNWWl7nXuGkFgDAtpzGF9JMJAk1RQO18sk+WT0FT/QQBO9b66SUSkZVh4wguuzZh+VSmFMQmSR39lEwY09ZGXhp5MIBxTtPQ0Qjl4mhC0LirzUxESaiTrVeXh5+vBwODWVQ2uwW7x4oGu4T2e1ALMC1yuyoNJlDsyisza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057542; c=relaxed/simple;
	bh=Y8ASbUV2WBH0AvjjTJZqMxQeQoAOxFDHtqWSwwLPlz4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZEM93g/K1uUtYxnxgRYh8wAI5sRK+RaPsHvODM+Fk1f9lYsfMNfCaniKfgop48hTOnBTO/O1RD+bnDRZWYMVa/gx09ugTzSgBf91mMPiB2EgIZJRy1SDzwXve+l+GHP5OiyOaQekI1giplN4s0tFGNS6FHRQEFMGTLDvVr4K1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQXygaYm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQXygaYm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 982662299D
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724057537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IvLkhS5U7HbT8qaoDH6nPeQS8n+PZsMWzYVgWxrtK/U=;
	b=BQXygaYmyPaO3f+hS3/EYiu0JIdsapGpxAASAXY4kCRPp+RPO3RiZcCnPXjIcwSTzThU7R
	AlJE2fcw14BnqHRBMvi3+BHwU+j+VaQcag+SWLrl7thgTrDI4q2BqK7JX6NqWpvdCyFEKc
	ddr/2Ws25PZjDLdhkV3sJQkM8YTGoiw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724057537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IvLkhS5U7HbT8qaoDH6nPeQS8n+PZsMWzYVgWxrtK/U=;
	b=BQXygaYmyPaO3f+hS3/EYiu0JIdsapGpxAASAXY4kCRPp+RPO3RiZcCnPXjIcwSTzThU7R
	AlJE2fcw14BnqHRBMvi3+BHwU+j+VaQcag+SWLrl7thgTrDI4q2BqK7JX6NqWpvdCyFEKc
	ddr/2Ws25PZjDLdhkV3sJQkM8YTGoiw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17E2137C3
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 08:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N/RYJMAHw2bxHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 08:52:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()
Date: Mon, 19 Aug 2024 18:21:59 +0930
Message-ID: <2107a0e72fa6eac67583deb421ac1247b02b7723.1724057484.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

There is only two differences between the two functions:

- btrfs_orig_bbio_end_io() do extra error propagation
  This is mostly to allow tolerance for write errors.

- btrfs_orig_bbio_end_io() do extra pending_ios check
  This check can handle both the original bio, or the cloned one.
  (All accounting happens in the original one).

This makes btrfs_orig_bbio_end_io() a much safer call.
In fact we already had a double freeing error due to usage of
btrfs_bio_end_io() in the error path of btrfs_submit_chunk().

This patch will move the whole content of btrfs_orig_bbio_end_io() into
btrfs_bio_end_io().

For normal paths this brings no change, because they are already calling
btrfs_orig_bbio_end_io() in the first place.

For error paths (not only inside bio.c but also external callers), this
change will introduce extra checks, especially for external callers, as
they will error out without submitting the btrfs bio.

But considering it's already in the error path, such slower but much
safer checks are still an overall win.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 088ceaca6ab0..0e4de33515fe 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -120,12 +120,6 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
 	}
 }
 
-void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
-{
-	bbio->bio.bi_status = status;
-	__btrfs_bio_end_io(bbio);
-}
-
 static void btrfs_orig_write_end_io(struct bio *bio);
 
 static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
@@ -147,8 +141,9 @@ static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
 	}
 }
 
-static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
+void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
+	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
 
@@ -179,7 +174,7 @@ static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
 static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 {
 	if (atomic_dec_and_test(&fbio->repair_count)) {
-		btrfs_orig_bbio_end_io(fbio->bbio);
+		btrfs_bio_end_io(fbio->bbio, fbio->bbio->bio.bi_status);
 		mempool_free(fbio, &btrfs_failed_bio_pool);
 	}
 }
@@ -326,7 +321,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	if (fbio)
 		btrfs_repair_done(fbio);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
 static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
@@ -360,7 +355,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	if (is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
@@ -380,7 +375,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 	} else {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
 			btrfs_record_physical_zoned(bbio);
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	}
 }
 
@@ -394,7 +389,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, NULL);
 	else
-		btrfs_orig_bbio_end_io(bbio);
+		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 
 	btrfs_put_bioc(bioc);
 }
@@ -424,7 +419,7 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
-	btrfs_orig_bbio_end_io(bbio);
+	btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	btrfs_put_bioc(bioc);
 }
 
@@ -593,7 +588,7 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 	/* If an error occurred we just want to clean up the bio and move on. */
 	if (bio->bi_status) {
-		btrfs_orig_bbio_end_io(async->bbio);
+		btrfs_bio_end_io(async->bbio, async->bbio->bio.bi_status);
 		return;
 	}
 
@@ -761,8 +756,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
-	bbio->bio.bi_status = ret;
-	btrfs_orig_bbio_end_io(bbio);
+	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
 }
-- 
2.46.0


