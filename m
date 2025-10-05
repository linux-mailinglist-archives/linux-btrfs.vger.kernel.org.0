Return-Path: <linux-btrfs+bounces-17443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA0BBCD8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 00:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C99084E76BB
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Oct 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473461E1E1C;
	Sun,  5 Oct 2025 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m9EzlDbj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m9EzlDbj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C7187332
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759704111; cv=none; b=NM7TTBnFll6pJr/qCS6KD9xJRTbm6/By37x1l2QmbZb2dNZ5pOiidgoKAJz74eVrmdf7h8PQvjJIihZKcJLmWkjUzpHs3hPiFK2myyoEe/ekVIz+9u6pONqFJzS0opQLrL7Zf5t92oJezmHbXd2bEF7JNsyGxXUG4RTjQHDXVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759704111; c=relaxed/simple;
	bh=cooyZDxiVQSvdEVRMtShGfYuU/3zm9ELvXFSRGH2Tqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhDg3hMRj5oI0b/Fam3ZZAdR8Jo+PZMT5bUrHdIk5I1qsbQo46QbyAapcZCQmzHRk3TMV2vdrkvUbtjrTMxlK6Gim7ThdXsbiDuSqz/UOEtN9WuzxdVPf/P7ihmj8mhAZsHVytyEPQdwBilj7ULcgVhYDJFCpJLKsuWdfiCXqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m9EzlDbj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m9EzlDbj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39F5F1F451
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759704105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myvNQgyB/CF0t4jaIntmZNiIsL76JPZbWlCjg/zQ/lg=;
	b=m9EzlDbjvEu7zIC56FJZ/A7IphHjGJE4AF3NsXUm0qBl5u1hAojqe1/eUoch4ql6rqRJaY
	tsHWUy/gHdSSHI6KM8MtTzjE1Vp+QV4v3MXL65m/pSAl1fNCNlPED9snlpFAUrnLDRLCHN
	XfP4Lpa01xvVHFWdyuz/Kke/y7S3Ti8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759704105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myvNQgyB/CF0t4jaIntmZNiIsL76JPZbWlCjg/zQ/lg=;
	b=m9EzlDbjvEu7zIC56FJZ/A7IphHjGJE4AF3NsXUm0qBl5u1hAojqe1/eUoch4ql6rqRJaY
	tsHWUy/gHdSSHI6KM8MtTzjE1Vp+QV4v3MXL65m/pSAl1fNCNlPED9snlpFAUrnLDRLCHN
	XfP4Lpa01xvVHFWdyuz/Kke/y7S3Ti8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74CED13995
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLPzDSj04miFJQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 05 Oct 2025 22:41:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: make read verification handle bs > ps cases without large folios
Date: Mon,  6 Oct 2025 09:11:22 +1030
Message-ID: <c8265dae88dabf133ada66109ea981a6f77fa41c.1759703432.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759703432.git.wqu@suse.com>
References: <cover.1759703432.git.wqu@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index 5034a9eaf2f0..6642318320eb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -163,7 +163,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct btrfs_failed_bio *fbio = repair_bbio->private;
 	struct btrfs_inode *inode = repair_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
 	/*
 	 * We can not move forward the saved_iter, as it will be later
 	 * utilized by repair_bbio again.
@@ -180,8 +179,14 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
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
 
@@ -196,12 +201,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
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
@@ -223,21 +222,25 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
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
 
@@ -257,10 +260,18 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
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
 	btrfs_bio_init(repair_bbio, fs_info, NULL, fbio);
@@ -277,10 +288,13 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
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
 
@@ -299,10 +313,16 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
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
 		kfree(bbio->csum);
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 03c107ab391b..ef3f2c1f7a77 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -549,7 +549,7 @@ void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, phys_addr_t paddr);
+			u32 bio_offset, const phys_addr_t paddrs[]);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 287c67296a7d..dbc5fad7b9a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3407,12 +3407,13 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
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
@@ -3420,12 +3421,13 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
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
@@ -3445,7 +3447,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	if (btrfs_check_block_csum(fs_info, paddr, csum, csum_expected))
+	btrfs_calculate_block_csum_pages(fs_info, paddrs, csum);
+	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		goto zeroit;
 	return true;
 
@@ -3454,9 +3457,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
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
2.50.1


