Return-Path: <linux-btrfs+bounces-10630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2149F9E88
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 06:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84A6188922F
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2024 05:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C231E9B16;
	Sat, 21 Dec 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dc/1tqO5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PK0IDV2t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F4370
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734759948; cv=none; b=DlWMbAbh6RgxQrqqzhSxAjHBCQj4NTyTzNi1VqAPU2ZowzW1JSkc9RcG29MSLgud/Gw6s+Y2exBA/GaQrSOLKZMSXRsdMDG3/5guf4x/75H5YIU4OBteX0/n0pkdmzkW4NlRWvODk+hB0qUDR4a/hxWa3vqWsv29raOXHT2jkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734759948; c=relaxed/simple;
	bh=J8/TUlIC17GC/qrystrSJbhYugaOTtpIPcloNo2A+hU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ajyTfFcSGQ9DJlUP4ydU3PMeAxU95vlEBO/VrDWPSn9FQnsqVp++sKRabR4ABF9VC1XHjen32u8jRe6umV0wONLxzoQSi85SlvFlZAX84KJOLiey0Z6bNen9uRARbxWwP2Lp3xzMb/8fSqQIgUsA/Dhz9PcsZs/iol88dph2F68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dc/1tqO5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PK0IDV2t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E80B21F7FA
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 05:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734759938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WJgF3T2D21ydRFDs4PAZ0r1fDg/vgcaGerMjPzXX1kk=;
	b=Dc/1tqO5yTQ6vdyFeIIJwyRoPI4/z7K9pbYv9U9vGNYu5vQ6RRpwy2oUsSFCUWckTIhG7x
	gam5398gj5nO2jT11EKTOjj/K7YilHshq4mkPzrLAS9FxrwxxnIkUl1y5XYBplK75X0ppL
	+pTJTafdD0QEsHlNDqC8F0Rz1s2klZ4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734759937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WJgF3T2D21ydRFDs4PAZ0r1fDg/vgcaGerMjPzXX1kk=;
	b=PK0IDV2tB36Fe4+lxKtqUU3W10L8CUVUOvNJu0/h07kGK0WWB0B48TJXdfDbagFdP9oXEw
	JYSiAdh5PC+i04zg54WN+vIH65b8BJkAkJ/wWOpJE9+BXYhAZTiCg7UvXg1hSAWxMKP8OU
	qSQ7rhxIlcjUhadx6d5gkhqamTfZKB0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CDEB132EA
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 05:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9oXaNwBWZmciJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2024 05:45:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: validate system chunk array at btrfs_validate_super()
Date: Sat, 21 Dec 2024 16:15:19 +1030
Message-ID: <3c0c676a4618b0f8a933847afa9cb3410fe30628.1734755681.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently btrfs_validate_super() only does a very basic check on the
array chunk size (not too large than the available space, but not too
small to contain no chunk).

The more comprehensive checks (the regular chunk checks and size check
inside the system chunk array) is all done inside
btrfs_read_sys_array().

It's not a big deal, but it also means we do not do any validation on
the system chunk array at super block writeback time either.

So this patch does the following modification to concetrate the system
chunk array check into btrfs_validate_super():

- Make chunk_err() helper to accept stack chunk pointer
  If @leaf parameter is NULL, then the @chunk pointer will be a pointer
  to the chunk item, other than the offset inside the leaf.

  And since @leaf can be NULL, add a new @fs_info parameter for that
  case.

- Make btrfs_chekc_chunk_valid() to handle stack chunk pointer
  The same as chunk_err(), a new @fs_info parameter, and if @leaf is
  NULL, then @chunk will be a pointer to a stack chunk.

  If @chunk is NULL, then all needed btrfs_chunk members will be read
  using the stack helper instead of the leaf helper.
  This means we need to read out all the needed member at the beginning
  of the function.

  Furthermore, at super block read time, fs_info->sectorsize is not yet
  initialized, we need one extra @sectorsize parameter to grab the
  correct sectorsize.

