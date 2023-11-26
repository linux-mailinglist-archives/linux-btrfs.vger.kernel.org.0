Return-Path: <linux-btrfs+bounces-361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD317F95BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 23:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36CB1C208E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDC14F62;
	Sun, 26 Nov 2023 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FCF0
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 14:19:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E11A21C81
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 22:19:06 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C87A13907
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 22:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1kLIKljEY2UTbAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 22:19:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Date: Mon, 27 Nov 2023 08:48:45 +1030
Message-ID: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++
X-Spam-Score: 20.51
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 1E11A21C81
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com
X-Spamd-Result: default: False [20.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 NEURAL_SPAM_SHORT(2.17)[0.723];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.34)[0.956];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

For now extent_buffer::pages[] are still only accept single page
pointer, thus we can migrate to folios pretty easily.

As for single page, page and folio are 1:1 mapped.

This patch would just do the conversion from struct page to struct
folio, providing the first step to higher order folio in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Some existing infrastructure like get_eb_page_index() can be used to
help the conversion to higher order folio.

Initially I tried to keep using page pointers for compound pages,
but since they are using the same page pointer, it's pretty easy to get
confused on whether the page is single or compound, and lead to various
VM BUGs.

Migrating to folio would address the problem much easier.

Unfortunately this patch is just migrating extent_buffer::pages[] type
to folio, we still have a lot of things worthy cleanup, but it should
provide the last preparation needed for higher order folio integration.
---
 fs/btrfs/accessors.c             |  18 ++---
 fs/btrfs/accessors.h             |   4 +-
 fs/btrfs/ctree.c                 |   2 +-
 fs/btrfs/disk-io.c               |  18 ++---
 fs/btrfs/extent_io.c             | 134 +++++++++++++++++--------------
 fs/btrfs/extent_io.h             |   2 +-
 fs/btrfs/tests/extent-io-tests.c |   6 +-
 7 files changed, 98 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 206cf1612c1d..ecc204728475 100644
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
index 7fc78171a262..df9d860efc20 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -90,14 +90,13 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		return;
 	}
 
-	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
+	kaddr = folio_address(buf->folios[0]) + offset_in_page(buf->start);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
-		kaddr = page_address(buf->pages[i]);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
-	}
+	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
+		crypto_shash_update(shash, folio_address(buf->folios[i]),
+				    PAGE_SIZE);
 	crypto_shash_final(shash, result);
 }
 
@@ -180,7 +179,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		return -EROFS;
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+		struct page *p = folio_page(eb->folios[i], 0);
 		u64 start = max_t(u64, eb->start, page_offset(p));
 		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
 		u32 len = end - start;
@@ -268,8 +267,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0], eb->start,
-					      eb->len)))
+	if (WARN_ON(!btrfs_page_test_uptodate(fs_info,
+					folio_page(eb->folios[0], 0), eb->start,
+					eb->len)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
@@ -378,7 +378,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 	}
 
 	csum_tree_block(eb, result);
-	header_csum = page_address(eb->pages[0]) +
+	header_csum = folio_address(eb->folios[0]) +
 		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fcd7b4674d08..96e15cbdc660 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -715,6 +715,21 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 	return alloc_page_array(nr_pages, page_array, 0);
 }
 
+static int alloc_eb_folio_array(unsigned int nr_pages,
+				struct folio **folio_array,
+				gfp_t extra_gfp)
+{
+	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES];
+	int ret;
+
+	ret = alloc_page_array(nr_pages, page_array, extra_gfp);
+	if (ret < 0)
+		return ret;
+	for (int i = 0; i < nr_pages; i++)
+		folio_array[i] = page_folio(page_array[i]);
+	return 0;
+}
+
 static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 				struct page *page, u64 disk_bytenr,
 				unsigned int pg_offset)
