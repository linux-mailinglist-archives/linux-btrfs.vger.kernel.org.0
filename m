Return-Path: <linux-btrfs+bounces-2032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FD845F51
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EA31C213B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1385622;
	Thu,  1 Feb 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iHojeNvU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iHojeNvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5584FD3
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810580; cv=none; b=W1w1qScPC5kHmHZRwK73s8CAs0527W+uJ1J7TRWBYg05zDEKJW0YnLMpjku+lB3V/vmA8/JdxTM+cb7sGOEmrE4zP7Z5WME2M7EjHzsYZTeFRBeatcaUrPQXvYfaJqAypLLIX9WeaPTsOF6HCcixaKrKxvhDpYWdKmmb3GzOm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810580; c=relaxed/simple;
	bh=sk4jIMBPoqVC59vFeeCPVsRMuHq3z7Z42j1uTDjgq0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPFlYrIWpaAUr3TS3CwR5BEO4SRAvkrvk1zJ2XhHXQEHbvWOMfa7hzKMbD+Xp3OObEvsUhnORLfgEzwIo7ScMnX9nnCXsGAk7DUCMeLkwRJSygCdzYYcLTd2mn/FxB7Mwi7f1cO9HSoL05tQ25njZXizBEsMl9Hjme0KHerGKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iHojeNvU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iHojeNvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6348C21F49;
	Thu,  1 Feb 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AT5QtPGlmGPqXQt6xI/nyxQkVYZ1e93VS/wbBEdPhRg=;
	b=iHojeNvUysFi5Nu1ibw1Txd6cPzoOHb9Pn07rMWLkInblS89Yy2ow3qv2Dw6skiA4VDm0T
	6++BgoGPTCGxIJOQhNpmkkM5Dfjb47U3kMk6esnrIpDVqG0UAiFOaZ1noIJy+SSYtbEKoS
	93xHu/xE7fNeP13dgzTugOrw7e13tcw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AT5QtPGlmGPqXQt6xI/nyxQkVYZ1e93VS/wbBEdPhRg=;
	b=iHojeNvUysFi5Nu1ibw1Txd6cPzoOHb9Pn07rMWLkInblS89Yy2ow3qv2Dw6skiA4VDm0T
	6++BgoGPTCGxIJOQhNpmkkM5Dfjb47U3kMk6esnrIpDVqG0UAiFOaZ1noIJy+SSYtbEKoS
	93xHu/xE7fNeP13dgzTugOrw7e13tcw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CB1013594;
	Thu,  1 Feb 2024 18:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id N9CfFtDcu2WsTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode pointer
Date: Thu,  1 Feb 2024 19:02:30 +0100
Message-ID: <e25d9d750e5a753c5341d11356649f89f00a260d.1706810422.git.dsterba@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iHojeNvU
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6348C21F49
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

