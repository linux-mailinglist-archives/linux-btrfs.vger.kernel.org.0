Return-Path: <linux-btrfs+bounces-4640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208B8B65AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FBA1F225CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB10194C91;
	Mon, 29 Apr 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWENVoDg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWENVoDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FCE194C81
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429421; cv=none; b=D+fUMbH/RC6BHpf4l60is/LxQcauscv45W4ctMYGU0mSzmgjCi1hk4S2o9ZHvQggMCX98rjrZRwIUVZd1PMI6fu9nspNb7l3iLCDNfI99Mju6MOYVncsUiYMncDpewqi6+9ydn7+HA1IhLpophMz3B+UuPgjWxWXTBgfCTlQliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429421; c=relaxed/simple;
	bh=zPrYo+qt2fGy/HmYxEc20D5QWzL1WRL0OnN7Uq0h5vQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvUflqSI+6EgOEkKnmKq4bGywO5g8XbzUaBYgG0mJ5Az5QoFWTGzf1y73TQOiRH1MtrcoS+8I1q3DjYkwuFlwNK4luQZUhKb1enenHh0ADnxP6lDDsd3+NQi+IF4+CjBbevObRuFuAJPYta7fB9AqF6SXuJOUYJsgRIIvPoCUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWENVoDg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWENVoDg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46FBC1F788
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxo0D++Zni8eq081HbfNLNq0bs7EDynxs9+OF2ulSXw=;
	b=WWENVoDgiZ+FAh+SIHq0NYkYMz55en1EalzjYRkZI1m1udIbv5yntE5ake/MZpCLkfkA+F
	lxsphns2m5/l08SsZfBK/RlTaYdmt4MIOCyLvHKofXPBOCOJ3Yrnbmq2jecnJatDu6WCbB
	WguFZfhVHk+bQx7CTwg3AWstpwnkwAE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WWENVoDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vxo0D++Zni8eq081HbfNLNq0bs7EDynxs9+OF2ulSXw=;
	b=WWENVoDgiZ+FAh+SIHq0NYkYMz55en1EalzjYRkZI1m1udIbv5yntE5ake/MZpCLkfkA+F
	lxsphns2m5/l08SsZfBK/RlTaYdmt4MIOCyLvHKofXPBOCOJ3Yrnbmq2jecnJatDu6WCbB
	WguFZfhVHk+bQx7CTwg3AWstpwnkwAE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD0A139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIZvM+cdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs: introduce extra sanity checks for extent maps
Date: Tue, 30 Apr 2024 07:53:03 +0930
Message-ID: <36f97899fd2aa52fe6b042ef3d5e2a23f04fa9d2.1714428940.git.wqu@suse.com>
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 46FBC1F788
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

Since extent_map structure has the all the needed members to represent a
file extent directly, we can apply all the file extent sanity checks to an extent
map.

The new sanity checks would cross check both the old members
(block_start/block_len/orig_start) and the new members
(disk_bytenr/disk_num_bytes/offset).

There is a special case for offset/orig_start/start cross check, we only
do such sanity check for compressed extent:

- Only compressed read/encoded write really utilize orig_start
  This can be proved by the cleanup patch of orig_start.

- Merged data extents can lead to false alerts
  The problem is, with disk_bytenr/disk_num_bytes, if we're merging
  two extent maps like this:

    |<- data extent A -->|<-- data extent B -->|
              |<- em 1 ->|<- em 2 ->|

  Let's assume em2 has orig_offset of 0 and start of 0, and obvisouly
  offset 0.

  But after merging, the merged em would have offset of em1, screwing up
  whatever the @orig_start cross check against @start.

The checks happens at the following timing:

- add_extent_mapping()
  This is for newly added extent map

- replace_extent_mapping()
  This is for btrfs_drop_extent_map_range() and split_extent_map()

- try_merge_map()

Since the check is way more strict than before, the following code has
to be modified to pass the check:

- extent-map-tests
  Previously the test case never populate ram_bytes, not to mention the
  newly introduced disk_bytenr/disk_num_bytes.
  Populate the involved numbers mostly to follow the existing
  block_start/block_len values.

  There are two special cases worth mentioning:
  - test_case_3()
    The test case is already way too invalid that tree-checker will
    reject almost all extents.

    And there is a special unaligned regular extent which has mismatch
    disk_num_bytes (4096) and ram_bytes (4096 - 1).
    Fix it by all assigned the disk_num_bytes and ram_bytes to 4096 - 1.

  - test_case_7()
    An extent is inserted with 16K length, but on-disk extent size is
    only 4K.
    This means it must be a compressed extent, so set the compressed flag
    for it.

