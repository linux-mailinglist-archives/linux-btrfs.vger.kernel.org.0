Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1642A436AFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJUTBF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhJUTBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:01:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C37C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w8so1438884qts.4
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kAkRmpj1RGwOAo3iy1904meAMSi6cqgQIBkTg0TGVnI=;
        b=pCa/UGYGbof7wpIui5VuiD84AyZi++4/3kkm8u6zws9yYVp6AJtFlvL26QTHOnv5kx
         60SJD1RLiqpfVvTNm5ue1c1ODFcr6K+/c8/mcF1CvM/6+EJ9ooUONOlCIK1YNSGfeCB5
         uu6TJ1fANyKZl0SO2+3W8BMp9xoUNjMkHk0uR8XOOwVh4ouy5YkaEmNvTPBaco0vbxw1
         PwweKjh52AyIn/yfS7y3e+Spj3lyZ4I+hv+n9ODE4vDpE2DTDgWcudGj9oMgC4otcrhp
         i0J4+6WI23y6y6vZ9EMiAq4/+1nDLum1umV0WC5eniEqn+K+z8wYSziNEsWR9+YSrnRo
         NhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAkRmpj1RGwOAo3iy1904meAMSi6cqgQIBkTg0TGVnI=;
        b=F7QQKCCmIMLFhNVdkBigQurLL/+t1KzNBguoo5rHP7V9CYTZA1+KAOe7OlmtKkDApt
         4wn8QqgUuWnLBDsbEeeHRhkT/yevyMbdwJEqdprXugY2LrDrCrK0NtfY5jKAJxiFO54p
         87Uz2l7pEGDDne8CykV7wMxmvbvV6Q0c7vgpSEklC8H23gbVbPNY7caDZS6vo10UPhS1
         kpBeOCQQXddCzizbqkGu/3f74MNB/oxOUp1a4LqUzz/rgMxfAL6tuk98VNHUosuw0kh5
         SgOupxzKMOdTDL2vEGbzkaw0ToeVg7Ha1M+CR1gIkmrWtTI8VEcWWjYRiNSnZhT/TyuQ
         4FFQ==
X-Gm-Message-State: AOAM5312/Q5aX3aNqR90T0bExZLZgfNI8qGhPdS3Rd+NelejpPGIUNc9
        f8/xio1lX9Ge0x/FtKdcS17AfAynncl9ZA==
X-Google-Smtp-Source: ABdhPJxeq6td+qqdVyBVF7chxMi2Ld6roBpAXXeIcg2AiRRkmvabtK2iCW2NVGwrVXUQwvGaQLc6dA==
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr8118562qta.29.1634842725621;
        Thu, 21 Oct 2021 11:58:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m66sm2878027qkb.87.2021.10.21.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: drop the _nr from the item helpers
Date:   Thu, 21 Oct 2021 14:58:35 -0400
Message-Id: <952eaed35ba9b557c85a7117b47a9cd83e874c04.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all call sites are using the slot number to modify item values,
rename the SETGET helpers to raw_item_*(), and then rework the _nr()
helpers to be the btrfs_item_*() btrfs_set_item_*() helpers, and then
rename all of the callers to the new helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c                   | 14 ++---
 fs/btrfs/ctree.c                     | 90 ++++++++++++++--------------
 fs/btrfs/ctree.h                     | 89 ++++++++++-----------------
 fs/btrfs/dev-replace.c               |  4 +-
 fs/btrfs/dir-item.c                  | 10 ++--
 fs/btrfs/extent-tree.c               | 14 ++---
 fs/btrfs/file-item.c                 | 24 ++++----
 fs/btrfs/inode-item.c                | 12 ++--
 fs/btrfs/ioctl.c                     |  6 +-
 fs/btrfs/print-tree.c                |  6 +-
 fs/btrfs/props.c                     |  2 +-
 fs/btrfs/ref-verify.c                |  2 +-
 fs/btrfs/reflink.c                   |  2 +-
 fs/btrfs/relocation.c                |  2 +-
 fs/btrfs/root-tree.c                 |  4 +-
 fs/btrfs/scrub.c                     |  2 +-
 fs/btrfs/send.c                      | 14 ++---
 fs/btrfs/tests/extent-buffer-tests.c | 10 ++--
 fs/btrfs/tree-checker.c              | 48 +++++++--------
 fs/btrfs/tree-log.c                  | 34 +++++------
 fs/btrfs/uuid-tree.c                 | 10 ++--
 fs/btrfs/verity.c                    |  2 +-
 fs/btrfs/volumes.c                   |  6 +-
 fs/btrfs/xattr.c                     |  6 +-
 24 files changed, 195 insertions(+), 218 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 8066b524916c..c4e0560d4c11 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -950,7 +950,7 @@ static int add_inline_refs(const struct btrfs_fs_info *fs_info,
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
-	item_size = btrfs_item_size_nr(leaf, slot);
+	item_size = btrfs_item_size(leaf, slot);
 	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
@@ -1779,7 +1779,7 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	}
 
 	eb = path->nodes[0];
-	item_size = btrfs_item_size_nr(eb, path->slots[0]);
+	item_size = btrfs_item_size(eb, path->slots[0]);
 	BUG_ON(item_size < sizeof(*ei));
 
 	ei = btrfs_item_ptr(eb, path->slots[0], struct btrfs_extent_item);
@@ -2085,7 +2085,7 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 
 		iref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
 
-		for (cur = 0; cur < btrfs_item_size_nr(eb, slot); cur += len) {
+		for (cur = 0; cur < btrfs_item_size(eb, slot); cur += len) {
 			name_len = btrfs_inode_ref_name_len(eb, iref);
 			/* path must be released before calling iterate()! */
 			btrfs_debug(fs_root->fs_info,
@@ -2141,7 +2141,7 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
 		}
 		btrfs_release_path(path);
 
-		item_size = btrfs_item_size_nr(eb, slot);
+		item_size = btrfs_item_size(eb, slot);
 		ptr = btrfs_item_ptr_offset(eb, slot);
 		cur_offset = 0;
 
@@ -2362,7 +2362,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 	iter->item_ptr = (u32)btrfs_item_ptr_offset(path->nodes[0],
 						    path->slots[0]);
 	iter->end_ptr = (u32)(iter->item_ptr +
-			btrfs_item_size_nr(path->nodes[0], path->slots[0]));
+			btrfs_item_size(path->nodes[0], path->slots[0]));
 	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_extent_item);
 
@@ -2402,7 +2402,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
 		iter->cur_ptr = (u32)btrfs_item_ptr_offset(path->nodes[0],
 							   path->slots[0]);
 		iter->item_ptr = iter->cur_ptr;
