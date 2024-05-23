Return-Path: <linux-btrfs+bounces-5229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088168CCB94
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD6D1C211A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32313B2AC;
	Thu, 23 May 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wob183Bc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wob183Bc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D62374E
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440640; cv=none; b=hroWl8PUQj6JG8jDxmgq+y1oyJxNCEEk/H36vmR3/EICTFTFC3hHphss5Z7rtXazwZNbFPTY2hTCGI4ZmWZVzML5OC26OURm5aLJzAV/S2i6D7cGvUk9m4p6nvPidPTPi3wctpJe5rdnjFu7baic1FkUrh9qcKSm06lKwIdAc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440640; c=relaxed/simple;
	bh=beNK+9lZDopi8MesAiIAJgIViGAs96TNDCUWpoPcKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtS+S3N46D+2SgVKMml8Oe1JjE4raUvEIZjyLq9bj5rZ0a2z2TjFy2Jb+3H1DPx//zzyRpLbx5eBvHYScVADjW5NdDkC3vMAfHi50Y6U6df/tMtiMl1M6fdSQh9kZLyVmKCPomaOMOe/kDOR4y35IIdhpcCMjQEsCqofqjht1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wob183Bc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wob183Bc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39622220E9;
	Thu, 23 May 2024 05:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08iamDes8RiMlZX8DMq7oAoARKwXkChpmuqnfKlrUxo=;
	b=Wob183Bc9xufpJhJxBD0xOcnTFFaHkoTM8Ewb86sjgn2lght9NZ239F+cNox60FtnYEFE+
	2M726YnUDsurSGtva1+gweq/VxQhtqsACH0MMf3HFNx0jDIFxqYdGS3+njt+vhtNx/rsc3
	STjrFfEIg3syBdNSImb30EQ8QXU76E0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08iamDes8RiMlZX8DMq7oAoARKwXkChpmuqnfKlrUxo=;
	b=Wob183Bc9xufpJhJxBD0xOcnTFFaHkoTM8Ewb86sjgn2lght9NZ239F+cNox60FtnYEFE+
	2M726YnUDsurSGtva1+gweq/VxQhtqsACH0MMf3HFNx0jDIFxqYdGS3+njt+vhtNx/rsc3
	STjrFfEIg3syBdNSImb30EQ8QXU76E0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 032FC13A6B;
	Thu, 23 May 2024 05:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LhkKjnOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 03/11] btrfs: introduce new members for extent_map
Date: Thu, 23 May 2024 14:33:22 +0930
Message-ID: <41be25a4c77c46f8725c13636098f5f37e5c3d93.1716440169.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
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
  little more complex, as we have 3 different cases:

  * Both extent maps are referring to the same data extents
    |<----- data extent A ----->|
       |<- em 1 ->|<- em 2 ->|

  * Both extent maps are referring to different data extents
    |<-- data extent A -->|<-- data extent B -->|
               |<- em 1 ->|<- em 2 ->|

  * One of the extent maps is referring to a merged and larger data
    extent that covers both extent maps

    This is not really valid case other than some selftests.
    So this test case would be removed.

  A new helper merge_ondisk_extents() would be introduced to handle
  above valid cases.

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
 fs/btrfs/extent_map.c | 78 ++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/extent_map.h | 17 ++++++++++
 fs/btrfs/file-item.c  |  9 ++++-
 fs/btrfs/file.c       |  1 +
 fs/btrfs/inode.c      | 57 +++++++++++++++++++++++++++----
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
index a9d60d1eade9..c7d2393692e6 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -229,6 +229,60 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
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
+	 * There are two different cases where @prev and @next can be merged.
+	 *
+	 * 1) They are referring to the same data extent
+	 * |<----- data extent A ----->|
+	 *    |<- prev ->|<- next ->|
+	 *
+	 * 2) They are referring to different data extents but still adjacent
+	 *
+	 * |<-- data extent A -->|<-- data extent B -->|
+	 *            |<- prev ->|<- next ->|
+	 *
+	 * The calculation here always merge the data extents first, then update
+	 * @offset using the new data extents.
+	 *
+	 * For case 1), the merged data extent would be the same.
+	 * For case 2), we just merge the two data extents into one.
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
@@ -260,6 +314,9 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
+
+			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+				merge_ondisk_extents(merge, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			rb_erase(&merge->rb_node, &tree->root);
@@ -275,6 +332,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
+		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+			merge_ondisk_extents(em, merge);
 		rb_erase(&merge->rb_node, &tree->root);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
@@ -562,6 +621,7 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
 		em->block_len = em->len;
+		em->offset += start_diff;
 	}
 	return add_extent_mapping(inode, em, 0);
 }
@@ -785,14 +845,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
 
@@ -813,13 +877,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -832,10 +897,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -989,10 +1055,12 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
 	split_pre->len = pre;
+	split_pre->disk_bytenr = new_logical;
+	split_pre->disk_num_bytes = split_pre->len;
+	split_pre->offset = 0;
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
-	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1007,10 +1075,12 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
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
index 2b7bbffd594b..0b1a8e409377 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -70,12 +70,29 @@ struct extent_map {
 	 */
 	u64 orig_start;
 
+	/*
+	 * The bytenr of the full on-disk extent.
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
index 430dce44ebd2..1298afea9503 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1295,12 +1295,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
@@ -1317,8 +1322,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
index 7c42565da70c..5133c6705d74 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2350,6 +2350,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->orig_start = offset;
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
+		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ac489fb5e39..7afcdea27782 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -141,6 +141,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
+				       struct btrfs_file_extent *file_extent,
 				       int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
@@ -1152,6 +1153,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent;
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
+		struct btrfs_file_extent file_extent;
 
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
@@ -2180,6 +2198,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
+					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				unlock_extent(&inode->io_tree, cur_offset,
@@ -5012,6 +5031,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
+			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
@@ -6880,6 +6900,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 	em->start = EXTENT_MAP_HOLE;
 	em->orig_start = EXTENT_MAP_HOLE;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
 
@@ -7045,7 +7066,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
-						  const int type)
+						  const int type,
+						  struct btrfs_file_extent *file_extent)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
@@ -7054,7 +7076,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		em = create_io_em(inode, start, len, orig_start, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  type);
+				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7085,6 +7107,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_file_extent file_extent;
 	struct extent_map *em;
 	struct btrfs_key ins;
 	u64 alloc_hint;
@@ -7103,9 +7126,16 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
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
@@ -7348,6 +7378,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
+				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
 	struct extent_map *em;
@@ -7405,9 +7436,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
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
@@ -7431,6 +7464,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_file_extent file_extent;
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
@@ -7461,7 +7495,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
+				     &orig_block_len, &ram_bytes,
+				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -7489,7 +7524,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
-					      ram_bytes, type);
+					      ram_bytes, type,
+					      &file_extent);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -9629,6 +9665,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
+		em->disk_bytenr = ins.objectid;
+		em->offset = 0;
 		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
@@ -10195,6 +10233,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_changeset *data_reserved = NULL;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent;
 	int compression;
 	size_t orig_count;
 	u64 start, end;
@@ -10370,10 +10409,16 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
2.45.1


