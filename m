Return-Path: <linux-btrfs+bounces-9769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858439D331E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 06:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF27281357
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 05:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AC156F39;
	Wed, 20 Nov 2024 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FYbpiowx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZOocrG2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030A5FEED
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732080161; cv=none; b=NyeYYzBb+U2P5cZEREPjnlLmuK9J7vXQKs+f3kmgh1qmSnwFT68P09JDm16L1cYFkyoCnzS1f8Y86/iEVmU4kr6kWypenkzei6wOqNpb33L1Pr+dk7IJ2821bEG+kF1jURZAJBMs3/utI+Aw3J3H1gceTwQbfESR/Vi8kb8ey7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732080161; c=relaxed/simple;
	bh=VJp55CMrkfAJ0rzY9zPCKNX1rwH3j0+nJK/H50BNQc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HShw446UENqm9DP3fx162PfG2Y6P0tbgtizflQD6K1Xvlcx1aKPgQBnz/g6wREepNHd2fGzNt0T27RwwT0Y+buEhqCQ2uK9UhjrMcytDCnO+3kU4qyEqQH/vXIbnXUURCGcFnGleL80QUV35Ar578W6qeFuEZeFzYJwmKTEiFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FYbpiowx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZOocrG2C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E33291F79C
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 05:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732080157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zozLXIbrLX15YGmKcmUdkPRqn5yiCpe8bdldGdvTY2w=;
	b=FYbpiowxtoNQMIU3pDF6Y8SHNMfwTFrMK0lUDtrThTenUsdbpoCPwTc0BgtHlVyrAdL5kD
	Fysk/8mNiqhOqfjDbc7ZNDr0A2y7pAmbrwMswtot1Zf/tzufXdSamXbkI8FQ/ykm8tsvf3
	29ldGQ320u9ZGbOzGt/qMiZ2FtKe9TY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732080156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zozLXIbrLX15YGmKcmUdkPRqn5yiCpe8bdldGdvTY2w=;
	b=ZOocrG2CizfiLjoz0Ma89S/WNYPsVfsu6SrHuEeIp8heZlH6jPC0A24jSDVI0NGkkhdnPv
	VKc/QKcNulrN0ZfCOlNgB26b7iIjSjgOi5vlaheqbOaikH3DgDS1o1gIVfkoUPw1lTr/PT
	iLTL6Zf1HO4vogi2oGUSG+vexFcenS0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D01213297
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 05:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id co43OBtyPWfcCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 05:22:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: validate system chunk array at btrfs_validate_super()
Date: Wed, 20 Nov 2024 15:52:18 +1030
Message-ID: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
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

Currently btrfs_validate_super() only does a very basic check on the
array chunk size (not too large than the available space, but not too
small to contain no chunk).

The more comprehensive checks (the regular chunk checks and size check
inside the system chunk array) is all done inside
btrfs_read_sys_array().

It's not a big deal, but for the sake of concentrated verification, we
should validate the system chunk array at the time of super block
validation.

So this patch does the following modification:

- Introduce a helper btrfs_check_system_chunk_array()
  * Validate the disk key
  * Validate the size before we access the full chunk/stripe items.
  * Do the full chunk item validation

- Call btrfs_check_system_chunk_array() at btrfs_validate_super()

- Simplify the checks inside btrfs_read_sys_array()
  Now the checks will be converted to an ASSERT().

- Simplify the checks inside read_one_chunk()
  Now all chunk items inside system chunk array and chunk tree is
  verified, there is no need to verify it again inside read_one_chunk().

This change has the following advantages:

- More comprehensive checks at write time
  Although this also means extra memcpy() for the superblocks at write
  time, due to the limits that we need a dummy extent buffer to utilize
  all the extent buffer helpers.

- Slightly improved readablity when iterating the system chunk array

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c      | 21 +--------
 fs/btrfs/disk-io.h      |  2 +-
 fs/btrfs/tree-checker.c | 99 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.h |  3 ++
 fs/btrfs/volumes.c      | 64 +++++++-------------------
 5 files changed, 121 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 814320948645..5d02ee491ec2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2337,7 +2337,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
  * 		1, 2	2nd and 3rd backup copy
  * 	       -1	skip bytenr check
  */
