Return-Path: <linux-btrfs+bounces-4703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B98BA6CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37123283532
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D5139CEB;
	Fri,  3 May 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GQ4dkc1D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GQ4dkc1D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D6139CE3
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716135; cv=none; b=I8ZRjAOJjlub+9oNIQFSgL4WcOEenZ+Stfinxbmiqzddac3gGmN1UbB5LIcrVBAjtyr9VZpAqM5YwOBdxM1Hd/Cl8ZxIphl7v3NYFWlcgZVQS2xVsbjWbXYrc0Nm/8KSAx1zW5FM9Cm0roaDH4EVIC0+2zTh0sTiP0obSCTOf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716135; c=relaxed/simple;
	bh=5MDB9XTd1644Y94FF3WosyZhhp5FABErhzm6knP0w+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7GOEE6pBQootONl6f6q4qdPP3QVXCe5yrV4FrGBRHyd9hexk2B5NXEJUhE5th3OxYezQTK1YknT2TM4+Rco2HGXq47Ozl0WpTAzCwrXgnepv6CyEgF15+uztZfcK8xieYWUxsb3fZELJjiNvSjhJkOWbizExpzW9geB6cifYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GQ4dkc1D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GQ4dkc1D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1DDC1FDBE;
	Fri,  3 May 2024 06:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW/Pje1TelJR7l71Gy5kNv36bP2TW85JbOsqX/e1Onk=;
	b=GQ4dkc1DfJ98917GLhtDDBIdnbqPVIqpsr6vAVjp6E5MEz7eXpGMY70eJFTcAuU0O2+1x6
	+khEyT/AqikpJvNmE6V97W5WWnIl+IZfar5QV7Lq6fky8WHpvC8RQfiIy1h7wD5u5IdVwU
	ornMeuRBJYBWdEav/QYwu98fVL3ZLqU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW/Pje1TelJR7l71Gy5kNv36bP2TW85JbOsqX/e1Onk=;
	b=GQ4dkc1DfJ98917GLhtDDBIdnbqPVIqpsr6vAVjp6E5MEz7eXpGMY70eJFTcAuU0O2+1x6
	+khEyT/AqikpJvNmE6V97W5WWnIl+IZfar5QV7Lq6fky8WHpvC8RQfiIy1h7wD5u5IdVwU
	ornMeuRBJYBWdEav/QYwu98fVL3ZLqU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62ED513991;
	Fri,  3 May 2024 06:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6CkpBuJ9NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 03 May 2024 06:02:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 03/11] btrfs: introduce new members for extent_map
Date: Fri,  3 May 2024 15:31:38 +0930
Message-ID: <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]

Introduce two new members for extent_map:

- disk_bytenr
- offset

Both are matching the members with the same name inside
btrfs_file_extent_items.

For now this patch only touches those members when:

- Reading btrfs_file_extent_items from disk
- Inserting new holes
- Merging two extent maps
  With the new disk_bytenr and disk_num_bytes, doing merging would be a
  little complex, as we have 3 different cases:

  * Both extent maps are referring to the same data extent
  * Both extent maps are referring to different data extents, but
    those data extents are adjacent, and extent maps are at head/tail
    of each data extents
  * One of the extent map is referring to an merged and larger data
    extent that covers both extent maps

  The 3rd case seems only valid in selftest (test_case_3()), but
  a new helper merge_ondisk_extents() should be able to handle all of
  them.

To properly assign values for those new members, a new btrfs_file_extent
parameter is introduced to all the involved call sites.

- For NOCOW writes the btrfs_file_extent would be exposed from
  can_nocow_file_extent().

- For other writes, the members can be easily calculated
  As most of them have 0 offset and utilizing the whole on-disk data
  extent.
  The exception is encoded write, but thankfully that interface provided
  offset directly and all other needed info.

For now, both the old members (block_start/block_len/orig_start) are
co-existing with the new members (disk_bytenr/offset), meanwhile all the
critical code is still using the old members only.

