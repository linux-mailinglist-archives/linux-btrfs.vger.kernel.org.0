Return-Path: <linux-btrfs+bounces-1916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066B841209
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18F41F23927
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D12E3F2;
	Mon, 29 Jan 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bH5B1gMM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bH5B1gMM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD823754
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553221; cv=none; b=J1ZVWGxgvb4rvOXmZ/tQVYiLViqyqtoCEJHiA3kiDQ+IH/QhzRhooSy2nukMPAfuKKz9BnHOGSeNSv7EPUX6GEL+hrLSvj2NnGLEP3CIxyJ/CqTsDMN9zEO6MgtiU1fCOhxmoHJJ+6aIhAPjJBxOYL7JGHwMGANQ+JpzFU5sCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553221; c=relaxed/simple;
	bh=p9fVgdTvIe2ouKzdEJSDLJb7RPMaWQykq0n63RXtUH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQh9J57AzRAJ1o6GcOmD+wkIhtZS1KogrJFtwGJvhfySmGd/dQvTCQR1FBB9nPEAY9JJvo7AdkhMiG7u+FvdOo7MRjaFh3MMEsYzMRaY5jhWMB6kdqRV8YQHmAveVuivNymuSLipMhDO0QALVLmd767r+1PXbsbtp7ofmjoAq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bH5B1gMM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bH5B1gMM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B3C62225C;
	Mon, 29 Jan 2024 18:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706553217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUghKq+mlRm5wCyRJfCWRrYhj3hesYPO5AjT1zAmF6Q=;
	b=bH5B1gMMh+FHlmxki/Eg6TtKlpcStzUzBdXPE8XLbL/GuhT+BPQfTxM+RTiH8aPwhTENMC
	4HFGQ0TvsUlnqDdjM8xpuKhoviOyWIEDnMvIdTSbpAffoCDqjgEak1R98gPOCCTaPwry9m
	l6JJKep3RsxeYfs5beUSvePT9ac0wnc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706553217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUghKq+mlRm5wCyRJfCWRrYhj3hesYPO5AjT1zAmF6Q=;
	b=bH5B1gMMh+FHlmxki/Eg6TtKlpcStzUzBdXPE8XLbL/GuhT+BPQfTxM+RTiH8aPwhTENMC
	4HFGQ0TvsUlnqDdjM8xpuKhoviOyWIEDnMvIdTSbpAffoCDqjgEak1R98gPOCCTaPwry9m
	l6JJKep3RsxeYfs5beUSvePT9ac0wnc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 341F8132FA;
	Mon, 29 Jan 2024 18:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SaC2DIHvt2V0RAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 29 Jan 2024 18:33:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: add helpers to get inode from page/folio pointers
Date: Mon, 29 Jan 2024 19:33:13 +0100
Message-ID: <86448b99cc16046569c38cdef83c41afcd8047ed.1706553080.git.dsterba@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

Add convenience helpers to get a struct btrfs_inode from a page or folio
pointer instead of open coding the chain or intermediate BTRFS_I. This
is implemented as a macro so we don't need full definitions of struct page
or address_space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   | 3 ++-
 fs/btrfs/extent_io.c | 8 ++++----
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/misc.h      | 3 +++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 26c11fce5e4e..e711bfe4d221 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -528,7 +528,8 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 				 size_t length)
 {
 	struct extent_io_tree *tree;
-	tree = &BTRFS_I(folio->mapping->host)->io_tree;
+
+	tree = &folio_to_inode(folio)->io_tree;
 	extent_invalidate_folio(tree, folio, offset);
 	btree_release_folio(folio, GFP_NOFS);
 	if (folio_get_private(folio)) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index baa149f2152c..46667c9d61a6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -839,7 +839,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			       u64 disk_bytenr, struct page *page,
 			       size_t size, unsigned long pg_offset)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 
 	ASSERT(pg_offset + size <= PAGE_SIZE);
 	ASSERT(bio_ctrl->end_io_func);
@@ -1171,7 +1171,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
@@ -1194,7 +1194,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					struct btrfs_bio_ctrl *bio_ctrl,
 					u64 *prev_em_start)
 {
-	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(pages[0]);
 	int index;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
@@ -2392,7 +2392,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *btrfs_inode = page_to_inode(page);
 	struct extent_io_tree *tree = &btrfs_inode->io_tree;
 	struct extent_map_tree *map = &btrfs_inode->extent_tree;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2d348c9c93b..2d3e5359d067 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7936,7 +7936,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
 static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 				 size_t length)
 {
-	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
+	struct btrfs_inode *inode = folio_to_inode(folio);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 40f2d9f1a17a..8be09234c575 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -8,6 +8,9 @@
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
+#define page_to_inode(page)	BTRFS_I((page)->mapping->host)
+#define folio_to_inode(folio)	BTRFS_I((folio)->mapping->host)
+
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
  */
-- 
2.42.1


