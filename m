Return-Path: <linux-btrfs+bounces-15039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492AAAEB5A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9647D3B6826
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11127299948;
	Fri, 27 Jun 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i4Wo0VD4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i4Wo0VD4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CA1917FB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022082; cv=none; b=jjMPxzzjXl3JcQdBAXjnsAxeLhE2uNWZbY5O+nKfx9HNHvSxX38G0taoioJfu0RHBnv6Vnb7R4q6Maa3dWaId1plBlW2qwug3MlFDeJjC4Au+h3DKovwuOSpkFP+cTitKeIhjPlNXe6e3hSB+ASFdMCLyaI4K0OIX/vI2iVcmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022082; c=relaxed/simple;
	bh=AJzT6GF6fKoCpPXQDXfcoYDZpwyRpSMuO5+Ftfz9IpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+Zt5hmwCYXmVj2UI6oAnYZl754G52aKIGQ9merI9DQxCC4gyzcdZcT9PMJx0VHdV/l3HzzWEy8xxYWiQKDca3NbRFfmMIYPwtcdXf4yJZNFSTryx8v20gaaMFgHHGqA1y9V/SaNZgXbBIlkNe8O6/tViwF13akC1S2sx8p/1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i4Wo0VD4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i4Wo0VD4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 319C31F390;
	Fri, 27 Jun 2025 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751022078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fcoFKejPVHJFkTeEuG0qEoG44BxGKE3j+Cc8npPmHTk=;
	b=i4Wo0VD4pY6cwXg+/5KvXKGyxmG44q8dO+2qjFhidTTnnS7cbgEvoyj+KITIdzzZe4JN+H
	hMrt/EDoppkRMImmuabd3sQOXfATBq/pH/dpm+bfM3yivUTV2ol6yr8xfCy0Ts/1uNjYOu
	JUOfhjA6vYr5kgHC9zmvZnjS0QNoC04=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751022078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fcoFKejPVHJFkTeEuG0qEoG44BxGKE3j+Cc8npPmHTk=;
	b=i4Wo0VD4pY6cwXg+/5KvXKGyxmG44q8dO+2qjFhidTTnnS7cbgEvoyj+KITIdzzZe4JN+H
	hMrt/EDoppkRMImmuabd3sQOXfATBq/pH/dpm+bfM3yivUTV2ol6yr8xfCy0Ts/1uNjYOu
	JUOfhjA6vYr5kgHC9zmvZnjS0QNoC04=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26D7E138A7;
	Fri, 27 Jun 2025 11:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBskCf55XmhSDQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 11:01:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use pgoff_t for page index variables
Date: Fri, 27 Jun 2025 13:01:17 +0200
Message-ID: <20250627110117.3463102-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 

Any conversion of offsets in the logical or the physical mapping space
of the pages is done by a shift and the target type should be pgoff_t
(type of struct page::index). Fix the locations where it's still
unsigned long.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c           | 12 ++++++------
 fs/btrfs/extent_io.c             |  4 ++--
 fs/btrfs/file.c                  |  2 +-
 fs/btrfs/free-space-cache.c      |  2 +-
 fs/btrfs/inode.c                 |  9 ++++-----
 fs/btrfs/ioctl.c                 |  2 +-
 fs/btrfs/relocation.c            |  8 ++++----
 fs/btrfs/tests/extent-io-tests.c |  7 +++----
 8 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4a0..eb044ca8ba261b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -282,8 +282,8 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 {
 	struct inode *inode = &cb->bbio.inode->vfs_inode;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	unsigned long index = cb->start >> PAGE_SHIFT;
-	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
+	pgoff_t index = cb->start >> PAGE_SHIFT;
+	const pgoff_t end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	int i;
 	int ret;
@@ -415,7 +415,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 				     int *memstall, unsigned long *pflags)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	unsigned long end_index;
+	pgoff_t end_index;
 	struct bio *orig_bio = &cb->orig_bbio->bio;
 	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
 	u64 isize = i_size_read(inode);
