Return-Path: <linux-btrfs+bounces-469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DEB800386
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 07:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDA21C20A9B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE28C2D9;
	Fri,  1 Dec 2023 06:07:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99484D7D
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 22:07:24 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0C01FD4F
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 06:07:23 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E421344E
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 06:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CCQ2Gxl4aWUTOAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 06:07:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: cleanup metadata page pointer usage
Date: Fri,  1 Dec 2023 16:36:55 +1030
Message-ID: <1d39380364ff0a1c8e6e352a98312fb2a860f25b.1701410201.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701410200.git.wqu@suse.com>
References: <cover.1701410200.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++
X-Spam-Score: 17.58
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 2C0C01FD4F
X-Spamd-Result: default: False [17.58 / 50.00];
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
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_HAM_LONG(-0.42)[-0.423];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Although we have migrated extent_buffer::pages[] to folios[], we're
still mostly using the folio_page() help to grab the page.

This patch would do the following cleanups for metadata:

- Introduce num_extent_folios() helper
  This is to replace most num_extent_pages() callers.

- Use num_extent_folios() to iterate future large folios
  This allows us to use things like
  bio_add_folio()/bio_add_folio_nofail(), and only set the needed flags
  for the folio (aka the leading/tailing page), which reduces the loop
  iteration to 1 for large folios.

- Change metadata related functions to use folio pointers
  Including their function name, involving:
  * attach_extent_buffer_page()
  * detach_extent_buffer_page()
  * page_range_has_eb()
  * btrfs_release_extent_buffer_pages()
  * btree_clear_page_dirty()
  * btrfs_page_inc_eb_refs()
  * btrfs_page_dec_eb_refs()

- Change btrfs_is_subpage() to accept an address_space pointer
  This is to allow both page->mapping and folio->mapping to be utilized.
  As data is still using the old per-page code, and may keep so for a
  while.

- Special corner case place holder for future order mismatches between
  extent buffer and inode filemap
  For now it's  just a block of comments and a dead ASSERT(), no real
  handling yet.

The subpage code would still go page, just because subpage and large
folio are conflicting conditions, thus we don't need to bother subpage
with higher order folios at all. Just folio_page(folio, 0) would be
enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |   6 +
 fs/btrfs/extent_io.c | 319 ++++++++++++++++++++++++-------------------
 fs/btrfs/extent_io.h |  14 ++
 fs/btrfs/inode.c     |   2 +-
 fs/btrfs/subpage.c   |  60 ++++----
 fs/btrfs/subpage.h   |  11 +-
 6 files changed, 239 insertions(+), 173 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 78bb85f775f6..a5ace9f6e790 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -97,6 +97,12 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
+	/*
+	 * Multiple single-page folios case would reach here.
+	 *
+	 * nodesize <= PAGE_SIZE and large folio all handled by above
+	 * crypto_shash_update() already.
+	 */
 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = folio_address(buf->folios[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e93f6a8d1f20..8d762809482b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -441,7 +441,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	else
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, page->mapping))
 		unlock_page(page);
 	else
 		btrfs_subpage_end_reader(fs_info, page, start, len);
@@ -565,7 +565,7 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 	struct folio *folio = page_folio(page);
 
 	ASSERT(PageLocked(page));
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, page->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio));
@@ -886,11 +886,10 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 	} while (size);
 }
 
-static int attach_extent_buffer_page(struct extent_buffer *eb,
-				     struct page *page,
-				     struct btrfs_subpage *prealloc)
+static int attach_extent_buffer_folio(struct extent_buffer *eb,
+				      struct folio *folio,
+				      struct btrfs_subpage *prealloc)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int ret = 0;
 
@@ -900,8 +899,8 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
 	 * For cloned or dummy extent buffers, their pages are not mapped and
 	 * will not race with any other ebs.
 	 */
