Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC70436AF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhJUTBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTBC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:01:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE9C061348
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id n2so1439242qta.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rQaynyziNnMRBKR7f7ss+eiEsEsleL6/G2Fw7/ElTeM=;
        b=P4KONjUs0Fa9+iJFReNdmD5fuyMdnPRmttVqMEI6fkqWP4tBMiXehFGs/a67QJQtAk
         HoCiBEJihRX3ENMxJCdO542wE1hElRregJ3CUHK7v2p3/pBGXKs6eoXZrDEOC8ImfsM2
         Zzaor5EDEDnYzV3IzttDOF4dau/hivRG6YuzyFiRlRqNy4oBNtqoH8IcOVLVEKyGfBix
         vU45OTaZfdzjttsOBu4ukCfps19Y2MBtvdZiGfiXFznLuJziJXayp5my2F53IFZpB4+o
         LiwoaDUPnmEsZgHJDY2xAywbeuz9gcIY9tVwzN2uOVMJmfDNloIDckNH5AnlWT1DQgvt
         0Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQaynyziNnMRBKR7f7ss+eiEsEsleL6/G2Fw7/ElTeM=;
        b=Luo7k9IqIG7Bufxn0l0rl26D3QzVgzWuukNZn6iFMnKDkXKYgn/jF2HGVgGbo8/Lmy
         B/egp7qYmKqVi36kCXulEkMHmT1zdniY9Ab7ZooZp+rhVixoOakbDMUgBe1xsqBPU+LP
         Z+D/he0uMU0f9mtOYRjrP4EnLKS/QgvkNFgUZDAy/3xFlv2w8V6bEA+NGes/yiRjLGAJ
         u0UI5MDu/z9HSf/+GQLz+Wv10ofaHiDN2IUuNM/UUnY1BoWS6o1ZuF9Zgnu30L/eAUq3
         4WiX9d0agyfz26mqZfmoAxoToHFCAoa2QIY9RF8b6a3WDR2aF6AnEF+vPVj9lQOrDwI8
         nMKw==
X-Gm-Message-State: AOAM531clSNpu1jh0oKw1krqwKR5rBziH1I2MonvzMDFDMeUngmsZam1
        +SikfmNAEzMsCJCQgCri5UVir/639VlqUw==
X-Google-Smtp-Source: ABdhPJxVJ1QKUdrtlCAJknyq8Wr0+MURDvnzmZEx9JTsVp37jUyS9dYZw7bLUcUYXZjQjPZqjddBKQ==
X-Received: by 2002:a05:622a:1392:: with SMTP id o18mr8138613qtk.107.1634842724115;
        Thu, 21 Oct 2021 11:58:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x125sm2921103qkd.8.2021.10.21.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: introduce item_nr token variant helpers
Date:   Thu, 21 Oct 2021 14:58:34 -0400
Message-Id: <d109c909da13522b55358c3b1401996c76ab7c9a.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The last remaining place where we have the pattern of

item = btrfs_item_nr(slot)
<do something with the item>

are the token helpers.  Handle this by introducing token helpers that
will do the btrfs_item_nr() work inside of the helper itself, and then
convert all users of the btrfs_item token helpers to the new _nr()
variants.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 66 +++++++++++++++++++-----------------------------
 fs/btrfs/ctree.h | 28 ++++++++++++++++++++
 2 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6f89dbc2cb31..500aac8a95c9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2669,7 +2669,6 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	u32 i;
 	int push_space = 0;
 	int push_items = 0;
-	struct btrfs_item *item;
 	u32 nr;
 	u32 right_nritems;
 	u32 data_end;
@@ -2701,11 +2700,12 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 			push_space += data_size;
 
 		this_item_size = btrfs_item_size_nr(left, i);
-		if (this_item_size + sizeof(*item) + push_space > free_space)
+		if (this_item_size + sizeof(struct btrfs_item) +
+		    push_space > free_space)
 			break;
 
 		push_items++;
-		push_space += this_item_size + sizeof(*item);
+		push_space += this_item_size + sizeof(struct btrfs_item);
 		if (i == 0)
 			break;
 		i--;
@@ -2750,9 +2750,8 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		item = btrfs_item_nr(i);
-		push_space -= btrfs_token_item_size(&token, item);
-		btrfs_set_token_item_offset(&token, item, push_space);
+		push_space -= btrfs_token_item_size_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -2897,7 +2896,6 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	int i;
 	int push_space = 0;
 	int push_items = 0;
-	struct btrfs_item *item;
 	u32 old_left_nritems;
 	u32 nr;
 	int ret = 0;
@@ -2926,11 +2924,12 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 			push_space += data_size;
 
 		this_item_size = btrfs_item_size_nr(right, i);
-		if (this_item_size + sizeof(*item) + push_space > free_space)
+		if (this_item_size + sizeof(struct btrfs_item) + push_space >
+		    free_space)
 			break;
 
 		push_items++;
