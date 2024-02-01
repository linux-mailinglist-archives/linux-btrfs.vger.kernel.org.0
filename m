Return-Path: <linux-btrfs+bounces-2031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7E845F53
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C4C2985A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEB84FD7;
	Thu,  1 Feb 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XV8N1RD9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XV8N1RD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFE84FC4
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810577; cv=none; b=b0rJZ6f6yLs+iw9LYTgv3NL+xtWy6FtLLDrvZNwEvKf527ay5Z7AQWwcbiYqNxkTZ3jvB6bF9mPmy897jisGSZo+5uw0zJ2y6oT5O1aPr747CAJmmfCu27jt8ngxpTiRxrc2CYpikc2h9clgOHuanRiiLmkXINWwnNfI8YDh7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810577; c=relaxed/simple;
	bh=lm4p+o0waB2kgTEs0LdklFA18omQcEbheoYhPdkvkiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDqa+o56R2YgyrjxBC2N8pi/J96M6Ab1HY36dpbzzW55hJNO7axY49CU1g9W7S0mWaO56rJjDx6cNIj2V6R3vt0n5qniPMn1t+ChivLkdqe7tBjSbgEa+l93Q3DzDnl+yrhpMTUtcHXIME0Y5XXsF1d5qOEBqz5UxMP7eaIzZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XV8N1RD9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XV8N1RD9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03BF4222D2;
	Thu,  1 Feb 2024 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9dW18fdYBj44V4Lov0Zzln5Air5OER3IF7UuG4eBVA=;
	b=XV8N1RD9jpbXKrK92FlzrbiO1osMuVaavkztqWVS3inkMAC0KGhPjoEd9RI/UQjhHn7Y4d
	9PKYxKBHtnJyTOMMzYJaEY5XOf1sO9TPZ0x6aCNafvq09ND3zwe3tyry8EX2+DwUhGNItR
	iNzO6KkZ3OEy9id6uTJUS6qR+H6hYZQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9dW18fdYBj44V4Lov0Zzln5Air5OER3IF7UuG4eBVA=;
	b=XV8N1RD9jpbXKrK92FlzrbiO1osMuVaavkztqWVS3inkMAC0KGhPjoEd9RI/UQjhHn7Y4d
	9PKYxKBHtnJyTOMMzYJaEY5XOf1sO9TPZ0x6aCNafvq09ND3zwe3tyry8EX2+DwUhGNItR
	iNzO6KkZ3OEy9id6uTJUS6qR+H6hYZQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F18A313594;
	Thu,  1 Feb 2024 18:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n9H4Os3cu2WoTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: add helpers to get fs_info from page/folio pointers
Date: Thu,  1 Feb 2024 19:02:28 +0100
Message-ID: <ba3bd2f385070755cf02a8a73f6b103e845ecc19.1706810422.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706810422.git.dsterba@suse.com>
References: <cover.1706810422.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XV8N1RD9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 03BF4222D2
X-Spam-Flag: NO

Add convenience helpers to get a fs_info from a page or folio pointer
instead of open coding the chain or using btrfs_sb() that in some cases
does one more pointer hop.  This is implemented as a macro (still with
type checking) so we don't need full definitions of struct page, folio,
btrfs_root and btrfs_fs_info. The latter can't be static inlines as this
would create loop between ctree.h <-> fs.h, or the headers would have to
be restructured.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent_io.c   | 16 ++++++++--------
 fs/btrfs/fs.h          |  3 +++
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/lzo.c         |  2 +-
 6 files changed, 15 insertions(+), 12 deletions(-)

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
index 7f9eaffbf433..420054ad9acb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -432,7 +432,7 @@ static bool btrfs_verify_page(struct page *page, u64 start)
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct folio *folio = page_folio(page);
 
 	ASSERT(page_offset(page) <= start &&
@@ -940,7 +940,7 @@ int set_folio_extent_mapped(struct folio *folio)
 	if (folio_test_private(folio))
 		return 0;
 
-	fs_info = btrfs_sb(folio->mapping->host->i_sb);
+	fs_info = folio_to_fs_info(folio);
 
 	if (btrfs_is_subpage(fs_info, folio->mapping))
 		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
@@ -959,7 +959,7 @@ void clear_page_extent_mapped(struct page *page)
 	if (!folio_test_private(folio))
 		return;
 
-	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	fs_info = page_to_fs_info(page);
 	if (btrfs_is_subpage(fs_info, page->mapping))
 		return btrfs_detach_subpage(fs_info, folio);
 
@@ -1760,7 +1760,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  */
 static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct folio *folio = page_folio(page);
 	int submitted = 0;
 	u64 page_start = page_offset(page);
@@ -1851,7 +1851,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	if (!folio_test_private(folio))
 		return 0;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
+	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
 		return submit_eb_subpage(page, wbc);
 
 	spin_lock(&mapping->i_private_lock);
@@ -2303,7 +2303,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = btrfs_sb(folio->mapping->host->i_sb)->sectorsize;
+	size_t blocksize = folio_to_fs_info(folio)->sectorsize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
@@ -4721,7 +4721,7 @@ static struct extent_buffer *get_next_extent_buffer(
 
 static int try_release_subpage_extent_buffer(struct page *page)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	u64 cur = page_offset(page);
 	const u64 end = page_offset(page) + PAGE_SIZE;
 	int ret;
@@ -4794,7 +4794,7 @@ int try_release_extent_buffer(struct page *page)
 	struct folio *folio = page_folio(page);
 	struct extent_buffer *eb;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
+	if (page_to_fs_info(page)->nodesize < PAGE_SIZE)
 		return try_release_subpage_extent_buffer(page);
 
 	/*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 1ee3afe1e45c..ce1bfd9938b1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -833,6 +833,9 @@ struct btrfs_fs_info {
 #define folio_to_inode(_folio)	(BTRFS_I(_Generic((_folio),			\
 					  struct folio *: (_folio))->mapping->host))
 
+#define page_to_fs_info(_page)	 (page_to_inode(_page)->root->fs_info)
+#define folio_to_fs_info(_folio) (folio_to_inode(_folio)->root->fs_info)
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
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
-- 
2.42.1


