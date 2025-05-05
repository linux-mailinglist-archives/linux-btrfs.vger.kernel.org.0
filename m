Return-Path: <linux-btrfs+bounces-13650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD104AA917E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE213AC1D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2F1FF7CD;
	Mon,  5 May 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jzNGMLZY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jzNGMLZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553820297E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442902; cv=none; b=iPe5eccr5KMFrDF/wUCqVB9pjX2DTIFv+GgSWoODIAnfQRxB1+PwQpbynzV8tPCE4PErqd10LFDH8tBErNVKsi+fCAHL067LassLFdqbkGMnje1NX2TgOKLm/Az6MhepIB5pw/PV6NyNzmrLkCJ/Bjq7GpYFTlJfM9m4TWtCtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442902; c=relaxed/simple;
	bh=HA1rsMzqIw045zfHhapHGyQPgvZ+8kXR7zl1X9dC//M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdwJ0/oHyGdirMo7C6G1G1NXIbtYSWnKcdoB7DOanQfTLcpgBtnIBmxi7QIWfDJIGYAnEZtwTKbaYybU6KQrtO5A4qgPzm2/fKbo3Rfa+rdPLXWt+6ulnBDev12p2dUvAVFH/9U6+ULDVt51Drefw4c9R7dK6yTSfwGmu6sas+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jzNGMLZY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jzNGMLZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A44E21F78F
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gol7a3A4+dDs4F/K6wVGqucaa2a/0Uckt+9sCaf57hA=;
	b=jzNGMLZY1WyaKuZnAFxPwrWvLLwCmJg4TrSyAhZGvu+GV8WhCw7jEOJgCt1Gs3oggsgqRm
	YymmDcnEhnSyakDmhc1NSTTn18YQ/Z76qtIZS58LH8hlusNL8LFEXZD0dJZlhRH45uW1Av
	gXyTMj0neV0vU9NUdB66coofG8uZmuw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gol7a3A4+dDs4F/K6wVGqucaa2a/0Uckt+9sCaf57hA=;
	b=jzNGMLZY1WyaKuZnAFxPwrWvLLwCmJg4TrSyAhZGvu+GV8WhCw7jEOJgCt1Gs3oggsgqRm
	YymmDcnEhnSyakDmhc1NSTTn18YQ/Z76qtIZS58LH8hlusNL8LFEXZD0dJZlhRH45uW1Av
	gXyTMj0neV0vU9NUdB66coofG8uZmuw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF5D91372E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oM7/J4yaGGg/CAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 May 2025 11:01:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: scrub: aggregate small bitmaps into a larger one
Date: Mon,  5 May 2025 20:31:04 +0930
Message-ID: <91cb3f7e3e3b59df0b7cb450021a33d2e5be71a9.1746442395.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746442395.git.wqu@suse.com>
References: <cover.1746442395.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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

Currently we have several small bitmaps inside scrub_stripe:

- extent_sector_bitmap
- error_bitmap
- io_error_bitmap
- csum_error_bitmap
- meta_error_bitmap
- meta_gen_error_bitmap

All those bitmaps are at most 16 bits long, but unsigned long is
either 32 or 64 (more common) bits.

This means we're wasting 1/2 or 3/4 space for each bitmap.

And we can have 128 scrub_stripe for each device, such wasted space adds up
quickly.

Instead of using a single unsigned long for each bitmap, aggregate them
into a larger bitmap, just like what we're doing for subpage support.

This reduces 24 bytes from each scrub_stripe structure on x86_64
systems.

This will need a lot of macros converting direct bitmap/bit operations into
our scrub_stripe specific helpers, but all those helpers are very small
and can be inlined.

So overall the overhead shouldn't be that huge, and we save quite some
memory space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 287 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 196 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 92cb75030729..165eac30e4b0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -100,6 +100,35 @@ enum scrub_stripe_flags {
 	SCRUB_STRIPE_FLAG_NO_REPORT,
 };
 