-	if (page->mapping)
-		lockdep_assert_held(&page->mapping->private_lock);
+	if (folio->mapping)
+		lockdep_assert_held(&folio->mapping->private_lock);
 
 	if (fs_info->nodesize >= PAGE_SIZE) {
 		if (!folio_test_private(folio))
@@ -922,7 +921,7 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
 		folio_attach_private(folio, prealloc);
 	else
 		/* Do new allocation to attach subpage */
-		ret = btrfs_attach_subpage(fs_info, page,
+		ret = btrfs_attach_subpage(fs_info, folio_page(folio, 0),
 					   BTRFS_SUBPAGE_METADATA);
 	return ret;
 }
@@ -939,7 +938,7 @@ int set_page_extent_mapped(struct page *page)
 
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
 
-	if (btrfs_is_subpage(fs_info, page))
+	if (btrfs_is_subpage(fs_info, page->mapping))
 		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
 
 	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
@@ -957,7 +956,7 @@ void clear_page_extent_mapped(struct page *page)
 		return;
 
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
-	if (btrfs_is_subpage(fs_info, page))
+	if (btrfs_is_subpage(fs_info, page->mapping))
 		return btrfs_detach_subpage(fs_info, page);
 
 	folio_detach_private(folio);
@@ -1281,7 +1280,7 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 	 * For regular sector size == page size case, since one page only
 	 * contains one sector, we return the page offset directly.
 	 */
-	if (!btrfs_is_subpage(fs_info, page)) {
+	if (!btrfs_is_subpage(fs_info, page->mapping)) {
 		*start = page_offset(page);
 		*end = page_offset(page) + PAGE_SIZE;
 		return;
@@ -1722,16 +1721,21 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		wbc_account_cgroup_owner(wbc, p, eb->len);
 		unlock_page(p);
 	} else {
-		for (int i = 0; i < num_extent_pages(eb); i++) {
-			struct page *p = folio_page(eb->folios[i], 0);
+		int num_folios = num_extent_folios(eb);
 
-			lock_page(p);
-			clear_page_dirty_for_io(p);
-			set_page_writeback(p);
-			__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
-			wbc_account_cgroup_owner(wbc, p, PAGE_SIZE);
-			wbc->nr_to_write--;
-			unlock_page(p);
+		for (int i = 0; i < num_folios; i++) {
+			struct folio *folio = eb->folios[i];
+			bool ret;
+
+			folio_lock(folio);
+			folio_clear_dirty_for_io(folio);
+			folio_start_writeback(folio);
+			ret = bio_add_folio(&bbio->bio, folio, folio_size(folio), 0);
+			ASSERT(ret);
+			wbc_account_cgroup_owner(wbc, folio_page(folio, 0),
+						 folio_size(folio));
+			wbc->nr_to_write -= folio_nr_pages(folio);
+			folio_unlock(folio);
 		}
 	}
 	btrfs_submit_bio(bbio, 0);
@@ -3088,12 +3092,11 @@ static int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
-static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
+static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
-	lockdep_assert_held(&page->mapping->private_lock);
+	lockdep_assert_held(&folio->mapping->private_lock);
 
 	if (folio_test_private(folio)) {
 		subpage = folio_get_private(folio);
@@ -3109,22 +3112,22 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
 	return false;
 }
 
-static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
+static void detach_extent_buffer_folio(struct extent_buffer *eb,
+				       struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-	struct folio *folio = page_folio(page);
 
 	/*
 	 * For mapped eb, we're going to change the folio private, which should
 	 * be done under the private_lock.
 	 */
 	if (mapped)
-		spin_lock(&page->mapping->private_lock);
+		spin_lock(&folio->mapping->private_lock);
 
 	if (!folio_test_private(folio)) {
 		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
+			spin_unlock(&folio->mapping->private_lock);
 		return;
 	}
 
@@ -3138,13 +3141,13 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 		 */
 		if (folio_test_private(folio) && folio_get_private(folio) == eb) {
 			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-			BUG_ON(PageDirty(page));
-			BUG_ON(PageWriteback(page));
+			BUG_ON(folio_test_dirty(folio));
+			BUG_ON(folio_test_writeback(folio));
 			/* We need to make sure we haven't be attached to a new eb. */
 			folio_detach_private(folio);
 		}
 		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
+			spin_unlock(&folio->mapping->private_lock);
 		return;
 	}
 
@@ -3154,41 +3157,41 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 	 * attached to one dummy eb, no sharing.
 	 */
 	if (!mapped) {
-		btrfs_detach_subpage(fs_info, page);
+		btrfs_detach_subpage(fs_info, folio_page(folio, 0));
 		return;
 	}
 
-	btrfs_page_dec_eb_refs(fs_info, page);
+	btrfs_folio_dec_eb_refs(fs_info, folio);
 
 	/*
 	 * We can only detach the folio private if there are no other ebs in the
 	 * page range and no unfinished IO.
 	 */
-	if (!page_range_has_eb(fs_info, page))
-		btrfs_detach_subpage(fs_info, page);
+	if (!folio_range_has_eb(fs_info, folio))
+		btrfs_detach_subpage(fs_info, folio_page(folio, 0));
 
-	spin_unlock(&page->mapping->private_lock);
+	spin_unlock(&folio->mapping->private_lock);
 }
 
 /* Release all pages attached to the extent buffer */
 static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 {
 	int i;
-	int num_pages;
+	int num_folios;
 
 	ASSERT(!extent_buffer_under_io(eb));
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = folio_page(eb->folios[i], 0);
+	num_folios = num_extent_folios(eb);
+	for (i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
 
-		if (!page)
+		if (!folio)
 			continue;
 
-		detach_extent_buffer_page(eb, page);
+		detach_extent_buffer_folio(eb, folio);
 
-		/* One for when we allocated the page */
-		put_page(page);
+		/* One for when we allocated the folio. */
+		folio_put(folio);
 	}
 }
 
@@ -3228,7 +3231,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
 	struct extent_buffer *new;
-	int num_pages = num_extent_pages(src);
+	int num_folios = num_extent_folios(src);
 	int ret;
 
 	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
@@ -3248,16 +3251,16 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		return NULL;
 	}
 
-	for (i = 0; i < num_pages; i++) {
+	for (i = 0; i < num_folios; i++) {
+		struct folio *folio = new->folios[i];
 		int ret;
-		struct page *p = folio_page(new->folios[i], 0);
 
-		ret = attach_extent_buffer_page(new, p, NULL);
+		ret = attach_extent_buffer_folio(new, folio, NULL);
 		if (ret < 0) {
 			btrfs_release_extent_buffer(new);
 			return NULL;
 		}
-		WARN_ON(PageDirty(p));
+		WARN_ON(folio_test_dirty(folio));
 	}
 	copy_extent_buffer_full(new, src);
 	set_extent_buffer_uptodate(new);
@@ -3269,7 +3272,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len)
 {
 	struct extent_buffer *eb;
-	int num_pages;
+	int num_folios = 0;
 	int i;
 	int ret;
 
@@ -3277,15 +3280,13 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	num_pages = num_extent_pages(eb);
 	ret = alloc_eb_folio_array(eb, 0);
 	if (ret)
 		goto err;
 
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = folio_page(eb->folios[i], 0);
-
-		ret = attach_extent_buffer_page(eb, p, NULL);
+	num_folios = num_extent_folios(eb);
+	for (i = 0; i < num_folios; i++) {
+		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
 		if (ret < 0)
 			goto err;
 	}
@@ -3296,10 +3297,10 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	return eb;
 err:
-	for (i = 0; i < num_pages; i++) {
+	for (i = 0; i < num_folios; i++) {
 		if (eb->folios[i]) {
-			detach_extent_buffer_page(eb, folio_page(eb->folios[i], 0));
-			__free_page(folio_page(eb->folios[i], 0));
+			detach_extent_buffer_folio(eb, eb->folios[i]);
+			__folio_put(eb->folios[i]);
 		}
 	}
 	__free_extent_buffer(eb);
@@ -3348,20 +3349,15 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 	spin_unlock(&eb->refs_lock);
 }
 
-static void mark_extent_buffer_accessed(struct extent_buffer *eb,
-		struct page *accessed)
+static void mark_extent_buffer_accessed(struct extent_buffer *eb)
 {
-	int num_pages, i;
+	int num_folios;
 
 	check_buffer_tree_ref(eb);
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = folio_page(eb->folios[i], 0);
-
-		if (p != accessed)
-			mark_page_accessed(p);
-	}
+	num_folios = num_extent_folios(eb);
+	for (int i = 0; i < num_folios; i++)
+		folio_mark_accessed(eb->folios[i]);
 }
 
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
@@ -3389,7 +3385,7 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 		spin_lock(&eb->refs_lock);
 		spin_unlock(&eb->refs_lock);
 	}
