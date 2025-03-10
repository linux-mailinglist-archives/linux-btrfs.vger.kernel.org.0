Return-Path: <linux-btrfs+bounces-12152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BEFA5A3D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F07416CEB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4C22FDE8;
	Mon, 10 Mar 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kCMPAYzJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6bqdHkF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kCMPAYzJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6bqdHkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21418FDAB
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634969; cv=none; b=af1QacnFthjXRtucisG0Kw0HhEk0ler1JGRWpjlHmkh2AEx7Y+kb47rLcslq7I+osZOH7BStJPEKNBq0jLl8dSVSCC/RafE47t8Ys+EgTmOdMdk4hl/V5i66DdT4sak63yS40K+lbHpoS2o4Q+89Zk2iXTKgG+Jum7JHRb5j4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634969; c=relaxed/simple;
	bh=hePWObXhYyI35Ra9NOBtf4/bKSftMECAP+QZZBPWxbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON16YXCv3+IMvoL1YXHNQk3EorE0iuw3tL3LUO607j4uCmEtk9SROMfocDCx9jQPEW7GRuUP66YBbBe1pkoZ/hRhe1PfPS57531GcyHFSh8b8HH/DMZ1ZvcWnid+GY+OJRhvOOy+nw0UeI8s+1daJ5Q5HN0Yb8/uqM0E93tlnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kCMPAYzJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6bqdHkF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kCMPAYzJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6bqdHkF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 195AF2116A;
	Mon, 10 Mar 2025 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8wPesf+hUzaJf79dnDBdN2BZn4UFLfbcadrM0M3lik=;
	b=kCMPAYzJtk2ryZKtksj2B8y3WNa7+LccpPVXazogtTEEHALuPSgFvxkhYbUorzWZOnJe66
	vXkcPjwuqwd68uVz1OL+zx+DmF35e7Ab39Wp5HMFBM4uPOIQqEEdFWgm/y2aiNW9EikXSE
	ZD7z4qDcqqhJGmnzJ7DPeq0XG9DulbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8wPesf+hUzaJf79dnDBdN2BZn4UFLfbcadrM0M3lik=;
	b=s6bqdHkFT6gZDaq65HgkGIvjvHXL7NmkhLTQ7pl/TSmLOZyIxvwqrqJRvitxN4F8jjjOjI
	KLuOy9bz9N38esAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8wPesf+hUzaJf79dnDBdN2BZn4UFLfbcadrM0M3lik=;
	b=kCMPAYzJtk2ryZKtksj2B8y3WNa7+LccpPVXazogtTEEHALuPSgFvxkhYbUorzWZOnJe66
	vXkcPjwuqwd68uVz1OL+zx+DmF35e7Ab39Wp5HMFBM4uPOIQqEEdFWgm/y2aiNW9EikXSE
	ZD7z4qDcqqhJGmnzJ7DPeq0XG9DulbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8wPesf+hUzaJf79dnDBdN2BZn4UFLfbcadrM0M3lik=;
	b=s6bqdHkFT6gZDaq65HgkGIvjvHXL7NmkhLTQ7pl/TSmLOZyIxvwqrqJRvitxN4F8jjjOjI
	KLuOy9bz9N38esAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2A4A1399F;
	Mon, 10 Mar 2025 19:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QGQrLY89z2e3FAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 10 Mar 2025 19:29:19 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
Date: Mon, 10 Mar 2025 15:29:07 -0400
Message-ID: <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741631234.git.rgoldwyn@suse.com>
References: <cover.1741631234.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since mapping_set_release_always() will provide a callback for release
folio, remove EXTENT_FOLIO_PRIVATE and all it's helper functions.

This affects how we handle subpage, so convert the function name of
set_folio_extent_mapped() to btrfs_set_folio_subpage() and
clear_folio_extent_mapped() to btrfs_clear_folio_subpage().
These functions are now just wrappers to btrfs_attach_subpage() and
btrfs_detach_subpage().

free_space_cache_inode does not use subpage, so just skip calling
btrfs_set_folio_subpage().

This reverts part of
fd1d7f44b352 ("btrfs: reject out-of-band dirty folios during writeback")
because it is not relevant. Whether a folio belongs to btrfs is now done
at the file inode level as opposed to the folio level.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c      |  2 +-
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/extent_io.c        | 59 +++++--------------------------------
 fs/btrfs/extent_io.h        | 10 ++-----
 fs/btrfs/file.c             |  4 +--
 fs/btrfs/free-space-cache.c |  9 ------
 fs/btrfs/inode.c            | 10 +++----
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/relocation.c       |  4 +--
 9 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e7f8ee5d48a4..85162ea47a7f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -491,7 +491,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			*memstall = 1;
 		}
 
-		ret = set_folio_extent_mapped(folio);
+		ret = btrfs_set_folio_subpage(folio);
 		if (ret < 0) {
 			folio_unlock(folio);
 			folio_put(folio);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index ae0b92b96345..6a980cf2acf7 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -883,7 +883,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 		return ERR_PTR(-ETXTBSY);
 	}
 
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 297b7168a7d6..3afbb754c248 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -859,38 +859,18 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 	return ret;
 }
 
