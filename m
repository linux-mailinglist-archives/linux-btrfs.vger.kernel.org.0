Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DF636D57
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKWWie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiKWWiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5097A36B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:10 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z1so13488252qkl.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0InXHCJtqmyPMKpy/Vu8sHtnq1JMsRpWdzO4KXBQUnw=;
        b=YDnFG4LkWAy7CFXooEN07uuJnqSg/nvplNMNG8F37l6lGOmZ/5c0VeJLqCyfuR8Mk9
         Z/k22xYAezCbI8Loz4RmcTMq3HiOcbhe421PiJhXMnm+TJ2CrZZTGHf+LrKQF3QuoVvh
         QBL/mi1L68HFCR/g6NjwZYtt/B5lYV5I339L8PuUDAHcdKtyfrOrRQ4p6MxHD79OaqXb
         AbTrnqUiu4N8VqLhVgeWPDSCuqI8YmqSSsP6fQQ507B4uEn9rK5YYG0nW29x1xypXrid
         VF3uM17zGUniqn1QtslbFjJgqVe1LMfcD8uVlsu5WdpnyZkDcEX9amhJafDlpY4m4+mo
         fItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0InXHCJtqmyPMKpy/Vu8sHtnq1JMsRpWdzO4KXBQUnw=;
        b=Ev19XvvpHJAhjOcrxtJ975V+34h2HPZO4vYN0YaVWsxyrL4uuvdsO5RvBT86MHIxOh
         tbBr/lw3IXLCwlILg/IhELCs+hWl8dBq0NysFsFoAUoprK77XKG3xuEZ8kc1k0KbB14F
         hAgkxeqe3zU+Aa0xc9Q5lG+XoYDNJcwEAgkQtBx6J3VKKahJR7lMzXIIOdEfvOU83wXl
         YuP3HFidaxjncuDJuQ9E7RzvQVHrtq3Aiz9nd7WuOHLB9bw9Z89YkfCH5fUeHmKYv21P
         EP6yM2teu8fQhoIVFHDd8IEJQSE3FkptwfRZ4RWWxHgfIjPvYZHmGsmQPQxp3JWNTqix
         XC7g==
X-Gm-Message-State: ANoB5pmcaXB8bQ7aFK5hYQFWfNVqHswJKITwNE/LVqF7BBVR1MQ6d+JA
        9sXYWDSViuHMUsS+HgVPrZ1x/sp1UX8Taw==
X-Google-Smtp-Source: AA0mqf5zm4kPCKjstqIcpmYL6MCpC34Dd1RdhTXzJlebgcVG36tkSigyzWLkdLWnI13FISp0C2P31Q==
X-Received: by 2002:ae9:f10c:0:b0:6ec:5496:4e17 with SMTP id k12-20020ae9f10c000000b006ec54964e17mr13360431qkg.559.1669243089369;
        Wed, 23 Nov 2022 14:38:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id q16-20020a37f710000000b006b95b0a714esm12692590qkj.17.2022.11.23.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 23/29] btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
Date:   Wed, 23 Nov 2022 17:37:31 -0500
Message-Id: <649870cfc38fb82ca4cb34386ed26f2a44315375.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're using btrfs_item_nr_offset(leaf, 0) to get the start of the leaf
data in the kernel, we don't have btrfs_leaf_data.  Replace all
occurrences of btrfs_leaf_data() with btrfs_item_nr_offset(leaf, 0) in
order to make syncing accessors.[ch] easier.  ctree.c will be synced
later, so this is simply an intermediate step.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c |  4 ++--
 check/main.c          |  4 ++--
 image/main.c          |  8 +++----
 kernel-shared/ctree.c | 50 +++++++++++++++++++++----------------------
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 29915f47..493cfc69 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -845,8 +845,8 @@ static void shift_items(struct btrfs_root *root, struct extent_buffer *eb)
 	unsigned int data_end = btrfs_item_offset(eb, nritems - 1);
 
 	/* Shift the item data up to and including slot back by shift space */
