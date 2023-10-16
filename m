Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486807CB25E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjJPSWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjJPSW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED9112
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-777719639adso1636585a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480541; x=1698085341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERZNY9yAu05NkeMS9bd2xgIAJNON/dSqVc7gEbsmsV8=;
        b=G8NxW2kvQ0IfVjPsukhcNob+832M58FqhrWenNhb7wErklFFkpvSiKy4E/0TtZ5fwU
         9MRZw22/y7SuIb1APkoyh7+ZutPDmJNRsMACtggfqE1JlPdcZbLTkZU85uRBUKn+dKcG
         ZnttTXfRqyGrZYZ0SS//8qT0qi+JB5UiLx8RuGnv96/9ANU81ZHeBaZ1F7D8txwqTxA4
         L72eWV+J90PYlw8eA4nDiH895LcARCWC8OiG9OFMQJXeQMYSPJdfQzVivQ53l1eafeeu
         9k0vEqiV1Geirsu74FBN4qsHqJgzJRpixYChS2JJ8zrpxoTIWLvo6jrrz8ymZydezlTT
         rRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480541; x=1698085341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERZNY9yAu05NkeMS9bd2xgIAJNON/dSqVc7gEbsmsV8=;
        b=tVyzEoWfrIsoRWL/N/sSW7sOHwuzW0dex2W3xvYwn8ZShaMZWKmwul9L54bcv+wp22
         hLsmjkzXOsuMlSCKvoPPL43BZoPSXi3AOYKatMe1Hv5Q/9ldndst0xRfwe//NKmyiq4D
         7usSxj490QAOZ01dtWruNaXBCPKuuOMS055N3keQK92YQGXzDNUB/q6uKkAi0Ibd4hmr
         3rgGUKEJL+75p63BSc7N05yrWNTPj+tFzWA4z5R9IRqOC/LXRUn1tSnp0XGeAExqMuis
         81kNPR0dnzjkgg5VFhRn4EMyIWsMhRz0r+j5+LdT2kiGawe2ZRn3bSg6eCtgaHxScfbr
         gDiw==
X-Gm-Message-State: AOJu0YyDksUAPDFp8ckS/wUzD7SKoQ6bvTgok0EuExCmRtqCPf3a+bqS
        DabaNR+FW0b3f2TnkVqunPY2JXus0CVB3fGov4tH9A==
X-Google-Smtp-Source: AGHT+IFoW9gHQwtYKBSpBv/9S6udxxjwOPvNE9OH7l3Gw5714cBqhJIhpD+byRa3vk6vya5DEWExDw==
X-Received: by 2002:a05:620a:2952:b0:773:bdb3:1318 with SMTP id n18-20020a05620a295200b00773bdb31318mr38022449qkp.15.1697480541396;
        Mon, 16 Oct 2023 11:22:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id vv3-20020a05620a562300b007758b25ac3bsm3206574qkn.82.2023.10.16.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 21/34] btrfs: plumb through setting the fscrypt_info for ordered extents
Date:   Mon, 16 Oct 2023 14:21:28 -0400
Message-ID: <7dd69dd1836293d1da17397f88262643aff44187.1697480198.git.josef@toxicpanda.com>
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
index 19087fd68cfe..a1fa5b6f3790 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1162,7 +1162,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
+	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1425,9 +1426,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
@@ -2158,7 +2160,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
+		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
 				nocow_args.num_bytes, nocow_args.num_bytes,
 				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7040,7 +7042,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
+	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
 					     block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
@@ -10512,9 +10514,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
index 27350dd50828..ee3138a6d11e 100644
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
@@ -181,10 +183,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
-	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->flags = flags;
+	entry->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	entry->encryption_type = entry->fscrypt_info ?
+		BTRFS_ENCRYPTION_FSCRYPT : BTRFS_ENCRYPTION_NONE;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
 	INIT_LIST_HEAD(&entry->list);
@@ -247,6 +251,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * Add an ordered extent to the per-inode tree.
  *
  * @inode:           Inode that this extent is for.
+ * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
@@ -263,17 +268,19 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
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
@@ -1166,8 +1173,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
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
index cc422bdb5363..767efcd74bee 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -170,10 +170,11 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
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
2.41.0

