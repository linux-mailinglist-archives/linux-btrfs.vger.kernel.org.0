Return-Path: <linux-btrfs+bounces-6053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34891D073
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2024 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BA8B210EC
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2024 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933803D575;
	Sun, 30 Jun 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G0W/cVRw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G0W/cVRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D98F72
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719734244; cv=none; b=VTDueqfr19Pnugy4cwORzNMt9cpSyKzbd5djmy8HodDe1dG7bomY4OfSKJ1GbDr3zlUbxgwPxeNZcyLBj+NONBdkSGhNZPDU+JnGQH1zb+lp0BP1LfOf0rFd2iiUyP/QYQJt3VP0Khu0FB+8AV8uy2fUijJuKaOKpUWWd5X0Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719734244; c=relaxed/simple;
	bh=HnKVVi0Co03GRcarJfA5WotiEo5YQn5W2xYOezV48Qs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQlgAFlp4EYjMrQUKV1KOsZ3t7vQSFebM7fRBJNTC5xhUhG6am0cwVc2aDao5W6/zTWncEBS+ftNSX0e+C4lTSWmAkGtucYFtkfyDCCcx0A/Wq6XH+IhP16+vVSP6JFaGhmerMU8XLb8WKUqg7XkI1EsXlvh8ijqDYxwTpPMYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G0W/cVRw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G0W/cVRw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3490219F4
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2024 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719734238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wRj0060d5rRR6LhS+2xUnoDA9lkLJE8HW+dbHz2hbOs=;
	b=G0W/cVRw0/ASMO9w/R/wPHH7wLBx1fKXwyeSdKr3E0fbnQ09rM6pMVf+yiBqkBGoIFrDvJ
	0mCOHIymwOGAGQqfXTBgxlB5zd+rc/k71kKAbNPM6IEJ8AUZ8zkp0FJBVPvXvOqxsu3APn
	YF9TVbhElBIvQbE8QgWTHsiNklKp+mM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719734238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wRj0060d5rRR6LhS+2xUnoDA9lkLJE8HW+dbHz2hbOs=;
	b=G0W/cVRw0/ASMO9w/R/wPHH7wLBx1fKXwyeSdKr3E0fbnQ09rM6pMVf+yiBqkBGoIFrDvJ
	0mCOHIymwOGAGQqfXTBgxlB5zd+rc/k71kKAbNPM6IEJ8AUZ8zkp0FJBVPvXvOqxsu3APn
	YF9TVbhElBIvQbE8QgWTHsiNklKp+mM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF5D13A7F
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2024 07:57:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tN5uJd0PgWbuNAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2024 07:57:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: prefer to allocate larger folio for metadata
Date: Sun, 30 Jun 2024 17:26:59 +0930
Message-ID: <96e9e2c1ac180a3b6c8c29a06c4a618c8d4dc2d9.1719734174.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
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
X-Spam-Level: 

For btrfs metadata, the high order folios are only utilized when all the
following conditions are met:

- The extent buffer start is aligned to nodesize
  This should be the common case for any btrfs in the last 5 years.

- The nodesize is larger than page size
  Or there is no need to use larger folios at all.

- MM layer can fulfill our folio allocation request

- The larger folio must exactly cover the extent buffer
  No longer no smaller, must be an exact fit.

  This is to make extent buffer accessors much easier.
  They only need to check the first slot in eb->folios[], to determine
  their access unit (need per-page handling or a large folio covering
  the whole eb).

There is another small blockage, filemap APIs can not guarantee the
folio size.
For example, by default we go 16K nodesize on x86_64, meaning a larger
folio we expect would be with order 2 (size 16K).
We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order 0
(page sized) folios.

So here we go a different workaround, allocate a order 2 folio first,
then attach them to the filemap of metadata.

Thus here comes several results related to the attach attempt of eb
folios:

1) We can attach the pre-allocated eb folio to filemap
   This is the most simple and hot path, we just continue our work
   setting up the extent buffer.

2) There is an existing folio in the filemap

   2.0) Subpage case
        We would reuse the folio no matter what, subpage is doing a
	different way handling folio->private (a bitmap other than a
	pointer to an existing eb).

   2.1) There is already a live extent buffer attached to the filemap
        folio
	This should be more or less hot path, we grab the existing eb
	and free the current one.

   2.2) No live eb.
   2.2.1) The filemap folio is larger than eb folio
          This is a better case, we can reuse the filemap folio, but
	  we need to cleanup all the pre-allocated folios of the
	  new eb before reusing.
	  Later code should take the folio size change into
	  consideration.

   2.2.2) The filemap folio is the same size of eb folio
          We just free the current folio, and reuse the filemap one.
	  No other special handling needed.

   2.2.3) The filemap folio is smaller than eb folio
          This is the most tricky corner case, we can not easily replace
	  the folio in filemap using our eb folio.

	  Thus here we return -EAGAIN, to inform our caller to re-try
	  with order 0 (of course with our larger folio freed).

Otherwise all the needed infrastructure is already here, we only need to
try allocate larger folio as our first try in alloc_eb_folio_array().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Rebased to the latest for-next branch
- Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
- Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
  and high order allocation"
  This allows us to use NOFAIL up to 32K nodesize, and makes sure for
  default 16K nodesize, all metadata would go 16K folios

v2:
- Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"
---
 fs/btrfs/extent_io.c | 106 +++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3ce07ab9692..f849b890684f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -734,12 +734,33 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
  *
  * For now, the folios populated are always in order 0 (aka, single page).
  */
