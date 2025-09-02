Return-Path: <linux-btrfs+bounces-16581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9BB3F991
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E672C2056C9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C64D2EAB6C;
	Tue,  2 Sep 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uwdxjfP6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uwdxjfP6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A12EA752
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803779; cv=none; b=ZPEsTh/mnVEtMJFr8AUeAmIXYKvk4iPsN5wCKOIwR39CdatYBFHW1fS1IAQ4NEopndYuY+bjBsx6jW/0TM9r/sGkMdjt1MKiFMAKQuy+jEJBG7G9KFCA1XOLmO26sO6Z2ur2Rr792yRh9pRGaQn25VgwhoUx/dnVqoiuHEKmev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803779; c=relaxed/simple;
	bh=S+B/ghfghin3vnl0R7Olpg864fFUG1CALXDnCxvaTSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWUMntVvzmbo1DfcT3Uva84EHM/OUv9U4s6c0F9M1hs7lorUVA2HQdqae7uIFtEFpf8cHXHiA1/rjxSzJpaESsjBlkzJMsNoeZbmnhDtB08RSmVnagjBbZaESzIUcKib3ULYh4tLd26iXpTUQ4Elws1wTJRSR93mj9sOQ7t+snk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uwdxjfP6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uwdxjfP6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 680D3211DF
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQr9aukjMOFQT2HBCJZn5hLdM6sJzplAIV7cH5J4UNM=;
	b=uwdxjfP6KxXDJcNtw3esVze+r4nokVLGBaAFyOWFHpiit3EehZEpBp4aX0vDUxWWuuprGN
	3ddbNknv5icYSrv1MXb6CCiSORyWQKJVjgT2o0OyNpmdGsCcvTlv5gZc2bvFJSMrirlal/
	hYyEqYriIvt2nogbWEjwPEcsgGq6684=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uwdxjfP6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQr9aukjMOFQT2HBCJZn5hLdM6sJzplAIV7cH5J4UNM=;
	b=uwdxjfP6KxXDJcNtw3esVze+r4nokVLGBaAFyOWFHpiit3EehZEpBp4aX0vDUxWWuuprGN
	3ddbNknv5icYSrv1MXb6CCiSORyWQKJVjgT2o0OyNpmdGsCcvTlv5gZc2bvFJSMrirlal/
	hYyEqYriIvt2nogbWEjwPEcsgGq6684=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E98D13888
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGqxF62ytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: introduce btrfs_bio_for_each_block() helper
Date: Tue,  2 Sep 2025 18:32:14 +0930
Message-ID: <9d6f34b2127aee8c1bb0191e204b728b8adbed6f.1756803640.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 680D3211DF
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

Currently if we want to iterate a bio in block unit, we do something
like this:

	while (iter->bi_size) {
		struct bio_vec bv = bio_iter_iovec();

		/* Do something with using the bv */

		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
	}

That's fine for now, but it will not handle future bs > ps, as
bio_iter_iovec() returns a single-page bvec, meaning the bv_len will not
exceed page size.

This means the code using that bv can only handle a block if bs <= ps.

To address this problem and handle future bs > ps cases better:

- Introduce a helper btrfs_bio_for_each_block()
  Instead of bio_vec, which has single and multiple page version and
  multiple page version has quite some limits, use my favorite way to
  represent a block, phys_addr_t.

  For bs <= ps cases, nothing is changed, except we will do a very
  small overhead to convert phys_addr_t to a folio, then use the proper
  folio helpers to handle the possible highmem cases.

  For bs > ps cases, all blocks will be backed by large folios, meaning
  every folio will cover at least one block. And still use proper folio
  helpers to handle highmem cases.

  With phys_addr_t, we will handle both large folio and highmem
  properly. So there is no better single variable to present a btrfs
  block than phys_addr_t.

- Extract the data block csum calculation into a helper
  The new helper, btrfs_calculate_block_csum() will be utilzed by
  btrfs_csum_one_bio().

