Return-Path: <linux-btrfs+bounces-5230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1C8CCB95
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5872834DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43DC13B2B8;
	Thu, 23 May 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="euobHmlF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="euobHmlF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAC38DF2
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440640; cv=none; b=eeqwRB3v0U92i6wOIGiPjCd6CZqo2Nxc5ESFwzXOoxLPOWUELz5U73r6941eNjgw02/Dkv1RM50si27ZiAEMTTj8eFxlX3I/BmBTJXfL0Xk4TIZS6VYw6qA8y8tIZW9erkhPcG8MlB3tYuxbqWpuBzLOpcUXfx78n7YYTlXzpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440640; c=relaxed/simple;
	bh=rZDVL2LHpUJJI1ojAHr+MfGoBtSRsL4ZqLRUOkM12Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1PZryiku+31veMSXgV9UITLqp/zjYNzr6x4YZDNNiSD2WIC6uTwXy1PbKfshtZrhuJrTbxPnEeA+yKx3+Sb9HYjdBwZ/jKOdthk/7Poa5rk+XgivNatwGM38cb9kdCSjPhrtFdmqgGc+eF9sxFt+V9nSEku+rY2akRJtpzO0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=euobHmlF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=euobHmlF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A709220E2;
	Thu, 23 May 2024 05:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NoLHlp05y0tWLldDpP2SGxvSyjA0eQlvLmCIXFOBxk=;
	b=euobHmlFYlMewug/LX/7TvSc6Pg0lDB0X6SVrkeMRrpEPQjparjjnAuYRnq8augeTq9v3B
	MtCX5eY7RPTq0YRCq3lkOUOJ6+4iBgwtT3wXlTf+nI5RlMsvOMDS+/GGNgioaNU7cX9cnP
	rBgI+XF9rZP4VRcm631gzzqi1Up9m1E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=euobHmlF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NoLHlp05y0tWLldDpP2SGxvSyjA0eQlvLmCIXFOBxk=;
	b=euobHmlFYlMewug/LX/7TvSc6Pg0lDB0X6SVrkeMRrpEPQjparjjnAuYRnq8augeTq9v3B
	MtCX5eY7RPTq0YRCq3lkOUOJ6+4iBgwtT3wXlTf+nI5RlMsvOMDS+/GGNgioaNU7cX9cnP
	rBgI+XF9rZP4VRcm631gzzqi1Up9m1E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D18A813A6B;
	Thu, 23 May 2024 05:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0MnqIDvOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 04/11] btrfs: introduce extra sanity checks for extent maps
Date: Thu, 23 May 2024 14:33:23 +0930
Message-ID: <a9fa2b3ca93da520f65410ce9fc5ef7d626227d5.1716440169.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1A709220E2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Since extent_map structure has the all the needed members to represent a
file extent directly, we can apply all the file extent sanity checks to an extent
map.

The new sanity checks would cross check both the old members
(block_start/block_len/orig_start) and the new members
(disk_bytenr/disk_num_bytes/offset).

There is a special case for offset/orig_start/start cross check, we only
do such sanity check for compressed extent, as only compressed
read/encoded write really utilize orig_start.
This can be proved by the cleanup patch of orig_start.

The checks happens at the following timing:

- add_extent_mapping()
  This is for newly added extent map

- replace_extent_mapping()
  This is for btrfs_drop_extent_map_range() and split_extent_map()

- try_merge_map()

For a lot of call sites we have to properly populate all the members to
pass the sanity check, meanwhile the following code needs extra
modification:

- setup_file_extents() from inode-tests
  The file extents layout of setup_file_extents() is already too invalid
  that tree-checker would reject most of them in real world.

  However there is just a special unaligned regular extent which has
  mismatched disk_num_bytes (4096) and ram_bytes (4096 - 1).
  So instead of dropping the whole test case, here we just unify
  disk_num_bytes and ram_bytes to 4096 - 1.

