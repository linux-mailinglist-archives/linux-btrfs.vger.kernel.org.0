Return-Path: <linux-btrfs+bounces-4644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE998B65AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110B62834DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD95199E9D;
	Mon, 29 Apr 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dHipAtgG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dHipAtgG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27D199E96
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429429; cv=none; b=i3sdRd7BVJHUDYYmfkGo2MGSyrLnK4yixPlIKnuWph2NblaHYDxawXOKzfeAZYqdNVl69Vac8PLcDC4KM9upYVZalfECw/dCzjudiLLcXPRIUbG3y7TrNpRg/xXRa/NAxnY7NvD/iXksLFqoIJJsGqzoNrSa+306TzXS+Yx0YMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429429; c=relaxed/simple;
	bh=YQLHcQmNFEnbQN7DVs0aqb/QeheFpURrMMqEyPTO3Ag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSq6uXY2kPSIa3CZsa4cRiks+D862kPHiHAiY5QtaZy6cMK5uceZnaCObxhiGxcZKBcSf2z3FIbRe6sXBNAQnTUMle1O+gCeSuAyxoW3PC+bRG0HhxfN+MIRMBUazjId1vUn7xbBMAkrINqZweesqFc2r4NRHXzgLwYFtCfdpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dHipAtgG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dHipAtgG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1211233B64
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bACQOIrXIEf0IDJ29gEenMxS5LLE/NG095zhE6V1ygQ=;
	b=dHipAtgGVqaWewAxUBQz8R1da4Rmv6QuEdFombixsTd1otV4DaQn5KWSfhPNaxzkYgA7OG
	Xa7EiMZWtzQjnNYaYRNo11P424tllf8UtvsYOvfDuoPYD/ZKNmhq26cfjFQ/KrpPldbAFH
	Eb6OSvT3+ZIEG40b3PNmkZl2mUjFnHI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bACQOIrXIEf0IDJ29gEenMxS5LLE/NG095zhE6V1ygQ=;
	b=dHipAtgGVqaWewAxUBQz8R1da4Rmv6QuEdFombixsTd1otV4DaQn5KWSfhPNaxzkYgA7OG
	Xa7EiMZWtzQjnNYaYRNo11P424tllf8UtvsYOvfDuoPYD/ZKNmhq26cfjFQ/KrpPldbAFH
	Eb6OSvT3+ZIEG40b3PNmkZl2mUjFnHI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38E9139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJJiJe8dMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: remove parameters duplicated from btrfs_file_extent
Date: Tue, 30 Apr 2024 07:53:07 +0930
Message-ID: <61a7e583dd76123ba2649039f0ae4d100f9b3d00.1714428940.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714428940.git.wqu@suse.com>
References: <cover.1714428940.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

The following functions are using parameters which can fetch from
structure btrfs_file_extent:

- create_io_em()
- btrfs_create_dio_extent()
- can_nocow_extent()
- btrfs_alloc_ordered_extent()
- struct can_nocow_file_extent_args

Also to do the cleanup, the function btrfs_alloc_ordered_extent() from
ordered-data.[ch] needs to have the btrfs_file_extent declaration.

Thankfully btrfs_inode.h would include ordered-data.h, so move the
declaration of btrfs_file_extent to ordered-data.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h  |  19 +----
 fs/btrfs/file.c         |   2 +-
 fs/btrfs/inode.c        | 174 ++++++++++++++--------------------------
 fs/btrfs/ordered-data.c |  20 +++--
 fs/btrfs/ordered-data.h |  22 ++++-
 5 files changed, 95 insertions(+), 142 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f30afce4f6ca..a673dbe5a7d7 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -444,25 +444,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 
-/*
- * A more access-friendly representation of btrfs_file_extent_item.
- *
- * Unused members are excluded.
- */
-struct btrfs_file_extent {
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-
-	u64 num_bytes;
-	u64 ram_bytes;
-	u64 offset;
-
-	u8 compression;
-};
-
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
index d74249b70541..775a9ef82377 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -138,9 +138,6 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len,
-				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type);
 
@@ -1167,12 +1164,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	file_extent.offset = 0;
 	file_extent.compression = async_extent->compress_type;
 
