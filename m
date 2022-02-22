Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC34C0497
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiBVW1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiBVW1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:11 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C328E34
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f21so1811648qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4nTG3Ay0j0spW8TQ5AFMUYyjIXQWQqaI1siQeX8CDL4=;
        b=memKFjThRYOSTr2gzsiW+sntvYYlIZeR82xiWeP5CHC2oF+294wg+wo1zzr230ec0G
         630M06RvH4eF8xLouBYXvhOemehatWdDjSnyZ4HSYXzwT0HG/tzMN9CRVsImgYpeNEWp
         K4Bl9wNHOAk7leKCpTJusPxE/cM316wzHoPqam7S2izzZJmkRl0DrnY8HB+W3YvwzpBK
         AeadzN1X29VM5T+1F8+5UmrZI0u3lKF8A9kCw5jtLyQVZc0RLdHBGKD8PY6pXvphGLsT
         7n6fFDWJbgIdtz4lJ1l+kzWAVDcBlhV8DvofGukdR48icdaZdhwsQrRu0C8UPxuz5kUp
         bLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nTG3Ay0j0spW8TQ5AFMUYyjIXQWQqaI1siQeX8CDL4=;
        b=te3L1GdYLtjrzxV1kWF7x3pdNRW21v1PyavhehNHR2+MF9dFyRd1KTqgVtKkiqj3hR
         VLi6g8VMhf76hY9aL7xB+OOhS0nUtXYPT6A+rHSjaGZTZQq4B62vSADt4GNSlf/E0OHu
         fJ/Cebmhrhb4JGvRoUAC7oCer7PoRuSPQMi2QX8k18BZ76hkFLQ3fh0xySV0UXGfmIjq
         6MyE7MqEJ9zXyZafq9ncAqSkVtW6AOu0Asx1nKr4M9ipDBw4A/1PcVxpt49dDzTYiwjL
         9rZ4lWgzAhkMj4zbX8kBhQRJnPcHYOCoo4uE9gcysWL46FK4KUEebKa7IRQWz655RX1+
         tFSA==
X-Gm-Message-State: AOAM530bM7lU61STA5Dk8nYTO95Kvc0quHlUfvxVbXU5/i4v6lOiImPl
        JaOND6jscnW/c1yCyLQgB3yjKFK7LoGQRA37
X-Google-Smtp-Source: ABdhPJwUd2jbtr9YjdiFExH7rwuZLpymjGDAQqD/j7VrF2JoyjtsSkIyViXu0YF4xWHIDJdMb02EiA==
X-Received: by 2002:a37:45d3:0:b0:47a:645e:137f with SMTP id s202-20020a3745d3000000b0047a645e137fmr16880335qka.535.1645568803285;
        Tue, 22 Feb 2022 14:26:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f16sm799485qtk.8.2022.02.22.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/13] btrfs-progs: make all of the item/key_ptr offset helpers take an eb
Date:   Tue, 22 Feb 2022 17:26:23 -0500
Message-Id: <ee29be722cf17a5dd2a977ba97ea28f245eb0e57.1645568701.git.josef@toxicpanda.com>
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

When we change the size of the btrfs_header we're going to need to
change how these helpers calculate where to find the start of items or
block ptrs.  To prepare for that make these helpers take the
extent_buffer as an argument so we can do the appropriate math based on
the version type.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 13 ++++++-----
 image/main.c          |  4 ++--
 kernel-shared/ctree.c | 54 +++++++++++++++++++++----------------------
 kernel-shared/ctree.h | 36 ++++++++++++++---------------
 4 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/check/main.c b/check/main.c
