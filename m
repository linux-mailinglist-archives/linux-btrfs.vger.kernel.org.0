Return-Path: <linux-btrfs+bounces-4031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1889CE74
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285881C21DF5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6A376E4;
	Mon,  8 Apr 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mh87nqxK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mh87nqxK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73D383A5
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615648; cv=none; b=NKYXcsKHqBJ20FnUXJoFp0e30Dr8ODRWiIRcaaC9vwZ8/Dtu8lyYmhbTCxpf88gONDNSqjmK5UACkB66vkOqNzQaxg/44DkQ1lpFoShxUSXakk7ATkyDy37j3eiz9Z7bYPdw+Na8wcpatEg2Uc6KEWMeYCXATWS0imBPJ1Dovj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615648; c=relaxed/simple;
	bh=trMvPgpAAbrU9SijkqKnkWmh4QdG/SWvPoVxOfrnYqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVYdIXbY0OMoQkHunXFs6DMeM6WYauwfzdi5OhyYcm+mmrTLC7b3ixF07veDfwV/wnaWvUwcygl3DsXF9JMXghke3PGPt/woDEXXWbreifKYDkrYhhmhk8jIy/LTsumw7U84HqDYk0DUQvi5HJWeSlbSS3Y4eO39Kv+aFcMszZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mh87nqxK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mh87nqxK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09ABF205F3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmW3LuXloJu+RhLFo0ZoJ50Qhs6UASkD4dHGISVERbk=;
	b=Mh87nqxKTdMUWmAHqEiNG3U7wPB4gyn6uEli92KTTF/ZqJ4wkGAsW0jUr8LvSx7IdkNfB4
	OtQmvtVUP7vJs8c0FqG+y9BSA8IL/CaGVfVT6UfcusCAbEa0zNK48YTPsPLkT8wI6St2DK
	WU4BBqPLEPoEapNHOWscCc3Z7NDs8Bs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Mh87nqxK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmW3LuXloJu+RhLFo0ZoJ50Qhs6UASkD4dHGISVERbk=;
	b=Mh87nqxKTdMUWmAHqEiNG3U7wPB4gyn6uEli92KTTF/ZqJ4wkGAsW0jUr8LvSx7IdkNfB4
	OtQmvtVUP7vJs8c0FqG+y9BSA8IL/CaGVfVT6UfcusCAbEa0zNK48YTPsPLkT8wI6St2DK
	WU4BBqPLEPoEapNHOWscCc3Z7NDs8Bs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C0E1332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IMwkNdpwFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:34:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/8] btrfs: introduce new members for extent_map
Date: Tue,  9 Apr 2024 08:03:42 +0930
Message-ID: <33ad6697db3e0e869e4553d95c3a3dc98883c278.1712614770.git.wqu@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 09ABF205F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

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

- Add a new member for can_nocow_file_extent_args
  The new member is called "orig_disk_bytenr", for easier fetching the
  old disk_bytenr.

- Update the new members when doing extent map split
  This is in fact a little simpler, as we only need to update
  offset/len.

- Update the new members when inserting new io extent map
  This involves quite some NOCOW related functions, and adding two
  parameters to a already long parameter list.

  To avoid unexpected parameter change, the two new parameters,
  @disk_bytenr and @offset are all added to the end of the list.

  And they would be relocated when dropping the old
  @block_start/@block_len/@orig_start members.

For now, both the old members (block_start/block_len/orig_start) are
co-existing with the new members (disk_bytenr/offset), meanwhile all the
critical code is still using the old members only.

The switch to new members would happen gradually to be bisect
friendly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  3 +-
 fs/btrfs/defrag.c      |  4 +++
 fs/btrfs/extent_map.c  | 75 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/extent_map.h  | 17 ++++++++++
 fs/btrfs/file-item.c   |  9 ++++-
 fs/btrfs/file.c        |  3 +-
 fs/btrfs/inode.c       | 56 +++++++++++++++++++++++--------
 7 files changed, 147 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 100020ca4658..ded36e065089 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -444,7 +444,8 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict);
+			      u64 *ram_bytes, bool nowait, bool strict,
+			      u64 *disk_bytenr_ret, u64 *extent_offset_ret);
 
 void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f015fa1b6301..5259fd556487 100644
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
index dd51a21b6a76..f59423897501 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -223,6 +223,58 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
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
 static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 {
 	struct extent_map *merge = NULL;
@@ -253,6 +305,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
+
+			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+				merge_ondisk_extents(merge, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
@@ -267,6 +322,8 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
+		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+			merge_ondisk_extents(em, merge);
 		rb_erase_cached(&merge->rb_node, &tree->map);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
@@ -541,6 +598,7 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
 		em->block_len = em->len;
+		em->offset += start_diff;
 	}
 	return add_extent_mapping(em_tree, em, 0);
 }
@@ -759,14 +817,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
 
@@ -787,13 +849,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -806,10 +869,11 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -965,6 +1029,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
 	split_pre->len = pre;
