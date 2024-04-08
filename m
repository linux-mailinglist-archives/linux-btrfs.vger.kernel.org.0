Return-Path: <linux-btrfs+bounces-4034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC389CE77
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022D71C21B8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C981148FFB;
	Mon,  8 Apr 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UFqmZNFi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UFqmZNFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB187C6D4
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615652; cv=none; b=RqOrvU01h4G8ZF21E1Ca7ZwxwJfNoOiOP2z7m5cmSXGicb3uKgnek+txsVekyQfUlB+C0KQmWRvG6DTsChbEydHd7htG9mhf0ELawA5GZSW3b7Vf27XBIA10el6otHASYIIjWBwCcUClWRIrq+SahTeb2GhcLm8MYHO9htYXmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615652; c=relaxed/simple;
	bh=szCR352KJ4B3Uixs5g72TfzNqcxxfdSRjiZ7NXv8fpI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUQiRu93N2ipNQsOu+vESeym+hpIG13j9QdKa6YDVO4GU9KREbwY9JpXm5KbWpxLdg66Yh0iv6GGp1h7u4+A2WV5VQOljGZbO22bdy60qjTCKvsRindqiNEIm250EPooYT2JhfLHzGvJ4ozGqgKqx1IjoYdvqu0CEytPqJfqOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UFqmZNFi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UFqmZNFi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 203AB22DBE
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+sS/GgTZUvGB03IlH8SPQoEodmqeyPxm2P9KLf4fBo=;
	b=UFqmZNFiu6Wuu2b6MZ7Hq8NfJrn9Em6HwcVFYr0gPOceDDLDyefe0uDPn0EQ1Z7jsf+G1X
	H7VIP5vLiUPo2fc/Juaw0LTkBH24iIbUtgk2q4PIGiCuMPt+fHS3EQ3u8wddX/a8bwYZn1
	lv3Q/0XeVGQ1+jzYCIDqBWivPC6GfIg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UFqmZNFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+sS/GgTZUvGB03IlH8SPQoEodmqeyPxm2P9KLf4fBo=;
	b=UFqmZNFiu6Wuu2b6MZ7Hq8NfJrn9Em6HwcVFYr0gPOceDDLDyefe0uDPn0EQ1Z7jsf+G1X
	H7VIP5vLiUPo2fc/Juaw0LTkBH24iIbUtgk2q4PIGiCuMPt+fHS3EQ3u8wddX/a8bwYZn1
	lv3Q/0XeVGQ1+jzYCIDqBWivPC6GfIg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 51C971332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qFR2Bd9wFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:34:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 6/8] btrfs: remove extent_map::block_len member
Date: Tue,  9 Apr 2024 08:03:45 +0930
Message-ID: <413140eb6558f2cabd6b6258ee6b8748db1e6d06.1712614770.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712614770.git.wqu@suse.com>
References: <cover.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 203AB22DBE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

The extent_map::block_len is either extent_map::len (non-compressed
extent) or extent_map::disk_num_bytes (compressed extent).

Since we already have sanity checks to do the cross-check between the
new and old members, we can drop the old extent_map::block_len now.

For most call sites, they can manually select extent_map::len or
extent_map::disk_num_bytes, since most if not all of them have checked
if the extent is compressed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c            |  2 +-
 fs/btrfs/extent_map.c             | 41 +++++++++++--------------------
 fs/btrfs/extent_map.h             |  9 -------
 fs/btrfs/file-item.c              |  7 ------
 fs/btrfs/file.c                   |  1 -
 fs/btrfs/inode.c                  | 36 +++++++++------------------
 fs/btrfs/relocation.c             |  1 -
 fs/btrfs/tests/extent-map-tests.c | 41 ++++++++++---------------------
 fs/btrfs/tree-log.c               |  4 +--
 include/trace/events/btrfs.h      |  5 +---
 10 files changed, 42 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 24993be16333..0a97a0e39731 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -585,7 +585,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	}
 
 	ASSERT(extent_map_is_compressed(em));
