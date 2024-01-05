Return-Path: <linux-btrfs+bounces-1265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC6824E50
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4691728621A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1F566F;
	Fri,  5 Jan 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GQ2MkCqD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WX6PsU7J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277241DDCA
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8BD11F890
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704434246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8/26tn8OEpodpfI01+Mkd8VPztxnzVF37bt3XRmrtwc=;
	b=GQ2MkCqDcppJNB7QaQte1tTjdMNRitY6x28c5cuCG7HP6OwFH6iTlG3qq01nRZ/mFr/GxP
	eoPeZLoZGCvcdjb5GeBW8ZMJXlYLeRFY75jK2QbRK9nkvd6h7wQEHSsmmuFlDBTjgh+uLP
	/ksChS1oI5joYnMEozBMeHsT2v6CMwA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704434245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8/26tn8OEpodpfI01+Mkd8VPztxnzVF37bt3XRmrtwc=;
	b=WX6PsU7JJczU1xV7NWovWPdQdbMoOXFSQPfEVwDpQQkmf7hXrJuK7nMf/uNr6+aTHuYKt8
	xDPXiR5crko2fj4FrAvYPB8W8zEughhaX88C5sU5n955Yn4g7hYzQ6teAFXw1IZxkpGUu3
	SJUlqpRVecYvUVpjdiderd7uG+SWINg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5D5313C99
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /pNAEESal2XgGAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 05:57:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: prefer to allocate larger folio for metadata
Date: Fri,  5 Jan 2024 16:27:01 +1030
Message-ID: <b2a33b0d75b29a0945b58342d021b24cf157114c.1704434178.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: D8BD11F890
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WX6PsU7J
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

With all the migration (including the previous ones which are only
detected through this patch), we can finally enable larger folio support
for metadata.

For btrfs metadata, the high order folios are only utilized in the
following way:

- The extent buffer start is aligned to nodesize
  This should be the common case for any btrfs in the last 5 years.

- The nodesize is larger than page size
  Or there is no need to use larger folios at all.

- MM layer can fulfill our request without retry
  If we're going to retry, it's better just falling back to per-page
  allocation.
  This would also help us to expose some corner cases mentioned below.

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
We don't accept 2 order 1 (size 8K) folios, but accept 4 order 0 (size
4K) folios.

So here we go a different workaround, allocate a order 2 folio first,
then attach them to the filemap of metadata.

Thus here comes several cases, all would be addressed inside
attach_eb_folio_to_filemap():

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
 fs/btrfs/extent_io.c | 152 ++++++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 45 deletions(-)
---
Changelog:
v2:
- Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6ee63ff61e4a..635d3ae32d08 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -726,12 +726,32 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
  *
  * For now, the folios populated are always in order 0 (aka, single page).
  */
-static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp)
+static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp,
+				int order)
 {
 	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
 	int num_pages = num_extent_pages(eb);
 	int ret;
 
+	if (order) {
+		/*
+		 * For higher order folio allocation, we discard the extra_gfp
+		 * (should only be __GFP_NOFAIL, and conflicts with higher order
+		 * folio).
+		 *
+		 * Instead we want no warning when allocation failed, and no
+		 * extra retry (to get a faster allocation).
+		 * As we're completely fine to fall back to lower order.
+		 */
+		eb->folios[0] = folio_alloc(GFP_NOFS | __GFP_NOWARN |
+					    __GFP_NORETRY, order);
+		if (eb->folios[0]) {
+			eb->folio_size = folio_size(eb->folios[0]);
+			eb->folio_shift = folio_shift(eb->folios[0]);
+			return 0;
+		}
+		/* Fallback to 0 order (single page) folios. */
+	}
 	ret = btrfs_alloc_page_array(num_pages, page_array, extra_gfp);
 	if (ret < 0)
 		return ret;
@@ -3251,7 +3271,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, 0);
+	ret = alloc_eb_folio_array(new, 0, folio_order(src->folios[0]));
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -3285,7 +3305,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, 0);
+	ret = alloc_eb_folio_array(eb, 0, 0);
 	if (ret)
 		goto err;
 
@@ -3498,6 +3518,18 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	return 0;
 }
 
+/*
+ * A helper to free all eb folios, should only be utilized in eb allocation
+ * path where we know all the folios are safe to be dropped.
+ */
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
@@ -3514,7 +3546,10 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
+	struct extent_buffer *existing_eb;
 	struct folio *existing_folio;