-	memmove_extent_buffer(eb, btrfs_leaf_data(eb) + data_end - shift_space,
-			      btrfs_leaf_data(eb) + data_end,
+	memmove_extent_buffer(eb, btrfs_item_nr_offset(eb, 0) + data_end - shift_space,
+			      btrfs_item_nr_offset(eb, 0) + data_end,
 			      btrfs_item_offset(eb, slot - 1) - data_end);
 
 	/* Now update the item pointers. */
diff --git a/check/main.c b/check/main.c
index bce91451..c0863705 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4429,8 +4429,8 @@ again:
 		       i, shift, (unsigned long long)buf->start);
 		offset = btrfs_item_offset(buf, i);
 		memmove_extent_buffer(buf,
-				      btrfs_leaf_data(buf) + offset + shift,
-				      btrfs_leaf_data(buf) + offset,
+				      btrfs_item_nr_offset(buf, 0) + offset + shift,
+				      btrfs_item_nr_offset(buf, 0) + offset,
 				      btrfs_item_size(buf, i));
 		btrfs_set_item_offset(buf, i, offset + shift);
 		btrfs_mark_buffer_dirty(buf);
diff --git a/image/main.c b/image/main.c
index 6bdb5d66..5afc4b7c 100644
--- a/image/main.c
+++ b/image/main.c
@@ -323,7 +323,7 @@ static void zero_items(struct metadump_struct *md, u8 *dst,
 		btrfs_item_key_to_cpu(src, &key, i);
 		if (key.type == BTRFS_CSUM_ITEM_KEY) {
 			size = btrfs_item_size(src, i);
-			memset(dst + btrfs_leaf_data(src) +
+			memset(dst + btrfs_item_nr_offset(src, 0) +
 			       btrfs_item_offset(src, i), 0, size);
 			continue;
 		}
@@ -369,7 +369,7 @@ static void copy_buffer(struct metadump_struct *md, u8 *dst,
 		size = sizeof(struct btrfs_header);
 		memset(dst + size, 0, src->len - size);
 	} else if (level == 0) {
-		size = btrfs_leaf_data(src) +
+		size = btrfs_item_nr_offset(src, 0) +
 			btrfs_item_offset(src, nritems - 1) -
 			btrfs_item_nr_offset(src, nritems);
 		memset(dst + btrfs_item_nr_offset(src, nritems), 0, size);
@@ -1248,8 +1248,8 @@ static void truncate_item(struct extent_buffer *eb, int slot, u32 new_size)
 		btrfs_set_item_offset(eb, i, ioff + size_diff);
 	}
 
-	memmove_extent_buffer(eb, btrfs_leaf_data(eb) + data_end + size_diff,
-			      btrfs_leaf_data(eb) + data_end,
+	memmove_extent_buffer(eb, btrfs_item_nr_offset(eb, 0) + data_end + size_diff,
+			      btrfs_item_nr_offset(eb, 0) + data_end,
 			      old_data_start + new_size - data_end);
 	btrfs_set_item_size(eb, slot, new_size);
 }
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 9b9fc9eb..9f8bc9a5 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2072,21 +2072,21 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* make room in the right data area */
 	data_end = leaf_data_end(right);
 	memmove_extent_buffer(right,
-			      btrfs_leaf_data(right) + data_end - push_space,
-			      btrfs_leaf_data(right) + data_end,
+			      btrfs_item_nr_offset(right, 0) + data_end - push_space,
+			      btrfs_item_nr_offset(right, 0) + data_end,
 			      BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_end);
 
 	/* copy from the left data area */
-	copy_extent_buffer(right, left, btrfs_leaf_data(right) +
+	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0) +
 		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - push_space,
-		     btrfs_leaf_data(left) + leaf_data_end(left), push_space);
+		     btrfs_item_nr_offset(left, 0) + leaf_data_end(left), push_space);
 
 	memmove_extent_buffer(right, btrfs_item_nr_offset(right, push_items),
-			      btrfs_leaf_data(right),
+			      btrfs_item_nr_offset(right, 0),
 			      right_nritems * sizeof(struct btrfs_item));
 
 	/* copy the items from left to right */