- Use btrfs_bio_for_each_block() to replace existing call sites
  Including:

  * index_one_bio() from raid56.c
    Very straight-forward.

  * btrfs_check_read_bio()
    Also update repair_one_sector() to grab the folio using phys_addr_t,
    and do extra checks to make sure the folio covers at least one
    block.
    We do not need to bother bv_len at all now.

  * btrfs_csum_one_bio()
    Now we can move the highmem handling into a dedicated helper,
    calculate_block_csum(), and use btrfs_bio_for_each_block() helper.

There is one exception in btrfs_decompress_buf2page(), which is copying
decompressed data into the original bio, which is not iterating using
block size thus we don't need to bother.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         | 20 +++++++++-----------
 fs/btrfs/btrfs_inode.h |  2 ++
 fs/btrfs/file-item.c   | 26 ++++++--------------------
 fs/btrfs/inode.c       | 26 +++++++++++++++-----------
 fs/btrfs/misc.h        | 25 +++++++++++++++++++++++++
 fs/btrfs/raid56.c      |  7 +++----
 6 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 493135bfa518..909b208f9ef3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -204,18 +204,21 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
  */
 static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 						  u32 bio_offset,
-						  struct bio_vec *bv,
+						  phys_addr_t paddr,
 						  struct btrfs_failed_bio *fbio)
 {
 	struct btrfs_inode *inode = failed_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct folio *folio = page_folio(phys_to_page(paddr));
 	const u32 sectorsize = fs_info->sectorsize;
+	const u32 foff = offset_in_folio(folio, paddr);
 	const u64 logical = (failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT);
 	struct btrfs_bio *repair_bbio;
 	struct bio *repair_bio;
 	int num_copies;
 	int mirror;
 
+	ASSERT(foff + sectorsize <= folio_size(folio));
 	btrfs_debug(fs_info, "repair read error: read error at %llu",
 		    failed_bbio->file_offset + bio_offset);
 
@@ -238,7 +241,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
 	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
-	__bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
+	bio_add_folio_nofail(repair_bio, folio, sectorsize, foff);
 
 	repair_bbio = btrfs_bio(repair_bio);
 	btrfs_bio_init(repair_bbio, fs_info, NULL, fbio);
@@ -259,6 +262,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	struct bvec_iter *iter = &bbio->saved_iter;
 	blk_status_t status = bbio->bio.bi_status;
 	struct btrfs_failed_bio *fbio = NULL;
+	phys_addr_t paddr;
 	u32 offset = 0;
 
 	/* Read-repair requires the inode field to be set by the submitter. */
@@ -276,17 +280,11 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
-	while (iter->bi_size) {
-		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
-
-		bv.bv_len = min(bv.bv_len, sectorsize);
-		if (status || !btrfs_data_csum_ok(bbio, dev, offset, bvec_phys(&bv)))
-			fbio = repair_one_sector(bbio, offset, &bv, fbio);
-
-		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
+	btrfs_bio_for_each_block(paddr, &bbio->bio, iter, fs_info->sectorsize) {
+		if (status || !btrfs_data_csum_ok(bbio, dev, offset, paddr))
+			fbio = repair_one_sector(bbio, offset, paddr, fbio);
 		offset += sectorsize;
 	}
-
 	if (bbio->csum != bbio->csum_inline)
 		kfree(bbio->csum);
 
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 077b2f178816..c40e99ec13bf 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -542,6 +542,8 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
+void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
+				u8 *dest);
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4dd3d8a02519..7906aea75ee4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -775,12 +775,10 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
-	char *data;
-	struct bvec_iter iter;
-	struct bio_vec bvec;
+	struct bvec_iter iter = bio->bi_iter;
+	phys_addr_t paddr;
+	const u32 blocksize = fs_info->sectorsize;
 	int index;
-	unsigned int blockcount;
-	int i;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -799,21 +797,9 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	shash->tfm = fs_info->csum_shash;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
-						 bvec.bv_len + fs_info->sectorsize
-						 - 1);
-
-		for (i = 0; i < blockcount; i++) {
-			data = bvec_kmap_local(&bvec);
-			crypto_shash_digest(shash,
-					    data + (i * fs_info->sectorsize),
-					    fs_info->sectorsize,
-					    sums->sums + index);
-			kunmap_local(data);
-			index += fs_info->csum_size;
-		}
-
+	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
+		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
+		index += fs_info->csum_size;
 	}
 
 	bbio->sums = sums;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 33bc1f51a8eb..ad876779289e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3328,14 +3328,8 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 	return btrfs_finish_one_ordered(ordered);
 }
 
