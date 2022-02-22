Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBE4C0492
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiBVW1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBVW1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:03 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DD6D95D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:35 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id ba20so3611567qvb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3w66zh4vJIilxFZzefRnO4t8Hf8wUfSh1IA1bWAEFwk=;
        b=H18V5jumjIdQK1VozGMFBMec0iG1NmGCm/S35dOjRzkp3oK5H5Jj50xECX0Qa+c6Mb
         5oGMag9PxhJuykMSpubk7lTXL1nw4fjoEuJlnfBANsfnc6JA6iJ9cFIa3Gb5Hp2r57/w
         HcFONqF9kzRMddHIFDWBsmFHn/nOV1KnRKsy2wuqeYZd2RJeb3G/85ghP1WXbK5w8nS7
         96CuZuuOYt7WJiutqOduJI7/e0B+Dons8KRqz5RTJJNeUAjS7UnJIpMtQroAxilEcU5W
         31T/pPSDIlckgBUxyGwFDb73hhxp5ONp8rYECiV24OXFahF72C/PXejQFPI9RH83bKUQ
         49Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3w66zh4vJIilxFZzefRnO4t8Hf8wUfSh1IA1bWAEFwk=;
        b=BYiIK0UMFUv0jlEf1SDG1bh7q281H6OBv+ABrXBJE/rTfFzQxKTH2idZGMdjuEsq9J
         lXxLhKFWnUMBxQLWNtCh0NGEswd85SVYkHM4+mqkPpDknW8LkS0wx24UaK7S+SdJb7+u
         KcFdybgIiaPb4AKeyaUHttIAmvo+i+d+nvLEw2idRbRLJAcuATjSpX2+syGOLOYAYiaA
         JyabMT5HbRkIwy1jZpsUdw85rJkyDE8l8O91uPVbwYWCCHXqK1EXLjw0ZWb0fuCfMML/
         oa+6TjUnoV4F0nAco5HQ9NBP8jWxqPl+3gV8ZbIhjePKllPSsydb6tas7DVBsMiFCh2S
         VMeQ==
X-Gm-Message-State: AOAM533yaFjk18BON+Qmj3mb4I6Vhr5cIK80ST7J/pJ5W6saLfE22Fj3
        BmC2NPJ02ZoaP7nhBWD6frgzu0hMBJTNeulT
X-Google-Smtp-Source: ABdhPJxOtcrUjc/0FnI/NRlvfF+tIL0iHi4JQxPlgwUdrxoLkn2EuisN57v4jBAGvCwNDC79+xO3fw==
X-Received: by 2002:a05:6214:62e:b0:42c:4194:6ab4 with SMTP id a14-20020a056214062e00b0042c41946ab4mr20971617qvx.69.1645568794280;
        Tue, 22 Feb 2022 14:26:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g11sm754589qtg.49.2022.02.22.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/13] btrfs-progs: add btrfs_set_item_*_nr() helpers
Date:   Tue, 22 Feb 2022 17:26:17 -0500
Message-Id: <c5790f3ac9c2b6121423ec68f5494776f5914cce.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a lot of the following patterns

	item = btrfs_item_nr(nr);
	btrfs_set_item_*(eb, item, val);

	btrfs_set_item_*(eb, btrfs_item_nr(nr), val);

in a lot of places in our code.  Instead add _nr variations of these
helpers and convert all of the users to this new helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c |  5 ++-
 check/main.c          | 14 +++------
 convert/common.c      | 25 ++++++++-------
 image/main.c          |  7 ++---
 kernel-shared/ctree.c | 72 ++++++++++++++-----------------------------
 kernel-shared/ctree.h | 12 ++++++++
 mkfs/common.c         | 41 +++++++++++-------------
 7 files changed, 74 insertions(+), 102 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 866c863e..57a4e271 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -838,7 +838,7 @@ static void shift_items(struct btrfs_root *root, struct extent_buffer *eb)
 	for (i = nritems - 1; i >= slot; i--) {
 		u32 offset = btrfs_item_offset_nr(eb, i);
 		offset -= shift_space;
-		btrfs_set_item_offset(eb, btrfs_item_nr(i), offset);
+		btrfs_set_item_offset_nr(eb, i, offset);
 	}
 }
 