+/*
+ * We have multiple bitmaps for one scrub_stripe.
+ * However each bitmap has at most (BTRFS_STRIPE_LEN / blocksize) bits,
+ * which is normally 16, and much smaller than BITS_PER_LONG (32 or 64).
+ *
+ * So to reduce memory usage for each scrub_stripe, we pack those bitmaps
+ * into a larger one.
+ *
+ * These enum records where the sub-bitmap are inside the larger one.
+ * Each subbitmap starts at scrub_bitmap_nr_##name * nr_sectors bit.
+ */
+enum {
+	/* Which blocks are covered by extent items. */
+	scrub_bitmap_nr_has_extent = 0,
+
+	/*
+	 * Which blocks have errors, including IO, csum, and metadata
+	 * errors.
+	 * This sub-bitmap is the OR results of the next few error related
+	 * sub-bitmaps.
+	 */
+	scrub_bitmap_nr_error,
+	scrub_bitmap_nr_io_error,
+	scrub_bitmap_nr_csum_error,
+	scrub_bitmap_nr_meta_error,
+	scrub_bitmap_nr_meta_gen_error,
+	scrub_bitmap_nr_last,
+};
+
 #define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
 
 /*
@@ -138,25 +167,15 @@ struct scrub_stripe {
 	 */
 	unsigned long state;
 
-	/* Indicate which sectors are covered by extent items. */
-	unsigned long extent_sector_bitmap;
+	/* The large bitmap contains all the sub-bitmaps. */
+	unsigned long bitmaps[BITS_TO_LONGS(scrub_bitmap_nr_last *
+					    (BTRFS_STRIPE_LEN / BTRFS_MIN_BLOCKSIZE))];
 
 	/*
-	 * The following error bitmaps are all for the current status.
-	 * Every time we submit a new read, these bitmaps may be updated.
-	 *
-	 * error_bitmap = io_error_bitmap | csum_error_bitmap |
-	 *		  meta_error_bitmap | meta_generation_bitmap;
-	 *
-	 * IO and csum errors can happen for both metadata and data.
+	 * For writeback (repair or replace) error reporting.
+	 * This one is protected by a spinlock, thus can not be packed into
+	 * the larger bitmap.
 	 */
-	unsigned long error_bitmap;
-	unsigned long io_error_bitmap;
-	unsigned long csum_error_bitmap;
-	unsigned long meta_error_bitmap;
-	unsigned long meta_gen_error_bitmap;
-
-	/* For writeback (repair or replace) error reporting. */
 	unsigned long write_error_bitmap;
 
 	/* Writeback can be concurrent, thus we need to protect the bitmap. */
@@ -208,6 +227,89 @@ struct scrub_ctx {
 	refcount_t              refs;
 };
 