-	mark_extent_buffer_accessed(eb, NULL);
+	mark_extent_buffer_accessed(eb);
 	return eb;
 }
 
@@ -3503,9 +3499,12 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
  * Return 0 if eb->folios[i] is attached to btree inode successfully.
  * Return >0 if there is already annother extent buffer for the range,
  * and @found_eb_ret would be updated.
+ * Return -EAGAIN if the filemap has an existing folio but with different size
+ * than @eb.
+ * The caller needs to free the existing folios and retry using the same order.
  */
-static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
-				     struct extent_buffer **found_eb_ret)
+static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
+				      struct extent_buffer **found_eb_ret)
 {
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -3536,6 +3535,12 @@ static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
 	 */
 	ASSERT(folio_nr_pages(existing_folio) == 1);
 
+	if (folio_size(existing_folio) != folio_size(eb->folios[0])) {
+		folio_unlock(existing_folio);
+		folio_put(existing_folio);
+		return -EAGAIN;
+	}
+
 	if (fs_info->nodesize < PAGE_SIZE) {
 		/*
 		 * We're going to reuse the existing page, can
@@ -3569,7 +3574,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
 	unsigned long len = fs_info->nodesize;
-	int num_pages;
+	int num_folios;
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
@@ -3611,8 +3616,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
 
-	num_pages = num_extent_pages(eb);
-
 	/*
 	 * Preallocate folio private for subpage case, so that we won't
 	 * allocate memory with private_lock nor page lock hold.
@@ -3628,6 +3631,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 	}
 
+reallocate:
 	/* Allocate all pages first. */
 	ret = alloc_eb_folio_array(eb, __GFP_NOFAIL);
 	if (ret < 0) {
@@ -3635,26 +3639,53 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	/* Attach all pages to the filemap. */
-	for (int i = 0; i < num_pages; i++) {
-		struct page *p;
+	num_folios = num_extent_folios(eb);
+	/*
+	 * Attach all pages to the filemap.
+	 */
+	for (int i = 0; i < num_folios; i++) {
+		struct folio *folio;
 
-		ret = attach_eb_page_to_filemap(eb, i, &existing_eb);
+		ret = attach_eb_folio_to_filemap(eb, i, &existing_eb);
 		if (ret > 0) {
 			ASSERT(existing_eb);
 			goto out;
 		}
+
+		/*
+		 * TODO: Special handling for a corner case where the order of
+		 * folios mismatch between the new eb and filemap.
+		 *
+		 * This happens when:
+		 *
+		 * - the new eb is using higher order folio
+		 *
+		 * - the filemap is still using 0-order folios for the range
+		 *   This can happen at the previous eb allocation, and we don't
+		 *   have higher order folio for the call.
+		 *
+		 * - the existing eb has already been freed
+		 *
+		 * In this case, we have to free the existing folios first, and
+		 * re-allocate using the same order.
+		 * Thankfully this is not going to happen yet, as we're still
+		 * using 0-order folios.
+		 */
+		if (unlikely(ret == -EAGAIN)) {
+			ASSERT(0);
+			goto reallocate;
+		}
 		attached++;
 
 		/*
-		 * Only after attach_eb_page_to_filemap(), eb->folios[] is
+		 * Only after attach_eb_folio_to_filemap(), eb->folios[] is
 		 * reliable, as we may choose to reuse the existing page cache
 		 * and free the allocated page.
 		 */
-		p = folio_page(eb->folios[i], 0);
+		folio = eb->folios[i];
 		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
-		ret = attach_extent_buffer_page(eb, p, prealloc);
+		ret = attach_extent_buffer_folio(eb, folio, prealloc);
 		ASSERT(!ret);
 		/*
 		 * To inform we have extra eb under allocation, so that
@@ -3665,19 +3696,23 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * detach_extent_buffer_page().
 		 * Thus needs no special handling in error path.
 		 */
-		btrfs_page_inc_eb_refs(fs_info, p);
+		btrfs_folio_inc_eb_refs(fs_info, folio);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
+		WARN_ON(btrfs_page_test_dirty(fs_info, folio_page(folio, 0),
+					      eb->start, eb->len));
 
 		/*
 		 * Check if the current page is physically contiguous with previous eb
 		 * page.
+		 * At this stage, either we allocated a large folio, thus @i
+		 * would only be 0, or we fall back to per-page allocation.
 		 */
-		if (i && folio_page(eb->folios[i - 1], 0) + 1 != p)
+		if (i && folio_page(eb->folios[i - 1], 0) + 1 != folio_page(folio, 0))
 			page_contig = false;
 
-		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
+		if (!btrfs_page_test_uptodate(fs_info, folio_page(folio, 0),
+					      eb->start, eb->len))
 			uptodate = 0;
 
 		/*
@@ -3719,7 +3754,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (int i = 0; i < num_pages; i++)
+	for (int i = 0; i < num_folios; i++)
 		unlock_page(folio_page(eb->folios[i], 0));
 	return eb;
 
@@ -3727,7 +3762,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
 	for (int i = 0; i < attached; i++) {
 		ASSERT(eb->folios[i]);
-		detach_extent_buffer_page(eb, folio_page(eb->folios[i], 0));
+		detach_extent_buffer_folio(eb, eb->folios[i]);
 		unlock_page(folio_page(eb->folios[i], 0));
 	}
 	/*
@@ -3832,31 +3867,31 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
-static void btree_clear_page_dirty(struct page *page)
+static void btree_clear_folio_dirty(struct folio *folio)
 {
-	ASSERT(PageDirty(page));
-	ASSERT(PageLocked(page));
-	clear_page_dirty_for_io(page);
-	xa_lock_irq(&page->mapping->i_pages);
-	if (!PageDirty(page))
-		__xa_clear_mark(&page->mapping->i_pages,
-				page_index(page), PAGECACHE_TAG_DIRTY);
-	xa_unlock_irq(&page->mapping->i_pages);
+	ASSERT(folio_test_dirty(folio));
+	ASSERT(folio_test_locked(folio));
+	folio_clear_dirty_for_io(folio);
+	xa_lock_irq(&folio->mapping->i_pages);
+	if (!folio_test_dirty(folio))
+		__xa_clear_mark(&folio->mapping->i_pages,
+				folio_index(folio), PAGECACHE_TAG_DIRTY);
+	xa_unlock_irq(&folio->mapping->i_pages);
 }
 
 static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page = folio_page(eb->folios[0], 0);
+	struct folio *folio = eb->folios[0];
 	bool last;
 
-	/* btree_clear_page_dirty() needs page locked */
-	lock_page(page);
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, eb->start,
-						  eb->len);
+	/* btree_clear_folio_dirty() needs page locked */
+	folio_lock(folio);
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio_page(folio, 0),
+			eb->start, eb->len);
 	if (last)
-		btree_clear_page_dirty(page);
-	unlock_page(page);
+		btree_clear_folio_dirty(folio);
+	folio_unlock(folio);
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
 
@@ -3865,8 +3900,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i;
-	int num_pages;
-	struct page *page;
+	int num_folios;
 
 	btrfs_assert_tree_write_locked(eb);
 
@@ -3896,15 +3930,15 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (eb->fs_info->nodesize < PAGE_SIZE)
 		return clear_subpage_extent_buffer_dirty(eb);
 
-	num_pages = num_extent_pages(eb);
+	num_folios = num_extent_folios(eb);
+	for (i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
 
-	for (i = 0; i < num_pages; i++) {
-		page = folio_page(eb->folios[i], 0);
-		if (!PageDirty(page))
+		if (!folio_test_dirty(folio))
 			continue;
-		lock_page(page);
-		btree_clear_page_dirty(page);
-		unlock_page(page);
+		folio_lock(folio);
+		btree_clear_folio_dirty(folio);
+		folio_unlock(folio);
 	}
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
@@ -3912,14 +3946,14 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 void set_extent_buffer_dirty(struct extent_buffer *eb)
 {
 	int i;
-	int num_pages;
+	int num_folios;
 	bool was_dirty;
 
 	check_buffer_tree_ref(eb);
 
 	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
 
-	num_pages = num_extent_pages(eb);
+	num_folios = num_extent_folios(eb);
 	WARN_ON(atomic_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 
@@ -3939,7 +3973,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		 */
 		if (subpage)
 			lock_page(folio_page(eb->folios[0], 0));
-		for (i = 0; i < num_pages; i++)
+		for (i = 0; i < num_folios; i++)
 			btrfs_page_set_dirty(eb->fs_info, folio_page(eb->folios[i], 0),
 					     eb->start, eb->len);
 		if (subpage)
@@ -3949,23 +3983,23 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 					 eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
-	for (i = 0; i < num_pages; i++)
-		ASSERT(PageDirty(folio_page(eb->folios[i], 0)));
+	for (i = 0; i < num_folios; i++)
+		ASSERT(folio_test_dirty(eb->folios[i]));
 #endif
 }
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page;
-	int num_pages;
+	int num_folios;
 	int i;
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		page = folio_page(eb->folios[i], 0);
-		if (!page)
+	num_folios = num_extent_folios(eb);
+	for (i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
+
+		if (!folio)
 			continue;
 
 		/*
@@ -3973,34 +4007,33 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
 		 */
 		if (fs_info->nodesize >= PAGE_SIZE)
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 		else
-			btrfs_subpage_clear_uptodate(fs_info, page, eb->start,
-						     eb->len);
+			btrfs_subpage_clear_uptodate(fs_info, folio_page(folio, 0),
+						     eb->start, eb->len);
 	}
 }
 
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct page *page;
-	int num_pages;
+	int num_folios;
 	int i;
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		page = folio_page(eb->folios[i], 0);
+	num_folios = num_extent_folios(eb);
+	for (i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
 
 		/*
 		 * This is special handling for metadata subpage, as regular
 		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
 		 */
 		if (fs_info->nodesize >= PAGE_SIZE)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 		else
-			btrfs_subpage_set_uptodate(fs_info, page, eb->start,
-						   eb->len);
+			btrfs_subpage_set_uptodate(fs_info, folio_page(folio, 0),
+						   eb->start, eb->len);
 	}
 }
 
@@ -4050,8 +4083,8 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			     struct btrfs_tree_parent_check *check)
 {
-	int num_pages = num_extent_pages(eb), i;
 	struct btrfs_bio *bbio;
+	bool ret;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -4081,12 +4114,18 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
 	if (eb->fs_info->nodesize < PAGE_SIZE) {
-		__bio_add_page(&bbio->bio, folio_page(eb->folios[0], 0), eb->len,
-			       eb->start - folio_pos(eb->folios[0]));
+		ret = bio_add_folio(&bbio->bio, eb->folios[0], eb->len,
+				    eb->start - folio_pos(eb->folios[0]));
+		ASSERT(ret);
 	} else {
-		for (i = 0; i < num_pages; i++)
-			__bio_add_page(&bbio->bio, folio_page(eb->folios[i], 0),
-				       PAGE_SIZE, 0);
+		int num_folios = num_extent_folios(eb);
+
+		for (int i = 0; i < num_folios; i++) {
+			struct folio *folio = eb->folios[i];
+
+			ret = bio_add_folio(&bbio->bio, folio, folio_size(folio), 0);
+			ASSERT(ret);
+		}
 	}
 	btrfs_submit_bio(bbio, mirror_num);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 66c2e214b141..a5fd5cb20a3c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -243,6 +243,20 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
 	return (eb->len >> PAGE_SHIFT) ?: 1;
 }
 
+/*
+ * This can only be determined at runtime by checking eb::folios[0].
+ *
+ * As we can have either one large folio covering the whole eb
+ * (either nodesize <= PAGE_SIZE, or high order folio), or multiple
+ * single-paged folios.
+ */
+static inline int num_extent_folios(const struct extent_buffer *eb)
+{
+	if (folio_order(eb->folios[0]))
+		return 1;
+	return num_extent_pages(eb);
+}
+
 static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
 {
 	return test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f7c0a5ec675f..9ede6aa77fde 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7863,7 +7863,7 @@ static void wait_subpage_spinlock(struct page *page)
 	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, page->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index caf0013f2545..7fd7671be458 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -64,7 +64,8 @@
  *   This means a slightly higher tree locking latency.
  */
 
-bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct page *page)
+bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+		      struct address_space *mapping)
 {
 	if (fs_info->sectorsize >= PAGE_SIZE)
 		return false;
@@ -74,8 +75,7 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct page *page)
 	 * mapping. And if page->mapping->host is data inode, it's subpage.
 	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
 	 */
-	if (!page->mapping || !page->mapping->host ||
-	    is_data_inode(page->mapping->host))
+	if (!mapping || !mapping->host || is_data_inode(mapping->host))
 		return true;
 
 	/*
@@ -129,7 +129,8 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		ASSERT(PageLocked(page));
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, page) || folio_test_private(folio))
+	if (!btrfs_is_subpage(fs_info, page->mapping) ||
+	    folio_test_private(folio))
 		return 0;
 
 	subpage = btrfs_alloc_subpage(fs_info, type);
@@ -147,7 +148,8 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage;
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, page) || !folio_test_private(folio))
+	if (!btrfs_is_subpage(fs_info, page->mapping) ||
+	    !folio_test_private(folio))
 		return;
 
 	subpage = folio_detach_private(folio);
@@ -193,33 +195,31 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage)
  * detach_extent_buffer_page() won't detach the folio private while we're still
  * allocating the extent buffer.
  */
-void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
-			    struct page *page)
+void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info,
+			     struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
-	ASSERT(folio_test_private(folio) && page->mapping);
-	lockdep_assert_held(&page->mapping->private_lock);
+	ASSERT(folio_test_private(folio) && folio->mapping);
+	lockdep_assert_held(&folio->mapping->private_lock);
 
 	subpage = folio_get_private(folio);
 	atomic_inc(&subpage->eb_refs);
 }
 
