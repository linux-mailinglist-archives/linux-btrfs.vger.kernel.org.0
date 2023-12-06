Return-Path: <linux-btrfs+bounces-729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EDE807C15
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 00:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BA728259A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF22E3F5;
	Wed,  6 Dec 2023 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fIPwpLQj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BFD5E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 15:09:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6E1221DF8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701904190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeVPifG8KcaMENn1T9U1ENl7UxCuEfVudMbIjAvXj2Y=;
	b=fIPwpLQjr2riFNQ+dFcVYwq62/4kuOtWz3iiS181cKAb8O8CJIS4+V70FyGjmMzcMURGOd
	ukaLS2N+BDRZP/oOfMxyi7U9TtipMd7Rf5Kc6wLMKc3kItYp2FlkHsO2vtpeFbqCQYAq7a
	iLT38XmSeWjVvt9S11MyIQtTYAe9164=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 76AE913403
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 23:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YB0rAj3/cGXMEAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Dec 2023 23:09:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: migrate extent_buffer::pages[] to folio
Date: Thu,  7 Dec 2023 09:39:27 +1030
Message-ID: <a39b5089bc761985891401dbe608cf716b9e02e9.1701902977.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701902977.git.wqu@suse.com>
References: <cover.1701902977.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.978];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

For now extent_buffer::pages[] are still only accept single page
pointer, thus we can migrate to folios pretty easily.

As for single page, page and folio are 1:1 mapped, including their page
flags.

This patch would just do the conversion from struct page to struct
folio, providing the first step to higher order folio in the future.

This conversion is pretty simple:

- extent_buffer::pages[] -> extent_buffer::folios[]

- page_address(eb->pages[i]) -> folio_address(eb->pages[i])

- eb->pages[i] -> folio_page(eb->folios[i], 0)

There would be more specific cleanups preparing for the incoming higher
order folio support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.c             |  20 ++---
 fs/btrfs/accessors.h             |   4 +-
 fs/btrfs/ctree.c                 |   2 +-
 fs/btrfs/disk-io.c               |  19 ++---
 fs/btrfs/extent_io.c             | 123 ++++++++++++++++++-------------
 fs/btrfs/extent_io.h             |   7 +-
 fs/btrfs/tests/extent-io-tests.c |   4 +-
 7 files changed, 103 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 206cf1612c1d..8f7cbb7154d4 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -27,7 +27,7 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb)
 {
 	token->eb = eb;
-	token->kaddr = page_address(eb->pages[0]);
+	token->kaddr = folio_address(eb->folios[0]);
 	token->offset = 0;
 }
 
@@ -50,7 +50,7 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
  * an offset into the extent buffer page array, cast to a specific type.  This
  * gives us all the type checking.
  *
- * The extent buffer pages stored in the array pages do not form a contiguous
+ * The extent buffer pages stored in the array folios may not form a contiguous
  * phyusical range, but the API functions assume the linear offset to the range
  * from 0 to metadata node size.
  */
@@ -74,13 +74,13 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	    member_offset + size <= token->offset + PAGE_SIZE) {	\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
 	}								\