The cleanup would happen later after all the older and newer members are
properly validated.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c     |  4 +++
 fs/btrfs/extent_map.c | 75 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_map.h | 17 ++++++++++
 fs/btrfs/file-item.c  |  9 +++++-
 fs/btrfs/file.c       |  1 +
 fs/btrfs/inode.c      | 60 ++++++++++++++++++++++++++++++----
 6 files changed, 155 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 407ccec3e57e..242c5469f4ba 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -709,6 +709,10 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			em->start = start;
 			em->orig_start = start;
 			em->block_start = EXTENT_MAP_HOLE;
+			em->disk_bytenr = EXTENT_MAP_HOLE;
+			em->disk_num_bytes = 0;
+			em->ram_bytes = 0;
+			em->offset = 0;
 			em->len = key.offset - start;
 			break;
 		}
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4230dd0f34cc..4d4ac9fc43e2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -232,6 +232,58 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	return next->block_start == prev->block_start;
 }
 
+/*
+ * Handle the ondisk data extents merge for @prev and @next.
+ *
+ * Only touches disk_bytenr/disk_num_bytes/offset/ram_bytes.
+ * For now only uncompressed regular extent can be merged.
+ *
+ * @prev and @next will be both updated to point to the new merged range.
+ * Thus one of them should be removed by the caller.
+ */
+static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *next)
+{
+	u64 new_disk_bytenr;
+	u64 new_disk_num_bytes;
+	u64 new_offset;
+
+	/* @prev and @next should not be compressed. */
+	ASSERT(!extent_map_is_compressed(prev));
+	ASSERT(!extent_map_is_compressed(next));
+
+	/*
+	 * There are several different cases that @prev and @next can be merged.
+	 *
+	 * 1) They are referring to the same data extent
+	 * 2) Their ondisk data extents are adjacent and @prev is the tail
+	 *    and @next is the head of their data extents
+	 * 3) One of @prev/@next is referrring to a larger merged data extent.
+	 *    (test_case_3 of extent maps tests).
+	 *
+	 * The calculation here always merge the data extents first, then update
+	 * @offset using the new data extents.
+	 *
+	 * For case 1), the merged data extent would be the same.
+	 * For case 2), we just merge the two data extents into one.
+	 * For case 3), we just got the larger data extent.
+	 */
+	new_disk_bytenr = min(prev->disk_bytenr, next->disk_bytenr);
+	new_disk_num_bytes = max(prev->disk_bytenr + prev->disk_num_bytes,
+				 next->disk_bytenr + next->disk_num_bytes) -
+			     new_disk_bytenr;
+	new_offset = prev->disk_bytenr + prev->offset - new_disk_bytenr;
+
+	prev->disk_bytenr = new_disk_bytenr;
+	prev->disk_num_bytes = new_disk_num_bytes;
+	prev->ram_bytes = new_disk_num_bytes;
+	prev->offset = new_offset;
+
+	next->disk_bytenr = new_disk_bytenr;
+	next->disk_num_bytes = new_disk_num_bytes;
+	next->ram_bytes = new_disk_num_bytes;
+	next->offset = new_offset;
+}
+
 static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
@@ -263,6 +315,9 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
+
+			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+				merge_ondisk_extents(merge, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
@@ -278,6 +333,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
+		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+			merge_ondisk_extents(em, merge);
 		rb_erase_cached(&merge->rb_node, &tree->map);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
@@ -565,6 +622,7 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
 		em->block_len = em->len;
+		em->offset += start_diff;
 	}
 	return add_extent_mapping(inode, em, 0);
 }
@@ -783,14 +841,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->block_len = em->block_len;
 				else
 					split->block_len = split->len;
+				split->disk_bytenr = em->disk_bytenr;
 				split->disk_num_bytes = max(split->block_len,
 							    em->disk_num_bytes);
+				split->offset = em->offset;
 				split->ram_bytes = em->ram_bytes;
 			} else {
 				split->orig_start = split->start;
 				split->block_len = 0;
 				split->block_start = em->block_start;
+				split->disk_bytenr = em->disk_bytenr;
 				split->disk_num_bytes = 0;
+				split->offset = 0;
 				split->ram_bytes = split->len;
 			}
 
