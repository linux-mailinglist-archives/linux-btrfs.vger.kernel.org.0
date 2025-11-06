Return-Path: <linux-btrfs+bounces-18767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D2C39D3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B03BAA68
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFD308F15;
	Thu,  6 Nov 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bT7E6ZAI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NLpJ7D7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EC35965
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421559; cv=none; b=QSiaL7PU1dUtl2sGm6FI8v0eb4wKVg9CUAQnTnmA3eaXOtcVAVoeeTyIZvPTJut08yFsh2mkBt9uuTI+L49b7hcAPp3NAcogwbeby9kL86TLxbMiEUyLed1hEPEfHvaMITfXk8VLswRkmvZXwfSYOx1GXjvqeHQuBitBQ6wE6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421559; c=relaxed/simple;
	bh=RPoh8GjrxMLHyH8d3ho66PAw7Vl3rXjp91M6a6aihWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L6vidSoAZX8CAfWCTtIE5PuLRCSZwdaHPYYyWeEM8ls1CmAqGf7Ajh/+MhlRVVBw2gp7kbP9DNEXLKJeCYmvwuCKftJBUZ8aZVhvAClpZbi0oV1rY7TtZa4ps9/bk4QzPsm6wxG1uk9mkYORUzf99yBkh9WT1Nx2jXCRed4soFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bT7E6ZAI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NLpJ7D7z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A44D5211D4
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762421554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/NubLzH9qE5I6wDmPMa3byO7JLV/jsMyLXBSCrfnc7M=;
	b=bT7E6ZAIl9h3TWz1tHZ0wMc0vtHFspTx5A9ZosHbj7qTdPGiyo1XJPYG5Jqgm6ZSbJMxPN
	ttRe5PCRDBRgVth0vCDUHIihvg/chdBg+A7zLL5UjKmA+oabdiGgRRZO60HOa/4OvKoiIp
	ph0ebasr6AkjbeY9y19ILhXEWOy/nQs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NLpJ7D7z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762421553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/NubLzH9qE5I6wDmPMa3byO7JLV/jsMyLXBSCrfnc7M=;
	b=NLpJ7D7zR8Vbb6kG9iv9K0taYwKzvftp+mTXQMkCW6ZZA/wrorFMQFjt2DmhmxlheAKk1k
	+b8CVRf/x0zEQPl3T6vj7u4TnWko4PXDk+LyeLlZG4yqt9SeiNUFeU6Bkv01AUkTmAhkXp
	s0K6WWx2cE5ac8JAN3hBtYcD10KVdp4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB099139A9
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGxkJjBrDGkJGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 09:32:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: extract the parity scrub code into a helper
Date: Thu,  6 Nov 2025 20:02:15 +1030
Message-ID: <a07e2c42e9f29dce1bb50a9b875cf29dfa909afd.1762421429.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A44D5211D4
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

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
Changelog:
v2:
- Rebased to the latest for-next branch
  The latest branch has the memory leak fixed merged, causing a minor
  conflict.

- Remove the DECLARE_COMPLETION_ONSTACK() inside the caller
  Which is no longer utilized.
---
 fs/btrfs/scrub.c | 93 +++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b6278406a103..726e0c5ed4f2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2113,24 +2113,69 @@ static int should_cancel_scrub(const struct scrub_ctx *sctx)
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
 				      struct btrfs_chunk_map *map,
 				      u64 full_stripe_start)
 {
-	DECLARE_COMPLETION_ONSTACK(io_done);
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
@@ -2252,42 +2297,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
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
-		bio_put(bio);
-		btrfs_put_bioc(bioc);
-		btrfs_bio_counter_dec(fs_info);
-		goto out;
-	}
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap,
-				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
-	btrfs_put_bioc(bioc);
-	if (!rbio) {
-		ret = -ENOMEM;
-		bio_put(bio);
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


