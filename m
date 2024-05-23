Return-Path: <linux-btrfs+bounces-5232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB98CCB97
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231161C214BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398E13B585;
	Thu, 23 May 2024 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HEP7nKSd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HEP7nKSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778838DF2
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440645; cv=none; b=mkgDSyW3VnQvCbKL7XnX6Sbnu8EiCN3ny4GkTcGzmLBomEZx/nKLfd3SpFhzj+8oT92hLi+CnnL9hGulqhvVCGNhVmNEsVZdcv2DbbiVYNlkaI68UexwRGS3SGcq+Tto5gm506nMj0UZnzrN9VU2zyrBXNVVAPP1/8V+m/VGYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440645; c=relaxed/simple;
	bh=S9c+XLe2jWzalO4YDGOn7d9AnMz+GoiTHqGTqRV4CUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm7HjBWPy5Ely8vJdw9ck3SY10bICmDhnh7TImvbfl850J0sp4uebRd1iEjeBwTPEsPu1QpKG1U9vSjieLuoC/v0Og2xYGZnOiVfZcXUecbkE9PE+ovEM8cuG+98Y2wrsNvd3lNsDa6LT7sUlLMyTOOqIrP4MQrCByvYkcCRZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HEP7nKSd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HEP7nKSd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C24571FE8C;
	Thu, 23 May 2024 05:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wztec9NiKWsl3bFhuU5r0niJWeShIn6OTA9N3aO2Xoc=;
	b=HEP7nKSd+hbsFRh98rNrhI/I9bKWWygO9U6QC4HwSlL9Rr/qF4t1bsiRF3djQm2gV6k2lk
	Ni3NBGtWZ9e48L0X8c/Jk+y6lcgRLz1hhp2D33DJa5AYo2UBJ+q1UtdJqvip0tY6ryIgJz
	v6ZMY5g3jN7d4xqnqswb0+mE+BMiPN0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HEP7nKSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wztec9NiKWsl3bFhuU5r0niJWeShIn6OTA9N3aO2Xoc=;
	b=HEP7nKSd+hbsFRh98rNrhI/I9bKWWygO9U6QC4HwSlL9Rr/qF4t1bsiRF3djQm2gV6k2lk
	Ni3NBGtWZ9e48L0X8c/Jk+y6lcgRLz1hhp2D33DJa5AYo2UBJ+q1UtdJqvip0tY6ryIgJz
	v6ZMY5g3jN7d4xqnqswb0+mE+BMiPN0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 847D613A6B;
	Thu, 23 May 2024 05:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDhvDj/OTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 06/11] btrfs: remove extent_map::block_len member
Date: Thu, 23 May 2024 14:33:25 +0930
Message-ID: <704b7d993adba335197ae582a78dc17851ad676b.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C24571FE8C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

The extent_map::block_len is either extent_map::len (non-compressed
extent) or extent_map::disk_num_bytes (compressed extent).

Since we already have sanity checks to do the cross-check between the
new and old members, we can drop the old extent_map::block_len now.

For most call sites, they can manually select extent_map::len or
extent_map::disk_num_bytes, since most if not all of them have checked
if the extent is compressed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c            |  2 +-
 fs/btrfs/extent_map.c             | 40 +++++++++++-------------------
 fs/btrfs/extent_map.h             |  9 -------
 fs/btrfs/file-item.c              |  7 ------
 fs/btrfs/file.c                   |  1 -
 fs/btrfs/inode.c                  | 36 +++++++++------------------
 fs/btrfs/relocation.c             |  1 -
 fs/btrfs/tests/extent-map-tests.c | 41 ++++++++++---------------------
 fs/btrfs/tree-log.c               |  4 +--
 include/trace/events/btrfs.h      |  5 +---
 10 files changed, 42 insertions(+), 104 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4f6d748aa99e..cd88432e7072 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -585,7 +585,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	}
 
 	ASSERT(extent_map_is_compressed(em));
-	compressed_len = em->block_len;
+	compressed_len = em->disk_num_bytes;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
 				  end_bbio_compressed_read);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 91be54f79d21..0c100fe47c43 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -183,11 +183,18 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 	return NULL;
 }
 
+static inline u64 extent_map_block_len(const struct extent_map *em)
+{
+	if (extent_map_is_compressed(em))
+		return em->disk_num_bytes;
+	return em->len;
+}
+
 static inline u64 extent_map_block_end(const struct extent_map *em)
 {
-	if (em->block_start + em->block_len < em->block_start)
+	if (em->block_start + extent_map_block_len(em) < em->block_start)
 		return (u64)-1;
-	return em->block_start + em->block_len;
+	return em->block_start + extent_map_block_len(em);
 }
 
 static bool can_merge_extent_map(const struct extent_map *em)
