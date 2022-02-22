Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDF4C0493
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiBVW1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiBVW1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:09 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610CB12C4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:40 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j5so3431997qvs.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SwOntcvzjumnY+pRayiV7cp4dQZJQxVSCCKQlTk6wl8=;
        b=G9TkuFZSlnItoMa2aCxP7MbFkvN2uhbBlbVomx5AoHvHhswqgFM03oVVFZrchjCiRK
         XnYIIlXqwCloU1nXoSwKJqL9tG4cTc7TvST/tobnL67vBc7QM3/6neBgK3ACgoCWR8RQ
         FzC4pvCfMuDQZpBPplSkNMQSOn1eIlVbZQ3em8Lk8/NTIXSjXx9xb9eM5pnbE1OLM8Z3
         MWyq3UmdQttn2h0qqyNNyo5579Iyb8rs5jEY1UPsmuEb4+NTZD5Q7ojlFFIShwjO9sJ7
         TvITY0XlXrRRNqkSBoi6vvsbZrFFYZgwONl8iBAZWgLQIdr7+8kJ0mfY6cJ+nsILrTdt
         6SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwOntcvzjumnY+pRayiV7cp4dQZJQxVSCCKQlTk6wl8=;
        b=v8/sWcWiIFISCIN21kF67ZnA/syVbN651kJX03kHp4TH7nLLm0hGwsLSmtyBzH4Rbp
         YocVg2EpmE4QqHBsbqTbcY5S4jxH4TcqzE89t3AtaSm5n2QwYBPh/+eUlruuBZ65EX1z
         HQhFLkXp+ykB6clz/1Hwy6wIBvpL4YGXNY4nYnBlf1XM0p5MOka0BsVO0UOtv3QZ3WhB
         knjpZR8NDe2DeKioekddz7YTQ0dE+rGR1bRyWOn0Hr9WOogIpy8O38HvJcXyQ5/xisdk
         hZaPb/dvwgN2VW0fQqNY3sr8mU5UDRMxaIdrHD1hjVj8qKduNxzA+61rD8zJnbOvuKQm
         0mmg==
X-Gm-Message-State: AOAM532upk4Wm3NyFqiBozR14nJcEBfhEX7JBiMKnGC5PvwA3BNaiBi4
        vWDqu/mM4YSB2YPex+XZkQ0JUBWM4l5Z713c
X-Google-Smtp-Source: ABdhPJy3bNA8/VZPspiW8ZJ4wWcyJl55WTpiwEJ/de+iVttOK6naJZpWdcpY0HeJ1phQgeQEfmXrcg==
X-Received: by 2002:a05:622a:40e:b0:2dc:eb59:4855 with SMTP id n14-20020a05622a040e00b002dceb594855mr24951396qtx.526.1645568798255;
        Tue, 22 Feb 2022 14:26:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h19sm839194qtx.12.2022.02.22.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/13] btrfs-progs: remove the _nr from the item helpers
Date:   Tue, 22 Feb 2022 17:26:20 -0500
Message-Id: <cf0dc72c817b75a3722d697716fed7d2c1d8cc2c.1645568701.git.josef@toxicpanda.com>
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

Now that all callers are using the _nr variations we can simply rename
these helpers to btrfs_item_##member/btrfs_set_item_##member and change
the actual item SETGET funcs to raw_item_##member/set_raw_item_##member
and then change all callers to drop the _nr part.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c       | 16 +++----
 check/main.c                | 50 ++++++++++-----------
 check/mode-common.c         | 12 ++---
 check/mode-lowmem.c         | 30 ++++++-------
 check/qgroup-verify.c       |  2 +-
 cmds/rescue-chunk-recover.c |  4 +-
 cmds/restore.c              |  2 +-
 convert/common.c            | 24 +++++-----
 image/main.c                | 20 ++++-----
 image/sanitize.c            |  4 +-
 kernel-shared/backref.c     |  8 ++--
 kernel-shared/ctree.c       | 90 ++++++++++++++++++-------------------
 kernel-shared/ctree.h       | 42 +++++++----------
 kernel-shared/dir-item.c    |  8 ++--
 kernel-shared/extent-tree.c | 12 ++---
 kernel-shared/file-item.c   | 12 ++---
 kernel-shared/inode-item.c  | 12 ++---
 kernel-shared/print-tree.c  | 20 ++++-----
 kernel-shared/root-tree.c   |  2 +-
 kernel-shared/uuid-tree.c   |  4 +-
 kernel-shared/volumes.c     | 10 ++---
 mkfs/common.c               | 36 +++++++--------
 22 files changed, 206 insertions(+), 214 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 57a4e271..fb1f15f0 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -246,7 +246,7 @@ static int corrupt_extent(struct btrfs_trans_handle *trans,
 				"corrupting extent record: key %llu %u %llu\n",
 				key.objectid, key.type, key.offset);
 			ptr = btrfs_item_ptr_offset(leaf, slot);
-			item_size = btrfs_item_size_nr(leaf, slot);
+			item_size = btrfs_item_size(leaf, slot);
 			memset_extent_buffer(leaf, 0, ptr, item_size);
 			btrfs_mark_buffer_dirty(leaf);
 		}
@@ -827,18 +827,18 @@ static void shift_items(struct btrfs_root *root, struct extent_buffer *eb)
 	int shift_space = btrfs_leaf_free_space(eb) / 2;
 	int slot = nritems / 2;
 	int i = 0;
-	unsigned int data_end = btrfs_item_offset_nr(eb, nritems - 1);
+	unsigned int data_end = btrfs_item_offset(eb, nritems - 1);
 
 	/* Shift the item data up to and including slot back by shift space */
 	memmove_extent_buffer(eb, btrfs_leaf_data(eb) + data_end - shift_space,
 			      btrfs_leaf_data(eb) + data_end,
-			      btrfs_item_offset_nr(eb, slot - 1) - data_end);
+			      btrfs_item_offset(eb, slot - 1) - data_end);
 
 	/* Now update the item pointers. */
 	for (i = nritems - 1; i >= slot; i--) {
-		u32 offset = btrfs_item_offset_nr(eb, i);
+		u32 offset = btrfs_item_offset(eb, i);
 		offset -= shift_space;
-		btrfs_set_item_offset_nr(eb, i, offset);
+		btrfs_set_item_offset(eb, i, offset);
 	}
 }
 
