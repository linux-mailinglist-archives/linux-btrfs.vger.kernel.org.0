Return-Path: <linux-btrfs+bounces-2030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9953845F52
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F183A298455
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745884FCD;
	Thu,  1 Feb 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJL+qyU7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJL+qyU7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656917C6C6
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810575; cv=none; b=Rt5IpzzB/5BUd5gOpBvXcYed6E8t4bu9i0Se+9pNMT64o9koYkamPZOBhXIKcWn2TQHJMYQBBkkuEmWDACob/pH2PR0UQ+W9KU1lGamxGZE/PALD7z3mUER2gRcYCEj77CB+5/2neIqc4gCY+syBHGh5LhfLDJVKBYXH2qW4ccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810575; c=relaxed/simple;
	bh=XyIbpSqbgwzKkWsFUZk405wI27k4xP6EYeRSI7MX5Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtSwsh6KY6j0K/6RGhAE1iNypyukeygb7THhavwjXNAiWsp+MQRYdtIA0IkMOBbVQbpqDYRbvh9dov+ClceeD51DsLN8d3I8hY77DGsqYqytl6PnrHt+WSGGajK3UV6nywBt/JesJI4p9qW8c7SgmlXWGJA5+atW4zwmSstdVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJL+qyU7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJL+qyU7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A21B21F49;
	Thu,  1 Feb 2024 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwno6ahArZs0qTDPhEAtTRu5BXbTdpQjWEhYW6IVa3A=;
	b=dJL+qyU7PryQyohO/Bf0vZ7PNnaHR//A4t4LFAmmNOm6INNMcjjQ4sPY8WyRa/wPMDgDkp
	xSSJ2gd3TIaoKfFmDabO8Ojl+HmRUvy5tuNnJu0vnpGjpV9Gs56Z9+K6kpx/zjtKzYtmue
	mmbwEsYgN5XEVsXRvGHeKpybYNSTqns=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwno6ahArZs0qTDPhEAtTRu5BXbTdpQjWEhYW6IVa3A=;
	b=dJL+qyU7PryQyohO/Bf0vZ7PNnaHR//A4t4LFAmmNOm6INNMcjjQ4sPY8WyRa/wPMDgDkp
	xSSJ2gd3TIaoKfFmDabO8Ojl+HmRUvy5tuNnJu0vnpGjpV9Gs56Z9+K6kpx/zjtKzYtmue
	mmbwEsYgN5XEVsXRvGHeKpybYNSTqns=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 93CED13594;
	Thu,  1 Feb 2024 18:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CuQTJMvcu2WmTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: add helpers to get inode from page/folio pointers
Date: Thu,  1 Feb 2024 19:02:26 +0100
Message-ID: <89f65ec2ffb3f24741324ff458bba9d91d18c541.1706810422.git.dsterba@suse.com>
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
	dkim=pass header.d=suse.com header.s=susede1 header.b=dJL+qyU7
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
X-Rspamd-Queue-Id: 9A21B21F49
X-Spam-Flag: NO

Add convenience helpers to get a struct btrfs_inode from a page or folio
pointer instead of open coding the chain or intermediate BTRFS_I. This
is implemented as a macro (still with type checking) so we don't need
full definitions of struct page or address_space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   | 3 ++-
 fs/btrfs/extent_io.c | 8 ++++----
 fs/btrfs/fs.h        | 5 +++++
 fs/btrfs/inode.c     | 2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

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
index 8648ea9b5fb5..7f9eaffbf433 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -819,7 +819,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			       u64 disk_bytenr, struct page *page,
 			       size_t size, unsigned long pg_offset)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 
 	ASSERT(pg_offset + size <= PAGE_SIZE);
 	ASSERT(bio_ctrl->end_io_func);
@@ -1151,7 +1151,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(page);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
@@ -1174,7 +1174,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					struct btrfs_bio_ctrl *bio_ctrl,
 					u64 *prev_em_start)
 {
-	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
+	struct btrfs_inode *inode = page_to_inode(pages[0]);
 	int index;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
@@ -2372,7 +2372,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
+	struct btrfs_inode *btrfs_inode = page_to_inode(page);
 	struct extent_io_tree *tree = &btrfs_inode->io_tree;
 	struct extent_map_tree *map = &btrfs_inode->extent_tree;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b747134fac77..1ee3afe1e45c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -828,6 +828,11 @@ struct btrfs_fs_info {
 #endif
 };
 
+#define page_to_inode(_page)	(BTRFS_I(_Generic((_page),			\
+					  struct page *: (_page))->mapping->host))
+#define folio_to_inode(_folio)	(BTRFS_I(_Generic((_folio),			\
+					  struct folio *: (_folio))->mapping->host))
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
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
-- 
2.42.1


