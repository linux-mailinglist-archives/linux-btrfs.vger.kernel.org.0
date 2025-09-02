Return-Path: <linux-btrfs+bounces-16579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D7B3F993
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065DD1B22B94
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058F2EB5D4;
	Tue,  2 Sep 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T8HAkuut";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T8HAkuut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965D2EA75E
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803768; cv=none; b=aU1SIHvY4HdKZXp/wDWdetajTi/zVoai3L9mP3kuEb0+oEX+8+cznZsE7zAzNG6CJQXP1omIadbf3x0ugVag5RgQhrgwMbmbooHxdKNHj2jGeVWoJ1+FeMTPMQh36dgqU6UayjrdQV7pCeNp3brNMwG0fB/BEjyCJ9EeBEP1da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803768; c=relaxed/simple;
	bh=grGBIYWmud9JuGlro5/07i02qcE3zK4UyQVuKtMeoMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2mP78sAfTSJgUl6LKM9mi5XirPn+eJ4NQ6AhUF6q8vM3csZLj1WhzwIF/8ZnXP++e43dOTACdfJWE5eIPe2tj9XEHToW55/b6dy1H/2Bg1OVq3N0wFumkRZHIW6CR8bqcDnn7A2IyNaCfUe0oPlWO9CjQWmjAbhxzaYwzfGWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T8HAkuut; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T8HAkuut; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28AB2211A2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0enyJlewQdxDrTUWiOCHyE0XZuCYPdAuSTH7oLWq4hc=;
	b=T8HAkuutMXlvjOM7RGJNc/J+w+idHi0+VcV5PiMl+79f83+RPxbEDbMdNA/SvMuAOoDkBe
	IyKYjy/83lfBwRcAfBEFvKHaM2Qh/YS1a6Ay0sVVqChnlcLzRpNcnFdGH9IXH5AYwqO/OO
	dyB3g6OOh/zT1wSeDNffC3EV5LNdmXQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=T8HAkuut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0enyJlewQdxDrTUWiOCHyE0XZuCYPdAuSTH7oLWq4hc=;
	b=T8HAkuutMXlvjOM7RGJNc/J+w+idHi0+VcV5PiMl+79f83+RPxbEDbMdNA/SvMuAOoDkBe
	IyKYjy/83lfBwRcAfBEFvKHaM2Qh/YS1a6Ay0sVVqChnlcLzRpNcnFdGH9IXH5AYwqO/OO
	dyB3g6OOh/zT1wSeDNffC3EV5LNdmXQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EB8013888
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YCEwCKyytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: concentrate highmem handling for data verification
Date: Tue,  2 Sep 2025 18:32:13 +0930
Message-ID: <ecf13173ba002901f25ed52a933cc6ef62d98934.1756803640.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 28AB2211A2
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

Currently for btrfs checksum verification, we do it in the following
pattern:

	kaddr = kmap_local_*();
	ret = btrfs_check_csum_csum(kaddr);
	kunmap_local(kaddr);

It's OK for now, but it's still not following the patterns of helpers
inside linux/highmem.h, which never requires a virt memory address.

In those highmem helpers, they mostly accept a folio, some offset/length
inside the folio, and in the implementation they check if the folio
needs partial kmap, and do the handling.

Inspired by those formal highmem helpers, enhance the highmem handling
of data checksum verification by:

- Rename btrfs_check_sector_csum() to btrfs_check_block_csum()
  To follow the more common term "block" used in all other major
  filesystems.

- Pass a physical address into btrfs_check_block_csum() and
  btrfs_data_csum_ok()
  The physical address is always available even for a highmem page.
  Since it's page frame number << PAGE_SHIFT + offset in page.

  And with that physical address, we can grab the folio covering the
  page, and do extra checks to ensure it covers at least one block.

  This also allows us to do the kmap inside btrfs_check_block_csum().
  This means all the extra HIGHMEM handling will be concentrated into
  btrfs_check_block_csum(), and no callers will need to bother highmem
  by themselves.

- Properly zero out the block if csum mismatch
  Since btrfs_data_csum_ok() only got a paddr, we can not and should not
  use memzero_bvec(), which only accepts single page bvec.
  Instead use paddr to grab the folio and call folio_zero_range()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         |  4 ++--
 fs/btrfs/btrfs_inode.h |  6 +++---
 fs/btrfs/inode.c       | 47 +++++++++++++++++++++++++++++-------------
 fs/btrfs/raid56.c      | 13 +++---------
 fs/btrfs/scrub.c       | 18 ++++++++++++++--
 5 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ea7f7a17a3d5..493135bfa518 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -167,7 +167,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	int mirror = repair_bbio->mirror_num;
 
 	if (repair_bbio->bio.bi_status ||
-	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
+	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bvec_phys(bv))) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
 		repair_bbio->bio.bi_iter = repair_bbio->saved_iter;
 
@@ -280,7 +280,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
 
 		bv.bv_len = min(bv.bv_len, sectorsize);
-		if (status || !btrfs_data_csum_ok(bbio, dev, offset, &bv))
+		if (status || !btrfs_data_csum_ok(bbio, dev, offset, bvec_phys(&bv)))
 			fbio = repair_one_sector(bbio, offset, &bv, fbio);
 
 		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index df3445448b7d..077b2f178816 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -542,10 +542,10 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr, u8 *csum,