- Introduce a helper validate_sys_chunk_array()
  * Validate the disk key
  * Validate the size before we access the full chunk items.
  * Do the full chunk item validation

- Call validate_sys_chunk_array() at btrfs_validate_super()

- Simplify the checks inside btrfs_read_sys_array()
  Now the checks will be converted to an ASSERT().

- Simplify the checks inside read_one_chunk()
  Now all chunk items inside system chunk array and chunk tree is
  verified, there is no need to verify it again inside read_one_chunk().

This change has the following advantages:

- More comprehensive checks at write time
  And unlike the sys_chunk_array read routine, this time we do not need
  to allocate a dummy extent buffer to do the check.
  All the checks done here requires no new memory allocation.

- Slightly improved readablity when iterating the system chunk array

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use stack pointer to verify the chunk item
  Thankfully the current chunk item verification doesn't involve stripe
  verification, thus stack pointer is enough and we do not need to
  allocate a dummy extent buffer nor memcpy() to do the verification

  This also fixes a bug that at super block read time,
  fs_info->sectorsize/sectorsize_bits are not initialized thus we can
  have problems using that dummy extent buffer (bitmap set beyond its
  range).

  That error can already be caught by btrfs/251, which explicitly
  uses page size as sectorsize, and will cause mount failure since
  the uninitialized default sectorsize is 4K, not matching the
  chunk_sector_size.
