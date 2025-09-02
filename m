Return-Path: <linux-btrfs+bounces-16578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0402B3F992
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE61B22715
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3292EA743;
	Tue,  2 Sep 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OlJNJTyZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OlJNJTyZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16052EAB60
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803768; cv=none; b=ivUzBQ3+gtLHrPSNlLTByRuIDZSj2ZVedXSFGszWD7StiiWWVlg1bbGxLZgRZLFsKfw+zrbbi2tzfQcUA9ZHD3W3juNgcPsnBn38Sh7hvRZXII4QB6CkjlqnDFxEYklU0BUpM2gpild4A40hDo4TZ3thBDCWF/oJ3JMQ51CC49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803768; c=relaxed/simple;
	bh=tpQ+y+4EbsAjL5E2kOdtT7Oe33iiR4DSQsbhYvgsiiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb6DNMeEQ3b6F+UAPwunTB9P1DNctIHi9ZJIADapeiq62b+5GnilUAUnoyU+H1ahrxW4ubuvNLh4hsT2BhkboNKGAEnCW9n6eGck18tapUL++yr/FHdV13QWnbm3dUWmoeFu9DBHP12jQKaicDcwmaDJFzDQJY91LOFsS6+JfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OlJNJTyZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OlJNJTyZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A71991F44E
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdW0AwJESvQk6Od4697lWZDlDBVRgJKpV7zXfPtNRUg=;
	b=OlJNJTyZ7+2sDGUjMSX/sPxeOncxw2+dyph/U+eYuqc0Dgnjygg947LLtd+fxl2oTs1r0H
	z72dtlWRLO7YLYZZkHoUZ4KsbpoUcxb30aPf/EPKI84LyQR4tqq1eY5Ca0mWquna0K1ide
	GlYXX6ZJqamUueA1r+8CMe4nQjFjro8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OlJNJTyZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdW0AwJESvQk6Od4697lWZDlDBVRgJKpV7zXfPtNRUg=;
	b=OlJNJTyZ7+2sDGUjMSX/sPxeOncxw2+dyph/U+eYuqc0Dgnjygg947LLtd+fxl2oTs1r0H
	z72dtlWRLO7YLYZZkHoUZ4KsbpoUcxb30aPf/EPKI84LyQR4tqq1eY5Ca0mWquna0K1ide
	GlYXX6ZJqamUueA1r+8CMe4nQjFjro8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDFA613888
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4K85J66ytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: introduce btrfs_bio_for_each_block_all() helper
Date: Tue,  2 Sep 2025 18:32:15 +0930
Message-ID: <85543e15b7440b4d7b8f88d1e5384a0b2dafa693.1756803640.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756803640.git.wqu@suse.com>
References: <cover.1756803640.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A71991F44E
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Currently if we want to iterate all blocks inside a bio, we do something
like this:

	bio_for_each_segment_all(bvec, bio, iter_all) {
		for (off = 0; off < bvec->bv_len; off += sectorsize) {
			/* Iterate blocks using bv + off */
		}
	}

That's fine for now, but it will not handle future bs > ps, as
bio_for_each_segment_all() is a single-page iterator, it will always
return a bvec that's no larger than a page.

But for bs > ps cases, we need a full folio (which covers at least one
block) so that we can work on the block.

To address this problem and handle future bs > ps cases better:

- Introduce a helper btrfs_bio_for_each_block_all()
  This helper will create a local bvec_iter, which has the size of the
  target bio. Then grab the current physical address of the current
  location, then advance the iterator by block size.

- Use btrfs_bio_for_each_block_all() to replace existing call sites
  Including:

  * set_bio_pages_uptodate() in raid56
  * verify_bio_data_sectors() in raid56

  Both will result much easier to read code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/misc.h   | 24 +++++++++++++++++++++++
 fs/btrfs/raid56.c | 49 +++++++++++++++++++----------------------------
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index f210f808311f..2352ab56dbb3 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -45,6 +45,30 @@ static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
 	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
 	     bio_advance_iter_single((bio), (iter), (blocksize)))
 
+/* Helper to initialize a bvec_iter to the size of the specified bio. */
+static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	u32 bio_size = 0;
+	int i;
+
+	bio_for_each_bvec_all(bvec, bio, i)
+		bio_size += bvec->bv_len;
+
+	return (struct bvec_iter) {
+		.bi_sector = 0,
+		.bi_size = bio_size,
+		.bi_idx = 0,
+		.bi_bvec_done = 0,
+	};
+}
+
+#define btrfs_bio_for_each_block_all(paddr, bio, blocksize)		\
+	for (struct bvec_iter iter = init_bvec_iter_for_bio(bio);	\
+	     (iter).bi_size &&						\
+	     (paddr = bio_iter_phys((bio), &(iter)), 1);		\
+	     bio_advance_iter_single((bio), &(iter), (blocksize)))
+
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 389f1b617fe7..2b4f577dcf39 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1510,22 +1510,17 @@ static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
  */
 static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	const u32 blocksize = rbio->bioc->fs_info->sectorsize;
+	phys_addr_t paddr;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct sector_ptr *sector;
-		phys_addr_t paddr = bvec_phys(bvec);
+	btrfs_bio_for_each_block_all(paddr, bio, blocksize) {
+		struct sector_ptr *sector = find_stripe_sector(rbio, paddr);
 
-		for (u32 off = 0; off < bvec->bv_len; off += sectorsize) {
-			sector = find_stripe_sector(rbio, paddr + off);
-			ASSERT(sector);
-			if (sector)
-				sector->uptodate = 1;
-		}
+		ASSERT(sector);
+		if (sector)
+			sector->uptodate = 1;
 	}
 }
 
@@ -1572,8 +1567,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	phys_addr_t paddr;
 
 	/* No data csum for the whole stripe, no need to verify. */
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
@@ -1583,23 +1577,20 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
 		return;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		for (u32 off = 0; off < bvec->bv_len;
-		     off += fs_info->sectorsize, total_sector_nr++) {
-			u8 csum_buf[BTRFS_CSUM_SIZE];
-			u8 *expected_csum = rbio->csum_buf +
-					    total_sector_nr * fs_info->csum_size;
-			int ret;
+	btrfs_bio_for_each_block_all(paddr, bio, fs_info->sectorsize) {
+		u8 csum_buf[BTRFS_CSUM_SIZE];
+		u8 *expected_csum = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
+		int ret;
 
-			/* No csum for this sector, skip to the next sector. */
-			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
-				continue;
+		/* No csum for this sector, skip to the next sector. */
+		if (!test_bit(total_sector_nr, rbio->csum_bitmap))
+			continue;
 
-			ret = btrfs_check_block_csum(fs_info, bvec_phys(bvec) + off,
-						     csum_buf, expected_csum);
-			if (ret < 0)
-				set_bit(total_sector_nr, rbio->error_bitmap);
-		}
+		ret = btrfs_check_block_csum(fs_info, paddr,
+					     csum_buf, expected_csum);
+		if (ret < 0)
+			set_bit(total_sector_nr, rbio->error_bitmap);
+		total_sector_nr++;
 	}
 }
 
-- 
2.50.1