+#define scrub_calc_start_bit(stripe, name, block_nr)			\
+({									\
+	unsigned int __start_bit;					\
+									\
+	ASSERT(block_nr < stripe->nr_sectors,				\
+		"nr_sectors=%u block_nr=%u", stripe->nr_sectors, block_nr); \
+	__start_bit = scrub_bitmap_nr_##name * stripe->nr_sectors + block_nr; \
+	__start_bit;							\
+})
+
+#define IMPLEMENT_SCRUB_BITMAP_OPS(name)				\
+static inline void scrub_bitmap_set_##name(struct scrub_stripe *stripe,	\
+				    unsigned int block_nr,		\
+				    unsigned int nr_blocks)		\
+{									\
+	const unsigned int start_bit = scrub_calc_start_bit(stripe,	\
+							    name, block_nr); \
+									\
+	bitmap_set(stripe->bitmaps, start_bit, nr_blocks);		\
+}									\
+static inline void scrub_bitmap_clear_##name(struct scrub_stripe *stripe, \
+				      unsigned int block_nr,		\
+				      unsigned int nr_blocks)		\
+{									\
+	const unsigned int start_bit = scrub_calc_start_bit(stripe, name, \
+							    block_nr);	\
+									\
+	bitmap_clear(stripe->bitmaps, start_bit, nr_blocks);		\
+}									\
+static inline bool scrub_bitmap_test_bit_##name(struct scrub_stripe *stripe, \
+				     unsigned int block_nr)		\
+{									\
+	const unsigned int start_bit = scrub_calc_start_bit(stripe, name, \
+							    block_nr);	\
+									\
+	return test_bit(start_bit, stripe->bitmaps);			\
+}									\
+static inline void scrub_bitmap_set_bit_##name(struct scrub_stripe *stripe, \
+				     unsigned int block_nr)		\
+{									\
+	const unsigned int start_bit = scrub_calc_start_bit(stripe, name, \
+							    block_nr);	\
+									\
+	set_bit(start_bit, stripe->bitmaps);				\
+}									\
+static inline void scrub_bitmap_clear_bit_##name(struct scrub_stripe *stripe, \
+				     unsigned int block_nr)		\
+{									\
+	const unsigned int start_bit = scrub_calc_start_bit(stripe, name, \
+							    block_nr);	\
+									\
+	clear_bit(start_bit, stripe->bitmaps);				\
+}									\
+static inline unsigned long scrub_bitmap_read_##name(struct scrub_stripe *stripe) \
+{									\
+	const unsigned int nr_blocks = stripe->nr_sectors;		\
+									\
+	ASSERT(nr_blocks > 0 && nr_blocks <= BITS_PER_LONG,		\
+	       "nr_blocks=%u BITS_PER_LONG=%u",				\
+	       nr_blocks, BITS_PER_LONG);				\
+									\
+	return bitmap_read(stripe->bitmaps, nr_blocks * scrub_bitmap_nr_##name, \
+			   stripe->nr_sectors);				\
+}									\
+static inline unsigned int scrub_bitmap_empty_##name(struct scrub_stripe *stripe) \
+{									\
+	unsigned long bitmap = scrub_bitmap_read_##name(stripe);	\
+									\
+	return bitmap_empty(&bitmap, stripe->nr_sectors);		\
+}									\
+static inline unsigned int scrub_bitmap_weight_##name(struct scrub_stripe *stripe) \
+{									\
+	unsigned long bitmap = scrub_bitmap_read_##name(stripe);	\
+									\
+	return bitmap_weight(&bitmap, stripe->nr_sectors);		\
+}
+IMPLEMENT_SCRUB_BITMAP_OPS(has_extent);
+IMPLEMENT_SCRUB_BITMAP_OPS(error);
+IMPLEMENT_SCRUB_BITMAP_OPS(io_error);
+IMPLEMENT_SCRUB_BITMAP_OPS(csum_error);
+IMPLEMENT_SCRUB_BITMAP_OPS(meta_error);
+IMPLEMENT_SCRUB_BITMAP_OPS(meta_gen_error);
+
 struct scrub_warning {
 	struct btrfs_path	*path;
 	u64			extent_item_size;
@@ -611,8 +713,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
 
 	if (logical != btrfs_stack_header_bytenr(header)) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
 			      logical, stripe->mirror_num,
@@ -621,8 +723,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (memcmp(header->fsid, fs_info->fs_devices->metadata_uuid,
 		   BTRFS_FSID_SIZE) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
@@ -631,8 +733,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
 		   BTRFS_UUID_SIZE) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
 			      logical, stripe->mirror_num,
@@ -653,8 +755,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 
 	crypto_shash_final(shash, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
 			      logical, stripe->mirror_num,
@@ -664,8 +766,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (stripe->sectors[sector_nr].generation !=
 	    btrfs_stack_header_generation(header)) {
-		bitmap_set(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_meta_gen_error(stripe, sector_nr, sectors_per_tree);
+		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      logical, stripe->mirror_num,
@@ -673,10 +775,10 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 			      stripe->sectors[sector_nr].generation);
 		return;
 	}
-	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
-	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
-	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-	bitmap_clear(&stripe->meta_gen_error_bitmap, sector_nr, sectors_per_tree);
+	scrub_bitmap_clear_error(stripe, sector_nr, sectors_per_tree);
+	scrub_bitmap_clear_csum_error(stripe, sector_nr, sectors_per_tree);
+	scrub_bitmap_clear_meta_error(stripe, sector_nr, sectors_per_tree);
+	scrub_bitmap_clear_meta_gen_error(stripe, sector_nr, sectors_per_tree);
 }
 
 static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
@@ -691,11 +793,11 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
 
 	/* Sector not utilized, skip it. */
-	if (!test_bit(sector_nr, &stripe->extent_sector_bitmap))
+	if (!scrub_bitmap_test_bit_has_extent(stripe, sector_nr))
 		return;
 
 	/* IO error, no need to check. */
-	if (test_bit(sector_nr, &stripe->io_error_bitmap))
+	if (scrub_bitmap_test_bit_io_error(stripe, sector_nr))
 		return;
 
 	/* Metadata, verify the full tree block. */
@@ -725,17 +827,17 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	 * cases without csum, we have no other choice but to trust it.
 	 */
 	if (!sector->csum) {
-		clear_bit(sector_nr, &stripe->error_bitmap);
+		scrub_bitmap_clear_bit_error(stripe, sector_nr);
 		return;
 	}
 
 	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
 	if (ret < 0) {
-		set_bit(sector_nr, &stripe->csum_error_bitmap);
-		set_bit(sector_nr, &stripe->error_bitmap);
+		scrub_bitmap_set_bit_csum_error(stripe, sector_nr);
+		scrub_bitmap_set_bit_error(stripe, sector_nr);
 	} else {
-		clear_bit(sector_nr, &stripe->csum_error_bitmap);
-		clear_bit(sector_nr, &stripe->error_bitmap);
+		scrub_bitmap_clear_bit_csum_error(stripe, sector_nr);
+		scrub_bitmap_clear_bit_error(stripe, sector_nr);
 	}
 }
 
