Return-Path: <linux-btrfs+bounces-1704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0883AF9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315A1B2C54F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004C86ACF;
	Wed, 24 Jan 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Hi5B9abE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A868615A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116786; cv=none; b=RLXiyB+G+fasmCmZnQYYHx1SIwYH/uLGOIFcdKGtEicbTut8rCR7NEwjvCurUPbFwq4b2xnIfVaOjGO9VqS2tIdTl1Ei70AiHYO9/Q1/2iJo/ZxIr97EKJD4xa1zXMnfdEdsu1/NvAlU9VCf+Vwrqrkzj8litEEl7x74oqduCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116786; c=relaxed/simple;
	bh=hrNQu4mnakMIZuyKKqOI+iknSbEDrWsWvhcbEqkzJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJTQb0oNHwWyo5B81IXieMFNlpsQ5WgzXjbQdRYKvmRAy8ThXhrJpWAWmxGHLNidpcRGVFJLU7t36uN9ppiAx/kXkxfbDn6Vmo6dXDfDaM6IvLh+xB+DY/QQWhmuAKujzr51kxrTAAG62y5RLRc6hlRlzdKbILCq4NPXD59qF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Hi5B9abE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4734703276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116783; x=1706721583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV4LEpfg6hJ6jYS3VyS9aEhz/ooSLEpFPflsXCnrmzo=;
        b=Hi5B9abEyh0kisuifXnapgoQm0xM5i065ZqzaiIOWX0BEtTDcu00Dk64ajLSLkHSyB
         jUiKYvRkQ9cMkCEEaFroH1olCAmahW2TDMiAzSj8BOwfxeCtuPNA73TbvztWXJJuwONP
         +jbYV/9oM2ScZ2Ktx51Dbqxxhu9rfq/nf+4LWoLAkFaFHHHs2Ofj3i3dvQjmNak1gCDt
         ihvo8k1UhieM5mtiQjAe86cQ3gW0tZrrxxUH5V36aUXl+BK2lDq0zHAUhcnWa4isa4xC
         b9uNSUUHddxWmDdk63qKB19OjCqnWgkBne6PqJxYK7R3VDPrRIzQ1Q+8eVKBRzbNCecu
         KVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116783; x=1706721583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV4LEpfg6hJ6jYS3VyS9aEhz/ooSLEpFPflsXCnrmzo=;
        b=tYyTjSd8sYGST4zZif8eNZwSqOsu05pLnhpXXv+JdPmbkPgcfTVTfVISJBtG24pRNW
         KoYgdfc4jjCE+WQfdPQdhWEjDO++DwciVPP/PFyqYMcWQFycdyImgcCtlguxERnfKeZF
         4aXyhV+bUN6mHDyMqTK8ps5qXTvnofbw/Ylf3LAgo2U4bqEPmM9YwYnsD+TGLc0EsOsE
         8Ger1zN/I5DReqfSh0c6xZQ7umwvH224Un6ntAdHcUp99q5t3Sb86PTyxyK3hafPbBKd
         iI73t4evnVrIQvK8F5+0gNWnFcmche4L9woaFAWgkSjJkA27zYK/TT7nEynETwLV58ZY
         yXVQ==
X-Gm-Message-State: AOJu0YzsAGEvcSP5S15XQbsV7ikAcfvzIZ219hWEBzVAuwxrh4vy3Y0z
	SqldBn4gjbnRe1kp81wlyeXanoENp+yeIsijHQAo0ULlPI6ETH1FAGk9Ti+6e/X8DRrCBJK12dB
	2
X-Google-Smtp-Source: AGHT+IFvhgg+W/x6OYccd+wsg14m2jyzVFfh0OYrtj70qGE+0iYMNgA/LzYeaEgpFy/7gr1rhuUYDg==
X-Received: by 2002:a5b:ac7:0:b0:dc2:4e85:6d68 with SMTP id a7-20020a5b0ac7000000b00dc24e856d68mr755157ybr.12.1706116783512;
        Wed, 24 Jan 2024 09:19:43 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g193-20020a25dbca000000b00dc25528fe9fsm2944218ybf.9.2024.01.24.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 22/52] btrfs: add fscrypt_info and encryption_type to extent_map
Date: Wed, 24 Jan 2024 12:18:44 -0500
Message-ID: <9818cd4134d048d2d641b9b8ae10be6c6af51956.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Each extent_map will end up with a pointer to its associated
fscrypt_info if any, which should have the same lifetime as the
extent_map. We are also going to need to track the encryption_type for
the file extent items.  Add the fscrypt_info to the extent_map, and the
subsequent code for transferring it in the split and merge cases, as
well as the code necessary to free them.  A future patch will add the
code to load them as appropriate.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 34 +++++++++++++++++++++++++++++++---
 fs/btrfs/extent_map.h | 16 ++++++++++++++++
 fs/btrfs/file-item.c  |  1 +
 fs/btrfs/inode.c      |  1 +
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f8705103819c..b351184700c1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -60,6 +60,7 @@ struct extent_map *alloc_extent_map(void)
 
 static void __free_extent_map(struct extent_map *em)
 {
+	fscrypt_put_extent_info(em->fscrypt_info);
 	kmem_cache_free(extent_map_cache, em);
 }
 
