Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB990436AF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJUTBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJUTA5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:00:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E302C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:41 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c28so1390615qtv.11
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IVYd9CVQfHD1PRJdmuMzwzVpkJfCK1eiN0YddIITZZ8=;
        b=4/kA+dZiSwBy7biW+4h82jnoZL/h/xG46V9AeKWBZy03HKmtp4uXorHIJjE+7/MLcC
         RTqzfKF8A7BnMVFpLJnFIo0FgEKs2s3DBcC0aVH5z27WUGc80Za9Iv2lkYN0pWFW4DMW
         qy/lq0WElzEzaKSxHALpRIveNrVfwCV93zfp2sZ4d0ztV+ygO0jLE/qx7lK0/VhDhneG
         iV+T2ZjjhVReEnUrdAyKG95dDauiaFFtNxfyYwuABvwZw9ZhqXrFiJ0NS6grsFNv8sut
         gHMwUXKUg7Pp9KD4ahhYHfR1gsFF6ZlMqyD+FGtZRok005YZpv0RVc/bCAxXzTfKHTtB
         sodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVYd9CVQfHD1PRJdmuMzwzVpkJfCK1eiN0YddIITZZ8=;
        b=vMOb2EW+h1HbjlzaFyKcIGQMcWdq3b6eDLHIvpVt/HGkP9PlPV/PGRaTpHI0Wb9Ypy
         J+TCHY7zoPddzTFvU+xidx3OOR3NUCe6WhcR5GdAMOzS1PJNk7GWU1bvybt7TV4t8Ojc
         o3itqxAGE+I9iYx9HL8eTIF29g5j0Kt1dfsmIkUKW/xywVnFUQUNy8pNzNhW7N6LJTPn
         t52FQOVytQsFQfqoROt6ml4xKFvujcNqjq+ceHej539/OtAvZacuU77lr6Sa+viYNdy1
         cKPs5kmSaP0cymU7PM0/LbHPxFvxa+2RfOxGCKVldwyYG1ypakcgDxDidgWycLuxcu8E
         Vh8g==
X-Gm-Message-State: AOAM5325iE0Yetzjrmpe0VMpV7NLP2BIFQIlgFDNTuR/WL6JNUY8tXIT
        kTWqUVFZQosgzJvb8O5609HMMR9UGaj5OQ==
X-Google-Smtp-Source: ABdhPJx4oiImu7PVn/TRICWrBs/1jq0hS5y0SBYaGT+3RyQcBYROAYHAjQuv6fPiO/UexPhZaRnLfQ==
X-Received: by 2002:a05:622a:1441:: with SMTP id v1mr8183476qtx.45.1634842720338;
        Thu, 21 Oct 2021 11:58:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s17sm2019253qtw.95.2021.10.21.11.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: use btrfs_item_size_nr/btrfs_item_offset_nr everywhere
Date:   Thu, 21 Oct 2021 14:58:31 -0400
Message-Id: <b64b018e55c848bcc78b2f8bd8f6db01d0c93685.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this pattern in a lot of places

item = btrfs_item_nr(slot);
btrfs_item_size(leaf, item);

when we could simply use

btrfs_item_size(leaf, slot);

Fix all callers of btrfs_item_size() and btrfs_item_offset() to use the
_nr variation of the helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c                   |  4 +---
 fs/btrfs/ctree.c                     | 22 +++++++---------------
 fs/btrfs/dir-item.c                  |  6 ++----
 fs/btrfs/inode-item.c                |  4 +---
 fs/btrfs/print-tree.c                |  4 +---
 fs/btrfs/send.c                      |  8 ++------
 fs/btrfs/tests/extent-buffer-tests.c | 17 +++++------------
 fs/btrfs/xattr.c                     |  4 +---
 8 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f735b8798ba1..8066b524916c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2058,7 +2058,6 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 	u64 parent = 0;
 	int found = 0;
 	struct extent_buffer *eb;
-	struct btrfs_item *item;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_key found_key;
 
@@ -2084,10 +2083,9 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 		}
 		btrfs_release_path(path);
 
-		item = btrfs_item_nr(slot);
 		iref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
 