-		iter->end_ptr = (u32)(iter->item_ptr + btrfs_item_size_nr(
+		iter->end_ptr = (u32)(iter->item_ptr + btrfs_item_size(
 				      path->nodes[0], path->slots[0]));
 	}
 
@@ -2467,7 +2467,7 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 	iter->item_ptr = (u32)btrfs_item_ptr_offset(path->nodes[0],
 					path->slots[0]);
 	iter->cur_ptr = iter->item_ptr;
-	iter->end_ptr = iter->item_ptr + (u32)btrfs_item_size_nr(path->nodes[0],
+	iter->end_ptr = iter->item_ptr + (u32)btrfs_item_size(path->nodes[0],
 						path->slots[0]);
 	return 0;
 }
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 500aac8a95c9..b2b12d80ab86 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2620,9 +2620,9 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 
 	if (!nr)
 		return 0;
-	data_len = btrfs_item_offset_nr(l, start) +
-		   btrfs_item_size_nr(l, start);
-	data_len = data_len - btrfs_item_offset_nr(l, end);
+	data_len = btrfs_item_offset(l, start) +
+		   btrfs_item_size(l, start);
+	data_len = data_len - btrfs_item_offset(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
 	return data_len;
@@ -2699,7 +2699,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 		if (path->slots[0] == i)
 			push_space += data_size;
 
-		this_item_size = btrfs_item_size_nr(left, i);
+		this_item_size = btrfs_item_size(left, i);
 		if (this_item_size + sizeof(struct btrfs_item) +
 		    push_space > free_space)
 			break;
@@ -2750,8 +2750,8 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space -= btrfs_token_item_size_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i, push_space);
+		push_space -= btrfs_token_item_size(&token, i);
+		btrfs_set_token_item_offset(&token, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -2923,7 +2923,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 		if (path->slots[0] == i)
 			push_space += data_size;
 
-		this_item_size = btrfs_item_size_nr(right, i);
+		this_item_size = btrfs_item_size(right, i);
 		if (this_item_size + sizeof(struct btrfs_item) + push_space >
 		    free_space)
 			break;
@@ -2945,23 +2945,23 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info) -
-		     btrfs_item_offset_nr(right, push_items - 1);
+		     btrfs_item_offset(right, push_items - 1);
 
 	copy_extent_buffer(left, right, BTRFS_LEAF_DATA_OFFSET +
 		     leaf_data_end(left) - push_space,
 		     BTRFS_LEAF_DATA_OFFSET +
-		     btrfs_item_offset_nr(right, push_items - 1),
+		     btrfs_item_offset(right, push_items - 1),
 		     push_space);
 	old_left_nritems = btrfs_header_nritems(left);
 	BUG_ON(old_left_nritems <= 0);
 
 	btrfs_init_map_token(&token, left);
-	old_left_item_size = btrfs_item_offset_nr(left, old_left_nritems - 1);
+	old_left_item_size = btrfs_item_offset(left, old_left_nritems - 1);
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i,
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size));
 	}
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
@@ -2972,7 +2972,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 		       right_nritems);
 
 	if (push_items < right_nritems) {
-		push_space = btrfs_item_offset_nr(right, push_items - 1) -
+		push_space = btrfs_item_offset(right, push_items - 1) -
 						  leaf_data_end(right);
 		memmove_extent_buffer(right, BTRFS_LEAF_DATA_OFFSET +
 				      BTRFS_LEAF_DATA_SIZE(fs_info) - push_space,
@@ -2990,8 +2990,8 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space = push_space - btrfs_token_item_size_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i, push_space);
+		push_space = push_space - btrfs_token_item_size(&token, i);
+		btrfs_set_token_item_offset(&token, i, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(left);
@@ -3136,8 +3136,8 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 	for (i = 0; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i, ioff + rt_data_off);
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -3253,7 +3253,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 
 	l = path->nodes[0];
 	slot = path->slots[0];
-	if (extend && data_size + btrfs_item_size_nr(l, slot) +
+	if (extend && data_size + btrfs_item_size(l, slot) +
 	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
 		return -EOVERFLOW;
 
@@ -3422,7 +3422,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
 		return 0;
 
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (key.type == BTRFS_EXTENT_DATA_KEY) {
 		fi = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_file_extent_item);
@@ -3442,7 +3442,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	ret = -EAGAIN;
 	leaf = path->nodes[0];
 	/* if our item isn't there, return now */
-	if (item_size != btrfs_item_size_nr(leaf, path->slots[0]))
+	if (item_size != btrfs_item_size(leaf, path->slots[0]))
 		goto err;
 
 	/* the leaf has  changed, it now has room.  return now */
@@ -3484,8 +3484,8 @@ static noinline int split_item(struct btrfs_path *path,
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
 	orig_slot = path->slots[0];
-	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	buf = kmalloc(item_size, GFP_NOFS);
 	if (!buf)
@@ -3506,12 +3506,12 @@ static noinline int split_item(struct btrfs_path *path,
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
 	btrfs_set_item_key(leaf, &disk_key, slot);
 
-	btrfs_set_item_offset_nr(leaf, slot, orig_offset);
-	btrfs_set_item_size_nr(leaf, slot, item_size - split_offset);
+	btrfs_set_item_offset(leaf, slot, orig_offset);
+	btrfs_set_item_size(leaf, slot, item_size - split_offset);
 
-	btrfs_set_item_offset_nr(leaf, orig_slot,
+	btrfs_set_item_offset(leaf, orig_slot,
 				 orig_offset + item_size - split_offset);
-	btrfs_set_item_size_nr(leaf, orig_slot, split_offset);
+	btrfs_set_item_size(leaf, orig_slot, split_offset);
 
 	btrfs_set_header_nritems(leaf, nritems + 1);
 
@@ -3583,14 +3583,14 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 
-	old_size = btrfs_item_size_nr(leaf, slot);
+	old_size = btrfs_item_size(leaf, slot);
 	if (old_size == new_size)
 		return;
 
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
 
-	old_data_start = btrfs_item_offset_nr(leaf, slot);
+	old_data_start = btrfs_item_offset(leaf, slot);
 
 	size_diff = old_size - new_size;
 
@@ -3605,8 +3605,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i, ioff + size_diff);
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -3649,7 +3649,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			fixup_low_keys(path, &disk_key, 1);
 	}
 
-	btrfs_set_item_size_nr(leaf, slot, new_size);
+	btrfs_set_item_size(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -3700,8 +3700,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset_nr(&token, i);
-		btrfs_set_token_item_offset_nr(&token, i, ioff - data_size);
+		ioff = btrfs_token_item_offset(&token, i);
+		btrfs_set_token_item_offset(&token, i, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -3710,8 +3710,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 		      data_end, old_data - data_end);
 
 	data_end = old_data;
-	old_size = btrfs_item_size_nr(leaf, slot);
-	btrfs_set_item_size_nr(leaf, slot, old_size + data_size);
+	old_size = btrfs_item_size(leaf, slot);
+	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -3785,8 +3785,8 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_token_item_offset_nr(&token, i);
-			btrfs_set_token_item_offset_nr(&token, i,
+			ioff = btrfs_token_item_offset(&token, i);
+			btrfs_set_token_item_offset(&token, i,
 						       ioff - batch->total_data_size);
 		}
 		/* shift the items */
@@ -3807,9 +3807,9 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[i]);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
 		data_end -= batch->data_sizes[i];
-		btrfs_set_token_item_offset_nr(&token, slot + i, data_end);
-		btrfs_set_token_item_size_nr(&token, slot + i,
-					     batch->data_sizes[i]);
+		btrfs_set_token_item_offset(&token, slot + i, data_end);
+		btrfs_set_token_item_size(&token, slot + i,
+					  batch->data_sizes[i]);
 	}
 
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
@@ -3916,7 +3916,7 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
 	u32 item_size;
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ret = setup_leaf_for_split(trans, root, path,
 				   item_size + sizeof(struct btrfs_item));
 	if (ret)
@@ -4025,10 +4025,10 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	u32 nritems;
 
 	leaf = path->nodes[0];
-	last_off = btrfs_item_offset_nr(leaf, slot + nr - 1);
+	last_off = btrfs_item_offset(leaf, slot + nr - 1);
 
 	for (i = 0; i < nr; i++)
-		dsize += btrfs_item_size_nr(leaf, slot + i);
+		dsize += btrfs_item_size(leaf, slot + i);
 
 	nritems = btrfs_header_nritems(leaf);
 
@@ -4045,8 +4045,8 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_token_item_offset_nr(&token, i);
-			btrfs_set_token_item_offset_nr(&token, i, ioff + dsize);
+			ioff = btrfs_token_item_offset(&token, i);
+			btrfs_set_token_item_offset(&token, i, ioff + dsize);
 		}
 
 		memmove_extent_buffer(leaf, btrfs_item_nr_offset(slot),
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5201341d35a6..dee251a92ae4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1953,8 +1953,8 @@ static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 }
 
 /* struct btrfs_item */
-BTRFS_SETGET_FUNCS(item_offset, struct btrfs_item, offset, 32);
-BTRFS_SETGET_FUNCS(item_size, struct btrfs_item, size, 32);
+BTRFS_SETGET_FUNCS(raw_item_offset, struct btrfs_item, offset, 32);
+BTRFS_SETGET_FUNCS(raw_item_size, struct btrfs_item, size, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_offset, struct btrfs_item, offset, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_item_size, struct btrfs_item, size, 32);
 
@@ -1972,7 +1972,7 @@ static inline struct btrfs_item *btrfs_item_nr(int nr)
 static inline u32 btrfs_item_end(const struct extent_buffer *eb,
 				 struct btrfs_item *item)
 {
-	return btrfs_item_offset(eb, item) + btrfs_item_size(eb, item);
+	return btrfs_raw_item_offset(eb, item) + btrfs_raw_item_size(eb, item);
 }
 
 static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
@@ -1980,55 +1980,32 @@ static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
 	return btrfs_item_end(eb, btrfs_item_nr(nr));
 }
 
-static inline u32 btrfs_item_offset_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_offset(eb, btrfs_item_nr(nr));
-}
-
-static inline u32 btrfs_item_size_nr(const struct extent_buffer *eb, int nr)
-{
-	return btrfs_item_size(eb, btrfs_item_nr(nr));
-}
-
-static inline void btrfs_set_item_size_nr(struct extent_buffer *eb, int nr,
-					  u32 val)
-{
-	btrfs_set_item_size(eb, btrfs_item_nr(nr), val);
-}
-
-static inline void btrfs_set_item_offset_nr(struct extent_buffer *eb, int nr,
-					    u32 val)
-{
-	btrfs_set_item_offset(eb, btrfs_item_nr(nr), val);
-}
-
-static inline u32 btrfs_token_item_offset_nr(struct btrfs_map_token *token,
-					     int slot)
-{
-	struct btrfs_item *item = btrfs_item_nr(slot);
-	return btrfs_token_item_offset(token, item);
-}
-
-static inline u32 btrfs_token_item_size_nr(struct btrfs_map_token *token,
-					     int slot)
-{
-	struct btrfs_item *item = btrfs_item_nr(slot);
-	return btrfs_token_item_size(token, item);
-}
-
-static inline void btrfs_set_token_item_offset_nr(struct btrfs_map_token *token,
-						  int slot, u32 val)
-{
-	struct btrfs_item *item = btrfs_item_nr(slot);
-	btrfs_set_token_item_offset(token, item, val);
-}
-
-static inline void btrfs_set_token_item_size_nr(struct btrfs_map_token *token,
-						int slot, u32 val)
-{
-	struct btrfs_item *item = btrfs_item_nr(slot);
-	btrfs_set_token_item_size(token, item, val);
-}
+#define BTRFS_ITEM_SETGET_FUNCS(member)						\
+static inline u32 btrfs_item_##member(const struct extent_buffer *eb,		\
+				      int slot)					\
+{										\
+	return btrfs_raw_item_##member(eb, btrfs_item_nr(slot));		\
+}										\
+static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
+					   int slot, u32 val)			\
+{										\
+	btrfs_set_raw_item_##member(eb, btrfs_item_nr(slot), val);		\
+}										\
+static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
+					    int slot)				\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(slot);				\
+	return btrfs_token_raw_item_##member(token, item);			\
+}										\
+static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
+						 int slot, u32 val)		\
+{										\
+	struct btrfs_item *item = btrfs_item_nr(slot);				\
+	btrfs_set_token_raw_item_##member(token, item, val);			\
+}
+
+BTRFS_ITEM_SETGET_FUNCS(offset)
+BTRFS_ITEM_SETGET_FUNCS(size);
 
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
@@ -2491,7 +2468,7 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 
 	if (nr == 0)
 		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
