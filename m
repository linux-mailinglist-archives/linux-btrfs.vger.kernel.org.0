Return-Path: <linux-btrfs+bounces-11705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B70A400AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6221895445
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0B253358;
	Fri, 21 Feb 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5h1jb3e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+BknapyJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5h1jb3e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+BknapyJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F861FBC86
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169283; cv=none; b=Lg2I6quUIcRP0jf2ifK7nZBKDsSP6XhG4dwZmTxKIO+AuCzTMbqGelEWFnmNxO9jR7+rtkuyKwfD5sF/I13pnzxwGv4iQVenebd1+nrAztokAW+Ofe7p7xOLrI1ZGJJNS07xRd/HHSSNt/zn/QVgilD/yXkzZuisCZU6k/JPjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169283; c=relaxed/simple;
	bh=EgycHrvQ2ItFu37joB31/rxz6108LXQWp+uXbn+gHqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as57bxdmNJDC7OzQKBK2T6fnFKq2pGgSImfBRI6uivabHHLsz2hwfl78GbV1UKZe2C5Ng/zluPTWg5jHG4dIWPlsixnOc/RvOhkSDz8mHrC9C6OFf2Oj/Jh9fvFZI8vduVO+df5Qq4deSuZqHF3TEy32KOBhCceS7q8UVWrvJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5h1jb3e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+BknapyJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5h1jb3e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+BknapyJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A2D321174;
	Fri, 21 Feb 2025 20:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTb4vlxyuVnFOivdqtVSdPD5t4DMLRcpUrD4oLTesEA=;
	b=W5h1jb3eA8/1D0Jmm/QSkH9EEFiqRRUY7mNrRG3hIkc0Eejvpr8c2HYXw0IgHhP3yZ344N
	db21JA3uwQPGhaVkZuZIuTf+QhQeFpatxpwMgChQdRfUh+KPssmgZElRUTEd3Vz9K6AK4G
	edJ/3OHCGCGZw5tEK90+HzQSBAej+cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTb4vlxyuVnFOivdqtVSdPD5t4DMLRcpUrD4oLTesEA=;
	b=+BknapyJHVI9q6jjbvmL7s5y9Vbz5P5zo+BVx1LRxnZzNlLIiItYH4t90Hu/YBW4U6KgRh
	eXAc/EcqvN6zppDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTb4vlxyuVnFOivdqtVSdPD5t4DMLRcpUrD4oLTesEA=;
	b=W5h1jb3eA8/1D0Jmm/QSkH9EEFiqRRUY7mNrRG3hIkc0Eejvpr8c2HYXw0IgHhP3yZ344N
	db21JA3uwQPGhaVkZuZIuTf+QhQeFpatxpwMgChQdRfUh+KPssmgZElRUTEd3Vz9K6AK4G
	edJ/3OHCGCGZw5tEK90+HzQSBAej+cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTb4vlxyuVnFOivdqtVSdPD5t4DMLRcpUrD4oLTesEA=;
	b=+BknapyJHVI9q6jjbvmL7s5y9Vbz5P5zo+BVx1LRxnZzNlLIiItYH4t90Hu/YBW4U6KgRh
	eXAc/EcqvN6zppDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2118413806;
	Fri, 21 Feb 2025 20:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wYG4AT3guGe0cgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 21 Feb 2025 20:21:17 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
Date: Fri, 21 Feb 2025 15:20:53 -0500
Message-ID: <f20af3e9a924af09da20a49f348b9b1f49057ccc.1740168635.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740168635.git.rgoldwyn@suse.com>
References: <cover.1740168635.git.rgoldwyn@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

free_space_cache_inode does not use subpage, so just skip calling
btrfs_set_folio_subpage().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c      |  2 +-
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/extent_io.c        | 28 +++++++++++++---------------
 fs/btrfs/extent_io.h        | 10 ++--------
 fs/btrfs/file.c             |  4 ++--
 fs/btrfs/free-space-cache.c |  9 ---------
 fs/btrfs/inode.c            |  6 +++---
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 9 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1fe154e7cc02..8f0cc726ba20 100644
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
index 968dae953948..46df90f9e790 100644
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
index d1f9fad18f25..ca29a1111de6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -865,25 +865,22 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 	return ret;
 }
 
-int set_folio_extent_mapped(struct folio *folio)
+int btrfs_set_folio_subpage(struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
 	ASSERT(folio->mapping);
 
-	if (folio_test_private(folio))
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return 0;
 
-	fs_info = folio_to_fs_info(folio);
-
-	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
+	if (folio_test_private(folio))
+		return 0;
 
-	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
-	return 0;
+	return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 }
 
-void clear_folio_extent_mapped(struct folio *folio)
+void btrfs_clear_folio_subpage(struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info;
 
@@ -893,10 +890,11 @@ void clear_folio_extent_mapped(struct folio *folio)
 		return;
 
 	fs_info = folio_to_fs_info(folio);
-	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
-	folio_detach_private(folio);
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
+		return;
+
+	btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 }
 
 static struct extent_map *get_extent_map(struct btrfs_inode *inode,
@@ -951,7 +949,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	size_t iosize;
 	size_t blocksize = fs_info->sectorsize;
 
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
 		return ret;
@@ -1562,7 +1560,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto done;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6c5328bfabc2..303c92272a46 100644
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
index 5808eb5bcd42..820feaf26583 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -875,7 +875,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 	}
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -1840,7 +1840,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	folio_wait_writeback(folio);
 
 	lock_extent(io_tree, page_start, page_end, &cached_state);
-	ret2 = set_folio_extent_mapped(folio);
+	ret2 = btrfs_set_folio_subpage(folio);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 056546bf9abd..7a85b243f18e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -453,7 +453,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 	int i;
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
-		int ret;
 
 		folio = __filemap_get_folio(inode->i_mapping, i,
 					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
@@ -463,14 +462,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
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
index 6424d45c6baa..896c9454dc96 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4863,7 +4863,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	 * folio private, but left the page in the mapping.  Set the page mapped
 	 * here to make sure it's properly set for the subpage stuff.
 	 */
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -7290,7 +7290,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(folio, gfp_flags)) {
 		wait_subpage_spinlock(folio);
-		clear_folio_extent_mapped(folio);
+		btrfs_clear_folio_subpage(folio);
 		return true;
 	}
 	return false;
@@ -7488,7 +7488,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
-	clear_folio_extent_mapped(folio);
+	btrfs_clear_folio_subpage(folio);
 }
 
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f0824c948cb7..f1060cab079f 100644
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
index af0969b70b53..285b0e5a9ab9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2873,7 +2873,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 	 * folio above, make sure we set_folio_extent_mapped() here so we have any
 	 * of the subpage blocksize stuff we need in place.
 	 */
-	ret = set_folio_extent_mapped(folio);
+	ret = btrfs_set_folio_subpage(folio);
 	if (ret < 0)
 		goto release_folio;
 
-- 
2.48.1