index ed3fde60..39cb1ce5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4192,16 +4192,17 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 	if (btrfs_header_level(buf)) {
 		struct btrfs_key_ptr ptr1, ptr2;
 
-		read_extent_buffer(buf, &ptr1, btrfs_node_key_ptr_offset(slot),
+		read_extent_buffer(buf, &ptr1,
+				   btrfs_node_key_ptr_offset(buf, slot),
 				   sizeof(struct btrfs_key_ptr));
 		read_extent_buffer(buf, &ptr2,
-				   btrfs_node_key_ptr_offset(slot + 1),
+				   btrfs_node_key_ptr_offset(buf, slot + 1),
 				   sizeof(struct btrfs_key_ptr));
 		write_extent_buffer(buf, &ptr1,
-				    btrfs_node_key_ptr_offset(slot + 1),
+				    btrfs_node_key_ptr_offset(buf, slot + 1),
 				    sizeof(struct btrfs_key_ptr));
 		write_extent_buffer(buf, &ptr2,
-				    btrfs_node_key_ptr_offset(slot),
+				    btrfs_node_key_ptr_offset(buf, slot),
 				    sizeof(struct btrfs_key_ptr));
 		if (slot == 0) {
 			struct btrfs_disk_key key;
@@ -4299,8 +4300,8 @@ static int delete_bogus_item(struct btrfs_root *root,
 	printf("Deleting bogus item [%llu,%u,%llu] at slot %d on block %llu\n",
 	       (unsigned long long)key.objectid, key.type,
 	       (unsigned long long)key.offset, slot, buf->start);
-	memmove_extent_buffer(buf, btrfs_item_nr_offset(slot),
-			      btrfs_item_nr_offset(slot + 1),
+	memmove_extent_buffer(buf, btrfs_item_nr_offset(buf, slot),
+			      btrfs_item_nr_offset(buf, slot + 1),
 			      sizeof(struct btrfs_item) *
 			      (nritems - slot - 1));
 	btrfs_set_header_nritems(buf, nritems - 1);
diff --git a/image/main.c b/image/main.c
index ff121fca..c6af0cc2 100644
--- a/image/main.c
+++ b/image/main.c
@@ -360,8 +360,8 @@ static void copy_buffer(struct metadump_struct *md, u8 *dst,
 	} else if (level == 0) {
 		size = btrfs_leaf_data(src) +
 			btrfs_item_offset(src, nritems - 1) -
-			btrfs_item_nr_offset(nritems);
-		memset(dst + btrfs_item_nr_offset(nritems), 0, size);
+			btrfs_item_nr_offset(src, nritems);
+		memset(dst + btrfs_item_nr_offset(src, nritems), 0, size);
 		zero_items(md, dst, src);
 	} else {
 		size = offsetof(struct btrfs_node, ptrs) +
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index e164492b..758a3882 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -756,10 +756,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
 
 		/* Also check if the item pointer overlaps with btrfs item. */
 		if (btrfs_item_ptr_offset(leaf, slot) <
-		    btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item)) {
+		    btrfs_item_nr_offset(leaf, slot) + sizeof(struct btrfs_item)) {
 			generic_err(leaf, slot,
 		"slot overlaps with its data, item end %lu data start %lu",
-				btrfs_item_nr_offset(slot) +
+				btrfs_item_nr_offset(leaf, slot) +
 				sizeof(struct btrfs_item),
 				btrfs_item_ptr_offset(leaf, slot));
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
@@ -1638,13 +1638,13 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 		push_items = min(src_nritems - 8, push_items);
 
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(dst_nritems),
-			   btrfs_node_key_ptr_offset(0),
+			   btrfs_node_key_ptr_offset(dst, dst_nritems),
+			   btrfs_node_key_ptr_offset(src, 0),
 		           push_items * sizeof(struct btrfs_key_ptr));
 
 	if (push_items < src_nritems) {
-		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(0),
-				      btrfs_node_key_ptr_offset(push_items),
+		memmove_extent_buffer(src, btrfs_node_key_ptr_offset(src, 0),
+				      btrfs_node_key_ptr_offset(src, push_items),
 				      (src_nritems - push_items) *
 				      sizeof(struct btrfs_key_ptr));
 	}
@@ -1699,14 +1699,14 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 	if (max_push < push_items)
 		push_items = max_push;
 
-	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
-				      btrfs_node_key_ptr_offset(0),
+	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(dst, push_items),
+				      btrfs_node_key_ptr_offset(dst, 0),
 				      (dst_nritems) *
 				      sizeof(struct btrfs_key_ptr));
 
 	copy_extent_buffer(dst, src,
-			   btrfs_node_key_ptr_offset(0),
-			   btrfs_node_key_ptr_offset(src_nritems - push_items),
+			   btrfs_node_key_ptr_offset(dst, 0),
+			   btrfs_node_key_ptr_offset(src, src_nritems - push_items),
 		           push_items * sizeof(struct btrfs_key_ptr));
 
 	btrfs_set_header_nritems(src, src_nritems - push_items);
@@ -1816,8 +1816,8 @@ static int insert_ptr(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (slot < nritems) {
 		/* shift the items */
 		memmove_extent_buffer(lower,
-			      btrfs_node_key_ptr_offset(slot + 1),
-			      btrfs_node_key_ptr_offset(slot),
+			      btrfs_node_key_ptr_offset(lower, slot + 1),
+			      btrfs_node_key_ptr_offset(lower, slot),
 			      (nritems - slot) * sizeof(struct btrfs_key_ptr));
 	}
 	btrfs_set_node_key(lower, key, slot);
@@ -1891,8 +1891,8 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 	root_add_used(root, root->fs_info->nodesize);
 
 	copy_extent_buffer(split, c,
-			   btrfs_node_key_ptr_offset(0),
-			   btrfs_node_key_ptr_offset(mid),
+			   btrfs_node_key_ptr_offset(split, 0),
+			   btrfs_node_key_ptr_offset(c, mid),
 			   (c_nritems - mid) * sizeof(struct btrfs_key_ptr));
 	btrfs_set_header_nritems(split, c_nritems - mid);
 	btrfs_set_header_nritems(c, mid);
@@ -2074,13 +2074,13 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		     BTRFS_LEAF_DATA_SIZE(root->fs_info) - push_space,
 		     btrfs_leaf_data(left) + leaf_data_end(left), push_space);
 
-	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
+	memmove_extent_buffer(right, btrfs_item_nr_offset(right, push_items),
 			      btrfs_leaf_data(right),
 			      right_nritems * sizeof(struct btrfs_item));
 
 	/* copy the items from left to right */
 	copy_extent_buffer(right, left, btrfs_leaf_data(right),
-		   btrfs_item_nr_offset(left_nritems - push_items),
+		   btrfs_item_nr_offset(left, left_nritems - push_items),
 		   push_items * sizeof(struct btrfs_item));
 
 	/* update the item pointers */
@@ -2197,7 +2197,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* push data from right to left */
 	copy_extent_buffer(left, right,
-			   btrfs_item_nr_offset(btrfs_header_nritems(left)),
+			   btrfs_item_nr_offset(left, btrfs_header_nritems(left)),
 			   btrfs_leaf_data(right),
 			   push_items * sizeof(struct btrfs_item));
 
@@ -2239,7 +2239,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 				      leaf_data_end(right), push_space);
 
 		memmove_extent_buffer(right, btrfs_leaf_data(right),
-			      btrfs_item_nr_offset(push_items),
+			      btrfs_item_nr_offset(right, push_items),
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
 	}
@@ -2297,7 +2297,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 	data_copy_size = btrfs_item_end(l, mid) - leaf_data_end(l);
 
 	copy_extent_buffer(right, l, btrfs_leaf_data(right),
-			   btrfs_item_nr_offset(mid),
+			   btrfs_item_nr_offset(l, mid),
 			   nritems * sizeof(struct btrfs_item));
 
 	copy_extent_buffer(right, l,
@@ -2576,8 +2576,8 @@ split:
 
 	if (slot < nritems) {
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + 1),
-			      btrfs_item_nr_offset(slot),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + 1),
+			      btrfs_item_nr_offset(leaf, slot),
 			      (nritems - slot) * sizeof(struct btrfs_item));
 
 	}
@@ -2836,8 +2836,8 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 		}
 
 		/* shift the items */
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot + nr),
-			      btrfs_item_nr_offset(slot),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot + nr),
+			      btrfs_item_nr_offset(leaf, slot),
 			      (nritems - slot) * sizeof(struct btrfs_item));
 
 		/* shift the data */