-static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
+static int alloc_eb_folio_array(struct extent_buffer *eb, int order,
+				bool nofail)
 {
 	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
 	int num_pages = num_extent_pages(eb);
 	int ret;
 
+	if (order) {
+		gfp_t gfp;
+
+		/*
+		 * For costly allocation, we want no retry nor warning.
+		 * Otherwise we can just set the NOFAIL flag and let mm layer
+		 * to do the heavylifting.
+		 */
+		if (order > PAGE_ALLOC_COSTLY_ORDER)
+			gfp = GFP_NOFS | __GFP_NORETRY | __GFP_NOWARN;
+		else
+			gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
+		eb->folios[0] = folio_alloc(gfp, order);
+		if (likely(eb->folios[0])) {
+			eb->folio_size = folio_size(eb->folios[0]);
+			eb->folio_shift = folio_shift(eb->folios[0]);
+			return 0;
+		}
+		/* Fallback to 0 order (single page) allocation. */
+	}
 	ret = btrfs_alloc_page_array(num_pages, page_array, nofail);
 	if (ret < 0)
 		return ret;
@@ -2722,7 +2743,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, false);
+	ret = alloc_eb_folio_array(new, 0, false);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -2755,7 +2776,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, false);
+	ret = alloc_eb_folio_array(eb, 0, false);
 	if (ret)
 		goto err;
 
@@ -2970,6 +2991,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	return 0;
 }
 
+static void free_all_eb_folios(struct extent_buffer *eb)
+{
+	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
+		if (eb->folios[i])
+			folio_put(eb->folios[i]);
+		eb->folios[i] = NULL;
+	}
+}
 
 /*
  * Return 0 if eb->folios[i] is attached to btree inode successfully.
@@ -2988,6 +3017,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	const int eb_order = folio_order(eb->folios[0]);
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -3008,15 +3038,6 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		goto retry;
 	}
 
-	/* For now, we should only have single-page folios for btree inode. */
-	ASSERT(folio_nr_pages(existing_folio) == 1);
-
-	if (folio_size(existing_folio) != eb->folio_size) {
-		folio_unlock(existing_folio);
-		folio_put(existing_folio);
-		return -EAGAIN;
-	}
-
 finish:
 	spin_lock(&mapping->i_private_lock);
 	if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
@@ -3025,6 +3046,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		eb->folios[i] = existing_folio;
 	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
+		int existing_order = folio_order(existing_folio);
 
 		existing_eb = grab_extent_buffer(fs_info,
 						 folio_page(existing_folio, 0));
@@ -3036,9 +3058,34 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 			folio_put(existing_folio);
 			return 1;
 		}
-		/* The extent buffer no longer exists, we can reuse the folio. */
-		__free_page(folio_page(eb->folios[i], 0));
-		eb->folios[i] = existing_folio;
+		if (existing_order > eb_order) {
+			/*
+			 * The existing one has higher order, we need to drop
+			 * all eb folios before resuing it.
+			 * And this should only happen for the first folio.
+			 */
+			ASSERT(i == 0);
+			free_all_eb_folios(eb);
+			eb->folios[i] = existing_folio;
+		} else if (existing_order == eb_order) {
+			/*
+			 * Can safely reuse the filemap folio, just
+			 * release the eb one.
+			 */
+			folio_put(eb->folios[i]);
+			eb->folios[i] = existing_folio;
+		} else {
+			/*
+			 * The existing one has lower order.
+			 *
+			 * Just retry and fallback to order 0.
+			 */
+			ASSERT(i == 0);
+			folio_unlock(existing_folio);
+			folio_put(existing_folio);
+			spin_unlock(&mapping->i_private_lock);
+			return -EAGAIN;
+		}
 	}
 	eb->folio_size = folio_size(eb->folios[i]);
 	eb->folio_shift = folio_shift(eb->folios[i]);
@@ -3071,6 +3118,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
 	int uptodate = 1;
+	int order = 0;
 	int ret;
 
 	if (check_eb_alignment(fs_info, start))
@@ -3087,6 +3135,9 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
+	if (fs_info->nodesize > PAGE_SIZE && IS_ALIGNED(start, fs_info->nodesize))
+		order = ilog2(fs_info->nodesize >> PAGE_SHIFT);
+
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -3121,7 +3172,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, true);
+	ret = alloc_eb_folio_array(eb, order, true);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3139,26 +3190,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		/*
-		 * TODO: Special handling for a corner case where the order of
-		 * folios mismatch between the new eb and filemap.
-		 *
-		 * This happens when:
-		 *
-		 * - the new eb is using higher order folio
-		 *
-		 * - the filemap is still using 0-order folios for the range
-		 *   This can happen at the previous eb allocation, and we don't
-		 *   have higher order folio for the call.
-		 *
-		 * - the existing eb has already been freed
-		 *
-		 * In this case, we have to free the existing folios first, and
-		 * re-allocate using the same order.
-		 * Thankfully this is not going to happen yet, as we're still
-		 * using 0-order folios.
+		 * Got a corner case where the existing folio is lower order,
+		 * fallback to 0 order and retry.
 		 */
 		if (unlikely(ret == -EAGAIN)) {
-			ASSERT(0);
+			order = 0;
+			free_all_eb_folios(eb);
 			goto reallocate;
 		}
 		attached++;
@@ -3169,6 +3206,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
+		num_folios = num_extent_folios(eb);
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
-- 
2.45.2


