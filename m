Return-Path: <linux-btrfs+bounces-1708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA4483AF97
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C371C23FBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57E86AF6;
	Wed, 24 Jan 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uHgunwNj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99E86ADE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116790; cv=none; b=WsSrumJ5CxqyB6SY0NxNsFcaZmXRb0RX+e3Vcq37W/PA9D64QF4UG/q//zL8TqtNOc0vNsPoMnztebn796iT/iMPmfvlPu30EzyGcMwc/aIGGw/kVXEq/yHdbQA046D4tX2uHycSJ5+R/Z9Za9nqFqWp1GA3E+brj7FMvRzxuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116790; c=relaxed/simple;
	bh=TGtfXeIU2gD7eCFbK+jfB6Hhv1wObrDLVykXBeDgEwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCjqMHzxtXmZQoAKdsFXmtfgNW1f7MjMIdsOePeJQ8Ll8sT+VdqFSgpCgfN6SyHvyMpt5QksSSBD/pSjJ9++oJ6FI3WxmAk+HuuiI2RLINkcoY2Ct95XMYtSt/FHxj3OTcCMf0Uw5xKOxMVV+jEp9le8tjuNtGuij27ah/uU0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uHgunwNj; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc221f01302so4469863276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116787; x=1706721587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GHY4ebkbtBMe9vZyd7ROTUiJYsLs7M198UMZcUyLG0=;
        b=uHgunwNjex5Nmy+NZsKfVKlXlwnCodiuTp15NU3W9ytZNjMHlQKZ32EqHEX/0b27lq
         PiuCu4pLbm/aRgiBrFCTlB175DCIRAtrxHhoeU9DO+3oE96JoXDhOuLHb8XnP8jjQ6eY
         qnq8VuN/Vg1JnuiaQyg7UcylyNiYhn7nUNrb0HNqbdd7YzGyeJHKyzN6aBlNVF9ZfrVN
         W8nm0HE9/wX5EbfXols2LVusa3G9SiyiK163Mb2WtZ5uiPt+TA3c0QdhJp0sgRN5Ujv7
         EWk1yjaLC2ShgvR39ODI9AdWhV7TmQi5iI685OrZiByAqrKjk55B2cZ9/6FY++20XXVB
         PMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116787; x=1706721587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GHY4ebkbtBMe9vZyd7ROTUiJYsLs7M198UMZcUyLG0=;
        b=o7Wets9A1WhhGaTfmjcR7gZHAt0s8CSTGszLgHLfji9z4n2J8+2KCz0jgrL0kZvAFC
         biGEQtGdPHYkfFCSLM/r3bvPgHuNV5eE3/70hvuZYbXtDVKUUbz3r9V9MJ0xqEkPbvtb
         PoWZmMC2e8iIBSotUwHhtqOL50C6O6QMV1CjIPv/evQHMoSaTMT6BXUAgZO653AuN5Aq
         2iFt88XJJAOsnIDMyy2suPKUXY+Jo6QMnGRL+p3yPfjPSdyaWD/NQKNy5CTbflzXV/zv
         //sJ3Jr1Fi7Ohso7h8KLYRjVkFdvmg1IhuogD0ziK7sNyXfot00km6QBgzleFSHOl5ep
         fVvg==
X-Gm-Message-State: AOJu0Yw69cao1z+tuW4OmRZvoR1tPQyI/LRfUD5Q/OcgopQK04/nbg2X
	UzXIEgRY8mZsChGeQqb5eNte6PRKNbJuFi1sFkhvmWk9ueMM2x3LK5h52T8tUM/1LF/Ixtfmb/X
	G
X-Google-Smtp-Source: AGHT+IHMY7JF6VntQrZClsJmtieW+3wdjl82LvlIaMzR5uexjeZtzGAIV5iyL78nkwgaOiFK48PetQ==
X-Received: by 2002:a25:af0e:0:b0:dc2:546d:e096 with SMTP id a14-20020a25af0e000000b00dc2546de096mr990603ybh.41.1706116787605;
        Wed, 24 Jan 2024 09:19:47 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t9-20020a252d09000000b00dc251f877a7sm2941261ybt.7.2024.01.24.09.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:47 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 26/52] btrfs: populate the ordered_extent with the fscrypt context
