Return-Path: <linux-btrfs+bounces-16737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BBB4A020
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 05:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208504E6561
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 03:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04305273D92;
	Tue,  9 Sep 2025 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W/jU3KEf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W/jU3KEf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A21AF4D5
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389146; cv=none; b=JwAGc1/sf73ymtI3tGZRRihXB5mQQBmIFy159G3Daw5kKoFBLJ/MnDXhrGKgz9sd6xDx29Gr4NzqqCpEdId5F06oETd2mC4TR8JjZqR6DFyjSrdsWuNsxWdlO2TUFQ2WPyV9J6RDjG4s9k/v3YfOPvdbEpwXE59AgRkSLUo9wIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389146; c=relaxed/simple;
	bh=QqJ0VAeVFRb2sjhffwI/OonRw5pqG2VVBBxO6Fa1ADw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA0pSSazsv1H7cu47cObhQlt5opdlKi2X4H+psxyDvyRN+2gs0cl4DEoV6XxI1gGzf5UCWp8fxnSgSQboqnRI2PQUJdTtfkhkjV6UQPkqmXoz/3QZiTb3OdFNu9xy93o9z1W0I2OAAVZH2JDV4WZ9p657aCw6UVn0TiY06ZqjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W/jU3KEf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W/jU3KEf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 274AB34C80
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR5d9MRrz+6H6EpLLyeq3EjJe80TO3fCcSmKNUWdJOI=;
	b=W/jU3KEfBZU6Chlq9Tb2VzYO5GrU+brBeHbZN+LBAXkEw830ZwqGI5wx+KVby+2N8CGFNW
	QsFgrOr0ebFW9z1WpzXtseoR0dyEBsBOr7BVpuHLSBf77ectT+GalNjERMcjkw0OhVnvFl
	egnKcHxFnVeQ2z7Rax3zODvA5K21C1A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR5d9MRrz+6H6EpLLyeq3EjJe80TO3fCcSmKNUWdJOI=;
	b=W/jU3KEfBZU6Chlq9Tb2VzYO5GrU+brBeHbZN+LBAXkEw830ZwqGI5wx+KVby+2N8CGFNW
	QsFgrOr0ebFW9z1WpzXtseoR0dyEBsBOr7BVpuHLSBf77ectT+GalNjERMcjkw0OhVnvFl
	egnKcHxFnVeQ2z7Rax3zODvA5K21C1A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636D913996
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CM/ECVShv2i7JgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 03:39:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: prepare compression folio alloc/free for bs > ps cases
Date: Tue,  9 Sep 2025 13:08:37 +0930
Message-ID: <160ef7471ce890c053195fb3713fda85a6aa9fef.1757388121.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757388121.git.wqu@suse.com>
References: <cover.1757388121.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

This includes the following preparation for bs > ps cases:

- Always alloc/free the folio directly if bs > ps
  This adds a new @fs_info parameter for btrfs_alloc_compr_folio(), thus
  affecting all compression algorithms.

  For btrfs_free_compr_folio() it needs no parameter for now, as we can
  use the folio size to skip the caching part.

  For now the change is just to passing a @fs_info into the function,
  all the folio size assumption is still based on page size.

- Use correct folio size for btrfs_add_compressed_bio_folios()
  Instead of page size, use the correct folio size.

- Use correct folio size/shift for btrfs_compress_filemap_get_folio()
  As we are not only using simple page sized folios anymore.

- Skip readahead for compressed pages
  Similar to subpage cases.

- Make btrfs_alloc_folio_array() to accept a new @order parameter

- Add a helper to calculate the minimal folio size

All those changes should not affect the existing bs <= ps handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 38 ++++++++++++++++++++++++++++----------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   |  7 +++++--
 fs/btrfs/extent_io.h   |  3 ++-
 fs/btrfs/fs.h          |  6 ++++++
 fs/btrfs/inode.c       |  5 +++--
 fs/btrfs/lzo.c         | 18 ++++++++++--------
 fs/btrfs/zlib.c        | 13 +++++++------
 fs/btrfs/zstd.c        | 15 ++++++++-------
 9 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 068339e86123..969c79fbaa1e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -223,10 +223,14 @@ static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_co
 /*
  * Common wrappers for page allocation from compression wrappers
  */