+	int eb_order = folio_order(eb->folios[0]);
+	int existing_order;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -3533,37 +3568,63 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	if (IS_ERR(existing_folio))
 		goto retry;
 
-	/* For now, we should only have single-page folios for btree inode. */
-	ASSERT(folio_nr_pages(existing_folio) == 1);
-
-	if (folio_size(existing_folio) != eb->folio_size) {
-		folio_unlock(existing_folio);
-		folio_put(existing_folio);
-		return -EAGAIN;
-	}
-
+	existing_order = folio_order(existing_folio);
 	if (fs_info->nodesize < PAGE_SIZE) {
 		/*
 		 * We're going to reuse the existing page, can drop our page
 		 * and subpage structure now.
 		 */
-		__free_page(folio_page(eb->folios[i], 0));
+		folio_put(eb->folios[i]);
 		eb->folios[i] = existing_folio;
-	} else {
-		struct extent_buffer *existing_eb;
+		return 0;
+	}
 
-		existing_eb = grab_extent_buffer(fs_info,
-						 folio_page(existing_folio, 0));
-		if (existing_eb) {
-			/* The extent buffer still exists, we can use it directly. */
-			*found_eb_ret = existing_eb;
-			folio_unlock(existing_folio);
-			folio_put(existing_folio);
-			return 1;
-		}
-		/* The extent buffer no longer exists, we can reuse the folio. */
-		__free_page(folio_page(eb->folios[i], 0));
+	/* Non-subpage case, try if we can grab the eb from the existing folio. */
+	existing_eb = grab_extent_buffer(fs_info,
+				folio_page(existing_folio, 0));
+	if (existing_eb) {
+		/*
+		 * The extent buffer still exists, we can use
+		 * it directly.
+		 */
+		*found_eb_ret = existing_eb;
+		folio_unlock(existing_folio);
+		folio_put(existing_folio);
+		return 1;
+	}
+	if (existing_order > eb_order) {
+		/*
+		 * The existing one has higher order, we need to drop
+		 * ALL eb folios before reusing it.
+		 * And this can only happen for the first folio.
+		 */
+		ASSERT(i == 0);
+		free_all_eb_folios(eb);
 		eb->folios[i] = existing_folio;
+	} else if (existing_order == eb_order) {
+		/*
+		 * Can safely reuse the filemap folio, just
+		 * release the eb one.
+		 */
+		folio_put(eb->folios[i]);
+		eb->folios[i] = existing_folio;
+	} else if (existing_order < eb_order) {
+		/*
+		 * The existing one has lower order (page based)
+		 * meanwhile we have a better higher order eb.
+		 *
+		 * In theory we should be able to drop all the
+		 * lower order folios in filemap and replace them
+		 * with our better one.
+		 * But we can not as the existing one still has
+		 * private set.
+		 * So here we force to fallback to 0 order folio
+		 * and retry.
+		 */
+		ASSERT(i == 0);
+		folio_unlock(existing_folio);
+		folio_put(existing_folio);
+		return -EAGAIN;
 	}
 	return 0;
 }
@@ -3580,6 +3641,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
+	int order = 0;
 	int uptodate = 1;
 	int ret;
 
@@ -3597,6 +3659,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
+	if (fs_info->nodesize > PAGE_SIZE &&
+	    IS_ALIGNED(start, fs_info->nodesize))
+		order = ilog2(fs_info->nodesize >> PAGE_SHIFT);
+
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -3631,7 +3697,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, __GFP_NOFAIL);
+	ret = alloc_eb_folio_array(eb, __GFP_NOFAIL, order);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3649,26 +3715,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
+		 * This happens when we got a higher order (better) folio, but
+		 * the filemap still has lower order (single paged) folio.
+		 * We don't have a good way to replace them yet.
+		 * Thus has to retry with lower order (0) folio.
 		 */
 		if (unlikely(ret == -EAGAIN)) {
-			ASSERT(0);
+			order = 0;
+			free_all_eb_folios(eb);
 			goto reallocate;
 		}
 		attached++;
@@ -3681,6 +3735,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		folio = eb->folios[i];
 		eb->folio_size = folio_size(folio);
 		eb->folio_shift = folio_shift(folio);
+
+		/*
+		 * We may have changed from single page folios to a larger
+		 * folios from filemap.
+		 * Re-calculate num_folios;
+		 */
+		num_folios = num_extent_folios(eb);
+
 		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_folio(eb, folio, prealloc);
-- 
2.43.0