- setup_relocation_extent_mapping()
  This is mostly utilized by relocation code to read the chunk like an
  inode.
  So populate the extent map using a regular non-compressed extent.

In fact, the new cross checks already exposed a bug in
btrfs_drop_extent_map_range(), and caught tons of bugs in the new
members assignment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c             | 66 +++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c             |  4 ++
 fs/btrfs/tests/extent-map-tests.c | 56 +++++++++++++++++++++++++-
 fs/btrfs/tests/inode-tests.c      |  2 +-
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4d4ac9fc43e2..8d0e257fc113 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -284,6 +284,66 @@ static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *nex
 	next->offset = new_offset;
 }
 
+static void dump_extent_map(const char *prefix, struct extent_map *em)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
+		return;
+	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu orig_start=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
+		em->ram_bytes, em->offset, em->orig_start, em->block_start,
+		em->block_len, em->flags);
+	ASSERT(0);
+}
+
+/* Internal sanity checks for btrfs debug builds. */
+static void validate_extent_map(struct extent_map *em)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
+		return;
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
+		if (em->disk_num_bytes == 0)
+			dump_extent_map("zero disk_num_bytes", em);
+		if (em->offset + em->len > em->ram_bytes)
+			dump_extent_map("ram_bytes too small", em);
+		if (em->offset + em->len > em->disk_num_bytes &&
+		    !extent_map_is_compressed(em))
+			dump_extent_map("disk_num_bytes too small", em);
+
+		if (extent_map_is_compressed(em)) {
+			if (em->block_start != em->disk_bytenr)
+				dump_extent_map(
+				"mismatch block_start/disk_bytenr/offset", em);
+			if (em->disk_num_bytes != em->block_len)
+				dump_extent_map(
+				"mismatch disk_num_bytes/block_len", em);
+			/*
+			 * Here we only check the start/orig_start/offset for
+			 * compressed extents.
+			 * This is because em::offset is always based on the
+			 * referred data extent, which can be merged.
+			 *
+			 * In that case, @offset would no longer match
+			 * em::start - em::orig_start, and cause false alert.
+			 *
+			 * Thankfully only compressed extent read/encoded write
+			 * really bothers @orig_start, so we can skip
+			 * the check for non-compressed extents.
+			 */
+			if (em->orig_start != em->start - em->offset)
+				dump_extent_map(
+				"mismatch orig_start/offset/start", em);
+
+		} else {
+			if (em->block_start != em->disk_bytenr + em->offset)
+				dump_extent_map(
+				"mismatch block_start/disk_bytenr/offset", em);
+		}
+	} else {
+		if (em->offset)
+			dump_extent_map("non-zero offset for hole/inline", em);
+	}
+}
+
 static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
@@ -320,6 +380,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 				merge_ondisk_extents(merge, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
+			validate_extent_map(em);
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
@@ -335,6 +396,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		em->block_len += merge->block_len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
+		validate_extent_map(em);
 		rb_erase_cached(&merge->rb_node, &tree->map);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
@@ -446,6 +508,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 
 	lockdep_assert_held_write(&tree->lock);
 
+	validate_extent_map(em);
 	ret = tree_insert(&tree->map, em);
 	if (ret)
 		return ret;
@@ -553,6 +616,9 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 
 	lockdep_assert_held_write(&tree->lock);
 
+	validate_extent_map(cur);
+	validate_extent_map(new);
+
 	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
 	ASSERT(extent_map_in_tree(cur));
 	if (!(cur->flags & EXTENT_FLAG_LOGGING))
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5cf5718c3b1f..277b03709537 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2911,9 +2911,13 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 		return -ENOMEM;
 
 	em->start = start;
+	em->orig_start = start;
 	em->len = end + 1 - start;
 	em->block_len = em->len;
 	em->block_start = block_start;
+	em->disk_bytenr = block_start;
+	em->disk_num_bytes = em->len;
+	em->ram_bytes = em->len;
 	em->flags |= EXTENT_FLAG_PINNED;
 
 	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ba36794ba2d5..8c683eed9f27 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -78,6 +78,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_16K;
+	em->disk_bytenr = 0;
+	em->disk_num_bytes = SZ_16K;
+	em->ram_bytes = SZ_16K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -96,9 +99,13 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_16K;
+	em->orig_start = SZ_16K;
 	em->len = SZ_4K;
 	em->block_start = SZ_32K; /* avoid merging */
 	em->block_len = SZ_4K;
+	em->disk_bytenr = SZ_32K; /* avoid merging */
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_4K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -117,9 +124,13 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* Add [0, 8K), should return [0, 16K) instead. */
 	em->start = start;
+	em->orig_start = start;
 	em->len = len;
 	em->block_start = start;
 	em->block_len = len;
+	em->disk_bytenr = start;
+	em->disk_num_bytes = len;
+	em->ram_bytes = len;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -174,6 +185,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
+	em->disk_bytenr = EXTENT_MAP_INLINE;
+	em->disk_num_bytes = 0;
+	em->ram_bytes = SZ_1K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -192,9 +206,13 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_4K;
+	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
+	em->disk_bytenr = SZ_4K;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_4K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -216,6 +234,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
+	em->disk_bytenr = EXTENT_MAP_INLINE;
+	em->disk_num_bytes = 0;
+	em->ram_bytes = SZ_1K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -262,9 +283,13 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 
 	/* Add [4K, 8K) */
 	em->start = SZ_4K;
+	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
+	em->disk_bytenr = SZ_4K;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_4K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -286,6 +311,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_16K;
+	em->disk_bytenr = 0;
+	em->disk_num_bytes = SZ_16K;
+	em->ram_bytes = SZ_16K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, start, len);
 	write_unlock(&em_tree->lock);
