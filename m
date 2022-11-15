Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D78629D91
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKOPc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiKOPb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:59 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9FEE35
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:57 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id w4so8935815qts.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4uBRkxUkKb9AUhSMhqquBoSPd2jCdxEhwmaKZ6P/sA=;
        b=DdWZCgLlwI6+QG8oAX7hz+HDSmorniSbpAmYVN/QBWlhok/Pf6fzrZnmlUZjY23kuI
         YhODTp0pmJOR2l+TnWt91GuO1sgiXdNcQ0+NU6ZGJRg52kkN6Zn7JcvbSy4B0uomUfnZ
         I+OUxUNVTFr3vQp+8RuhEUPO3IdLUBxgO6r+eCFNZzqjjd4RpzZbC6ew4XWUzFAR9UZA
         eQf4ZGy5jw0ssSLL2j+6TsM3fjNFNNzz/rWaAlLj2yfSFZfiTsb/CNnQDJflc1HN25S2
         HCZHtyJIMo21zyVXh2mEOcHbqXztykezyH5a0dVmN4H8HbjJjq5Cfvq7Ys+K5OBlpna3
         tykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4uBRkxUkKb9AUhSMhqquBoSPd2jCdxEhwmaKZ6P/sA=;
        b=C//69DvG/TGWSuvr1HPvOfFyMko7mtP7PzSqgGckdLurxyh8d8ny5qIfzv5ABnEbbd
         sl2ykUPtGgEdWJiin2L0hmulA/w9Cf5/VJADJN4k1Rpn/PYZDYyAXhMf8K90cAtvz0W9
         0vTibu/3VH6bvH3tdy2UaCD4BmZEGXCuBrf9jBF88FUyhIMnkJCcUI+w2MWZZ5NJXHHv
         igJD/D9tAyL6zC79AGp2xESGjGn1vzIsO9uOthzv53KTB50g6JZVC0In7sTIWER80t1j
         cEX0i9yNISI66IIYnvWRy7vEINEVkIezIJtrpWh8KPf1rb5QPgmij0vXNvJiPuN/X3WN
         VQxw==
X-Gm-Message-State: ANoB5pmruBOtNLLAZ+LcmA4fZAhNNrJ6VBX03iwluyXnjAotmTZZ8bic
        OVXProDR/FG803nqGoG6Vvd1KhvFnc27KA==
X-Google-Smtp-Source: AA0mqf6qpMe7YnronyankqDCFFbXA/+9v2AiH20QIhyVIbqk4uF+ClY9WJfOkYrcfj9ipSX+hTxxjg==
X-Received: by 2002:ac8:7a81:0:b0:3a5:6131:6438 with SMTP id x1-20020ac87a81000000b003a561316438mr17247483qtr.164.1668526316207;
        Tue, 15 Nov 2022 07:31:56 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b006ee77f1ecc3sm8528599qkp.31.2022.11.15.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/18] btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
Date:   Tue, 15 Nov 2022 10:31:24 -0500
Message-Id: <f64162e95355a89a19d23d51b6aea24a2421cadc.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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
index ddad9553..480889a3 100644
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
index d6ff0008..b8970595 100644
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

