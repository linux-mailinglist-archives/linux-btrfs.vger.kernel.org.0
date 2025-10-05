Return-Path: <linux-btrfs+bounces-17445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC9BBCD90
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 00:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12D6B4E75E5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Oct 2025 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789E1C701F;
	Sun,  5 Oct 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zl/AQRGZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zl/AQRGZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1639ACF
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759704125; cv=none; b=lNK5QIYbsAzUjy6MmphGKozkAg3frVugn6jDeSVTzBpqHl0OK9Wry4+eOwTpbJBrDV/YMEPUOxuyu0iOfJHYuWfFz99VoAKsA5nghd8aulojIeVQuWrUnSC9LqfTKl5fGYc9K8rDE+h478TvIUnzbqP0s6LEYZtirSxKLXVoz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759704125; c=relaxed/simple;
	bh=UI4FKyf1uwCsLULMSRSjXgq1sgfHkEh6nMGwU9EuNPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3taAPtI/5v3b3uyGoCveZ+zWWkZfVUNmbq3RPU5tjIfrktr5aAuy6zsiuAK+4HRwJLi82DGGeZS6jpeZamNqC92IL4kPbVkiN38GmOqZwUMBgAFusfEAbAd4/67c8n36jv8OAZwlXdM3nkd3J5sdxLSNMURdTMXmd4obNMPZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zl/AQRGZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zl/AQRGZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CAAF336E4
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759704104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qM1EZMdsUktzIpR1BgjS+ayiHZnLJ01DF7XVOUt/6oc=;
	b=Zl/AQRGZMvPeHD6zYNJNbwbqTz+564o6RGi+OZaTnnsc5fbIsQ8l5m6NDk2BwE9UyTgRso
	NzYRmZDY1+Dp/VRv1eGgsxEYV9qdLVLjySrJyjufBLXEof7Vr4qHkeJUvTWuD4o0a6bXbj
	e3FY9PExNcJXiJJXVx4J74ggY38LO9o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759704104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qM1EZMdsUktzIpR1BgjS+ayiHZnLJ01DF7XVOUt/6oc=;
	b=Zl/AQRGZMvPeHD6zYNJNbwbqTz+564o6RGi+OZaTnnsc5fbIsQ8l5m6NDk2BwE9UyTgRso
	NzYRmZDY1+Dp/VRv1eGgsxEYV9qdLVLjySrJyjufBLXEof7Vr4qHkeJUvTWuD4o0a6bXbj
	e3FY9PExNcJXiJJXVx4J74ggY38LO9o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DCE813995
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 22:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EuNACf04miFJQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 05 Oct 2025 22:41:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
Date: Mon,  6 Oct 2025 09:11:21 +1030
Message-ID: <6ece8dbda3a4b5e7d2d521a7751e59801a8a685d.1759703432.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -2.80

Currently btrfs_repair_io_failure() only accept a single @paddr
parameter, and for bs > ps cases it's required that @paddr is backed by
a large folio.

That assumption has quite some limits, preventing us from utilizing true
zero-copy direct-io and encoded read/writes.

To address the problem, enhance btrfs_repair_io_failure() by:

- Accept an array of paddrs, up to 64K / PAGE_SIZE entries
  This kind acts like a bio_vec, but with very limited entries, as the
  function is only utilized to repair one fs data block, or a tree block.

  Both has a upper size limit (BTRFS_MAX_BLOCK_SIZE, aka 64K), so we
  don't need the full bio_vec thing to handle it.

- Allocate a bio with multiple slots
  Previously even for bs > ps cases, we only pass in a contiguous
  physical address range, thus a single slot will be enough.

  But not any more, so we have to allocate a bio structure, other than
  using the on-stack one.

- Use on-stack memory to allocate @paddrs array
  It's at most 16 pages (4K page size, 64K block size), will take up at
  most 128 bytes.
  I think the on-stack cost is still acceptable.

- Add one extra check to make sure the repair bio is exactly one block

- Utilize btrfs_repair_io_failure() to submit a single bio for metadata
  This should improve the read-repair performance for metadata, as now
  we submit a node sized bio then wait, other than submit each block of
  the metadata and wait for each submitted block.

- Reduce the width of @length parameter of btrfs_repair_io_failure()
  Since we only call btrfs_repair_io_failure() on a single data or
  metadata block, u64 is overkilled.
  Use u32 instead and add one extra ASSERT()s to make sure the length
  never exceed BTRFS_MAX_BLOCK_SIZE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c     | 66 ++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/bio.h     |  2 +-
 fs/btrfs/disk-io.c | 29 ++++++++++++--------
 3 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 21df48e6c4fa..5034a9eaf2f0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -164,7 +164,21 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct btrfs_inode *inode = repair_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
+	/*
+	 * We can not move forward the saved_iter, as it will be later
+	 * utilized by repair_bbio again.
+	 */
+	struct bvec_iter saved_iter = repair_bbio->saved_iter;
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+	const u64 logical = repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT;
+	const u32 nr_steps = repair_bbio->saved_iter.bi_size / step;
 	int mirror = repair_bbio->mirror_num;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