@@ -786,13 +888,13 @@ static void scrub_repair_read_endio(struct btrfs_bio *bbio)
 		bio_size += bvec->bv_len;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
-		bitmap_set(&stripe->error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
+		scrub_bitmap_set_io_error(stripe, sector_nr,
+					  bio_size >> fs_info->sectorsize_bits);
+		scrub_bitmap_set_error(stripe, sector_nr,
+				       bio_size >> fs_info->sectorsize_bits);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, sector_nr,
-			     bio_size >> fs_info->sectorsize_bits);
+		scrub_bitmap_clear_io_error(stripe, sector_nr,
+					  bio_size >> fs_info->sectorsize_bits);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io))
@@ -829,7 +931,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	const unsigned long old_error_bitmap = stripe->error_bitmap;
+	const unsigned long old_error_bitmap = scrub_bitmap_read_error(stripe);
 	int i;
 
 	ASSERT(stripe->mirror_num >= 1);
@@ -837,7 +939,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 
 	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
 		/* The current sector cannot be merged, submit the bio. */
-		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
+		if (bbio && ((i > 0 && !test_bit(i - 1, &old_error_bitmap)) ||
 			     bbio->bio.bi_iter.bi_size >= blocksize)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
@@ -873,6 +975,8 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				      DEFAULT_RATELIMIT_BURST);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_device *dev = NULL;
+	const unsigned long extent_bitmap = scrub_bitmap_read_has_extent(stripe);
+	const unsigned long error_bitmap = scrub_bitmap_read_error(stripe);
 	u64 physical = 0;
 	int nr_data_sectors = 0;
 	int nr_meta_sectors = 0;
@@ -912,7 +1016,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	}
 
 skip:
-	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(sector_nr, &extent_bitmap, stripe->nr_sectors) {
 		bool repaired = false;
 
 		if (stripe->sectors[sector_nr].is_metadata) {
@@ -924,7 +1028,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		}
 
 		if (test_bit(sector_nr, &errors->init_error_bitmap) &&
-		    !test_bit(sector_nr, &stripe->error_bitmap)) {
+		    !test_bit(sector_nr, &error_bitmap)) {
 			nr_repaired_sectors++;
 			repaired = true;
 		}
@@ -963,19 +1067,19 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 					    stripe->logical, stripe->mirror_num);
 		}
 
-		if (test_bit(sector_nr, &stripe->io_error_bitmap))
+		if (scrub_bitmap_test_bit_io_error(stripe, sector_nr))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("i/o error", dev, false,
 						     stripe->logical, physical);
-		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
+		if (scrub_bitmap_test_bit_csum_error(stripe, sector_nr))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("checksum error", dev, false,
 						     stripe->logical, physical);
-		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
+		if (scrub_bitmap_test_bit_meta_error(stripe, sector_nr))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("header error", dev, false,
 						     stripe->logical, physical);
-		if (test_bit(sector_nr, &stripe->meta_gen_error_bitmap))
+		if (scrub_bitmap_test_bit_meta_gen_error(stripe, sector_nr))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("generation error", dev, false,
 						     stripe->logical, physical);
@@ -1002,7 +1106,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	sctx->stat.verify_errors += errors->nr_meta_errors +
 				    errors->nr_meta_gen_errors;
 	sctx->stat.uncorrectable_errors +=
-		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
+		bitmap_weight(&error_bitmap, stripe->nr_sectors);
 	sctx->stat.corrected_errors += nr_repaired_sectors;
 	spin_unlock(&sctx->stat_lock);
 }