---
 fs/btrfs/disk-io.c      | 67 +++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c | 94 +++++++++++++++++++++++------------------
 fs/btrfs/tree-checker.h |  7 ++-
 fs/btrfs/volumes.c      | 74 ++++++--------------------------
 4 files changed, 139 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eff0dd1ae62f..851f550a549b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2327,6 +2327,71 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int validate_sys_chunk_array(const struct btrfs_fs_info *fs_info,
+				    const struct btrfs_super_block *sb)
+{
+	unsigned int cur = 0; /* Offset inside the sys chunk array */
+	/*
+	 * At sb read time, fs_info is not fully utilized. Thus we have
+	 * to use super block sectorsize, which should have been validated.
+	 */
+	const u32 sectorsize = btrfs_super_sectorsize(sb);
+	u32 sys_array_size = btrfs_super_sys_array_size(sb);
+
+	if (sys_array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
+		btrfs_err(fs_info, "system chunk array too big %u > %u",
+			  sys_array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
+		return -EUCLEAN;
+	}
+
+	while (cur < sys_array_size) {
+		struct btrfs_disk_key *disk_key;
+		struct btrfs_chunk *chunk;
+		struct btrfs_key key;
+		u64 type;
+		u16 num_stripes;
+		u32 len;
+		int ret;
+
+		disk_key = (struct btrfs_disk_key *)(sb->sys_chunk_array + cur);
+		len = sizeof(*disk_key);
+
+		if (cur + len > sys_array_size)
+			goto short_read;
+		cur += len;
+
+		btrfs_disk_key_to_cpu(&key, disk_key);
+		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
+			btrfs_err(fs_info,
+			    "unexpected item type %u in sys_array at offset %u",
+				  key.type, cur);
+			return -EUCLEAN;
+		}
+		chunk = (struct btrfs_chunk *)(sb->sys_chunk_array + cur);
+		num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+		if (cur + btrfs_chunk_item_size(num_stripes) > sys_array_size)
+			goto short_read;
+		type = btrfs_stack_chunk_type(chunk);
+		if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
+			btrfs_err(fs_info,
+			"invalid chunk type %llu in sys_array at offset %u",
+				  type, cur);
+			return -EUCLEAN;
+		}
+		ret = btrfs_check_chunk_valid(fs_info, NULL, chunk, key.offset,
+					      sectorsize);
+		if (ret < 0)
+			return ret;
+		cur += btrfs_chunk_item_size(num_stripes);
+	}
+	return 0;
+short_read:
+	btrfs_err(fs_info,
+	"super block sys chunk array short read, cur=%u sys_array_size=%u",
+		  cur, sys_array_size);
+	return -EUCLEAN;
+}
+
 /*
  * Real super block validation
  * NOTE: super csum type and incompat features will not be checked here.
@@ -2495,6 +2560,8 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	ret = validate_sys_chunk_array(fs_info, sb);
+
 	/*
 	 * Obvious sys_chunk_array corruptions, it must hold at least one key
 	 * and one chunk
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index dfeee033f31f..a9a009648143 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -764,22 +764,19 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	return 0;
 }
 
-__printf(4, 5)
+__printf(5, 6)
 __cold
-static void chunk_err(const struct extent_buffer *leaf,
+static void chunk_err(const struct btrfs_fs_info *fs_info,
+		      const struct extent_buffer *leaf,
 		      const struct btrfs_chunk *chunk, u64 logical,
 		      const char *fmt, ...)
 {
-	const struct btrfs_fs_info *fs_info = leaf->fs_info;
-	bool is_sb;
+	bool is_sb = !leaf;
 	struct va_format vaf;
 	va_list args;
 	int i;
 	int slot = -1;
 
-	/* Only superblock eb is able to have such small offset */
-	is_sb = (leaf->start == BTRFS_SUPER_INFO_OFFSET);
-
 	if (!is_sb) {
 		/*
 		 * Get the slot number by iterating through all slots, this
@@ -812,13 +809,17 @@ static void chunk_err(const struct extent_buffer *leaf,
 /*
  * The common chunk check which could also work on super block sys chunk array.
  *
+ * If @leaf is NULL, then @chunk must be an on-stack chunk item.
+ * (For superblock sys_chunk array, and fs_info->sectorsize is unreliable)
+ *
  * Return -EUCLEAN if anything is corrupted.
  * Return 0 if everything is OK.
  */
-int btrfs_check_chunk_valid(struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk, u64 logical)
+int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
+			    const struct extent_buffer *leaf,
+			    const struct btrfs_chunk *chunk, u64 logical,
+			    u32 sectorsize)
 {
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	u64 length;
 	u64 chunk_end;
 	u64 stripe_len;
@@ -826,63 +827,73 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	u16 sub_stripes;
 	u64 type;
 	u64 features;
+	u32 chunk_sector_size;
 	bool mixed = false;
 	int raid_index;
 	int nparity;
 	int ncopies;
 
-	length = btrfs_chunk_length(leaf, chunk);
-	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
-	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
-	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
-	type = btrfs_chunk_type(leaf, chunk);
+	if (leaf) {
+		length = btrfs_chunk_length(leaf, chunk);
+		stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
+		num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+		sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+		type = btrfs_chunk_type(leaf, chunk);
+		chunk_sector_size = btrfs_chunk_sector_size(leaf, chunk);
+	} else {
+		length = btrfs_stack_chunk_length(chunk);
+		stripe_len = btrfs_stack_chunk_stripe_len(chunk);
+		num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+		sub_stripes = btrfs_stack_chunk_sub_stripes(chunk);
+		type = btrfs_stack_chunk_type(chunk);
+		chunk_sector_size = btrfs_stack_chunk_sector_size(chunk);
+	}
 	raid_index = btrfs_bg_flags_to_raid_index(type);
 	ncopies = btrfs_raid_array[raid_index].ncopies;
 	nparity = btrfs_raid_array[raid_index].nparity;
 
 	if (unlikely(!num_stripes)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes, have %u", num_stripes);
 		return -EUCLEAN;
 	}
 	if (unlikely(num_stripes < ncopies)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes < ncopies, have %u < %d",
 			  num_stripes, ncopies);
 		return -EUCLEAN;
 	}
 	if (unlikely(nparity && num_stripes == nparity)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk num_stripes == nparity, have %u == %d",
 			  num_stripes, nparity);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(logical, fs_info->sectorsize))) {
-		chunk_err(leaf, chunk, logical,
+	if (unlikely(!IS_ALIGNED(logical, sectorsize))) {
+		chunk_err(fs_info, leaf, chunk, logical,
 		"invalid chunk logical, have %llu should aligned to %u",
-			  logical, fs_info->sectorsize);
+			  logical, sectorsize);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize)) {
-		chunk_err(leaf, chunk, logical,
+	if (unlikely(chunk_sector_size != sectorsize)) {
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk sectorsize, have %u expect %u",
-			  btrfs_chunk_sector_size(leaf, chunk),
-			  fs_info->sectorsize);
+			  chunk_sector_size, sectorsize);
 		return -EUCLEAN;
 	}
