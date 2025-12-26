Return-Path: <linux-btrfs+bounces-20016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55289CDE579
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 06:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 403D0301B81D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9E246798;
	Fri, 26 Dec 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fNHhoz8m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fNHhoz8m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364023FC41
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726017; cv=none; b=cwSJO3J4w8AiDilbgRj852ujwBqtAlK6LSVuM2zor8yvC/7sfj4C2HPTCP/c+rra+HGF+M8zfxoSRT8BrowflVHyGHBNc3vSI9IlTtSaE6PMJ4uk+n4RLF/NarwdEEbsQASyUuckeBqK86fVJI9GJB1iE8Oj+M94NVzwRJR0YqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726017; c=relaxed/simple;
	bh=NReZBxbnHATG4JlErxrgDfkroJUY2Q4B3et1UrH6E18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMzCJeIBilKG7J64dvjGR2ZY4/kDcWra7nB9QSv851qCs93HUCc0e2yoFKubTa/wZUlK720JDkPMgwKvXqrzAESHnyrxLMyZEdwInlb6rI7ts0Z+nbV251SmZgJIjFAueoWxWl6M+I6+wTB8B3yPkZEHw89OqyWdwnpZDNPBYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fNHhoz8m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fNHhoz8m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6268133711
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBJQMA07V2LAXYyJOphGeObmipzhZkPfN7cOR8iSRPY=;
	b=fNHhoz8m83PTP6pwK6WgGK4uoe5h8Sk6gqP+MzCNvfrOXnJWQLXEtgUXfEHG9mf7DW05KA
	beXWea6MNWLyQDm+/+0ltzqTDpi1LPKnkrOd1e10V0pR50t5tA9e6U3F57D4MIeZ73kkdy
	2V/R5wJcGUqPNPlFkxyl6udg2Ea3SzU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766726001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBJQMA07V2LAXYyJOphGeObmipzhZkPfN7cOR8iSRPY=;
	b=fNHhoz8m83PTP6pwK6WgGK4uoe5h8Sk6gqP+MzCNvfrOXnJWQLXEtgUXfEHG9mf7DW05KA
	beXWea6MNWLyQDm+/+0ltzqTDpi1LPKnkrOd1e10V0pR50t5tA9e6U3F57D4MIeZ73kkdy
	2V/R5wJcGUqPNPlFkxyl6udg2Ea3SzU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B053EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGJZCnAZTmn1DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 05:13:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: use btrfs_file_header structure for inode.c
Date: Fri, 26 Dec 2025 15:42:50 +1030
Message-ID: <c649da7c4bc6c65679821c9167d58de48d9ea675.1766725912.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766725912.git.wqu@suse.com>
References: <cover.1766725912.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.405];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.68

This also involves btrfs_file_extent_inline*() helpers inside
file-item.h, thus the changes are covering other files.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.h  |   8 +--
 fs/btrfs/inode-item.c |   2 +-
 fs/btrfs/inode.c      | 138 +++++++++++++++++++++---------------------
 fs/btrfs/print-tree.c |  28 ++++-----
 fs/btrfs/reflink.c    |   4 +-
 fs/btrfs/send.c       |  28 ++++-----
 6 files changed, 103 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 548d02595a6c..da7e756a13f6 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -30,20 +30,20 @@ static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
  * extent headers.  If a file is compressed on disk, this is the compressed
  * size.
  */