@@ -372,6 +400,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->len = SZ_8K;
 	em->block_start = 0;
 	em->block_len = SZ_8K;
+	em->disk_bytenr = 0;
+	em->disk_num_bytes = SZ_8K;
+	em->ram_bytes = SZ_8K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -390,9 +421,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 
 	/* Add [8K, 32K) */
 	em->start = SZ_8K;
+	em->orig_start = SZ_8K;
 	em->len = 24 * SZ_1K;
 	em->block_start = SZ_16K; /* avoid merging */
 	em->block_len = 24 * SZ_1K;
+	em->disk_bytenr = SZ_16K; /* avoid merging */
+	em->disk_num_bytes = 24 * SZ_1K;
+	em->ram_bytes = 24 * SZ_1K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -410,9 +445,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	/* Add [0K, 32K) */
 	em->start = 0;
+	em->orig_start = 0;
 	em->len = SZ_32K;
 	em->block_start = 0;
 	em->block_len = SZ_32K;
+	em->disk_bytenr = 0;
+	em->disk_num_bytes = SZ_32K;
+	em->ram_bytes = SZ_32K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, start, len);
 	write_unlock(&em_tree->lock);
@@ -494,9 +533,13 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	}
 
 	em->start = start;
+	em->orig_start = start;
 	em->len = len;
 	em->block_start = block_start;
 	em->block_len = SZ_4K;
+	em->disk_bytenr = block_start;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = len;
 	em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
@@ -715,9 +758,13 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_4K;
+	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_16K;
 	em->block_len = SZ_16K;
+	em->disk_bytenr = SZ_16K;
+	em->disk_num_bytes = SZ_16K;
+	em->ram_bytes = SZ_16K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, 0, SZ_8K);
 	write_unlock(&em_tree->lock);
@@ -771,7 +818,10 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_4K;
-	em->flags |= EXTENT_FLAG_PINNED;
+	em->disk_bytenr = 0;
+	em->disk_num_bytes = SZ_4K;
+	em->ram_bytes = SZ_16K;
+	em->flags |= (EXTENT_FLAG_PINNED | EXTENT_FLAG_COMPRESS_ZLIB);
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -790,9 +840,13 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* [32K, 48K), not pinned */
 	em->start = SZ_32K;
+	em->orig_start = SZ_32K;
 	em->len = SZ_16K;
 	em->block_start = SZ_32K;
 	em->block_len = SZ_16K;
+	em->disk_bytenr = SZ_32K;
+	em->disk_num_bytes = SZ_16K;
+	em->ram_bytes = SZ_16K;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 99da9d34b77a..0895c6e06812 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -117,7 +117,7 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 
 	/* Now for a regular extent */
 	insert_extent(root, offset, sectorsize - 1, sectorsize - 1, 0,
-		      disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
+		      disk_bytenr, sectorsize - 1, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	disk_bytenr += sectorsize;
 	offset += sectorsize - 1;
-- 
2.44.0


