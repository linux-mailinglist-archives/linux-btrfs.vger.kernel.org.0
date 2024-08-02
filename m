Return-Path: <linux-btrfs+bounces-6951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73D94553B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 02:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5BC1C2040D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 00:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCA8F48;
	Fri,  2 Aug 2024 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bct/oYf4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bct/oYf4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA1613D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557907; cv=none; b=bbUEIkY0JIzNuRzBoJOPFBM2Rq/15mcv0cBMp6F6No64qRqEZ/7BDCn1zUQaZBXqiowTsd3XLL29FQfkdYgfviLtQr1Gwit7duHVTvPkflhwd025OEzxIdg8TB9pXrDaxuEAqIp9brKTisrbS2tZCFcaPzUcqzQ+JjnTNBbasI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557907; c=relaxed/simple;
	bh=yQKqMiXI3+XZxq3VVLyzHdBTLJiJEOvRzwJutgx8XQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UgaLGF5YycRa9bMDW4nR5xdS7aicmuLhfxukBKBxrXd1A6xhoZu+sN+aLoR86lZKT+qPbPeLAwRDJrwq+I69XMYmlSJAhORotnRvXzLRmWUKzUpj4wCV6KbEDI8k1pxjI5cEjK7g8V0+OVtRBP/vvQBmFGz9/rDh2Sbo6AgqaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bct/oYf4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bct/oYf4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 239CC1FB7E
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722557903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zlu6zCahHJbC45q5EG+PQPYhZWwuv5u6m+1UqJdWuHU=;
	b=bct/oYf4M38Rb2nyMLG0PBgCjy8FFt26V4KosWNP8jsjSK+87AqRGjSC1LUVPppuzptx4P
	o/9nUgnxEZgXg9ySlusLYq9xetJk47MBFIXL6UDTmUzUG/OfzL/w72PrOh9sLlfjyamwzY
	pNOIIooSOeoUgEXuSnSIf6GxZC4g2Gc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722557903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zlu6zCahHJbC45q5EG+PQPYhZWwuv5u6m+1UqJdWuHU=;
	b=bct/oYf4M38Rb2nyMLG0PBgCjy8FFt26V4KosWNP8jsjSK+87AqRGjSC1LUVPppuzptx4P
	o/9nUgnxEZgXg9ySlusLYq9xetJk47MBFIXL6UDTmUzUG/OfzL/w72PrOh9sLlfjyamwzY
	pNOIIooSOeoUgEXuSnSIf6GxZC4g2Gc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43CB413999
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 00:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vf3ZOs0lrGYkIAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 00:18:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v9] btrfs: prefer to allocate larger folio for metadata
Date: Fri,  2 Aug 2024 09:48:00 +0930
Message-ID: <ef421f88bfa5cf4fd1d4293a8f27cfc97d5d10e4.1722557590.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.60

Since btrfs metadata is always in fixed size (nodesize, determined at
mkfs time, default to 16K), and btrfs has the full control of the folios
(read is triggered internally, no read/readahead call backs), it's the
best location to experimental larger folios inside btrfs.

To enable larger folios, the btrfs has to meet the following conditions:

- The extent buffer start is aligned to nodesize
  This should be the common case for any btrfs in the last 5 years.

- The nodesize is larger than page size

- MM layer can fulfill our larger folio allocation
  The larger folio will cover exactly the metadata size (nodesize).

If any of the condition is not met, we just fall back to page sized
folio and go as usual.
This means, we can have mixed orders for btrfs metadata.

Thus there are several new corner cases with the mixed orders:

1) New filemap_add_folio() -EEXIST failure cases
   For mixed order cases, filemap_add_folio() can return -EEXIST
   meanwhile filemap_lock_folio() returns -ENOENT.
   In this case where are 2 possible reasons:
   * The folio get reclaimed between add and lock
   * The larger folio conflicts with smaller ones in the range

   We have no way to distinguish them, so for larger folio case we
   fall back to order 0 and retry, as that will rule out folio conflict
   case.

2) Existing folio size may be different than the one we allocated
   This is after the existing eb checks.

2.1) The existing folio is larger than the allocated one
     Need to free all allocated folios, and use the existing larger
     folio instead.

2.2) The existing folio has the same size
     Free the allocated one and reuse the page cache.
     This is the existing path.

2.3) The existing folio is smaller than the allocated one
     Fall back to re-allocate order 0 folios instead.

Otherwise all the needed infrastructure is already here, we only need to
try allocate larger folio as our first try in alloc_eb_folio_array().

For now, the higher order allocation is only a preferable attempt for
debug build, before we had enough test coverage and push it to end
users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
[CHANGELOG]
v9:
- Remove the __GFP_NORETRY flag
  This is to increase the possibility that we got a larger folio.

- Instead of retrying 5 times, fall back to order 0 immediately if both
  filemap_add_folio() and filemap_lock_folio() failed
  This is to make the behavior more aligned to __filemap_get_folio()