@@ -288,10 +295,10 @@ static void dump_extent_map(struct btrfs_fs_info *fs_info,
 {
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
-	btrfs_crit(fs_info, "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+	btrfs_crit(fs_info, "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu flags=0x%x\n",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
 		em->ram_bytes, em->offset, em->block_start,
-		em->block_len, em->flags);
+		em->flags);
 	ASSERT(0);
 }
 
@@ -314,9 +321,6 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info,
 			if (em->block_start != em->disk_bytenr)
 				dump_extent_map(fs_info,
 				"mismatch block_start/disk_bytenr/offset", em);
-			if (em->disk_num_bytes != em->block_len)
-				dump_extent_map(fs_info,
-				"mismatch disk_num_bytes/block_len", em);
 		} else if (em->block_start != em->disk_bytenr + em->offset) {
 			dump_extent_map(fs_info,
 				"mismatch block_start/disk_bytenr/offset", em);
@@ -355,7 +359,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->len += merge->len;
-			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
 
@@ -376,7 +379,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		merge = rb_entry(rb, struct extent_map, rb_node);
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
-		em->block_len += merge->block_len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
 		validate_extent_map(fs_info, em);
@@ -670,7 +672,6 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	if (em->block_start < EXTENT_MAP_LAST_BYTE &&
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
-		em->block_len = em->len;
 		em->offset += start_diff;
 	}
 	return add_extent_mapping(inode, em, 0);
@@ -890,17 +891,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
 				split->block_start = em->block_start;
 
-				if (compressed)
-					split->block_len = em->block_len;
-				else
-					split->block_len = split->len;
 				split->disk_bytenr = em->disk_bytenr;
-				split->disk_num_bytes = max(split->block_len,
-							    em->disk_num_bytes);
+				split->disk_num_bytes = em->disk_num_bytes;
 				split->offset = em->offset;
 				split->ram_bytes = em->ram_bytes;
 			} else {
-				split->block_len = 0;
 				split->block_start = em->block_start;
 				split->disk_bytenr = em->disk_bytenr;
 				split->disk_num_bytes = 0;
@@ -930,23 +925,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->disk_num_bytes = max(em->block_len,
-							    em->disk_num_bytes);
+				split->disk_num_bytes = em->disk_num_bytes;
 				split->offset = em->offset + end - em->start;
 				split->ram_bytes = em->ram_bytes;
-				if (compressed) {
-					split->block_len = em->block_len;
-				} else {
+				if (!compressed) {
 					const u64 diff = end - em->start;
 
-					split->block_len = split->len;
 					split->block_start += diff;
 				}
 			} else {
 				split->disk_num_bytes = 0;
 				split->offset = 0;
 				split->ram_bytes = split->len;
-				split->block_len = 0;
 			}
 
 			if (extent_map_in_tree(em)) {
@@ -1104,7 +1094,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
 	split_pre->block_start = new_logical;
-	split_pre->block_len = split_pre->len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1123,7 +1112,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
 	split_mid->block_start = em->block_start + pre;
-	split_mid->block_len = split_mid->len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5ae3d56b4351..5312bb542af0 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -102,15 +102,6 @@ struct extent_map {
 	 */
 	u64 block_start;
 
-	/*
-	 * The on-disk length for the file extent.
-	 *
-	 * For compressed extents it matches btrfs_file_extent_item::disk_num_bytes.
-	 * For uncompressed extents it matches extent_map::len.
-	 * For holes and inline extents it's -1 and shouldn't be used.
-	 */
-	u64 block_len;
-
 	/*
 	 * Generation of the extent map, for merged em it's the highest
 	 * generation of all merged ems.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 06d23951901c..397df6588ce2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1307,11 +1307,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
-			em->block_len = em->disk_num_bytes;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
 			em->block_start = bytenr;
-			em->block_len = em->len;
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
@@ -1324,11 +1322,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->start = 0;
 		em->len = fs_info->sectorsize;
 		em->offset = 0;
-		/*
-		 * Initialize block_len with the same values
-		 * as in inode.c:btrfs_get_extent().
-		 */
-		em->block_len = (u64)-1;
 		extent_map_set_compression(em, compress_type);
 	} else {
 		btrfs_err(fs_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 707012fc2d43..7033ea619073 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2350,7 +2350,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 066f14c78bc9..00bb64fdf938 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,7 +139,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 block_start,
-				       u64 block_len, u64 disk_num_bytes,
+				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type);
@@ -1210,7 +1210,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
 			  ins.objectid,			/* block_start */
-			  ins.offset,			/* block_len */
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
@@ -1453,7 +1452,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  ins.objectid, /* block_start */
-				  ins.offset, /* block_len */
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
@@ -2191,7 +2189,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  nocow_args.disk_bytenr, /* block_start */
-					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  &nocow_args.file_extent,
@@ -5027,7 +5024,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
@@ -6896,7 +6892,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	em->start = EXTENT_MAP_HOLE;
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
-	em->block_len = (u64)-1;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -7054,7 +7049,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 start,
 						  const u64 len,
 						  const u64 block_start,
-						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
 						  const int type,
@@ -7065,14 +7059,14 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, block_start,
-				  block_len, orig_block_len, ram_bytes,
+				  orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
 	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
-					     block_start, block_len, 0,
+					     block_start, len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7124,7 +7118,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.objectid, ins.offset, ins.offset,
+				     ins.objectid, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     &file_extent);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7365,7 +7359,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 block_start,
-				       u64 block_len, u64 disk_num_bytes,
+				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type)
@@ -7387,16 +7381,10 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	switch (type) {
 	case BTRFS_ORDERED_PREALLOC:
-		/* Uncompressed extents. */
-		ASSERT(block_len == len);
-
 		/* We're only referring part of a larger preallocated extent. */
-		ASSERT(block_len <= ram_bytes);
+		ASSERT(len <= ram_bytes);
 		break;
 	case BTRFS_ORDERED_REGULAR:
-		/* Uncompressed extents. */
-		ASSERT(block_len == len);
-
 		/* COW results a new extent matching our file extent size. */
 		ASSERT(disk_num_bytes == len);
 		ASSERT(ram_bytes == len);
@@ -7422,7 +7410,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	em->start = start;
 	em->len = len;
-	em->block_len = block_len;
 	em->block_start = block_start;
 	em->disk_bytenr = file_extent->disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
@@ -7511,7 +7498,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      block_start,
-					      len, orig_block_len,
+					      orig_block_len,
 					      ram_bytes, type,
 					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
@@ -9654,7 +9641,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
 		em->offset = 0;
-		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
@@ -10151,12 +10137,12 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * Bail if the buffer isn't large enough to return the whole
 		 * compressed extent.
 		 */
-		if (em->block_len > count) {
+		if (em->disk_num_bytes > count) {
 			ret = -ENOBUFS;
 			goto out_em;
 		}
-		disk_io_size = em->block_len;
-		count = em->block_len;
+		disk_io_size = em->disk_num_bytes;
+		count = em->disk_num_bytes;
 		encoded->unencoded_len = em->ram_bytes;
 		encoded->unencoded_offset = iocb->ki_pos - (em->start - em->offset);
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
@@ -10404,7 +10390,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
 			  ins.objectid,
-			  ins.offset, ins.offset, ram_bytes, compression,
+			  ins.offset, ram_bytes, compression,
 			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 21061a0b2e7c..68fe52ab445d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2912,7 +2912,6 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 
 	em->start = start;
 	em->len = end + 1 - start;
-	em->block_len = em->len;
 	em->block_start = block_start;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = em->len;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 65c6921ff4a2..0dd270d6c506 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -28,9 +28,10 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 		if (refcount_read(&em->refs) != 1) {
 			ret = -EINVAL;
 			test_err(
-"em leak: em (start %llu len %llu block_start %llu block_len %llu) refs %d",
+"em leak: em (start %llu len %llu block_start %llu disk_num_bytes %llu offset %llu) refs %d",
 				 em->start, em->len, em->block_start,
-				 em->block_len, refcount_read(&em->refs));
+				 em->disk_num_bytes, em->offset,
+				 refcount_read(&em->refs));
 
 			refcount_set(&em->refs, 1);
 		}
@@ -77,7 +78,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -101,7 +101,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = SZ_16K;
 	em->len = SZ_4K;
 	em->block_start = SZ_32K; /* avoid merging */
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_32K; /* avoid merging */
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -125,7 +124,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = start;
 	em->len = len;
 	em->block_start = start;
-	em->block_len = len;
 	em->disk_bytenr = start;
 	em->disk_num_bytes = len;
 	em->ram_bytes = len;
@@ -143,11 +141,11 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 	if (em->start != 0 || extent_map_end(em) != SZ_16K ||
-	    em->block_start != 0 || em->block_len != SZ_16K) {
+	    em->block_start != 0 || em->disk_num_bytes != SZ_16K) {
 		test_err(
-"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_start %llu block_len %llu",
+"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_start %llu disk_num_bytes %llu",
 			 start, start + len, ret, em->start, em->len,
-			 em->block_start, em->block_len);
+			 em->block_start, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -182,7 +180,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = 0;
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
-	em->block_len = (u64)-1;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -206,7 +203,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -230,7 +226,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = 0;
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
-	em->block_len = (u64)-1;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -247,11 +242,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 	if (em->start != 0 || extent_map_end(em) != SZ_1K ||
-	    em->block_start != EXTENT_MAP_INLINE || em->block_len != (u64)-1) {
+	    em->block_start != EXTENT_MAP_INLINE) {
 		test_err(
-"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start %llu block_len %llu",
-			 ret, em->start, em->len, em->block_start,
-			 em->block_len);
+"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start %llu",
+			 ret, em->start, em->len, em->block_start);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -282,7 +276,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -306,7 +299,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -329,11 +321,11 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	 * em->start.
 	 */
 	if (start < em->start || start + len > extent_map_end(em) ||
-	    em->start != em->block_start || em->len != em->block_len) {
+	    em->start != em->block_start) {
 		test_err(
 "case3 [%llu %llu): ret %d em (start %llu len %llu block_start %llu block_len %llu)",
 			 start, start + len, ret, em->start, em->len,
-			 em->block_start, em->block_len);
+			 em->block_start, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -395,7 +387,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_8K;
 	em->block_start = 0;
-	em->block_len = SZ_8K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_8K;
 	em->ram_bytes = SZ_8K;
@@ -419,7 +410,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = SZ_8K;
 	em->len = 24 * SZ_1K;
 	em->block_start = SZ_16K; /* avoid merging */
-	em->block_len = 24 * SZ_1K;
 	em->disk_bytenr = SZ_16K; /* avoid merging */
 	em->disk_num_bytes = 24 * SZ_1K;
 	em->ram_bytes = 24 * SZ_1K;
@@ -442,7 +432,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_32K;
 	em->block_start = 0;
-	em->block_len = SZ_32K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_32K;
 	em->ram_bytes = SZ_32K;
@@ -462,9 +451,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	if (start < em->start || start + len > extent_map_end(em)) {
 		test_err(
-"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_start %llu block_len %llu)",
+"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_start %llu disk_num_bytes %llu)",
 			 start, start + len, ret, em->start, em->len, em->block_start,
-			 em->block_len);
+			 em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -529,7 +518,6 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	em->start = start;
 	em->len = len;
 	em->block_start = block_start;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = len;
@@ -753,7 +741,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_16K;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = SZ_16K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -809,7 +796,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_16K;
@@ -834,7 +820,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->start = SZ_32K;
 	em->len = SZ_16K;
 	em->block_start = SZ_32K;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = SZ_32K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d6a3151d6c37..1d04f0cb6f53 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4651,7 +4651,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->disk_num_bytes);
+		csum_len = em->disk_num_bytes;
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4701,7 +4701,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->disk_num_bytes);
+	block_len = em->disk_num_bytes;
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index cbac7cd11995..a1804239812c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -292,7 +292,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__field(	u64,  start		)
 		__field(	u64,  len		)
 		__field(	u64,  block_start	)
-		__field(	u64,  block_len		)
 		__field(	u32,  flags		)
 		__field(	int,  refs		)
 	),
@@ -303,19 +302,17 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__entry->start		= map->start;
 		__entry->len		= map->len;
 		__entry->block_start	= map->block_start;
-		__entry->block_len	= map->block_len;
 		__entry->flags		= map->flags;
 		__entry->refs		= refcount_read(&map->refs);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu "
-		  "block_start=%llu(%s) block_len=%llu flags=%s refs=%u",
+		  "block_start=%llu(%s) flags=%s refs=%u",
 		  show_root_type(__entry->root_objectid),
 		  __entry->ino,
 		  __entry->start,
 		  __entry->len,
 		  show_map_type(__entry->block_start),
-		  __entry->block_len,
 		  show_map_flags(__entry->flags),
 		  __entry->refs)
 );
-- 
2.45.1