-			    const u8 * const csum_expected);
+int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
+			   const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, struct bio_vec *bv);
+			u32 bio_offset, phys_addr_t paddr);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cd9b505bd25..33bc1f51a8eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3334,13 +3334,35 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
  *
  * @kaddr must be a properly kmapped address.
  */
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr, u8 *csum,
-			    const u8 * const csum_expected)
+int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
+			   const u8 * const csum_expected)
 {
+	struct folio *folio = page_folio(phys_to_page(paddr));
+	const u32 blocksize = fs_info->sectorsize;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 
 	shash->tfm = fs_info->csum_shash;
-	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
+	/* The full block must be inside the folio. */
+	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
+
+	if (folio_test_partial_kmap(folio)) {
+		size_t cur = paddr;
+
+		crypto_shash_init(shash);
+		while (cur < paddr + blocksize) {
+			void *kaddr;
+			size_t len = min(paddr + blocksize - cur,
+					 PAGE_SIZE - offset_in_page(cur));
+
+			kaddr = kmap_local_folio(folio, offset_in_folio(folio, cur));
+			crypto_shash_update(shash, kaddr, len);
+			kunmap_local(kaddr);
+			cur += len;
+		}
+		crypto_shash_final(shash, csum);
+	} else {
+		crypto_shash_digest(shash, phys_to_virt(paddr), blocksize, csum);
+	}
 
 	if (memcmp(csum, csum_expected, fs_info->csum_size))
 		return -EIO;
@@ -3361,17 +3383,16 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr, u8 *csum
  * Return %true if the sector is ok or had no checksum to start with, else %false.
  */
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, struct bio_vec *bv)
+			u32 bio_offset, phys_addr_t paddr)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 blocksize = fs_info->sectorsize;
+	struct folio *folio;
 	u64 file_offset = bbio->file_offset + bio_offset;
-	u64 end = file_offset + bv->bv_len - 1;
+	u64 end = file_offset + blocksize - 1;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
-	void *kaddr;
-
-	ASSERT(bv->bv_len == fs_info->sectorsize);
 
 	if (!bbio->csum)
 		return true;
@@ -3387,12 +3408,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	kaddr = bvec_kmap_local(bv);
-	if (btrfs_check_sector_csum(fs_info, kaddr, csum, csum_expected)) {
-		kunmap_local(kaddr);
+	if (btrfs_check_block_csum(fs_info, paddr, csum, csum_expected))
 		goto zeroit;
-	}
-	kunmap_local(kaddr);
 	return true;
 
 zeroit:
@@ -3400,7 +3417,9 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 				    bbio->mirror_num);
 	if (dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	memzero_bvec(bv);
+	folio = page_folio(phys_to_page(paddr));
+	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
+	folio_zero_range(folio, offset_in_folio(folio, paddr), blocksize);
 	return false;
 }
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3ff2bedfb3a4..e88699460dda 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1585,9 +1585,6 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 		return;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		void *kaddr;
-
-		kaddr = bvec_kmap_local(bvec);
 		for (u32 off = 0; off < bvec->bv_len;
 		     off += fs_info->sectorsize, total_sector_nr++) {
 			u8 csum_buf[BTRFS_CSUM_SIZE];
@@ -1599,12 +1596,11 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 				continue;
 
-			ret = btrfs_check_sector_csum(fs_info, kaddr + off,
-						      csum_buf, expected_csum);
+			ret = btrfs_check_block_csum(fs_info, bvec_phys(bvec) + off,
+						     csum_buf, expected_csum);
 			if (ret < 0)
 				set_bit(total_sector_nr, rbio->error_bitmap);
 		}
-		kunmap_local(kaddr);
 	}
 }
 
@@ -1802,7 +1798,6 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	struct sector_ptr *sector;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
-	void *kaddr;
 	int ret;
 
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
@@ -1824,9 +1819,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	kaddr = kmap_local_sector(sector);
-	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expected);
-	kunmap_local(kaddr);
+	ret = btrfs_check_block_csum(fs_info, sector->paddr, csum_buf, csum_expected);
 	return ret;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d86020ace69c..0b993e7273d3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -696,6 +696,20 @@ static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
 	return page_address(page) + offset_in_page(offset);
 }
 
+static phys_addr_t scrub_stripe_get_paddr(struct scrub_stripe *stripe, int sector_nr)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	u32 offset = (sector_nr << fs_info->sectorsize_bits);
+	const struct page *page = stripe->pages[offset >> PAGE_SHIFT];
+
+	/* stripe->pages[] is allocated by us and no highmem is allowed. */
+	ASSERT(page);
+	ASSERT(!PageHighMem(page));
+	/* And the range must be contained inside the page. */
+	ASSERT(offset_in_page(offset) + fs_info->sectorsize <= PAGE_SIZE);
+	return page_to_phys(page) + offset_in_page(offset);
+}
+
 static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
@@ -788,7 +802,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
 	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
-	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
+	phys_addr_t paddr = scrub_stripe_get_paddr(stripe, sector_nr);
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	int ret;
 
@@ -833,7 +847,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		return;
 	}
 
-	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
+	ret = btrfs_check_block_csum(fs_info, paddr, csum_buf, sector->csum);
 	if (ret < 0) {
 		scrub_bitmap_set_bit_csum_error(stripe, sector_nr);
 		scrub_bitmap_set_bit_error(stripe, sector_nr);
-- 
2.50.1