@@ -100,12 +101,24 @@ void free_extent_map_safe(struct extent_map_tree *tree,
 	if (!em)
 		return;
 
-	if (refcount_dec_and_test(&em->refs)) {
-		WARN_ON(extent_map_in_tree(em));
-		WARN_ON(!list_empty(&em->list));
+	if (!refcount_dec_and_test(&em->refs))
+		return;
+
+	WARN_ON(extent_map_in_tree(em));
+	WARN_ON(!list_empty(&em->list));
+
+	/*
+	 * We could take a lock freeing the fscrypt_info, so add this to the
+	 * list of freed_extents to be freed later.
+	 */
+	if (em->fscrypt_info) {
 		list_add_tail(&em->free_list, &tree->freed_extents);
 		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+		return;
 	}
+
+	/* Nothing scary here, just free the object. */
+	__free_extent_map(em);
 }
 
 /*
@@ -273,6 +286,10 @@ static bool can_merge_extent_map(const struct extent_map *em)
 	if (!list_empty(&em->list))
 		return false;
 
+	/* We can't merge encrypted extents. */
+	if (em->fscrypt_info)
+		return false;
+
 	return true;
 }
 
@@ -288,6 +305,10 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	if (next->block_start < EXTENT_MAP_LAST_BYTE - 1)
 		return next->block_start == extent_map_block_end(prev);
 
+	/* Don't merge adjacent encrypted maps. */
+	if (prev->fscrypt_info || next->fscrypt_info)
+		return false;
+
 	/* HOLES and INLINE extents. */
 	return next->block_start == prev->block_start;
 }
@@ -852,6 +873,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 			split->generation = gen;
 			split->flags = flags;
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			replace_extent_mapping(em_tree, em, split, modified);
 			free_extent_map(split);
 			split = split2;
@@ -892,6 +915,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->orig_block_len = 0;
 			}
 
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			if (extent_map_in_tree(em)) {
 				replace_extent_mapping(em_tree, em, split,
 						       modified);
@@ -1053,6 +1078,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
+	split_pre->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
 
 	replace_extent_mapping(em_tree, em, split_pre, 1);
 
@@ -1071,6 +1097,8 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
+	split_mid->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
+
 	add_extent_mapping(em_tree, split_mid, 1);
 
 	/* Once for us */
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d31f2a03670e..7d9d1f715d27 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -18,6 +18,7 @@ enum {
 	ENUM_BIT(EXTENT_FLAG_COMPRESS_ZLIB),
 	ENUM_BIT(EXTENT_FLAG_COMPRESS_LZO),
 	ENUM_BIT(EXTENT_FLAG_COMPRESS_ZSTD),
+	ENUM_BIT(EXTENT_FLAG_ENCRYPT_FSCRYPT),
 	/* pre-allocated extent */
 	ENUM_BIT(EXTENT_FLAG_PREALLOC),
 	/* Logging this extent */
@@ -54,6 +55,7 @@ struct extent_map {
 	u64 generation;
 	u32 flags;
 	refcount_t refs;
+	struct fscrypt_extent_info *fscrypt_info;
 	struct list_head list;
 	struct list_head free_list;
 };
@@ -72,6 +74,20 @@ struct extent_map_tree {
 
 struct btrfs_inode;
 
+static inline void extent_map_set_encryption(struct extent_map *em,
+					     enum btrfs_encryption_type type)
+{
+	if (type == BTRFS_ENCRYPTION_FSCRYPT)
+		em->flags |= EXTENT_FLAG_ENCRYPT_FSCRYPT;
+}
+
+static inline enum btrfs_encryption_type extent_map_encryption(const struct extent_map *em)
+{
+	if (em->flags & EXTENT_FLAG_ENCRYPT_FSCRYPT)
+		return BTRFS_ENCRYPTION_FSCRYPT;
+	return BTRFS_ENCRYPTION_NONE;
+}
+
 static inline void extent_map_set_compression(struct extent_map *em,
 					      enum btrfs_compression_type type)
 {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 81ac1d474bf1..8bb6be8f2445 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1304,6 +1304,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
+		extent_map_set_encryption(em, btrfs_file_extent_encryption(leaf, fi));
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ec48c24fe630..ac6365d378cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7373,6 +7373,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		em->flags |= EXTENT_FLAG_FILLING;
 	else if (type == BTRFS_ORDERED_COMPRESSED)
 		extent_map_set_compression(em, compress_type);
+	extent_map_set_encryption(em, BTRFS_ENCRYPTION_NONE);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-- 
2.43.0