-int set_folio_extent_mapped(struct folio *folio)
+int btrfs_set_folio_subpage(struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info;
-
-	ASSERT(folio->mapping);
-
-	if (folio_test_private(folio))
-		return 0;
-
-	fs_info = folio_to_fs_info(folio);
-
-	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
-	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
-	return 0;
+	return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 }
 
-void clear_folio_extent_mapped(struct folio *folio)
+void btrfs_clear_folio_subpage(struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info;
-
-	ASSERT(folio->mapping);
-
-	if (!folio_test_private(folio))
-		return;
-
-	fs_info = folio_to_fs_info(folio);
-	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
-	folio_detach_private(folio);
+	btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 }
 
 static struct extent_map *get_extent_map(struct btrfs_inode *inode,
@@ -942,7 +922,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	int ret = 0;
 	const size_t blocksize = fs_info->sectorsize;
 
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
 		return ret;
@@ -1731,30 +1711,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
 
-	/*
-	 * If the page is dirty but without private set, it's marked dirty
-	 * without informing the fs.
-	 * Nowadays that is a bug, since the introduction of
-	 * pin_user_pages*().
-	 *
-	 * So here we check if the page has private set to rule out such
-	 * case.
-	 * But we also have a long history of relying on the COW fixup,
-	 * so here we only enable this check for experimental builds until
-	 * we're sure it's safe.
-	 */
-	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
-	    unlikely(!folio_test_private(folio))) {
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
-		btrfs_err_rl(fs_info,
-	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
-			     inode->root->root_key.objectid,
-			     btrfs_ino(inode), folio_pos(folio));
-		ret = -EUCLEAN;
-		goto done;
-	}
-
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto done;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2e261892c7bc..f4077941810f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -65,12 +65,6 @@ enum {
 	ENUM_BIT(PAGE_SET_ORDERED),
 };
 
-/*
- * Folio private values.  Every page that is controlled by the extent map has
- * folio private set to this value.
- */
-#define EXTENT_FOLIO_PRIVATE			1
-
 /*
  * The extent buffer bitmap operations are done with byte granularity instead of
  * word granularity for two reasons:
@@ -247,8 +241,8 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
-int set_folio_extent_mapped(struct folio *folio);
-void clear_folio_extent_mapped(struct folio *folio);
+int btrfs_set_folio_subpage(struct folio *folio);
+void btrfs_clear_folio_subpage(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 160e4030ca60..12d7a98c50a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -877,7 +877,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 	}
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -1835,7 +1835,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	folio_wait_writeback(folio);
 
 	lock_extent(io_tree, page_start, page_end, &cached_state);
-	ret2 = set_folio_extent_mapped(folio);
+	ret2 = btrfs_set_folio_subpage(folio);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3095cce904b5..4dacf8386050 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -450,7 +450,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 	int i;
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
-		int ret;
 
 		folio = __filemap_get_folio(inode->i_mapping, i,
 					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
@@ -460,14 +459,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 			return -ENOMEM;
 		}
 
-		ret = set_folio_extent_mapped(folio);
-		if (ret < 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			io_ctl_drop_pages(io_ctl);
-			return ret;
-		}
-
 		io_ctl->pages[i] = &folio->page;
 		if (uptodate && !folio_test_uptodate(folio)) {
 			btrfs_read_folio(NULL, folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 02ff9c449b35..aba7e6099180 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4873,11 +4873,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	/*
 	 * We unlock the page after the io is completed and then re-lock it
-	 * above.  release_folio() could have come in between that and cleared
-	 * folio private, but left the page in the mapping.  Set the page mapped
+	 * above.  release_folio() could have come in between that,
+	 * but left the page in the mapping.  Set the page mapped
 	 * here to make sure it's properly set for the subpage stuff.
 	 */
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -7317,7 +7317,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(folio, gfp_flags)) {
 		wait_subpage_spinlock(folio);
-		clear_folio_extent_mapped(folio);
+		btrfs_clear_folio_subpage(folio);
 		return true;
 	}
 	return false;
@@ -7515,7 +7515,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
-	clear_folio_extent_mapped(folio);
+	btrfs_clear_folio_subpage(folio);
 }
 
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 15c296cb4dac..e27486fec156 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -91,7 +91,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 		goto out_unlock;
 	}
 
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto out_unlock;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index af0969b70b53..a9e62fe6c8af 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2870,10 +2870,10 @@ static int relocate_one_folio(struct reloc_control *rc,
 
 	/*
 	 * We could have lost folio private when we dropped the lock to read the
-	 * folio above, make sure we set_folio_extent_mapped() here so we have any
+	 * folio above, make sure we btrfs_set_folio_subpage() here so we have any
 	 * of the subpage blocksize stuff we need in place.
 	 */
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto release_folio;
 
-- 
2.48.1


