Return-Path: <linux-btrfs+bounces-4642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E778B65AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08D9282B0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF4199E95;
	Mon, 29 Apr 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sc0gXUf8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sc0gXUf8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01A194C99
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429425; cv=none; b=cWk8UTSr6Jq0k2RBm4oFg9CBKpPEgESxpOxYg1IKYhzkjqV52z9hIxhBcehRdHGVkpFWYi5/Z0fqm2/TQKXjGWeGfPojbttps7jUDwY3+AJjVEYsgu+JgrJAXIWGIKsQTkOGsW8g/1IfcJQUMrcmYYtGzWdWi1cv+F8MRLJ5rMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429425; c=relaxed/simple;
	bh=HoHd0ND02OSNFHvQyEpmLFqAaD03CvPMTOn7XG+/SXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEtnroJivVcsOZj1l7pc8XgLsEJ+rCPGxsjBFOxNV3DJ75T+Q9hvfrlVDbS/+XOjFeSn3h+RAtSnYWzUxRzh/hue6aoW+75KNqZLMOir7WNKi5LyDgMk070LsjnlLAvGuZd5vH7stvYyQw8BYOjFLpUwO8Nir518nF8DJwmiGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sc0gXUf8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sc0gXUf8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F24233B63
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5kt6+t9n8scsa6L5hNcADcibv4N62JBw/a5z4mcaK0=;
	b=Sc0gXUf8n86voucuVNI1Yda3D2YhOs1Eauhb4xxYqiiIaX6xKRY0IyUhh7E2txmced85XM
	1G6aIzWPl5t4b9nY+JAc5QjLnH6L/L5ryu7fmyzcCL7BJK5UfZDPaPnjOljJu4BOvLvaZB
	7g0LPfnsIBG98Tn3D2UbGnUPeQony5A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Sc0gXUf8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5kt6+t9n8scsa6L5hNcADcibv4N62JBw/a5z4mcaK0=;
	b=Sc0gXUf8n86voucuVNI1Yda3D2YhOs1Eauhb4xxYqiiIaX6xKRY0IyUhh7E2txmced85XM
	1G6aIzWPl5t4b9nY+JAc5QjLnH6L/L5ryu7fmyzcCL7BJK5UfZDPaPnjOljJu4BOvLvaZB
	7g0LPfnsIBG98Tn3D2UbGnUPeQony5A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2D6139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YDHYMesdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: remove extent_map::block_len member
Date: Tue, 30 Apr 2024 07:53:05 +0930
Message-ID: <8212bcb8b0dab021fd16938770245f05aa3c5683.1714428940.git.wqu@suse.com>
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
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F24233B63
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
index a4cd0e743027..3af87911c83e 100644
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
index dc73b8a81271..dcd191c2c4b3 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -186,11 +186,18 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
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
@@ -288,10 +295,10 @@ static void dump_extent_map(const char *prefix, struct extent_map *em)
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
 
@@ -313,9 +320,6 @@ static void validate_extent_map(struct extent_map *em)
 			if (em->block_start != em->disk_bytenr)
 				dump_extent_map(
 				"mismatch block_start/disk_bytenr/offset", em);
-			if (em->disk_num_bytes != em->block_len)
-				dump_extent_map(
-				"mismatch disk_num_bytes/block_len", em);
 		} else {
 			if (em->block_start != em->disk_bytenr + em->offset)
 				dump_extent_map(
@@ -354,7 +358,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->len += merge->len;
-			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
 
@@ -375,7 +378,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		merge = rb_entry(rb, struct extent_map, rb_node);
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
-		em->block_len += merge->block_len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
 		validate_extent_map(em);
@@ -669,7 +671,6 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	if (em->block_start < EXTENT_MAP_LAST_BYTE &&
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
-		em->block_len = em->len;
 		em->offset += start_diff;
 	}
 	return add_extent_mapping(inode, em, 0);
@@ -884,17 +885,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -924,23 +919,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -1098,8 +1088,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
 	split_pre->block_start = new_logical;
-	split_pre->block_len = split_pre->len;
-	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1118,7 +1106,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
 	split_mid->block_start = em->block_start + pre;
-	split_mid->block_len = split_mid->len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 883e78513fcd..9cd6316b9b86 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -103,15 +103,6 @@ struct extent_map {
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
index 08d608f0ae5d..95fb7c059a1a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1306,11 +1306,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
@@ -1323,11 +1321,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
index be4e6acb08f3..05c7b5429b85 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2337,7 +2337,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e1741fdb5a91..ad75efe99461 100644
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
@@ -1170,7 +1170,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
 			  ins.objectid,			/* block_start */
-			  ins.offset,			/* block_len */
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
@@ -1439,7 +1438,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.compression = BTRFS_COMPRESS_NONE;
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  ins.objectid, /* block_start */
-				  ins.offset, /* block_len */
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
@@ -2164,7 +2162,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  nocow_args.disk_bytenr, /* block_start */
-					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  &nocow_args.file_extent,
@@ -4957,7 +4954,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
-			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
@@ -6818,7 +6814,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	em->start = EXTENT_MAP_HOLE;
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
-	em->block_len = (u64)-1;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -6976,7 +6971,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 start,
 						  const u64 len,
 						  const u64 block_start,
-						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
 						  const int type,
@@ -6987,14 +6981,14 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 
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
@@ -7046,7 +7040,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.objectid, ins.offset, ins.offset,
+				     ins.objectid, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     &file_extent);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7287,7 +7281,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 block_start,
-				       u64 block_len, u64 disk_num_bytes,
+				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type)
@@ -7309,16 +7303,10 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
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
@@ -7344,7 +7332,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	em->start = start;
 	em->len = len;
-	em->block_len = block_len;
 	em->block_start = block_start;
 	em->disk_bytenr = file_extent->disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
@@ -7433,7 +7420,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      block_start,
-					      len, orig_block_len,
+					      orig_block_len,
 					      ram_bytes, type,
 					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
@@ -9587,7 +9574,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
 		em->offset = 0;
-		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
@@ -10084,12 +10070,12 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -10335,7 +10321,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
 			  ins.objectid,
-			  ins.offset, ins.offset, ram_bytes, compression,
+			  ins.offset, ram_bytes, compression,
 			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c1bd26a96cc0..e79e94e745a1 100644
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
index bd56efe37f02..ffdaa6a682af 100644
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
index c9e8c5f96b1c..13f35180e3a0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4648,7 +4648,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->disk_num_bytes);
+		csum_len = em->disk_num_bytes;
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4698,7 +4698,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->disk_num_bytes);
+	block_len = em->disk_num_bytes;
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 6dacdc1fb63e..3743719d13f2 100644
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
2.44.0