-static inline u32 btrfs_file_extent_inline_item_len(
+static inline u32 btrfs_file_header_inline_item_len(
 						const struct extent_buffer *eb,
 						int nr)
 {
 	return btrfs_item_size(eb, nr) - sizeof(struct btrfs_file_header);
 }
 
-static inline unsigned long btrfs_file_extent_inline_start(
-				const struct btrfs_file_extent_item *e)
+static inline unsigned long btrfs_file_header_inline_start(
+				const struct btrfs_file_header *e)
 {
 	return (unsigned long)e + sizeof(struct btrfs_file_header);
 }
 
-static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
+static inline u32 btrfs_file_header_calc_inline_size(u32 datasize)
 {
 	return sizeof(struct btrfs_file_header) + datasize;
 }
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 19a00104dc6f..45c3fbf6d299 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -594,7 +594,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				u32 size = (u32)(new_size - found_key.offset);
 
 				btrfs_set_file_header_ram_bytes(leaf, fh, size);
-				size = btrfs_file_extent_calc_inline_size(size);
+				size = btrfs_file_header_calc_inline_size(size);
 				btrfs_truncate_item(trans, path, size, 1);
 			} else if (!del_item) {
 				/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 127f9e7ef453..aa9ce054ab1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -469,7 +469,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	const u32 sectorsize = trans->fs_info->sectorsize;
 	char *kaddr;
 	unsigned long ptr;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	int ret;
 	size_t cur_size = size;
 	u64 i_size;
@@ -503,35 +503,34 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_DATA_KEY;
 		key.offset = 0;
 
-		datasize = btrfs_file_extent_calc_inline_size(cur_size);
+		datasize = btrfs_file_header_calc_inline_size(cur_size);
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
 					      datasize);
 		if (ret)
 			goto fail;
 	}
 	leaf = path->nodes[0];
-	ei = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, ei, trans->transid);
-	btrfs_set_file_extent_type(leaf, ei, BTRFS_FILE_EXTENT_INLINE);
-	btrfs_set_file_extent_encryption(leaf, ei, 0);
-	btrfs_set_file_extent_other_encoding(leaf, ei, 0);
-	btrfs_set_file_extent_ram_bytes(leaf, ei, size);
-	ptr = btrfs_file_extent_inline_start(ei);
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	btrfs_set_file_header_generation(leaf, fh, trans->transid);
+	btrfs_set_file_header_type(leaf, fh, BTRFS_FILE_EXTENT_INLINE);
+	btrfs_set_file_header_encryption(leaf, fh, 0);
+	btrfs_set_file_header_other_encoding(leaf, fh, 0);
+	btrfs_set_file_header_ram_bytes(leaf, fh, size);
+	ptr = btrfs_file_header_inline_start(fh);
 
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		kaddr = kmap_local_folio(compressed_folio, 0);
 		write_extent_buffer(leaf, kaddr, ptr, compressed_size);
 		kunmap_local(kaddr);
 