@@ -1692,7 +1707,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	if (fs_info->nodesize < PAGE_SIZE) {
-		struct page *p = eb->pages[0];
+		struct page *p = folio_page(eb->folios[0], 0);
 
 		lock_page(p);
 		btrfs_subpage_set_writeback(fs_info, p, eb->start, eb->len);
@@ -1706,7 +1721,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		unlock_page(p);
 	} else {
 		for (int i = 0; i < num_extent_pages(eb); i++) {
-			struct page *p = eb->pages[i];
+			struct page *p = folio_page(eb->folios[i], 0);
 
 			lock_page(p);
 			clear_page_dirty_for_io(p);
@@ -3175,7 +3190,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
+		struct page *page = folio_page(eb->folios[i], 0);
 
 		if (!page)
 			continue;
@@ -3237,7 +3252,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = btrfs_alloc_page_array(num_pages, new->pages);
+	ret = alloc_eb_folio_array(num_pages, new->folios, 0);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -3245,7 +3260,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 
 	for (i = 0; i < num_pages; i++) {
 		int ret;
-		struct page *p = new->pages[i];
+		struct page *p = folio_page(new->folios[i], 0);
 
 		ret = attach_extent_buffer_page(new, p, NULL);
 		if (ret < 0) {
@@ -3273,12 +3288,12 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 		return NULL;
 
 	num_pages = num_extent_pages(eb);
-	ret = btrfs_alloc_page_array(num_pages, eb->pages);
+	ret = alloc_eb_folio_array(num_pages, eb->folios, 0);
 	if (ret)
 		goto err;
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+		struct page *p = folio_page(eb->folios[i], 0);
 
 		ret = attach_extent_buffer_page(eb, p, NULL);
 		if (ret < 0)
@@ -3292,9 +3307,9 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3352,7 +3367,7 @@ static void mark_extent_buffer_accessed(struct extent_buffer *eb,
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
+		struct page *p = folio_page(eb->folios[i], 0);
 
 		if (p != accessed)
 			mark_page_accessed(p);
@@ -3494,7 +3509,7 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 }
 
 /*
- * Return 0 if eb->pages[i] is attached to btree inode successfully.
+ * Return 0 if eb->folios[i] is attached to btree inode successfully.
  * Return >0 if there is already annother extent buffer for the range,
  * and @found_eb_ret would be updated.
  */
@@ -3510,11 +3525,11 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 
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
@@ -3535,8 +3550,8 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 		 * We're going to reuse the existing page, can
 		 * drop our page and subpage structure now.
 		 */
-		__free_page(eb->pages[i]);
-		eb->pages[i] = folio_page(existing_folio, 0);
+		__free_page(folio_page(eb->folios[i], 0));
+		eb->folios[i] = existing_folio;
 	} else {
 		struct extent_buffer *existing_eb;
 
@@ -3553,8 +3568,8 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
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
@@ -3623,7 +3638,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Alloc all pages. */
-	ret = alloc_page_array(num_pages, eb->pages, __GFP_NOFAIL);
+	ret = alloc_eb_folio_array(num_pages, eb->folios, __GFP_NOFAIL);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		btrfs_free_subpage(prealloc);
@@ -3646,7 +3661,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * reliable, as we may choose to reuse the existing page cache
 		 * and free the allocated page.
 		 */
-		eb_page = eb->pages[i];
+		eb_page = folio_page(eb->folios[i], 0);
 
 		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
@@ -3669,7 +3684,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * Check if the current page is physically contiguous with previous eb
 		 * page.
 		 */
-		if (i && eb->pages[i - 1] + 1 != eb_page)
+		if (i && folio_page(eb->folios[i - 1], 0) + 1 != eb_page)
 			page_contig = false;
 		if (!btrfs_page_test_uptodate(fs_info, eb_page, eb->start, eb->len))
 			uptodate = 0;
@@ -3686,7 +3701,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	/* All pages are physically contiguous, can skip cross page handling. */
 	if (page_contig)
-		eb->addr = page_address(eb->pages[0]) + offset_in_page(eb->start);
+		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
 
 again:
 	ret = radix_tree_preload(GFP_NOFS);
@@ -3715,14 +3730,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * live buffer and won't free them prematurely.
 	 */
 	for (int i = 0; i < num_pages; i++)
-		unlock_page(eb->pages[i]);
+		folio_unlock(eb->folios[i]);
 	return eb;
 
 out:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
 	for (int i = 0; i < attached; i++) {
-		ASSERT(eb->pages[i]);
-		unlock_page(eb->pages[i]);
+		ASSERT(eb->folios[i]);
+		folio_unlock(eb->folios[i]);
 	}
 
 	btrfs_release_extent_buffer(eb);
@@ -3836,7 +3851,7 @@ static void btree_clear_page_dirty(struct page *page)
 static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page = eb->pages[0];
+	struct page *page = folio_page(eb->folios[0], 0);
 	bool last;
 
 	/* btree_clear_page_dirty() needs page locked */
@@ -3855,7 +3870,6 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i;
 	int num_pages;
-	struct page *page;
 
 	btrfs_assert_tree_write_locked(eb);
 
@@ -3874,7 +3888,9 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	num_pages = num_extent_pages(eb);
 
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		struct page *page;
+
+		page = folio_page(eb->folios[i], 0);
 		if (!PageDirty(page))
 			continue;
 		lock_page(page);
@@ -3913,33 +3929,35 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		 * the above race.
 		 */
 		if (subpage)
-			lock_page(eb->pages[0]);
+			lock_page(folio_page(eb->folios[0], 0));
 		for (i = 0; i < num_pages; i++)
-			btrfs_page_set_dirty(eb->fs_info, eb->pages[i],
+			btrfs_page_set_dirty(eb->fs_info,
+					     folio_page(eb->folios[i], 0),
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
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page;
 	int num_pages;
 	int i;
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		struct page *page;
+
+		page = folio_page(eb->folios[i], 0);
 		if (!page)
 			continue;
 
@@ -3958,14 +3976,15 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page;
 	int num_pages;
 	int i;
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
+		struct page *page;
+
+		page = folio_page(eb->folios[i], 0);
 
 		/*
 		 * This is special handling for metadata subpage, as regular
@@ -4056,11 +4075,12 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
 	if (eb->fs_info->nodesize < PAGE_SIZE) {
-		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
-			       eb->start - page_offset(eb->pages[0]));
+		__bio_add_page(&bbio->bio, folio_page(eb->folios[0], 0),
+			       eb->len, eb->start - folio_pos(eb->folios[0]));
 	} else {
 		for (i = 0; i < num_pages; i++)
-			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
+			__bio_add_page(&bbio->bio, folio_page(eb->folios[i], 0),
+				       PAGE_SIZE, 0);
 	}
 	btrfs_submit_bio(bbio, mirror_num);
 
@@ -4131,7 +4151,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
+		page = folio_page(eb->folios[i], 0);
 
 		cur = min(len, (PAGE_SIZE - offset));
 		kaddr = page_address(page);
@@ -4150,7 +4170,6 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 {
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
 	char __user *dst = (char __user *)dstv;
 	unsigned long i = get_eb_page_index(start);
@@ -4168,10 +4187,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
-
 		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
+		kaddr = folio_address(eb->folios[i]);
 		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
 			ret = -EFAULT;
 			break;
@@ -4191,7 +4208,6 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 {
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
 	unsigned long i = get_eb_page_index(start);
@@ -4206,11 +4222,9 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
-
 		cur = min(len, (PAGE_SIZE - offset));
 
-		kaddr = page_address(page);
+		kaddr = folio_address(eb->folios[i]);
 		ret = memcmp(ptr, kaddr + offset, cur);
 		if (ret)
 			break;
@@ -4260,7 +4274,6 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 {
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
 	unsigned long i = get_eb_page_index(start);
@@ -4283,12 +4296,11 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
-		page = eb->pages[i];
 		if (check_uptodate)
-			assert_eb_page_uptodate(eb, page);
+			assert_eb_page_uptodate(eb, folio_page(eb->folios[i], 0));
 
 		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
+		kaddr = folio_address(eb->folios[i]);
 		if (use_memmove)
 			memmove(kaddr + offset, src, cur);
 		else
@@ -4321,7 +4333,7 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 		unsigned long index = get_eb_page_index(cur);
 		unsigned int offset = get_eb_offset_in_page(eb, cur);
 		unsigned int cur_len = min(start + len - cur, PAGE_SIZE - offset);
-		struct page *page = eb->pages[index];
+		struct page *page = folio_page(eb->folios[index], 0);
 
 		assert_eb_page_uptodate(eb, page);
 		memset(page_address(page) + offset, c, cur_len);
@@ -4349,7 +4361,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 		unsigned long index = get_eb_page_index(cur);
 		unsigned long offset = get_eb_offset_in_page(src, cur);
 		unsigned long cur_len = min(src->len, PAGE_SIZE - offset);
-		void *addr = page_address(src->pages[index]) + offset;
+		void *addr = folio_address(src->folios[index]) + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
 
@@ -4378,7 +4390,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	offset = get_eb_offset_in_page(dst, dst_offset);
 
 	while (len > 0) {
-		page = dst->pages[i];
+		page = folio_page(dst->folios[i], 0);
 		assert_eb_page_uptodate(dst, page);
 
 		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
@@ -4441,7 +4453,7 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 	size_t offset;
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
-	page = eb->pages[i];
+	page = folio_page(eb->folios[i], 0);
 	assert_eb_page_uptodate(eb, page);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
@@ -4453,7 +4465,7 @@ static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long
 
 	if (check_eb_range(eb, bytenr, 1))
 		return NULL;
-	return page_address(eb->pages[index]) + get_eb_offset_in_page(eb, bytenr);
+	return folio_address(eb->folios[index]) + get_eb_offset_in_page(eb, bytenr);
 }
 
 /*
@@ -4561,7 +4573,7 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 		unsigned long pg_off = get_eb_offset_in_page(dst, cur_src);
 		unsigned long cur_len = min(src_offset + len - cur_src,
 					    PAGE_SIZE - pg_off);
-		void *src_addr = page_address(dst->pages[pg_index]) + pg_off;
+		void *src_addr = folio_address(dst->folios[pg_index]) + pg_off;
 		const bool use_memmove = areas_overlap(src_offset + cur_off,
 						       dst_offset + cur_off, cur_len);
 
@@ -4608,8 +4620,8 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
 
-		src_addr = page_address(dst->pages[src_i]) + src_off_in_page -
-					cur + 1;
+		src_addr = folio_address(dst->folios[src_i]) + src_off_in_page -
+			   cur + 1;
 		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
 					    cur);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6531285ef0bc..dc1b4948b5a3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -93,7 +93,7 @@ struct extent_buffer {
 
 	struct rw_semaphore lock;
 
-	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct folio *folios[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 	pid_t lock_owner;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 1cc86af97dc6..975ce8d5ecd4 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -652,8 +652,8 @@ static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
 					const char *test_name)
 {
 	for (int i = 0; i < eb->len; i++) {
-		struct page *page = eb->pages[i >> PAGE_SHIFT];
-		void *addr = page_address(page) + offset_in_page(i);
+		void *addr = folio_address(eb->folios[i >> PAGE_SHIFT]) +
+			     offset_in_page(i);
 
 		if (memcmp(addr, memory + i, 1) != 0) {
 			test_err("%s failed", test_name);
@@ -668,7 +668,7 @@ static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
 				const char *test_name)
 {
 	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
-		void *eb_addr = page_address(eb->pages[i]);
+		void *eb_addr = folio_address(eb->folios[i]);
 
 		if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE) != 0) {
 			dump_eb_and_memory_contents(eb, memory, test_name);
-- 
2.42.1