-	em = create_io_em(inode, start,
-			  async_extent->ram_size,	/* len */
-			  ins.offset,			/* orig_block_len */
-			  async_extent->ram_size,	/* ram_bytes */
-			  async_extent->compress_type,
-			  &file_extent,
+	em = create_io_em(inode, start, &file_extent,
 			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -1180,14 +1172,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
-				       async_extent->ram_size,	/* num_bytes */
-				       async_extent->ram_size,	/* ram_bytes */
-				       ins.objectid,		/* disk_bytenr */
-				       ins.offset,		/* disk_num_bytes */
-				       0,			/* offset */
-				       1 << BTRFS_ORDERED_COMPRESSED,
-				       async_extent->compress_type);
+	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
+				       1 << BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1435,11 +1421,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.ram_bytes = ins.offset;
 		file_extent.offset = 0;
 		file_extent.compression = BTRFS_COMPRESS_NONE;
-		em = create_io_em(inode, start, ins.offset, /* len */
-				  ins.offset, /* orig_block_len */
-				  ram_size, /* ram_bytes */
-				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  &file_extent,
+		em = create_io_em(inode, start, &file_extent,
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
@@ -1447,10 +1429,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, start, ram_size,
-					ram_size, ins.objectid, cur_alloc_size,
-					0, 1 << BTRFS_ORDERED_REGULAR,
-					BTRFS_COMPRESS_NONE);
+		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
+					1 << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
@@ -1835,13 +1815,11 @@ struct can_nocow_file_extent_args {
 	 */
 	bool free_path;
 
-	/* Output fields. Only set when can_nocow_file_extent() returns 1. */
-
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-	u64 extent_offset;
-
-	/* Number of bytes that can be written to in NOCOW mode. */
+	/*
+	 * Output fields. Only set when can_nocow_file_extent() returns 1.
+	 *
+	 * Number of bytes that can be written to in NOCOW mode.
+	 */
 	u64 num_bytes;
 
 	/* The expected file extent for the NOCOW write. */
@@ -1867,6 +1845,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_root *csum_root;
+	u64 block_start;
 	u64 extent_end;
 	u8 extent_type;
 	int can_nocow = 0;
@@ -1880,9 +1859,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		goto out;
 
 	/* Can't access these fields unless we know it's not an inline extent. */
-	args->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	args->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-	args->extent_offset = btrfs_file_extent_offset(leaf, fi);
+	args->file_extent.disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 
 	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
 	    extent_type == BTRFS_FILE_EXTENT_REG)
@@ -1899,7 +1876,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		goto out;
 
 	/* An explicit hole, must COW. */
-	if (args->disk_bytenr == 0)
+	if (args->file_extent.disk_bytenr == 0)
 		goto out;
 
 	/* Compressed/encrypted/encoded extents must be COWed. */
@@ -1910,7 +1887,6 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
 	extent_end = btrfs_file_extent_end(path);
 
-	args->file_extent.disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 	args->file_extent.disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 	args->file_extent.ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	args->file_extent.offset = btrfs_file_extent_offset(leaf, fi);
@@ -1924,8 +1900,8 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	btrfs_release_path(path);
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
-				    key->offset - args->extent_offset,
-				    args->disk_bytenr, args->strict, path);
+				    key->offset - args->file_extent.offset,
+				    args->file_extent.disk_bytenr, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
@@ -1946,8 +1922,6 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	    atomic_read(&root->snapshot_force_cow))
 		goto out;
 
-	args->disk_bytenr += args->extent_offset;
-	args->disk_bytenr += args->start - key->offset;
 	args->num_bytes = min(args->end + 1, extent_end) - args->start;
 
 	args->file_extent.num_bytes = args->num_bytes;
@@ -1957,10 +1931,11 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
 	 */
+	block_start = args->file_extent.disk_bytenr + args->file_extent.num_bytes;
 
-	csum_root = btrfs_csum_root(root->fs_info, args->disk_bytenr);
-	ret = btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
-				      args->disk_bytenr + args->num_bytes - 1,
+	csum_root = btrfs_csum_root(root->fs_info, block_start);
+	ret = btrfs_lookup_csums_list(csum_root, block_start,
+				      block_start + args->num_bytes - 1,
 				      NULL, nowait);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
@@ -2018,7 +1993,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
 		u64 extent_end;
-		u64 ram_bytes;
 		u64 nocow_end;
 		int extent_type;
 		bool is_prealloc;
@@ -2097,7 +2071,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			ret = -EUCLEAN;
 			goto error;
 		}