@@ -980,8 +980,7 @@ static int corrupt_btrfs_item(struct btrfs_root *root, struct btrfs_key *key,
 	case BTRFS_ITEM_OFFSET:
 		orig = btrfs_item_offset_nr(path->nodes[0], path->slots[0]);
 		bogus = generate_u32(orig);
-		btrfs_set_item_offset(path->nodes[0],
-				      btrfs_item_nr(path->slots[0]), bogus);
+		btrfs_set_item_offset_nr(path->nodes[0], path->slots[0], bogus);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/check/main.c b/check/main.c
index 76eb8d54..0bc42de7 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4213,13 +4213,10 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 			btrfs_fixup_low_keys(path, &key, btrfs_header_level(buf) + 1);
 		}
 	} else {
-		struct btrfs_item *item1, *item2;
 		struct btrfs_key k1, k2;
 		char *item1_data, *item2_data;
 		u32 item1_offset, item2_offset, item1_size, item2_size;
 
-		item1 = btrfs_item_nr(slot);
-		item2 = btrfs_item_nr(slot + 1);
 		btrfs_item_key_to_cpu(buf, &k1, slot);
 		btrfs_item_key_to_cpu(buf, &k2, slot + 1);
 		item1_offset = btrfs_item_offset_nr(buf, slot);
@@ -4244,10 +4241,10 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 		free(item1_data);
 		free(item2_data);
 
-		btrfs_set_item_offset(buf, item1, item2_offset);
-		btrfs_set_item_offset(buf, item2, item1_offset);
-		btrfs_set_item_size(buf, item1, item2_size);
-		btrfs_set_item_size(buf, item2, item1_size);
+		btrfs_set_item_offset_nr(buf, slot, item2_offset);
+		btrfs_set_item_offset_nr(buf, slot + 1, item1_offset);
+		btrfs_set_item_size_nr(buf, slot, item2_size);
+		btrfs_set_item_size_nr(buf, slot + 1, item1_size);
 
 		path->slots[0] = slot;
 		btrfs_set_item_key_unsafe(root, path, &k2);
@@ -4371,8 +4368,7 @@ again:
 				      btrfs_leaf_data(buf) + offset + shift,
 				      btrfs_leaf_data(buf) + offset,
 				      btrfs_item_size_nr(buf, i));
-		btrfs_set_item_offset(buf, btrfs_item_nr(i),
-				      offset + shift);
+		btrfs_set_item_offset_nr(buf, i, offset + shift);
 		btrfs_mark_buffer_dirty(buf);
 	}
 
diff --git a/convert/common.c b/convert/common.c
index 356c2b4c..38112084 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -204,8 +204,8 @@ static void insert_temp_root_item(struct extent_buffer *buf,
 	btrfs_set_disk_key_offset(&disk_key, 0);
 
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot), sizeof(root_item));
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, sizeof(root_item));
 	write_extent_buffer(buf, &root_item,
 			    btrfs_item_ptr_offset(buf, *slot),
 			    sizeof(root_item));
@@ -311,8 +311,8 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_DEV_ITEMS_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, 1);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot), sizeof(*dev_item));
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, sizeof(*dev_item));
 
 	dev_item = btrfs_item_ptr(buf, *slot, struct btrfs_dev_item);
 	/* Generate device uuid */
@@ -369,9 +369,8 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, start);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot),
-			    btrfs_chunk_item_size(1));
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, btrfs_chunk_item_size(1));
 
 	chunk = btrfs_item_ptr(buf, *slot, struct btrfs_chunk);
 	btrfs_set_chunk_length(buf, chunk, len);
@@ -472,8 +471,8 @@ static void insert_temp_dev_extent(struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, 1);
 	btrfs_set_disk_key_offset(&disk_key, start);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot), sizeof(*dev_extent));
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, sizeof(*dev_extent));
 
 	dev_extent = btrfs_item_ptr(buf, *slot, struct btrfs_dev_extent);
 	btrfs_set_dev_extent_chunk_objectid(buf, dev_extent,
@@ -604,8 +603,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot), itemsize);
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, itemsize);
 
 	ei = btrfs_item_ptr(buf, *slot, struct btrfs_extent_item);
 	btrfs_set_extent_refs(buf, ei, 1);
@@ -670,8 +669,8 @@ static void insert_temp_block_group(struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 	btrfs_set_disk_key_offset(&disk_key, len);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, btrfs_item_nr(*slot), *itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(*slot), sizeof(bgi));
+	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
+	btrfs_set_item_size_nr(buf, *slot, sizeof(bgi));
 
 	btrfs_set_stack_block_group_flags(&bgi, flag);
 	btrfs_set_stack_block_group_used(&bgi, used);