+	split_pre->disk_bytenr = new_logical;
+	split_pre->disk_num_bytes = split_pre->len;
+	split_pre->offset = 0;
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
@@ -983,10 +1050,12 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
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
index 242a0c2e7a5e..848b4a4ecd6a 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -67,12 +67,29 @@ struct extent_map {
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
index b552646a0ce6..96486f82ab5d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1280,12 +1280,17 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
@@ -1302,8 +1307,10 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
index cdcd7e0785c1..af6de3549901 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1094,7 +1094,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, NULL, nowait, false);
+			NULL, NULL, NULL, nowait, false, NULL, NULL);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
@@ -2161,6 +2161,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->orig_start = offset;
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
+		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4d207c3b38d9..69a7cdeef81e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,9 +139,9 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
-				       int type);
+				       int type, u64 disk_bytenr, u64 offset);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 					  u64 root, void *warn_ctx)
@@ -1166,7 +1166,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
-			  BTRFS_ORDERED_COMPRESSED);
+			  BTRFS_ORDERED_COMPRESSED,
+			  ins.objectid, 0);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
@@ -1429,7 +1430,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  BTRFS_ORDERED_REGULAR /* type */);
+				  BTRFS_ORDERED_REGULAR /* type */,
+				  ins.objectid, 0);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out_reserve;
@@ -1859,6 +1861,7 @@ struct can_nocow_file_extent_args {
 	 */
 
 	u64 block_start;
+	u64 orig_disk_bytenr;
 	u64 orig_disk_num_bytes;
 	u64 orig_offset;
 	/* Number of bytes that can be written to in NOCOW mode. */
@@ -1897,6 +1900,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
 	/* Can't access these fields unless we know it's not an inline extent. */
 	args->block_start = btrfs_file_extent_disk_bytenr(leaf, fi);
+	args->orig_disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 	args->orig_disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 	args->orig_offset = btrfs_file_extent_offset(leaf, fi);
 
@@ -2169,7 +2173,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.orig_disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
-					  BTRFS_ORDERED_PREALLOC);
+					  BTRFS_ORDERED_PREALLOC,
+					  nocow_args.orig_disk_bytenr,
+					  cur_offset - found_key.offset +
+					  nocow_args.orig_offset);
 			if (IS_ERR(em)) {
 				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
@@ -4999,6 +5006,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
+			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
@@ -6860,6 +6868,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 	em->start = EXTENT_MAP_HOLE;
 	em->orig_start = EXTENT_MAP_HOLE;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
 
@@ -7025,7 +7034,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const u64 block_len,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
-						  const int type)
+						  const int type,
+						  const u64 disk_bytenr,
+						  const u64 offset)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
@@ -7034,7 +7045,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		em = create_io_em(inode, start, len, orig_start, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  type);
+				  type, disk_bytenr, offset);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7085,7 +7096,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR);
+				     ins.offset, BTRFS_ORDERED_REGULAR,
+				     ins.objectid, 0);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7129,7 +7141,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict)
+			      u64 *ram_bytes, bool nowait, bool strict,
+			      u64 *disk_bytenr_ret, u64 *new_offset_ret)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7218,6 +7231,11 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*orig_start = key.offset - nocow_args.orig_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.orig_disk_num_bytes;
+	if (disk_bytenr_ret)
+		*disk_bytenr_ret = nocow_args.orig_disk_bytenr;
+	if (new_offset_ret)
+		*new_offset_ret = offset - key.offset +
+				  nocow_args.orig_offset;
 
 	*len = nocow_args.num_bytes;
 	ret = 1;
@@ -7324,7 +7342,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
-				       int type)
+				       int type, u64 disk_bytenr, u64 offset)
 {
 	struct extent_map *em;
 	int ret;
@@ -7381,9 +7399,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
+	em->disk_bytenr = disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
+	em->offset = offset;
 	em->flags |= EXTENT_FLAG_PINNED;
 	if (type == BTRFS_ORDERED_COMPRESSED)
 		extent_map_set_compression(em, compress_type);
@@ -7410,6 +7430,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
+	u64 disk_bytenr;
+	u64 new_offset;
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
@@ -7437,7 +7459,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, false, false) == 1) {
+				     &orig_block_len, &ram_bytes, false, false,
+				     &disk_bytenr, &new_offset) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -7465,7 +7488,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
-					      ram_bytes, type);
+					      ram_bytes, type,
+					      disk_bytenr, new_offset);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -9784,6 +9808,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
+		em->disk_bytenr = ins.objectid;
+		em->offset = 0;
 		em->block_len = ins.offset;
 		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
@@ -10526,7 +10552,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	em = create_io_em(inode, start, num_bytes,
 			  start - encoded->unencoded_offset, ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
-			  BTRFS_ORDERED_COMPRESSED);
+			  BTRFS_ORDERED_COMPRESSED, ins.objectid,
+			  encoded->unencoded_offset);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
@@ -10856,7 +10883,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL,
+				       false, true, NULL, NULL);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.44.0