- test_case_7() from extent-map-tests
  An extent is inserted with 16K length, but on-disk extent size is
  only 4K.
  This means it must be a compressed extent, so set the compressed flag
  for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c             | 60 +++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c             |  4 +++
 fs/btrfs/tests/extent-map-tests.c | 56 ++++++++++++++++++++++++++++-
 fs/btrfs/tests/inode-tests.c      |  2 +-
 4 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c7d2393692e6..b157f30ac241 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -283,8 +283,62 @@ static void merge_ondisk_extents(struct extent_map *prev, struct extent_map *nex
 	next->offset = new_offset;
 }
 
+static void dump_extent_map(struct btrfs_fs_info *fs_info,
+			    const char *prefix, struct extent_map *em)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
+		return;
+	btrfs_crit(fs_info, "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu orig_start=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
+		em->ram_bytes, em->offset, em->orig_start, em->block_start,
+		em->block_len, em->flags);
+	ASSERT(0);
+}
+
+/* Internal sanity checks for btrfs debug builds. */
+static void validate_extent_map(struct btrfs_fs_info *fs_info,
+				struct extent_map *em)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
+		return;
+	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
+		if (em->disk_num_bytes == 0)
+			dump_extent_map(fs_info, "zero disk_num_bytes", em);
+		if (em->offset + em->len > em->ram_bytes)
+			dump_extent_map(fs_info, "ram_bytes too small", em);
+		if (em->offset + em->len > em->disk_num_bytes &&
+		    !extent_map_is_compressed(em))
+			dump_extent_map(fs_info, "disk_num_bytes too small", em);
+
+		if (extent_map_is_compressed(em)) {
+			if (em->block_start != em->disk_bytenr)
+				dump_extent_map(fs_info,
+				"mismatch block_start/disk_bytenr/offset", em);
+			if (em->disk_num_bytes != em->block_len)
+				dump_extent_map(fs_info,
+				"mismatch disk_num_bytes/block_len", em);
+			/*
+			 * Here we only check the start/orig_start/offset for
+			 * compressed extents as that's the only case where
+			 * orig_start is utilized.
+			 */
+			if (em->orig_start != em->start - em->offset)
+				dump_extent_map(fs_info,
+				"mismatch orig_start/offset/start", em);
+
+		} else if (em->block_start != em->disk_bytenr + em->offset) {
+			dump_extent_map(fs_info,
+				"mismatch block_start/disk_bytenr/offset", em);
+		}
+	} else if (em->offset) {
+		dump_extent_map(fs_info,
+				"non-zero offset for hole/inline", em);
+	}
+}
+
 static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *tree = &inode->extent_tree;
 	struct extent_map *merge = NULL;
 	struct rb_node *rb;
@@ -319,6 +373,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 				merge_ondisk_extents(merge, em);
 			em->flags |= EXTENT_FLAG_MERGED;
 
+			validate_extent_map(fs_info, em);
 			rb_erase(&merge->rb_node, &tree->root);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
@@ -334,6 +389,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		em->block_len += merge->block_len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 			merge_ondisk_extents(em, merge);
+		validate_extent_map(fs_info, em);
 		rb_erase(&merge->rb_node, &tree->root);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
@@ -445,6 +501,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 
 	lockdep_assert_held_write(&tree->lock);
 
+	validate_extent_map(fs_info, em);
 	ret = tree_insert(&tree->root, em);
 	if (ret)
 		return ret;
@@ -548,10 +605,13 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 				   struct extent_map *new,
 				   int modified)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *tree = &inode->extent_tree;
 
 	lockdep_assert_held_write(&tree->lock);
 
+	validate_extent_map(fs_info, new);
+
 	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
 	ASSERT(extent_map_in_tree(cur));
 	if (!(cur->flags & EXTENT_FLAG_LOGGING))
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5f1a909a1d91..151ed1ebd291 100644
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
index c511a1297956..e73ac7a0869c 100644
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
2.45.1