-	token->kaddr = page_address(token->eb->pages[idx]);		\
+	token->kaddr = folio_address(token->eb->folios[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE ) \
 		return get_unaligned_le##bits(token->kaddr + oip);	\
 									\
 	memcpy(lebytes, token->kaddr + oip, part);			\
-	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
+	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
 	token->offset = (idx + 1) << PAGE_SHIFT;			\
 	memcpy(lebytes + part, token->kaddr, size - part);		\
 	return get_unaligned_le##bits(lebytes);				\
@@ -91,7 +91,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
 	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
 	const unsigned long idx = get_eb_page_index(member_offset);	\
-	char *kaddr = page_address(eb->pages[idx]);			\
+	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
 	u8 lebytes[sizeof(u##bits)];					\
@@ -101,7 +101,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 		return get_unaligned_le##bits(kaddr + oip);		\
 									\
 	memcpy(lebytes, kaddr + oip, part);				\
-	kaddr = page_address(eb->pages[idx + 1]);			\
+	kaddr = folio_address(eb->folios[idx + 1]);			\
 	memcpy(lebytes + part, kaddr, size - part);			\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
@@ -125,7 +125,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
-	token->kaddr = page_address(token->eb->pages[idx]);		\
+	token->kaddr = folio_address(token->eb->folios[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
@@ -133,7 +133,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	}								\
 	put_unaligned_le##bits(val, lebytes);				\
 	memcpy(token->kaddr + oip, lebytes, part);			\
-	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
+	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
 	token->offset = (idx + 1) << PAGE_SHIFT;			\
 	memcpy(token->kaddr, lebytes + part, size - part);		\
 }									\
@@ -143,7 +143,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
 	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
 	const unsigned long idx = get_eb_page_index(member_offset);	\
-	char *kaddr = page_address(eb->pages[idx]);			\
+	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = PAGE_SIZE - oip;				\
 	u8 lebytes[sizeof(u##bits)];					\
@@ -156,7 +156,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 									\
 	put_unaligned_le##bits(val, lebytes);				\
 	memcpy(kaddr + oip, lebytes, part);				\
-	kaddr = page_address(eb->pages[idx + 1]);			\
+	kaddr = folio_address(eb->folios[idx + 1]);			\
 	memcpy(kaddr, lebytes + part, size - part);			\
 }
 
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index aa0844535644..ed7aa32972ad 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -90,14 +90,14 @@ static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 {									\
-	const type *p = page_address(eb->pages[0]) +			\
+	const type *p = folio_address(eb->folios[0]) +			\
 			offset_in_page(eb->start);			\
 	return get_unaligned_le##bits(&p->member);			\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
 				    u##bits val)			\
 {									\
-	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
+	type *p = folio_address(eb->folios[0]) + offset_in_page(eb->start); \
 	put_unaligned_le##bits(val, &p->member);			\
 }
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 137c4eb24c28..e6c535cf3749 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -832,7 +832,7 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 
 		if (oip + key_size <= PAGE_SIZE) {
 			const unsigned long idx = get_eb_page_index(offset);
-			char *kaddr = page_address(eb->pages[idx]);
+			char *kaddr = folio_address(eb->folios[idx]);
 
 			oip = get_eb_offset_in_page(eb, offset);
 			tmp = (struct btrfs_disk_key *)(kaddr + oip);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9317606017e2..78bb85f775f6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -89,7 +89,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		first_page_part = fs_info->nodesize;
 		num_pages = 1;
 	} else {
-		kaddr = page_address(buf->pages[0]);
+		kaddr = folio_address(buf->folios[0]);
 		first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 		num_pages = num_extent_pages(buf);
 	}
@@ -98,7 +98,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 			    first_page_part - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
-		kaddr = page_address(buf->pages[i]);
+		kaddr = folio_address(buf->folios[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
@@ -184,13 +184,14 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		return -EROFS;
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-		u64 start = max_t(u64, eb->start, page_offset(p));
-		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
+		u64 start = max_t(u64, eb->start, folio_pos(eb->folios[i]));
+		u64 end = min_t(u64, eb->start + eb->len,
+				folio_pos(eb->folios[i]) + PAGE_SIZE);
 		u32 len = end - start;
 
 		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
-				start, p, offset_in_page(start), mirror_num);
+				start, folio_page(eb->folios[i], 0),
+				offset_in_page(start), mirror_num);
 		if (ret)
 			break;
 	}
@@ -277,8 +278,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0], eb->start,
-					      eb->len)))
+	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, folio_page(eb->folios[0], 0),
+					      eb->start, eb->len)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
@@ -387,7 +388,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 	}
 
 	csum_tree_block(eb, result);
-	header_csum = page_address(eb->pages[0]) +
+	header_csum = folio_address(eb->folios[0]) +
 		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 734016eac82f..131088ec74ef 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -712,6 +712,26 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 	return 0;
 }
 
+/*
+ * Populate needed folios for the extent buffer.
+ *
+ * For now, the folios populated are always in order 0 (aka, single page).
+ */
+static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp)
+{
+	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { NULL };
+	int num_pages = num_extent_pages(eb);
+	int ret;
+
+	ret = btrfs_alloc_page_array(num_pages, page_array, extra_gfp);
+	if (ret < 0)
+		return ret;
+
+	for (int i = 0; i < num_pages; i++)
+		eb->folios[i] = page_folio(page_array[i]);
+	return 0;
+}
+
 static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 				struct page *page, u64 disk_bytenr,
 				unsigned int pg_offset)
