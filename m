Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794307CB264
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJPSWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjJPSWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:41 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692A114
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:33 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b61de8e456so1520312241.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480552; x=1698085352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVSFcN3hgU5Wv+MUFYElNWnOc10PkPLhn8pZyce9ayk=;
        b=klcaBvOxUESMKIbRbinFJa/idwgtg6JmC2oO2zwhdQbRWoEBr+g492cIGL1NNBF4ex
         x8K4xhaKEyJm6MF/fKSYydrThZyrmQ9PYI3akU9XzdM2+cyyvC5WIGw0ChFGOYs5g3Lq
         SmVniE3ht1oTWpOfgI1AqG3Sdd7XHP7ZO9jZyygTM4sYPxMngycZc2QdagkplTebw18Q
         lMjqL6bXJHwzovL7xSPZTSNisZGHU0cZmtiDeSo3+Zitzf/JBHE1q2aHcO4bfcIcWwiy
         kGbffUTN+xDRYy8WpJkugT7aYyMDZDoUzyHZsFwe4Y9c/nM1SdrNKXtdP0mxzzV8szpo
         UDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480552; x=1698085352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVSFcN3hgU5Wv+MUFYElNWnOc10PkPLhn8pZyce9ayk=;
        b=sURx9CgGfOIFeOZYXDM3of+ukqPYIGVgRwdQpqr4UvTyQz6YjVRlcf9L79knG56iXM
         dUWEpqfyGhHrKeZ/9KBJPnRu/ZMhJPFIO1tHR0NGkxCCmyibhd7uYayoT27aXC/w0Sii
         mmre883GNx1ADmq+H3KRuZkqimjQNAHcHawS/xxWIZB3zX1SztbirOJIJqHv2ExetBtD
         cJPEnru9aTZl0qdZ0q1rXVRmkEzJwWYkhybwKBFp1W5TeoNKP7/xBfeD2TEjCMCVTnSy
         SIkaPSDYs1hy8zLDgh7QlXv77FoBQNIxVb55EB1WdrlZzDeOEKxrXn717VJZElbSTU34
         6TfQ==
X-Gm-Message-State: AOJu0YwidUSR5VGRlEpt2GQ/vYgqLt7DesrlvLD16XjUxd3ijc7pXaHn
        Y6C/xyNmW1qEmI/Yv/Fyb7//EqK6nliDFrWcJm9voA==
X-Google-Smtp-Source: AGHT+IFjdOCrZuGFDMsKwUXORva80znpM0/FWVoa4PkOgytHd1zT9UJxHmIs4UKP+XXasktIMBDARQ==
X-Received: by 2002:a67:c097:0:b0:457:e828:3747 with SMTP id x23-20020a67c097000000b00457e8283747mr157143vsi.5.1697480551970;
        Mon, 16 Oct 2023 11:22:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g6-20020ac80706000000b004196d75d79csm3204308qth.46.2023.10.16.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 30/34] btrfs: populate ordered_extent with the orig offset
Date:   Mon, 16 Oct 2023 14:21:37 -0400
Message-ID: <46d61ba02e4e604e3cb65bf23781fcf40e4527b1.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent encryption we have to use a logical block nr as input for the
IV.  For btrfs we're using the offset into the extent we're operating
on.  For most ordered extents this is the same as the file_offset,
however for prealloc and NOCOW we have to use the original offset.

Add this as an argument and plumb it through everywhere, this will be
used when setting up the bio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 15 ++++++++++-----
 fs/btrfs/ordered-data.c | 22 ++++++++++++----------
 fs/btrfs/ordered-data.h | 12 +++++++++---
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0109b313217..1b844a27a0d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1165,6 +1165,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
 				       start,			/* file_offset */
+				       start,			/* orig_start */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1428,8 +1429,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info,
-					start, ram_size, ram_size, ins.objectid,
-					cur_alloc_size, 0,
+					start, start, ram_size, ram_size,
+					ins.objectid, cur_alloc_size, 0,
 					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		free_extent_map(em);
@@ -2178,7 +2179,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info,
-				cur_offset, nocow_args.num_bytes,
+				cur_offset,
+				found_key.offset - nocow_args.extent_offset,
+				nocow_args.num_bytes,
 				nocow_args.num_bytes, nocow_args.disk_bytenr,
 				nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7087,8 +7090,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		fscrypt_info = orig_em->fscrypt_info;
 	}
 
-	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start, len,
-					     len, block_start, block_len, 0,
+	ordered = btrfs_alloc_ordered_extent(inode, fscrypt_info, start,
+					     orig_start, len, len, block_start,
+					     block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
 					     BTRFS_COMPRESS_NONE);
@@ -10612,6 +10616,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, em->fscrypt_info, start,
+				       start - encoded->unencoded_offset,
 				       num_bytes, ram_bytes, ins.objectid,
 				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ee3138a6d11e..75eb42b5c95b 100644
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
@@ -175,6 +175,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
+	entry->orig_offset = orig_offset;
 	entry->num_bytes = num_bytes;
 	entry->ram_bytes = ram_bytes;
 	entry->disk_bytenr = disk_bytenr;
@@ -253,6 +254,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * @inode:           Inode that this extent is for.
  * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
+ * @orig_offset:     Logical offset of the original extent (PREALLOC or NOCOW)
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
  * @disk_bytenr:     Offset of extent on disk.
@@ -270,17 +272,17 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
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
@@ -1174,8 +1176,8 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		return ERR_PTR(-EINVAL);
 
 	new = alloc_ordered_extent(inode, ordered->fscrypt_info, file_offset,
-				   len, len, disk_bytenr, len, 0, flags,
-				   ordered->compress_type);
+				   ordered->orig_offset, len, len, disk_bytenr,
+				   len, 0, flags, ordered->compress_type);
 	if (IS_ERR(new))
 		return new;
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 767efcd74bee..af8b51c255ee 100644
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
@@ -172,9 +178,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
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
2.41.0

