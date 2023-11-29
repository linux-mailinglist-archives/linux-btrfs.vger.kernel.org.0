Return-Path: <linux-btrfs+bounces-445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB97FE331
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 23:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA29B211B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301947A5F;
	Wed, 29 Nov 2023 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FjzhAzry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAC93
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 14:32:30 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D347F219BF
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701297148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mCPM52joZOmBrlOVVwwOJZizJW+I2wtU+jbiKKm3nKs=;
	b=FjzhAzrynKLQwQU8w3NKlNXq9pUFf5LvgCsjfDuTLTxzj+Y14njkQSCMgEk/Yhd3VoI9EW
	aQS8t4CLa04vVKiNNAX9NnurUBUODvPTrsuSMq52d8YR5TyBkHIJ5xFjfhxPnLTP+C0xoY
	1nhlFX+J2XQqXVt/2R9PxGJE5NEKqr4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B8D211336F
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 22:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cqZcF/u7Z2XtKwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 22:32:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4] btrfs: refactor alloc_extent_buffer() to allocate-then-attach method
Date: Thu, 30 Nov 2023 09:02:08 +1030
Message-ID: <cf7b0e83150d2c91bb4234fcf3552e86a8bd1a92.1701297048.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 15.46
X-Spamd-Result: default: False [15.46 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_SPAM_LONG(2.47)[0.705];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_SHORT(2.99)[0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam: Yes

Currently alloc_extent_buffer() utilizes find_or_create_page() to
allocate one page a time for an extent buffer.

This method has the following disadvantages:

- find_or_create_page() is the legacy way of allocating new pages
  With the new folio infrastructure, find_or_create_page() is just
  redirected to filemap_get_folio().

- Lacks the way to support higher order (order >= 1) folios
  As we can not yet let filemap to give us a higher order folio (yet).

This patch would change the workflow by the following way:

		Old		   |		new
-----------------------------------+-------------------------------------
                                   | ret = btrfs_alloc_page_array();
for (i = 0; i < num_pages; i++) {  | for (i = 0; i < num_pages; i++) {
    p = find_or_create_page();     |     ret = filemap_add_folio();
    /* Attach page private */      |     /* Reuse page cache if needed */
    /* Reused eb if needed */      |
				   |     /* Attach page private and
				   |        reuse eb if needed */
				   | }

By this we split the page allocation and private attaching into two
parts, allowing future updates to each part more easily, and migrate to
folio interfaces (especially for possible higher order folios).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use the old "GFP_NOFS | __GFP_NOFAIL" flag for metadata page
  allocation

v3:
- Fix a missing "attached++" line
  Which affects the error handling path.

v4:
- Remove the internal helper alloc_page_array()
  The naming is too generic and can be confused with public mm
  functions.
  Just append an @extra_gfp parameter for btrfs_alloc_page_array()

- Detach the attached page before error out
  Previously we rely btrfs_release_extent_buffer() to handle
  half-attached ebs, this makes the detach_extent_buffer_page() more
  complex.
  Here we detach all the half attached pages first, then set
  EXTENT_BUFFER_UNMAPPED flag for the eb, so we won't need to bother
  those half attached extent buffers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/extent_io.c   | 161 +++++++++++++++++++++++++++++++----------
 fs/btrfs/extent_io.h   |   3 +-
 fs/btrfs/inode.c       |   2 +-
 fs/btrfs/raid56.c      |   6 +-
 fs/btrfs/scrub.c       |   2 +-
 6 files changed, 129 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 05595d113ff8..f939a640db2b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -608,7 +608,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		goto out_free_bio;
 	}
 
-	ret2 = btrfs_alloc_page_array(cb->nr_pages, cb->compressed_pages);
+	ret2 = btrfs_alloc_page_array(cb->nr_pages, cb->compressed_pages, 0);
 	if (ret2) {
 		ret = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0143bf63044c..734016eac82f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -674,19 +674,22 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
  * @nr_pages:   number of pages to allocate
  * @page_array: the array to fill with pages; any existing non-null entries in
  * 		the array will be skipped
+ * @extra_gfp:	the extra gfp flags for the allocation.
  *
  * Return: 0        if all pages were able to be allocated;
  *         -ENOMEM  otherwise, the partially allocated pages would be freed and
  *                  the array slots zeroed
  */
-int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
+int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
+			   gfp_t extra_gfp)
 {
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
 		unsigned int last = allocated;
 
-		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
+		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
+						   nr_pages, page_array);
 
 		if (allocated == nr_pages)
 			return 0;
@@ -3219,7 +3222,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = btrfs_alloc_page_array(num_pages, new->pages);
+	ret = btrfs_alloc_page_array(num_pages, new->pages, 0);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -3255,7 +3258,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 		return NULL;
 
 	num_pages = num_extent_pages(eb);
-	ret = btrfs_alloc_page_array(num_pages, eb->pages);
+	ret = btrfs_alloc_page_array(num_pages, eb->pages, 0);
 	if (ret)
 		goto err;
 
@@ -3475,16 +3478,81 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	return 0;
 }
 
+
+/*
+ * Return 0 if eb->pages[i] is attached to btree inode successfully.
+ * Return >0 if there is already annother extent buffer for the range,
+ * and @found_eb_ret would be updated.
+ */
+static int attach_eb_page_to_filemap(struct extent_buffer *eb, int i,
+				     struct extent_buffer **found_eb_ret)
+{
+
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	const unsigned long index = eb->start >> PAGE_SHIFT;
+	struct folio *existing_folio;
+	int ret;
+
+	ASSERT(found_eb_ret);
+
+	/* Caller should ensure the page exists. */
+	ASSERT(eb->pages[i]);
+
+retry:
+	ret = filemap_add_folio(mapping, page_folio(eb->pages[i]), index + i,
+			GFP_NOFS | __GFP_NOFAIL);
+	if (!ret)
+		return 0;
+
+	existing_folio = filemap_lock_folio(mapping, index + i);
+	/* The page cache only exists for a very short time, just retry. */
+	if (IS_ERR(existing_folio))
+		goto retry;
+
+	/*
+	 * For now, we should only have single-page folios for btree
+	 * inode.
+	 */
+	ASSERT(folio_nr_pages(existing_folio) == 1);
+
+	if (fs_info->nodesize < PAGE_SIZE) {
+		/*
+		 * We're going to reuse the existing page, can
+		 * drop our page and subpage structure now.
+		 */
+		__free_page(eb->pages[i]);
+		eb->pages[i] = folio_page(existing_folio, 0);
+	} else {
+		struct extent_buffer *existing_eb;
+
+		existing_eb = grab_extent_buffer(fs_info,
+					folio_page(existing_folio, 0));
+		if (existing_eb) {
+			/*
+			 * The extent buffer still exists, we can use
+			 * it directly.
+			 */
+			*found_eb_ret = existing_eb;
+			folio_unlock(existing_folio);
+			folio_put(existing_folio);
+			return 1;
+		}
+		/* The extent buffer no longer exists, we can reuse the folio. */
+		__free_page(eb->pages[i]);
+		eb->pages[i] = folio_page(existing_folio, 0);
+	}
+	return 0;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
 	unsigned long len = fs_info->nodesize;
 	int num_pages;
-	int i;
-	unsigned long index = start >> PAGE_SHIFT;
+	int attached = 0;
 	struct extent_buffer *eb;
-	struct extent_buffer *exists = NULL;
-	struct page *p;
+	struct extent_buffer *existing_eb = NULL;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
@@ -3535,29 +3603,36 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (fs_info->nodesize < PAGE_SIZE) {
 		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
 		if (IS_ERR(prealloc)) {
-			exists = ERR_CAST(prealloc);
-			goto free_eb;
+			ret = PTR_ERR(prealloc);
+			goto out;
 		}
 	}
 
-	for (i = 0; i < num_pages; i++, index++) {
-		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
-		if (!p) {
-			exists = ERR_PTR(-ENOMEM);
-			btrfs_free_subpage(prealloc);
-			goto free_eb;
-		}
+	/* Allocate all pages first. */
+	ret = btrfs_alloc_page_array(num_pages, eb->pages, __GFP_NOFAIL);
+	if (ret < 0) {
+		btrfs_free_subpage(prealloc);
+		goto out;
+	}
 
-		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer(fs_info, p);
-		if (exists) {
-			spin_unlock(&mapping->private_lock);
-			unlock_page(p);
-			put_page(p);
-			mark_extent_buffer_accessed(exists, p);
-			btrfs_free_subpage(prealloc);
-			goto free_eb;
+	/* Attach all pages to the filemap. */
+	for (int i = 0; i < num_pages; i++) {
+		struct page *p;
+
+		ret = attach_eb_page_to_filemap(eb, i, &existing_eb);
+		if (ret > 0) {
+			ASSERT(existing_eb);
+			goto out;
 		}
+		attached++;
+
+		/*
+		 * Only after attach_eb_page_to_filemap(), eb->pages[] is
+		 * reliable, as we may choose to reuse the existing page cache
+		 * and free the allocated page.
+		 */
+		p = eb->pages[i];
+		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_page(eb, p, prealloc);
 		ASSERT(!ret);
@@ -3574,7 +3649,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		spin_unlock(&mapping->private_lock);
 
 		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
-		eb->pages[i] = p;
 
 		/*
 		 * Check if the current page is physically contiguous with previous eb
@@ -3601,10 +3675,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		eb->addr = page_address(eb->pages[0]) + offset_in_page(eb->start);
 again:
 	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		exists = ERR_PTR(ret);
-		goto free_eb;
-	}
+	if (ret)
+		goto out;
 
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
@@ -3612,9 +3684,9 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
-		exists = find_extent_buffer(fs_info, start);
-		if (exists)
-			goto free_eb;
+		existing_eb = find_extent_buffer(fs_info, start);
+		if (existing_eb)
+			goto out;
 		else
 			goto again;
 	}
@@ -3627,19 +3699,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (i = 0; i < num_pages; i++)
+	for (int i = 0; i < num_pages; i++)
 		unlock_page(eb->pages[i]);
 	return eb;
 
-free_eb:
+out:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
-	for (i = 0; i < num_pages; i++) {
-		if (eb->pages[i])
-			unlock_page(eb->pages[i]);
+	for (int i = 0; i < attached; i++) {
+		ASSERT(eb->pages[i]);
+		detach_extent_buffer_page(eb, eb->pages[i]);
+		unlock_page(eb->pages[i]);
 	}
+	/*
+	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
+	 * so it can be cleaned up without utlizing page->mapping.
+	 */
+	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	btrfs_release_extent_buffer(eb);
-	return exists;
+	if (ret < 0)
+		return ERR_PTR(ret);
+	ASSERT(existing_eb);
+	return existing_eb;
 }
 
 static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c2c6bfba63c0..c73d53c22ec5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -302,7 +302,8 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *buf);
 
-int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
+int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
+			   gfp_t extra_gfp);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 096b3004a19f..f7c0a5ec675f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10009,7 +10009,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 	if (!pages)
 		return -ENOMEM;
-	ret = btrfs_alloc_page_array(nr_pages, pages);
+	ret = btrfs_alloc_page_array(nr_pages, pages, 0);
 	if (ret) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 90f12c0e88a1..792c8e17c31d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -964,7 +964,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	int ret;
 
-	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages);
+	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, 0);
 	if (ret < 0)
 		return ret;
 	/* Mapping all sectors */
@@ -979,7 +979,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	int ret;
 
 	ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
-				     rbio->stripe_pages + data_pages);
+				     rbio->stripe_pages + data_pages, 0);
 	if (ret < 0)
 		return ret;
 
@@ -1530,7 +1530,7 @@ static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 	const int data_pages = rbio->nr_data * rbio->stripe_npages;
 	int ret;
 
-	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
+	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages, 0);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 061d54148568..9ab16e3f87d1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 	atomic_set(&stripe->pending_io, 0);
 	spin_lock_init(&stripe->write_error_lock);
 
-	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages);
+	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages, 0);
 	if (ret < 0)
 		goto error;
 
-- 
2.43.0


