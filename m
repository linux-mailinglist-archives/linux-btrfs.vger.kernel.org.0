Return-Path: <linux-btrfs+bounces-4708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB28BA6D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939A11C21EEA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2213A3F4;
	Fri,  3 May 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lxc2P3NN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lxc2P3NN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BA13A25B
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716143; cv=none; b=czGHTbweC1YAWWQy+RsrwGgd/j9MqoAh2aCvWVgfVstmlJFDeBEbTQcVHd+TqeWHekLTePNHMwWnSlfoyd5k+eLbOHN2039EwxDiW/rO9/Zdm9sYzglfjC9x9G2OthQUNJkj9wpz2SB+WCrAniPb3wCBFuuT2yhPZaz+b2OFbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716143; c=relaxed/simple;
	bh=C0t4Ytap5f49OrLdZS49NNsYi/niRQQnJItVRBToVKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONmU0FtZgYU0BYPWgm22tHRkwYnmOmxiP0sOLkZ44UkvDy3Kkt2sAXkZNGSlxw/NnCh14xMJhhDC26IIPRGT05B+Kl//lhuBl+z//+7LsjjM9scsi1UQrL2fQxRnFMJYWHLhbj+YayakK7Mv8mV99nSWbBP/ZFLucr7NMpZiYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lxc2P3NN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lxc2P3NN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 847A422885;
	Fri,  3 May 2024 06:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfFw8ozIK0xp8Qx6eumFGghdbJC8uSzyvS318G3MmCA=;
	b=lxc2P3NNvsnbXTnGdeChqkTYOPdC99rkEIhNAuQiWNMCQfZAFoASBl/0sRzcfwGr6/4mgS
	UdeVGw1EdHDnr1gk57n8H5oDMmiLKFXnM+sjkaszHAyKg0Dt/T+DEcKFfL6QD1bvvIf5Nu
	NYwJ3BRTkYVdNHyA5sXJHzH7lhA5228=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lxc2P3NN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfFw8ozIK0xp8Qx6eumFGghdbJC8uSzyvS318G3MmCA=;
	b=lxc2P3NNvsnbXTnGdeChqkTYOPdC99rkEIhNAuQiWNMCQfZAFoASBl/0sRzcfwGr6/4mgS
	UdeVGw1EdHDnr1gk57n8H5oDMmiLKFXnM+sjkaszHAyKg0Dt/T+DEcKFfL6QD1bvvIf5Nu
	NYwJ3BRTkYVdNHyA5sXJHzH7lhA5228=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AE2B13991;
	Fri,  3 May 2024 06:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPrrCel9NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 03 May 2024 06:02:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 07/11] btrfs: remove extent_map::block_start member
Date: Fri,  3 May 2024 15:31:42 +0930
Message-ID: <9333b82dcbe22bd78687f702485d308daaedc7a9.1714707707.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 847A422885
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

The member extent_map::block_start can be calculated from
extent_map::disk_bytenr + extent_map::offset for regular extents.
And otherwise just extent_map::disk_bytenr.

And this is already validated by the validate_extent_map().
Now we can remove the member.

However there is a special case in btrfs_alloc_ordered_extent(), where
we intentionally pass a pseudo ordered extent, exploiting the fact that
for NOCOW/PREALLOC writes we do not rely on ordered extent members to
update the file extent items.

And that's the only way to pass btrfs_extract_ordered_extent(), as it
doesn't accept any ordered extent with an offset.