-int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
+int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num)
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
@@ -2495,24 +2495,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	/*
-	 * Obvious sys_chunk_array corruptions, it must hold at least one key
-	 * and one chunk
-	 */
-	if (btrfs_super_sys_array_size(sb) > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
-		btrfs_err(fs_info, "system chunk array too big %u > %u",
-			  btrfs_super_sys_array_size(sb),
-			  BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
-		ret = -EINVAL;
-	}
-	if (btrfs_super_sys_array_size(sb) < sizeof(struct btrfs_disk_key)
-			+ sizeof(struct btrfs_chunk)) {
-		btrfs_err(fs_info, "system chunk array too small %u < %zu",
-			  btrfs_super_sys_array_size(sb),
-			  sizeof(struct btrfs_disk_key)
-			  + sizeof(struct btrfs_chunk));
-		ret = -EINVAL;
-	}
+	ret = btrfs_check_system_chunk_array(fs_info, sb);
 
 	/*
 	 * The generation is a global counter, we'll trust it more than the others
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a7051e2570c1..ff8f314f5ac8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -54,7 +54,7 @@ int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
-int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
+int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num);
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 148d8cefa40e..83e88bcb0475 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -973,6 +973,105 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	return 0;
 }
 
+int btrfs_check_system_chunk_array(struct btrfs_fs_info *fs_info,
+				   const struct btrfs_super_block *sb)
+{
+	struct extent_buffer *dummy;
+	u32 array_size;
+	u32 cur_offset = 0;
+	u32 len;
+	int ret = 0;
+
+	/*
+	 * We allocated a dummy extent, just to use extent buffer accessors.
+	 * There will be unused space after BTRFS_SUPER_INFO_SIZE, but
+	 * that's fine, we will not go beyond system chunk array anyway.
+	 */
+	dummy = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
+	if (!dummy)
+		return -ENOMEM;
+	set_extent_buffer_uptodate(dummy);
+	write_extent_buffer(dummy, sb, 0, BTRFS_SUPER_INFO_SIZE);
+
+	array_size = btrfs_super_sys_array_size(sb);
+	if (array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
+		btrfs_crit(fs_info,
+			   "superblock syschunk too large, have %u expect <=%u",
+			   array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	while (cur_offset < array_size) {
+		struct btrfs_disk_key *disk_key;
+		struct btrfs_key key;
+		struct btrfs_chunk *chunk;
+		u32 num_stripes;
+		u64 type;
+
+		len = sizeof(*disk_key);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+		disk_key = (struct btrfs_disk_key *)(sb->sys_chunk_array + cur_offset);
+		btrfs_disk_key_to_cpu(&key, disk_key);
+		cur_offset += len;
+
+		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
+			btrfs_crit(fs_info,
+			    "unexpected item type %u in sys_array at offset %u",
+				  (u32)key.type, cur_offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+		/*
+		 * At least one btrfs_chunk with one stripe must be present,
+		 * exact stripe count check comes afterwards
+		 */
+		len = btrfs_chunk_item_size(1);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+
+		chunk = (struct btrfs_chunk *)
+			(offsetof(struct btrfs_super_block, sys_chunk_array) +
+			 cur_offset);
+		num_stripes = btrfs_chunk_num_stripes(dummy, chunk);
+		if (!num_stripes) {
+			btrfs_crit(fs_info,
+			"invalid number of stripes %u in sys_array at offset %u",
+				  num_stripes, cur_offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+		type = btrfs_chunk_type(dummy, chunk);
+		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
+			btrfs_err(fs_info,
+			"invalid chunk type %llu in sys_array at offset %u",
+				  type, cur_offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		len = btrfs_chunk_item_size(num_stripes);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+
+		ret = btrfs_check_chunk_valid(dummy, chunk, key.offset);
+		if (ret)
+			goto out;
+		cur_offset += len;
+	}
+out:
+	free_extent_buffer_stale(dummy);
+	return ret;
+
+out_short_read:
+	btrfs_crit(fs_info,
+	"sys_array too short to read %u bytes at offset %u array size %u",
+		   len, cur_offset, array_size);
+	free_extent_buffer_stale(dummy);
+	return ret;
+}
+
 /*
  * Enhanced version of chunk item checker.
  *
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index db67f96cbe4b..b1c85e4e1add 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
 
 struct extent_buffer;
 struct btrfs_chunk;
@@ -68,6 +69,8 @@ int btrfs_check_node(struct extent_buffer *node);
 
 int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			    struct btrfs_chunk *chunk, u64 logical);
+int btrfs_check_system_chunk_array(struct btrfs_fs_info *fs_info,
+				   const struct btrfs_super_block *sb);
 int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
 int btrfs_verify_level_key(struct extent_buffer *eb,
 			   const struct btrfs_tree_parent_check *check);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..c2863075ee86 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7002,16 +7002,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	warn_32bit_meta_chunk(fs_info, logical, length, type);
 #endif
 
-	/*
-	 * Only need to verify chunk item if we're reading from sys chunk array,
-	 * as chunk item in tree block is already verified by tree-checker.
-	 */
-	if (leaf->start == BTRFS_SUPER_INFO_OFFSET) {
-		ret = btrfs_check_chunk_valid(leaf, chunk, logical);
-		if (ret)
-			return ret;
-	}
-
 	map = btrfs_find_chunk_map(fs_info, logical, 1);
 
 	/* already mapped? */
@@ -7274,11 +7264,9 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	u8 *array_ptr;
 	unsigned long sb_array_offset;
 	int ret = 0;
-	u32 num_stripes;
 	u32 array_size;
 	u32 len = 0;
 	u32 cur_offset;
-	u64 type;
 	struct btrfs_key key;
 
 	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
@@ -7301,10 +7289,17 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	cur_offset = 0;
 
 	while (cur_offset < array_size) {
+		u32 num_stripes;
+
 		disk_key = (struct btrfs_disk_key *)array_ptr;
 		len = sizeof(*disk_key);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+
+		/*
+		 * The super block should have passed
+		 * btrfs_check_system_chunk_array(), thus we only do
+		 * ASSERT() for those sanity checks.
+		 */
+		ASSERT(cur_offset + len <= array_size);
 
 		btrfs_disk_key_to_cpu(&key, disk_key);
 
@@ -7312,44 +7307,24 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 		sb_array_offset += len;
 		cur_offset += len;
 
-		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
-			btrfs_err(fs_info,
-			    "unexpected item type %u in sys_array at offset %u",
-				  (u32)key.type, cur_offset);
-			ret = -EIO;
-			break;
-		}
+		ASSERT(key.type == BTRFS_CHUNK_ITEM_KEY);
 
 		chunk = (struct btrfs_chunk *)sb_array_offset;
 		/*
 		 * At least one btrfs_chunk with one stripe must be present,
 		 * exact stripe count check comes afterwards
 		 */
-		len = btrfs_chunk_item_size(1);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+		ASSERT(cur_offset + btrfs_chunk_item_size(1) <= array_size);
 
 		num_stripes = btrfs_chunk_num_stripes(sb, chunk);
-		if (!num_stripes) {
-			btrfs_err(fs_info,
-			"invalid number of stripes %u in sys_array at offset %u",
-				  num_stripes, cur_offset);
-			ret = -EIO;
-			break;
-		}
+		/* Should have at least one stripe. */
+		ASSERT(num_stripes);
 
-		type = btrfs_chunk_type(sb, chunk);
-		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
-			btrfs_err(fs_info,
-			"invalid chunk type %llu in sys_array at offset %u",
-				  type, cur_offset);
-			ret = -EIO;
-			break;
-		}
+		/* Only system chunks are allowed in system chunk array. */
+		ASSERT(btrfs_chunk_type(sb, chunk) & BTRFS_BLOCK_GROUP_SYSTEM);
 
 		len = btrfs_chunk_item_size(num_stripes);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+		ASSERT(cur_offset + len <= array_size);
 
 		ret = read_one_chunk(&key, sb, chunk);
 		if (ret)
@@ -7362,13 +7337,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	clear_extent_buffer_uptodate(sb);
 	free_extent_buffer_stale(sb);
 	return ret;
-
-out_short_read:
-	btrfs_err(fs_info, "sys_array too short to read %u bytes at offset %u",
-			len, cur_offset);
-	clear_extent_buffer_uptodate(sb);
-	free_extent_buffer_stale(sb);
-	return -EIO;
 }
 
 /*
-- 
2.47.0