- Add extra comments on the possible racing we're facing inside
  attach_eb_folio_to_filemap()
  And to make it more clear, add a likely() for the filemap_add_folio()
  case of (!ret)

v8:
- Drop the memcgroup optimization as dependency
  Opting out memcgroup will be pushed as an independent patchset
  instead. It's not related to the soft lockup.

- Fix a soft lockup caused by mixed folio orders
	 |<- folio ->|
	 |  |  |//|//|   |//| is the existing page cache
  In above case, the filemap_add_folio() will always return -EEXIST
  but filemap_lock_folio() also returns -ENOENT.
  Which can lead to a dead loop.
  Fix it by only retrying 5 times for larger folios, then fall back
  to 0 order folios.

- Slightly rewording the commit messages
  Make it shorter and better organized.

v7:
- Fix an accidentally removed line caused by previous modification
  attempt
  Previously I was moving that line to the common branch to
  unconditionally define root_mem_cgroup pointer.
  But that's later discarded and changed to use macro definition, but
  forgot to add back the original line.

v6:
- Add a new root_mem_cgroup definition for CONFIG_MEMCG=n cases
  So that users of root_mem_cgroup no longer needs to check
  CONFIG_MEMCG.
  This is to fix the compile error for CONFIG_MEMCG=n cases.

- Slight rewording of the 2nd patch

v5:
- Use root memcgroup to attach folios to btree inode filemap
- Only try higher order folio once without NOFAIL nor extra retry

v4:
- Hide the feature behind CONFIG_BTRFS_DEBUG
  So that end users won't be affected (aka, still per-page based
  allocation) meanwhile we can do more testing on this new behavior.

v3:
- Rebased to the latest for-next branch
- Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
- Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
  and high order allocation"
  This allows us to use NOFAIL up to 32K nodesize, and makes sure for
  default 16K nodesize, all metadata would go 16K folios

v2:
- Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"
 fs/btrfs/extent_io.c | 131 ++++++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 040c92541bc9..83225d265b60 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -716,12 +716,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
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
+		if (order > 0)
+			gfp = GFP_NOFS | __GFP_NOWARN;
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
@@ -2697,7 +2713,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, false);
+	ret = alloc_eb_folio_array(new, 0, false);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -2730,7 +2746,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, false);
+	ret = alloc_eb_folio_array(eb, 0, false);
 	if (ret)
 		goto err;
 
@@ -2945,6 +2961,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
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
@@ -2963,6 +2987,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	const int eb_order = folio_order(eb->folios[0]);
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -2973,25 +2998,39 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 retry:
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
-	if (!ret)
+	if (likely(!ret))
 		goto finish;
 
+	/*
+	 * The remaining code is to handle various cases of races, including:
+	 *
+	 * - The page got reclaimed just after above filemap_add_folio() failure
+	 * - Some one else has inserted the folio before us
+	 * - Some existing page cache but no extent buffer attached
+	 * - Mixed order folios caused some conflicts
+	 */
 	existing_folio = filemap_lock_folio(mapping, index + i);
-	/* The page cache only exists for a very short time, just retry. */
 	if (IS_ERR(existing_folio)) {
 		existing_folio = NULL;
+		/*
+		 * There are two cases here:
+		 * - The page is reclaimed between the add and lock
+		 * - The larger folio conflicts with some pages
+		 *   E.g.
+		 *	|<- folio ->|
+		 *	|  |  |//|//|
+		 *   Where |//| is the slot that we have a page cache.
+		 *
+		 * For larger folio case, we just fallback to order 0
+		 * immediately as we have no good way to distinguish them.
+		 */
+		if (eb_order > 0) {
+			ASSERT(i == 0);
+			return -EAGAIN;
+		}
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
@@ -3000,6 +3039,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		eb->folios[i] = existing_folio;
 	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
+		int existing_order = folio_order(existing_folio);
 
 		existing_eb = grab_extent_buffer(fs_info,
 						 folio_page(existing_folio, 0));
@@ -3011,9 +3051,34 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
@@ -3046,6 +3111,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
 	int uptodate = 1;
+	int order = 0;
 	int ret;
 
 	if (check_eb_alignment(fs_info, start))
@@ -3062,6 +3128,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) && fs_info->nodesize > PAGE_SIZE &&
+	    IS_ALIGNED(start, fs_info->nodesize))
+		order = ilog2(fs_info->nodesize >> PAGE_SHIFT);
+
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -3096,7 +3166,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, true);
+	ret = alloc_eb_folio_array(eb, order, true);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3113,27 +3183,11 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			goto out;
 		}
 
-		/*
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
-		 */
+		/* Need to fallback to 0 order folios. */
 		if (unlikely(ret == -EAGAIN)) {
-			ASSERT(0);
+			ASSERT(order > 0);
+			order = 0;
+			free_all_eb_folios(eb);
 			goto reallocate;
 		}
 		attached++;
@@ -3144,6 +3198,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
+		num_folios = num_extent_folios(eb);
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
-- 
2.45.2


