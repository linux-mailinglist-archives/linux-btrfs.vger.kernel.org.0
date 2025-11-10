Return-Path: <linux-btrfs+bounces-18852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C465C49A25
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 23:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69F91886482
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37D2F659C;
	Mon, 10 Nov 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="priS5C2A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="priS5C2A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D42D6607
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814562; cv=none; b=JLcTvRnvOmlNVWh1Kf39txvbNwe/RhfP8KEP1g0addcHHJZONQK1EzXvxijwP3gOpe5LzLRMRd2vc8FU34IBrXaaaMuQrpwWtgjYkNfIX9TWcPhPEvTcXqKVkIzZAHZaaBEH+HOuZ+6nIUXPdxWutjYezuzwM8yc7ICi/VeeyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814562; c=relaxed/simple;
	bh=1vntNRPVaixZpzukVo9YleC9ZqP2SQobbzs+ELYSW4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLmsi1MlH73lW6mV262FyiVjART3LLWpJnJmu841+6th06jpid65O+R3o7Q2rxWPygU6OZdxpeLKzWFCWnn/5ZTYPAVbcQYgsA4m2MVz4T99+a0k02h+/pJolBC7BBYzKefumvp3Q+ybgemM4nMPnnF7YijX7TNeXajHd+21ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=priS5C2A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=priS5C2A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C01921E9D
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3RHOowVOsbrx3TpK7VH9wUp/95XkArhYrQe/fndTpI=;
	b=priS5C2Au5h7cREvVE1xBD1agWuKRWDEqUk2o5k1zG2eadJQl+LJumC7VzByVQxD3UbKcv
	9Cdz7mEwh4EK2GlcIII997/2QaA01QW4Le9e+y5/slZSRmWPgWlvhu3QO+IygUuts/kyKB
	esFvzessCR4E2DVWwcsI3fmb/sBpiqA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=priS5C2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3RHOowVOsbrx3TpK7VH9wUp/95XkArhYrQe/fndTpI=;
	b=priS5C2Au5h7cREvVE1xBD1agWuKRWDEqUk2o5k1zG2eadJQl+LJumC7VzByVQxD3UbKcv
	9Cdz7mEwh4EK2GlcIII997/2QaA01QW4Le9e+y5/slZSRmWPgWlvhu3QO+IygUuts/kyKB
	esFvzessCR4E2DVWwcsI3fmb/sBpiqA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69F4514623
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OINwC1JqEmk/agAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/4] btrfs: make read verification handle bs > ps cases without large folios
Date: Tue, 11 Nov 2025 09:12:00 +1030
Message-ID: <ad413e741fe89980436a5534d092c727733fc3bc.1762814274.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762814274.git.wqu@suse.com>
References: <cover.1762814274.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2C01921E9D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The current read verification is also relying on large folios to support
bs > ps cases, but that introduced quite some limits.

To enhance read-repair to support bs > ps without large folios:

- Make btrfs_data_csum_ok() to accept an array of paddrs
  Which can pass the paddrs[] direct into
  btrfs_calculate_block_csum_pages().

- Make repair_one_sector() to accept an array of paddrs
  So that it can submit a repair bio backed by regular pages, not only
  large folios.
  This requires us to allocate more slots at bio allocation time though.

  Also since the caller may have only partially advanced the saved_iter
  for bs > ps cases, we can not directly trust the logical bytenr from
  saved_iter (can be unaligned), thus a manual round down is necessary
  for the logical bytenr.

- Make btrfs_check_read_bio() to build an array of paddrs
  The tricky part is that we can only call btrfs_data_csum_ok() after
  all involved pages are assembled.

  This means at the call time of btrfs_check_read_bio(), our offset
  inside the bio is already at the end of the fs block.
  Thus we must re-calculate @bio_offset for btrfs_data_csum_ok() and
  repair_one_sector().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 62 ++++++++++++++++++++++++++++--------------
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       | 18 ++++++------
 3 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 383ea6731b35..fcd28eb68247 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -171,7 +171,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct btrfs_failed_bio *fbio = repair_bbio->private;
 	struct btrfs_inode *inode = repair_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
 	/*
 	 * We can not move forward the saved_iter, as it will be later
 	 * utilized by repair_bbio again.
@@ -188,8 +187,14 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	/* Repair bbio should be eaxctly one block sized. */
 	ASSERT(repair_bbio->saved_iter.bi_size == fs_info->sectorsize);
 
+	btrfs_bio_for_each_block(paddr, &repair_bbio->bio, &saved_iter, step) {
+		ASSERT(slot < nr_steps);
+		paddrs[slot] = paddr;
+		slot++;
+	}
+
 	if (repair_bbio->bio.bi_status ||
-	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bvec_phys(bv))) {
+	    !btrfs_data_csum_ok(repair_bbio, dev, 0, paddrs)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
 		repair_bbio->bio.bi_iter = repair_bbio->saved_iter;
 
@@ -204,12 +209,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		return;
 	}
 