-		ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 		extent_end = btrfs_file_extent_end(path);
 
 		/*
@@ -2117,7 +2090,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			goto must_cow;
 
 		ret = 0;
-		nocow_bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		nocow_bg = btrfs_inc_nocow_writers(fs_info,
+				nocow_args.file_extent.disk_bytenr);
 		if (!nocow_bg) {
 must_cow:
 			/*
@@ -2158,9 +2132,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (is_prealloc) {
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  nocow_args.disk_num_bytes, /* orig_block_len */
-					  ram_bytes, BTRFS_COMPRESS_NONE,
+			em = create_io_em(inode, cur_offset,
 					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
@@ -2172,12 +2144,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
-				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
-				is_prealloc
-				? (1 << BTRFS_ORDERED_PREALLOC)
-				: (1 << BTRFS_ORDERED_NOCOW),
-				BTRFS_COMPRESS_NONE);
+				&nocow_args.file_extent,
+				is_prealloc ? (1 << BTRFS_ORDERED_PREALLOC) :
+				(1 << BTRFS_ORDERED_NOCOW));
 		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
@@ -6965,19 +6934,15 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
-						  const u64 len,
-						  const u64 orig_block_len,
-						  const u64 ram_bytes,
-						  const int type,
-						  struct btrfs_file_extent *file_extent)
+						  struct btrfs_file_extent *file_extent,
+						  const int type)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent tmp = { 0 };
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len,
-				  orig_block_len, ram_bytes,
-				  BTRFS_COMPRESS_NONE, /* compress_type */
+		em = create_io_em(inode, start,
 				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
@@ -7003,18 +6968,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	 * routine to handle NOCOW/PREALLOC splits, meanwhile result nothing
 	 * different.
 	 */
-	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
-					     file_extent->disk_bytenr +
-					     file_extent->offset,
-					     len, 0,
+	tmp.disk_bytenr = file_extent->disk_bytenr + file_extent->offset;
+	tmp.disk_num_bytes = file_extent->num_bytes;
+	tmp.num_bytes = file_extent->num_bytes;
+	tmp.ram_bytes = file_extent->num_bytes;
+	tmp.offset = 0;
+	tmp.compression = file_extent->compression;
+	ordered = btrfs_alloc_ordered_extent(inode, start,
+					     &tmp,
 					     (1 << type) |
-					     (1 << BTRFS_ORDERED_DIRECT),
-					     BTRFS_COMPRESS_NONE);
+					     (1 << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
 			free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
-						    start + len - 1, false);
+				start + file_extent->num_bytes - 1, false);
 		}
 		em = ERR_CAST(ordered);
 	} else {
@@ -7057,10 +7025,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.ram_bytes = ins.offset;
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR,
-				     &file_extent);
+	em = btrfs_create_dio_extent(inode, dio_data, start,
+				     &file_extent, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7088,9 +7054,6 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  * @offset:	File offset
  * @len:	The length to write, will be updated to the nocow writeable
  *		range
- * @orig_start:	(optional) Return the original file offset of the file extent
- * @orig_len:	(optional) Return the original on-disk length of the file extent
- * @ram_bytes:	(optional) Return the ram_bytes of the file extent
  * @strict:	if true, omit optimizations that might force us into unnecessary
  *		cow. e.g., don't trust generation number.
  *
@@ -7103,8 +7066,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_block_len,
-			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -7155,8 +7117,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	found_type = btrfs_file_extent_type(leaf, fi);
-	if (ram_bytes)
-		*ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 
 	nocow_args.start = offset;
 	nocow_args.end = offset + *len - 1;
@@ -7174,7 +7134,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	}
 
 	ret = 0;
-	if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
+	if (btrfs_extent_readonly(fs_info, nocow_args.file_extent.disk_bytenr))
 		goto out;
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
@@ -7190,8 +7150,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	if (orig_block_len)
-		*orig_block_len = nocow_args.disk_num_bytes;
 	if (file_extent)
 		memcpy(file_extent, &nocow_args.file_extent,
 		       sizeof(struct btrfs_file_extent));