Add a convenience helper to get a fs_info from a VFS inode pointer
instead of open coding the chain or using btrfs_sb() that in some cases
does one more pointer hop.  This is implemented as a macro (still with
type checking) so we don't need full definitions of struct btrfs_inode,
btrfs_root or btrfs_fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c      |  6 +++---
 fs/btrfs/defrag.c           |  4 ++--
 fs/btrfs/disk-io.c          |  6 +++---
 fs/btrfs/export.c           |  2 +-
 fs/btrfs/extent_io.c        | 12 +++++------
 fs/btrfs/file.c             | 14 ++++++-------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/fs.h               |  3 +++
 fs/btrfs/inode.c            | 38 +++++++++++++++++------------------
 fs/btrfs/ioctl.c            | 40 ++++++++++++++++++-------------------
 fs/btrfs/lzo.c              |  2 +-
 fs/btrfs/props.c            |  2 +-
 fs/btrfs/reflink.c          |  6 +++---
 fs/btrfs/relocation.c       |  2 +-
 14 files changed, 71 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9cae8542c7e0..0b8833baf404 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -281,7 +281,7 @@ static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
 static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 {
 	struct inode *inode = &cb->bbio.inode->vfs_inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
@@ -412,7 +412,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 				     struct compressed_bio *cb,
 				     int *memstall, unsigned long *pflags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	unsigned long end_index;
 	struct bio *orig_bio = &cb->orig_bbio->bio;
 	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
@@ -438,7 +438,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	 * This makes readahead less effective, so here disable readahead for
 	 * subpage for now, until full compressed write is supported.
 	 */
-	if (btrfs_sb(inode->i_sb)->sectorsize < PAGE_SIZE)
+	if (fs_info->sectorsize < PAGE_SIZE)
 		return 0;
 
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8fc8118c3225..3878ce0cb88e 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -809,7 +809,7 @@ static u32 get_extent_max_capacity(const struct btrfs_fs_info *fs_info,
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     u32 extent_thresh, u64 newer_than, bool locked)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_map *next;
 	bool ret = false;
 
@@ -1364,7 +1364,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	unsigned long sectors_defragged = 0;
 	u64 isize = i_size_read(inode);
 	u64 cur;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ebefc69ddcfa..3127ca68fc9d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -497,15 +497,15 @@ static int btree_migrate_folio(struct address_space *mapping,
 static int btree_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
-	struct btrfs_fs_info *fs_info;
 	int ret;
 
 	if (wbc->sync_mode == WB_SYNC_NONE) {
+		struct btrfs_fs_info *fs_info;
 
 		if (wbc->for_kupdate)
 			return 0;
 
-		fs_info = BTRFS_I(mapping->host)->root->fs_info;
+		fs_info = inode_to_fs_info(mapping->host);
 		/* this is a bit racy, but that's ok */
 		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
 					     BTRFS_DIRTY_METADATA_THRESH,
@@ -544,7 +544,7 @@ static void btree_invalidate_folio(struct folio *folio, size_t offset,
 static bool btree_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
 	struct btrfs_subpage_info *spi = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 3f2e8fb9e3e9..2f9e3c1c60f0 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -214,7 +214,7 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 {
 	struct inode *inode = d_inode(child);
 	struct inode *dir = d_inode(parent);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_inode_ref *iref;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 420054ad9acb..ac6b5d8895aa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -206,7 +206,7 @@ static void __process_pages_contig(struct address_space *mapping,
 				   struct page *locked_page, u64 start, u64 end,
 				   unsigned long page_ops)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
@@ -250,7 +250,7 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 					u64 start,
 					u64 end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
@@ -322,7 +322,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    struct page *locked_page, u64 *start,
 				    u64 *end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u64 orig_start = *start;
 	const u64 orig_end = *end;
@@ -1002,7 +1002,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 start = page_offset(page);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -1909,7 +1909,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
-	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
@@ -2197,7 +2197,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 	bool found_error = false;
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	const u32 sectorsize = fs_info->sectorsize;
 	loff_t i_size = i_size_read(inode);
 	u64 cur = start;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4bca37fd6833..7e82a40e2a44 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1135,7 +1135,7 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	loff_t pos = iocb->ki_pos;
 	int ret;
 	loff_t oldsize;
@@ -1183,7 +1183,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	struct file *file = iocb->ki_filp;
 	loff_t pos;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct page **pages = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 release_bytes = 0;
@@ -1459,7 +1459,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	loff_t pos;
 	ssize_t written = 0;
 	ssize_t written_buffered;
@@ -1785,7 +1785,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_log_ctx ctx;
@@ -2591,7 +2591,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
@@ -3046,7 +3046,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	int ret;
 
 	/* Do not allow fallocate in ZONED mode */
-	if (btrfs_is_zoned(btrfs_sb(inode->i_sb)))
+	if (btrfs_is_zoned(inode_to_fs_info(inode)))
 		return -EOPNOTSUPP;
 
 	alloc_start = round_down(offset, blocksize);
@@ -3751,7 +3751,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (fsverity_active(inode))
 		return 0;
 
-	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
+	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
 		return 0;
 
 	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f74b13f9b193..43a35c65c25f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -397,7 +397,7 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 		return -ENOMEM;
 
 	io_ctl->num_pages = num_pages;
-	io_ctl->fs_info = btrfs_sb(inode->i_sb);
+	io_ctl->fs_info = inode_to_fs_info(inode);
 	io_ctl->inode = inode;
 
 	return 0;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ce1bfd9938b1..a8b3a8828162 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -836,6 +836,9 @@ struct btrfs_fs_info {
 #define page_to_fs_info(_page)	 (page_to_inode(_page)->root->fs_info)
 #define folio_to_fs_info(_folio) (folio_to_inode(_folio)->root->fs_info)
 
+#define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
+					   struct inode *: (_inode)))->root->fs_info)
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27d67c4580bc..015c2db7139a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2827,7 +2827,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 int btrfs_writepage_cow_fixup(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_writepage_fixup *fixup;
 
 	/* This page has ordered extent covering it already */
@@ -3242,7 +3242,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 {
-	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
+	if (btrfs_is_zoned(inode_to_fs_info(ordered->inode)) &&
 	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags) &&
 	    list_empty(&ordered->bioc_list))
 		btrfs_finish_ordered_zoned(ordered);
@@ -3727,7 +3727,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 static int btrfs_read_locked_inode(struct inode *inode,
 				   struct btrfs_path *in_path)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_path *path = in_path;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
@@ -4452,8 +4452,8 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 
 int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dentry->d_sb);
 	struct btrfs_root *root = dir->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *dest = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
@@ -5008,7 +5008,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 
 		if (btrfs_is_zoned(fs_info)) {
 			ret = btrfs_wait_ordered_range(inode,
@@ -5211,7 +5211,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 
 void btrfs_evict_inode(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_block_rsv *rsv = NULL;
@@ -5650,7 +5650,7 @@ static inline u8 btrfs_inode_type(struct inode *inode)
 
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
@@ -6189,7 +6189,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	struct inode *dir = args->dir;
 	struct inode *inode = args->inode;
 	const struct fscrypt_str *name = args->orphan ? NULL : &args->fname.disk_name;
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_key *location;
@@ -6511,7 +6511,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 			       struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_new_inode_args new_inode_args = {
 		.dir = dir,
@@ -6581,7 +6581,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct fscrypt_name fname;
 	u64 index;
 	int err;
@@ -7064,7 +7064,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 	struct btrfs_path *path;
 	int ret;
@@ -7303,7 +7303,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 unsigned int iomap_flags)
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
@@ -7443,7 +7443,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		struct iomap *srcmap)
 {
 	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = iter->private;
@@ -8120,7 +8120,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct folio *folio = page_folio(page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
@@ -8729,7 +8729,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 			      struct inode *new_dir,
 			      struct dentry *new_dentry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(old_dir);
 	struct btrfs_trans_handle *trans;
 	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
@@ -8981,7 +8981,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(old_dir);
 	struct btrfs_new_inode_args whiteout_args = {
 		.dir = old_dir,
 		.dentry = old_dentry,
@@ -9423,7 +9423,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
@@ -9604,7 +9604,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       loff_t actual_len, u64 *alloc_hint,
 				       struct btrfs_trans_handle *trans)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_map *em;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_key ins;
@@ -9756,7 +9756,7 @@ static int btrfs_permission(struct mnt_idmap *idmap,
 static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			 struct file *file, umode_t mode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 46f9a6645bf6..ec9084ee23a5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -243,7 +243,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
 	struct btrfs_trans_handle *trans;
@@ -580,7 +580,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 				  struct inode *dir, struct dentry *dentry,
 				  struct btrfs_qgroup_inherit *inherit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_root_item *root_item;
@@ -772,7 +772,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 			   struct dentry *dentry, bool readonly,
 			   struct btrfs_qgroup_inherit *inherit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct inode *inode;
 	struct btrfs_pending_snapshot *pending_snapshot;
 	unsigned int trans_num_items;
@@ -958,7 +958,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 				   struct btrfs_qgroup_inherit *inherit)
 {
 	struct inode *dir = d_inode(parent->dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct dentry *dentry;
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
 	int error;
@@ -1093,7 +1093,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 new_size;
 	u64 old_size;
 	u64 devid = 1;
@@ -1401,7 +1401,7 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 static noinline int btrfs_ioctl_subvol_getflags(struct inode *inode,
 						void __user *arg)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret = 0;
 	u64 flags = 0;
@@ -1424,7 +1424,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 					      void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	u64 root_flags;
@@ -1671,7 +1671,7 @@ static noinline int search_ioctl(struct inode *inode,
 				 u64 *buf_size,
 				 char __user *ubuf)
 {
-	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *info = inode_to_fs_info(inode);
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	struct btrfs_path *path;
@@ -2342,9 +2342,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 					     bool destroy_v2)
 {
 	struct dentry *parent = file->f_path.dentry;
-	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *dest = NULL;
@@ -2692,7 +2692,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	struct bdev_handle *bdev_handle = NULL;
 	int ret;
@@ -2757,7 +2757,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_ioctl_vol_args *vol_args;
 	struct bdev_handle *bdev_handle = NULL;
 	int ret;
@@ -2900,7 +2900,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root *new_root;
 	struct btrfs_dir_item *di;
@@ -3174,7 +3174,7 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 
 static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(file_inode(file)->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(file_inode(file));
 	struct btrfs_ioctl_scrub_args *sa;
 	int ret;
 
@@ -3692,7 +3692,7 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_ioctl_quota_ctl_args *sa;
 	int ret;
 
@@ -3734,7 +3734,7 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_qgroup_assign_args *sa;
 	struct btrfs_trans_handle *trans;
@@ -3890,7 +3890,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_ioctl_quota_rescan_args *qsa;
 	int ret;
 
@@ -3954,7 +3954,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct btrfs_trans_handle *trans;
@@ -4142,7 +4142,7 @@ static int btrfs_ioctl_get_fslabel(struct btrfs_fs_info *fs_info,
 static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_trans_handle *trans;
@@ -4285,7 +4285,7 @@ check_feature_bits(fs_info, FEAT_##mask_base, change_mask, flags,	\
 static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_ioctl_feature_flags flags[2];
@@ -4576,7 +4576,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	void __user *argp = (void __user *)arg;
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 110a2c304bdc..3e5d3b7028e8 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -214,7 +214,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	const u32 sectorsize = btrfs_sb(mapping->host->i_sb)->sectorsize;
+	const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
 	struct page *page_in = NULL;
 	char *sizes_ptr;
 	const unsigned long max_nr_page = *out_pages;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f9bf591a0718..ac4a0af2b554 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -302,7 +302,7 @@ static int prop_compression_validate(const struct btrfs_inode *inode,
 static int prop_compression_apply(struct inode *inode, const char *value,
 				  size_t len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	int type;
 
 	/* Reset to defaults */
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e38cb40e150c..08d0fb46ceec 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -174,7 +174,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 				    char *inline_data,
 				    struct btrfs_trans_handle **trans_out)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dst->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(dst);
 	struct btrfs_root *root = BTRFS_I(dst)->root;
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
 				      fs_info->sectorsize);
@@ -337,7 +337,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 off, const u64 olen, const u64 olen_aligned,
 		       const u64 destoff, int no_time_update)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_path *path = NULL;
 	struct extent_buffer *leaf;
 	struct btrfs_trans_handle *trans;
@@ -726,7 +726,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 {
 	struct inode *inode = file_inode(file);
 	struct inode *src = file_inode(file_src);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	int ret;
 	int wb_ret;
 	u64 len = olen;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index abe594f77f99..2fca67f2b39b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2987,7 +2987,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			     const struct file_extent_cluster *cluster,
 			     int *cluster_nr, unsigned long page_index)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-- 
2.42.1