-		btrfs_set_file_extent_compression(leaf, ei,
+		btrfs_set_file_header_compression(leaf, fh,
 						  compress_type);
 	} else {
 		struct folio *folio;
 
 		folio = filemap_get_folio(inode->vfs_inode.i_mapping, 0);
 		ASSERT(!IS_ERR(folio));
-		btrfs_set_file_extent_compression(leaf, ei, 0);
+		btrfs_set_file_header_compression(leaf, fh, 0);
 		kaddr = kmap_local_folio(folio, 0);
 		write_extent_buffer(leaf, kaddr, ptr, size);
 		kunmap_local(kaddr);
@@ -657,7 +656,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	drop_args.end = fs_info->sectorsize;
 	drop_args.drop_cache = true;
 	drop_args.replace_extent = true;
-	drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
+	drop_args.extent_item_size = btrfs_file_header_calc_inline_size(data_len);
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
@@ -1904,7 +1903,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	const bool is_freespace_inode = btrfs_is_free_space_inode(inode);
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_root *root = inode->root;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_root *csum_root;
 	u64 io_start;
 	u64 extent_end;
@@ -1913,8 +1912,8 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	int ret = 0;
 	bool nowait = path->nowait;
 
-	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	extent_type = btrfs_file_extent_type(leaf, fi);
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	extent_type = btrfs_file_header_type(leaf, fh);
 
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 		goto out;
@@ -1928,27 +1927,27 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 * for its subvolume was created, then this implies the extent is shared,
 	 * hence we must COW.
 	 */
-	if (btrfs_file_extent_generation(leaf, fi) <=
+	if (btrfs_file_header_generation(leaf, fh) <=
 	    btrfs_root_last_snapshot(&root->root_item))
 		goto out;
 
 	/* An explicit hole, must COW. */
-	if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0)
+	if (btrfs_file_header_disk_bytenr(leaf, fh) == 0)
 		goto out;
 
 	/* Compressed/encrypted/encoded extents must be COWed. */
-	if (btrfs_file_extent_compression(leaf, fi) ||
-	    btrfs_file_extent_encryption(leaf, fi) ||
-	    btrfs_file_extent_other_encoding(leaf, fi))
+	if (btrfs_file_header_compression(leaf, fh) ||
+	    btrfs_file_header_encryption(leaf, fh) ||
+	    btrfs_file_header_other_encoding(leaf, fh))
 		goto out;
 
 	extent_end = btrfs_file_extent_end(path);
 
-	args->file_extent.disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	args->file_extent.disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-	args->file_extent.ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
-	args->file_extent.offset = btrfs_file_extent_offset(leaf, fi);
-	args->file_extent.compression = btrfs_file_extent_compression(leaf, fi);
+	args->file_extent.disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
+	args->file_extent.disk_num_bytes = btrfs_file_header_disk_num_bytes(leaf, fh);
+	args->file_extent.ram_bytes = btrfs_file_header_ram_bytes(leaf, fh);
+	args->file_extent.offset = btrfs_file_header_offset(leaf, fh);
+	args->file_extent.compression = btrfs_file_header_compression(leaf, fh);
 
 	/*
 	 * The following checks can be expensive, as they need to take other
@@ -2129,7 +2128,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	while (cur_offset <= end) {
 		struct btrfs_block_group *nocow_bg = NULL;
 		struct btrfs_key found_key;
-		struct btrfs_file_extent_item *fi;
+		struct btrfs_file_header *fh;
 		struct extent_buffer *leaf;
 		struct extent_state *cached_state = NULL;
 		u64 extent_end;
@@ -2201,9 +2200,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 * Found extent which begins before our range and potentially
 		 * intersect it
 		 */
-		fi = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		extent_type = btrfs_file_extent_type(leaf, fi);
+		fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+		extent_type = btrfs_file_header_type(leaf, fh);
 		/* If this is triggered then we have a memory corruption. */
 		ASSERT(extent_type < BTRFS_NR_FILE_EXTENT_TYPES);
 		if (WARN_ON(extent_type >= BTRFS_NR_FILE_EXTENT_TYPES)) {
@@ -7052,7 +7050,7 @@ static struct dentry *btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 static noinline int uncompress_inline(struct btrfs_path *path,
 				      struct folio *folio,
-				      struct btrfs_file_extent_item *item)
+				      struct btrfs_file_header *header)
 {
 	int ret;
 	struct extent_buffer *leaf = path->nodes[0];
@@ -7063,13 +7061,13 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	unsigned long ptr;
 	int compress_type;
 
-	compress_type = btrfs_file_extent_compression(leaf, item);
-	max_size = btrfs_file_extent_ram_bytes(leaf, item);
-	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
+	compress_type = btrfs_file_header_compression(leaf, header);
+	max_size = btrfs_file_header_ram_bytes(leaf, header);
+	inline_size = btrfs_file_header_inline_item_len(leaf, path->slots[0]);
 	tmp = kmalloc(inline_size, GFP_NOFS);
 	if (!tmp)
 		return -ENOMEM;
-	ptr = btrfs_file_extent_inline_start(item);
+	ptr = btrfs_file_header_inline_start(header);
 
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
@@ -7094,7 +7092,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 {
 	const u32 blocksize = path->nodes[0]->fs_info->sectorsize;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	void *kaddr;
 	size_t copy_size;
 
@@ -7103,16 +7101,16 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 
 	ASSERT(folio_pos(folio) == 0);
 
-	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			    struct btrfs_file_extent_item);
-	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
-		return uncompress_inline(path, folio, fi);
+	fh = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_header);
+	if (btrfs_file_header_compression(path->nodes[0], fh) != BTRFS_COMPRESS_NONE)
+		return uncompress_inline(path, folio, fh);
 
 	copy_size = min_t(u64, blocksize,
-			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
+			  btrfs_file_header_ram_bytes(path->nodes[0], fh));
 	kaddr = kmap_local_folio(folio, 0);
 	read_extent_buffer(path->nodes[0], kaddr,
-			   btrfs_file_extent_inline_start(fi), copy_size);
+			   btrfs_file_header_inline_start(fh), copy_size);
 	kunmap_local(kaddr);
 	if (copy_size < blocksize)
 		folio_zero_range(folio, copy_size, blocksize - copy_size);
