Return-Path: <linux-btrfs+bounces-10535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87979F61F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4132E161FC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6480918A6A8;
	Wed, 18 Dec 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fluifCwg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fluifCwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966181990DE
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514926; cv=none; b=YYK6w0bA6Ndm2zstaLuU/Rd5KcCJi+Y3uxvGH1x1Nb16NtA7Jht/3Ky7G42bzFe92dYKxedbxo1p8YlkVJcbyO4NNjbYPiTZhObKkmLbDdqbMFh7R042JvhtKXp0bKNt4xjoPfZ6D4LrmwyP+sK3YlcW8cXkyJbG38JAM7R6cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514926; c=relaxed/simple;
	bh=T5cFn31JK+Vit129HYvQQDZK0QNeBviQtF13J/g9i7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTe35c8srXIRZID2rdh+hMC3ZbBtejrnTDuZMkNXbosX0c8QnxgmuUtD143v6iVmFAFQLE4qUjju15NL3r7GTumA5PIaMe8/K/inehjAiWrbalBMZMsR0xdVgQKFh5yisoIqQl/sQxaSkiiLPKa+qZ3t7Yws3iETJhZiMLqH8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fluifCwg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fluifCwg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2A7E1F444
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVvVC9Hc9JbFvOJJq8KNPzOaD2uRl3HwRKVTRku4ZxM=;
	b=fluifCwgd//d8n+OeTOmGtK9TauosYilcXPPFWAMq1nbzCLFuuyDOCXRucZwknTz5Brs+Z
	RQqJUROeReLtRANmaR2VtkNSO/Mw9VZOYmcPvyDKuLx/g3xnRVBvIXrZn0bAs0vdhZQkgq
	pazfjxj691rX3zShyvgi7TvOD+uLkTQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVvVC9Hc9JbFvOJJq8KNPzOaD2uRl3HwRKVTRku4ZxM=;
	b=fluifCwgd//d8n+OeTOmGtK9TauosYilcXPPFWAMq1nbzCLFuuyDOCXRucZwknTz5Brs+Z
	RQqJUROeReLtRANmaR2VtkNSO/Mw9VZOYmcPvyDKuLx/g3xnRVBvIXrZn0bAs0vdhZQkgq
	pazfjxj691rX3zShyvgi7TvOD+uLkTQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE0CB132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yARZKumYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/18] btrfs: migrate free space cache code to use block size terminology
Date: Wed, 18 Dec 2024 20:11:23 +1030
Message-ID: <7b07c87c4b56c123bf7b29fe05d2de8a84da1f4c.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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

Straightforward rename from "sector" to "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/free-space-cache.c |  8 ++++----
 fs/btrfs/free-space-tree.c  | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 17707c898eae..d02ee2f38b60 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2290,7 +2290,7 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		 * of cache left then go ahead an dadd them, no sense in adding
 		 * the overhead of a bitmap if we don't have to.
 		 */