-/*
- * Verify the checksum for a single sector without any extra action that depend
- * on the type of I/O.
- *
- * @kaddr must be a properly kmapped address.
- */
-int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
-			   const u8 * const csum_expected)
+void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
+				u8 *dest)
 {
 	struct folio *folio = page_folio(phys_to_page(paddr));
 	const u32 blocksize = fs_info->sectorsize;
@@ -3359,11 +3353,21 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
 			kunmap_local(kaddr);
 			cur += len;
 		}
-		crypto_shash_final(shash, csum);
+		crypto_shash_final(shash, dest);
 	} else {
-		crypto_shash_digest(shash, phys_to_virt(paddr), blocksize, csum);
+		crypto_shash_digest(shash, phys_to_virt(paddr), blocksize, dest);
 	}
-
+}
+/*
+ * Verify the checksum for a single sector without any extra action that depend
+ * on the type of I/O.
+ *
+ * @kaddr must be a properly kmapped address.
+ */
+int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
+			   const u8 * const csum_expected)
+{
+	btrfs_calculate_block_csum(fs_info, paddr, csum);
 	if (memcmp(csum, csum_expected, fs_info->csum_size))
 		return -EIO;
 	return 0;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index ff5eac84d819..f210f808311f 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/math64.h>
 #include <linux/rbtree.h>
+#include <linux/bio.h>
 
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
@@ -20,6 +21,30 @@
 	name = (1U << __ ## name ## _BIT),              \
 	__ ## name ## _SEQ = __ ## name ## _BIT
 
+static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
+{
+	struct bio_vec bv = bio_iter_iovec(bio, *iter);
+
+	return bvec_phys(&bv);
+}
+
+/*
+ * Helper to iterate bio using btrfs block size.
+ *
+ * This will handle large folio and highmem.
+ *
+ * @paddr:	Physical memory address of each iteration
+ * @bio:	The bio to iterate
+ * @iter:	The bvec_iter (pointer) to use.
+ * @blocksize:	The blocksize to iterate.
+ *
+ * This requires all folios in the bio to cover at least one block.
+ */
+#define btrfs_bio_for_each_block(paddr, bio, iter, blocksize)		\
+	for (; (iter)->bi_size &&					\
+	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
+	     bio_advance_iter_single((bio), (iter), (blocksize)))
+
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e88699460dda..389f1b617fe7 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1208,17 +1208,16 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	const u32 sectorsize_bits = rbio->bioc->fs_info->sectorsize_bits;
 	struct bvec_iter iter = bio->bi_iter;
+	phys_addr_t paddr;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->full_stripe_logical;
 
-	while (iter.bi_size) {
+	btrfs_bio_for_each_block(paddr, bio, &iter, sectorsize) {
 		unsigned int index = (offset >> sectorsize_bits);
 		struct sector_ptr *sector = &rbio->bio_sectors[index];
-		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
 		sector->has_paddr = true;
-		sector->paddr = bvec_phys(&bv);
-		bio_advance_iter_single(bio, &iter, sectorsize);
+		sector->paddr = paddr;
 		offset += sectorsize;
 	}
 }
-- 
2.50.1