@@ -2919,8 +2919,8 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 	if (slot < nritems - 1) {
 		/* shift the items */
 		memmove_extent_buffer(parent,
-			      btrfs_node_key_ptr_offset(slot),
-			      btrfs_node_key_ptr_offset(slot + 1),
+			      btrfs_node_key_ptr_offset(parent, slot),
+			      btrfs_node_key_ptr_offset(parent, slot + 1),
 			      sizeof(struct btrfs_key_ptr) *
 			      (nritems - slot - 1));
 	}
@@ -3007,8 +3007,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			btrfs_set_item_offset(leaf, i, ioff + dsize);
 		}
 
-		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
-			      btrfs_item_nr_offset(slot + nr),
+		memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, slot),
+			      btrfs_item_nr_offset(leaf, slot + nr),
 			      sizeof(struct btrfs_item) *
 			      (nritems - slot - nr));
 	}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 464a0f74..addfafc7 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1921,77 +1921,77 @@ BTRFS_SETGET_FUNCS(ref_count_v0, struct btrfs_extent_ref_v0, count, 32);
 BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
 BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
 
-static inline unsigned long btrfs_node_key_ptr_offset(int nr)
+static inline unsigned long btrfs_node_key_ptr_offset(const struct extent_buffer *eb, int nr)
 {
 	return offsetof(struct btrfs_node, ptrs) +
 		sizeof(struct btrfs_key_ptr) * nr;
 }
 