-struct folio *btrfs_alloc_compr_folio(void)
+struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info)
 {
 	struct folio *folio = NULL;
 
+	/* For bs > ps cases, no cached folio pool for now. */
+	if (fs_info->block_min_order)
+		goto alloc;
+
 	spin_lock(&compr_pool.lock);
 	if (compr_pool.count > 0) {
 		folio = list_first_entry(&compr_pool.list, struct folio, lru);
@@ -238,13 +242,18 @@ struct folio *btrfs_alloc_compr_folio(void)
 	if (folio)
 		return folio;
 
-	return folio_alloc(GFP_NOFS, 0);
+alloc:
+	return folio_alloc(GFP_NOFS, fs_info->block_min_order);
 }
 
 void btrfs_free_compr_folio(struct folio *folio)
 {
 	bool do_free = false;
 
+	/* The folio is from bs > ps fs, no cached pool for now. */
+	if (folio_order(folio))
+		goto free;
+
 	spin_lock(&compr_pool.lock);
 	if (compr_pool.count > compr_pool.thresh) {
 		do_free = true;
@@ -257,6 +266,7 @@ void btrfs_free_compr_folio(struct folio *folio)
 	if (!do_free)
 		return;
 
+free:
 	ASSERT(folio_ref_count(folio) == 1);
 	folio_put(folio);
 }
@@ -344,16 +354,19 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 
 static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = cb->bbio.fs_info;
 	struct bio *bio = &cb->bbio.bio;
 	u32 offset = 0;
 
 	while (offset < cb->compressed_len) {
+		struct folio *folio;
 		int ret;
-		u32 len = min_t(u32, cb->compressed_len - offset, PAGE_SIZE);
+		u32 len = min_t(u32, cb->compressed_len - offset,
+				btrfs_min_folio_size(fs_info));
 
+		folio = cb->compressed_folios[offset >> (PAGE_SHIFT + fs_info->block_min_order)];
 		/* Maximum compressed extent is smaller than bio size limit. */
-		ret = bio_add_folio(bio, cb->compressed_folios[offset >> PAGE_SHIFT],
-				    len, 0);
+		ret = bio_add_folio(bio, folio, len, 0);
 		ASSERT(ret);
 		offset += len;
 	}
@@ -443,6 +456,10 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	if (fs_info->sectorsize < PAGE_SIZE)
 		return 0;
 
+	/* For bs > ps cases, we don't support readahead for compressed folios for now. */
+	if (fs_info->block_min_order)
+		return 0;
+
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	while (cur < compressed_end) {
@@ -606,14 +623,15 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	btrfs_free_extent_map(em);
 
-	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
+	cb->nr_folios = DIV_ROUND_UP(compressed_len, btrfs_min_folio_size(fs_info));
 	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);
 	if (!cb->compressed_folios) {
 		status = BLK_STS_RESOURCE;
 		goto out_free_bio;
 	}
 
-	ret = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios);
+	ret = btrfs_alloc_folio_array(cb->nr_folios, fs_info->block_min_order,
+				      cb->compressed_folios);
 	if (ret) {
 		status = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
@@ -1033,12 +1051,12 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * - compression algo are 0-3
  * - the level are bits 4-7
  *
- * @out_pages is an in/out parameter, holds maximum number of pages to allocate
- * and returns number of actually allocated pages
+ * @out_folios is an in/out parameter, holds maximum number of folios to allocate
+ * and returns number of actually allocated folios
  *
  * @total_in is used to return the number of bytes actually read.  It
  * may be smaller than the input length if we had to exit early because we
- * ran out of room in the pages array or because we cross the
+ * ran out of room in the folios array or because we cross the
  * max_out threshold.
  *
  * @total_out is an in/out parameter, must be set to the input length and will
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 760d4aac74e6..41d93a977d69 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -112,7 +112,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 int btrfs_compress_str2level(unsigned int type, const char *str);
 
-struct folio *btrfs_alloc_compr_folio(void);
+struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info);
 void btrfs_free_compr_folio(struct folio *folio);
 
 struct workspace_manager {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca7174fa0240..258658856195 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -618,6 +618,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
  * Populate every free slot in a provided array with folios using GFP_NOFS.
  *
  * @nr_folios:   number of folios to allocate
+ * @order:	 the order of the folios to be allocated
  * @folio_array: the array to fill with folios; any existing non-NULL entries in
  *		 the array will be skipped
  *
@@ -625,12 +626,13 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
  *         -ENOMEM  otherwise, the partially allocated folios would be freed and
  *                  the array slots zeroed
  */
-int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
+int btrfs_alloc_folio_array(unsigned int nr_folios, unsigned int order,
+			    struct folio **folio_array)
 {
 	for (int i = 0; i < nr_folios; i++) {
 		if (folio_array[i])
 			continue;
-		folio_array[i] = folio_alloc(GFP_NOFS, 0);
+		folio_array[i] = folio_alloc(GFP_NOFS, order);
 		if (!folio_array[i])
 			goto error;
 	}
@@ -639,6 +641,7 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
 	for (int i = 0; i < nr_folios; i++) {
 		if (folio_array[i])
 			folio_put(folio_array[i]);
+		folio_array[i] = NULL;
 	}
 	return -ENOMEM;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 61130786b9a3..5fcbfe44218c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -366,7 +366,8 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   bool nofail);
-int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array);
+int btrfs_alloc_folio_array(unsigned int nr_folios, unsigned int order,
+			    struct folio **folio_array);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bf4a1b75b0cf..4a48b19ea863 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -921,6 +921,12 @@ static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
 }
 