@@ -446,8 +446,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	while (cur < compressed_end) {
-		u64 page_end;
-		u64 pg_index = cur >> PAGE_SHIFT;
+		pgoff_t page_end;
+		pgoff_t pg_index = cur >> PAGE_SHIFT;
 		u32 add_size;
 
 		if (pg_index > end_index)
@@ -1482,7 +1482,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 				     struct heuristic_ws *ws)
 {
 	struct page *page;
-	u64 index, index_end;
+	pgoff_t index, index_end;
 	u32 i, curr_sample_pos;
 	u8 *in_data;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 03a55f1ee39c9f..44bc343464ab59 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1662,7 +1662,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	int ret;
 	size_t pg_offset;
 	loff_t i_size = i_size_read(&inode->vfs_inode);
-	unsigned long end_index = i_size >> PAGE_SHIFT;
+	const pgoff_t end_index = i_size >> PAGE_SHIFT;
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 
 	trace_extent_writepage(folio, &inode->vfs_inode, bio_ctrl->wbc);
@@ -3146,7 +3146,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
-	const unsigned long index = eb->start >> PAGE_SHIFT;
+	const pgoff_t index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio;
 	int ret;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 247676f34f2e66..05b046c6806fe5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -856,7 +856,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 				      loff_t pos, size_t write_bytes,
 				      bool nowait)
 {
-	unsigned long index = pos >> PAGE_SHIFT;
+	const pgoff_t index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
 	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN) |
 			  fgf_set_order(write_bytes);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index efd21a28570c1e..5d8d1570a5c948 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -366,7 +366,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 static void readahead_cache(struct inode *inode)
 {
 	struct file_ra_state ra;
-	unsigned long last_index;
+	pgoff_t last_index;
 
 	file_ra_state_init(&ra, inode->i_mapping);
 	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 80c72c594b1950..5aaeb1bea8ab54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -395,8 +395,8 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags)
 static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 						 u64 offset, u64 bytes)
 {
-	unsigned long index = offset >> PAGE_SHIFT;
-	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
+	pgoff_t index = offset >> PAGE_SHIFT;
+	const pgoff_t end_index = (offset + bytes - 1) >> PAGE_SHIFT;
 	struct folio *folio;
 
 	while (index <= end_index) {
@@ -808,12 +808,11 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 
 static int extent_range_clear_dirty_for_io(struct btrfs_inode *inode, u64 start, u64 end)
 {
-	unsigned long end_index = end >> PAGE_SHIFT;
+	const pgoff_t end_index = end >> PAGE_SHIFT;
 	struct folio *folio;
 	int ret = 0;
 
-	for (unsigned long index = start >> PAGE_SHIFT;
-	     index <= end_index; index++) {
+	for (pgoff_t index = start >> PAGE_SHIFT; index <= end_index; index++) {
 		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
 		if (IS_ERR(folio)) {
 			if (!ret)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 65763bc6a0f653..61c9ed01b8e0e7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4658,7 +4658,7 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 	struct btrfs_uring_priv *priv = bc->priv;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(priv->iocb.ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	unsigned long index;
+	pgoff_t index;
 	u64 cur;
 	size_t page_offset;
 	ssize_t ret;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d7ec1d72821c26..bbd2afd3bacf9a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2814,13 +2814,13 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 
 static int relocate_one_folio(struct reloc_control *rc,
 			      struct file_ra_state *ra,
-			      int *cluster_nr, unsigned long index)
+			      int *cluster_nr, pgoff_t index)
 {
 	const struct file_extent_cluster *cluster = &rc->cluster;
 	struct inode *inode = rc->data_inode;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
-	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
+	const pgoff_t last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	struct folio *folio;
 	u64 folio_start;
@@ -2974,8 +2974,8 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	struct inode *inode = rc->data_inode;
 	const struct file_extent_cluster *cluster = &rc->cluster;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
-	unsigned long index;
-	unsigned long last_index;
+	pgoff_t index;
+	pgoff_t last_index;
 	struct file_ra_state *ra;
 	int cluster_nr = 0;
 	int ret = 0;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 87f7437be022b8..660141fc67a87f 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -23,8 +23,8 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 {
 	int ret;
 	struct folio_batch fbatch;
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
+	pgoff_t index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
 	int i;
 	int count = 0;
 	int loops = 0;
@@ -114,7 +114,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	struct extent_io_tree *tmp;
 	struct page *page;
 	struct page *locked_page = NULL;
-	unsigned long index = 0;
 	/* In this test we need at least 2 file extents at its maximum size */
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 total_dirty = 2 * max_bytes;
@@ -157,7 +156,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * everything to make sure our pages don't get evicted and screw up our
 	 * test.
 	 */
-	for (index = 0; index < (total_dirty >> PAGE_SHIFT); index++) {
+	for (pgoff_t index = 0; index < (total_dirty >> PAGE_SHIFT); index++) {
 		page = find_or_create_page(inode->i_mapping, index, GFP_KERNEL);
 		if (!page) {
 			test_err("failed to allocate test page");
-- 
2.49.0


