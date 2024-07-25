Return-Path: <linux-btrfs+bounces-6690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E893BFBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 12:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249131C21530
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B465198A3F;
	Thu, 25 Jul 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nguV4Wm/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nguV4Wm/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66691339A0
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902299; cv=none; b=m5qmFYXVJ9vfz0ELpCrMzPOtb6c79yDoN3oG804M6coE7GaXypM6BeTczpiazr8mGIa/C5FlpT0+XIEjqCCTwMy/MNma+7K7yovGRienAsGzbn4mXTBf1VYDH0eII5HviBP1NpfsNfuBADf2mdryOv7STX2Mbsls2MXYFCvq24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902299; c=relaxed/simple;
	bh=0zlELu+ECNMoNVb/8OqfaRmwyqYEQTeyfGrx+lr2twM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N1fsOuy5CAG8W9zbBRo5eYrOPeNyDhaxbNZepLgZDFahE9Fu/waBWgo7FyN5+CfzUa1VFUuj/lpQVqjm2vCvSrGofMuzsHnmKAcYs1J4N52Ut6wSrVOVQ0HJfeLdKEiN0Tbw2Pcw/v42wOhu517W3YtQE2j9G7eZcVa6vqgxdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nguV4Wm/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nguV4Wm/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A928E1F7EB
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721902295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HRaG564BMqNU+IJAwZ7xr9lxt3juEdZaIQJIKTN7D1k=;
	b=nguV4Wm/emVxY2TmWWqhq5s+xycYB2QpDWB/+7NiA0JuoHY/LPyFrJ+IW7qNIP00+ZXcwR
	0l2neVM3deJHg86fKGYWvnnCl7DyFgocAhDN9aCdgLzr5mnMktbFXwml5z+xIQ0bQn7vqh
	K+3usrQ70nl13HiIj2j/h/egckdx2WY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721902295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HRaG564BMqNU+IJAwZ7xr9lxt3juEdZaIQJIKTN7D1k=;
	b=nguV4Wm/emVxY2TmWWqhq5s+xycYB2QpDWB/+7NiA0JuoHY/LPyFrJ+IW7qNIP00+ZXcwR
	0l2neVM3deJHg86fKGYWvnnCl7DyFgocAhDN9aCdgLzr5mnMktbFXwml5z+xIQ0bQn7vqh
	K+3usrQ70nl13HiIj2j/h/egckdx2WY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD011368A
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AyXMINYkombuRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:11:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v8] btrfs: prefer to allocate larger folio for metadata
Date: Thu, 25 Jul 2024 19:41:16 +0930
Message-ID: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

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
   We can only retry several times, before falling back to 0 order
   folios.

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
Changelog:
[CHANGELOG]
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
---
 fs/btrfs/extent_io.c | 122 ++++++++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..0beebcb9be77 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -719,12 +719,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
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
@@ -2707,7 +2723,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, false);
+	ret = alloc_eb_folio_array(new, 0, false);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -2740,7 +2756,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, false);
+	ret = alloc_eb_folio_array(eb, 0, false);
 	if (ret)
 		goto err;
 
@@ -2955,7 +2971,16 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
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
 
+#define BTRFS_ADD_FOLIO_RETRY_LIMIT	(5)
 /*
  * Return 0 if eb->folios[i] is attached to btree inode successfully.
  * Return >0 if there is already another extent buffer for the range,
@@ -2973,6 +2998,8 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	const int eb_order = folio_order(eb->folios[0]);
+	int retried = 0;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -2990,18 +3017,25 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	/* The page cache only exists for a very short time, just retry. */
 	if (IS_ERR(existing_folio)) {
 		existing_folio = NULL;
+		retried++;
+		/*
+		 * We can have the following case:
+		 *	|<- folio ->|
+		 *	|  |  |//|//|
+		 * Where |//| is the slot that we have a page cache.
+		 *
+		 * In above case, filemap_add_folio() will return -EEXIST,
+		 * but filemap_lock_folio() will return -ENOENT.
+		 * After several retries, we know it's the above case,
+		 * and just fallback to order 0 folios instead.
+		 */
+		if (eb_order > 0 && retried > BTRFS_ADD_FOLIO_RETRY_LIMIT) {
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
@@ -3010,6 +3044,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		eb->folios[i] = existing_folio;
 	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
+		int existing_order = folio_order(existing_folio);
 
 		existing_eb = grab_extent_buffer(fs_info,
 						 folio_page(existing_folio, 0));
@@ -3021,9 +3056,34 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
@@ -3056,6 +3116,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
 	int uptodate = 1;
+	int order = 0;
 	int ret;
 
 	if (check_eb_alignment(fs_info, start))
@@ -3072,6 +3133,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) && fs_info->nodesize > PAGE_SIZE &&
+	    IS_ALIGNED(start, fs_info->nodesize))
+		order = ilog2(fs_info->nodesize >> PAGE_SHIFT);
+
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -3106,7 +3171,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, true);
+	ret = alloc_eb_folio_array(eb, order, true);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3123,27 +3188,11 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -3154,6 +3203,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
+		num_folios = num_extent_folios(eb);
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
-- 
2.45.2