@@ -1032,23 +1136,20 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
 	unsigned long repaired;
+	unsigned long error;
 	int mirror;
 	int i;
 
 	ASSERT(stripe->mirror_num > 0);
 
 	wait_scrub_stripe_io(stripe);
-	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
+	scrub_verify_one_stripe(stripe, scrub_bitmap_read_has_extent(stripe));
 	/* Save the initial failed bitmap for later repair and report usage. */
-	errors.init_error_bitmap = stripe->error_bitmap;
-	errors.nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
-					    stripe->nr_sectors);
-	errors.nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
-					      stripe->nr_sectors);
-	errors.nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
-					      stripe->nr_sectors);
-	errors.nr_meta_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
-					      stripe->nr_sectors);
+	errors.init_error_bitmap = scrub_bitmap_read_error(stripe);
+	errors.nr_io_errors = scrub_bitmap_weight_io_error(stripe);
+	errors.nr_csum_errors = scrub_bitmap_weight_csum_error(stripe);
+	errors.nr_meta_errors = scrub_bitmap_weight_meta_error(stripe);
+	errors.nr_meta_gen_errors = scrub_bitmap_weight_meta_gen_error(stripe);
 
 	if (bitmap_empty(&errors.init_error_bitmap, stripe->nr_sectors))
 		goto out;
@@ -1062,13 +1163,13 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	for (mirror = calc_next_mirror(stripe->mirror_num, num_copies);
 	     mirror != stripe->mirror_num;
 	     mirror = calc_next_mirror(mirror, num_copies)) {
-		const unsigned long old_error_bitmap = stripe->error_bitmap;
+		const unsigned long old_error_bitmap = scrub_bitmap_read_error(stripe);
 
 		scrub_stripe_submit_repair_read(stripe, mirror,
 						BTRFS_STRIPE_LEN, false);
 		wait_scrub_stripe_io(stripe);
 		scrub_verify_one_stripe(stripe, old_error_bitmap);
-		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+		if (scrub_bitmap_empty_error(stripe))
 			goto out;
 	}
 
@@ -1086,21 +1187,22 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	for (i = 0, mirror = stripe->mirror_num;
 	     i < num_copies;
 	     i++, mirror = calc_next_mirror(mirror, num_copies)) {
-		const unsigned long old_error_bitmap = stripe->error_bitmap;
+		const unsigned long old_error_bitmap = scrub_bitmap_read_error(stripe);
 
 		scrub_stripe_submit_repair_read(stripe, mirror,
 						fs_info->sectorsize, true);
 		wait_scrub_stripe_io(stripe);
 		scrub_verify_one_stripe(stripe, old_error_bitmap);
-		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+		if (scrub_bitmap_empty_error(stripe))
 			goto out;
 	}
 out:
+	error = scrub_bitmap_read_error(stripe);
 	/*
 	 * Submit the repaired sectors.  For zoned case, we cannot do repair
 	 * in-place, but queue the bg to be relocated.
 	 */
