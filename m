Return-Path: <linux-btrfs+bounces-1715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79783AFA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB391F2A289
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB97C1272DA;
	Wed, 24 Jan 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BaG9J5la"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB01272BF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116796; cv=none; b=ZGSRhjIQONDIgKSojjWJ16fwLdI2vIrfi0OpIjamt28rjLlK71F80R1gBOj6TrNIC4y1gf9wDIqwMUommWVM0o/vNecsPr3B177UdFSeh0pNTsMVQBn9XIaimbujCmR7XybONqobmoklTxQWFiC8aSy4yUgVODww7dGeHfZmEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116796; c=relaxed/simple;
	bh=pknzlpzbBEhJv2FXVFZoOJx792Jf3PZ6KUbmKoOYKQE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC6TM75JC+8SNXyBGyyVsrWPhtf/D8oIt1HP55HLdqbhtNY8X5/yBNZgv69qkWZt5do1+guyNhkJMxzSogZD6QLCSeN6TY1PZcBtO21TFDa69JoBI75l92QlxbCd6TFuoe4w7qjDaNF1p+FLQaiyrx311R+Dh4PQKx9r06ytH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BaG9J5la; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff84214fc7so56223147b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116794; x=1706721594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dFo+f19GBEAYwqiY7zLRHf4iTz8jOu/JlGsrnAeq6Y=;
        b=BaG9J5la67PmOM7Y9lmuT6TYHR7OX3VORTsFPUPYemgceYjLvyVvyJRIBL2mAz0VAz
         LIpbPGi7H8AFk91gq0iSY74NQwsEOZjXweJZwUmux44xAycNcW2WlqHh/cnCPqIvXfZ1
         TtswTQc7iCa9Ov25svwAtXWvKL7ZFVTSFRwQeyNBvjAVLl9zzVbQny+raSNReBeg0/XV
         x8mHNG4nMnligbYdiS8Y/GWwZujfi2TaJZ6JUSwVRHBEuIER3HsetgfYw7dnj/1BRuWY
         QEJr+FBtnOdwqv+pZpLNzu202pA+MyexRSKy+oRRaSIvjDZvuwFAHuaTWxJFqvOEvIkA
         9QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116794; x=1706721594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dFo+f19GBEAYwqiY7zLRHf4iTz8jOu/JlGsrnAeq6Y=;
        b=BDHm8XBp45O3g9vSn0Gs6r3POb4QgR9xGIM+NT6NVny9oAErllYUymBkLSFaKIqaO6
         Stw55VtQyQ8d+anSo7k30W1QTU1YdHB0MsCSc4V4Np4Y/+keESmDMYPW3rJ5FzHNK1/W
         Y9GLs/ZRWYZ/0VgbtoheF9CfS86Qeevtr4BZGh1G1XImQxcRGyGRU7LzZ+VWbOm5LLB1
         4xaPuU0jrSdQ+bf4ZD8Vaq9gh8tpzBjhwzilmjJ4R5U+M0AI+J+5h7kRkB5XUSSiTg46
         Uccg05mlwdXsJtYSG22S+ZWS2pmu+PTwMytt5bVhe009PLOV8Vr/WnfS9i9JBbstkAvt
         KOaw==
X-Gm-Message-State: AOJu0Yyk5RUNr4YDZph6AD4Yx5VR3FMTJ3Ob+V3axGPXKFuXGhcWlL84
	RJbWXgD7sUXYplZI63dFHLxHGm0wEelFJcSs5HLLVfCOJhWBTmAYU22Hp4daAk32a7LGG9gXcuS
	Z
X-Google-Smtp-Source: AGHT+IGGo28S3TYL52x1+tYOpzh7LjFOZ7dOqsFS7XvLDZdxRgLyLlrkIQ4L86JOiPxXAG94A4+QfQ==
X-Received: by 2002:a81:a14d:0:b0:5ff:9675:1e00 with SMTP id y74-20020a81a14d000000b005ff96751e00mr1004510ywg.43.1706116794078;
        Wed, 24 Jan 2024 09:19:54 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005f75cf6281fsm65990ywb.5.2024.01.24.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 33/52] btrfs: populate ordered_extent with the orig offset
Date: Wed, 24 Jan 2024 12:18:55 -0500
Message-ID: <fe06053fe2973c424dd539fecfee8cc171bdd22d.1706116485.git.josef@toxicpanda.com>
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