-	compressed_len = em->block_len;
+	compressed_len = em->disk_num_bytes;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
 				  end_bbio_comprssed_read);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 03d1d791bdca..932f5cb791b0 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -177,11 +177,18 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
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
@@ -279,10 +286,10 @@ static void dump_extent_map(const char *prefix, struct extent_map *em)
 {
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
-	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu flags=0x%x\n",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
 		em->ram_bytes, em->offset, em->block_start,
-		em->block_len, em->flags);
+		em->flags);
 	ASSERT(0);
 }
 
@@ -304,9 +311,6 @@ static void validate_extent_map(struct extent_map *em)
 			if (em->block_start != em->disk_bytenr)
 				dump_extent_map(
 				"mismatch block_start/disk_bytenr/offset", em);
-			if (em->disk_num_bytes != em->block_len)
-				dump_extent_map(
-				"mismatch disk_num_bytes/block_len", em);
 		} else {
 			if (em->block_start != em->disk_bytenr + em->offset)
 				dump_extent_map(
@@ -344,7 +348,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->len += merge->len;
-			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
 
@@ -364,7 +367,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		merge = rb_entry(rb, struct extent_map, rb_node);
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
-		em->block_len += merge->block_len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
 		validate_extent_map(em);
@@ -645,7 +647,6 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 	if (em->block_start < EXTENT_MAP_LAST_BYTE &&
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
-		em->block_len = em->len;
 		em->offset += start_diff;
 	}
 	return add_extent_mapping(em_tree, em, 0);
@@ -860,17 +861,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -900,23 +895,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -1076,8 +1066,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
 	split_pre->block_start = new_logical;
-	split_pre->block_len = split_pre->len;
-	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1096,7 +1084,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
 	split_mid->block_start = em->block_start + pre;
-	split_mid->block_len = split_mid->len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 31a39751429e..bb7681bb7dba 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -99,15 +99,6 @@ struct extent_map {
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
index 70698ff04200..fd1e0e431e76 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1292,11 +1292,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
@@ -1309,11 +1307,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
index a90b9e1aa982..cbb0263f5a18 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2161,7 +2161,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24c11a1f1a93..7dbc0c163316 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,7 +139,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 block_start,
-				       u64 block_len, u64 disk_num_bytes,
+				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type, u64 disk_bytenr, u64 offset);
 
@@ -1161,7 +1161,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
 			  ins.objectid,			/* block_start */
-			  ins.offset,			/* block_len */
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
@@ -1424,7 +1423,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		ram_size = ins.offset;
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  ins.objectid, /* block_start */
-				  ins.offset, /* block_len */
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
@@ -2166,7 +2164,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  nocow_args.block_start, /* block_start */
-					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.orig_disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC,
@@ -5002,7 +4999,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
@@ -6864,7 +6860,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	em->start = EXTENT_MAP_HOLE;
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
-	em->block_len = (u64)-1;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -7022,7 +7017,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 start,
 						  const u64 len,
 						  const u64 block_start,
-						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
 						  const int type,
@@ -7034,14 +7028,14 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, block_start,
-				  block_len, orig_block_len, ram_bytes,
+				  orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type, disk_bytenr, offset);
 		if (IS_ERR(em))
 			goto out;
 	}
 	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
-					     block_start, block_len, 0,
+					     block_start, len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7086,7 +7080,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 		return ERR_PTR(ret);
 
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.objectid, ins.offset, ins.offset,
+				     ins.objectid, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     ins.objectid, 0);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7329,7 +7323,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 block_start,
-				       u64 block_len, u64 disk_num_bytes,
+				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type, u64 disk_bytenr, u64 offset)
 {
@@ -7350,16 +7344,10 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
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
@@ -7385,7 +7373,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	em->start = start;
 	em->len = len;
-	em->block_len = block_len;
 	em->block_start = block_start;
 	em->disk_bytenr = disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
@@ -7475,7 +7462,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      block_start,
-					      len, orig_block_len,
+					      orig_block_len,
 					      ram_bytes, type,
 					      disk_bytenr, new_offset);
 		btrfs_dec_nocow_writers(bg);
@@ -9797,7 +9784,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
 		em->offset = 0;