-	bitmap_andnot(&repaired, &errors.init_error_bitmap, &stripe->error_bitmap,
+	bitmap_andnot(&repaired, &errors.init_error_bitmap, &error,
 		      stripe->nr_sectors);
 	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sectors)) {
 		if (btrfs_is_zoned(fs_info)) {
@@ -1131,10 +1233,10 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, sector_nr, num_sectors);
-		bitmap_set(&stripe->error_bitmap, sector_nr, num_sectors);
+		scrub_bitmap_set_io_error(stripe, sector_nr, num_sectors);
+		scrub_bitmap_set_error(stripe, sector_nr, num_sectors);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, sector_nr, num_sectors);
+		scrub_bitmap_clear_io_error(stripe, sector_nr, num_sectors);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io)) {
@@ -1224,7 +1326,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 
 	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
 		/* We should only writeback sectors covered by an extent. */
-		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
+		ASSERT(scrub_bitmap_test_bit_has_extent(stripe, sector_nr));
 
 		/* Cannot merge with previous sector, submit the current one. */
 		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
@@ -1512,7 +1614,7 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 		struct scrub_sector_verification *sector =
 						&stripe->sectors[nr_sector];
 
-		set_bit(nr_sector, &stripe->extent_sector_bitmap);
+		scrub_bitmap_set_bit_has_extent(stripe, nr_sector);
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			sector->is_metadata = true;
 			sector->generation = extent_gen;
@@ -1522,12 +1624,8 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 
 static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 {
-	stripe->extent_sector_bitmap = 0;
-	stripe->error_bitmap = 0;
-	stripe->io_error_bitmap = 0;
-	stripe->csum_error_bitmap = 0;
-	stripe->meta_error_bitmap = 0;
-	stripe->meta_gen_error_bitmap = 0;
+	ASSERT(stripe->nr_sectors);
+	bitmap_zero(stripe->bitmaps, scrub_bitmap_nr_last * stripe->nr_sectors);
 }
 
 /*
@@ -1681,21 +1779,21 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
 	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
+	const unsigned long has_extent = scrub_bitmap_read_has_extent(stripe);
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
 
 	atomic_inc(&stripe->pending_io);
 
-	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(i, &has_extent, stripe->nr_sectors) {
 		/* We're beyond the chunk boundary, no need to read anymore. */
 		if (i >= nr_sectors)
 			break;
 
 		/* The current sector cannot be merged, submit the bio. */
 		if (bbio &&
-		    ((i > 0 &&
-		      !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
+		    ((i > 0 && !test_bit(i - 1, &has_extent)) ||
 		     bbio->bio.bi_iter.bi_size >= stripe_len)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
@@ -1729,8 +1827,8 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 					 * the extent tree, then it's a preallocated
 					 * extent and not an error.
 					 */
-					set_bit(i, &stripe->io_error_bitmap);
-					set_bit(i, &stripe->error_bitmap);
+					scrub_bitmap_set_bit_io_error(stripe, i);
+					scrub_bitmap_set_bit_error(stripe, i);
 				}
 				continue;
 			}
@@ -1800,9 +1898,10 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 
 static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 {
+	const unsigned long error = scrub_bitmap_read_error(stripe);
 	int i;
 
-	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(i, &error, stripe->nr_sectors) {
 		if (stripe->sectors[i].is_metadata) {
 			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
@@ -1878,13 +1977,16 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 		}
 		for (int i = 0; i < nr_stripes; i++) {
 			unsigned long good;
+			unsigned long has_extent;
+			unsigned long error;
 
 			stripe = &sctx->stripes[i];
 
 			ASSERT(stripe->dev == fs_info->dev_replace.srcdev);
 
-			bitmap_andnot(&good, &stripe->extent_sector_bitmap,
-				      &stripe->error_bitmap, stripe->nr_sectors);
+			has_extent = scrub_bitmap_read_has_extent(stripe);
+			error = scrub_bitmap_read_error(stripe);
+			bitmap_andnot(&good, &has_extent, &error, stripe->nr_sectors);
 			scrub_write_sectors(sctx, stripe, good, true);
 		}
 	}
@@ -2018,7 +2120,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	/* Check if all data stripes are empty. */
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
-		if (!bitmap_empty(&stripe->extent_sector_bitmap, stripe->nr_sectors)) {
+		if (!scrub_bitmap_empty_has_extent(stripe)) {
 			all_empty = false;
 			break;
 		}
@@ -2050,15 +2152,18 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	 */
 	for (int i = 0; i < data_stripes; i++) {
 		unsigned long error;
+		unsigned long has_extent;
 
 		stripe = &sctx->raid56_data_stripes[i];
 
+		error = scrub_bitmap_read_error(stripe);
+		has_extent = scrub_bitmap_read_has_extent(stripe);
+
 		/*
 		 * We should only check the errors where there is an extent.
 		 * As we may hit an empty data stripe while it's missing.
 		 */
-		bitmap_and(&error, &stripe->error_bitmap,
-			   &stripe->extent_sector_bitmap, stripe->nr_sectors);
+		bitmap_and(&error, &error, &has_extent, stripe->nr_sectors);
 		if (!bitmap_empty(&error, stripe->nr_sectors)) {
 			btrfs_err(fs_info,
 "unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
@@ -2067,8 +2172,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 			ret = -EIO;
 			goto out;
 		}
-		bitmap_or(&extent_bitmap, &extent_bitmap,
-			  &stripe->extent_sector_bitmap, stripe->nr_sectors);
+		bitmap_or(&extent_bitmap, &extent_bitmap, &has_extent,
+			  stripe->nr_sectors);
 	}
 
 	/* Now we can check and regenerate the P/Q stripe. */
-- 
2.49.0