-		for (cur = 0; cur < btrfs_item_size(eb, item); cur += len) {
+		for (cur = 0; cur < btrfs_item_size_nr(eb, slot); cur += len) {
 			name_len = btrfs_inode_ref_name_len(eb, iref);
 			/* path must be released before calling iterate()! */
 			btrfs_debug(fs_root->fs_info,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 74c8e18f3720..ec8b1266fd92 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2614,19 +2614,15 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
  */
 static int leaf_space_used(struct extent_buffer *l, int start, int nr)
 {
-	struct btrfs_item *start_item;
-	struct btrfs_item *end_item;
 	int data_len;
 	int nritems = btrfs_header_nritems(l);
 	int end = min(nritems, start + nr) - 1;
 
 	if (!nr)
 		return 0;
-	start_item = btrfs_item_nr(start);
-	end_item = btrfs_item_nr(end);
-	data_len = btrfs_item_offset(l, start_item) +
-		   btrfs_item_size(l, start_item);
-	data_len = data_len - btrfs_item_offset(l, end_item);
+	data_len = btrfs_item_offset_nr(l, start) +
+		   btrfs_item_size_nr(l, start);
+	data_len = data_len - btrfs_item_offset_nr(l, end);
 	data_len += sizeof(struct btrfs_item) * nr;
 	WARN_ON(data_len < 0);
 	return data_len;
@@ -2690,8 +2686,6 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	slot = path->slots[1];
 	i = left_nritems - 1;
 	while (i >= nr) {
-		item = btrfs_item_nr(i);
-
 		if (!empty && push_items > 0) {
 			if (path->slots[0] > i)
 				break;
@@ -2706,7 +2700,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 		if (path->slots[0] == i)
 			push_space += data_size;
 
-		this_item_size = btrfs_item_size(left, item);
+		this_item_size = btrfs_item_size_nr(left, i);
 		if (this_item_size + sizeof(*item) + push_space > free_space)
 			break;
 
@@ -2917,8 +2911,6 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 		nr = min(right_nritems - 1, max_slot);
 
 	for (i = 0; i < nr; i++) {
-		item = btrfs_item_nr(i);
-
 		if (!empty && push_items > 0) {
 			if (path->slots[0] < i)
 				break;
@@ -2933,7 +2925,7 @@ static noinline int __push_leaf_left(struct btrfs_path *path, int data_size,
 		if (path->slots[0] == i)
 			push_space += data_size;
 
-		this_item_size = btrfs_item_size(right, item);
+		this_item_size = btrfs_item_size_nr(right, i);
 		if (this_item_size + sizeof(*item) + push_space > free_space)
 			break;
 
@@ -3500,8 +3492,8 @@ static noinline int split_item(struct btrfs_path *path,
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
 	item = btrfs_item_nr(path->slots[0]);
-	orig_offset = btrfs_item_offset(leaf, item);
-	item_size = btrfs_item_size(leaf, item);
+	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
 
 	buf = kmalloc(item_size, GFP_NOFS);
 	if (!buf)
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 7721ce0c0604..7f46c42a26fa 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -27,7 +27,6 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	char *ptr;
-	struct btrfs_item *item;
 	struct extent_buffer *leaf;
 
 	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
@@ -41,10 +40,9 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 		return ERR_PTR(ret);
 	WARN_ON(ret > 0);
 	leaf = path->nodes[0];
-	item = btrfs_item_nr(path->slots[0]);
 	ptr = btrfs_item_ptr(leaf, path->slots[0], char);
-	BUG_ON(data_size > btrfs_item_size(leaf, item));
-	ptr += btrfs_item_size(leaf, item) - data_size;
+	ASSERT(data_size <= btrfs_item_size_nr(leaf, path->slots[0]));
+	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - data_size;
 	return (struct btrfs_dir_item *)ptr;
 }
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 37f36ffdaf6b..65111c484d15 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -256,7 +256,6 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
@@ -282,9 +281,8 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		goto out;
 
 	leaf = path->nodes[0];
-	item = btrfs_item_nr(path->slots[0]);
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
-	ptr += btrfs_item_size(leaf, item) - ins_len;
+	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
 	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aae1027bd76a..52370af39afe 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -200,7 +200,6 @@ void btrfs_print_leaf(struct extent_buffer *l)
 	struct btrfs_fs_info *fs_info;
 	int i;
 	u32 type, nr;
-	struct btrfs_item *item;
 	struct btrfs_root_item *ri;
 	struct btrfs_dir_item *di;
 	struct btrfs_inode_item *ii;
@@ -224,12 +223,11 @@ void btrfs_print_leaf(struct extent_buffer *l)
 		   btrfs_leaf_free_space(l), btrfs_header_owner(l));
 	print_eb_refs_lock(l);
 	for (i = 0 ; i < nr ; i++) {
-		item = btrfs_item_nr(i);
 		btrfs_item_key_to_cpu(l, &key, i);
 		type = key.type;
 		pr_info("\titem %d key (%llu %u %llu) itemoff %d itemsize %d\n",
 			i, key.objectid, type, key.offset,
-			btrfs_item_offset(l, item), btrfs_item_size(l, item));
+			btrfs_item_offset_nr(l, i), btrfs_item_size_nr(l, i));
 		switch (type) {
 		case BTRFS_INODE_ITEM_KEY:
 			ii = btrfs_item_ptr(l, i, struct btrfs_inode_item);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..e15f18dec9a6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -886,7 +886,6 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 			     iterate_inode_ref_t iterate, void *ctx)
 {
 	struct extent_buffer *eb = path->nodes[0];
-	struct btrfs_item *item;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_inode_extref *extref;
 	struct btrfs_path *tmp_path;
@@ -918,8 +917,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	if (found_key->type == BTRFS_INODE_REF_KEY) {
 		ptr = (unsigned long)btrfs_item_ptr(eb, slot,
 						    struct btrfs_inode_ref);
-		item = btrfs_item_nr(slot);
-		total = btrfs_item_size(eb, item);
+		total = btrfs_item_size_nr(eb, slot);
 		elem_size = sizeof(*iref);
 	} else {
 		ptr = btrfs_item_ptr_offset(eb, slot);
@@ -1006,7 +1004,6 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 {
 	int ret = 0;
 	struct extent_buffer *eb;
-	struct btrfs_item *item;
 	struct btrfs_dir_item *di;
 	struct btrfs_key di_key;
 	char *buf = NULL;
@@ -1035,11 +1032,10 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 
 	eb = path->nodes[0];
 	slot = path->slots[0];
-	item = btrfs_item_nr(slot);
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	cur = 0;
 	len = 0;
-	total = btrfs_item_size(eb, item);
+	total = btrfs_item_size_nr(eb, slot);
 
 	num = 0;
 	while (cur < total) {
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 2a95f7224e18..bbef99175564 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -15,7 +15,6 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	struct btrfs_path *path = NULL;
 	struct btrfs_root *root = NULL;
 	struct extent_buffer *eb;
-	struct btrfs_item *item;
 	char *value = "mary had a little lamb";
 	char *split1 = "mary had a little";
 	char *split2 = " lamb";
@@ -61,7 +60,6 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	key.offset = 0;
 
 	btrfs_setup_item_for_insert(root, path, &key, value_len);
-	item = btrfs_item_nr(0);
 	write_extent_buffer(eb, value, btrfs_item_ptr_offset(eb, 0),
 			    value_len);
 
@@ -90,8 +88,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	item = btrfs_item_nr(0);
-	if (btrfs_item_size(eb, item) != strlen(split1)) {
+	if (btrfs_item_size_nr(eb, 0) != strlen(split1)) {
 		test_err("invalid len in the first split");
 		ret = -EINVAL;
 		goto out;
@@ -115,8 +112,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	item = btrfs_item_nr(1);
-	if (btrfs_item_size(eb, item) != strlen(split2)) {
+	if (btrfs_item_size_nr(eb, 1) != strlen(split2)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
@@ -147,8 +143,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	item = btrfs_item_nr(0);
-	if (btrfs_item_size(eb, item) != strlen(split3)) {
+	if (btrfs_item_size_nr(eb, 0) != strlen(split3)) {
 		test_err("invalid len in the first split");
 		ret = -EINVAL;
 		goto out;
@@ -171,8 +166,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	item = btrfs_item_nr(1);
-	if (btrfs_item_size(eb, item) != strlen(split4)) {
+	if (btrfs_item_size_nr(eb, 1) != strlen(split4)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
@@ -195,8 +189,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	item = btrfs_item_nr(2);
-	if (btrfs_item_size(eb, item) != strlen(split2)) {
+	if (btrfs_item_size_nr(eb, 2) != strlen(split2)) {
 		test_err("invalid len in the second split");
 		ret = -EINVAL;
 		goto out;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 2837b4c8424d..0f04bb7f3ce4 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -170,7 +170,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		const u16 old_data_len = btrfs_dir_data_len(leaf, di);
 		const u32 item_size = btrfs_item_size_nr(leaf, slot);
 		const u32 data_size = sizeof(*di) + name_len + size;
-		struct btrfs_item *item;
 		unsigned long data_ptr;
 		char *ptr;
 
@@ -196,9 +195,8 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 			btrfs_extend_item(path, data_size);
 		}
 
-		item = btrfs_item_nr(slot);
 		ptr = btrfs_item_ptr(leaf, slot, char);
-		ptr += btrfs_item_size(leaf, item) - data_size;
+		ptr += btrfs_item_size_nr(leaf, slot) - data_size;
 		di = (struct btrfs_dir_item *)ptr;
 		btrfs_set_dir_data_len(leaf, di, size);
 		data_ptr = ((unsigned long)(di + 1)) + name_len;
-- 
2.26.3