@@ -811,13 +873,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->start = end;
 			split->len = em_end - end;
 			split->block_start = em->block_start;
+			split->disk_bytenr = em->disk_bytenr;
 			split->flags = flags;
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
 				split->disk_num_bytes = max(em->block_len,
 							    em->disk_num_bytes);
-
+				split->offset = em->offset + end - em->start;
 				split->ram_bytes = em->ram_bytes;
 				if (compressed) {
 					split->block_len = em->block_len;
@@ -830,10 +893,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->orig_start = em->orig_start;
 				}
 			} else {
+				split->disk_num_bytes = 0;
+				split->offset = 0;
 				split->ram_bytes = split->len;
 				split->orig_start = split->start;
 				split->block_len = 0;
-				split->disk_num_bytes = 0;
 			}
 
 			if (extent_map_in_tree(em)) {
@@ -987,6 +1051,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
 	split_pre->len = pre;
+	split_pre->disk_bytenr = new_logical;
+	split_pre->disk_num_bytes = split_pre->len;
+	split_pre->offset = 0;
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
@@ -1005,10 +1072,12 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* Insert the middle extent_map. */
 	split_mid->start = em->start + pre;
 	split_mid->len = em->len - pre;
+	split_mid->disk_bytenr = em->block_start + pre;
+	split_mid->disk_num_bytes = split_mid->len;
+	split_mid->offset = 0;
 	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
-	split_mid->disk_num_bytes = split_mid->block_len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6ea0287b0d61..cc9c8092b704 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -70,12 +70,29 @@ struct extent_map {
 	 */
 	u64 orig_start;
 
+	/*
+	 * The bytenr for of the full on-disk extent.
+	 *
+	 * For regular extents it's btrfs_file_extent_item::disk_bytenr.
+	 * For holes it's EXTENT_MAP_HOLE and for inline extents it's
+	 * EXTENT_MAP_INLINE.
+	 */
+	u64 disk_bytenr;
+
 	/*
 	 * The full on-disk extent length, matching
 	 * btrfs_file_extent_item::disk_num_bytes.
 	 */
 	u64 disk_num_bytes;
 
+	/*
+	 * Offset inside the decompressed extent.
+	 *
+	 * For regular extents it's btrfs_file_extent_item::offset.
+	 * For holes and inline extents it's 0.
+	 */
+	u64 offset;
+
 	/*
 	 * The decompressed size of the whole on-disk extent, matching
 	 * btrfs_file_extent_item::ram_bytes.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2197cfe5443b..47bd4fe0a44b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1294,12 +1294,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
-		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
+			em->disk_bytenr = EXTENT_MAP_HOLE;
+			em->disk_num_bytes = 0;
+			em->offset = 0;
 			return;
 		}
+		em->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
+		em->offset = btrfs_file_extent_offset(leaf, fi);
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
@@ -1316,8 +1321,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		ASSERT(extent_start == 0);
 
 		em->block_start = EXTENT_MAP_INLINE;
+		em->disk_bytenr = EXTENT_MAP_INLINE;
 		em->start = 0;
 		em->len = fs_info->sectorsize;
+		em->offset = 0;
 		/*
 		 * Initialize orig_start and block_len with the same values
 		 * as in inode.c:btrfs_get_extent().
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 63a13a4cace0..8931eeee199d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2337,6 +2337,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->orig_start = offset;
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
+		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2815b72f2d85..42fea12d509f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,8 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
+				       struct btrfs_file_extent *file_extent,
 				       int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
@@ -1152,6 +1153,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent = { 0 };
 	struct btrfs_key ins;
 	struct page *locked_page = NULL;
 	struct extent_state *cached = NULL;
@@ -1198,6 +1200,13 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	lock_extent(io_tree, start, end, &cached);
 
 	/* Here we're doing allocation and writeback of the compressed pages */
+	file_extent.disk_bytenr = ins.objectid;
+	file_extent.disk_num_bytes = ins.offset;
+	file_extent.ram_bytes = async_extent->ram_size;
+	file_extent.num_bytes = async_extent->ram_size;
+	file_extent.offset = 0;
+	file_extent.compression = async_extent->compress_type;
+
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
 			  start,			/* orig_start */
@@ -1206,6 +1215,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
+			  &file_extent,
 			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -1395,6 +1405,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	while (num_bytes > 0) {
 		struct btrfs_ordered_extent *ordered;
+		struct btrfs_file_extent file_extent = { 0 };
 
 		cur_alloc_size = num_bytes;
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
@@ -1431,6 +1442,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		extent_reserved = true;
 
 		ram_size = ins.offset;
+		file_extent.disk_bytenr = ins.objectid;
+		file_extent.disk_num_bytes = ins.offset;
+		file_extent.num_bytes = ins.offset;
+		file_extent.ram_bytes = ins.offset;
+		file_extent.offset = 0;
+		file_extent.compression = BTRFS_COMPRESS_NONE;
 
 		lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
@@ -1442,6 +1459,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
+				  &file_extent,
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
@@ -1855,6 +1873,7 @@ struct can_nocow_file_extent_args {
 	u64 disk_bytenr;
 	u64 disk_num_bytes;
 	u64 extent_offset;
+
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
 
@@ -2182,6 +2201,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
+					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				unlock_extent(&inode->io_tree, cur_offset,
@@ -4982,6 +5002,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
+			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
@@ -6842,6 +6863,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 	em->start = EXTENT_MAP_HOLE;
 	em->orig_start = EXTENT_MAP_HOLE;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
 
@@ -7007,7 +7029,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
-						  const int type)
+						  const int type,
+						  struct btrfs_file_extent *file_extent)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
@@ -7016,7 +7039,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		em = create_io_em(inode, start, len, orig_start, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  type);
+				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7047,6 +7070,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em;
 	struct btrfs_key ins;
 	u64 alloc_hint;
@@ -7065,9 +7089,16 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
+	file_extent.disk_bytenr = ins.objectid;
+	file_extent.disk_num_bytes = ins.offset;
+	file_extent.num_bytes = ins.offset;
+	file_extent.ram_bytes = ins.offset;
+	file_extent.offset = 0;
+	file_extent.compression = BTRFS_COMPRESS_NONE;
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR);
+				     ins.offset, BTRFS_ORDERED_REGULAR,
+				     &file_extent);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7310,6 +7341,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
+				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
 	struct extent_map *em;
@@ -7367,9 +7399,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
+	em->disk_bytenr = file_extent->disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
+	em->offset = file_extent->offset;
 	em->flags |= EXTENT_FLAG_PINNED;
 	if (type == BTRFS_ORDERED_COMPRESSED)
 		extent_map_set_compression(em, compress_type);
@@ -7393,6 +7427,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
@@ -7423,7 +7458,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
+				     &orig_block_len, &ram_bytes,
+				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -7451,7 +7487,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
-					      ram_bytes, type);
+					      ram_bytes, type,
+					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -9602,6 +9639,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
+		em->disk_bytenr = ins.objectid;
+		em->offset = 0;
 		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
@@ -10168,6 +10207,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_changeset *data_reserved = NULL;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent = { 0 };
 	int compression;
 	size_t orig_count;
 	u64 start, end;
@@ -10343,10 +10383,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		goto out_delalloc_release;
 	extent_reserved = true;
 
+	file_extent.disk_bytenr = ins.objectid;
+	file_extent.disk_num_bytes = ins.offset;
+	file_extent.num_bytes = num_bytes;
+	file_extent.ram_bytes = ram_bytes;
+	file_extent.offset = encoded->unencoded_offset;
+	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
 			  start - encoded->unencoded_offset, ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
-			  BTRFS_ORDERED_COMPRESSED);
+			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
-- 
2.45.0


