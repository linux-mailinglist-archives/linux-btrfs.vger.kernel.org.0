Return-Path: <linux-btrfs+bounces-18751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C4C38F0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 04:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9CE1A234BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138621A434;
	Thu,  6 Nov 2025 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IvQjlCxp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kz+G9VOb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC33C38
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398150; cv=none; b=kIaUXACfEjRtU0cbIMRL+2IJ+B3GVq7B0ZHktrnkLhvQzGmwEnXD5FtjntSUHxedkN/kCqzuyUXkhzQ1B3omEKrl4E1uaxoX9MuOIi/rhq4BbVjEqcncBtrWqQtHOdrIDALo+bSza99+Kz1RURbjXkDaqS3AKtgCGe6BfI9NyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398150; c=relaxed/simple;
	bh=wTulpwVUJwsMCjeY/tgThum1RnB4u+k0w8ccLI+sZts=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nbmbHM02tLOV5sh24TI4wjpkY5vPCRyzIT8IF9Zrh20+tc2folDthCXy5kFxnZLLeo6W7H4neztXopEZhjt4UUoCpgYo7sAKCiJzpTBekYr4ZgEWTFlNGsLzSdsZMqL0NbXEP4pq1sxzbcEyBnLCSQisurN1iSw9NCxbDw92LFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IvQjlCxp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kz+G9VOb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 691321F393
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762398145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8oS24VYZN4iZqQBhct5k+Q9hpzxh9rS9SFUVuSmaBU=;
	b=IvQjlCxp4R20vAGxwt7xAe+R20lhJIHVBNA+cps87SoaQqbz0QHMh60iu0KrEetjJWFHNn
	FVmgaEWgZ8psBOlqJEWZoxvhNcheKMwSNhSz7PXLTHRrGzlSfL6Br7S6oKSZBw/N5rivch
	EZ7MMWb/uVA/KLbGfVTD2VVkFCiooJA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762398144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j8oS24VYZN4iZqQBhct5k+Q9hpzxh9rS9SFUVuSmaBU=;
	b=Kz+G9VObFhvt+6pEQiBaFT3bXbDxaXlyWyrgzzKykqCdbu4hvSW1UjzdfEXbHd5CmlQaJu
	twn0t2xFztJ63nnkv3irgpByLZFwv+iH8yFJkGGvfZEFlwZnRWFTJzXWnO59c+AEv4bNYO
	ebopvfDprHmh7XcXeOF2MQGlpG70lOA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D0F139A9
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 03:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tXETFr8PDGklIwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 03:02:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: extract the parity scrub code into a helper
Date: Thu,  6 Nov 2025 13:32:05 +1030
Message-ID: <2d2cfb7729a65d88ea8b9d6408611d0cc76e1ab7.1762398098.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The function scrub_raid56_parity_stripe() is handling the partity stripe
by the following steps:

- Scrub each data stripes
  And make sure everything is fine in each data stripe

- Cache the data stripe into the raid bio

- Use the cached raid bio to scrub the target parity stripe

Extract the last two steps into a new helper,
scrub_radi56_cached_parity(), as a cleanup and make the error handling
more straightforward.

With the following minor cleanups:

- Use on-stack bio structure
  The bio is always empty thus we do not need any bio vector nor the
  block device. Thus there is no need to allocate a bio, the on-stack
  one is more than enough to cut it.

- Remove the unnecessary btrfs_put_bioc() call if btrfs_map_block()
  failed
  If btrfs_map_block() is failed, @bioc_ret will not be touched thus
  there is no need to call btrfs_put_bioc() in this case.

- Use a proper out: tag to do the cleanup
  Now the error cleanup is much shorter and simpler, just
  btrfs_bio_counter_dec() and bio_uninit().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e3612202ba55..8c360d941bd5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2113,6 +2113,56 @@ static int should_cancel_scrub(const struct scrub_ctx *sctx)
 	return 0;
 }
 
+static int scrub_raid56_cached_parity(struct scrub_ctx *sctx,
+				      struct btrfs_device *scrub_dev,
+				      struct btrfs_chunk_map *map,
+				      u64 full_stripe_start,
+				      unsigned long *extent_bitmap)
+{
+	DECLARE_COMPLETION_ONSTACK(io_done);
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_raid_bio *rbio;
+	struct bio bio;
+	const int data_stripes = nr_data_stripes(map);
+	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
+	int ret;
+
+	bio_init(&bio, NULL, NULL, 0, REQ_OP_READ);
+	bio.bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
+	bio.bi_private = &io_done;
+	bio.bi_end_io = raid56_scrub_wait_endio;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
+			      &length, &bioc, NULL, NULL);
+	if (ret < 0)
+		goto out;
+	/* For RAID56 write there must be an @bioc allocated. */
+	ASSERT(bioc);
+	rbio = raid56_parity_alloc_scrub_rbio(&bio, bioc, scrub_dev, extent_bitmap,
+				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+	btrfs_put_bioc(bioc);
+	if (!rbio) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Use the recovered stripes as cache to avoid read them from disk again. */
+	for (int i = 0; i < data_stripes; i++) {
+		struct scrub_stripe *stripe = &sctx->raid56_data_stripes[i];
+
+		raid56_parity_cache_data_folios(rbio, stripe->folios,
+				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
+	}
+	raid56_parity_submit_scrub_rbio(rbio);
+	wait_for_completion_io(&io_done);
+	ret = blk_status_to_errno(bio.bi_status);
+out:
+	btrfs_bio_counter_dec(fs_info);
+	bio_uninit(&bio);
+	return ret;
+}
+
 static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				      struct btrfs_device *scrub_dev,
 				      struct btrfs_block_group *bg,
@@ -2121,16 +2171,12 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 {
 	DECLARE_COMPLETION_ONSTACK(io_done);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_raid_bio *rbio;
-	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_path extent_path = { 0 };
 	struct btrfs_path csum_path = { 0 };
-	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
 	const int data_stripes = nr_data_stripes(map);
 	unsigned long extent_bitmap = 0;
-	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
 	int ret;
 
 	ASSERT(sctx->raid56_data_stripes);
@@ -2252,40 +2298,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	}
 
 	/* Now we can check and regenerate the P/Q stripe. */
-	bio = bio_alloc(NULL, 1, REQ_OP_READ, GFP_NOFS);
-	bio->bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
-	bio->bi_private = &io_done;
-	bio->bi_end_io = raid56_scrub_wait_endio;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
-			      &length, &bioc, NULL, NULL);
-	if (ret < 0) {
-		btrfs_put_bioc(bioc);
-		btrfs_bio_counter_dec(fs_info);
-		goto out;
-	}
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap,
-				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
-	btrfs_put_bioc(bioc);
-	if (!rbio) {
-		ret = -ENOMEM;
-		btrfs_bio_counter_dec(fs_info);
-		goto out;
-	}
-	/* Use the recovered stripes as cache to avoid read them from disk again. */
-	for (int i = 0; i < data_stripes; i++) {
-		stripe = &sctx->raid56_data_stripes[i];
-
-		raid56_parity_cache_data_folios(rbio, stripe->folios,
-				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
-	}
-	raid56_parity_submit_scrub_rbio(rbio);
-	wait_for_completion_io(&io_done);
-	ret = blk_status_to_errno(bio->bi_status);
-	bio_put(bio);
-	btrfs_bio_counter_dec(fs_info);
-
+	ret = scrub_raid56_cached_parity(sctx, scrub_dev, map, full_stripe_start,
+					 &extent_bitmap);
 out:
 	btrfs_release_path(&extent_path);
 	btrfs_release_path(&csum_path);
-- 
2.51.2