+/* Return the minimal folio size of the fs. */
+static inline unsigned int btrfs_min_folio_size(struct btrfs_fs_info *fs_info)
+{
+	return 1 << (PAGE_SHIFT + fs_info->block_min_order);
+}
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ad876779289e..25d3b67070e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -854,6 +854,7 @@ static void compress_file_range(struct btrfs_work *work)
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
@@ -902,8 +903,8 @@ static void compress_file_range(struct btrfs_work *work)
 	actual_end = min_t(u64, i_size, end + 1);
 again:
 	folios = NULL;
-	nr_folios = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
-	nr_folios = min_t(unsigned long, nr_folios, BTRFS_MAX_COMPRESSED_PAGES);
+	nr_folios = (end >> min_folio_shift) - (start >> min_folio_shift) + 1;
+	nr_folios = min_t(unsigned long, nr_folios, BTRFS_MAX_COMPRESSED >> min_folio_shift);
 
 	/*
 	 * we don't want to send crud past the end of i_size through
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 047d90e216f6..c5a25fd872bd 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -132,13 +132,14 @@ static inline size_t read_compress_length(const char *buf)
  *
  * Will allocate new pages when needed.
  */
-static int copy_compressed_data_to_page(char *compressed_data,
+static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
+					char *compressed_data,
 					size_t compressed_size,
 					struct folio **out_folios,
 					unsigned long max_nr_folio,
-					u32 *cur_out,
-					const u32 sectorsize)
+					u32 *cur_out)
 {
+	const u32 sectorsize = fs_info->sectorsize;
 	u32 sector_bytes_left;
 	u32 orig_out;
 	struct folio *cur_folio;
@@ -156,7 +157,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	cur_folio = out_folios[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
 	if (!cur_folio) {
-		cur_folio = btrfs_alloc_compr_folio();
+		cur_folio = btrfs_alloc_compr_folio(fs_info);
 		if (!cur_folio)
 			return -ENOMEM;
 		out_folios[*cur_out / PAGE_SIZE] = cur_folio;
@@ -182,7 +183,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		cur_folio = out_folios[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
 		if (!cur_folio) {
-			cur_folio = btrfs_alloc_compr_folio();
+			cur_folio = btrfs_alloc_compr_folio(fs_info);
 			if (!cur_folio)
 				return -ENOMEM;
 			out_folios[*cur_out / PAGE_SIZE] = cur_folio;
@@ -217,8 +218,9 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 			unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	const u32 sectorsize = fs_info->sectorsize;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	struct folio *folio_in = NULL;
 	char *sizes_ptr;
@@ -268,9 +270,9 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			goto out;
 		}
 
-		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
+		ret = copy_compressed_data_to_page(fs_info, workspace->cbuf, out_len,
 						   folios, max_nr_folio,
-						   &cur_out, sectorsize);
+						   &cur_out);
 		if (ret < 0)
 			goto out;
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d72566a87afa..ccf77a0fa96c 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -136,6 +136,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
@@ -147,7 +148,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
-	const u32 blocksize = inode->root->fs_info->sectorsize;
+	const u32 blocksize = fs_info->sectorsize;
 	const u64 orig_end = start + len;
 
 	*out_folios = 0;
@@ -156,7 +157,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 	ret = zlib_deflateInit(&workspace->strm, workspace->level);
 	if (unlikely(ret != Z_OK)) {
-		btrfs_err(inode->root->fs_info,
+		btrfs_err(fs_info,
 	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
 		ret = -EIO;
@@ -166,7 +167,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_folio = btrfs_alloc_compr_folio();
+	out_folio = btrfs_alloc_compr_folio(fs_info);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -224,7 +225,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (unlikely(ret != Z_OK)) {
-			btrfs_warn(inode->root->fs_info,
+			btrfs_warn(fs_info,
 		"zlib compression failed, error %d root %llu inode %llu offset %llu",
 				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
 				   start);
@@ -249,7 +250,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -285,7 +286,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index b11a87842cda..28e2e99a2463 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -400,6 +400,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	zstd_cstream *stream;
@@ -412,7 +413,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
-	const u32 blocksize = inode->root->fs_info->sectorsize;
+	const u32 blocksize = fs_info->sectorsize;
 	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
 	unsigned int cur_len;
 
@@ -425,7 +426,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
 			workspace->size);
 	if (unlikely(!stream)) {
-		btrfs_err(inode->root->fs_info,
+		btrfs_err(fs_info,
 	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
 			  workspace->req_level, btrfs_root_id(inode->root),
 			  btrfs_ino(inode), start);
@@ -443,7 +444,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	workspace->in_buf.size = cur_len;
 
 	/* Allocate and map in the output buffer */
-	out_folio = btrfs_alloc_compr_folio();
+	out_folio = btrfs_alloc_compr_folio(fs_info);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -459,7 +460,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (unlikely(zstd_is_error(ret2))) {
-			btrfs_warn(inode->root->fs_info,
+			btrfs_warn(fs_info,
 "zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
 				   workspace->req_level, zstd_get_error_code(ret2),
 				   btrfs_root_id(inode->root), btrfs_ino(inode),
@@ -491,7 +492,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -532,7 +533,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 		ret2 = zstd_end_stream(stream, &workspace->out_buf);
 		if (unlikely(zstd_is_error(ret2))) {
-			btrfs_err(inode->root->fs_info,
+			btrfs_err(fs_info,
 "zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
 				  workspace->req_level, zstd_get_error_code(ret2),
 				  btrfs_root_id(inode->root), btrfs_ino(inode),
@@ -556,7 +557,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			ret = -E2BIG;
 			goto out;
 		}
-		out_folio = btrfs_alloc_compr_folio();
+		out_folio = btrfs_alloc_compr_folio(fs_info);
 		if (out_folio == NULL) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.50.1