diff --git a/image/main.c b/image/main.c
index e953d981..09f60e63 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1218,7 +1218,6 @@ static struct extent_buffer *alloc_dummy_eb(u64 bytenr, u32 size)
 
 static void truncate_item(struct extent_buffer *eb, int slot, u32 new_size)
 {
-	struct btrfs_item *item;
 	u32 nritems;
 	u32 old_size;
 	u32 old_data_start;
@@ -1238,16 +1237,14 @@ static void truncate_item(struct extent_buffer *eb, int slot, u32 new_size)
 
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		item = btrfs_item_nr(i);
 		ioff = btrfs_item_offset_nr(eb, i);
-		btrfs_set_item_offset(eb, item, ioff + size_diff);
+		btrfs_set_item_offset_nr(eb, i, ioff + size_diff);
 	}
 
 	memmove_extent_buffer(eb, btrfs_leaf_data(eb) + data_end + size_diff,
 			      btrfs_leaf_data(eb) + data_end,
 			      old_data_start + new_size - data_end);
-	item = btrfs_item_nr(slot);
-	btrfs_set_item_size(eb, item, new_size);
+	btrfs_set_item_size_nr(eb, slot, new_size);
 }
 
 static int fixup_chunk_tree_block(struct mdrestore_struct *mdres,
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index fc661aeb..81a438c8 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1982,7 +1982,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	int free_space;
 	int push_space = 0;
 	int push_items = 0;
-	struct btrfs_item *item;
 	u32 left_nritems;
 	u32 nr;
 	u32 right_nritems;
@@ -2036,16 +2035,14 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	i = left_nritems - 1;
 	while (i >= nr) {
-		item = btrfs_item_nr(i);
-
 		if (path->slots[0] == i)
-			push_space += data_size + sizeof(*item);
+			push_space += data_size + sizeof(struct btrfs_item);
 
 		this_item_size = btrfs_item_size_nr(left, i);
-		if (this_item_size + sizeof(*item) + push_space > free_space)
+		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
 			break;
 		push_items++;
-		push_space += this_item_size + sizeof(*item);
+		push_space += this_item_size + sizeof(struct btrfs_item);
 		if (i == 0)
 			break;
 		i--;
@@ -2091,9 +2088,8 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		item = btrfs_item_nr(i);
 		push_space -= btrfs_item_size_nr(right, i);
-		btrfs_set_item_offset(right, item, push_space);
+		btrfs_set_item_offset_nr(right, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -2135,7 +2131,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	int free_space;
 	int push_space = 0;
 	int push_items = 0;
-	struct btrfs_item *item;
 	u32 old_left_nritems;
 	u32 right_nritems;
 	u32 nr;
@@ -2182,17 +2177,15 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		nr = right_nritems - 1;
 
 	for (i = 0; i < nr; i++) {
-		item = btrfs_item_nr(i);
-
 		if (path->slots[0] == i)
-			push_space += data_size + sizeof(*item);
+			push_space += data_size + sizeof(struct btrfs_item);
 
 		this_item_size = btrfs_item_size_nr(right, i);
-		if (this_item_size + sizeof(*item) + push_space > free_space)
+		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
 			break;
 
 		push_items++;
-		push_space += this_item_size + sizeof(*item);
+		push_space += this_item_size + sizeof(struct btrfs_item);
 	}
 
 	if (push_items == 0) {
@@ -2223,9 +2216,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
 
-		item = btrfs_item_nr(i);
 		ioff = btrfs_item_offset_nr(left, i);
-		btrfs_set_item_offset(left, item,
+		btrfs_set_item_offset_nr(left, i,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 			      old_left_item_size));
 	}
@@ -2255,9 +2247,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		item = btrfs_item_nr(i);
 		push_space = push_space - btrfs_item_size_nr(right, i);
-		btrfs_set_item_offset(right, item, push_space);
+		btrfs_set_item_offset_nr(right, i, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(left);
@@ -2318,9 +2309,8 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 		      btrfs_item_end_nr(l, mid);
 
 	for (i = 0; i < nritems; i++) {
-		struct btrfs_item *item = btrfs_item_nr(i);
 		u32 ioff = btrfs_item_offset_nr(right, i);
-		btrfs_set_item_offset(right, item, ioff + rt_data_off);
+		btrfs_set_item_offset_nr(right, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -2537,8 +2527,6 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	u32 item_size;
 	struct extent_buffer *leaf;
 	struct btrfs_key orig_key;
-	struct btrfs_item *item;
-	struct btrfs_item *new_item;
 	int ret = 0;
 	int slot;
 	u32 nritems;
@@ -2573,7 +2561,6 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 
 split:
-	item = btrfs_item_nr(path->slots[0]);
 	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
 	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
 
@@ -2598,14 +2585,12 @@ split:
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
 	btrfs_set_item_key(leaf, &disk_key, slot);
 
-	new_item = btrfs_item_nr(slot);
-
-	btrfs_set_item_offset(leaf, new_item, orig_offset);
-	btrfs_set_item_size(leaf, new_item, item_size - split_offset);
+	btrfs_set_item_offset_nr(leaf, slot, orig_offset);
+	btrfs_set_item_size_nr(leaf, slot, item_size - split_offset);
 
-	btrfs_set_item_offset(leaf, item,
-			      orig_offset + item_size - split_offset);
-	btrfs_set_item_size(leaf, item, split_offset);
+	btrfs_set_item_offset_nr(leaf, path->slots[0],
+				 orig_offset + item_size - split_offset);
+	btrfs_set_item_size_nr(leaf, path->slots[0], split_offset);
 
 	btrfs_set_header_nritems(leaf, nritems + 1);
 
@@ -2634,7 +2619,6 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	u32 nritems;
 	unsigned int data_end;
 	unsigned int old_data_start;
@@ -2665,9 +2649,8 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	/* first correct the data pointers */
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		item = btrfs_item_nr(i);
 		ioff = btrfs_item_offset_nr(leaf, i);
-		btrfs_set_item_offset(leaf, item, ioff + size_diff);
+		btrfs_set_item_offset_nr(leaf, i, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -2711,8 +2694,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			btrfs_fixup_low_keys(path, &disk_key, 1);
 	}
 
-	item = btrfs_item_nr(slot);
-	btrfs_set_item_size(leaf, item, new_size);
+	btrfs_set_item_size_nr(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	ret = 0;
@@ -2729,7 +2711,6 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	u32 nritems;
 	unsigned int data_end;
 	unsigned int old_data;
@@ -2761,9 +2742,8 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	/* first correct the data pointers */
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		item = btrfs_item_nr(i);
 		ioff = btrfs_item_offset_nr(leaf, i);
-		btrfs_set_item_offset(leaf, item, ioff - data_size);
+		btrfs_set_item_offset_nr(leaf, i, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -2773,8 +2753,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	data_end = old_data;
 	old_size = btrfs_item_size_nr(leaf, slot);
-	item = btrfs_item_nr(slot);
-	btrfs_set_item_size(leaf, item, old_size + data_size);
+	btrfs_set_item_size_nr(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	ret = 0;
@@ -2796,7 +2775,6 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			    int nr)
 {
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	int ret = 0;
 	int slot;
 	int i;
@@ -2853,9 +2831,8 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			item = btrfs_item_nr(i);
 			ioff = btrfs_item_offset_nr(leaf, i);
-			btrfs_set_item_offset(leaf, item, ioff - total_data);
+			btrfs_set_item_offset_nr(leaf, i, ioff - total_data);
 		}
 
 		/* shift the items */
@@ -2874,10 +2851,9 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	for (i = 0; i < nr; i++) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key + i);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
-		item = btrfs_item_nr(slot + i);
-		btrfs_set_item_offset(leaf, item, data_end - data_size[i]);
+		btrfs_set_item_offset_nr(leaf, slot + i, data_end - data_size[i]);
 		data_end -= data_size[i];
-		btrfs_set_item_size(leaf, item, data_size[i]);
+		btrfs_set_item_size_nr(leaf, slot + i, data_size[i]);
 	}
 	btrfs_set_header_nritems(leaf, nritems + nr);
 	btrfs_mark_buffer_dirty(leaf);
@@ -3001,7 +2977,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		    struct btrfs_path *path, int slot, int nr)
 {
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 	int last_off;
 	int dsize = 0;
 	int ret = 0;
@@ -3028,9 +3003,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			item = btrfs_item_nr(i);
 			ioff = btrfs_item_offset_nr(leaf, i);
-			btrfs_set_item_offset(leaf, item, ioff + dsize);
+			btrfs_set_item_offset_nr(leaf, i, ioff + dsize);
 		}
 
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d9677bce..cda05481 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2005,6 +2005,18 @@ static inline u32 btrfs_item_end_nr(struct extent_buffer *eb, int nr)
 	return btrfs_item_end(eb, btrfs_item_nr(nr));
 }
 
+static inline void btrfs_set_item_size_nr(struct extent_buffer *eb, int nr,
+					  u32 size)
+{
+	btrfs_set_item_size(eb, btrfs_item_nr(nr), size);
+}
+
+static inline void btrfs_set_item_offset_nr(struct extent_buffer *eb, int nr,
+					    u32 offset)
+{
+	btrfs_set_item_offset(eb, btrfs_item_nr(nr), offset);
+}
+
 static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
 {
 	return btrfs_item_offset(eb, btrfs_item_nr(nr));
diff --git a/mkfs/common.c b/mkfs/common.c
index f3e689cb..0ea0d114 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -104,9 +104,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 		btrfs_set_disk_key_objectid(&disk_key,
 			reference_root_table[blk]);
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-		btrfs_set_item_size(buf, btrfs_item_nr(nritems),
-				sizeof(root_item));
+		btrfs_set_item_offset_nr(buf, nritems, itemoff);
+		btrfs_set_item_size_nr(buf, nritems, sizeof(root_item));
 		if (blk == MKFS_FS_TREE) {
 			time_t now = time(NULL);
 
@@ -160,8 +159,8 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_disk_key_offset(&disk_key, group_size);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_INFO_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(nritems), sizeof(*info));
+	btrfs_set_item_offset_nr(buf, nritems, itemoff);
+	btrfs_set_item_size_nr(buf, nritems, sizeof(*info));
 
 	info = btrfs_item_ptr(buf, nritems, struct btrfs_free_space_info);
 	btrfs_set_free_space_extent_count(buf, info, 1);
@@ -172,8 +171,8 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_disk_key_offset(&disk_key, group_start + group_size - free_start);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
+	btrfs_set_item_offset_nr(buf, nritems, itemoff);
+	btrfs_set_item_size_nr(buf, nritems, 0);
 
 	nritems++;
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FREE_SPACE_TREE]);
@@ -341,8 +340,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			btrfs_set_disk_key_offset(&disk_key, system_group_size);
 			btrfs_set_disk_key_type(&disk_key, BTRFS_BLOCK_GROUP_ITEM_KEY);
 			btrfs_set_item_key(buf, &disk_key, nritems);
-			btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-			btrfs_set_item_size(buf, btrfs_item_nr(nritems), sizeof(*bg_item));
+			btrfs_set_item_offset_nr(buf, nritems, itemoff);
+			btrfs_set_item_size_nr(buf, nritems, sizeof(*bg_item));
 
 			bg_item = btrfs_item_ptr(buf, nritems,
 						 struct btrfs_block_group_item);
@@ -387,10 +386,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			btrfs_set_disk_key_offset(&disk_key, cfg->nodesize);
 		}
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
-				      itemoff);
-		btrfs_set_item_size(buf, btrfs_item_nr(nritems),
-				    item_size);
+		btrfs_set_item_offset_nr(buf, nritems, itemoff);
+		btrfs_set_item_size_nr(buf, nritems, item_size);
 		extent_item = btrfs_item_ptr(buf, nritems,
 					     struct btrfs_extent_item);
 		btrfs_set_extent_refs(buf, extent_item, 1);
@@ -405,9 +402,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_disk_key_offset(&disk_key, ref_root);
 		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
-				      itemoff);
-		btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
+		btrfs_set_item_offset_nr(buf, nritems, itemoff);
+		btrfs_set_item_size_nr(buf, nritems, 0);
 		nritems++;
 	}
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
@@ -434,8 +430,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, 1);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
+	btrfs_set_item_offset_nr(buf, nritems, itemoff);
+	btrfs_set_item_size_nr(buf, nritems, item_size);
 
 	dev_item = btrfs_item_ptr(buf, nritems, struct btrfs_dev_item);
 	btrfs_set_device_id(buf, dev_item, 1);
@@ -465,8 +461,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_CHUNK_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
+	btrfs_set_item_offset_nr(buf, nritems, itemoff);
+	btrfs_set_item_size_nr(buf, nritems, item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
 	btrfs_set_chunk_length(buf, chunk, system_group_size);
@@ -521,9 +517,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
-	btrfs_set_item_size(buf, btrfs_item_nr(nritems),
-			    sizeof(struct btrfs_dev_extent));
+	btrfs_set_item_offset_nr(buf, nritems, itemoff);
+	btrfs_set_item_size_nr(buf, nritems, sizeof(struct btrfs_dev_extent));
 	dev_extent = btrfs_item_ptr(buf, nritems, struct btrfs_dev_extent);
 	btrfs_set_dev_extent_chunk_tree(buf, dev_extent,
 					BTRFS_CHUNK_TREE_OBJECTID);
-- 
2.26.3

