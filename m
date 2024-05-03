Return-Path: <linux-btrfs+bounces-4707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB288BA6D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AB81F2278D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C911139D07;
	Fri,  3 May 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="umsp+Nry";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="umsp+Nry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF413A263
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716143; cv=none; b=AOANZSr5XFdvYgxSOmJ9/RfRmQUFX8WckAozuLX7z+r0nfBnIAp4S31Y4HOjCsfJW6pWsBMGMTwczxIexLSGXmkQuYwSgXZ04/Q1oj8M/ZYhH46Yh5s3jK96Vhs0WLU+2qUkh/RFua+hU8A0MVP8hQjC722W9+XLQqbhX+365eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716143; c=relaxed/simple;
	bh=WkjPy2b4IL2e7yEqb92eIQmZcEfx/JTd8JN7XNGBQQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3tF64u5KFw1kft2R6z59mLuRM2HjZaesgSjOem8+aoptgkSLqvjbB6Kh63FJSBMEFjYFnlOQRsah4aaFlSPGTxbIWOIizrxMI231HXXzOvuncLa6i8IW03FKHj6pMo2lxU9Dcx0lZv6NaiJ+lgfKrKlL71tENOeTZjMqhqpffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=umsp+Nry; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=umsp+Nry; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0DA22886
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skY3q60dS9xqyQPozgd9erlcpfxOv+vWKRLSlPhB23M=;
	b=umsp+NrysM7VznGs5/ug7l9IgIrx2mZVcm3BXnQ+95XuBAzwOapvgunkboTdE/WJIrJkNJ
	8DGFq1Way3q+uniyx8s0iyAfGhQdzAvjWBgrD2j5eCmAmGvB7i1JKVw82AyfzLwsWdVYaC
	N8YTy+nQw/U6SkM5kJL8v7SB7G6VvR0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=umsp+Nry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skY3q60dS9xqyQPozgd9erlcpfxOv+vWKRLSlPhB23M=;
	b=umsp+NrysM7VznGs5/ug7l9IgIrx2mZVcm3BXnQ+95XuBAzwOapvgunkboTdE/WJIrJkNJ
	8DGFq1Way3q+uniyx8s0iyAfGhQdzAvjWBgrD2j5eCmAmGvB7i1JKVw82AyfzLwsWdVYaC
	N8YTy+nQw/U6SkM5kJL8v7SB7G6VvR0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AA5813991
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDvFL+p9NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 06:02:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/11] btrfs: cleanup duplicated parameters related to can_nocow_file_extent_args
Date: Fri,  3 May 2024 15:31:43 +0930
Message-ID: <5f31db841be606ec0bf8693377647f572ac9f4e7.1714707707.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0F0DA22886
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]

The following functions and structures can be simplified using the
btrfs_file_extent structure:

- can_nocow_extent()
  No need to return ram_bytes/orig_block_len through the parameter list,
  the @file_extent parameter contains all needed info.

- can_nocow_file_extent_args
  The following members are no longer needed:

  * disk_bytenr
    This one is confusing as it's not really the
    btrfs_file_extent_item::disk_bytenr, but where the IO would be,
    thus it's file_extent::disk_bytenr + file_extent::offset now.

  * num_bytes
    Now file_extent::num_bytes.

  * extent_offset
    Now file_extent::offset.

  * disk_num_bytes
    Now file_extent::disk_num_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  3 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 89 +++++++++++++++++++-----------------------
 3 files changed, 42 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f30afce4f6ca..bea343615ad1 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -461,8 +461,7 @@ struct btrfs_file_extent {
 };
 
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_block_len,
-			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict);
 
 void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 102b5c17ece1..6aaeb9ee048d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, NULL, nowait, false);
+			       NULL, nowait, false);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bc1f165193a..89f284ae26a4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1862,16 +1862,10 @@ struct can_nocow_file_extent_args {
 	 */
 	bool free_path;
 
-	/* Output fields. Only set when can_nocow_file_extent() returns 1. */
-
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-	u64 extent_offset;
-
-	/* Number of bytes that can be written to in NOCOW mode. */
-	u64 num_bytes;
-
-	/* The expected file extent for the NOCOW write. */
+	/*
+	 * Output fields. Only set when can_nocow_file_extent() returns 1.
+	 * The expected file extent for the NOCOW write.
+	 */
 	struct btrfs_file_extent file_extent;
 };
 
@@ -1894,6 +1888,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_root *csum_root;
+	u64 io_start;
 	u64 extent_end;
 	u8 extent_type;
 	int can_nocow = 0;
@@ -1906,11 +1901,6 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 		goto out;
 
-	/* Can't access these fields unless we know it's not an inline extent. */
-	args->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	args->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-	args->extent_offset = btrfs_file_extent_offset(leaf, fi);
-
 	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
 	    extent_type == BTRFS_FILE_EXTENT_REG)
 		goto out;
@@ -1926,7 +1916,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		goto out;
 
 	/* An explicit hole, must COW. */
-	if (args->disk_bytenr == 0)
+	if (btrfs_file_extent_disk_num_bytes(leaf, fi) == 0)
 		goto out;
 
 	/* Compressed/encrypted/encoded extents must be COWed. */
