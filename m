Return-Path: <linux-btrfs+bounces-6031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA391B5B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 06:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA421C21AA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 04:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50DF37143;
	Fri, 28 Jun 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ahGcy54W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ahGcy54W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBE208B8
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548521; cv=none; b=EMUbJ41P7E3ENmvi7pkCs0dyTVUlKPs1n750qi1FEv+rRYIgQtFmx63esC6LPKhpXkzbcR0L0Q6lKNLEqTUTD/s3KSv1/srRw9X+PvDTauOq4QyzF1extbYKyRw85AmWZF6kGqAIGAjifS0Ad2Lxou3k+ZuIi9tastXWVe1bkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548521; c=relaxed/simple;
	bh=/X3d5GuMboVCA2WTyThVD3MOnjMbgSembUO8wXTZwfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msxAHBAjWMlAhxsjy2zHeGRhwvas/8z66noeX3Wgjm3a+FmUu+zLM0nUNKA4KVKM8YPgbxBOJi7zVtYAdn9tnBV7WyJFXvlJlWqQZkw4fg8cWTrd+sNsMbTmOPirmofa4g1RTfveh62t3XmCPKLfUtL9BuV31ePO8/VkrEllfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ahGcy54W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ahGcy54W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D06E21AC7
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQ4RePHYh9+2rE+LtEbvKzcEjKLvk/03GTwjR/FXBc=;
	b=ahGcy54WYbhDQUW++CuacINnewGY4Mtdm7CbGY4xYN0bURQtmk8aAt8wxz+DxnWl76Az5I
	bswlzBrpnDe+MNP6vJOEcIzTdf3sAbo2u2jVJQxV+QF8UYz0mru3k4qkdgndqNBa9FqPCQ
	RboIfvWbC2M3zCzyEOKsKFR31SaRoPk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ahGcy54W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBQ4RePHYh9+2rE+LtEbvKzcEjKLvk/03GTwjR/FXBc=;
	b=ahGcy54WYbhDQUW++CuacINnewGY4Mtdm7CbGY4xYN0bURQtmk8aAt8wxz+DxnWl76Az5I
	bswlzBrpnDe+MNP6vJOEcIzTdf3sAbo2u2jVJQxV+QF8UYz0mru3k4qkdgndqNBa9FqPCQ
	RboIfvWbC2M3zCzyEOKsKFR31SaRoPk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 316B21373E
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0JArN2I6fmZXWwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: rename the extra_gfp parameter of btrfs_alloc_page_array()
Date: Fri, 28 Jun 2024 13:51:30 +0930
Message-ID: <9533640304878bb57291dafc76ab0656892cf64a.1719548446.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719548446.git.wqu@suse.com>
References: <cover.1719548446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0D06E21AC7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

There is only one caller utilizing the @extra_gfp parameter,
alloc_eb_folio_array().
And in that case the extra_gfp is only assigned to __GFP_NOFAIL.

This patch would rename the @extra_gfp parameter to @nofail to indicate
that.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 20 ++++++++++----------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/raid56.c    |  6 +++---
 fs/btrfs/scrub.c     |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dc416bad9ad8..d3ce07ab9692 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -696,21 +696,21 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
 }
 
 /*
- * Populate every free slot in a provided array with pages.
+ * Populate every free slot in a provided array with pages, using GFP_NOFS.
  *
  * @nr_pages:   number of pages to allocate
  * @page_array: the array to fill with pages; any existing non-null entries in
- * 		the array will be skipped
- * @extra_gfp:	the extra GFP flags for the allocation.
+ *		the array will be skipped
+ * @nofail:	whether using __GFP_NOFAIL flag
  *
  * Return: 0        if all pages were able to be allocated;
  *         -ENOMEM  otherwise, the partially allocated pages would be freed and
  *                  the array slots zeroed
  */
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
-			   gfp_t extra_gfp)
+			   bool nofail)
 {
-	const gfp_t gfp = GFP_NOFS | extra_gfp;
+	const gfp_t gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
@@ -734,13 +734,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
  *
  * For now, the folios populated are always in order 0 (aka, single page).
  */
-static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp)
+static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 {
 	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
 	int num_pages = num_extent_pages(eb);
 	int ret;
 
-	ret = btrfs_alloc_page_array(num_pages, page_array, extra_gfp);
+	ret = btrfs_alloc_page_array(num_pages, page_array, nofail);
 	if (ret < 0)
 		return ret;
 
@@ -2722,7 +2722,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, 0);
+	ret = alloc_eb_folio_array(new, false);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -2755,7 +2755,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, 0);
+	ret = alloc_eb_folio_array(eb, false);
 	if (ret)
 		goto err;
 
@@ -3121,7 +3121,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, __GFP_NOFAIL);
+	ret = alloc_eb_folio_array(eb, true);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8364dcb1ace3..e0cf9a367373 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -364,7 +364,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *buf);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
-			   gfp_t extra_gfp);
+			   bool nofail);
 int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 92ef9b01cf5e..0a11d309ee89 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 	if (!pages)
 		return -ENOMEM;
-	ret = btrfs_alloc_page_array(nr_pages, pages, 0);
+	ret = btrfs_alloc_page_array(nr_pages, pages, false);
 	if (ret) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3858c00936e8..39bec672df0c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1051,7 +1051,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	int ret;
 
-	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, 0);
+	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, false);
 	if (ret < 0)
 		return ret;
 	/* Mapping all sectors */
@@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	int ret;
 
 	ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
-				     rbio->stripe_pages + data_pages, 0);
+				     rbio->stripe_pages + data_pages, false);
 	if (ret < 0)
 		return ret;
 
@@ -1640,7 +1640,7 @@ static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 	const int data_pages = rbio->nr_data * rbio->stripe_npages;
 	int ret;
 
-	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages, 0);
+	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages, false);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4677a4f55b6a..14a8d7100018 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 	atomic_set(&stripe->pending_io, 0);
 	spin_lock_init(&stripe->write_error_lock);
 
-	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages, 0);
+	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages, false);
 	if (ret < 0)
 		goto error;
 
-- 
2.45.2