-		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
@@ -10294,12 +10280,12 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
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
 		encoded->unencoded_offset = iocb->ki_pos - em->start + em->offset;
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
@@ -10538,7 +10524,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	em = create_io_em(inode, start, num_bytes,
 			  ins.objectid,
-			  ins.offset, ins.offset, ram_bytes, compression,
+			  ins.offset, ram_bytes, compression,
 			  BTRFS_ORDERED_COMPRESSED, ins.objectid,
 			  encoded->unencoded_offset);
 	if (IS_ERR(em)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2dfb197c2a96..95a8588dcf8e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2956,7 +2956,6 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 
 	em->start = start;
 	em->len = end + 1 - start;
-	em->block_len = em->len;
 	em->block_start = block_start;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = em->len;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index a55adecd5955..dc14907c65f9 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -25,9 +25,10 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 #ifdef CONFIG_BTRFS_DEBUG
 		if (refcount_read(&em->refs) != 1) {
 			test_err(
-"em leak: em (start %llu len %llu block_start %llu block_len %llu) refs %d",
+"em leak: em (start %llu len %llu block_start %llu disk_num_bytes %llu offset %llu) refs %d",
 				 em->start, em->len, em->block_start,
-				 em->block_len, refcount_read(&em->refs));
+				 em->disk_num_bytes, em->offset,
+				 refcount_read(&em->refs));
 
 			refcount_set(&em->refs, 1);
 		}
@@ -71,7 +72,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -95,7 +95,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->start = SZ_16K;
 	em->len = SZ_4K;
 	em->block_start = SZ_32K; /* avoid merging */
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_32K; /* avoid merging */
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -119,7 +118,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->start = start;
 	em->len = len;
 	em->block_start = start;
-	em->block_len = len;
 	em->disk_bytenr = start;
 	em->disk_num_bytes = len;
 	em->ram_bytes = len;
@@ -137,11 +135,11 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
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
@@ -173,7 +171,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
-	em->block_len = (u64)-1;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -197,7 +194,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -221,7 +217,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
-	em->block_len = (u64)-1;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -238,11 +233,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
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
@@ -269,7 +263,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -293,7 +286,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -316,11 +308,11 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
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
@@ -379,7 +371,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_8K;
 	em->block_start = 0;
-	em->block_len = SZ_8K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_8K;
 	em->ram_bytes = SZ_8K;
@@ -403,7 +394,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = SZ_8K;
 	em->len = 24 * SZ_1K;
 	em->block_start = SZ_16K; /* avoid merging */
-	em->block_len = 24 * SZ_1K;
 	em->disk_bytenr = SZ_16K; /* avoid merging */
 	em->disk_num_bytes = 24 * SZ_1K;
 	em->ram_bytes = 24 * SZ_1K;
@@ -426,7 +416,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->start = 0;
 	em->len = SZ_32K;
 	em->block_start = 0;
-	em->block_len = SZ_32K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_32K;
 	em->ram_bytes = SZ_32K;
@@ -446,9 +435,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
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
@@ -512,7 +501,6 @@ static int add_compressed_extent(struct btrfs_fs_info *fs_info,
 	em->start = start;
 	em->len = len;
 	em->block_start = block_start;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = len;
@@ -739,7 +727,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct extent_map_tree *em
 	em->start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_16K;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = SZ_16K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -801,7 +788,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	em->start = 0;
 	em->len = SZ_16K;
 	em->block_start = 0;
-	em->block_len = SZ_4K;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_16K;
@@ -826,7 +812,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	em->start = SZ_32K;
 	em->len = SZ_16K;
 	em->block_start = SZ_32K;
-	em->block_len = SZ_16K;
 	em->disk_bytenr = SZ_32K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e43c0128a39f..5ca7f2623b56 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4645,7 +4645,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->disk_num_bytes);
+		csum_len = em->disk_num_bytes;
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4694,7 +4694,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->disk_num_bytes);
+	block_len = em->disk_num_bytes;
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7dcc28cd1699..0d0775bde14c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -294,7 +294,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__field(	u64,  start		)
 		__field(	u64,  len		)
 		__field(	u64,  block_start	)
-		__field(	u64,  block_len		)
 		__field(	u32,  flags		)
 		__field(	int,  refs		)
 	),
@@ -305,19 +304,17 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
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
2.44.0