@@ -1951,8 +1941,8 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	btrfs_release_path(path);
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
-				    key->offset - args->extent_offset,
-				    args->disk_bytenr, args->strict, path);
+				    key->offset - args->file_extent.offset,
+				    args->file_extent.disk_bytenr, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
@@ -1973,21 +1963,18 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	    atomic_read(&root->snapshot_force_cow))
 		goto out;
 
-	args->disk_bytenr += args->extent_offset;
-	args->disk_bytenr += args->start - key->offset;
-	args->num_bytes = min(args->end + 1, extent_end) - args->start;
-
-	args->file_extent.num_bytes = args->num_bytes;
+	args->file_extent.num_bytes = min(args->end + 1, extent_end) - args->start;
 	args->file_extent.offset += args->start - key->offset;
+	io_start = args->file_extent.disk_bytenr + args->file_extent.offset;
 
 	/*
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
 	 */
 
-	csum_root = btrfs_csum_root(root->fs_info, args->disk_bytenr);
-	ret = btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
-				      args->disk_bytenr + args->num_bytes - 1,
+	csum_root = btrfs_csum_root(root->fs_info, io_start);
+	ret = btrfs_lookup_csums_list(csum_root, io_start,
+				      io_start + args->file_extent.num_bytes - 1,
 				      NULL, nowait);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
@@ -2046,7 +2033,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct extent_buffer *leaf;
 		struct extent_state *cached_state = NULL;
 		u64 extent_end;
-		u64 ram_bytes;
 		u64 nocow_end;
 		int extent_type;
 		bool is_prealloc;
@@ -2125,7 +2111,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			ret = -EUCLEAN;
 			goto error;
 		}
-		ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 		extent_end = btrfs_file_extent_end(path);
 
 		/*
@@ -2145,7 +2130,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			goto must_cow;
 
 		ret = 0;
-		nocow_bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		nocow_bg = btrfs_inc_nocow_writers(fs_info,
+				nocow_args.file_extent.disk_bytenr +
+				nocow_args.file_extent.offset);
 		if (!nocow_bg) {
 must_cow:
 			/*
@@ -2181,16 +2168,18 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		}
 
-		nocow_end = cur_offset + nocow_args.num_bytes - 1;
+		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
 		lock_extent(&inode->io_tree, cur_offset, nocow_end, &cached_state);
 
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  nocow_args.disk_num_bytes, /* orig_block_len */
-					  ram_bytes, BTRFS_COMPRESS_NONE,
+			em = create_io_em(inode, cur_offset,
+					  nocow_args.file_extent.num_bytes,
+					  nocow_args.file_extent.disk_num_bytes,
+					  nocow_args.file_extent.ram_bytes,
+					  BTRFS_COMPRESS_NONE,
 					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
@@ -2203,9 +2192,16 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
+		/*
+		 * Check btrfs_create_dio_extent() for why we intentionally pass
+		 * incorrect value for NOCOW/PREALLOC OEs.
+		 */
 		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
-				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+				nocow_args.file_extent.num_bytes,
+				nocow_args.file_extent.num_bytes,
+				nocow_args.file_extent.disk_bytenr +
+				nocow_args.file_extent.offset,
+				nocow_args.file_extent.num_bytes, 0,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
@@ -7144,8 +7140,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_block_len,
-			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -7196,8 +7191,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	found_type = btrfs_file_extent_type(leaf, fi);
-	if (ram_bytes)
-		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 
 	nocow_args.start = offset;
 	nocow_args.end = offset + *len - 1;
@@ -7215,14 +7208,15 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	}
 
 	ret = 0;
-	if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
+	if (btrfs_extent_readonly(fs_info,
+				nocow_args.file_extent.disk_bytenr + nocow_args.file_extent.offset))
 		goto out;
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		u64 range_end;
 
-		range_end = round_up(offset + nocow_args.num_bytes,
+		range_end = round_up(offset + nocow_args.file_extent.num_bytes,
 				     root->fs_info->sectorsize) - 1;
 		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
 		if (ret) {
@@ -7231,13 +7225,11 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	if (orig_block_len)
-		*orig_block_len = nocow_args.disk_num_bytes;
 	if (file_extent)
 		memcpy(file_extent, &nocow_args.file_extent,
 		       sizeof(struct btrfs_file_extent));
 
-	*len = nocow_args.num_bytes;
+	*len = nocow_args.file_extent.num_bytes;
 	ret = 1;
 out:
 	btrfs_free_path(path);
@@ -7422,7 +7414,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em = *map;
 	int type;
-	u64 block_start, orig_block_len, ram_bytes;
+	u64 block_start;
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
@@ -7450,7 +7442,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = extent_map_block_start(em) + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len,
-				     &orig_block_len, &ram_bytes,
 				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
@@ -7477,8 +7468,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		space_reserved = true;
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_block_len,
-					      ram_bytes, type,
+					      file_extent.disk_num_bytes,
+					      file_extent.ram_bytes, type,
 					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
@@ -10709,7 +10700,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.45.0


