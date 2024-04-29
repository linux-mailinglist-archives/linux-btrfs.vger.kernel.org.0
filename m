Return-Path: <linux-btrfs+bounces-4639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E188B65A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D511C20EB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4421194C8A;
	Mon, 29 Apr 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OV9/bhfi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OV9/bhfi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD86194C68
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429419; cv=none; b=IRsSrjTefOX788pLSRcKACHveostbbGHQPRjqBOcAHk5nvRimiEB+vH6XB/HKtojQOZb8w7oqSpumnxFDIpY95vzGXL0qOskUolVKSLWvBw4T8IvT6AzW2ozwANtfPmkn9aUqddxOuzC5uY4ED+3/KOs6JmplUrKYeaj2oqtfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429419; c=relaxed/simple;
	bh=VYNxf35VfR2ODdhhsOCRL5zSe+/byfQEAd71Q26K0Lc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEwc8v3I1PWGm/VE5rTFak8vg3BsFKtnnrpYBcT9Mbqcnp3jueKaZiXhj1Dqw6TPRqEF5puAwTMwTG5Q3HLv4d+3QD7SR1z9NVWp+VwHDh0PohFNoTnRTd6tXsZny/zzsRzQMIPD4m/G7ZfOrKEEAzIISjiLxmeLbjTCYRF7yu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OV9/bhfi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OV9/bhfi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 878D633B60
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cf4lpBVX2sH8EYFNZP4uLOYnLC3MxzA/CLyG1aC90k=;
	b=OV9/bhfid9xUNrzqOz+PMXn29pxfme8p+kPk+ZnLloBBWfGUZKi0mkK5edo6L3Y2Yahuh5
	i0pwiHAgPdMzJA7XE86IfVhFHdEjW4yHT3/Gw/Ban6e9rG5pupIYiHKT/Ohuq7EX9anFMp
	bBQr8pqzADDDe9gcj8huTz/IPrsuWQE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cf4lpBVX2sH8EYFNZP4uLOYnLC3MxzA/CLyG1aC90k=;
	b=OV9/bhfid9xUNrzqOz+PMXn29pxfme8p+kPk+ZnLloBBWfGUZKi0mkK5edo6L3Y2Yahuh5
	i0pwiHAgPdMzJA7XE86IfVhFHdEjW4yHT3/Gw/Ban6e9rG5pupIYiHKT/Ohuq7EX9anFMp
	bBQr8pqzADDDe9gcj8huTz/IPrsuWQE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A008139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJ9mNeUdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: introduce new members for extent_map
Date: Tue, 30 Apr 2024 07:53:02 +0930
Message-ID: <ec31d03ecb00341c10208fb526c199c4dead7fb9.1714428940.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
index ccd9b03116f5..baccc841f657 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -71,12 +71,29 @@ struct extent_map {
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
index 17377746a274..09acc09ea915 100644
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
@@ -1114,6 +1115,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent = { 0 };
 	struct btrfs_key ins;
 	struct page *locked_page = NULL;
 	struct extent_map *em;
@@ -1158,6 +1160,13 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
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
@@ -1166,6 +1175,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
+			  &file_extent,
 			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -1385,6 +1395,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	while (num_bytes > 0) {
 		struct btrfs_ordered_extent *ordered;
+		struct btrfs_file_extent file_extent = { 0 };
 
 		cur_alloc_size = num_bytes;
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
@@ -1421,6 +1432,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		extent_reserved = true;
 
 		ram_size = ins.offset;
+		file_extent.disk_bytenr = ins.objectid;
+		file_extent.disk_num_bytes = ins.offset;
+		file_extent.num_bytes = ins.offset;
+		file_extent.ram_bytes = ins.offset;
+		file_extent.offset = 0;
+		file_extent.compression = BTRFS_COMPRESS_NONE;
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
@@ -1428,6 +1445,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
+				  &file_extent,
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
@@ -1828,6 +1846,7 @@ struct can_nocow_file_extent_args {
 	u64 disk_bytenr;
 	u64 disk_num_bytes;
 	u64 extent_offset;
+
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
 
@@ -2152,6 +2171,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
+					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				btrfs_dec_nocow_writers(nocow_bg);
@@ -4941,6 +4961,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
+			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
@@ -6801,6 +6822,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 	em->start = EXTENT_MAP_HOLE;
 	em->orig_start = EXTENT_MAP_HOLE;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
 
@@ -6966,7 +6988,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
-						  const int type)
+						  const int type,
+						  struct btrfs_file_extent *file_extent)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
@@ -6975,7 +6998,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		em = create_io_em(inode, start, len, orig_start, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  type);
+				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7006,6 +7029,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em;
 	struct btrfs_key ins;
 	u64 alloc_hint;
@@ -7024,9 +7048,16 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
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
@@ -7269,6 +7300,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
+				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
 	struct extent_map *em;
@@ -7326,9 +7358,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
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
@@ -7352,6 +7386,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
@@ -7382,7 +7417,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
+				     &orig_block_len, &ram_bytes,
+				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -7410,7 +7446,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
-					      ram_bytes, type);
+					      ram_bytes, type,
+					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -9561,6 +9598,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
+		em->disk_bytenr = ins.objectid;
+		em->offset = 0;
 		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
@@ -10127,6 +10166,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_changeset *data_reserved = NULL;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent = { 0 };
 	int compression;
 	size_t orig_count;
 	u64 start, end;
@@ -10300,10 +10340,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
2.44.0


