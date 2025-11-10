Return-Path: <linux-btrfs+bounces-18850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF4C49A19
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 23:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165321887547
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27F2F744B;
	Mon, 10 Nov 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F/URy+15";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F/URy+15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAB1F130B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814549; cv=none; b=n5B9uiyhxOVkW26XXWWp4qLD/L8SFWE4kNTvBH4lFcxqqBTAsjcXPK41dmNlKq3V/OWHa0fOrm8bPOvzJxf9rzwdWg3UZ9Wn0Vi4jsAMhTlwgX4RDuF6vWdBguolVl+T8s7ODGhYjQyB3bKoVLuomJxm++RYGzRn2WNa1MyA52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814549; c=relaxed/simple;
	bh=r917Ie0r9hXVYTBocpNv7IlKID7Wz38/he/07kP1mjw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqeHnJd/t7IC1d4P7Q9M9umOsyNQUVMlMD01EWD2Ruje1doo4SKbTZrheFoRN5EDS+ie3VZDhisX/92m95jnHEsyWBDPn/ypJIgF8IvamouGoZTzN3NdJizZjiAG6xGs2KYSPf8Z50JuTldUyhyRFy8t/RugmwhAyViuZAyqbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F/URy+15; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F/URy+15; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B739B1F38A
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DBm/vA88ed78JvU1qdNvKlkuykvi8kj+WG4aNMwfmw=;
	b=F/URy+15JL5J0c8cg3GblwpSB1HT27YWs5Cqs6seDVvWmGIx+0B1SoxK16w0vPtOaOeDT8
	c2IlBwJcXcUjPPCHgxZuZGB1BIpAuyANzQpmYs/NvcTlAiA7O2+Dop1pGJiGa3LMPDBgNL
	utvnsAFgJSFJ7uQy2zUOVLI88ZbpiAg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762814544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DBm/vA88ed78JvU1qdNvKlkuykvi8kj+WG4aNMwfmw=;
	b=F/URy+15JL5J0c8cg3GblwpSB1HT27YWs5Cqs6seDVvWmGIx+0B1SoxK16w0vPtOaOeDT8
	c2IlBwJcXcUjPPCHgxZuZGB1BIpAuyANzQpmYs/NvcTlAiA7O2+Dop1pGJiGa3LMPDBgNL
	utvnsAFgJSFJ7uQy2zUOVLI88ZbpiAg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0111C14623
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELxlLU9qEmk/agAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:42:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/4] btrfs: make btrfs_csum_one_bio() handle bs > ps without large folios
Date: Tue, 11 Nov 2025 09:11:58 +1030
Message-ID: <8039ef3c4b61cd200f9fdbcca91a7ab5c94e3f30.1762814274.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.72 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.12)[-0.593];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.72
X-Spam-Level: 

For bs > ps cases, all folios passed into btrfs_csum_one_bio() is
ensured to be backed by large folios.

But that requirement excludes features like direct IO and encoded
writes.

To support bs > ps without large folios, enhance btrfs_csum_one_bio()
by:

- Split btrfs_calculate_block_csum() into two versions
  * btrfs_calculate_block_csum_folio()
    For call sites that a fs block is always backed by a large folio.

    This will do extra checks on the folio size, build a paddrs[] array,
    and pass it into the newer btrfs_calculate_block_csum_pages()
    helper.

    For now btrfs_check_block_csum() is still using this version.

  * btrfs_calculate_block_csum_pages()
    For call sites that may hit a fs block backed by incontiguous pages.
    The pages are represented by paddrs[] array, which includes the
    offset inside the page.

    This function will do the proper sub-block handling.

- Make btrfs_csum_one_bio() to use btrfs_calculate_block_csum_pages()
  This means we will need to build a local paddrs[] array, and after
  filling a fs block, do the checksum calculation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  6 ++--
 fs/btrfs/file-item.c   | 15 +++++++--
 fs/btrfs/inode.c       | 73 ++++++++++++++++++++++++++++++------------
 3 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a66ca5531b5c..cac3ce4c8aa4 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -547,8 +547,10 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