-	return btrfs_item_offset_nr(leaf, nr - 1);
+	return btrfs_item_offset(leaf, nr - 1);
 }
 
 /* struct btrfs_file_extent_item */
@@ -2552,7 +2529,7 @@ static inline u32 btrfs_file_extent_inline_item_len(
 						const struct extent_buffer *eb,
 						int nr)
 {
-	return btrfs_item_size_nr(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
 /* btrfs_qgroup_status_item */
@@ -2644,11 +2621,11 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
 /* helper function to cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type) \
 	((type *)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset_nr(leaf, slot)))
+	btrfs_item_offset(leaf, slot)))
 
 #define btrfs_item_ptr_offset(leaf, slot) \
 	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
-	btrfs_item_offset_nr(leaf, slot)))
+	btrfs_item_offset(leaf, slot)))
 
 static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 {
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 59ef388d43bc..a39987e020e3 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -128,7 +128,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	ptr = btrfs_item_ptr(eb, slot, struct btrfs_dev_replace_item);
 
 	if (item_size != sizeof(struct btrfs_dev_replace_item)) {
@@ -382,7 +382,7 @@ int btrfs_run_dev_replace(struct btrfs_trans_handle *trans)
 	}
 
 	if (ret == 0 &&
-	    btrfs_item_size_nr(path->nodes[0], path->slots[0]) < sizeof(*ptr)) {
+	    btrfs_item_size(path->nodes[0], path->slots[0]) < sizeof(*ptr)) {
 		/*
 		 * need to delete old one and insert a new one.
 		 * Since no attempt is made to recover any old state, if the
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 7f46c42a26fa..3b532bab0755 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -41,8 +41,8 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 	WARN_ON(ret > 0);
 	leaf = path->nodes[0];
 	ptr = btrfs_item_ptr(leaf, path->slots[0], char);
-	ASSERT(data_size <= btrfs_item_size_nr(leaf, path->slots[0]));
-	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - data_size;
+	ASSERT(data_size <= btrfs_item_size(leaf, path->slots[0]));
+	ptr += btrfs_item_size(leaf, path->slots[0]) - data_size;
 	return (struct btrfs_dir_item *)ptr;
 }
 
@@ -269,7 +269,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	data_size = sizeof(*di) + name_len;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
-	if (data_size + btrfs_item_size_nr(leaf, slot) +
+	if (data_size + btrfs_item_size(leaf, slot) +
 	    sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info)) {
 		ret = -EOVERFLOW;
 	} else {
@@ -407,7 +407,7 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 	leaf = path->nodes[0];
 	dir_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
 
-	total_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	total_len = btrfs_item_size(leaf, path->slots[0]);
 	while (cur < total_len) {
 		this_len = sizeof(*dir_item) +
 			btrfs_dir_name_len(leaf, dir_item) +
@@ -443,7 +443,7 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	sub_item_len = sizeof(*di) + btrfs_dir_name_len(leaf, di) +
 		btrfs_dir_data_len(leaf, di);
-	item_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_len = btrfs_item_size(leaf, path->slots[0]);
 	if (sub_item_len == item_len) {
 		ret = btrfs_del_item(trans, root, path);
 	} else {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3fd736a02c1e..c6c080ea0f30 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -171,7 +171,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 	if (ret == 0) {
 		leaf = path->nodes[0];
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		if (item_size >= sizeof(*ei)) {
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
@@ -865,7 +865,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (unlikely(item_size < sizeof(*ei))) {
 		err = -EINVAL;
 		btrfs_print_v0_err(fs_info);
@@ -1007,7 +1007,7 @@ void setup_inline_extent_backref(struct btrfs_fs_info *fs_info,
 		__run_delayed_extent_op(extent_op, leaf, ei);
 
 	ptr = (unsigned long)ei + item_offset;
-	end = (unsigned long)ei + btrfs_item_size_nr(leaf, path->slots[0]);
+	end = (unsigned long)ei + btrfs_item_size(leaf, path->slots[0]);
 	if (ptr < end - size)
 		memmove_extent_buffer(leaf, ptr + size, ptr,
 				      end - size - ptr);
@@ -1119,7 +1119,7 @@ void update_inline_extent_backref(struct btrfs_path *path,
 	} else {
 		*last_ref = 1;
 		size =  btrfs_extent_inline_ref_size(type);
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		ptr = (unsigned long)iref;
 		end = (unsigned long)ei + item_size;
 		if (ptr + size < end)
@@ -1634,7 +1634,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (unlikely(item_size < sizeof(*ei))) {
 		err = -EINVAL;
@@ -2316,7 +2316,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 		goto out;
 
 	ret = 1;
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 
 	/* If extent item has more than 1 inline ref then it's shared */
@@ -3068,7 +3068,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, extent_slot);
+	item_size = btrfs_item_size(leaf, extent_slot);
 	if (unlikely(item_size < sizeof(*ei))) {
 		ret = -EINVAL;
 		btrfs_print_v0_err(info);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d1cbb64a78f3..0f2e2ab34828 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -208,7 +208,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 
 		csum_offset = (bytenr - found_key.offset) >>
 				fs_info->sectorsize_bits;
-		csums_in_item = btrfs_item_size_nr(leaf, path->slots[0]);
+		csums_in_item = btrfs_item_size(leaf, path->slots[0]);
 		csums_in_item /= csum_size;
 
 		if (csum_offset == csums_in_item) {
@@ -274,7 +274,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_csum_item);
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		itemsize = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
+		itemsize = btrfs_item_size(path->nodes[0], path->slots[0]);
 
 		csum_start = key.offset;
 		csum_len = (itemsize / csum_size) * sectorsize;
@@ -291,7 +291,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	itemsize = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
+	itemsize = btrfs_item_size(path->nodes[0], path->slots[0]);
 
 	csum_start = key.offset;
 	csum_len = (itemsize / csum_size) * sectorsize;
@@ -534,7 +534,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 		    key.type == BTRFS_EXTENT_CSUM_KEY) {
 			offset = (start - key.offset) >> fs_info->sectorsize_bits;
 			if (offset * csum_size <
-			    btrfs_item_size_nr(leaf, path->slots[0] - 1))
+			    btrfs_item_size(leaf, path->slots[0] - 1))
 				path->slots[0]--;
 		}
 	}