+	phys_addr_t paddr;
+	unsigned int slot = 0;
+
+	/* Repair bbio should be eaxctly one block sized. */
+	ASSERT(repair_bbio->saved_iter.bi_size == fs_info->sectorsize);
 
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bvec_phys(bv))) {
@@ -182,12 +196,17 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		return;
 	}
 
+	btrfs_bio_for_each_block(paddr, &repair_bbio->bio, &saved_iter, step) {
+		ASSERT(slot < nr_steps);
+		paddrs[slot] = paddr;
+		slot++;
+	}
+
 	do {
 		mirror = prev_repair_mirror(fbio, mirror);
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
-				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  bvec_phys(bv), mirror);
+				  logical, paddrs, mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
@@ -824,18 +843,34 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
  *
  * The I/O is issued synchronously to block the repair read completion from
  * freeing the bio.
+ *
+ * @ino:	Offending inode number
+ * @fileoff:	File offset inside the inode
+ * @length:	Length of the repair write
+ * @logical:	Logical address of the range
+ * @paddrs:	Physical address array of the content.
+ *		Length for each paddr should be min(sectorsize, PAGE_SIZE).
+ * @mirror_num: Mirror number to write to. Must not be zero.
  */
-int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, phys_addr_t paddr, int mirror_num)
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
+			    u32 length, u64 logical, const phys_addr_t paddrs[], int mirror_num)
 {
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+	const u32 nr_steps = DIV_ROUND_UP_POW2(length, step);
 	struct btrfs_io_stripe smap = { 0 };
-	struct bio_vec bvec;
-	struct bio bio;
+	struct bio *bio = NULL;
 	int ret = 0;
 
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	/* Basic alignment checks. */
+	ASSERT(IS_ALIGNED(logical, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(length, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(fileoff, fs_info->sectorsize));
+	/* Either it's a single data or metadata block. */
+	ASSERT(length <= BTRFS_MAX_BLOCKSIZE);
+
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
@@ -855,24 +890,27 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		goto out_counter_dec;
 	}
 
-	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-	__bio_add_page(&bio, phys_to_page(paddr), length, offset_in_page(paddr));
-	ret = submit_bio_wait(&bio);
+	bio = bio_alloc(smap.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
+	bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
+	for (int i = 0; i < nr_steps; i++) {
+		ret = bio_add_page(bio, phys_to_page(paddrs[i]), step, offset_in_page(paddrs[i]));
+		/* We should have allocated enough slots to contain all the different pages. */
+		ASSERT(ret == step);
+	}
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
 		btrfs_dev_stat_inc_and_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
-		goto out_bio_uninit;
+		goto out_counter_dec;
 	}
 
 	btrfs_info_rl(fs_info,
 		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-			     ino, start, btrfs_dev_name(smap.dev),
+			     ino, fileoff, btrfs_dev_name(smap.dev),
 			     smap.physical >> SECTOR_SHIFT);
 	ret = 0;
 
-out_bio_uninit:
-	bio_uninit(&bio);
 out_counter_dec:
 	btrfs_bio_counter_dec(fs_info);
 	return ret;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 00883aea55d7..e93e7ab6322a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -112,6 +112,6 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			    u64 length, u64 logical, phys_addr_t paddr, int mirror_num);
+			    u32 length, u64 logical, const phys_addr_t paddrs[], int mirror_num);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f475fb2272ac..2623b84dd6ed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -182,26 +182,33 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	const u32 step = min(fs_info->nodesize, PAGE_SIZE);
+	const u32 nr_steps = eb->len / step;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
 	int ret = 0;
 
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
-	for (int i = 0; i < num_extent_folios(eb); i++) {
+	for (int i = 0; i < num_extent_pages(eb); i++) {
 		struct folio *folio = eb->folios[i];
-		u64 start = max_t(u64, eb->start, folio_pos(folio));
-		u64 end = min_t(u64, eb->start + eb->len,
-				folio_pos(folio) + eb->folio_size);
-		u32 len = end - start;
-		phys_addr_t paddr = PFN_PHYS(folio_pfn(folio)) +
-				    offset_in_folio(folio, start);
 
-		ret = btrfs_repair_io_failure(fs_info, 0, start, len, start,
-					      paddr, mirror_num);
-		if (ret)
-			break;
+		/* No large folio support yet. */
+		ASSERT(folio_order(folio) == 0);
+		ASSERT(i < nr_steps);
+
+		/*
+		 * For nodesize < page size, there is just one paddr, with some
+		 * offset inside the page.
+		 *
+		 * For nodesize >= page size, it's one or more paddrs, and eb->start
+		 * must be aligned to page boundary.
+		 */
+		paddrs[i] = page_to_phys(&folio->page) + offset_in_page(eb->start);
 	}
 
+	ret = btrfs_repair_io_failure(fs_info, 0, eb->start, eb->len, eb->start,
+				      paddrs, mirror_num);
 	return ret;
 }
 
-- 
2.50.1