-	btrfs_bio_for_each_block(paddr, &repair_bbio->bio, &saved_iter, step) {
-		ASSERT(slot < nr_steps);
-		paddrs[slot] = paddr;
-		slot++;
-	}
-
 	do {
 		mirror = prev_repair_mirror(fbio, mirror);
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
@@ -231,21 +230,25 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
  */
 static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 						  u32 bio_offset,
-						  phys_addr_t paddr,
+						  phys_addr_t paddrs[],
 						  struct btrfs_failed_bio *fbio)
 {
 	struct btrfs_inode *inode = failed_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct folio *folio = page_folio(phys_to_page(paddr));
 	const u32 sectorsize = fs_info->sectorsize;
-	const u32 foff = offset_in_folio(folio, paddr);
-	const u64 logical = (failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT);
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+	const u32 nr_steps = sectorsize / step;
+	/*
+	 * For bs > ps cases, the saved_iter can be partially moved forward.
+	 * In that case we should round it down to the block boundary.
+	 */
+	const u64 logical = round_down(failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
+				       sectorsize);
 	struct btrfs_bio *repair_bbio;
 	struct bio *repair_bio;
 	int num_copies;
 	int mirror;
 
-	ASSERT(foff + sectorsize <= folio_size(folio));
 	btrfs_debug(fs_info, "repair read error: read error at %llu",
 		    failed_bbio->file_offset + bio_offset);
 
@@ -265,10 +268,18 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	atomic_inc(&fbio->repair_count);
 
-	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
+	repair_bio = bio_alloc_bioset(NULL, nr_steps, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
-	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
-	bio_add_folio_nofail(repair_bio, folio, sectorsize, foff);
+	repair_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+	for (int i = 0; i < nr_steps; i++) {
+		int ret;
+
+		ASSERT(offset_in_page(paddrs[i]) + step <= PAGE_SIZE);
+
+		ret = bio_add_page(repair_bio, phys_to_page(paddrs[i]), step,
+				   offset_in_page(paddrs[i]));
+		ASSERT(ret == step);
+	}
 
 	repair_bbio = btrfs_bio(repair_bio);
 	btrfs_bio_init(repair_bbio, failed_bbio->inode, failed_bbio->file_offset + bio_offset,
@@ -284,10 +295,13 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u32 sectorsize = fs_info->sectorsize;
+	const u32 sectorsize = fs_info->sectorsize;
+	const u32 step = min(sectorsize, PAGE_SIZE);
+	const u32 nr_steps = sectorsize / step;
 	struct bvec_iter *iter = &bbio->saved_iter;
 	blk_status_t status = bbio->bio.bi_status;
 	struct btrfs_failed_bio *fbio = NULL;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
 	phys_addr_t paddr;
 	u32 offset = 0;
 
@@ -306,10 +320,16 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
-	btrfs_bio_for_each_block(paddr, &bbio->bio, iter, fs_info->sectorsize) {
-		if (status || !btrfs_data_csum_ok(bbio, dev, offset, paddr))
-			fbio = repair_one_sector(bbio, offset, paddr, fbio);
-		offset += sectorsize;
+	btrfs_bio_for_each_block(paddr, &bbio->bio, iter, step) {
+		paddrs[(offset / step) % nr_steps] = paddr;
+		offset += step;
+
+		if (IS_ALIGNED(offset, sectorsize)) {
+			if (status ||
+			    !btrfs_data_csum_ok(bbio, dev, offset - sectorsize, paddrs))
+				fbio = repair_one_sector(bbio, offset - sectorsize,
+							 paddrs, fbio);
+		}
 	}
 	if (bbio->csum != bbio->csum_inline)
 		kvfree(bbio->csum);
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index cac3ce4c8aa4..925b1f262075 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -554,7 +554,7 @@ void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, phys_addr_t paddr);
+			u32 bio_offset, const phys_addr_t paddrs[]);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4883d0de749e..51acb6d5ed47 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3420,12 +3420,13 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
 }
 
 /*
- * Verify the checksum of a single data sector.
+ * Verify the checksum of a single data sector, which can be scattered at
+ * different incontiguous pages.
  *
  * @bbio:	btrfs_io_bio which contains the csum
  * @dev:	device the sector is on
  * @bio_offset:	offset to the beginning of the bio (in bytes)
- * @bv:		bio_vec to check
+ * @paddrs:	physical addresses which back the fs block
  *
  * Check if the checksum on a data block is valid.  When a checksum mismatch is
  * detected, report the error and fill the corrupted range with zero.
@@ -3433,12 +3434,13 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
  * Return %true if the sector is ok or had no checksum to start with, else %false.
  */
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, phys_addr_t paddr)
+			u32 bio_offset, const phys_addr_t paddrs[])
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const u32 blocksize = fs_info->sectorsize;
-	struct folio *folio;
+	const u32 step = min(blocksize, PAGE_SIZE);
+	const u32 nr_steps = blocksize / step;
 	u64 file_offset = bbio->file_offset + bio_offset;
 	u64 end = file_offset + blocksize - 1;
 	u8 *csum_expected;
@@ -3458,7 +3460,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	if (btrfs_check_block_csum(fs_info, paddr, csum, csum_expected))
+	btrfs_calculate_block_csum_pages(fs_info, paddrs, csum);
+	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		goto zeroit;
 	return true;
 
@@ -3467,9 +3470,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 				    bbio->mirror_num);
 	if (dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	folio = page_folio(phys_to_page(paddr));
-	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
-	folio_zero_range(folio, offset_in_folio(folio, paddr), blocksize);
+	for (int i = 0; i < nr_steps; i++)
+		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
 	return false;
 }
 
-- 
2.51.2