@@ -559,7 +559,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 		if (key.offset > start)
 			start = key.offset;
 
-		size = btrfs_item_size_nr(leaf, path->slots[0]);
+		size = btrfs_item_size(leaf, path->slots[0]);
 		csum_end = key.offset + (size / csum_size) * fs_info->sectorsize;
 		if (csum_end <= start) {
 			path->slots[0]++;
@@ -750,7 +750,7 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
 	leaf = path->nodes[0];
-	csum_end = btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
+	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
 	csum_end <<= blocksize_bits;
 	csum_end += key->offset;
 
@@ -834,7 +834,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		if (key.offset >= end_byte)
 			break;
 
-		csum_end = btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
+		csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
 		csum_end <<= blocksize_bits;
 		csum_end += key.offset;
 
@@ -1002,7 +1002,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		item_end = btrfs_item_ptr(leaf, path->slots[0],
 					  struct btrfs_csum_item);
 		item_end = (struct btrfs_csum_item *)((char *)item_end +
-			   btrfs_item_size_nr(leaf, path->slots[0]));
+			   btrfs_item_size(leaf, path->slots[0]));
 		goto found;
 	}
 	ret = PTR_ERR(item);
@@ -1013,7 +1013,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		u32 item_size;
 		/* we found one, but it isn't big enough yet */
 		leaf = path->nodes[0];
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		if ((item_size / csum_size) >=
 		    MAX_CSUM_ITEMS(fs_info, csum_size)) {
 			/* already at max size, make a new one */
@@ -1070,7 +1070,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	}
 
 extend_csum:
-	if (csum_offset == btrfs_item_size_nr(leaf, path->slots[0]) /
+	if (csum_offset == btrfs_item_size(leaf, path->slots[0]) /
 	    csum_size) {
 		int extend_nr;
 		u64 tmp;
@@ -1125,7 +1125,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		diff = min(diff,
 			   MAX_CSUM_ITEMS(fs_info, csum_size) * csum_size);
 
-		diff = diff - btrfs_item_size_nr(leaf, path->slots[0]);
+		diff = diff - btrfs_item_size(leaf, path->slots[0]);
 		diff = min_t(u32, btrfs_leaf_free_space(leaf), diff);
 		diff /= csum_size;
 		diff *= csum_size;
@@ -1162,7 +1162,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 csum:
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
 	item_end = (struct btrfs_csum_item *)((unsigned char *)item +
-				      btrfs_item_size_nr(leaf, path->slots[0]));
+				      btrfs_item_size(leaf, path->slots[0]));
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 65111c484d15..56755ce9a907 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -19,7 +19,7 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 	u32 cur_offset = 0;
 	int len;
 
-	item_size = btrfs_item_size_nr(leaf, slot);
+	item_size = btrfs_item_size(leaf, slot);
 	ptr = btrfs_item_ptr_offset(leaf, slot);
 	while (cur_offset < item_size) {
 		ref = (struct btrfs_inode_ref *)(ptr + cur_offset);
@@ -45,7 +45,7 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 	u32 cur_offset = 0;
 	int ref_name_len;
 
-	item_size = btrfs_item_size_nr(leaf, slot);
+	item_size = btrfs_item_size(leaf, slot);
 	ptr = btrfs_item_ptr_offset(leaf, slot);
 
 	/*
@@ -139,7 +139,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	if (index)
 		*index = btrfs_inode_extref_index(leaf, extref);
 
@@ -208,7 +208,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 
 	if (index)
 		*index = btrfs_inode_ref_index(leaf, ref);
@@ -282,7 +282,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
-	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - ins_len;
+	ptr += btrfs_item_size(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
 	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
@@ -330,7 +330,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (ref)
 			goto out;
 
-		old_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
+		old_size = btrfs_item_size(path->nodes[0], path->slots[0]);
 		btrfs_extend_item(path, ins_len);
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9d3f375df83..912f32a9e683 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2067,7 +2067,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 	for (i = slot; i < nritems; i++) {
 		item_off = btrfs_item_ptr_offset(leaf, i);
-		item_len = btrfs_item_size_nr(leaf, i);
+		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
 		if (!key_in_sk(key, sk))
@@ -2522,7 +2522,7 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 
 	item_off = btrfs_item_ptr_offset(leaf, slot);
-	item_len = btrfs_item_size_nr(leaf, slot);
+	item_len = btrfs_item_size(leaf, slot);
 	/* Check if dirid in ROOT_REF corresponds to passed dirid */
 	rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
 	if (args->dirid != btrfs_root_ref_dirid(leaf, rref)) {
@@ -2724,7 +2724,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 
 			item_off = btrfs_item_ptr_offset(leaf, slot)
 					+ sizeof(struct btrfs_root_ref);
-			item_len = btrfs_item_size_nr(leaf, slot)
+			item_len = btrfs_item_size(leaf, slot)
 					- sizeof(struct btrfs_root_ref);
 			read_extent_buffer(leaf, subvol_info->name,
 					   item_off, item_len);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 52370af39afe..0775ae9f4419 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -85,7 +85,7 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 	struct btrfs_disk_key key;
 	unsigned long end;
 	unsigned long ptr;
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	u64 flags;
 	u64 offset;
 	int ref_index = 0;
@@ -227,7 +227,7 @@ void btrfs_print_leaf(struct extent_buffer *l)
 		type = key.type;
 		pr_info("\titem %d key (%llu %u %llu) itemoff %d itemsize %d\n",
 			i, key.objectid, type, key.offset,
-			btrfs_item_offset_nr(l, i), btrfs_item_size_nr(l, i));
+			btrfs_item_offset(l, i), btrfs_item_size(l, i));
 		switch (type) {
 		case BTRFS_INODE_ITEM_KEY:
 			ii = btrfs_item_ptr(l, i, struct btrfs_inode_item);
@@ -345,7 +345,7 @@ void btrfs_print_leaf(struct extent_buffer *l)
 		case BTRFS_UUID_KEY_SUBVOL:
 		case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
-					btrfs_item_size_nr(l, i));
+					btrfs_item_size(l, i));
 			break;
 		}
 	}
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index b1cb5a8c2999..a978676aa627 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -158,7 +158,7 @@ static int iterate_object_props(struct btrfs_root *root,
 
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 		cur = 0;
-		total_len = btrfs_item_size_nr(leaf, slot);
+		total_len = btrfs_item_size(leaf, slot);
 
 		while (cur < total_len) {
 			u32 name_len = btrfs_dir_name_len(leaf, di);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index e2b9f8616501..f34130d90dee 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -435,7 +435,7 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	struct extent_buffer *leaf = path->nodes[0];
-	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u32 item_size = btrfs_item_size(leaf, slot);
 	unsigned long end, ptr;
 	u64 offset, flags, count;
 	int type, ret;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e0f93b357548..a3930da4eb3f 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -439,7 +439,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			break;
 		}
 		next_key_min_offset = key.offset + datal;
-		size = btrfs_item_size_nr(leaf, slot);
+		size = btrfs_item_size(leaf, slot);
 		read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf, slot),
 				   size);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 33a0ee7ac590..ee0a0efc7efd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3149,7 +3149,7 @@ static int add_tree_block(struct reloc_control *rc,
 	u64 owner = 0;
 
 	eb =  path->nodes[0];
-	item_size = btrfs_item_size_nr(eb, path->slots[0]);
+	item_size = btrfs_item_size(eb, path->slots[0]);
 
 	if (extent_key->type == BTRFS_METADATA_ITEM_KEY ||
 	    item_size >= sizeof(*ei) + sizeof(*bi)) {
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..458aa74a37ce 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -25,7 +25,7 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 	u32 len;
 	int need_reset = 0;
 
-	len = btrfs_item_size_nr(eb, slot);
+	len = btrfs_item_size(eb, slot);
 	read_extent_buffer(eb, item, btrfs_item_ptr_offset(eb, slot),
 			   min_t(u32, len, sizeof(*item)));
 	if (len < sizeof(*item))
@@ -148,7 +148,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr_offset(l, slot);
-	old_len = btrfs_item_size_nr(l, slot);
+	old_len = btrfs_item_size(l, slot);
 
 	/*
 	 * If this is the first time we update the root item which originated
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf82ea6f54fb..648c055764d3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -758,7 +758,7 @@ static void scrub_print_warning(const char *errstr, struct scrub_block *sblock)
 
 	eb = path->nodes[0];
 	ei = btrfs_item_ptr(eb, path->slots[0], struct btrfs_extent_item);
-	item_size = btrfs_item_size_nr(eb, path->slots[0]);
+	item_size = btrfs_item_size(eb, path->slots[0]);
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 		do {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e15f18dec9a6..4d96cb089c93 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -917,11 +917,11 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	if (found_key->type == BTRFS_INODE_REF_KEY) {
 		ptr = (unsigned long)btrfs_item_ptr(eb, slot,
 						    struct btrfs_inode_ref);
-		total = btrfs_item_size_nr(eb, slot);
+		total = btrfs_item_size(eb, slot);
 		elem_size = sizeof(*iref);
 	} else {
 		ptr = btrfs_item_ptr_offset(eb, slot);
-		total = btrfs_item_size_nr(eb, slot);
+		total = btrfs_item_size(eb, slot);
 		elem_size = sizeof(*extref);
 	}
 
@@ -1035,7 +1035,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	cur = 0;
 	len = 0;
-	total = btrfs_item_size_nr(eb, slot);
+	total = btrfs_item_size(eb, slot);
 
 	num = 0;
 	while (cur < total) {
@@ -3606,7 +3606,7 @@ static int is_ancestor(struct btrfs_root *root,
 		    key.type != BTRFS_INODE_EXTREF_KEY)
 			break;
 
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		while (cur_offset < item_size) {
 			u64 parent;
 			u64 parent_gen;
@@ -6550,7 +6550,7 @@ static int compare_refs(struct send_ctx *sctx, struct btrfs_path *path,
 	}
 
 	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	while (cur_offset < item_size) {
 		extref = (struct btrfs_inode_extref *)(ptr +
@@ -6775,8 +6775,8 @@ static int tree_compare_item(struct btrfs_path *left_path,
 	int len1, len2;
 	unsigned long off1, off2;
 
-	len1 = btrfs_item_size_nr(left_path->nodes[0], left_path->slots[0]);
-	len2 = btrfs_item_size_nr(right_path->nodes[0], right_path->slots[0]);
+	len1 = btrfs_item_size(left_path->nodes[0], left_path->slots[0]);
+	len2 = btrfs_item_size(right_path->nodes[0], right_path->slots[0]);
 	if (len1 != len2)
 		return 1;
 
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index bbef99175564..51a8b075c259 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -88,7 +88,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	if (btrfs_item_size_nr(eb, 0) != strlen(split1)) {
+	if (btrfs_item_size(eb, 0) != strlen(split1)) {
 		test_err("invalid len in the first split");
 		ret = -EINVAL;
 		goto out;
@@ -112,7 +112,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	if (btrfs_item_size_nr(eb, 1) != strlen(split2)) {
+	if (btrfs_item_size(eb, 1) != strlen(split2)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
@@ -143,7 +143,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	if (btrfs_item_size_nr(eb, 0) != strlen(split3)) {
+	if (btrfs_item_size(eb, 0) != strlen(split3)) {
 		test_err("invalid len in the first split");
 		ret = -EINVAL;
 		goto out;
@@ -166,7 +166,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	if (btrfs_item_size_nr(eb, 1) != strlen(split4)) {
+	if (btrfs_item_size(eb, 1) != strlen(split4)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
@@ -189,7 +189,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	if (btrfs_item_size_nr(eb, 2) != strlen(split2)) {
+	if (btrfs_item_size(eb, 2) != strlen(split2)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7733e8ac0a69..09512d79e687 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -202,7 +202,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_file_extent_item *fi;
 	u32 sectorsize = fs_info->sectorsize;
-	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
 
 	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
@@ -354,17 +354,17 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			key->offset, sectorsize);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(btrfs_item_size_nr(leaf, slot), csumsize))) {
+	if (unlikely(!IS_ALIGNED(btrfs_item_size(leaf, slot), csumsize))) {
 		generic_err(leaf, slot,
 	"unaligned item size for csum item, have %u should be aligned to %u",
-			btrfs_item_size_nr(leaf, slot), csumsize);
+			btrfs_item_size(leaf, slot), csumsize);
 		return -EUCLEAN;
 	}
 	if (slot > 0 && prev_key->type == BTRFS_EXTENT_CSUM_KEY) {
 		u64 prev_csum_end;
 		u32 prev_item_size;
 
-		prev_item_size = btrfs_item_size_nr(leaf, slot - 1);
+		prev_item_size = btrfs_item_size(leaf, slot - 1);
 		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
 		prev_csum_end += prev_key->offset;
 		if (unlikely(prev_csum_end > key->offset)) {
@@ -483,7 +483,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_dir_item *di;
-	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u32 item_size = btrfs_item_size(leaf, slot);
 	u32 cur = 0;
 
 	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
@@ -640,7 +640,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
 				  struct btrfs_key *key, int slot)
 {
 	struct btrfs_block_group_item bgi;
-	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 flags;
 	u64 type;
 
@@ -912,10 +912,10 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 {
 	int num_stripes;
 
-	if (unlikely(btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk))) {
+	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
 		chunk_err(leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect [%zu, %u)",
-			btrfs_item_size_nr(leaf, slot),
+			btrfs_item_size(leaf, slot),
 			sizeof(struct btrfs_chunk),
 			BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
 		return -EUCLEAN;
@@ -927,10 +927,10 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
 		goto out;
 
 	if (unlikely(btrfs_chunk_item_size(num_stripes) !=
-		     btrfs_item_size_nr(leaf, slot))) {
+		     btrfs_item_size(leaf, slot))) {
 		chunk_err(leaf, chunk, key->offset,
 			"invalid chunk item size: have %u expect %lu",
-			btrfs_item_size_nr(leaf, slot),
+			btrfs_item_size(leaf, slot),
 			btrfs_chunk_item_size(num_stripes));
 		return -EUCLEAN;
 	}
@@ -1095,12 +1095,12 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	if (unlikely(ret < 0))
 		return ret;
 
-	if (unlikely(btrfs_item_size_nr(leaf, slot) != sizeof(ri) &&
-		     btrfs_item_size_nr(leaf, slot) !=
+	if (unlikely(btrfs_item_size(leaf, slot) != sizeof(ri) &&
+		     btrfs_item_size(leaf, slot) !=
 		     btrfs_legacy_root_item_size())) {
 		generic_err(leaf, slot,
 			    "invalid root item size, have %u expect %zu or %u",
-			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
+			    btrfs_item_size(leaf, slot), sizeof(ri),
 			    btrfs_legacy_root_item_size());
 		return -EUCLEAN;
 	}
@@ -1111,7 +1111,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	 * And since we allow geneartion_v2 as 0, it will still pass the check.
 	 */
 	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
-			   btrfs_item_size_nr(leaf, slot));
+			   btrfs_item_size(leaf, slot));
 
 	/* Generation related */
 	if (unlikely(btrfs_root_generation(&ri) >
@@ -1208,7 +1208,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 	bool is_tree_block = false;
 	unsigned long ptr;	/* Current pointer inside inline refs */
 	unsigned long end;	/* Extent item end */
-	const u32 item_size = btrfs_item_size_nr(leaf, slot);
+	const u32 item_size = btrfs_item_size(leaf, slot);
 	u64 flags;
 	u64 generation;
 	u64 total_refs;		/* Total refs in btrfs_extent_item */
@@ -1432,10 +1432,10 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
 		expect_item_size = sizeof(struct btrfs_shared_data_ref);
 
-	if (unlikely(btrfs_item_size_nr(leaf, slot) != expect_item_size)) {
+	if (unlikely(btrfs_item_size(leaf, slot) != expect_item_size)) {
 		generic_err(leaf, slot,
 		"invalid item size, have %u expect %u for key type %u",
-			    btrfs_item_size_nr(leaf, slot),
+			    btrfs_item_size(leaf, slot),
 			    expect_item_size, key->type);
 		return -EUCLEAN;
 	}
@@ -1460,12 +1460,12 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 {
 	struct btrfs_extent_data_ref *dref;
 	unsigned long ptr = btrfs_item_ptr_offset(leaf, slot);
-	const unsigned long end = ptr + btrfs_item_size_nr(leaf, slot);
+	const unsigned long end = ptr + btrfs_item_size(leaf, slot);
 
-	if (unlikely(btrfs_item_size_nr(leaf, slot) % sizeof(*dref) != 0)) {
+	if (unlikely(btrfs_item_size(leaf, slot) % sizeof(*dref) != 0)) {
 		generic_err(leaf, slot,
 	"invalid item size, have %u expect aligned to %zu for key type %u",
-			    btrfs_item_size_nr(leaf, slot),
+			    btrfs_item_size(leaf, slot),
 			    sizeof(*dref), key->type);
 		return -EUCLEAN;
 	}
@@ -1507,16 +1507,16 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
 		return -EUCLEAN;
 	/* namelen can't be 0, so item_size == sizeof() is also invalid */
-	if (unlikely(btrfs_item_size_nr(leaf, slot) <= sizeof(*iref))) {
+	if (unlikely(btrfs_item_size(leaf, slot) <= sizeof(*iref))) {
 		inode_ref_err(leaf, slot,
 			"invalid item size, have %u expect (%zu, %u)",
-			btrfs_item_size_nr(leaf, slot),
+			btrfs_item_size(leaf, slot),
 			sizeof(*iref), BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
 		return -EUCLEAN;
 	}
 
 	ptr = btrfs_item_ptr_offset(leaf, slot);
-	end = ptr + btrfs_item_size_nr(leaf, slot);
+	end = ptr + btrfs_item_size(leaf, slot);
 	while (ptr < end) {
 		u16 namelen;
 
@@ -1689,7 +1689,7 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		if (slot == 0)
 			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
 		else
-			item_end_expected = btrfs_item_offset_nr(leaf,
+			item_end_expected = btrfs_item_offset(leaf,
 								 slot - 1);
 		if (unlikely(btrfs_item_end_nr(leaf, slot) != item_end_expected)) {
 			generic_err(leaf, slot,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c900eb27cf8..8799bf6247d4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -386,7 +386,7 @@ static int do_overwrite_item(struct btrfs_trans_handle *trans,
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)
 		overwrite_root = 1;
 
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	src_ptr = btrfs_item_ptr_offset(eb, slot);
 
 	/* Our caller must have done a search for the key for us. */
@@ -409,7 +409,7 @@ static int do_overwrite_item(struct btrfs_trans_handle *trans,
 	if (ret == 0) {
 		char *src_copy;
 		char *dst_copy;
-		u32 dst_size = btrfs_item_size_nr(path->nodes[0],
+		u32 dst_size = btrfs_item_size(path->nodes[0],
 						  path->slots[0]);
 		if (dst_size != item_size)
 			goto insert;
@@ -503,7 +503,7 @@ static int do_overwrite_item(struct btrfs_trans_handle *trans,
 	/* make sure any existing item is the correct size */
 	if (ret == -EEXIST || ret == -EOVERFLOW) {
 		u32 found_size;
-		found_size = btrfs_item_size_nr(path->nodes[0],
+		found_size = btrfs_item_size(path->nodes[0],
 						path->slots[0]);
 		if (found_size > item_size)
 			btrfs_truncate_item(path, item_size, 1);
@@ -1096,7 +1096,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		 * otherwise they must be unlinked as a conflict
 		 */
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-		ptr_end = ptr + btrfs_item_size_nr(leaf, path->slots[0]);
+		ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
 		while (ptr < ptr_end) {
 			victim_ref = (struct btrfs_inode_ref *)ptr;
 			victim_name_len = btrfs_inode_ref_name_len(leaf,
@@ -1155,7 +1155,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 		leaf = path->nodes[0];
 
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		base = btrfs_item_ptr_offset(leaf, path->slots[0]);
 
 		while (cur_offset < item_size) {
@@ -1317,7 +1317,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 
 	eb = path->nodes[0];
 	ref_ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
-	ref_end = ref_ptr + btrfs_item_size_nr(eb, path->slots[0]);
+	ref_end = ref_ptr + btrfs_item_size(eb, path->slots[0]);
 	while (ref_ptr < ref_end) {
 		char *name = NULL;
 		int namelen;
@@ -1502,7 +1502,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	int ref_struct_size;
 
 	ref_ptr = btrfs_item_ptr_offset(eb, slot);
-	ref_end = ref_ptr + btrfs_item_size_nr(eb, slot);
+	ref_end = ref_ptr + btrfs_item_size(eb, slot);
 
 	if (key->type == BTRFS_INODE_EXTREF_KEY) {
 		struct btrfs_inode_extref *r;
@@ -1676,7 +1676,7 @@ static int count_inode_extrefs(struct btrfs_root *root,
 			break;
 
 		leaf = path->nodes[0];
-		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+		item_size = btrfs_item_size(leaf, path->slots[0]);
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		cur_offset = 0;
 
@@ -1730,7 +1730,7 @@ static int count_inode_refs(struct btrfs_root *root,
 		    key.type != BTRFS_INODE_REF_KEY)
 			break;
 		ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-		ptr_end = ptr + btrfs_item_size_nr(path->nodes[0],
+		ptr_end = ptr + btrfs_item_size(path->nodes[0],
 						   path->slots[0]);
 		while (ptr < ptr_end) {
 			struct btrfs_inode_ref *ref;
@@ -2123,7 +2123,7 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 					struct btrfs_key *key)
 {
 	int ret = 0;
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	struct btrfs_dir_item *di;
 	int name_len;
 	unsigned long ptr;
@@ -2302,7 +2302,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 again:
 	eb = path->nodes[0];
 	slot = path->slots[0];
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	ptr = btrfs_item_ptr_offset(eb, slot);
 	ptr_end = ptr + item_size;
 	while (ptr < ptr_end) {
@@ -2420,7 +2420,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 		}
 
 		di = btrfs_item_ptr(path->nodes[0], i, struct btrfs_dir_item);
-		total_size = btrfs_item_size_nr(path->nodes[0], i);
+		total_size = btrfs_item_size(path->nodes[0], i);
 		cur = 0;
 		while (cur < total_size) {
 			u16 name_len = btrfs_dir_name_len(path->nodes[0], di);
@@ -3672,7 +3672,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	if (count == 1) {
 		btrfs_item_key_to_cpu(src, &key, start_slot);
-		item_size = btrfs_item_size_nr(src, start_slot);
+		item_size = btrfs_item_size(src, start_slot);
 		batch.keys = &key;
 		batch.data_sizes = &item_size;
 		batch.total_data_size = item_size;
@@ -3695,7 +3695,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 			const int slot = start_slot + i;
 
 			btrfs_item_key_to_cpu(src, &ins_keys[i], slot);
-			ins_sizes[i] = btrfs_item_size_nr(src, slot);
+			ins_sizes[i] = btrfs_item_size(src, slot);
 			batch.total_data_size += ins_sizes[i];
 		}
 	}
@@ -4346,7 +4346,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	batch.nr = nr;
 
 	for (i = 0; i < nr; i++) {
-		ins_sizes[i] = btrfs_item_size_nr(src, i + start_slot);
+		ins_sizes[i] = btrfs_item_size(src, i + start_slot);
 		batch.total_data_size += ins_sizes[i];
 		btrfs_item_key_to_cpu(src, ins_keys + i, i + start_slot);
 	}
@@ -5162,7 +5162,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	struct btrfs_path *search_path;
 	char *name = NULL;
 	u32 name_len = 0;
-	u32 item_size = btrfs_item_size_nr(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
 	u32 cur_offset = 0;
 	unsigned long ptr = btrfs_item_ptr_offset(eb, slot);
 
@@ -6089,7 +6089,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		if (key.objectid != ino || key.type > BTRFS_INODE_EXTREF_KEY)
 			break;
 
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
 			struct btrfs_key inode_key;
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 74023c8a783f..b458452a1aaf 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -52,7 +52,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, u8 *uuid,
 
 	eb = path->nodes[0];
 	slot = path->slots[0];
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	offset = btrfs_item_ptr_offset(eb, slot);
 	ret = -ENOENT;
 
@@ -125,7 +125,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
-		offset += btrfs_item_size_nr(eb, slot) - sizeof(subid_le);
+		offset += btrfs_item_size(eb, slot) - sizeof(subid_le);
 	} else {
 		btrfs_warn(fs_info,
 			   "insert uuid item failed %d (0x%016llx, 0x%016llx) type %u!",
@@ -186,7 +186,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	eb = path->nodes[0];
 	slot = path->slots[0];
 	offset = btrfs_item_ptr_offset(eb, slot);
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	if (!IS_ALIGNED(item_size, sizeof(u64))) {
 		btrfs_warn(fs_info, "uuid item with illegal size %lu!",
 			   (unsigned long)item_size);
@@ -208,7 +208,7 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		goto out;
 	}
 
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 	if (item_size == sizeof(subid)) {
 		ret = btrfs_del_item(trans, uuid_root, path);
 		goto out;
@@ -331,7 +331,7 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 			goto skip;
 
 		offset = btrfs_item_ptr_offset(leaf, slot);
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		if (!IS_ALIGNED(item_size, sizeof(u64))) {
 			btrfs_warn(fs_info,
 				   "uuid item with illegal size %lu!",
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4968535dfff0..90eb5c2830a9 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -333,7 +333,7 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		if (key.objectid != btrfs_ino(inode) || key.type != key_type)
 			break;
 
-		item_end = btrfs_item_size_nr(leaf, path->slots[0]) + key.offset;
+		item_end = btrfs_item_size(leaf, path->slots[0]) + key.offset;
 
 		if (copied > 0) {
 			/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9eab8a741166..fdb74441a6a4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4634,7 +4634,7 @@ int btrfs_uuid_scan_kthread(void *data)
 
 		eb = path->nodes[0];
 		slot = path->slots[0];
-		item_size = btrfs_item_size_nr(eb, slot);
+		item_size = btrfs_item_size(eb, slot);
 		if (item_size < sizeof(root_item))
 			goto skip;
 
@@ -7713,7 +7713,7 @@ static int btrfs_device_init_dev_stats(struct btrfs_device *device,
 	}
 	slot = path->slots[0];
 	eb = path->nodes[0];
-	item_size = btrfs_item_size_nr(eb, slot);
+	item_size = btrfs_item_size(eb, slot);
 
 	ptr = btrfs_item_ptr(eb, slot, struct btrfs_dev_stats_item);
 
@@ -7791,7 +7791,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	}
 
 	if (ret == 0 &&
-	    btrfs_item_size_nr(path->nodes[0], path->slots[0]) < sizeof(*ptr)) {
+	    btrfs_item_size(path->nodes[0], path->slots[0]) < sizeof(*ptr)) {
 		/* need to delete old one and insert a new one */
 		ret = btrfs_del_item(trans, dev_root, path);
 		if (ret != 0) {
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 0f04bb7f3ce4..99abf41b89b9 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -168,7 +168,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		const int slot = path->slots[0];
 		struct extent_buffer *leaf = path->nodes[0];
 		const u16 old_data_len = btrfs_dir_data_len(leaf, di);
-		const u32 item_size = btrfs_item_size_nr(leaf, slot);
+		const u32 item_size = btrfs_item_size(leaf, slot);
 		const u32 data_size = sizeof(*di) + name_len + size;
 		unsigned long data_ptr;
 		char *ptr;
@@ -196,7 +196,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		}
 
 		ptr = btrfs_item_ptr(leaf, slot, char);
-		ptr += btrfs_item_size_nr(leaf, slot) - data_size;
+		ptr += btrfs_item_size(leaf, slot) - data_size;
 		di = (struct btrfs_dir_item *)ptr;
 		btrfs_set_dir_data_len(leaf, di, size);
 		data_ptr = ((unsigned long)(di + 1)) + name_len;
@@ -333,7 +333,7 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto next_item;
 
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
-		item_size = btrfs_item_size_nr(leaf, slot);
+		item_size = btrfs_item_size(leaf, slot);
 		cur = 0;
 		while (cur < item_size) {
 			u16 name_len = btrfs_dir_name_len(leaf, di);
-- 
2.26.3