@@ -7366,7 +7364,7 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 	int ret;
 	struct extent_buffer *leaf;
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 	struct btrfs_key key;
 	int found_type;
 
@@ -7404,8 +7402,8 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 	if (btrfs_file_extent_end(path) <= offset)
 		return 0;
 
-	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	found_type = btrfs_file_extent_type(leaf, fi);
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	found_type = btrfs_file_header_type(leaf, fh);
 
 	nocow_args.start = offset;
 	nocow_args.end = offset + *len - 1;
@@ -8970,7 +8968,7 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int name_len;
 	int datasize;
 	unsigned long ptr;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	struct extent_buffer *leaf;
 
 	name_len = strlen(symname);
@@ -9020,7 +9018,7 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
-	datasize = btrfs_file_extent_calc_inline_size(name_len);
+	datasize = btrfs_file_header_calc_inline_size(name_len);
 	ret = btrfs_insert_empty_item(trans, root, path, &key, datasize);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
@@ -9030,17 +9028,17 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 	leaf = path->nodes[0];
-	ei = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, ei, trans->transid);
-	btrfs_set_file_extent_type(leaf, ei,
+	fh = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_header);
+	btrfs_set_file_header_generation(leaf, fh, trans->transid);
+	btrfs_set_file_header_type(leaf, fh,
 				   BTRFS_FILE_EXTENT_INLINE);
-	btrfs_set_file_extent_encryption(leaf, ei, 0);
-	btrfs_set_file_extent_compression(leaf, ei, 0);
-	btrfs_set_file_extent_other_encoding(leaf, ei, 0);
-	btrfs_set_file_extent_ram_bytes(leaf, ei, name_len);
+	btrfs_set_file_header_encryption(leaf, fh, 0);
+	btrfs_set_file_header_compression(leaf, fh, 0);
+	btrfs_set_file_header_other_encoding(leaf, fh, 0);
+	btrfs_set_file_header_ram_bytes(leaf, fh, name_len);
 
-	ptr = btrfs_file_extent_inline_start(ei);
+	ptr = btrfs_file_header_inline_start(fh);
 	write_extent_buffer(leaf, symname, ptr, name_len);
 	btrfs_free_path(path);
 