@@ -978,9 +978,9 @@ static int corrupt_btrfs_item(struct btrfs_root *root, struct btrfs_key *key,
 	ret = 0;
 	switch (corrupt_field) {
 	case BTRFS_ITEM_OFFSET:
-		orig = btrfs_item_offset_nr(path->nodes[0], path->slots[0]);
+		orig = btrfs_item_offset(path->nodes[0], path->slots[0]);
 		bogus = generate_u32(orig);
-		btrfs_set_item_offset_nr(path->nodes[0], path->slots[0], bogus);
+		btrfs_set_item_offset(path->nodes[0], path->slots[0], bogus);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1082,7 +1082,7 @@ static int corrupt_item_nocow(struct btrfs_trans_handle *trans,
 		fprintf(stdout, "Corrupting key and data [%llu, %u, %llu].\n",
 			key.objectid, key.type, key.offset);
 		ptr = btrfs_item_ptr_offset(leaf, slot);
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		memset_extent_buffer(leaf, 0, ptr, item_size);
 		btrfs_mark_buffer_dirty(leaf);
 	}
diff --git a/check/main.c b/check/main.c
index 92e1399f..ed3fde60 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1408,7 +1408,7 @@ static int process_dir_item(struct extent_buffer *eb,
 		return 0;
 
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
-	total = btrfs_item_size_nr(eb, slot);
+	total = btrfs_item_size(eb, slot);
 	while (cur < total) {
 		int ret;
 
@@ -1490,7 +1490,7 @@ static int process_inode_ref(struct extent_buffer *eb,
 	inode_cache = &active_node->inode_cache;
 
 	ref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
-	total = btrfs_item_size_nr(eb, slot);
+	total = btrfs_item_size(eb, slot);
 	while (cur < total) {
 		name_len = btrfs_inode_ref_name_len(eb, ref);
 		index = btrfs_inode_ref_index(eb, ref);
@@ -1539,7 +1539,7 @@ static int process_inode_extref(struct extent_buffer *eb,
 	inode_cache = &active_node->inode_cache;
 
 	extref = btrfs_item_ptr(eb, slot, struct btrfs_inode_extref);
-	total = btrfs_item_size_nr(eb, slot);
+	total = btrfs_item_size(eb, slot);
 	while (cur < total) {
 		name_len = btrfs_inode_extref_name_len(eb, extref);
 		index = btrfs_inode_extref_index(eb, extref);
@@ -4216,10 +4216,10 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 
 		btrfs_item_key_to_cpu(buf, &k1, slot);
 		btrfs_item_key_to_cpu(buf, &k2, slot + 1);
-		item1_offset = btrfs_item_offset_nr(buf, slot);
-		item2_offset = btrfs_item_offset_nr(buf, slot + 1);
-		item1_size = btrfs_item_size_nr(buf, slot);
-		item2_size = btrfs_item_size_nr(buf, slot + 1);
+		item1_offset = btrfs_item_offset(buf, slot);
+		item2_offset = btrfs_item_offset(buf, slot + 1);
+		item1_size = btrfs_item_size(buf, slot);
+		item2_size = btrfs_item_size(buf, slot + 1);
 
 		item1_data = malloc(item1_size);
 		if (!item1_data)
@@ -4238,10 +4238,10 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 		free(item1_data);
 		free(item2_data);
 
-		btrfs_set_item_offset_nr(buf, slot, item2_offset);
-		btrfs_set_item_offset_nr(buf, slot + 1, item1_offset);
-		btrfs_set_item_size_nr(buf, slot, item2_size);
-		btrfs_set_item_size_nr(buf, slot + 1, item1_size);
+		btrfs_set_item_offset(buf, slot, item2_offset);
+		btrfs_set_item_offset(buf, slot + 1, item1_offset);
+		btrfs_set_item_size(buf, slot, item2_size);
+		btrfs_set_item_size(buf, slot + 1, item1_size);
 
 		path->slots[0] = slot;
 		btrfs_set_item_key_unsafe(root, path, &k2);
@@ -4342,9 +4342,9 @@ again:
 			shift = BTRFS_LEAF_DATA_SIZE(gfs_info) -
 				btrfs_item_end(buf, i);
 		} else if (i > 0 && btrfs_item_end(buf, i) !=
-			   btrfs_item_offset_nr(buf, i - 1)) {
+			   btrfs_item_offset(buf, i - 1)) {
 			if (btrfs_item_end(buf, i) >
-			    btrfs_item_offset_nr(buf, i - 1)) {
+			    btrfs_item_offset(buf, i - 1)) {
 				ret = delete_bogus_item(root, path, buf, i);
 				if (!ret)
 					goto again;
@@ -4352,7 +4352,7 @@ again:
 				ret = -EIO;
 				break;
 			}
-			shift = btrfs_item_offset_nr(buf, i - 1) -
+			shift = btrfs_item_offset(buf, i - 1) -
 				btrfs_item_end(buf, i);
 		}
 		if (!shift)
@@ -4360,12 +4360,12 @@ again:
 
 		printf("Shifting item nr %d by %u bytes in block %llu\n",
 		       i, shift, (unsigned long long)buf->start);
-		offset = btrfs_item_offset_nr(buf, i);
+		offset = btrfs_item_offset(buf, i);
 		memmove_extent_buffer(buf,
 				      btrfs_leaf_data(buf) + offset + shift,
 				      btrfs_leaf_data(buf) + offset,
-				      btrfs_item_size_nr(buf, i));
-		btrfs_set_item_offset_nr(buf, i, offset + shift);
+				      btrfs_item_size(buf, i));
+		btrfs_set_item_offset(buf, i, offset + shift);
 		btrfs_mark_buffer_dirty(buf);
 	}
 
@@ -5403,7 +5403,7 @@ static int process_extent_item(struct btrfs_root *root,
 	unsigned long ptr;
 	int ret;
 	int type;
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	u64 refs = 0;
 	u64 offset;
 	u64 num_bytes;
@@ -6077,7 +6077,7 @@ static int check_csum_root(struct btrfs_root *root)
 				path.slots[0]);
 			errors++;
 		}
-		num_entries = btrfs_item_size_nr(leaf, path.slots[0]) / csum_size;
+		num_entries = btrfs_item_size(leaf, path.slots[0]) / csum_size;
 		data_len = num_entries * gfs_info->sectorsize;
 
 		if (num_entries > max_entries) {
@@ -6459,7 +6459,7 @@ static int run_next_block(struct btrfs_root *root,
 			}
 			if (key.type == BTRFS_EXTENT_CSUM_KEY) {
 				total_csum_bytes +=
-					btrfs_item_size_nr(buf, i);
+					btrfs_item_size(buf, i);
 				continue;
 			}
 			if (key.type == BTRFS_CHUNK_ITEM_KEY) {
@@ -6552,11 +6552,11 @@ static int run_next_block(struct btrfs_root *root,
 			if (key.type != BTRFS_EXTENT_DATA_KEY)
 				continue;
 			/* Check itemsize before we continue */
-			if (btrfs_item_size_nr(buf, i) < inline_offset) {
+			if (btrfs_item_size(buf, i) < inline_offset) {
 				ret = -EUCLEAN;
 				error(
 		"invalid file extent item size, have %u expect (%lu, %u]",
-					btrfs_item_size_nr(buf, i),
+					btrfs_item_size(buf, i),
 					inline_offset,
 					BTRFS_LEAF_DATA_SIZE(gfs_info));
 				continue;
@@ -6568,12 +6568,12 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
-			if (btrfs_item_size_nr(buf, i) !=
+			if (btrfs_item_size(buf, i) !=
 			    sizeof(struct btrfs_file_extent_item)) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
-					btrfs_item_size_nr(buf, i),
+					btrfs_item_size(buf, i),
 					sizeof(struct btrfs_file_extent_item));
 				continue;
 			}
@@ -9661,7 +9661,7 @@ static int build_roots_info_cache(void)
 
 		ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 		flags = btrfs_extent_flags(leaf, ei);
-		item_end = (unsigned long)ei + btrfs_item_size_nr(leaf, slot);
+		item_end = (unsigned long)ei + btrfs_item_size(leaf, slot);
 
 		if (found_key.type == BTRFS_EXTENT_ITEM_KEY &&
 		    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
diff --git a/check/mode-common.c b/check/mode-common.c
index c3d8bb45..f05960ac 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -205,7 +205,7 @@ int check_prealloc_extent_written(u64 disk_bytenr, u64 num_bytes)
 	/* First check all inline refs. */
 	ei = btrfs_item_ptr(path.nodes[0], path.slots[0],
 			    struct btrfs_extent_item);
-	item_size = btrfs_item_size_nr(path.nodes[0], path.slots[0]);
+	item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
 	ptr = (unsigned long)(ei + 1);
 	end = (unsigned long)ei + item_size;
 	while (ptr < end) {
@@ -340,7 +340,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 		if (key.offset > start)
 			start = key.offset;
 
-		size = btrfs_item_size_nr(leaf, path.slots[0]);
+		size = btrfs_item_size(leaf, path.slots[0]);
 		csum_end = key.offset + (size / csum_size) *
 			   gfs_info->sectorsize;
 		if (csum_end > start) {
@@ -758,7 +758,7 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 	if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 		goto out;
 	len = min_t(u32, BTRFS_NAME_LEN,
-		btrfs_item_size_nr(path.nodes[0], path.slots[0]) - sizeof(*di));
+		btrfs_item_size(path.nodes[0], path.slots[0]) - sizeof(*di));
 	len = min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
 	read_extent_buffer(path.nodes[0], namebuf, (unsigned long)(di + 1), len);
 	if (name_len != len || memcmp(namebuf, name, len))
@@ -802,7 +802,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 		goto out;
 
 	cur = btrfs_item_ptr_offset(path.nodes[0], path.slots[0]);
-	end = cur + btrfs_item_size_nr(path.nodes[0], path.slots[0]);
+	end = cur + btrfs_item_size(path.nodes[0], path.slots[0]);
 	while (cur < end) {
 		di = (struct btrfs_dir_item *)cur;
 		cur += btrfs_dir_name_len(path.nodes[0], di) + sizeof(*di);
@@ -817,7 +817,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 		if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 			continue;
 		len = min_t(u32, BTRFS_NAME_LEN,
-			    btrfs_item_size_nr(path.nodes[0], path.slots[0]) -
+			    btrfs_item_size(path.nodes[0], path.slots[0]) -
 			    sizeof(*di));
 		len = min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
 		read_extent_buffer(path.nodes[0], namebuf,
@@ -903,7 +903,7 @@ int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
 		case BTRFS_INODE_REF_KEY:
 			/* The most accurate way to determine filetype */
 			cur = btrfs_item_ptr_offset(leaf, slot);
-			end = cur + btrfs_item_size_nr(leaf, slot);
+			end = cur + btrfs_item_size(leaf, slot);
 			while (cur < end) {
 				iref = (struct btrfs_inode_ref *)cur;
 				namelen = min_t(u32, end - cur - sizeof(&iref),
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 729c453a..99d04945 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -98,7 +98,7 @@ static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 		goto full_backref;
 
 	ptr = (unsigned long)(ei + 1);
-	end = (unsigned long)ei + btrfs_item_size_nr(eb, slot);
+	end = (unsigned long)ei + btrfs_item_size(eb, slot);
 
 	if (key.type == BTRFS_EXTENT_ITEM_KEY)
 		ptr += sizeof(struct btrfs_tree_block_info);
@@ -844,7 +844,7 @@ loop:
 	node = path.nodes[0];
 	slot = path.slots[0];
 	di = btrfs_item_ptr(node, slot, struct btrfs_dir_item);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 	while (cur < total) {
 		ret = -ENOENT;
 		len = btrfs_dir_name_len(node, di);
@@ -940,7 +940,7 @@ static int find_dir_item(struct btrfs_root *root, struct btrfs_key *key,
 	node = path.nodes[0];
 	slot = path.slots[0];
 	di = btrfs_item_ptr(node, slot, struct btrfs_dir_item);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 	while (cur < total) {
 		ret = key->type == BTRFS_DIR_ITEM_KEY ?
 			DIR_ITEM_MISMATCH : DIR_INDEX_MISMATCH;
@@ -1147,7 +1147,7 @@ begin:
 
 	memset(namebuf, 0, sizeof(namebuf) / sizeof(*namebuf));
 	ref = btrfs_item_ptr(node, slot, struct btrfs_inode_ref);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 
 next:
 	/* Update inode ref count */
@@ -1256,7 +1256,7 @@ static int check_inode_extref(struct btrfs_root *root,
 	location.offset = 0;
 
 	extref = btrfs_item_ptr(node, slot, struct btrfs_inode_extref);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 
 next:
 	/* update inode ref count */
@@ -1352,7 +1352,7 @@ static int find_inode_ref(struct btrfs_root *root, struct btrfs_key *key,
 	slot = path.slots[0];
 
 	ref = btrfs_item_ptr(node, slot, struct btrfs_inode_ref);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 
 	/* Iterate all entry of INODE_REF */
 	while (cur < total) {
@@ -1418,7 +1418,7 @@ extref:
 
 	extref = btrfs_item_ptr(node, slot, struct btrfs_inode_extref);
 	cur = 0;
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 
 	/* Iterate all entry of INODE_EXTREF */
 	while (cur < total) {
@@ -1710,7 +1710,7 @@ begin:
 	slot = path->slots[0];
 
 	di = btrfs_item_ptr(node, slot, struct btrfs_dir_item);
-	total = btrfs_item_size_nr(node, slot);
+	total = btrfs_item_size(node, slot);
 	memset(namebuf, 0, sizeof(namebuf) / sizeof(*namebuf));
 
 	while (cur < total) {
@@ -2206,7 +2206,7 @@ loop:
 special_case:
 	di = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_dir_item);
 	cur = 0;
-	total = btrfs_item_size_nr(path.nodes[0], path.slots[0]);
+	total = btrfs_item_size(path.nodes[0], path.slots[0]);
 
 	while (cur < total) {
 		len = btrfs_dir_name_len(path.nodes[0], di);
@@ -3106,7 +3106,7 @@ static int check_tree_block_ref(struct btrfs_root *root,
 	/*
 	 * Iterate the extent/metadata item to find the exact backref
 	 */
-	item_size = btrfs_item_size_nr(leaf, slot);
+	item_size = btrfs_item_size(leaf, slot);
 	ptr = (unsigned long)iref;
 	end = (unsigned long)ei + item_size;
 
@@ -3448,7 +3448,7 @@ static int check_extent_data_item(struct btrfs_root *root,
 	}
 
 	/* Check data backref inside that extent item */
-	item_size = btrfs_item_size_nr(leaf, path.slots[0]);
+	item_size = btrfs_item_size(leaf, path.slots[0]);
 	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
 	ptr = (unsigned long)iref;
 	end = (unsigned long)ei + item_size;
@@ -4230,7 +4230,7 @@ static int check_extent_item(struct btrfs_path *path)
 	int slot = path->slots[0];
 	int type;
 	u32 nodesize = btrfs_super_nodesize(gfs_info->super_copy);
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	u64 flags;
 	u64 offset;
 	u64 parent;
@@ -4391,7 +4391,7 @@ next:
 			eb = path->nodes[0];
 			slot = path->slots[0];
 			ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
-			item_size = btrfs_item_size_nr(eb, slot);
+			item_size = btrfs_item_size(eb, slot);
 			goto next;
 		}
 	}
@@ -4408,7 +4408,7 @@ next:
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(eb, slot);
+		item_size = btrfs_item_size(eb, slot);
 		ptr_offset += btrfs_extent_inline_ref_size(type);
 		goto next;
 	}
@@ -4846,7 +4846,7 @@ again:
 		err |= ret;
 		break;
 	case BTRFS_EXTENT_CSUM_KEY:
-		total_csum_bytes += btrfs_item_size_nr(eb, slot);
+		total_csum_bytes += btrfs_item_size(eb, slot);
 		err |= ret;
 		break;
 	case BTRFS_TREE_BLOCK_REF_KEY:
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0813b841..2c05f875 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1041,7 +1041,7 @@ static int add_inline_refs(struct btrfs_fs_info *info,
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_extent_data_ref *dref;
 	u64 flags, root_obj, offset, parent;
-	u32 item_size = btrfs_item_size_nr(ei_leaf, slot);
+	u32 item_size = btrfs_item_size(ei_leaf, slot);
 	int type;
 	unsigned long end;
 	unsigned long ptr;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index da24df4c..ec5c206f 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1812,7 +1812,7 @@ static int next_csum(struct btrfs_root *csum_root,
 	struct btrfs_csum_item *csum_item;
 	u32 blocksize = csum_root->fs_info->sectorsize;
 	u16 csum_size = csum_root->fs_info->csum_size;
-	int csums_in_item = btrfs_item_size_nr(*leaf, *slot) / csum_size;
+	int csums_in_item = btrfs_item_size(*leaf, *slot) / csum_size;
 
 	if (*csum_offset >= csums_in_item) {
 		++(*slot);
@@ -1897,7 +1897,7 @@ static u64 item_end_offset(struct btrfs_root *root, struct btrfs_key *key,
 	u32 blocksize = root->fs_info->sectorsize;
 	u16 csum_size = root->fs_info->csum_size;
 
-	u64 offset = btrfs_item_size_nr(leaf, slot);
+	u64 offset = btrfs_item_size(leaf, slot);
 	offset /= csum_size;
 	offset *= blocksize;
 	offset += key->offset;
diff --git a/cmds/restore.c b/cmds/restore.c
index bc88af70..81ca6cd5 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -512,7 +512,7 @@ static int set_file_xattrs(struct btrfs_root *root, u64 inode,
 		if (key.type != BTRFS_XATTR_ITEM_KEY || key.objectid != inode)
 			break;
 		cur = 0;
-		total_len = btrfs_item_size_nr(leaf, path.slots[0]);
+		total_len = btrfs_item_size(leaf, path.slots[0]);
 		di = btrfs_item_ptr(leaf, path.slots[0],
 				    struct btrfs_dir_item);
 
diff --git a/convert/common.c b/convert/common.c
index 38112084..0fb7b6c5 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -204,8 +204,8 @@ static void insert_temp_root_item(struct extent_buffer *buf,
 	btrfs_set_disk_key_offset(&disk_key, 0);
 
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, sizeof(root_item));
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, sizeof(root_item));
 	write_extent_buffer(buf, &root_item,
 			    btrfs_item_ptr_offset(buf, *slot),
 			    sizeof(root_item));
@@ -311,8 +311,8 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_DEV_ITEMS_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, 1);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, sizeof(*dev_item));
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, sizeof(*dev_item));
 
 	dev_item = btrfs_item_ptr(buf, *slot, struct btrfs_dev_item);
 	/* Generate device uuid */
@@ -369,8 +369,8 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, start);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, btrfs_chunk_item_size(1));
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, btrfs_chunk_item_size(1));
 
 	chunk = btrfs_item_ptr(buf, *slot, struct btrfs_chunk);
 	btrfs_set_chunk_length(buf, chunk, len);
@@ -471,8 +471,8 @@ static void insert_temp_dev_extent(struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, 1);
 	btrfs_set_disk_key_offset(&disk_key, start);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, sizeof(*dev_extent));
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, sizeof(*dev_extent));
 
 	dev_extent = btrfs_item_ptr(buf, *slot, struct btrfs_dev_extent);
 	btrfs_set_dev_extent_chunk_objectid(buf, dev_extent,
@@ -603,8 +603,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, itemsize);
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, itemsize);
 
 	ei = btrfs_item_ptr(buf, *slot, struct btrfs_extent_item);
 	btrfs_set_extent_refs(buf, ei, 1);
@@ -669,8 +669,8 @@ static void insert_temp_block_group(struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 	btrfs_set_disk_key_offset(&disk_key, len);
 	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset_nr(buf, *slot, *itemoff);
-	btrfs_set_item_size_nr(buf, *slot, sizeof(bgi));
+	btrfs_set_item_offset(buf, *slot, *itemoff);
+	btrfs_set_item_size(buf, *slot, sizeof(bgi));
 
 	btrfs_set_stack_block_group_flags(&bgi, flag);
 	btrfs_set_stack_block_group_used(&bgi, used);
diff --git a/image/main.c b/image/main.c
index 5d67d282..ff121fca 100644
--- a/image/main.c
+++ b/image/main.c
@@ -311,9 +311,9 @@ static void zero_items(struct metadump_struct *md, u8 *dst,
 	for (i = 0; i < nritems; i++) {
 		btrfs_item_key_to_cpu(src, &key, i);
 		if (key.type == BTRFS_CSUM_ITEM_KEY) {
-			size = btrfs_item_size_nr(src, i);
+			size = btrfs_item_size(src, i);
 			memset(dst + btrfs_leaf_data(src) +
-			       btrfs_item_offset_nr(src, i), 0, size);
+			       btrfs_item_offset(src, i), 0, size);
 			continue;
 		}
 
@@ -359,7 +359,7 @@ static void copy_buffer(struct metadump_struct *md, u8 *dst,
 		memset(dst + size, 0, src->len - size);
 	} else if (level == 0) {
 		size = btrfs_leaf_data(src) +
-			btrfs_item_offset_nr(src, nritems - 1) -
+			btrfs_item_offset(src, nritems - 1) -
 			btrfs_item_nr_offset(nritems);
 		memset(dst + btrfs_item_nr_offset(nritems), 0, size);
 		zero_items(md, dst, src);
@@ -971,7 +971,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 			break;
 		}
 
-		if (btrfs_item_size_nr(leaf, path->slots[0]) >= sizeof(*ei)) {
+		if (btrfs_item_size(leaf, path->slots[0]) >= sizeof(*ei)) {
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			if (btrfs_extent_flags(leaf, ei) &
@@ -1223,26 +1223,26 @@ static void truncate_item(struct extent_buffer *eb, int slot, u32 new_size)
 	u32 data_end;
 	int i;
 
-	old_size = btrfs_item_size_nr(eb, slot);
+	old_size = btrfs_item_size(eb, slot);
 	if (old_size == new_size)
 		return;
 
 	nritems = btrfs_header_nritems(eb);
-	data_end = btrfs_item_offset_nr(eb, nritems - 1);
+	data_end = btrfs_item_offset(eb, nritems - 1);
 
-	old_data_start = btrfs_item_offset_nr(eb, slot);
+	old_data_start = btrfs_item_offset(eb, slot);
 	size_diff = old_size - new_size;
 
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		ioff = btrfs_item_offset_nr(eb, i);
-		btrfs_set_item_offset_nr(eb, i, ioff + size_diff);
+		ioff = btrfs_item_offset(eb, i);
+		btrfs_set_item_offset(eb, i, ioff + size_diff);
 	}
 
 	memmove_extent_buffer(eb, btrfs_leaf_data(eb) + data_end + size_diff,
 			      btrfs_leaf_data(eb) + data_end,
 			      old_data_start + new_size - data_end);
-	btrfs_set_item_size_nr(eb, slot, new_size);
+	btrfs_set_item_size(eb, slot, new_size);
 }
 
 static int fixup_chunk_tree_block(struct mdrestore_struct *mdres,
diff --git a/image/sanitize.c b/image/sanitize.c
index e3ac1b84..c6970403 100644
--- a/image/sanitize.c
+++ b/image/sanitize.c
@@ -325,7 +325,7 @@ static void sanitize_dir_item(enum sanitize_mode sanitize,
 	int free_garbage = (sanitize == SANITIZE_NAMES);
 
 	dir_item = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
-	total_len = btrfs_item_size_nr(eb, slot);
+	total_len = btrfs_item_size(eb, slot);
 	while (cur < total_len) {
 		this_len = sizeof(*dir_item) +
 			btrfs_dir_name_len(eb, dir_item) +
@@ -371,7 +371,7 @@ static void sanitize_inode_ref(enum sanitize_mode sanitize,
 	int len;
 	int free_garbage = (sanitize == SANITIZE_NAMES);
 
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	ptr = btrfs_item_ptr_offset(eb, slot);
 	while (cur_offset < item_size) {
 		if (ext) {
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 327599b7..9c5a3895 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -561,7 +561,7 @@ static int __add_inline_refs(struct btrfs_fs_info *fs_info,
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
-	item_size = btrfs_item_size_nr(leaf, slot);
+	item_size = btrfs_item_size(leaf, slot);
 	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
@@ -1182,7 +1182,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	}
 
 	eb = path->nodes[0];
-	item_size = btrfs_item_size_nr(eb, path->slots[0]);
+	item_size = btrfs_item_size(eb, path->slots[0]);
 	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(eb, path->slots[0], struct btrfs_extent_item);
@@ -1443,7 +1443,7 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 
 		iref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
 
-		for (cur = 0; cur < btrfs_item_size_nr(eb, slot); cur += len) {
+		for (cur = 0; cur < btrfs_item_size(eb, slot); cur += len) {
 			name_len = btrfs_inode_ref_name_len(eb, iref);
 			/* path must be released before calling iterate()! */
 			pr_debug("following ref at offset %u for inode %llu in "
@@ -1502,7 +1502,7 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
 		btrfs_release_path(path);
 
 		leaf = path->nodes[0];
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		cur_offset = 0;
 
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index d18c91d1..04847cd5 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -582,7 +582,7 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 	u32 nr = btrfs_header_nritems(leaf);
 	if (nr == 0)
 		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
-	return btrfs_item_offset_nr(leaf, nr - 1);
+	return btrfs_item_offset(leaf, nr - 1);
 }
 
 static void generic_err(const struct extent_buffer *buf, int slot,
@@ -728,7 +728,7 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 		if (slot == 0)
 			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
 		else
-			item_end_expected = btrfs_item_offset_nr(leaf,
+			item_end_expected = btrfs_item_offset(leaf,
 								 slot - 1);
 		if (btrfs_item_end(leaf, slot) != item_end_expected) {
 			generic_err(leaf, slot,
@@ -1932,7 +1932,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 	if (!nr)
 		return 0;
 	data_len = btrfs_item_end(l, start);
-	data_len = data_len - btrfs_item_offset_nr(l, end);
+	data_len = data_len - btrfs_item_offset(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
 	return data_len;
@@ -2038,7 +2038,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		if (path->slots[0] == i)
 			push_space += data_size + sizeof(struct btrfs_item);
 
-		this_item_size = btrfs_item_size_nr(left, i);
+		this_item_size = btrfs_item_size(left, i);
 		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
 			break;
 		push_items++;
@@ -2088,8 +2088,8 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space -= btrfs_item_size_nr(right, i);
-		btrfs_set_item_offset_nr(right, i, push_space);
+		push_space -= btrfs_item_size(right, i);
+		btrfs_set_item_offset(right, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -2180,7 +2180,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		if (path->slots[0] == i)
 			push_space += data_size + sizeof(struct btrfs_item);
 
-		this_item_size = btrfs_item_size_nr(right, i);
+		this_item_size = btrfs_item_size(right, i);
 		if (this_item_size + sizeof(struct btrfs_item) + push_space > free_space)
 			break;
 
@@ -2202,22 +2202,22 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
-		     btrfs_item_offset_nr(right, push_items -1);
+		     btrfs_item_offset(right, push_items -1);
 
 	copy_extent_buffer(left, right, btrfs_leaf_data(left) +
 		     leaf_data_end(left) - push_space,
 		     btrfs_leaf_data(right) +
-		     btrfs_item_offset_nr(right, push_items - 1),
+		     btrfs_item_offset(right, push_items - 1),
 		     push_space);
 	old_left_nritems = btrfs_header_nritems(left);
 	BUG_ON(old_left_nritems == 0);
 
-	old_left_item_size = btrfs_item_offset_nr(left, old_left_nritems - 1);
+	old_left_item_size = btrfs_item_offset(left, old_left_nritems - 1);
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
 
-		ioff = btrfs_item_offset_nr(left, i);
-		btrfs_set_item_offset_nr(left, i,
+		ioff = btrfs_item_offset(left, i);
+		btrfs_set_item_offset(left, i,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 			      old_left_item_size));
 	}
@@ -2230,7 +2230,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	}
 
 	if (push_items < right_nritems) {
-		push_space = btrfs_item_offset_nr(right, push_items - 1) -
+		push_space = btrfs_item_offset(right, push_items - 1) -
 						  leaf_data_end(right);
 		memmove_extent_buffer(right, btrfs_leaf_data(right) +
 				      BTRFS_LEAF_DATA_SIZE(root->fs_info) -
@@ -2247,8 +2247,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space = push_space - btrfs_item_size_nr(right, i);
-		btrfs_set_item_offset_nr(right, i, push_space);
+		push_space = push_space - btrfs_item_size(right, i);
+		btrfs_set_item_offset(right, i, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(left);
@@ -2309,8 +2309,8 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 		      btrfs_item_end(l, mid);
 
 	for (i = 0; i < nritems; i++) {
-		u32 ioff = btrfs_item_offset_nr(right, i);
-		btrfs_set_item_offset_nr(right, i, ioff + rt_data_off);
+		u32 ioff = btrfs_item_offset(right, i);
+		btrfs_set_item_offset(right, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -2364,7 +2364,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 
 	l = path->nodes[0];
 	slot = path->slots[0];
-	if (extend && data_size + btrfs_item_size_nr(l, slot) +
+	if (extend && data_size + btrfs_item_size(l, slot) +
 	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info))
 		return -EOVERFLOW;
 
@@ -2540,7 +2540,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	    sizeof(struct btrfs_item))
 		goto split;
 
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	btrfs_release_path(path);
 
 	path->search_for_split = 1;
@@ -2549,7 +2549,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	path->search_for_split = 0;
 
 	/* if our item isn't there or got smaller, return now */
-	if (ret != 0 || item_size != btrfs_item_size_nr(path->nodes[0],
+	if (ret != 0 || item_size != btrfs_item_size(path->nodes[0],
 							path->slots[0])) {
 		return -EAGAIN;
 	}
@@ -2561,8 +2561,8 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 
 split:
-	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 
 	buf = kmalloc(item_size, GFP_NOFS);
@@ -2585,12 +2585,12 @@ split:
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
 	btrfs_set_item_key(leaf, &disk_key, slot);
 
-	btrfs_set_item_offset_nr(leaf, slot, orig_offset);
-	btrfs_set_item_size_nr(leaf, slot, item_size - split_offset);
+	btrfs_set_item_offset(leaf, slot, orig_offset);
+	btrfs_set_item_size(leaf, slot, item_size - split_offset);
 
-	btrfs_set_item_offset_nr(leaf, path->slots[0],
+	btrfs_set_item_offset(leaf, path->slots[0],
 				 orig_offset + item_size - split_offset);
-	btrfs_set_item_size_nr(leaf, path->slots[0], split_offset);
+	btrfs_set_item_size(leaf, path->slots[0], split_offset);
 
 	btrfs_set_header_nritems(leaf, nritems + 1);
 
@@ -2629,14 +2629,14 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
-	old_size = btrfs_item_size_nr(leaf, slot);
+	old_size = btrfs_item_size(leaf, slot);
 	if (old_size == new_size)
 		return 0;
 
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
 
-	old_data_start = btrfs_item_offset_nr(leaf, slot);
+	old_data_start = btrfs_item_offset(leaf, slot);
 
 	size_diff = old_size - new_size;
 
@@ -2649,8 +2649,8 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	/* first correct the data pointers */
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		ioff = btrfs_item_offset_nr(leaf, i);
-		btrfs_set_item_offset_nr(leaf, i, ioff + size_diff);
+		ioff = btrfs_item_offset(leaf, i);
+		btrfs_set_item_offset(leaf, i, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -2694,7 +2694,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			btrfs_fixup_low_keys(path, &disk_key, 1);
 	}
 
-	btrfs_set_item_size_nr(leaf, slot, new_size);
+	btrfs_set_item_size(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	ret = 0;
@@ -2742,8 +2742,8 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	/* first correct the data pointers */
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
-		ioff = btrfs_item_offset_nr(leaf, i);
-		btrfs_set_item_offset_nr(leaf, i, ioff - data_size);
+		ioff = btrfs_item_offset(leaf, i);
+		btrfs_set_item_offset(leaf, i, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -2752,8 +2752,8 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		      data_end, old_data - data_end);
 
 	data_end = old_data;
-	old_size = btrfs_item_size_nr(leaf, slot);
-	btrfs_set_item_size_nr(leaf, slot, old_size + data_size);
+	old_size = btrfs_item_size(leaf, slot);
+	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	ret = 0;
@@ -2831,8 +2831,8 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_item_offset_nr(leaf, i);
-			btrfs_set_item_offset_nr(leaf, i, ioff - total_data);
+			ioff = btrfs_item_offset(leaf, i);
+			btrfs_set_item_offset(leaf, i, ioff - total_data);
 		}
 
 		/* shift the items */
@@ -2851,9 +2851,9 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	for (i = 0; i < nr; i++) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key + i);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
-		btrfs_set_item_offset_nr(leaf, slot + i, data_end - data_size[i]);
+		btrfs_set_item_offset(leaf, slot + i, data_end - data_size[i]);
 		data_end -= data_size[i];
-		btrfs_set_item_size_nr(leaf, slot + i, data_size[i]);
+		btrfs_set_item_size(leaf, slot + i, data_size[i]);
 	}
 	btrfs_set_header_nritems(leaf, nritems + nr);
 	btrfs_mark_buffer_dirty(leaf);
@@ -2985,10 +2985,10 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	u32 nritems;
 
 	leaf = path->nodes[0];
-	last_off = btrfs_item_offset_nr(leaf, slot + nr - 1);
+	last_off = btrfs_item_offset(leaf, slot + nr - 1);
 
 	for (i = 0; i < nr; i++)
-		dsize += btrfs_item_size_nr(leaf, slot + i);
+		dsize += btrfs_item_size(leaf, slot + i);
 
 	nritems = btrfs_header_nritems(leaf);
 
@@ -3003,8 +3003,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_item_offset_nr(leaf, i);
-			btrfs_set_item_offset_nr(leaf, i, ioff + dsize);
+			ioff = btrfs_item_offset(leaf, i);
+			btrfs_set_item_offset(leaf, i, ioff + dsize);
 		}
 
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
@@ -3334,7 +3334,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, u8 *uuid,
 
 	eb = path->nodes[0];
 	slot = path->slots[0];
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	offset = btrfs_item_ptr_offset(eb, slot);
 	ret = -ENOENT;
 
@@ -3407,7 +3407,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
-		offset += btrfs_item_size_nr(eb, slot) - sizeof(subvol_id_le);
+		offset += btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
 	} else if (ret < 0) {
 		warning(
 		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index befa244f..8b654dde 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1980,8 +1980,8 @@ static inline void btrfs_set_node_key(struct extent_buffer *eb,
 }
 
 /* struct btrfs_item */
-BTRFS_SETGET_FUNCS(item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_FUNCS(item_size, struct btrfs_item, size, 32);
+BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 
 static inline unsigned long btrfs_item_nr_offset(int nr)
 {
@@ -1994,31 +1994,23 @@ static inline struct btrfs_item *btrfs_item_nr(int nr)
 	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
 }
 
-static inline void btrfs_set_item_size_nr(struct extent_buffer *eb, int nr,
-					  u32 size)
-{
-	btrfs_set_item_size(eb, btrfs_item_nr(nr), size);
+#define BTRFS_ITEM_SETGET_FUNCS(member)						\
+static inline u32 btrfs_item_##member(const struct extent_buffer *eb, int slot)	\
+{										\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
+}										\
+static inline void btrfs_set_item_##member(struct extent_buffer *eb,		\
+					   int slot, u32 val)			\
+{										\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
 }
 
-static inline void btrfs_set_item_offset_nr(struct extent_buffer *eb, int nr,
-					    u32 offset)
-{
-	btrfs_set_item_offset(eb, btrfs_item_nr(nr), offset);
-}
-
-static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_offset(eb, btrfs_item_nr(nr));
-}
-
-static inline u32 btrfs_item_size_nr(struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_size(eb, btrfs_item_nr(nr));
-}
+BTRFS_ITEM_SETGET_FUNCS(size)
+BTRFS_ITEM_SETGET_FUNCS(offset)
 
 static inline u32 btrfs_item_end(struct extent_buffer *eb, int nr)
 {
-	return btrfs_item_offset_nr(eb, nr) + btrfs_item_size_nr(eb, nr);
+	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
 }
 
 static inline void btrfs_item_key(struct extent_buffer *eb,
@@ -2560,7 +2552,7 @@ static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
 static inline u32 btrfs_file_extent_inline_item_len(struct extent_buffer *eb,
 						    int nr)
 {
-	return btrfs_item_size_nr(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
 /* struct btrfs_ioctl_search_header */
@@ -2612,11 +2604,11 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 /* helper function to cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type) \
 	((type *)(btrfs_leaf_data(leaf) + \
-	btrfs_item_offset_nr(leaf, slot)))
+	btrfs_item_offset(leaf, slot)))
 
 #define btrfs_item_ptr_offset(leaf, slot) \
 	((unsigned long)(btrfs_leaf_data(leaf) + \
-	btrfs_item_offset_nr(leaf, slot)))
+	btrfs_item_offset(leaf, slot)))
 
 u64 btrfs_name_hash(const char *name, int len);
 u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len);
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 729d4308..27dfb362 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -48,8 +48,8 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 	WARN_ON(ret > 0);
 	leaf = path->nodes[0];
 	ptr = btrfs_item_ptr(leaf, path->slots[0], char);
-	BUG_ON(data_size > btrfs_item_size_nr(leaf, path->slots[0]));
-	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - data_size;
+	BUG_ON(data_size > btrfs_item_size(leaf, path->slots[0]));
+	ptr += btrfs_item_size(leaf, path->slots[0]) - data_size;
 	return (struct btrfs_dir_item *)ptr;
 }
 
@@ -264,7 +264,7 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	sub_item_len = sizeof(*di) + btrfs_dir_name_len(leaf, di) +
 		btrfs_dir_data_len(leaf, di);
-	item_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_len = btrfs_item_size(leaf, path->slots[0]);
 
 	/*
 	 * If @sub_item_len is longer than @item_len, then it means the
@@ -329,7 +329,7 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_root *root,
 
 	leaf = path->nodes[0];
 	dir_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
-	total_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	total_len = btrfs_item_size(leaf, path->slots[0]);
 	if (verify_dir_item(root, leaf, dir_item))
 		return NULL;
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 3713452b..e36745ca 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -929,7 +929,7 @@ again:
 	BUG_ON(ret);
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (item_size < sizeof(*ei)) {
 		printf("Size is %u, needs to be %u, slot %d\n",
 		       (unsigned)item_size,
@@ -1055,7 +1055,7 @@ static int setup_inline_extent_backref(struct btrfs_root *root,
 	btrfs_set_extent_refs(leaf, ei, refs);
 
 	ptr = (unsigned long)ei + item_offset;
-	end = (unsigned long)ei + btrfs_item_size_nr(leaf, path->slots[0]);
+	end = (unsigned long)ei + btrfs_item_size(leaf, path->slots[0]);
 	if (ptr < end - size)
 		memmove_extent_buffer(leaf, ptr + size, ptr,
 				      end - size - ptr);
@@ -1159,7 +1159,7 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
 			btrfs_set_shared_data_ref_count(leaf, sref, refs);
 	} else {
 		size =  btrfs_extent_inline_ref_size(type);
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		ptr = (unsigned long)iref;
 		end = (unsigned long)ei + item_size;
 		if (ptr + size < end)
@@ -1353,7 +1353,7 @@ again:
 	}
 
 	l = path->nodes[0];
-	item_size = btrfs_item_size_nr(l, path->slots[0]);
+	item_size = btrfs_item_size(l, path->slots[0]);
 	if (item_size >= sizeof(*item)) {
 		item = btrfs_item_ptr(l, path->slots[0],
 				      struct btrfs_extent_item);
@@ -1429,7 +1429,7 @@ again:
 		BUG();
 	}
 	l = path->nodes[0];
-	item_size = btrfs_item_size_nr(l, path->slots[0]);
+	item_size = btrfs_item_size(l, path->slots[0]);
 	if (item_size < sizeof(*item)) {
 		error(
 "unsupported or corrupted extent item, item size=%u expect minimal size=%zu",
@@ -2035,7 +2035,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, extent_slot);
+	item_size = btrfs_item_size(leaf, extent_slot);
 	if (item_size < sizeof(*ei)) {
 		error(
 "unsupported or corrupted extent item, item size=%u expect minimal size=%zu",
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 0d68ed52..b0fcd49d 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -170,7 +170,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 
 		csum_offset = (bytenr - found_key.offset) /
 				root->fs_info->sectorsize;
-		csums_in_item = btrfs_item_size_nr(leaf, path->slots[0]);
+		csums_in_item = btrfs_item_size(leaf, path->slots[0]);
 		csums_in_item /= csum_size;
 
 		if (csum_offset >= csums_in_item) {
@@ -235,7 +235,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 		/* printf("item not big enough for bytenr %llu\n", bytenr); */
 		/* we found one, but it isn't big enough yet */
 		leaf = path->nodes[0];
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		if ((item_size / csum_size) >= MAX_CSUM_ITEMS(root, csum_size)) {
 			/* already at max size, make a new one */
 			goto insert;
@@ -287,10 +287,10 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	    csum_offset >= MAX_CSUM_ITEMS(root, csum_size)) {
 		goto insert;
 	}
-	if (csum_offset >= btrfs_item_size_nr(leaf, path->slots[0]) /
+	if (csum_offset >= btrfs_item_size(leaf, path->slots[0]) /
 	    csum_size) {
 		u32 diff = (csum_offset + 1) * csum_size;
-		diff = diff - btrfs_item_size_nr(leaf, path->slots[0]);
+		diff = diff - btrfs_item_size(leaf, path->slots[0]);
 		if (diff != csum_size)
 			goto insert;
 		ret = btrfs_extend_item(root, path, diff);
@@ -359,7 +359,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 	int ret;
 
 	leaf = path->nodes[0];
-	csum_end = btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
+	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
 	csum_end *= root->fs_info->sectorsize;
 	csum_end += key->offset;
 
@@ -439,7 +439,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 		if (key.offset >= end_byte)
 			break;
 
-		csum_end = btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
+		csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
 		csum_end *= blocksize;
 		csum_end += key.offset;
 
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index 7ca75f6d..891ae40a 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -32,7 +32,7 @@ static int find_name_in_backref(struct btrfs_path *path, const char * name,
 	int len;
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	while (cur_offset < item_size) {
 		ref = (struct btrfs_inode_ref *)(ptr + cur_offset);
@@ -77,7 +77,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (find_name_in_backref(path, name, name_len, &ref))
 			goto out;
 
-		old_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
+		old_size = btrfs_item_size(path->nodes[0], path->slots[0]);
 		ret = btrfs_extend_item(root, path, ins_len);
 		BUG_ON(ret);
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -197,7 +197,7 @@ static int btrfs_find_name_in_ext_backref(struct btrfs_path *path,
 
 	node = path->nodes[0];
 	slot = path->slots[0];
-	item_size = btrfs_item_size_nr(node, slot);
+	item_size = btrfs_item_size(node, slot);
 	ptr = btrfs_item_ptr_offset(node, slot);
 
 	/*
@@ -293,7 +293,7 @@ int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (index)
 		*index = btrfs_inode_extref_index(leaf, extref);
 
@@ -361,7 +361,7 @@ int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
-	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - ins_len;
+	ptr += btrfs_item_size(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
 	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
@@ -416,7 +416,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (index)
 		*index = btrfs_inode_ref_index(leaf, ref);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index aff2ebc4..717be5d5 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -440,7 +440,7 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
 	unsigned long end;
 	unsigned long ptr;
 	int type;
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	u64 flags;
 	u64 offset;
 	char flags_str[32] = {0};
@@ -571,7 +571,7 @@ static void print_root_item(struct extent_buffer *leaf, int slot)
 	struct btrfs_key drop_key;
 
 	ri = btrfs_item_ptr(leaf, slot, struct btrfs_root_item);
-	len = btrfs_item_size_nr(leaf, slot);
+	len = btrfs_item_size(leaf, slot);
 
 	memset(&root_item, 0, sizeof(root_item));
 	read_extent_buffer(leaf, &root_item, (unsigned long)ri, len);
@@ -1306,18 +1306,18 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		 * Only need to ensure all pointers are pointing range inside
 		 * the leaf, thus no segfault.
 		 */
-		if (btrfs_item_offset_nr(eb, i) > leaf_data_size ||
-		    btrfs_item_size_nr(eb, i) + btrfs_item_offset_nr(eb, i) >
+		if (btrfs_item_offset(eb, i) > leaf_data_size ||
+		    btrfs_item_size(eb, i) + btrfs_item_offset(eb, i) >
 		    leaf_data_size) {
 			error(
 "leaf %llu slot %u pointer invalid, offset %u size %u leaf data limit %u",
 			      btrfs_header_bytenr(eb), i,
-			      btrfs_item_offset_nr(eb, i),
-			      btrfs_item_size_nr(eb, i), leaf_data_size);
+			      btrfs_item_offset(eb, i),
+			      btrfs_item_size(eb, i), leaf_data_size);
 			error("skip remaining slots");
 			break;
 		}
-		item_size = btrfs_item_size_nr(eb, i);
+		item_size = btrfs_item_size(eb, i);
 		/* Untyped extraction of slot from btrfs_item_ptr */
 		ptr = btrfs_item_ptr(eb, i, void*);
 
@@ -1329,8 +1329,8 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		printf("\titem %u ", i);
 		btrfs_print_key(&disk_key);
 		printf(" itemoff %u itemsize %u\n",
-			btrfs_item_offset_nr(eb, i),
-			btrfs_item_size_nr(eb, i));
+			btrfs_item_offset(eb, i),
+			btrfs_item_size(eb, i));
 
 		if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID)
 			print_free_space_header(eb, i);
@@ -1436,7 +1436,7 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_UUID_KEY_SUBVOL:
 		case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
 			print_uuid_item(eb, btrfs_item_ptr_offset(eb, i),
-					btrfs_item_size_nr(eb, i));
+					btrfs_item_size(eb, i));
 			break;
 		case BTRFS_STRING_ITEM_KEY: {
 			const char *str = eb->data + btrfs_item_ptr_offset(eb, i);
diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
index bc410963..0f83f915 100644
--- a/kernel-shared/root-tree.c
+++ b/kernel-shared/root-tree.c
@@ -87,7 +87,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr_offset(l, slot);
-	old_len = btrfs_item_size_nr(l, slot);
+	old_len = btrfs_item_size(l, slot);
 
 	/*
 	 * If this is the first time we update the root item which originated
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index c0b3406a..6de9a178 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -154,7 +154,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	eb = path->nodes[0];
 	slot = path->slots[0];
 	offset = btrfs_item_ptr_offset(eb, slot);
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
 		warning("uuid item with illegal size %u!", item_size);
 		ret = -ENOENT;
@@ -175,7 +175,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		goto out;
 	}
 
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	if (item_size == sizeof(subid)) {
 		ret = btrfs_del_item(trans, uuid_root, path);
 		goto out;
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 4274c378..e24428db 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2103,9 +2103,9 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	 * one stripe, so no "==" check.
 	 */
 	if (slot >= 0 &&
-	    btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk)) {
+	    btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk)) {
 		error("invalid chunk item size, have %u expect [%zu, %u)",
-			btrfs_item_size_nr(leaf, slot),
+			btrfs_item_size(leaf, slot),
 			sizeof(struct btrfs_chunk),
 			BTRFS_LEAF_DATA_SIZE(fs_info));
 		return -EUCLEAN;
@@ -2122,9 +2122,9 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 		return -EUCLEAN;
 	}
 	if (slot >= 0 && btrfs_chunk_item_size(num_stripes) !=
-	    btrfs_item_size_nr(leaf, slot)) {
+	    btrfs_item_size(leaf, slot)) {
 		error("invalid chunk item size, have %u expect %lu",
-			btrfs_item_size_nr(leaf, slot),
+			btrfs_item_size(leaf, slot),
 			btrfs_chunk_item_size(num_stripes));
 		return -EUCLEAN;
 	}
@@ -2184,7 +2184,7 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	 */
 	if (num_stripes < 1 ||
 	    (slot == -1 && chunk_ondisk_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) ||
-	    (slot >= 0 && chunk_ondisk_size > btrfs_item_size_nr(leaf, slot))) {
+	    (slot >= 0 && chunk_ondisk_size > btrfs_item_size(leaf, slot))) {
 		error("invalid num_stripes: %u", num_stripes);
 		return -EIO;
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index 0ea0d114..11d92c8b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -104,8 +104,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 		btrfs_set_disk_key_objectid(&disk_key,
 			reference_root_table[blk]);
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset_nr(buf, nritems, itemoff);
-		btrfs_set_item_size_nr(buf, nritems, sizeof(root_item));
+		btrfs_set_item_offset(buf, nritems, itemoff);
+		btrfs_set_item_size(buf, nritems, sizeof(root_item));
 		if (blk == MKFS_FS_TREE) {
 			time_t now = time(NULL);
 
@@ -159,8 +159,8 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_disk_key_offset(&disk_key, group_size);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_INFO_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset_nr(buf, nritems, itemoff);
-	btrfs_set_item_size_nr(buf, nritems, sizeof(*info));
+	btrfs_set_item_offset(buf, nritems, itemoff);
+	btrfs_set_item_size(buf, nritems, sizeof(*info));
 
 	info = btrfs_item_ptr(buf, nritems, struct btrfs_free_space_info);
 	btrfs_set_free_space_extent_count(buf, info, 1);
@@ -171,8 +171,8 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_disk_key_offset(&disk_key, group_start + group_size - free_start);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset_nr(buf, nritems, itemoff);
-	btrfs_set_item_size_nr(buf, nritems, 0);
+	btrfs_set_item_offset(buf, nritems, itemoff);
+	btrfs_set_item_size(buf, nritems, 0);
 
 	nritems++;
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FREE_SPACE_TREE]);
@@ -340,8 +340,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			btrfs_set_disk_key_offset(&disk_key, system_group_size);
 			btrfs_set_disk_key_type(&disk_key, BTRFS_BLOCK_GROUP_ITEM_KEY);
 			btrfs_set_item_key(buf, &disk_key, nritems);
-			btrfs_set_item_offset_nr(buf, nritems, itemoff);
-			btrfs_set_item_size_nr(buf, nritems, sizeof(*bg_item));
+			btrfs_set_item_offset(buf, nritems, itemoff);
+			btrfs_set_item_size(buf, nritems, sizeof(*bg_item));
 
 			bg_item = btrfs_item_ptr(buf, nritems,
 						 struct btrfs_block_group_item);
@@ -386,8 +386,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			btrfs_set_disk_key_offset(&disk_key, cfg->nodesize);
 		}
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset_nr(buf, nritems, itemoff);
-		btrfs_set_item_size_nr(buf, nritems, item_size);
+		btrfs_set_item_offset(buf, nritems, itemoff);
+		btrfs_set_item_size(buf, nritems, item_size);
 		extent_item = btrfs_item_ptr(buf, nritems,
 					     struct btrfs_extent_item);
 		btrfs_set_extent_refs(buf, extent_item, 1);
@@ -402,8 +402,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_disk_key_offset(&disk_key, ref_root);
 		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
 		btrfs_set_item_key(buf, &disk_key, nritems);
-		btrfs_set_item_offset_nr(buf, nritems, itemoff);
-		btrfs_set_item_size_nr(buf, nritems, 0);
+		btrfs_set_item_offset(buf, nritems, itemoff);
+		btrfs_set_item_size(buf, nritems, 0);
 		nritems++;
 	}
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
@@ -430,8 +430,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, 1);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset_nr(buf, nritems, itemoff);
-	btrfs_set_item_size_nr(buf, nritems, item_size);
+	btrfs_set_item_offset(buf, nritems, itemoff);
+	btrfs_set_item_size(buf, nritems, item_size);
 
 	dev_item = btrfs_item_ptr(buf, nritems, struct btrfs_dev_item);
 	btrfs_set_device_id(buf, dev_item, 1);
@@ -461,8 +461,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_CHUNK_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset_nr(buf, nritems, itemoff);
-	btrfs_set_item_size_nr(buf, nritems, item_size);
+	btrfs_set_item_offset(buf, nritems, itemoff);
+	btrfs_set_item_size(buf, nritems, item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
 	btrfs_set_chunk_length(buf, chunk, system_group_size);
@@ -517,8 +517,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
-	btrfs_set_item_offset_nr(buf, nritems, itemoff);
-	btrfs_set_item_size_nr(buf, nritems, sizeof(struct btrfs_dev_extent));
+	btrfs_set_item_offset(buf, nritems, itemoff);
+	btrfs_set_item_size(buf, nritems, sizeof(struct btrfs_dev_extent));
 	dev_extent = btrfs_item_ptr(buf, nritems, struct btrfs_dev_extent);
 	btrfs_set_dev_extent_chunk_tree(buf, dev_extent,
 					BTRFS_CHUNK_TREE_OBJECTID);
-- 
2.26.3