-	if (unlikely(!length || !IS_ALIGNED(length, fs_info->sectorsize))) {
-		chunk_err(leaf, chunk, logical,
+	if (unlikely(!length || !IS_ALIGNED(length, sectorsize))) {
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk length, have %llu", length);
 		return -EUCLEAN;
 	}
 	if (unlikely(check_add_overflow(logical, length, &chunk_end))) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 "invalid chunk logical start and length, have logical start %llu length %llu",
 			  logical, length);
 		return -EUCLEAN;
 	}
 	if (unlikely(!is_power_of_2(stripe_len) || stripe_len != BTRFS_STRIPE_LEN)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "invalid chunk stripe length: %llu",
 			  stripe_len);
 		return -EUCLEAN;
@@ -896,30 +907,29 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	 * Thus it should be a good way to catch obvious bitflips.
 	 */
 	if (unlikely(length >= btrfs_stripe_nr_to_offset(U32_MAX))) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "chunk length too large: have %llu limit %llu",
 			  length, btrfs_stripe_nr_to_offset(U32_MAX));
 		return -EUCLEAN;
 	}
 	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
 			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "unrecognized chunk type: 0x%llx",
 			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
-			    BTRFS_BLOCK_GROUP_PROFILE_MASK) &
-			  btrfs_chunk_type(leaf, chunk));
+			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
 		return -EUCLEAN;
 	}
 
 	if (unlikely(!has_single_bit_set(type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
 		     (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) != 0)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 		"invalid chunk profile flag: 0x%llx, expect 0 or 1 bit set",
 			  type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
 		return -EUCLEAN;
 	}
 	if (unlikely((type & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 	"missing chunk type flag, have 0x%llx one bit must be set in 0x%llx",
 			  type, BTRFS_BLOCK_GROUP_TYPE_MASK);
 		return -EUCLEAN;
@@ -928,7 +938,7 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	if (unlikely((type & BTRFS_BLOCK_GROUP_SYSTEM) &&
 		     (type & (BTRFS_BLOCK_GROUP_METADATA |
 			      BTRFS_BLOCK_GROUP_DATA)))) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			  "system chunk with data or metadata type: 0x%llx",
 			  type);
 		return -EUCLEAN;
@@ -941,7 +951,7 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	if (!mixed) {
 		if (unlikely((type & BTRFS_BLOCK_GROUP_METADATA) &&
 			     (type & BTRFS_BLOCK_GROUP_DATA))) {
-			chunk_err(leaf, chunk, logical,
+			chunk_err(fs_info, leaf, chunk, logical,
 			"mixed chunk type in non-mixed mode: 0x%llx", type);
 			return -EUCLEAN;
 		}
@@ -963,7 +973,7 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
 		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
 		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
-		chunk_err(leaf, chunk, logical,
+		chunk_err(fs_info, leaf, chunk, logical,
 			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
 			num_stripes, sub_stripes,
 			type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
@@ -983,10 +993,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 				 struct btrfs_chunk *chunk,
 				 struct btrfs_key *key, int slot)
 {
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	int num_stripes;
 
 	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
-		chunk_err(leaf, chunk, key->offset,
+		chunk_err(fs_info, leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect [%zu, %u)",
 			btrfs_item_size(leaf, slot),
 			sizeof(struct btrfs_chunk),
@@ -1001,14 +1012,15 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 
 	if (unlikely(btrfs_chunk_item_size(num_stripes) !=
 		     btrfs_item_size(leaf, slot))) {
-		chunk_err(leaf, chunk, key->offset,
+		chunk_err(fs_info, leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect %lu",
 			btrfs_item_size(leaf, slot),
 			btrfs_chunk_item_size(num_stripes));
 		return -EUCLEAN;
 	}
 out:
-	return btrfs_check_chunk_valid(leaf, chunk, key->offset);
+	return btrfs_check_chunk_valid(fs_info, leaf, chunk, key->offset,
+				       fs_info->sectorsize);
 }
 
 __printf(3, 4)
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index db67f96cbe4b..c391d3e4c876 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
 
 struct extent_buffer;
 struct btrfs_chunk;
@@ -66,8 +67,10 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node);
 int btrfs_check_leaf(struct extent_buffer *leaf);
 int btrfs_check_node(struct extent_buffer *node);
 
-int btrfs_check_chunk_valid(struct extent_buffer *leaf,
-			    struct btrfs_chunk *chunk, u64 logical);
+int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
+			    const struct extent_buffer *leaf,
+			    const struct btrfs_chunk *chunk, u64 logical,
+			    u32 sectorsize);
 int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
 int btrfs_verify_level_key(struct extent_buffer *eb,
 			   const struct btrfs_tree_parent_check *check);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d32913c51d69..9b25fa67bc7d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7003,16 +7003,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
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
@@ -7270,16 +7260,11 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	struct extent_buffer *sb;
-	struct btrfs_disk_key *disk_key;
-	struct btrfs_chunk *chunk;
 	u8 *array_ptr;
 	unsigned long sb_array_offset;
 	int ret = 0;
-	u32 num_stripes;
 	u32 array_size;
-	u32 len = 0;
 	u32 cur_offset;
-	u64 type;
 	struct btrfs_key key;
 
 	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
@@ -7302,10 +7287,16 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	cur_offset = 0;
 
 	while (cur_offset < array_size) {
-		disk_key = (struct btrfs_disk_key *)array_ptr;
-		len = sizeof(*disk_key);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+		struct btrfs_chunk *chunk;
+		struct btrfs_disk_key *disk_key = (struct btrfs_disk_key *)array_ptr;
+		u32 len = sizeof(*disk_key);
+
+		/*
+		 * The sys_chunk_array is already verified at super block read
+		 * time.
+		 * Only do ASSERT()s for basic checks.
+		 */
+		ASSERT(cur_offset + len <= array_size);
 
 		btrfs_disk_key_to_cpu(&key, disk_key);
 
@@ -7313,44 +7304,14 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
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
-		/*
-		 * At least one btrfs_chunk with one stripe must be present,
-		 * exact stripe count check comes afterwards
-		 */
-		len = btrfs_chunk_item_size(1);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+		ASSERT(btrfs_chunk_type(sb, chunk) & BTRFS_BLOCK_GROUP_SYSTEM);
 
-		num_stripes = btrfs_chunk_num_stripes(sb, chunk);
-		if (!num_stripes) {
-			btrfs_err(fs_info,
-			"invalid number of stripes %u in sys_array at offset %u",
-				  num_stripes, cur_offset);
-			ret = -EIO;
-			break;
-		}
+		len = btrfs_chunk_item_size(btrfs_chunk_num_stripes(sb, chunk));
 
-		type = btrfs_chunk_type(sb, chunk);
-		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
-			btrfs_err(fs_info,
-			"invalid chunk type %llu in sys_array at offset %u",
-				  type, cur_offset);
-			ret = -EIO;
-			break;
-		}
-
-		len = btrfs_chunk_item_size(num_stripes);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
+		ASSERT(cur_offset + len <= array_size);
 
 		ret = read_one_chunk(&key, sb, chunk);
 		if (ret)
@@ -7363,13 +7324,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
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
2.47.1


