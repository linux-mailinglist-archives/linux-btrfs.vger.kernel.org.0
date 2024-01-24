Return-Path: <linux-btrfs+bounces-1706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DC83AFA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4389EB2C888
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C286AE1;
	Wed, 24 Jan 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="E2PaqjKV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3386ACE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116788; cv=none; b=RxbiQDI3IVEmrvzz2+lkdAmVb6/5syIM0VhtTuPy8qiOatmLrWvy5oLAw4Q6JM74kpNwKidb59iwH1fhTZWh3v7NlnQ2GtHN8zdj7rYuPW3lRVrT0jdNn3xyEOjv+ynDEKlSrJVkECvXVH3ZXf/oPD+csSQtrhn2TjyIpA4rt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116788; c=relaxed/simple;
	bh=W/dcK8XrdiW15t5iza0nDoBFy7MkG87/wzlZh3tdovo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFJJ0ooI60FFs3NPCazq6F+mJy9lfQwoWAK7mTIDdYtsCBQ/cQ1E57WC8G9M9iEYq92x+bInTrG6ByenrLPUWdh3xbqbMkUyHqJ4F0sQiPrkv6XmmTt5upiQy7v3BDUWt1tfNELmGtpV4ykWkWR9m2GjTin0QRZROJXZ++3H0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=E2PaqjKV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ebca94cf74so56423727b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116785; x=1706721585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GXmJXhfjQ35H9z3pkF/FNc90hl98T9V9g1dLT/QRF4=;
        b=E2PaqjKVvx+DL6ZArJw3Q6kixKsQa4O4ztb8g9jORoYTlTFKjYIyjim8jHx/XiXrm9
         7htzI3Ngu6tpKPyduxXilM/ph1qO+80jGMWLzy3PwJKdDRYhAzCkrh0fQHlTmmUJa+z3
         ylPa8hADCZNuZAIW2iSmeijgfWnQkaFVicD+itYJHhJk117EqCJn2zom47A2Mz4KOkc5
         p+OGQtzkRrklMel6CN+HVAoTKkEPLTBWq3ZBXKPrZ4LHbE6yjrheilq4BEOyqFVWexci
         12ZPWCjJtipHyBTqgRsKkx7ykxpc8UZlSIUlTGuoCUh3xs7WrF3ZbCmxCBkonhs635NG
         viMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116785; x=1706721585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GXmJXhfjQ35H9z3pkF/FNc90hl98T9V9g1dLT/QRF4=;
        b=sgG4dlzKBpA8Z5ltG4MHx2KwPcfPlgllqUQuemjVr9r0j6hLQo52E8vr/jtV7o4hyv
         F1XUkN4BLEGtakKCfTbfYUhkpr+q8VCt+VHAWHzyFZ6ZgVfXJ1MRoRu3qxlzRJY6L3PK
         HVkVpNuawIoSunx/iqk+k+2yXNLesL6o9Y/8vLR8z5UexfgoRNBWrXz5/lvMhjUizzm/
         sjN0yYI/xXINwp/nbyr3WLyTw8Ue3RSiJbqkJtBf0Bm7iYd7nhpAwbFpADXD7ZLR/UFa
         xeAN/p7oe9mhnOS97XOxMWLL/wnmHomuuRz7hLEkpDRwV3gmUdmGpT9z6qRwm2u4Bf0E
         FEtg==
X-Gm-Message-State: AOJu0Ywx2Y+ra8p15xtWb0C25Ziztf72L5mnmXIOtcNtFtF4RIhR2SaN
	8K2fgZ8vnvkQfj/1/ITQevtxuWyFyWQDw2gpAa8ZePDOp4OCUr8iqoqa+ttpVct8DArDdCPgBMB
	H
X-Google-Smtp-Source: AGHT+IFhDAvZZ3fkRLS+Rt7xDmSuec3GJAXSC+ZpTRqhUQihVfI0SMwax+Ew6MSnQj/D1o5xsEQvAQ==
X-Received: by 2002:a81:a1c1:0:b0:5ff:6487:1b7f with SMTP id y184-20020a81a1c1000000b005ff64871b7fmr925911ywg.99.1706116785592;
        Wed, 24 Jan 2024 09:19:45 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l123-20020a0de281000000b005ffbb3031a3sm65904ywe.74.2024.01.24.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 24/52] btrfs: plumb through setting the fscrypt_info for ordered extents
Date: Wed, 24 Jan 2024 12:18:46 -0500
Message-ID: <80c5dabfe190b84e31a95160021da64ebcf7ecf7.1706116485.git.josef@toxicpanda.com>
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

We're going to be getting fscrypt_info from the extent maps, update the
helpers to take an fscrypt_info argument and use that to set the
encryption type on the ordered extent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 20 +++++++++++---------
 fs/btrfs/ordered-data.c | 32 ++++++++++++++++++++------------
 fs/btrfs/ordered-data.h |  9 +++++----
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac6365d378cc..3b14ba55e293 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1171,7 +1171,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
+	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1434,9 +1435,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, start, ram_size,
-					ram_size, ins.objectid, cur_alloc_size,
-					0, 1 << BTRFS_ORDERED_REGULAR,
+		ordered = btrfs_alloc_ordered_extent(inode, NULL,
+					start, ram_size, ram_size, ins.objectid,
+					cur_alloc_size, 0,
+					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
@@ -2167,7 +2169,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
+		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
 				nocow_args.num_bytes, nocow_args.num_bytes,
 				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7060,7 +7062,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
+	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
 					     block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
@@ -10563,9 +10565,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start, num_bytes, ram_bytes,
-				       ins.objectid, ins.offset,
-				       encoded->unencoded_offset,
+	ordered = btrfs_alloc_ordered_extent(inode, NULL, start,
+				       num_bytes, ram_bytes, ins.objectid,
+				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a9879d35a3af..1cd04c57b7a2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -146,9 +146,11 @@ static inline struct rb_node *ordered_tree_search(struct btrfs_inode *inode,
 }
 
 static struct btrfs_ordered_extent *alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset, u64 num_bytes,
-			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
-			u64 offset, unsigned long flags, int compress_type)
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
@@ -182,10 +184,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
-	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = qgroup_rsv;
 	entry->flags = flags;
+	entry->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	entry->encryption_type = entry->fscrypt_info ?
+		BTRFS_ENCRYPTION_FSCRYPT : BTRFS_ENCRYPTION_NONE;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
 	INIT_LIST_HEAD(&entry->list);
@@ -248,6 +252,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * Add an ordered extent to the per-inode tree.
  *
  * @inode:           Inode that this extent is for.
+ * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
@@ -264,17 +269,19 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * Return: the new ordered extent or error pointer.
  */
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type)
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
-	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
-				     disk_bytenr, disk_num_bytes, offset, flags,
+	entry = alloc_ordered_extent(inode, fscrypt_info, file_offset,
+				     num_bytes, ram_bytes, disk_bytenr,
+				     disk_num_bytes, offset, flags,
 				     compress_type);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
@@ -1170,8 +1177,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes))
 		return ERR_PTR(-EINVAL);
 
-	new = alloc_ordered_extent(inode, file_offset, len, len, disk_bytenr,
-				   len, 0, flags, ordered->compress_type);
+	new = alloc_ordered_extent(inode, ordered->fscrypt_info, file_offset,
+				   len, len, disk_bytenr, len, 0, flags,
+				   ordered->compress_type);
 	if (IS_ERR(new))
 		return new;
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 85ba9a381880..57ca8ce6eb6d 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -163,10 +163,11 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type);
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.43.0