For extent encryption we have to use a logical block nr as input for the
IV.  For btrfs we're using the offset into the extent we're operating
on.  For most ordered extents this is the same as the file_offset,
however for prealloc and NOCOW we have to use the original offset.

Add this as an argument and plumb it through everywhere, this will be
used when setting up the bio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 15 ++++++++++-----
 fs/btrfs/ordered-data.c | 32 ++++++++++++++++++++++----------
 fs/btrfs/ordered-data.h | 12 +++++++++---
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 71098063bb9f..a84ff55b7eb5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1175,6 +1175,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
+				       start,			/* orig_start */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1438,8 +1439,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
-					start, ram_size, ram_size, ins.objectid,
-					cur_alloc_size, 0,
+					start, start, ram_size, ram_size,
+					ins.objectid, cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		free_extent_map(em);
@@ -2193,7 +2194,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
-				cur_offset, nocow_args.num_bytes,
+				cur_offset,
+				found_key.offset - nocow_args.extent_offset,
+				nocow_args.num_bytes,
 				nocow_args.num_bytes, nocow_args.disk_bytenr,
 				nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7117,8 +7120,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		fscrypt_info = em->fscrypt_info;
 	}
 
-	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
-					     len, block_start, block_len, 0,
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start,
+					     orig_start, len, len, block_start,
+					     block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -10684,6 +10688,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
+				       start - encoded->unencoded_offset,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1cd04c57b7a2..c33012ec79d9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -148,9 +148,9 @@ static inline struct rb_node *ordered_tree_search(struct btrfs_inode *inode,
 static struct btrfs_ordered_extent *alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type)
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
@@ -176,6 +176,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
+	entry->orig_offset = orig_offset;
 	entry->num_bytes = num_bytes;
 	entry->ram_bytes = ram_bytes;
 	entry->disk_bytenr = disk_bytenr;
@@ -254,6 +255,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * @inode:           Inode that this extent is for.
  * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
+ * @orig_offset:     Logical offset of the original extent (PREALLOC or NOCOW)
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
  * @disk_bytenr:     Offset of extent on disk.
@@ -271,17 +273,17 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type)
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
 	entry = alloc_ordered_extent(inode, fscrypt_info, file_offset,
-				     num_bytes, ram_bytes, disk_bytenr,
-				     disk_num_bytes, offset, flags,
+				     orig_offset, num_bytes, ram_bytes,
+				     disk_bytenr, disk_num_bytes, offset, flags,
 				     compress_type);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
@@ -1178,8 +1180,8 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		return ERR_PTR(-EINVAL);
 
 	new = alloc_ordered_extent(inode, ordered->fscrypt_info, file_offset,
-				   len, len, disk_bytenr, len, 0, flags,
-				   ordered->compress_type);
+				   ordered->orig_offset, len, len, disk_bytenr,
+				   len, 0, flags, ordered->compress_type);
 	if (IS_ERR(new))
 		return new;
 
@@ -1200,6 +1202,16 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	ordered->num_bytes -= len;
 	ordered->disk_num_bytes -= len;
 
+	/*
+	 * ->orig_offset is the original offset of the original extent, which
+	 * for PREALLOC or NOCOW stays the same, but if we're a regular extent
+	 * that means this is a new extent and thus ->orig_offset must equal
+	 * ->file_offset.  This is only important for encryption as we only use
+	 * it for setting the offset for the bio encryption context.
+	 */
+	if (test_bit(BTRFS_ORDERED_REGULAR, &ordered->flags))
+		ordered->orig_offset = ordered->file_offset;
+
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
 		ASSERT(ordered->bytes_left == 0);
 		new->bytes_left = 0;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 57ca8ce6eb6d..a8ce181288f7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -83,6 +83,12 @@ struct btrfs_ordered_extent {
 	/* logical offset in the file */
 	u64 file_offset;
 
+	/*
+	 * The original logical offset of the extent, this is for NOCOW and
+	 * PREALLOC extents, otherwise it'll be the same as file_offset.
+	 */
+	u64 orig_offset;
+
 	/*
 	 * These fields directly correspond to the same fields in
 	 * btrfs_file_extent_item.
@@ -165,9 +171,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode,
 			struct fscrypt_extent_info *fscrypt_info,
-			u64 file_offset, u64 num_bytes, u64 ram_bytes,
-			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
-			unsigned long flags, int compress_type);
+			u64 file_offset, u64 orig_offset, u64 num_bytes,
+			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
+			u64 offset, unsigned long flags, int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.43.0