@@ -7298,9 +7256,6 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len,
-				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
@@ -7322,25 +7277,25 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	switch (type) {
 	case BTRFS_ORDERED_PREALLOC:
 		/* We're only referring part of a larger preallocated extent. */
-		ASSERT(len <= ram_bytes);
+		ASSERT(file_extent->num_bytes <= file_extent->ram_bytes);
 		break;
 	case BTRFS_ORDERED_REGULAR:
 		/* COW results a new extent matching our file extent size. */
-		ASSERT(disk_num_bytes == len);
-		ASSERT(ram_bytes == len);
+		ASSERT(file_extent->disk_num_bytes == file_extent->num_bytes);
+		ASSERT(file_extent->ram_bytes == file_extent->num_bytes);
 
 		/* Since it's a new extent, we should not have any offset. */
 		ASSERT(file_extent->offset == 0);
 		break;
 	case BTRFS_ORDERED_COMPRESSED:
 		/* Must be compressed. */
-		ASSERT(compress_type != BTRFS_COMPRESS_NONE);
+		ASSERT(file_extent->compression != BTRFS_COMPRESS_NONE);
 
 		/*
 		 * Encoded write can make us to refer to part of the
 		 * uncompressed extent.
 		 */
-		ASSERT(len <= ram_bytes);
+		ASSERT(file_extent->num_bytes <= file_extent->ram_bytes);
 		break;
 	}
 
@@ -7349,15 +7304,15 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		return ERR_PTR(-ENOMEM);
 
 	em->start = start;
-	em->len = len;
+	em->len = file_extent->num_bytes;
 	em->disk_bytenr = file_extent->disk_bytenr;
-	em->disk_num_bytes = disk_num_bytes;
-	em->ram_bytes = ram_bytes;
+	em->disk_num_bytes = file_extent->disk_num_bytes;
+	em->ram_bytes = file_extent->ram_bytes;
 	em->generation = -1;
 	em->offset = file_extent->offset;
 	em->flags |= EXTENT_FLAG_PINNED;
 	if (type == BTRFS_ORDERED_COMPRESSED)
-		extent_map_set_compression(em, compress_type);
+		extent_map_set_compression(em, file_extent->compression);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -7381,7 +7336,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em = *map;
 	int type;
-	u64 block_start, orig_block_len, ram_bytes;
+	u64 block_start;
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
@@ -7409,7 +7364,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = extent_map_block_start(em) + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len,
-				     &orig_block_len, &ram_bytes,
 				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
@@ -7435,10 +7389,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_block_len,
-					      ram_bytes, type,
-					      &file_extent);
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
+					      &file_extent, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -10334,21 +10286,17 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.ram_bytes = ram_bytes;
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
-	em = create_io_em(inode, start, num_bytes,
-			  ins.offset, ram_bytes, compression,
-			  &file_extent, BTRFS_ORDERED_COMPRESSED);
+	em = create_io_em(inode, start, &file_extent,
+			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start, num_bytes, ram_bytes,
-				       ins.objectid, ins.offset,
-				       encoded->unencoded_offset,
+	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 				       (1 << BTRFS_ORDERED_ENCODED) |
-				       (1 << BTRFS_ORDERED_COMPRESSED),
-				       compression);
+				       (1 << BTRFS_ORDERED_COMPRESSED));
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -10666,7 +10614,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 03b2f646b2f9..5a7fee6fb051 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -247,12 +247,15 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  *
  * @inode:           Inode that this extent is for.
  * @file_offset:     Logical offset in file where the extent starts.
+ * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ *
+ * The following members are from @file_extent:
+ *
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
  * @disk_bytenr:     Offset of extent on disk.
  * @disk_num_bytes:  Size of extent on disk.
  * @offset:          Offset into unencoded data where file data starts.
- * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
@@ -263,17 +266,20 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  */
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type)
+			struct btrfs_file_extent *file_extent,
+			unsigned long flags)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
-	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
-				     disk_bytenr, disk_num_bytes, offset, flags,
-				     compress_type);
+	entry = alloc_ordered_extent(inode, file_offset,
+				     file_extent->num_bytes,
+				     file_extent->ram_bytes,
+				     file_extent->disk_bytenr,
+				     file_extent->disk_num_bytes,
+				     file_extent->offset, flags,
+				     file_extent->compression);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
 	return entry;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 34413fc5b4bd..b89b5f6ae088 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -171,11 +171,27 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+
+/*
+ * A more access-friendly representation of btrfs_file_extent_item.
+ *
+ * Unused members are excluded.
+ */
+struct btrfs_file_extent {
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+
+	u64 num_bytes;
+	u64 ram_bytes;
+	u64 offset;
+
+	u8 compression;
+};
+
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type);
+			struct btrfs_file_extent *file_extent,
+			unsigned long flags);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.44.0