-void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
-			    struct page *page)
+void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info,
+			     struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
-	ASSERT(folio_test_private(folio) && page->mapping);
-	lockdep_assert_held(&page->mapping->private_lock);
+	ASSERT(folio_test_private(folio) && folio->mapping);
+	lockdep_assert_held(&folio->mapping->private_lock);
 
 	subpage = folio_get_private(folio);
 	ASSERT(atomic_read(&subpage->eb_refs));
@@ -352,7 +352,7 @@ int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
 {
 	struct folio *folio = page_folio(page);
 
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page->mapping)) {
 		lock_page(page);
 		return 0;
 	}
@@ -369,7 +369,7 @@ int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
 void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len)
 {
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page->mapping))
 		return unlock_page(page);
 	btrfs_subpage_clamp_range(page, &start, &len);
 	if (btrfs_subpage_end_and_test_writer(fs_info, page, start, len))
@@ -612,7 +612,8 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
 void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
 		set_page_func(page);					\
 		return;							\
 	}								\
@@ -621,7 +622,8 @@ void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
 void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
 		clear_page_func(page);					\
 		return;							\
 	}								\
@@ -630,14 +632,16 @@ void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
 bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping))			\
 		return test_page_func(page);				\
 	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
 }									\
 void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping)) {	\
 		set_page_func(page);					\
 		return;							\
 	}								\
@@ -647,7 +651,8 @@ void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
 		clear_page_func(page);					\
 		return;							\
 	}								\
@@ -657,7 +662,8 @@ void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
+	if (unlikely(!fs_info) ||					\
+	    !btrfs_is_subpage(fs_info, page->mapping)) \
 		return test_page_func(page);				\
 	btrfs_subpage_clamp_range(page, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
@@ -686,7 +692,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 		return;
 
 	ASSERT(!PageDirty(page));
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, page->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -716,7 +722,7 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
 
 	ASSERT(PageLocked(page));
 	/* For non-subpage case, we just unlock the page */
-	if (!btrfs_is_subpage(fs_info, page))
+	if (!btrfs_is_subpage(fs_info, page->mapping))
 		return unlock_page(page);
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 5cbf67ccbdeb..93d1c5690faf 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -73,7 +73,8 @@ enum btrfs_subpage_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
-bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct page *page);
+bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+		      struct address_space *mapping);
 
 void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
@@ -86,10 +87,10 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 					  enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
 
-void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
-			    struct page *page);
-void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
-			    struct page *page);
+void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info,
+			     struct folio *folio);
+void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info,
+			     struct folio *folio);
 
 void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len);
-- 
2.43.0