For now we will keep the old pseudo ordered extent members, and leave
the cleanup of it for the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c            |  3 +-
 fs/btrfs/defrag.c                 |  9 ++-
 fs/btrfs/extent_io.c              | 10 ++--
 fs/btrfs/extent_map.c             | 56 +++++------------
 fs/btrfs/extent_map.h             | 22 ++++---
 fs/btrfs/file-item.c              |  4 --
 fs/btrfs/file.c                   | 11 ++--
 fs/btrfs/inode.c                  | 84 +++++++++++++++-----------
 fs/btrfs/relocation.c             |  1 -
 fs/btrfs/tests/extent-map-tests.c | 48 ++++++---------
 fs/btrfs/tests/inode-tests.c      | 99 ++++++++++++++++---------------
 fs/btrfs/tree-log.c               | 17 +++---
 fs/btrfs/zoned.c                  |  4 +-
 include/trace/events/btrfs.h      | 11 +---
 14 files changed, 172 insertions(+), 207 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3af87911c83e..414adbba07b8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -507,7 +507,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 */
 		if (!em || cur < em->start ||
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
-		    (em->block_start >> SECTOR_SHIFT) != orig_bio->bi_iter.bi_sector) {
+		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
+		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 025e7f853a68..6fb94e897fc5 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -707,7 +707,6 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 		 */
 		if (key.offset > start) {
 			em->start = start;
-			em->block_start = EXTENT_MAP_HOLE;
 			em->disk_bytenr = EXTENT_MAP_HOLE;
 			em->disk_num_bytes = 0;
 			em->ram_bytes = 0;
@@ -828,7 +827,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 */
 	next = defrag_lookup_extent(inode, em->start + em->len, newer_than, locked);
 	/* No more em or hole */
-	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
+	if (!next || next->disk_bytenr >= EXTENT_MAP_LAST_BYTE)
 		goto out;
 	if (next->flags & EXTENT_FLAG_PREALLOC)
 		goto out;
@@ -995,12 +994,12 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 * This is for users who want to convert inline extents to
 		 * regular ones through max_inline= mount option.
 		 */
-		if (em->block_start == EXTENT_MAP_INLINE &&
+		if (em->disk_bytenr == EXTENT_MAP_INLINE &&
 		    em->len <= inode->root->fs_info->max_inline)
 			goto next;
 
 		/* Skip holes and preallocated extents. */
-		if (em->block_start == EXTENT_MAP_HOLE ||
+		if (em->disk_bytenr == EXTENT_MAP_HOLE ||
 		    (em->flags & EXTENT_FLAG_PREALLOC))
 			goto next;
 
@@ -1065,7 +1064,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 * So if an inline extent passed all above checks, just add it
 		 * for defrag, and be converted to regular extents.
 		 */
-		if (em->block_start == EXTENT_MAP_INLINE)
+		if (em->disk_bytenr == EXTENT_MAP_INLINE)
 			goto add;
 
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 597387e9f040..ef9928cc6467 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1083,10 +1083,10 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
 		if (compress_type != BTRFS_COMPRESS_NONE)
-			disk_bytenr = em->block_start;
+			disk_bytenr = em->disk_bytenr;
 		else
-			disk_bytenr = em->block_start + extent_offset;
-		block_start = em->block_start;
+			disk_bytenr = extent_map_block_start(em) + extent_offset;
+		block_start = extent_map_block_start(em);
 		if (em->flags & EXTENT_FLAG_PREALLOC)
 			block_start = EXTENT_MAP_HOLE;
 
@@ -1405,8 +1405,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
 		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
 
-		block_start = em->block_start;
-		disk_bytenr = em->block_start + extent_offset;
+		block_start = extent_map_block_start(em);
+		disk_bytenr = extent_map_block_start(em) + extent_offset;
 
 		ASSERT(!extent_map_is_compressed(em));
 		ASSERT(block_start != EXTENT_MAP_HOLE);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index dcd191c2c4b3..9ae86125599a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -195,9 +195,10 @@ static inline u64 extent_map_block_len(const struct extent_map *em)
 
 static inline u64 extent_map_block_end(const struct extent_map *em)
 {
-	if (em->block_start + extent_map_block_len(em) < em->block_start)
+	if (extent_map_block_start(em) + extent_map_block_len(em) <
+	    extent_map_block_start(em))
 		return (u64)-1;
-	return em->block_start + extent_map_block_len(em);
+	return extent_map_block_start(em) + extent_map_block_len(em);
 }
 
 static bool can_merge_extent_map(const struct extent_map *em)
@@ -232,11 +233,11 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	if (prev->flags != next->flags)
 		return false;
 
-	if (next->block_start < EXTENT_MAP_LAST_BYTE - 1)
-		return next->block_start == extent_map_block_end(prev);
+	if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
+		return extent_map_block_start(next) == extent_map_block_end(prev);
 
 	/* HOLES and INLINE extents. */
-	return next->block_start == prev->block_start;
+	return next->disk_bytenr == prev->disk_bytenr;
 }
 
 /*
@@ -295,10 +296,9 @@ static void dump_extent_map(const char *prefix, struct extent_map *em)
 {
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
-	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu flags=0x%x\n",
+	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu flags=0x%x\n",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
-		em->ram_bytes, em->offset, em->block_start,
-		em->flags);
+		em->ram_bytes, em->offset, em->flags);
 	ASSERT(0);
 }
 
@@ -315,16 +315,6 @@ static void validate_extent_map(struct extent_map *em)
 		if (em->offset + em->len > em->disk_num_bytes &&
 		    !extent_map_is_compressed(em))
 			dump_extent_map("disk_num_bytes too small", em);
-
-		if (extent_map_is_compressed(em)) {
-			if (em->block_start != em->disk_bytenr)
-				dump_extent_map(
-				"mismatch block_start/disk_bytenr/offset", em);
-		} else {
-			if (em->block_start != em->disk_bytenr + em->offset)
-				dump_extent_map(
-				"mismatch block_start/disk_bytenr/offset", em);
-		}
 	} else {
 		if (em->offset)
 			dump_extent_map("non-zero offset for hole/inline", em);
@@ -358,7 +348,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->len += merge->len;
-			em->block_start = merge->block_start;
 			em->generation = max(em->generation, merge->generation);
 
 			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
@@ -668,11 +657,9 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	start_diff = start - em->start;
 	em->start = start;
 	em->len = end - start;
-	if (em->block_start < EXTENT_MAP_LAST_BYTE &&
-	    !extent_map_is_compressed(em)) {
-		em->block_start += start_diff;
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE &&
+	    !extent_map_is_compressed(em))
 		em->offset += start_diff;
-	}
 	return add_extent_mapping(inode, em, 0);
 }
 
@@ -707,7 +694,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 	 * Tree-checker should have rejected any inline extent with non-zero
 	 * file offset. Here just do a sanity check.
 	 */
-	if (em->block_start == EXTENT_MAP_INLINE)
+	if (em->disk_bytenr == EXTENT_MAP_INLINE)
 		ASSERT(em->start == 0);
 
 	ret = add_extent_mapping(inode, em, 0);
@@ -836,7 +823,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		u64 gen;
 		unsigned long flags;
 		bool modified;
-		bool compressed;
 
 		if (em_end < end) {
 			next_em = next_extent_map(em);
@@ -870,7 +856,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			goto remove_em;
 
 		gen = em->generation;
-		compressed = extent_map_is_compressed(em);
 
 		if (em->start < start) {
 			if (!split) {
@@ -882,15 +867,12 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->start = em->start;
 			split->len = start - em->start;
 
-			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->block_start = em->block_start;
-
+			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
 				split->disk_bytenr = em->disk_bytenr;
 				split->disk_num_bytes = em->disk_num_bytes;
 				split->offset = em->offset;
 				split->ram_bytes = em->ram_bytes;
 			} else {
-				split->block_start = em->block_start;
 				split->disk_bytenr = em->disk_bytenr;
 				split->disk_num_bytes = 0;
 				split->offset = 0;
@@ -913,20 +895,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			}
 			split->start = end;
 			split->len = em_end - end;
-			split->block_start = em->block_start;
 			split->disk_bytenr = em->disk_bytenr;
 			split->flags = flags;
 			split->generation = gen;
 
-			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
+			if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
 				split->disk_num_bytes = em->disk_num_bytes;
 				split->offset = em->offset + end - em->start;
 				split->ram_bytes = em->ram_bytes;
-				if (!compressed) {
-					const u64 diff = end - em->start;
-
-					split->block_start += diff;
-				}
 			} else {
 				split->disk_num_bytes = 0;
 				split->offset = 0;
@@ -1073,7 +1049,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 	ASSERT(em->len == len);
 	ASSERT(!extent_map_is_compressed(em));
-	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
+	ASSERT(em->disk_bytenr < EXTENT_MAP_LAST_BYTE);
 	ASSERT(em->flags & EXTENT_FLAG_PINNED);
 	ASSERT(!(em->flags & EXTENT_FLAG_LOGGING));
 	ASSERT(!list_empty(&em->list));
@@ -1087,7 +1063,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_bytenr = new_logical;
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
-	split_pre->block_start = new_logical;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1102,10 +1077,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* Insert the middle extent_map. */
 	split_mid->start = em->start + pre;
 	split_mid->len = em->len - pre;
-	split_mid->disk_bytenr = em->block_start + pre;
+	split_mid->disk_bytenr = extent_map_block_start(em) + pre;
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
-	split_mid->block_start = em->block_start + pre;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index aee721eaa7f3..a0e7f49ec88f 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -90,18 +90,6 @@ struct extent_map {
 	 */
 	u64 ram_bytes;
 
-	/*
-	 * The on-disk logical bytenr for the file extent.
-	 *
-	 * For compressed extents it matches btrfs_file_extent_item::disk_bytenr.
-	 * For uncompressed extents it matches
-	 * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset
-	 *
-	 * For holes it is EXTENT_MAP_HOLE and for inline extents it is
-	 * EXTENT_MAP_INLINE.
-	 */
-	u64 block_start;
-
 	/*
 	 * Generation of the extent map, for merged em it's the highest
 	 * generation of all merged ems.
@@ -162,6 +150,16 @@ static inline int extent_map_in_tree(const struct extent_map *em)
 	return !RB_EMPTY_NODE(&em->rb_node);
 }
 
+static inline u64 extent_map_block_start(const struct extent_map *em)
+{
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
+		if (extent_map_is_compressed(em))
+			return em->disk_bytenr;
+		return em->disk_bytenr + em->offset;
+	}
+	return em->disk_bytenr;
+}
+
 static inline u64 extent_map_end(const struct extent_map *em)
 {
 	if (em->start + em->len < em->start)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 95fb7c059a1a..b8e213a1a8ee 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1294,7 +1294,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = btrfs_file_extent_end(path) - extent_start;
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
-			em->block_start = EXTENT_MAP_HOLE;
 			em->disk_bytenr = EXTENT_MAP_HOLE;
 			em->disk_num_bytes = 0;
 			em->offset = 0;
@@ -1305,10 +1304,8 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->offset = btrfs_file_extent_offset(leaf, fi);
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
-			em->block_start = bytenr;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
-			em->block_start = bytenr;
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
@@ -1316,7 +1313,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		/* Tree-checker has ensured this. */
 		ASSERT(extent_start == 0);
 
-		em->block_start = EXTENT_MAP_INLINE;
 		em->disk_bytenr = EXTENT_MAP_INLINE;
 		em->start = 0;
 		em->len = fs_info->sectorsize;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05c7b5429b85..102b5c17ece1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2335,7 +2335,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->len = end - offset;
 		hole_em->ram_bytes = hole_em->len;
 
-		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
@@ -2368,7 +2367,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 		return PTR_ERR(em);
 
 	/* Hole or vacuum extent(only exists in no-hole mode) */
-	if (em->block_start == EXTENT_MAP_HOLE) {
+	if (em->disk_bytenr == EXTENT_MAP_HOLE) {
 		ret = 1;
 		*len = em->start + em->len > *start + *len ?
 		       0 : *start + *len - em->start - em->len;
@@ -3025,7 +3024,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
-	if (em->block_start == EXTENT_MAP_HOLE)
+	if (em->disk_bytenr == EXTENT_MAP_HOLE)
 		ret = RANGE_BOUNDARY_HOLE;
 	else if (em->flags & EXTENT_FLAG_PREALLOC)
 		ret = RANGE_BOUNDARY_PREALLOC_EXTENT;
@@ -3089,7 +3088,7 @@ static int btrfs_zero_range(struct inode *inode,
 		ASSERT(IS_ALIGNED(alloc_start, sectorsize));
 		len = offset + len - alloc_start;
 		offset = alloc_start;
-		alloc_hint = em->block_start + em->len;
+		alloc_hint = extent_map_block_start(em) + em->len;
 	}
 	free_extent_map(em);
 
@@ -3107,7 +3106,7 @@ static int btrfs_zero_range(struct inode *inode,
 							   mode);
 			goto out;
 		}
-		if (len < sectorsize && em->block_start != EXTENT_MAP_HOLE) {
+		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
@@ -3320,7 +3319,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		last_byte = min(extent_map_end(em), alloc_end);
 		actual_end = min_t(u64, extent_map_end(em), offset + len);
 		last_byte = ALIGN(last_byte, blocksize);
-		if (em->block_start == EXTENT_MAP_HOLE ||
+		if (em->disk_bytenr == EXTENT_MAP_HOLE ||
 		    (cur_offset >= inode->i_size &&
 		     !(em->flags & EXTENT_FLAG_PREALLOC))) {
 			const u64 range_len = last_byte - cur_offset;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7df295e0046d..8bc1f165193a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -138,7 +138,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 block_start,
+				       u64 len,
 				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
@@ -1209,7 +1209,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
-			  ins.objectid,			/* block_start */
 			  ins.offset,			/* orig_block_len */
 			  async_extent->ram_size,	/* ram_bytes */
 			  async_extent->compress_type,
@@ -1287,15 +1286,15 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 		 * first block in this inode and use that as a hint.  If that
 		 * block is also bogus then just don't worry about it.
 		 */
-		if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
+		if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
 			free_extent_map(em);
 			em = search_extent_mapping(em_tree, 0, 0);
-			if (em && em->block_start < EXTENT_MAP_LAST_BYTE)
-				alloc_hint = em->block_start;
+			if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
+				alloc_hint = extent_map_block_start(em);
 			if (em)
 				free_extent_map(em);
 		} else {
-			alloc_hint = em->block_start;
+			alloc_hint = extent_map_block_start(em);
 			free_extent_map(em);
 		}
 	}
@@ -1451,7 +1450,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			    &cached);
 
 		em = create_io_em(inode, start, ins.offset, /* len */
-				  ins.objectid, /* block_start */
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
@@ -2191,7 +2189,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  nocow_args.disk_bytenr, /* block_start */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  &nocow_args.file_extent,
@@ -2706,7 +2703,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			return PTR_ERR(em);
 
-		if (em->block_start != EXTENT_MAP_HOLE)
+		if (extent_map_block_start(em) != EXTENT_MAP_HOLE)
 			goto next;
 
 		em_len = em->len;
@@ -4993,7 +4990,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->start = cur_offset;
 			hole_em->len = hole_size;
 
-			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
 			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
@@ -6842,7 +6838,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	if (em) {
 		if (em->start > start || em->start + em->len <= start)
 			free_extent_map(em);
-		else if (em->block_start == EXTENT_MAP_INLINE && page)
+		else if (em->disk_bytenr == EXTENT_MAP_INLINE && page)
 			free_extent_map(em);
 		else
 			goto out;
@@ -6945,7 +6941,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		/* New extent overlaps with existing one */
 		em->start = start;
 		em->len = found_key.offset - start;
-		em->block_start = EXTENT_MAP_HOLE;
+		em->disk_bytenr = EXTENT_MAP_HOLE;
 		goto insert;
 	}
 
@@ -6969,7 +6965,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		 *
 		 * Other members are not utilized for inline extents.
 		 */
-		ASSERT(em->block_start == EXTENT_MAP_INLINE);
+		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
 		ret = read_inline_extent(inode, path, page);
@@ -6980,7 +6976,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 not_found:
 	em->start = start;
 	em->len = len;
-	em->block_start = EXTENT_MAP_HOLE;
+	em->disk_bytenr = EXTENT_MAP_HOLE;
 insert:
 	ret = 0;
 	btrfs_release_path(path);
@@ -7011,7 +7007,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
-						  const u64 block_start,
 						  const u64 orig_block_len,
 						  const u64 ram_bytes,
 						  const int type,
@@ -7021,15 +7016,38 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, block_start,
+		em = create_io_em(inode, start, len,
 				  orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
+
+	/*
+	 * NOTE: I know the numbers are totally wrong for NOCOW/PREALLOC,
+	 * but it doesn't cause problem at least for now.
+	 *
+	 * For regular writes, we would have file_extent->offset as 0,
+	 * thus we really only need disk_bytenr, every other length
+	 * (disk_num_bytes/ram_bytes) would match @len and fe->num_bytes.
+	 * The current numbers are totally fine.
+	 *
+	 * For NOCOW, we don't really care about the numbers except @file_pos
+	 * and @num_bytes, as we won't insert a file extent item at all.
+	 *
+	 * For PREALLOC, we do not use ordered extent's member, but
+	 * btrfs_mark_extent_written() would handle everything.
+	 *
+	 * So here we intentionally go with pseudo numbers for the NOCOW/PREALLOC
+	 * OEs, or btrfs_extract_ordered_extent() would need a completely new
+	 * routine to handle NOCOW/PREALLOC splits, meanwhile result nothing
+	 * different.
+	 */
 	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
-					     block_start, len, 0,
+					     file_extent->disk_bytenr +
+					     file_extent->offset,
+					     len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7081,7 +7099,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
 	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.objectid, ins.offset,
+				     ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     &file_extent);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7321,7 +7339,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 block_start,
+				       u64 len,
 				       u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
@@ -7373,7 +7391,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	em->start = start;
 	em->len = len;
-	em->block_start = block_start;
 	em->disk_bytenr = file_extent->disk_bytenr;
 	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
@@ -7424,13 +7441,13 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 */
 	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
 	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
-	     em->block_start != EXTENT_MAP_HOLE)) {
+	     em->disk_bytenr != EXTENT_MAP_HOLE)) {
 		if (em->flags & EXTENT_FLAG_PREALLOC)
 			type = BTRFS_ORDERED_PREALLOC;
 		else
 			type = BTRFS_ORDERED_NOCOW;
 		len = min(len, em->len - (start - em->start));
-		block_start = em->block_start + (start - em->start);
+		block_start = extent_map_block_start(em) + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len,
 				     &orig_block_len, &ram_bytes,
@@ -7460,7 +7477,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		space_reserved = true;
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      block_start,
 					      orig_block_len,
 					      ram_bytes, type,
 					      &file_extent);
@@ -7663,7 +7679,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * the generic code.
 	 */
 	if (extent_map_is_compressed(em) ||
-	    em->block_start == EXTENT_MAP_INLINE) {
+	    em->disk_bytenr == EXTENT_MAP_INLINE) {
 		free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
@@ -7757,12 +7773,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * We trim the extents (and move the addr) even though iomap code does
 	 * that, since we have locked only the parts we are performing I/O in.
 	 */
-	if ((em->block_start == EXTENT_MAP_HOLE) ||
+	if ((em->disk_bytenr == EXTENT_MAP_HOLE) ||
 	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
 	} else {
-		iomap->addr = em->block_start + (start - em->start);
+		iomap->addr = extent_map_block_start(em) + (start - em->start);
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
@@ -9612,7 +9628,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		em->start = cur_offset;
 		em->len = ins.offset;
-		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
 		em->offset = 0;
 		em->disk_num_bytes = ins.offset;
@@ -10078,7 +10093,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out_unlock_extent;
 	}
 
-	if (em->block_start == EXTENT_MAP_INLINE) {
+	if (em->disk_bytenr == EXTENT_MAP_INLINE) {
 		u64 extent_start = em->start;
 
 		/*
@@ -10099,14 +10114,14 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	encoded->len = min_t(u64, extent_map_end(em),
 			     inode->vfs_inode.i_size) - iocb->ki_pos;
-	if (em->block_start == EXTENT_MAP_HOLE ||
+	if (em->disk_bytenr == EXTENT_MAP_HOLE ||
 	    (em->flags & EXTENT_FLAG_PREALLOC)) {
 		disk_bytenr = EXTENT_MAP_HOLE;
 		count = min_t(u64, count, encoded->len);
 		encoded->len = count;
 		encoded->unencoded_len = count;
 	} else if (extent_map_is_compressed(em)) {
-		disk_bytenr = em->block_start;
+		disk_bytenr = em->disk_bytenr;
 		/*
 		 * Bail if the buffer isn't large enough to return the whole
 		 * compressed extent.
@@ -10125,7 +10140,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_em;
 		encoded->compression = ret;
 	} else {
-		disk_bytenr = em->block_start + (start - em->start);
+		disk_bytenr = extent_map_block_start(em) + (start - em->start);
 		if (encoded->len > count)
 			encoded->len = count;
 		/*
@@ -10363,7 +10378,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
-			  ins.objectid,
 			  ins.offset, ram_bytes, compression,
 			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
@@ -10667,12 +10681,12 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			goto out;
 		}
 
-		if (em->block_start == EXTENT_MAP_HOLE) {
+		if (em->disk_bytenr == EXTENT_MAP_HOLE) {
 			btrfs_warn(fs_info, "swapfile must not have holes");
 			ret = -EINVAL;
 			goto out;
 		}
-		if (em->block_start == EXTENT_MAP_INLINE) {
+		if (em->disk_bytenr == EXTENT_MAP_INLINE) {
 			/*
 			 * It's unlikely we'll ever actually find ourselves
 			 * here, as a file small enough to fit inline won't be
@@ -10690,7 +10704,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			goto out;
 		}
 
-		logical_block_start = em->block_start + (start - em->start);
+		logical_block_start = extent_map_block_start(em) + (start - em->start);
 		len = min(len, em->len - (start - em->start));
 		free_extent_map(em);
 		em = NULL;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a66d9b921f84..0d462c2a9c89 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2912,7 +2912,6 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 
 	em->start = start;
 	em->len = end + 1 - start;
-	em->block_start = block_start;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = em->len;
 	em->ram_bytes = em->len;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ffdaa6a682af..a145214be14b 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -28,8 +28,8 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 		if (refcount_read(&em->refs) != 1) {
 			ret = -EINVAL;
 			test_err(
-"em leak: em (start %llu len %llu block_start %llu disk_num_bytes %llu offset %llu) refs %d",
-				 em->start, em->len, em->block_start,
+"em leak: em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu offset %llu) refs %d",
+				 em->start, em->len, em->disk_bytenr,
 				 em->disk_num_bytes, em->offset,
 				 refcount_read(&em->refs));
 
@@ -77,7 +77,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* Add [0, 16K) */
 	em->start = 0;
 	em->len = SZ_16K;
-	em->block_start = 0;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -100,7 +99,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	em->start = SZ_16K;
 	em->len = SZ_4K;
-	em->block_start = SZ_32K; /* avoid merging */
 	em->disk_bytenr = SZ_32K; /* avoid merging */
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -123,7 +121,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* Add [0, 8K), should return [0, 16K) instead. */
 	em->start = start;
 	em->len = len;
-	em->block_start = start;
 	em->disk_bytenr = start;
 	em->disk_num_bytes = len;
 	em->ram_bytes = len;
@@ -141,11 +138,11 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 	if (em->start != 0 || extent_map_end(em) != SZ_16K ||
-	    em->block_start != 0 || em->disk_num_bytes != SZ_16K) {
+	    em->disk_bytenr != 0 || em->disk_num_bytes != SZ_16K) {
 		test_err(
-"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_start %llu disk_num_bytes %llu",
+"case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu",
 			 start, start + len, ret, em->start, em->len,
-			 em->block_start, em->disk_num_bytes);
+			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -179,7 +176,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* Add [0, 1K) */
 	em->start = 0;
 	em->len = SZ_1K;
-	em->block_start = EXTENT_MAP_INLINE;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -202,7 +198,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	em->start = SZ_4K;
 	em->len = SZ_4K;
-	em->block_start = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -225,7 +220,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* Add [0, 1K) */
 	em->start = 0;
 	em->len = SZ_1K;
-	em->block_start = EXTENT_MAP_INLINE;
 	em->disk_bytenr = EXTENT_MAP_INLINE;
 	em->disk_num_bytes = 0;
 	em->ram_bytes = SZ_1K;
@@ -242,10 +236,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 	if (em->start != 0 || extent_map_end(em) != SZ_1K ||
-	    em->block_start != EXTENT_MAP_INLINE) {
+	    em->disk_bytenr != EXTENT_MAP_INLINE) {
 		test_err(
-"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start %llu",
-			 ret, em->start, em->len, em->block_start);
+"case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu",
+			 ret, em->start, em->len, em->disk_bytenr);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -275,7 +269,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	/* Add [4K, 8K) */
 	em->start = SZ_4K;
 	em->len = SZ_4K;
-	em->block_start = SZ_4K;
 	em->disk_bytenr = SZ_4K;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_4K;
@@ -298,7 +291,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	/* Add [0, 16K) */
 	em->start = 0;
 	em->len = SZ_16K;
-	em->block_start = 0;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -321,11 +313,11 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	 * em->start.
 	 */
 	if (start < em->start || start + len > extent_map_end(em) ||
-	    em->start != em->block_start) {
+	    em->start != extent_map_block_start(em)) {
 		test_err(
-"case3 [%llu %llu): ret %d em (start %llu len %llu block_start %llu block_len %llu)",
+"case3 [%llu %llu): ret %d em (start %llu len %llu disk_bytenr %llu block_len %llu)",
 			 start, start + len, ret, em->start, em->len,
-			 em->block_start, em->disk_num_bytes);
+			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -386,7 +378,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	/* Add [0K, 8K) */
 	em->start = 0;
 	em->len = SZ_8K;
-	em->block_start = 0;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_8K;
 	em->ram_bytes = SZ_8K;
@@ -409,7 +400,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	/* Add [8K, 32K) */
 	em->start = SZ_8K;
 	em->len = 24 * SZ_1K;
-	em->block_start = SZ_16K; /* avoid merging */
 	em->disk_bytenr = SZ_16K; /* avoid merging */
 	em->disk_num_bytes = 24 * SZ_1K;
 	em->ram_bytes = 24 * SZ_1K;
@@ -431,7 +421,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	/* Add [0K, 32K) */
 	em->start = 0;
 	em->len = SZ_32K;
-	em->block_start = 0;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_32K;
 	em->ram_bytes = SZ_32K;
@@ -451,9 +440,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	if (start < em->start || start + len > extent_map_end(em)) {
 		test_err(
-"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_start %llu disk_num_bytes %llu)",
-			 start, start + len, ret, em->start, em->len, em->block_start,
-			 em->disk_num_bytes);
+"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu)",
+			 start, start + len, ret, em->start, em->len,
+			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
 	free_extent_map(em);
@@ -517,7 +506,6 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 
 	em->start = start;
 	em->len = len;
-	em->block_start = block_start;
 	em->disk_bytenr = block_start;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = len;
@@ -740,7 +728,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	em->start = SZ_4K;
 	em->len = SZ_4K;
-	em->block_start = SZ_16K;
 	em->disk_bytenr = SZ_16K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -795,7 +782,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* [0, 16K), pinned */
 	em->start = 0;
 	em->len = SZ_16K;
-	em->block_start = 0;
 	em->disk_bytenr = 0;
 	em->disk_num_bytes = SZ_4K;
 	em->ram_bytes = SZ_16K;
@@ -819,7 +805,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	/* [32K, 48K), not pinned */
 	em->start = SZ_32K;
 	em->len = SZ_16K;
-	em->block_start = SZ_32K;
 	em->disk_bytenr = SZ_32K;
 	em->disk_num_bytes = SZ_16K;
 	em->ram_bytes = SZ_16K;
@@ -885,8 +870,9 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	if (em->block_start != SZ_32K + SZ_4K) {
-		test_err("em->block_start is %llu, expected 36K", em->block_start);
+	if (extent_map_block_start(em) != SZ_32K + SZ_4K) {
+		test_err("em->block_start is %llu, expected 36K",
+				extent_map_block_start(em));
 		goto out;
 	}
 
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 1b8c39edfc18..d6fd1978934a 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -264,8 +264,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
+		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	free_extent_map(em);
@@ -283,8 +283,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_INLINE) {
-		test_err("expected an inline, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_INLINE) {
+		test_err("expected an inline, got %llu", em->disk_bytenr);
 		goto out;
 	}
 
@@ -321,8 +321,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
+		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != 4) {
@@ -344,8 +344,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize - 1) {
@@ -371,8 +371,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -389,7 +389,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	disk_bytenr = em->block_start;
+	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -399,8 +399,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
+		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -421,8 +421,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != 2 * sectorsize) {
@@ -441,9 +441,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	disk_bytenr += (em->start - orig_start);
-	if (em->block_start != disk_bytenr) {
+	if (extent_map_block_start(em) != disk_bytenr) {
 		test_err("wrong block start, want %llu, have %llu",
-			 disk_bytenr, em->block_start);
+			 disk_bytenr, extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -455,8 +455,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -483,8 +483,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -502,7 +502,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	disk_bytenr = em->block_start;
+	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -512,8 +512,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_HOLE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_HOLE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -531,9 +531,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start - orig_start, em->offset);
 		goto out;
 	}
-	if (em->block_start != disk_bytenr + em->offset) {
+	if (extent_map_block_start(em) != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + em->offset, em->block_start);
+			 disk_bytenr + em->offset, extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -544,8 +544,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != 2 * sectorsize) {
@@ -564,9 +564,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start - orig_start, em->offset);
 		goto out;
 	}
-	if (em->block_start != disk_bytenr + em->offset) {
+	if (extent_map_block_start(em) != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + em->offset, em->block_start);
+			 disk_bytenr + em->offset, extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -578,8 +578,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != 2 * sectorsize) {
@@ -611,8 +611,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -635,7 +635,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
 		goto out;
 	}
-	disk_bytenr = em->block_start;
+	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -645,8 +645,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -671,9 +671,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != disk_bytenr) {
+	if (extent_map_block_start(em) != disk_bytenr) {
 		test_err("block start does not match, want %llu got %llu",
-			 disk_bytenr, em->block_start);
+			 disk_bytenr, extent_map_block_start(em));
 		goto out;
 	}
 	if (em->start != offset || em->len != 2 * sectorsize) {
@@ -706,8 +706,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -732,8 +732,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole extent, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
+		test_err("expected a hole extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	/*
@@ -764,8 +764,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
+		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != offset || em->len != sectorsize) {
@@ -843,8 +843,8 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->block_start);
+	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
+		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
 	if (em->start != 0 || em->len != sectorsize) {
@@ -865,8 +865,9 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (em->block_start != sectorsize) {
-		test_err("expected a real extent, got %llu", em->block_start);
+	if (extent_map_block_start(em) != sectorsize) {
+		test_err("expected a real extent, got %llu",
+			 extent_map_block_start(em));
 		goto out;
 	}
 	if (em->start != sectorsize || em->len != sectorsize) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 13f35180e3a0..c4b67bf993d6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4575,6 +4575,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_root *csum_root;
+	u64 block_start;
 	u64 csum_offset;
 	u64 csum_len;
 	u64 mod_start = em->start;
@@ -4584,7 +4585,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 
 	if (inode->flags & BTRFS_INODE_NODATASUM ||
 	    (em->flags & EXTENT_FLAG_PREALLOC) ||
-	    em->block_start == EXTENT_MAP_HOLE)
+	    em->disk_bytenr == EXTENT_MAP_HOLE)
 		return 0;
 
 	list_for_each_entry(ordered, &ctx->ordered_extents, log_list) {
@@ -4655,9 +4656,10 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	}
 
 	/* block start is already adjusted for the file extent offset. */
-	csum_root = btrfs_csum_root(trans->fs_info, em->block_start);
-	ret = btrfs_lookup_csums_list(csum_root, em->block_start + csum_offset,
-				      em->block_start + csum_offset +
+	block_start = extent_map_block_start(em);
+	csum_root = btrfs_csum_root(trans->fs_info, block_start);
+	ret = btrfs_lookup_csums_list(csum_root, block_start + csum_offset,
+				      block_start + csum_offset +
 				      csum_len - 1, &ordered_sums, false);
 	if (ret < 0)
 		return ret;
@@ -4689,6 +4691,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	enum btrfs_compression_type compress_type;
 	u64 extent_offset = em->offset;
+	u64 block_start = extent_map_block_start(em);
 	u64 block_len;
 	int ret;
 
@@ -4701,10 +4704,10 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	block_len = em->disk_num_bytes;
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
-		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
+		btrfs_set_stack_file_extent_disk_bytenr(&fi, block_start);
 		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
-	} else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start -
+	} else if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
+		btrfs_set_stack_file_extent_disk_bytenr(&fi, block_start -
 							extent_offset);
 		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4b52a8916dbb..6d0f7fc9aaf2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1778,7 +1778,9 @@ static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 	write_lock(&em_tree->lock);
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
-	em->block_start = logical;
+	/* The em should be a new COW extent, thus it should not has offset. */
+	ASSERT(em->offset == 0);
+	em->disk_bytenr = logical;
 	free_extent_map(em);
 	write_unlock(&em_tree->lock);
 }
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 3743719d13f2..89b2b66e5bc0 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -291,7 +291,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__field(	u64,  ino		)
 		__field(	u64,  start		)
 		__field(	u64,  len		)
-		__field(	u64,  block_start	)
 		__field(	u32,  flags		)
 		__field(	int,  refs		)
 	),
@@ -301,18 +300,16 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__entry->ino		= btrfs_ino(inode);
 		__entry->start		= map->start;
 		__entry->len		= map->len;
-		__entry->block_start	= map->block_start;
 		__entry->flags		= map->flags;
 		__entry->refs		= refcount_read(&map->refs);
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu "
-		  "block_start=%llu(%s) flags=%s refs=%u",
+		  "flags=%s refs=%u",
 		  show_root_type(__entry->root_objectid),
 		  __entry->ino,
 		  __entry->start,
 		  __entry->len,
-		  show_map_type(__entry->block_start),
 		  show_map_flags(__entry->flags),
 		  __entry->refs)
 );
@@ -2608,7 +2605,6 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
 		__field(	u64,	root_id		)
 		__field(	u64,	start		)
 		__field(	u64,	len		)
-		__field(	u64,	block_start	)
 		__field(	u32,	flags		)
 	),
 
@@ -2617,15 +2613,12 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
 		__entry->root_id	= inode->root->root_key.objectid;
 		__entry->start		= em->start;
 		__entry->len		= em->len;
-		__entry->block_start	= em->block_start;
 		__entry->flags		= em->flags;
 	),
 
-	TP_printk_btrfs(
-"ino=%llu root=%llu(%s) start=%llu len=%llu block_start=%llu(%s) flags=%s",
+	TP_printk_btrfs("ino=%llu root=%llu(%s) start=%llu len=%llu flags=%s",
 			__entry->ino, show_root_type(__entry->root_id),
 			__entry->start, __entry->len,
-			show_map_type(__entry->block_start),
 			show_map_flags(__entry->flags))
 );
 
-- 
2.45.0