-static inline struct btrfs_key_ptr *btrfs_node_key_ptr(int nr)
+static inline struct btrfs_key_ptr *btrfs_node_key_ptr(const struct extent_buffer *eb, int nr)
 {
-	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(nr);
+	return (struct btrfs_key_ptr *)btrfs_node_key_ptr_offset(eb, nr);
 }
 
 static inline u64 btrfs_node_blockptr(struct extent_buffer *eb, int nr)
 {
-	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(nr));
+	return btrfs_key_blockptr(eb, btrfs_node_key_ptr(eb, nr));
 }
 
 static inline void btrfs_set_node_blockptr(struct extent_buffer *eb,
 					   int nr, u64 val)
 {
-	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(nr), val);
+	btrfs_set_key_blockptr(eb, btrfs_node_key_ptr(eb, nr), val);
 }
 
 static inline u64 btrfs_node_ptr_generation(struct extent_buffer *eb, int nr)
 {
-	return btrfs_key_generation(eb, btrfs_node_key_ptr(nr));
+	return btrfs_key_generation(eb, btrfs_node_key_ptr(eb, nr));
 }
 
 static inline void btrfs_set_node_ptr_generation(struct extent_buffer *eb,
 						 int nr, u64 val)
 {
-	btrfs_set_key_generation(eb, btrfs_node_key_ptr(nr), val);
+	btrfs_set_key_generation(eb, btrfs_node_key_ptr(eb, nr), val);
 }
 
 static inline void btrfs_node_key(struct extent_buffer *eb,
 				  struct btrfs_disk_key *disk_key, int nr)
 {
-	read_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
-		       disk_key);
+	read_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr,
+		       key, disk_key);
 }
 
 static inline void btrfs_set_node_key(struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
 {
-	write_eb_member(eb, btrfs_node_key_ptr(nr), struct btrfs_key_ptr, key,
-			disk_key);
+	write_eb_member(eb, btrfs_node_key_ptr(eb, nr), struct btrfs_key_ptr,
+			key, disk_key);
 }
 
 /* struct btrfs_item */
 BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
 BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 
-static inline unsigned long btrfs_item_nr_offset(int nr)
+static inline unsigned long btrfs_item_nr_offset(const struct extent_buffer *eb, int nr)
 {
 	return offsetof(struct btrfs_leaf, items) +
 		sizeof(struct btrfs_item) * nr;
 }
 
-static inline struct btrfs_item *btrfs_item_nr(int nr)
+static inline struct btrfs_item *btrfs_item_nr(const struct extent_buffer *eb, int nr)
 {
-	return (struct btrfs_item *)btrfs_item_nr_offset(nr);
+	return (struct btrfs_item *)btrfs_item_nr_offset(eb, nr);
 }
 
 #define BTRFS_ITEM_SETGET_FUNCS(member)						\
 static inline u32 btrfs_item_##member(const struct extent_buffer *eb, int slot)	\
 {										\
-	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(eb, slot));		\
 }										\
 static inline void btrfs_set_item_##member(struct extent_buffer *eb,		\
 					   int slot, u32 val)			\
 {										\
-	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
 }
 
 BTRFS_ITEM_SETGET_FUNCS(size)
@@ -2005,14 +2005,14 @@ static inline u32 btrfs_item_end(struct extent_buffer *eb, int nr)
 static inline void btrfs_item_key(struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 	read_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
 
 static inline void btrfs_set_item_key(struct extent_buffer *eb,
 			       struct btrfs_disk_key *disk_key, int nr)
 {
-	struct btrfs_item *item = btrfs_item_nr(nr);
+	struct btrfs_item *item = btrfs_item_nr(eb, nr);
 	write_eb_member(eb, item, struct btrfs_item, key, disk_key);
 }
 
-- 
2.26.3