-		push_space += this_item_size + sizeof(*item);
+		push_space += this_item_size + sizeof(struct btrfs_item);
 	}
 
 	if (push_items == 0) {
@@ -2961,10 +2960,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
 
-		item = btrfs_item_nr(i);
-
-		ioff = btrfs_token_item_offset(&token, item);
-		btrfs_set_token_item_offset(&token, item,
+		ioff = btrfs_token_item_offset_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size));
 	}
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
@@ -2993,10 +2990,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		item = btrfs_item_nr(i);
-
-		push_space = push_space - btrfs_token_item_size(&token, item);
-		btrfs_set_token_item_offset(&token, item, push_space);
+		push_space = push_space - btrfs_token_item_size_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(left);
@@ -3139,11 +3134,10 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 
 	btrfs_init_map_token(&token, right);
 	for (i = 0; i < nritems; i++) {
-		struct btrfs_item *item = btrfs_item_nr(i);
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(&token, item);
-		btrfs_set_token_item_offset(&token, item, ioff + rt_data_off);
+		ioff = btrfs_token_item_offset_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -3578,7 +3572,6 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int slot;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	u32 nritems;
 	unsigned int data_end;
 	unsigned int old_data_start;
@@ -3611,10 +3604,9 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		item = btrfs_item_nr(i);
 
-		ioff = btrfs_token_item_offset(&token, item);
-		btrfs_set_token_item_offset(&token, item, ioff + size_diff);
+		ioff = btrfs_token_item_offset_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -3673,7 +3665,6 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 {
 	int slot;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	u32 nritems;
 	unsigned int data_end;
 	unsigned int old_data;
@@ -3708,10 +3699,9 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		item = btrfs_item_nr(i);
 
-		ioff = btrfs_token_item_offset(&token, item);
-		btrfs_set_token_item_offset(&token, item, ioff - data_size);
+		ioff = btrfs_token_item_offset_nr(&token, i);
+		btrfs_set_token_item_offset_nr(&token, i, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -3743,7 +3733,6 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 				   const struct btrfs_item_batch *batch)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_item *item;
 	int i;
 	u32 nritems;
 	unsigned int data_end;
@@ -3796,10 +3785,9 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			item = btrfs_item_nr(i);
-			ioff = btrfs_token_item_offset(&token, item);
-			btrfs_set_token_item_offset(&token, item,
-						    ioff - batch->total_data_size);
+			ioff = btrfs_token_item_offset_nr(&token, i);
+			btrfs_set_token_item_offset_nr(&token, i,
+						       ioff - batch->total_data_size);
 		}
 		/* shift the items */
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + batch->nr),
@@ -3818,10 +3806,10 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 	for (i = 0; i < batch->nr; i++) {
 		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[i]);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
-		item = btrfs_item_nr(slot + i);
 		data_end -= batch->data_sizes[i];
-		btrfs_set_token_item_offset(&token, item, data_end);
-		btrfs_set_token_item_size(&token, item, batch->data_sizes[i]);
+		btrfs_set_token_item_offset_nr(&token, slot + i, data_end);
+		btrfs_set_token_item_size_nr(&token, slot + i,
+					     batch->data_sizes[i]);
 	}
 
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
@@ -4029,7 +4017,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	u32 last_off;
 	u32 dsize = 0;
 	int ret = 0;
@@ -4058,9 +4045,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			item = btrfs_item_nr(i);
-			ioff = btrfs_token_item_offset(&token, item);
-			btrfs_set_token_item_offset(&token, item, ioff + dsize);
+			ioff = btrfs_token_item_offset_nr(&token, i);
+			btrfs_set_token_item_offset_nr(&token, i, ioff + dsize);
 		}
 
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e3c523da64b6..5201341d35a6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2002,6 +2002,34 @@ static inline void btrfs_set_item_offset_nr(struct extent_buffer *eb, int nr,
 	btrfs_set_item_offset(eb, btrfs_item_nr(nr), val);
 }
 
+static inline u32 btrfs_token_item_offset_nr(struct btrfs_map_token *token,
+					     int slot)
+{
+	struct btrfs_item *item = btrfs_item_nr(slot);
+	return btrfs_token_item_offset(token, item);
+}
+
+static inline u32 btrfs_token_item_size_nr(struct btrfs_map_token *token,
+					     int slot)
+{
+	struct btrfs_item *item = btrfs_item_nr(slot);
+	return btrfs_token_item_size(token, item);
+}
+
+static inline void btrfs_set_token_item_offset_nr(struct btrfs_map_token *token,
+						  int slot, u32 val)
+{
+	struct btrfs_item *item = btrfs_item_nr(slot);
+	btrfs_set_token_item_offset(token, item, val);
+}
+
+static inline void btrfs_set_token_item_size_nr(struct btrfs_map_token *token,
+						int slot, u32 val)
+{
+	struct btrfs_item *item = btrfs_item_nr(slot);
+	btrfs_set_token_item_size(token, item, val);
+}
+
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-- 
2.26.3