-				u8 *dest);
+void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
+				      const phys_addr_t paddr, u8 *dest);
+void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
+				      const phys_addr_t paddrs[], u8 *dest);
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 72be3ede0edf..e7c219e83ff0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -775,13 +775,22 @@ static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
 	struct bvec_iter iter = *src;
 	phys_addr_t paddr;
 	const u32 blocksize = fs_info->sectorsize;
+	const u32 step = min(blocksize, PAGE_SIZE);
+	const u32 nr_steps = blocksize / step;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
+	u32 offset = 0;
 	int index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
-	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
-		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
-		index += fs_info->csum_size;
+	btrfs_bio_for_each_block(paddr, bio, &iter, step) {
+		paddrs[(offset / step) % nr_steps] = paddr;
+		offset += step;
+
+		if (IS_ALIGNED(offset, blocksize)) {
+			btrfs_calculate_block_csum_pages(fs_info, paddrs, sums->sums + index);
+			index += fs_info->csum_size;
+		}
 	}
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8737914e8552..4883d0de749e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3343,36 +3343,67 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 	return btrfs_finish_one_ordered(ordered);
 }
 
-void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
-				u8 *dest)
+/*
+ * Calculate the checksum of a fs block at physical memory address @paddr,
+ * and save the result to @dest.
+ *
+ * The folio containing @paddr must be large enough to contain a full fs block.
+ */
+void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
+				      const phys_addr_t paddr, u8 *dest)
 {
 	struct folio *folio = page_folio(phys_to_page(paddr));
 	const u32 blocksize = fs_info->sectorsize;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	const u32 step = min(blocksize, PAGE_SIZE);
+	const u32 nr_steps = blocksize / step;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
 
-	shash->tfm = fs_info->csum_shash;
 	/* The full block must be inside the folio. */
 	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
 
-	if (folio_test_partial_kmap(folio)) {
-		size_t cur = paddr;
+	for (int i = 0; i < nr_steps; i++) {
+		u32 pindex = offset_in_folio(folio, paddr + i * step) >> PAGE_SHIFT;
 
-		crypto_shash_init(shash);
-		while (cur < paddr + blocksize) {
-			void *kaddr;
-			size_t len = min(paddr + blocksize - cur,
-					 PAGE_SIZE - offset_in_page(cur));
-
-			kaddr = kmap_local_folio(folio, offset_in_folio(folio, cur));
-			crypto_shash_update(shash, kaddr, len);
-			kunmap_local(kaddr);
-			cur += len;
-		}
-		crypto_shash_final(shash, dest);
-	} else {
-		crypto_shash_digest(shash, phys_to_virt(paddr), blocksize, dest);
+		/*
+		 * For bs <= ps cases, we will only run the loop once, so the offset
+		 * inside the page will only added to paddrs[0].
+		 *
+		 * For bs > ps cases, the block must be page aligned, thus offset
+		 * inside the page will always be 0.
+		 */
+		paddrs[i] = page_to_phys(folio_page(folio, pindex)) + offset_in_page(paddr);
 	}
+	return btrfs_calculate_block_csum_pages(fs_info, paddrs, dest);
 }
+
+/*
+ * Calculate the checksum of a fs block backed by multiple incontiguous pages at @paddrs[]
+ * and save the result to @dest.
+ *
+ * The folio containing @paddr must be large enough to contain a full fs block.
+ */
+void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
+				      const phys_addr_t paddrs[], u8 *dest)
+{
+	const u32 blocksize = fs_info->sectorsize;
+	const u32 step = min(blocksize, PAGE_SIZE);
+	const u32 nr_steps = blocksize / step;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	for (int i = 0; i < nr_steps; i++) {
+		const phys_addr_t paddr = paddrs[i];
+		void *kaddr;
+
+		ASSERT(offset_in_page(paddr) + step <= PAGE_SIZE);
+		kaddr = kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
+		crypto_shash_update(shash, kaddr, step);
+		kunmap_local(kaddr);
+	}
+	crypto_shash_final(shash, dest);
+}
+
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
@@ -3382,7 +3413,7 @@ void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected)
 {
-	btrfs_calculate_block_csum(fs_info, paddr, csum);
+	btrfs_calculate_block_csum_folio(fs_info, paddr, csum);
 	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		return -EIO;
 	return 0;
-- 
2.51.2