@@ -1689,7 +1709,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	if (fs_info->nodesize < PAGE_SIZE) {
-		struct page *p = eb->pages[0];
+		struct page *p = folio_page(eb->folios[0], 0);
 
 		lock_page(p);
 		btrfs_subpage_set_writeback(fs_info, p, eb->start, eb->len);
@@ -1703,7 +1723,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		unlock_page(p);
 	} else {
 		for (int i = 0; i < num_extent_pages(eb); i++) {
-			struct page *p = eb->pages[i];
+			struct page *p = folio_page(eb->folios[i], 0);
 
 			lock_page(p);
 			clear_page_dirty_for_io(p);
@@ -3160,7 +3180,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
+		struct page *page = folio_page(eb->folios[i], 0);
 
 		if (!page)
 			continue;
@@ -3222,7 +3242,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = btrfs_alloc_page_array(num_pages, new->pages, 0);
+	ret = alloc_eb_folio_array(new, 0);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -3230,7 +3250,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 
 	for (i = 0; i < num_pages; i++) {
 		int ret;
-		struct page *p = new->pages[i];
+		struct page *p = folio_page(new->folios[i], 0);
 
 		ret = attach_extent_buffer_page(new, p, NULL);
 		if (ret < 0) {
@@ -3258,12 +3278,12 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 		return NULL;
 
 	num_pages = num_extent_pages(eb);
-	ret = btrfs_alloc_page_array(num_pages, eb->pages, 0);
+	ret = alloc_eb_folio_array(eb, 0);
 	if (ret)
 		goto err;
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+		struct page *p = folio_page(eb->folios[i], 0);
 
 		ret = attach_extent_buffer_page(eb, p, NULL);
 		if (ret < 0)
@@ -3277,9 +3297,9 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 err:
 	for (i = 0; i < num_pages; i++) {
-		if (eb->pages[i]) {
-			detach_extent_buffer_page(eb, eb->pages[i]);
-			__free_page(eb->pages[i]);
+		if (eb->folios[i]) {
+			detach_extent_buffer_page(eb, folio_page(eb->folios[i], 0));
+			__free_page(folio_page(eb->folios[i], 0));
 		}
 	}
 	__free_extent_buffer(eb);
@@ -3337,7 +3357,7 @@ static void mark_extent_buffer_accessed(struct extent_buffer *eb,
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+		struct page *p = folio_page(eb->folios[i], 0);
 
 		if (p != accessed)
 			mark_page_accessed(p);
@@ -3480,7 +3500,7 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 
 
 /*
- * Return 0 if eb->pages[i] is attached to btree inode successfully.
+ * Return 0 if eb->folios[i] is attached to btree inode successfully.
  * Return >0 if there is already annother extent buffer for the range,
  * and @found_eb_ret would be updated.
  */
@@ -3496,11 +3516,11 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 
 	ASSERT(found_eb_ret);
 
-	/* Caller should ensure the page exists. */
-	ASSERT(eb->pages[i]);
+	/* Caller should ensure the folio exists. */
+	ASSERT(eb->folios[i]);
 
 retry:
-	ret = filemap_add_folio(mapping, page_folio(eb->pages[i]), index + i,
+	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 			GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
 		return 0;
@@ -3521,8 +3541,8 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 		 * We're going to reuse the existing page, can
 		 * drop our page and subpage structure now.
 		 */
-		__free_page(eb->pages[i]);
-		eb->pages[i] = folio_page(existing_folio, 0);
+		__free_page(folio_page(eb->folios[i], 0));
+		eb->folios[i] = existing_folio;
 	} else {
 		struct extent_buffer *existing_eb;
 
@@ -3539,8 +3559,8 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 			return 1;
 		}
 		/* The extent buffer no longer exists, we can reuse the folio. */
-		__free_page(eb->pages[i]);
-		eb->pages[i] = folio_page(existing_folio, 0);
+		__free_page(folio_page(eb->folios[i], 0));
+		eb->folios[i] = existing_folio;
 	}
 	return 0;
 }
@@ -3609,7 +3629,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Allocate all pages first. */
-	ret = btrfs_alloc_page_array(num_pages, eb->pages, __GFP_NOFAIL);
+	ret = alloc_eb_folio_array(eb, __GFP_NOFAIL);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3627,11 +3647,11 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		attached++;
 
 		/*
-		 * Only after attach_eb_page_to_filemap(), eb->pages[] is
+		 * Only after attach_eb_page_to_filemap(), eb->folios[] is
 		 * reliable, as we may choose to reuse the existing page cache
 		 * and free the allocated page.
 		 */
-		p = eb->pages[i];
+		p = folio_page(eb->folios[i], 0);
 		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_page(eb, p, prealloc);
@@ -3654,7 +3674,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * Check if the current page is physically contiguous with previous eb
 		 * page.
 		 */
-		if (i && eb->pages[i - 1] + 1 != p)
+		if (i && folio_page(eb->folios[i - 1], 0) + 1 != p)
 			page_contig = false;
 
 		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
@@ -3672,7 +3692,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	/* All pages are physically contiguous, can skip cross page handling. */
 	if (page_contig)
-		eb->addr = page_address(eb->pages[0]) + offset_in_page(eb->start);
+		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
 again:
 	ret = radix_tree_preload(GFP_NOFS);
 	if (ret)
@@ -3700,15 +3720,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * live buffer and won't free them prematurely.
 	 */
 	for (int i = 0; i < num_pages; i++)
-		unlock_page(eb->pages[i]);
+		unlock_page(folio_page(eb->folios[i], 0));
 	return eb;
 
 out:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
 	for (int i = 0; i < attached; i++) {
-		ASSERT(eb->pages[i]);
-		detach_extent_buffer_page(eb, eb->pages[i]);
-		unlock_page(eb->pages[i]);
+		ASSERT(eb->folios[i]);
+		detach_extent_buffer_page(eb, folio_page(eb->folios[i], 0));
+		unlock_page(folio_page(eb->folios[i], 0));
 	}
 	/*
 	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
@@ -3827,7 +3847,7 @@ static void btree_clear_page_dirty(struct page *page)
 static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page = eb->pages[0];
+	struct page *page = folio_page(eb->folios[0], 0);
 	bool last;
 
 	/* btree_clear_page_dirty() needs page locked */
@@ -3879,7 +3899,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	num_pages = num_extent_pages(eb);
 
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 		if (!PageDirty(page))
 			continue;
 		lock_page(page);
@@ -3918,19 +3938,19 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		 * the above race.
 		 */
 		if (subpage)
-			lock_page(eb->pages[0]);
+			lock_page(folio_page(eb->folios[0], 0));
 		for (i = 0; i < num_pages; i++)
-			btrfs_page_set_dirty(eb->fs_info, eb->pages[i],
+			btrfs_page_set_dirty(eb->fs_info, folio_page(eb->folios[i], 0),
 					     eb->start, eb->len);
 		if (subpage)
-			unlock_page(eb->pages[0]);
+			unlock_page(folio_page(eb->folios[0], 0));
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
 					 eb->len,
 					 eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
-		ASSERT(PageDirty(eb->pages[i]));
+		ASSERT(PageDirty(folio_page(eb->folios[i], 0)));
 #endif
 }
 
@@ -3944,7 +3964,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 		if (!page)
 			continue;
 
@@ -3970,7 +3990,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 
 		/*
 		 * This is special handling for metadata subpage, as regular
@@ -4061,11 +4081,12 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
 	if (eb->fs_info->nodesize < PAGE_SIZE) {
-		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
-			       eb->start - page_offset(eb->pages[0]));
+		__bio_add_page(&bbio->bio, folio_page(eb->folios[0], 0), eb->len,
+			       eb->start - folio_pos(eb->folios[0]));
 	} else {
 		for (i = 0; i < num_pages; i++)
-			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
+			__bio_add_page(&bbio->bio, folio_page(eb->folios[i], 0),
+				       PAGE_SIZE, 0);
 	}
 	btrfs_submit_bio(bbio, mirror_num);
 
@@ -4136,7 +4157,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 
 		cur = min(len, (PAGE_SIZE - offset));
 		kaddr = page_address(page);
@@ -4173,7 +4194,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 
 		cur = min(len, (PAGE_SIZE - offset));
 		kaddr = page_address(page);
@@ -4211,7 +4232,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 
 		cur = min(len, (PAGE_SIZE - offset));
 
@@ -4286,7 +4307,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 		if (check_uptodate)
 			assert_eb_page_uptodate(eb, page);
 
@@ -4324,7 +4345,7 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 		unsigned long index = get_eb_page_index(cur);
 		unsigned int offset = get_eb_offset_in_page(eb, cur);
 		unsigned int cur_len = min(start + len - cur, PAGE_SIZE - offset);
-		struct page *page = eb->pages[index];
+		struct page *page = folio_page(eb->folios[index], 0);
 
 		assert_eb_page_uptodate(eb, page);
 		memset_page(page, offset, c, cur_len);
@@ -4352,7 +4373,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 		unsigned long index = get_eb_page_index(cur);
 		unsigned long offset = get_eb_offset_in_page(src, cur);
 		unsigned long cur_len = min(src->len, PAGE_SIZE - offset);
-		void *addr = page_address(src->pages[index]) + offset;
+		void *addr = folio_address(src->folios[index]) + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
 
@@ -4381,7 +4402,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	offset = get_eb_offset_in_page(dst, dst_offset);
 
 	while (len > 0) {
-		page = dst->pages[i];
+		page = folio_page(dst->folios[i], 0);
 		assert_eb_page_uptodate(dst, page);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
@@ -4444,7 +4465,7 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
-	page = eb->pages[i];
+	page = folio_page(eb->folios[i], 0);
 	assert_eb_page_uptodate(eb, page);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
@@ -4456,7 +4477,7 @@ static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long
 
 	if (check_eb_range(eb, bytenr, 1))
 		return NULL;
-	return page_address(eb->pages[index]) + get_eb_offset_in_page(eb, bytenr);
+	return folio_address(eb->folios[index]) + get_eb_offset_in_page(eb, bytenr);
 }
 
 /*
@@ -4563,7 +4584,7 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 		unsigned long pg_off = get_eb_offset_in_page(dst, cur_src);
 		unsigned long cur_len = min(src_offset + len - cur_src,
 					    PAGE_SIZE - pg_off);
-		void *src_addr = page_address(dst->pages[pg_index]) + pg_off;
+		void *src_addr = folio_address(dst->folios[pg_index]) + pg_off;
 		const bool use_memmove = areas_overlap(src_offset + cur_off,
 						       dst_offset + cur_off, cur_len);
 
@@ -4610,8 +4631,8 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
 
-		src_addr = page_address(dst->pages[src_i]) + src_off_in_page -
-					cur + 1;
+		src_addr = folio_address(dst->folios[src_i]) + src_off_in_page -
+					 cur + 1;
 		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
 					    cur);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c73d53c22ec5..66c2e214b141 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,7 +94,12 @@ struct extent_buffer {
 
 	struct rw_semaphore lock;
 
-	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	/*
+	 * Pointers to all the folios of the extent buffer.
+	 *
+	 * For now the folio is always order 0 (aka, a single page).
+	 */
+	struct folio *folios[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 	pid_t lock_owner;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 1cc86af97dc6..25b3349595e0 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -652,7 +652,7 @@ static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 					const char *test_name)
 {
 	for (int i = 0; i < eb->len; i++) {
-		struct page *page = eb->pages[i >> PAGE_SHIFT];
+		struct page *page = folio_page(eb->folios[i >> PAGE_SHIFT], 0);
 		void *addr = page_address(page) + offset_in_page(i);
 
 		if (memcmp(addr, memory + i, 1) != 0) {
@@ -668,7 +668,7 @@ static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
 				const char *test_name)
 {
 	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
-		void *eb_addr = page_address(eb->pages[i]);
+		void *eb_addr = folio_address(eb->folios[i]);
 
 		if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE) != 0) {
 			dump_eb_and_memory_contents(eb, memory, test_name);
-- 
2.43.0