-	copy_extent_buffer(right, left, btrfs_leaf_data(right),
+	copy_extent_buffer(right, left, btrfs_item_nr_offset(right, 0),
 		   btrfs_item_nr_offset(left, left_nritems - push_items),
 		   push_items * sizeof(struct btrfs_item));
 
@@ -2205,15 +2205,15 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* push data from right to left */
 	copy_extent_buffer(left, right,
 			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
-			   btrfs_leaf_data(right),
+			   btrfs_item_nr_offset(right, 0),
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 		     btrfs_item_offset(right, push_items -1);
 
-	copy_extent_buffer(left, right, btrfs_leaf_data(left) +
+	copy_extent_buffer(left, right, btrfs_item_nr_offset(left, 0) +
 		     leaf_data_end(left) - push_space,
-		     btrfs_leaf_data(right) +
+		     btrfs_item_nr_offset(right, 0) +
 		     btrfs_item_offset(right, push_items - 1),
 		     push_space);
 	old_left_nritems = btrfs_header_nritems(left);
@@ -2239,13 +2239,13 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (push_items < right_nritems) {
 		push_space = btrfs_item_offset(right, push_items - 1) -
 						  leaf_data_end(right);
-		memmove_extent_buffer(right, btrfs_leaf_data(right) +
+		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0) +
 				      BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 				      push_space,
-				      btrfs_leaf_data(right) +
+				      btrfs_item_nr_offset(right, 0) +
 				      leaf_data_end(right), push_space);
 
-		memmove_extent_buffer(right, btrfs_leaf_data(right),
+		memmove_extent_buffer(right, btrfs_item_nr_offset(right, 0),
 			      btrfs_item_nr_offset(right, push_items),
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
@@ -2303,14 +2303,14 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_leaf_data(right),
+	copy_extent_buffer(right, l, btrfs_item_nr_offset(right, 0),
 			   btrfs_item_nr_offset(l, mid),
 			   nritems * sizeof(struct btrfs_item));
 
 	copy_extent_buffer(right, l,
-		     btrfs_leaf_data(right) +
+		     btrfs_item_nr_offset(right, 0) +
 		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - data_copy_size,
-			 btrfs_leaf_data(l) + leaf_data_end(l), data_copy_size);
+			 btrfs_item_nr_offset(l, 0) + leaf_data_end(l), data_copy_size);
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 		      btrfs_item_data_end(l, mid);
@@ -2662,8 +2662,8 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	/* shift the data */
 	if (from_end) {
-		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
-			      data_end + size_diff, btrfs_leaf_data(leaf) +
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
+			      data_end + size_diff, btrfs_item_nr_offset(leaf, 0) +
 			      data_end, old_data_start + new_size - data_end);
 	} else {
 		struct btrfs_disk_key disk_key;
@@ -2690,8 +2690,8 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			}
 		}
 
-		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
-			      data_end + size_diff, btrfs_leaf_data(leaf) +
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
+			      data_end + size_diff, btrfs_item_nr_offset(leaf, 0) +
 			      data_end, old_data_start - data_end);
 
 		offset = btrfs_disk_key_offset(&disk_key);
@@ -2754,8 +2754,8 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 	/* shift the data */
-	memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
-		      data_end - data_size, btrfs_leaf_data(leaf) +
+	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
+		      data_end - data_size, btrfs_item_nr_offset(leaf, 0) +
 		      data_end, old_data - data_end);
 
 	data_end = old_data;
@@ -2848,8 +2848,8 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			      (nritems - slot) * sizeof(struct btrfs_item));
 
 		/* shift the data */
-		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
-			      data_end - total_data, btrfs_leaf_data(leaf) +
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
+			      data_end - total_data, btrfs_item_nr_offset(leaf, 0) +
 			      data_end, old_data - data_end);
 		data_end = old_data;
 	}
@@ -3002,9 +3002,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (slot + nr != nritems) {
 		int data_end = leaf_data_end(leaf);
 
-		memmove_extent_buffer(leaf, btrfs_leaf_data(leaf) +
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) +
 			      data_end + dsize,
-			      btrfs_leaf_data(leaf) + data_end,
+			      btrfs_item_nr_offset(leaf, 0) + data_end,
 			      last_off - data_end);
 
 		for (i = slot + nr; i < nritems; i++) {
-- 
2.26.3