@@ -9392,7 +9390,7 @@ static ssize_t btrfs_encoded_read_inline(
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *item;
+	struct btrfs_file_header *header;
 	u64 ram_bytes;
 	unsigned long ptr;
 	void *tmp;
@@ -9415,22 +9413,22 @@ static ssize_t btrfs_encoded_read_inline(
 		return ret;
 	}
 	leaf = path->nodes[0];
-	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	header = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
 
-	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
-	ptr = btrfs_file_extent_inline_start(item);
+	ram_bytes = btrfs_file_header_ram_bytes(leaf, header);
+	ptr = btrfs_file_header_inline_start(header);
 
 	encoded->len = min_t(u64, extent_start + ram_bytes,
 			     inode->vfs_inode.i_size) - iocb->ki_pos;
 	ret = btrfs_encoded_io_compression_from_extent(fs_info,
-				 btrfs_file_extent_compression(leaf, item));
+				 btrfs_file_header_compression(leaf, header));
 	if (ret < 0)
 		return ret;
 	encoded->compression = ret;
 	if (encoded->compression) {
 		size_t inline_size;
 
-		inline_size = btrfs_file_extent_inline_item_len(leaf,
+		inline_size = btrfs_file_header_inline_item_len(leaf,
 								path->slots[0]);
 		if (inline_size > count)
 			return -ENOBUFS;
@@ -10303,7 +10301,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	while (prev_extent_end < isize) {
 		struct btrfs_key key;
 		struct extent_buffer *leaf;
-		struct btrfs_file_extent_item *ei;
+		struct btrfs_file_header *fh;
 		struct btrfs_block_group *bg;
 		u64 logical_block_start;
 		u64 physical_block_start;
@@ -10330,9 +10328,9 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		leaf = path->nodes[0];
-		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+		fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
 
-		if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
+		if (btrfs_file_header_type(leaf, fh) == BTRFS_FILE_EXTENT_INLINE) {
 			/*
 			 * It's unlikely we'll ever actually find ourselves
 			 * here, as a file small enough to fit inline won't be
@@ -10345,27 +10343,27 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			goto out;
 		}
 
-		if (btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
+		if (btrfs_file_header_compression(leaf, fh) != BTRFS_COMPRESS_NONE) {
 			btrfs_warn(fs_info, "swapfile must not be compressed");
 			ret = -EINVAL;
 			goto out;
 		}
 
-		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+		disk_bytenr = btrfs_file_header_disk_bytenr(leaf, fh);
 		if (disk_bytenr == 0) {
 			btrfs_warn(fs_info, "swapfile must not have holes");
 			ret = -EINVAL;
 			goto out;
 		}
 
-		logical_block_start = disk_bytenr + btrfs_file_extent_offset(leaf, ei);
-		extent_gen = btrfs_file_extent_generation(leaf, ei);
+		logical_block_start = disk_bytenr + btrfs_file_header_offset(leaf, fh);
+		extent_gen = btrfs_file_header_generation(leaf, fh);
 		prev_extent_end = btrfs_file_extent_end(path);
 
 		if (prev_extent_end > isize)
 			len = isize - key.offset;
 		else
-			len = btrfs_file_extent_num_bytes(leaf, ei);
+			len = btrfs_file_header_num_bytes(leaf, fh);
 
 		backref_ctx->curr_leaf_bytenr = leaf->start;
 
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index f189bf09ce6a..6b683580d09a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -345,30 +345,30 @@ static void print_extent_csum(const struct extent_buffer *eb, int i)
 
 static void print_file_extent_item(const struct extent_buffer *eb, int i)
 {
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_header *fh;
 
-	fi = btrfs_item_ptr(eb, i, struct btrfs_file_extent_item);
+	fh = btrfs_item_ptr(eb, i, struct btrfs_file_header);
 	pr_info("\t\tgeneration %llu type %hhu\n",
-		btrfs_file_extent_generation(eb, fi),
-		btrfs_file_extent_type(eb, fi));
+		btrfs_file_header_generation(eb, fh),
+		btrfs_file_header_type(eb, fh));
 
-	if (btrfs_file_extent_type(eb, fi) == BTRFS_FILE_EXTENT_INLINE) {
+	if (btrfs_file_header_type(eb, fh) == BTRFS_FILE_EXTENT_INLINE) {
 		pr_info("\t\tinline extent data size %u ram_bytes %llu compression %hhu\n",
-			btrfs_file_extent_inline_item_len(eb, i),
-			btrfs_file_extent_ram_bytes(eb, fi),
-			btrfs_file_extent_compression(eb, fi));
+			btrfs_file_header_inline_item_len(eb, i),
+			btrfs_file_header_ram_bytes(eb, fh),
+			btrfs_file_header_compression(eb, fh));
 		return;
 	}
 
 	pr_info("\t\textent data disk bytenr %llu nr %llu\n",
-		btrfs_file_extent_disk_bytenr(eb, fi),
-		btrfs_file_extent_disk_num_bytes(eb, fi));
+		btrfs_file_header_disk_bytenr(eb, fh),
+		btrfs_file_header_disk_num_bytes(eb, fh));
 	pr_info("\t\textent data offset %llu nr %llu ram %llu\n",
-		btrfs_file_extent_offset(eb, fi),
-		btrfs_file_extent_num_bytes(eb, fi),
-		btrfs_file_extent_ram_bytes(eb, fi));
+		btrfs_file_header_offset(eb, fh),
+		btrfs_file_header_num_bytes(eb, fh),
+		btrfs_file_header_ram_bytes(eb, fh));
 	pr_info("\t\textent compression %hhu\n",
-		btrfs_file_extent_compression(eb, fi));
+		btrfs_file_header_compression(eb, fh));
 }
 
 static void key_type_string(const struct btrfs_key *key, char *buf, int buf_size)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b5fe95baf92e..9f74d4ac920b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -62,8 +62,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const u32 block_size = fs_info->sectorsize;
 	const u64 range_end = file_offset + block_size - 1;
-	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
-	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
+	const size_t inline_size = size - btrfs_file_header_calc_inline_size(0);
+	char *data_start = inline_data + btrfs_file_header_calc_inline_size(0);
 	struct extent_changeset *data_reserved = NULL;
 	struct folio *folio = NULL;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8127a7120c2..95b8722cb76e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1708,7 +1708,7 @@ static int read_symlink(struct btrfs_root *root,
 	int ret;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u8 type;
 	u8 compression;
 	unsigned long off;
@@ -1739,9 +1739,9 @@ static int read_symlink(struct btrfs_root *root,
 		return -EIO;
 	}
 
-	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			struct btrfs_file_extent_item);
-	type = btrfs_file_extent_type(path->nodes[0], ei);
+	fh = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			struct btrfs_file_header);
+	type = btrfs_file_header_type(path->nodes[0], fh);
 	if (unlikely(type != BTRFS_FILE_EXTENT_INLINE)) {
 		ret = -EUCLEAN;
 		btrfs_crit(root->fs_info,
@@ -1749,7 +1749,7 @@ static int read_symlink(struct btrfs_root *root,
 			   ino, btrfs_root_id(root), type);
 		return ret;
 	}
-	compression = btrfs_file_extent_compression(path->nodes[0], ei);
+	compression = btrfs_file_header_compression(path->nodes[0], fh);
 	if (unlikely(compression != BTRFS_COMPRESS_NONE)) {
 		ret = -EUCLEAN;
 		btrfs_crit(root->fs_info,
@@ -1758,8 +1758,8 @@ static int read_symlink(struct btrfs_root *root,
 		return ret;
 	}
 
-	off = btrfs_file_extent_inline_start(ei);
-	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
+	off = btrfs_file_header_inline_start(fh);
+	len = btrfs_file_header_ram_bytes(path->nodes[0], fh);
 
 	return fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
 }
@@ -5481,7 +5481,7 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	struct fs_path *fspath;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *ei;
+	struct btrfs_file_header *fh;
 	u64 ram_bytes;
 	size_t inline_size;
 	int ret;
@@ -5495,9 +5495,9 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 		return ret;
 
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
-	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
+	fh = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_header);
+	ram_bytes = btrfs_file_header_ram_bytes(leaf, fh);
+	inline_size = btrfs_file_header_inline_item_len(leaf, path->slots[0]);
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fspath);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
@@ -5506,7 +5506,7 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
 	ret = btrfs_encoded_io_compression_from_extent(fs_info,
-				btrfs_file_extent_compression(leaf, ei));
+				btrfs_file_header_compression(leaf, fh));
 	if (ret < 0)
 		return ret;
 	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
@@ -5515,7 +5515,7 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 	read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
-			   btrfs_file_extent_inline_start(ei), inline_size);
+			   btrfs_file_header_inline_start(fh), inline_size);
 	sctx->send_size += inline_size;
 
 	ret = send_cmd(sctx);
@@ -5652,7 +5652,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 		 * the extent that we couldn't clone in clone_range().
 		 */
 		if (is_inline &&
-		    btrfs_file_extent_inline_item_len(leaf,
+		    btrfs_file_header_inline_item_len(leaf,
 						      path->slots[0]) <= len) {
 			return send_encoded_inline_extent(sctx, path, offset,
 							  len);
-- 
2.52.0


