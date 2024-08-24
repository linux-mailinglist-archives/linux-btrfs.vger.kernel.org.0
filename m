Return-Path: <linux-btrfs+bounces-7472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F095DD55
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12701F220AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275215575C;
	Sat, 24 Aug 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bEiBAs7h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bEiBAs7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CE154C0B
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724494032; cv=none; b=qdhEK2RhNdbk8NJGO/T5iyBxX5e1Yz+tqZvgqG8vssund0ALxf9RkTV+qSUIscIihkc8BeqbNFrbrrdgc8hf0URokzrYYNzC06XqoYgl9DpC5EU3K0uQrkKVTawcbP6GEIQqhKxQRMalxcZ+zhmHn7lA3yMDH2Dyga52AMGxUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724494032; c=relaxed/simple;
	bh=WLStSTXxL/zHx6ynKuc2nSXw6FWwnkWumZqRtGqzHf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jA02/bzugHn0BstDM9wvIBRhlUxsS2FbMUY9sxP4Uz4gztw0v8ddKAwA/zbhax6dQBhLcjXckidNfpCRx6XA+4n5H3f+FF7tJFPa2by0XDyrSTlEQMhiLq0TM19QRzcIulIjygvwqYHh+AanbYhztatLDJR4rExR1K0ylQe8wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bEiBAs7h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bEiBAs7h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1089227B0;
	Sat, 24 Aug 2024 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724494022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VRmyUaq37mC3xbNOhIkvjJQ4h9pLgpM5bj1yhuV/ifU=;
	b=bEiBAs7hMFjm+zzR/aAdosu2XljZgKbF/Ut4xwSi77YQwAo3g4hLVJIJTnrSdkm6Q/vjrj
	mZ78Shy55+hGPzRhyNLzKV3gSV1PqidpK2mALCXZ1W5jTp9mJvxvmdZP5qbUL666Evwb0Y
	oXzKGOzU1khP4BJbDZOwV3kYgU1cbNo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724494022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VRmyUaq37mC3xbNOhIkvjJQ4h9pLgpM5bj1yhuV/ifU=;
	b=bEiBAs7hMFjm+zzR/aAdosu2XljZgKbF/Ut4xwSi77YQwAo3g4hLVJIJTnrSdkm6Q/vjrj
	mZ78Shy55+hGPzRhyNLzKV3gSV1PqidpK2mALCXZ1W5jTp9mJvxvmdZP5qbUL666Evwb0Y
	oXzKGOzU1khP4BJbDZOwV3kYgU1cbNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B2613A1F;
	Sat, 24 Aug 2024 10:07:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C1VqHcWwyWZMKAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 24 Aug 2024 10:07:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()
Date: Sat, 24 Aug 2024 19:36:43 +0930
Message-ID: <a3420f0dc1e19845295ef7341e84789efb9809a3.1724493980.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

There is only two differences between the two functions:

- btrfs_orig_bbio_end_io() do extra error propagation
  This is mostly to allow tolerance for write errors.

- btrfs_orig_bbio_end_io() do extra pending_ios check
  This check can handle both the original bio, or the cloned one.
  (All accounting happens in the original one).

This makes btrfs_orig_bbio_end_io() a much safer call.
In fact we already had a double freeing error due to usage of
btrfs_bio_end_io() in the error path of btrfs_submit_chunk().

So just move the whole content of btrfs_orig_bbio_end_io() into
btrfs_bio_end_io().

For normal paths this brings no change, because they are already calling
btrfs_orig_bbio_end_io() in the first place.

For error paths (not only inside bio.c but also external callers), this
change will introduce extra checks, especially for external callers, as
they will error out without submitting the btrfs bio.

But considering it's already in the error path, such slower but much
safer checks are still an overall win.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Updated with the v4 fix of the use-after-free bug
  To properly end the remaining bbio.
---
 fs/btrfs/bio.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f6cb58d7f16a..93f0994336d7 100644
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
 
@@ -768,11 +763,9 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
 		ASSERT(remaining);
 
-		remaining->bio.bi_status = ret;
-		btrfs_orig_bbio_end_io(remaining);
+		btrfs_bio_end_io(remaining, ret);
 	}
-	bbio->bio.bi_status = ret;
-	btrfs_orig_bbio_end_io(bbio);
+	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
 }
-- 
2.46.0