Date: Wed, 24 Jan 2024 12:18:48 -0500
Message-ID: <33e650f3e91ed0318211301beb27fa613382f28e.1706116485.git.josef@toxicpanda.com>
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

The fscrypt_extent_info will be tied to the extent_map lifetime, so it
will be created when we create the IO em, or it'll already exist in the
NOCOW case.  Use this fscrypt_info when creating the ordered extent to
make sure everything is passed through properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 77 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5d8cf2f83831..7b3ef349661a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1170,9 +1170,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
@@ -1181,6 +1180,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				       0,			/* offset */
 				       1 << BTRFS_ORDERED_COMPRESSED,
 				       async_extent->compress_type);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1434,13 +1434,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL,
+		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 					start, ram_size, ram_size, ins.objectid,
 					cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
+		free_extent_map(em);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
@@ -2013,6 +2013,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
+		struct extent_map *em = NULL;
+		struct fscrypt_extent_info *fscrypt_info = NULL;
 		u64 extent_end;
 		u64 ram_bytes;
 		u64 nocow_end;
@@ -2149,13 +2151,29 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		}
 
+		/*
+		 * We only want to do this lookup if we're encrypted, otherwise
+		 * fsrypt_info will be null and we can avoid this lookup.
+		 */
+		if (IS_ENCRYPTED(&inode->vfs_inode)) {
+			em = btrfs_get_extent(inode, NULL, 0, cur_offset,
+					      nocow_args.num_bytes);
+			if (IS_ERR(em)) {
+				btrfs_dec_nocow_writers(nocow_bg);
+				ret = PTR_ERR(em);
+				goto error;
+			}
+			fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
+			free_extent_map(em);
+			em = NULL;
+		}
+
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
-			struct extent_map *em;
 
-			em = create_io_em(inode, NULL, cur_offset,
+			em = create_io_em(inode, fscrypt_info, cur_offset,
 					  nocow_args.num_bytes,
 					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
@@ -2164,6 +2182,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
+				fscrypt_put_extent_info(fscrypt_info);
 				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
 				goto error;
@@ -2171,13 +2190,15 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
-				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
+				cur_offset, nocow_args.num_bytes,
+				nocow_args.num_bytes, nocow_args.disk_bytenr,
+				nocow_args.num_bytes, 0,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
 				BTRFS_COMPRESS_NONE);
+		fscrypt_put_extent_info(fscrypt_info);
 		btrfs_dec_nocow_writers(nocow_bg);
 		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
@@ -7044,6 +7065,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
+						  struct extent_map *orig_em,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -7055,18 +7077,24 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info = NULL;
+
+	if (orig_em)
+		fscrypt_info = orig_em->fscrypt_info;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, NULL, start, len, orig_start,
+		em = create_io_em(inode, fscrypt_info, start, len, orig_start,
 				  block_start, block_len, orig_block_len,
 				  ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type);
 		if (IS_ERR(em))
 			goto out;
+		fscrypt_info = em->fscrypt_info;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
-					     block_start, block_len, 0,
+
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
+					     len, block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -7110,9 +7138,10 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
-				     ins.objectid, ins.offset, ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR);
+	em = btrfs_create_dio_extent(inode, dio_data, NULL, start, ins.offset,
+				     start, ins.objectid, ins.offset,
+				     ins.offset, ins.offset,
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7379,7 +7408,13 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode,
 		em->flags |= EXTENT_FLAG_FILLING;
 	else if (type == BTRFS_ORDERED_COMPRESSED)
 		extent_map_set_compression(em, compress_type);
-	extent_map_set_encryption(em, BTRFS_ENCRYPTION_NONE);
+
+	if (fscrypt_info) {
+		extent_map_set_encryption(em, BTRFS_ENCRYPTION_FSCRYPT);
+		em->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	} else {
+		extent_map_set_encryption(em, BTRFS_ENCRYPTION_NONE);
+	}
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -7455,9 +7490,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_start, block_start,
-					      len, orig_block_len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, em,
+					      start, len, orig_start,
+					      block_start, len, orig_block_len,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
@@ -10567,14 +10602,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, NULL, start,
+	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
+	free_extent_map(em);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
-- 
2.43.0