-		if (info->bytes <= fs_info->sectorsize * 8) {
+		if (info->bytes <= fs_info->blocksize * 8) {
 			if (ctl->free_extents * 3 <= ctl->extents_thresh)
 				return false;
 		} else {
@@ -2959,7 +2959,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 
 	spin_lock_init(&ctl->tree_lock);
-	ctl->unit = fs_info->sectorsize;
+	ctl->unit = fs_info->blocksize;
 	ctl->start = block_group->start;
 	ctl->block_group = block_group;
 	ctl->op = &free_space_op;
@@ -3583,10 +3583,10 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 		min_bytes = cont1_bytes;
 	} else if (block_group->flags & BTRFS_BLOCK_GROUP_METADATA) {
 		cont1_bytes = bytes;
-		min_bytes = fs_info->sectorsize;
+		min_bytes = fs_info->blocksize;
 	} else {
 		cont1_bytes = max(bytes, (bytes + empty_size) >> 2);
-		min_bytes = fs_info->sectorsize;
+		min_bytes = fs_info->blocksize;
 	}
 
 	spin_lock(&ctl->tree_lock);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7ba50e133921..e6dbf3e39b00 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -49,7 +49,7 @@ void set_free_space_tree_thresholds(struct btrfs_block_group *cache)
 	 * We convert to bitmaps when the disk space required for using extents
 	 * exceeds that required for using bitmaps.
 	 */
-	bitmap_range = cache->fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
+	bitmap_range = cache->fs_info->blocksize * BTRFS_FREE_SPACE_BITMAP_BITS;
 	num_bitmaps = div_u64(cache->length + bitmap_range - 1, bitmap_range);
 	bitmap_size = sizeof(struct btrfs_item) + BTRFS_FREE_SPACE_BITMAP_SIZE;
 	total_bitmap_size = num_bitmaps * bitmap_size;
@@ -158,7 +158,7 @@ static int btrfs_search_prev_slot(struct btrfs_trans_handle *trans,
 static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *fs_info,
 					 u64 size)
 {
-	return DIV_ROUND_UP(size >> fs_info->sectorsize_bits, BITS_PER_BYTE);
+	return DIV_ROUND_UP(size >> fs_info->blocksize_bits, BITS_PER_BYTE);
 }
 
 static unsigned long *alloc_bitmap(u32 bitmap_size)
@@ -258,9 +258,9 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 				ASSERT(found_key.objectid + found_key.offset <= end);
 
 				first = div_u64(found_key.objectid - start,
-						fs_info->sectorsize);
+						fs_info->blocksize);
 				last = div_u64(found_key.objectid + found_key.offset - start,
-					       fs_info->sectorsize);
+					       fs_info->blocksize);
 				le_bitmap_set(bitmap, first, last - first);
 
 				extent_count++;
@@ -301,7 +301,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	}
 
 	bitmap_cursor = (char *)bitmap;
-	bitmap_range = fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
+	bitmap_range = fs_info->blocksize * BTRFS_FREE_SPACE_BITMAP_BITS;
 	i = start;
 	while (i < end) {
 		unsigned long ptr;
@@ -397,7 +397,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				ASSERT(found_key.objectid + found_key.offset <= end);
 
 				bitmap_pos = div_u64(found_key.objectid - start,
-						     fs_info->sectorsize *
+						     fs_info->blocksize *
 						     BITS_PER_BYTE);
 				bitmap_cursor = ((char *)bitmap) + bitmap_pos;
 				data_size = free_space_bitmap_size(fs_info,
@@ -433,16 +433,16 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
-	nrbits = block_group->length >> block_group->fs_info->sectorsize_bits;
+	nrbits = block_group->length >> block_group->fs_info->blocksize_bits;
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
 		end_bit = find_next_zero_bit_le(bitmap, nrbits, start_bit);
 		ASSERT(start_bit < end_bit);
 
-		key.objectid = start + start_bit * block_group->fs_info->sectorsize;
+		key.objectid = start + start_bit * block_group->fs_info->blocksize;
 		key.type = BTRFS_FREE_SPACE_EXTENT_KEY;
-		key.offset = (end_bit - start_bit) * block_group->fs_info->sectorsize;
+		key.offset = (end_bit - start_bit) * block_group->fs_info->blocksize;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret)
@@ -529,7 +529,7 @@ int free_space_test_bit(struct btrfs_block_group *block_group,
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	i = div_u64(offset - found_start,
-		    block_group->fs_info->sectorsize);
+		    block_group->fs_info->blocksize);
 	return !!extent_buffer_test_bit(leaf, ptr, i);
 }
 
@@ -558,8 +558,8 @@ static void free_space_set_bits(struct btrfs_trans_handle *trans,
 		end = found_end;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	first = (*start - found_start) >> fs_info->sectorsize_bits;
-	last = (end - found_start) >> fs_info->sectorsize_bits;
+	first = (*start - found_start) >> fs_info->blocksize_bits;
+	last = (end - found_start) >> fs_info->blocksize_bits;
 	if (bit)
 		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
 	else
@@ -619,7 +619,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * that block is within the block group.
 	 */
 	if (start > block_group->start) {
-		u64 prev_block = start - block_group->fs_info->sectorsize;
+		u64 prev_block = start - block_group->fs_info->blocksize;
 
 		key.objectid = prev_block;
 		key.type = (u8)-1;
@@ -1544,7 +1544,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 				extent_count++;
 			}
 			prev_bit = bit;
-			offset += fs_info->sectorsize;
+			offset += fs_info->blocksize;
 		}
 	}
 	if (prev_bit == 1) {
-- 
2.47.1


