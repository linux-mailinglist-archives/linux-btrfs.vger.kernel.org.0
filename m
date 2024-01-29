Return-Path: <linux-btrfs+bounces-1917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9584120A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C3B1F248DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31122E84D;
	Mon, 29 Jan 2024 18:33:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C838125CC
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553223; cv=none; b=QRUu8LZOdvn2dpONa2SPZA8bMUrt9Ub0K8F2Gk/8aalLD2pPksc2QsuULOGIklBSE76NqrMESnA9B2xWvgWObcfTLLmsdvYGiaHkN++7Ts+9XgCL/n2NVjRNCAMr8gEcNmQ7TLmfh0Y7k7jMf0xME6y8MVRwVa1ME7MwoYye2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553223; c=relaxed/simple;
	bh=0VrhVcIAopkX6zNr0eiqcC9lCaS6uLLyj8EnQvXHvXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld/MnSLbezUy75ba64dvpeDBdpFHo6hGjQFE/0QNJzyxojoQPsznSBthCZsRpNpE9HQy09mfUbO3nAhn/XPf14eiIqYPGsszyNSEguKpAjIU9A6Q0E4m61MYUNkDFO8QeY+iHSgYZDqh5zNXkVPqHhwlNwgDTrFE2eC+939utzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 979512224F;
	Mon, 29 Jan 2024 18:33:39 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C86132FA;
	Mon, 29 Jan 2024 18:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IZ1WI4Pvt2V3RAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 29 Jan 2024 18:33:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: add helpers to get fs_info from page/folio pointers
Date: Mon, 29 Jan 2024 19:33:15 +0100
Message-ID: <b93ed05e42a65c5bb11a8c5a3bdad9facb3ed43a.1706553080.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706553080.git.dsterba@suse.com>
References: <cover.1706553080.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 979512224F
X-Spam-Flag: NO

Add convenience helpers to get a fs_info from a page or folio pointer
instead of open coding the chain or using btrfs_sb() that in some cases
does one more pointer hop.  This is implemented as a macro so we don't
need full definitions of struct page or address_space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent_io.c   | 18 +++++++++---------
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/lzo.c         |  2 +-
 fs/btrfs/misc.h        |  2 ++
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 488089acd49f..9cae8542c7e0 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1036,7 +1036,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 		     unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(dest_page);
 	struct list_head *workspace;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e711bfe4d221..ebefc69ddcfa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -533,7 +533,7 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 	extent_invalidate_folio(tree, folio, offset);
 	btree_release_folio(folio, GFP_NOFS);
 	if (folio_get_private(folio)) {
-		btrfs_warn(BTRFS_I(folio->mapping->host)->root->fs_info,
+		btrfs_warn(folio_to_fs_info(folio),
 			   "folio private not zero on folio %llu",
 			   (unsigned long long)folio_pos(folio));
 		folio_detach_private(folio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46667c9d61a6..7327b276cd07 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -432,7 +432,7 @@ static bool btrfs_verify_page(struct page *page, u64 start)
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct folio *folio = page_folio(page);
 
 	ASSERT(page_offset(page) <= start &&
@@ -960,7 +960,7 @@ int set_folio_extent_mapped(struct folio *folio)
 	if (folio_test_private(folio))
 		return 0;
 
-	fs_info = btrfs_sb(folio->mapping->host->i_sb);
+	fs_info = folio_to_fs_info(page);
 
 	if (btrfs_is_subpage(fs_info, folio->mapping))
 		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
@@ -979,7 +979,7 @@ void clear_page_extent_mapped(struct page *page)
 	if (!folio_test_private(folio))
 		return;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	fs_info = page_to_fs_info(page);
 	if (btrfs_is_subpage(fs_info, page->mapping))
 		return btrfs_detach_subpage(fs_info, folio);
 
@@ -1780,7 +1780,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  */
 static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct folio *folio = page_folio(page);
 	int submitted = 0;
 	u64 page_start = page_offset(page);
@@ -1871,7 +1871,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	if (!folio_test_private(folio))
 		return 0;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
+	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
 		return submit_eb_subpage(page, wbc);
 
 	spin_lock(&mapping->i_private_lock);
@@ -1929,7 +1929,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
-	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
+	struct btrfs_fs_info *fs_info = page_to_fs_info(mapping->host);
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
@@ -2323,7 +2323,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = btrfs_sb(folio->mapping->host->i_sb)->sectorsize;
+	size_t blocksize = folio_to_fs_info(folio)->sectorsize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
@@ -4783,7 +4783,7 @@ static struct extent_buffer *get_next_extent_buffer(
 
 static int try_release_subpage_extent_buffer(struct page *page)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	u64 cur = page_offset(page);
 	const u64 end = page_offset(page) + PAGE_SIZE;
 	int ret;
@@ -4856,7 +4856,7 @@ int try_release_extent_buffer(struct page *page)
 	struct folio *folio = page_folio(page);
 	struct extent_buffer *eb;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
+	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
 		return try_release_subpage_extent_buffer(page);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2d3e5359d067..27d67c4580bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7869,7 +7869,7 @@ static void btrfs_readahead(struct readahead_control *rac)
  */
 static void wait_subpage_spinlock(struct page *page)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index e43bc0fdc74e..110a2c304bdc 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -429,7 +429,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(dest_page);
 	const u32 sectorsize = fs_info->sectorsize;
 	size_t in_len;
 	size_t out_len;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 8be09234c575..9cb671ef136c 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -10,6 +10,8 @@
 
 #define page_to_inode(page)	BTRFS_I((page)->mapping->host)
 #define folio_to_inode(folio)	BTRFS_I((folio)->mapping->host)
+#define page_to_fs_info(page)	BTRFS_I((page)->mapping->host)->root->fs_info
+#define folio_to_fs_info(page)	BTRFS_I((folio)->mapping->host)->root->fs_info
 
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
-- 
2.42.1


