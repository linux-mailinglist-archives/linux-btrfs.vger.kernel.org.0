Return-Path: <linux-btrfs+bounces-15753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90778B16338
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6F3AAE2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BB2DAFD2;
	Wed, 30 Jul 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJTzNgXu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221512D9EEF
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887233; cv=none; b=HSbZ6ZY4rrqYVBhZeqNtEqYys+djbDmP1dGA0omyJqVs97T7XMvZ9Fn057Rv+flwdVMVlvJGdFt450DTXVh+Z3MnqE7zQtLNZGvwnoLa0vwmyNXl7cuqArT2znYZo5QJeSuXoxVv/1RCTVS5WzZQsbXdr0N/yQhLNfamDeiaOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887233; c=relaxed/simple;
	bh=ZdGyrctNmn5BQD5B4ESZ9rRaO8SxfwL0H9YdZJJW8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOhyogaSuN6ziIyNftAbAVz3QYDFYBR28dPM5Ls0Ze3QKe4Ui5duv890LscyN7DFwi6ui0fnfpLG8kpgMA7m8CQOzn215tNthe1SaXCj1DU0dGaBLn5PPxicz2Y0OtNB6dsmr+x98no1MJi8zue8TYvVvf5fOdYlNBxRaP7T+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJTzNgXu; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76ba6200813so83587b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753887230; x=1754492030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ7TZ6OcVkDXXUwTQSjpsbKalLLTmECG8HSs41d+vFQ=;
        b=dJTzNgXu+DYRYmb7pOSk83VvKeMrmXuZGuCBExEjymCJF0iU1AsEbnCjoOx/S0p2I2
         eHHIJ+2W31PIDwSiZFfRjS9EoCCCVU1EJByKR4+SF88/b3wLCucsBU0H6otXxo/cing7
         2R5ShKzANXRds7W9lZRhn9ekBD8ETJJYX9BUmGmLem1EvLSWBgCY04bvfBxF3YQNcM+T
         fDhZDJT+8H5EJWdwJWu0Ov1F7tLcKZJ94LE5R4OuHa+fMyiq4HeKOmrDrMsBUayMvCZH
         Jf7RVxjqAbPpL2d0q5izNLFm5ijOMmNQrML5ZpJekrko8qD9fRbDX9VcUlqQIcJJBniF
         PKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753887230; x=1754492030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ7TZ6OcVkDXXUwTQSjpsbKalLLTmECG8HSs41d+vFQ=;
        b=NO2DtX/VOQ5/4xWKXjvHwYH4k2CXyrvbtllf09KGVTiNI5qEtoJ/+W+VJo+5xxqJrb
         xivDyaz8SuezG8npeaj5bicV0cZ9H7Bd+qZQ6i1tvpLqIT3RwTMOHHmHnZWJ/Ef0m4GI
         rTJiLQpxzkroLbdzI2i4M+hRrHoV2dfqsnR1SZHys2udLtF4rgPv3UTOQ/TN1syou5ob
         IvhyEZfO5aWS8Y97ALaxpJi7fVDCkTDmQkP43f4aYhCHyrBVNkIoQLhOGqmDMKpQWQEn
         3B2eI2ouY3ISXDujEAfRAQSSgt1x8gyCIBD1yQc8eQltSDdt4txt42d0S3wp7jcmQfEy
         nP/w==
X-Gm-Message-State: AOJu0YwhZDtDpIMQbuodjgH45aOjr8zINywmaUdowXCvyw0T5sZ/oCop
	g3yMDBnqdocZlfTGcu6A0LZUwvCWBk7xX50r7rrrZjisPZze+pBwQdJwZr3YLsQTkSlSqw==
X-Gm-Gg: ASbGncuoCfMUzb9YUpoadEy1YnJeXXT9M504eeLyeVFoRRZCu7DKEuU+fmTP3Fbo50S
	z45QHgOGpJeAxFkIKCycbTQU50mkNGeMWPAvCi9DSUZ0r6Okl2mlGtHZcDiYYNLRwPMiQlfwXiv
	HdyjAnai2cU3+LqYF2BayrLTVkHyUHF+5DJTE1qO+8P8ODMGRR9ERNmwhHgrAMBZVNwkjkywxcX
	RlGT//PKqX7eJVtqKUdHqJs072D4C9cY2cOX9LDG20Zm+oQFmUG6QJ7NQ3wlaokdOafiNfj88dv
	iMBhrZEoKsC6slSQAGthjNajzEKHjSSDKNR1wMOcYU9LSFEZJsdZd6iHpJ7Nel++XzYBn8vTGm4
	FTP+H4ZMLWVKU3bT9FhYclaz9/bhY
X-Google-Smtp-Source: AGHT+IHNDfSGyyforgZqKyHKlZ5qH9xWHgN8F8Ojs3OY29W3OjrMHuWQSCkjMGn0dmews/dgQMqc1Q==
X-Received: by 2002:a05:6a00:2e0d:b0:730:915c:b77 with SMTP id d2e1a72fcca58-76ab10172fdmr2403021b3a.1.1753887230157;
        Wed, 30 Jul 2025 07:53:50 -0700 (PDT)
Received: from SaltyKitkat ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02206sm10960778b3a.32.2025.07.30.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:53:49 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: 
Cc: linux-btrfs@vger.kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: replace manual next item search with btrfs_get_next_valid_item()
Date: Wed, 30 Jul 2025 22:53:08 +0800
Message-ID: <20250730145327.22373-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function btrfs_get_next_valid_item() was introduced in
commit 62142be363ae9("btrfs: introduce btrfs_for_each_slot iterator macro")
and has never been used in other places other than
the btrfs_for_each_slot macro.

However, in multiple locations, we implement the same pattern
for advancing to the next valid item in a btrfs path:
1. Increment path->slots[0]
2. Check if beyond last item in leaf
3. If so, call btrfs_next_leaf()
4. Check return value and handle errors
5. Update the key

This pattern can be replaced by the helper function
btrfs_get_next_valid_item() which encapsulates step 2-5.
The change simplifies the code by:
* Reducing code duplication
* Making control flow easier to follow
* Centralizing error handling logic
* Improving maintainability

The functionality remains identical as the helper implements the exact
same logic sequence.

There are still some places that have a similar pattern
but with more complex logic. These parts are left untouched.
One example: in file.c: btrfs_drop_extents(), the pattern after
the label next_slot is left untouched.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/disk-io.c    |  15 +++---
 fs/btrfs/file-item.c  |  28 ++++-------
 fs/btrfs/file.c       |  18 +++-----
 fs/btrfs/inode.c      |  31 +++++--------
 fs/btrfs/ioctl.c      |  49 ++++++++++----------
 fs/btrfs/props.c      |  15 ++----
 fs/btrfs/reflink.c    |  16 ++-----
 fs/btrfs/relocation.c |  12 ++---
 fs/btrfs/send.c       |  40 ++++++++--------
 fs/btrfs/tree-log.c   | 105 +++++++++++++++---------------------------
 fs/btrfs/verity.c     |  21 +++------
 fs/btrfs/volumes.c    |  15 ++----
 fs/btrfs/zoned.c      |  15 +++---
 13 files changed, 145 insertions(+), 235 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70fc4e7cc5a0..69f5af9d5e92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2130,17 +2130,14 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		if (ret < 0)
 			break;
 
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(tree_root, path);
-			if (ret) {
-				if (ret > 0)
-					ret = 0;
-				break;
-			}
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret > 0) {
+			ret = 0;
+			break;
 		}
-		ret = 0;
+		if (ret < 0)
+			break;
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (key.objectid != objectid)
 			break;
 		btrfs_release_path(path);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c09fbc257634..4612eecade52 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -517,17 +517,13 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 	while (start <= end) {
 		u64 csum_end;
 
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
 		leaf = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			if (ret > 0)
-				break;
-			leaf = path->nodes[0];
-		}
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
 		    key.type != BTRFS_EXTENT_CSUM_KEY ||
 		    key.offset > end)
@@ -674,17 +670,13 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 	while (start <= end) {
 		u64 csum_end;
 
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto fail;
+		if (ret > 0)
+			break;
 		leaf = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto fail;
-			if (ret > 0)
-				break;
-			leaf = path->nodes[0];
-		}
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
 		    key.type != BTRFS_EXTENT_CSUM_KEY ||
 		    key.offset > end)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 204674934795..24eb3285c01f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3623,22 +3623,18 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	}
 
 	while (start < i_size) {
-		struct extent_buffer *leaf = path->nodes[0];
+		struct extent_buffer *leaf;
 		struct btrfs_file_extent_item *extent;
 		u64 extent_end;
 		u8 type;
 
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-
-			leaf = path->nodes[0];
-		}
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
+		leaf = path->nodes[0];
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b77dd22b8cdb..92531693a627 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2089,17 +2089,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		check_prev = false;
 next_slot:
 		/* Go to next leaf if we have exhausted the current one */
+		ret = btrfs_get_next_valid_item(root, &found_key, path);
+		if (ret < 0)
+			goto error;
+		if (ret > 0)
+			break;
 		leaf = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto error;
-			if (ret > 0)
-				break;
-			leaf = path->nodes[0];
-		}
-
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 
 		/* Didn't find anything for our INO */
 		if (found_key.objectid > ino)
@@ -7074,16 +7069,14 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 next:
 	if (start >= extent_end) {
 		path->slots[0]++;
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				goto not_found;
+		ret = btrfs_get_next_valid_item(root, &found_key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			goto not_found;
+
+		leaf = path->nodes[0];
 
-			leaf = path->nodes[0];
-		}
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		if (found_key.objectid != objectid ||
 		    found_key.type != BTRFS_EXTENT_DATA_KEY)
 			goto not_found;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e13de2bdcbf..e0a27fd66853 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2126,22 +2126,20 @@ static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = 0;
 		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
-		if (ret < 0) {
+		if (ret < 0)
+			goto out;
+
+		ret = btrfs_get_next_valid_item(fs_info->tree_root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = -EUCLEAN;
 			goto out;
-		} else if (path->slots[0] >=
-			   btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(fs_info->tree_root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = -EUCLEAN;
-				goto out;
-			}
 		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		btrfs_item_key_to_cpu(leaf, &key, slot);
+
 		if (key.objectid == subvol_info->treeid &&
 		    key.type == BTRFS_ROOT_BACKREF_KEY) {
 			subvol_info->parent_id = key.offset;
@@ -2209,23 +2207,20 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 
 	root = root->fs_info->tree_root;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0) {
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_get_next_valid_item(root, &key, path);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = -EUCLEAN;
 		goto out;
-	} else if (path->slots[0] >=
-		   btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_leaf(root, path);
-		if (ret < 0) {
-			goto out;
-		} else if (ret > 0) {
-			ret = -EUCLEAN;
-			goto out;
-		}
 	}
-	while (1) {
-		leaf = path->nodes[0];
-		slot = path->slots[0];
+	leaf = path->nodes[0];
+	slot = path->slots[0];
 
-		btrfs_item_key_to_cpu(leaf, &key, slot);
+	while (1) {
 		if (key.objectid != objectid || key.type != BTRFS_ROOT_REF_KEY) {
 			ret = 0;
 			goto out;
@@ -2249,6 +2244,10 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 			ret = -EUCLEAN;
 			goto out;
 		}
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
 	}
 
 out:
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index adc956432d2f..79b4ab5f51f7 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -166,19 +166,14 @@ static int iterate_object_props(struct btrfs_root *root,
 		int slot;
 		const struct hlist_head *handlers;
 
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		else if (ret > 0)
+			break;
 		slot = path->slots[0];
 		leaf = path->nodes[0];
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
 		if (key.objectid != objectid)
 			break;
 		if (key.type != BTRFS_XATTR_ITEM_KEY)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ce25ab7f0e99..c70940c15d6b 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -345,7 +345,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	struct btrfs_trans_handle *trans;
 	char *buf = NULL;
 	struct btrfs_key key;
-	u32 nritems;
 	int slot;
 	int ret;
 	const u64 len = olen_aligned;
@@ -397,20 +396,15 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 				path->slots[0]--;
 		}
 
-		nritems = btrfs_header_nritems(path->nodes[0]);
 process_slot:
-		if (path->slots[0] >= nritems) {
-			ret = btrfs_next_leaf(BTRFS_I(src)->root, path);
-			if (ret < 0)
-				goto out;
-			if (ret > 0)
-				break;
-			nritems = btrfs_header_nritems(path->nodes[0]);
-		}
+		ret = btrfs_get_next_valid_item(BTRFS_I(src)->root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 
-		btrfs_item_key_to_cpu(leaf, &key, slot);
 		if (key.type > BTRFS_EXTENT_DATA_KEY ||
 		    key.objectid != btrfs_ino(BTRFS_I(src)))
 			break;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e58151933844..85af65a794c6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3342,7 +3342,6 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct btrfs_key key;
-	struct extent_buffer *leaf;
 	u64 start, end, last;
 	int ret;
 
@@ -3367,15 +3366,10 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 		if (ret < 0)
 			break;
 next:
-		leaf = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(rc->extent_root, path);
-			if (ret != 0)
-				break;
-			leaf = path->nodes[0];
-		}
+		ret = btrfs_get_next_valid_item(rc->extent_root, &key, path);
+		if (ret != 0)
+			break;
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid >= last) {
 			ret = 1;
 			break;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7664025a5af4..3c17f3b0794c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5887,8 +5887,8 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	}
 
 	while (true) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		struct extent_buffer *leaf;
+		int slot;
 		struct btrfs_file_extent_item *ei;
 		u8 type;
 		u64 ext_len;
@@ -5896,16 +5896,14 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		u64 clone_data_offset;
 		bool crossed_src_i_size = false;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(clone_root->root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
+		ret = btrfs_get_next_valid_item(clone_root->root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
 
-		btrfs_item_key_to_cpu(leaf, &key, slot);
+		leaf = path->nodes[0];
+		slot = path->slots[0];
 
 		/*
 		 * We might have an implicit trailing hole (NO_HOLES feature
@@ -6400,21 +6398,19 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		path->slots[0]--;
 
 	while (search_start < end) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		struct extent_buffer *leaf;
+		int slot;
 		struct btrfs_file_extent_item *fi;
 		u64 extent_end;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
 
-		btrfs_item_key_to_cpu(leaf, &key, slot);
+		leaf = path->nodes[0];
+		slot = path->slots[0];
 		if (key.objectid < sctx->cur_ino ||
 		    key.type < BTRFS_EXTENT_DATA_KEY)
 			goto next;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9f05d454b9df..d107c4f8bd4b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2077,7 +2077,6 @@ static noinline int find_dir_range(struct btrfs_root *root,
 	u64 found_end;
 	struct btrfs_dir_log_item *item;
 	int ret;
-	int nritems;
 
 	if (*start_ret == (u64)-1)
 		return 1;
@@ -2114,15 +2113,10 @@ static noinline int find_dir_range(struct btrfs_root *root,
 	ret = 1;
 next:
 	/* check the next slot in the tree to see if it is a valid item */
-	nritems = btrfs_header_nritems(path->nodes[0]);
 	path->slots[0]++;
-	if (path->slots[0] >= nritems) {
-		ret = btrfs_next_leaf(root, path);
-		if (ret)
-			goto out;
-	}
-
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ret = btrfs_get_next_valid_item(root, &key, path);
+	if (ret)
+		goto out;
 
 	if (key.type != BTRFS_DIR_LOG_INDEX_KEY || key.objectid != dirid) {
 		ret = 1;
@@ -2378,22 +2372,17 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 
 		dir_key.offset = range_start;
 		while (1) {
-			int nritems;
 			ret = btrfs_search_slot(NULL, root, &dir_key, path,
 						0, 0);
 			if (ret < 0)
 				goto out;
 
-			nritems = btrfs_header_nritems(path->nodes[0]);
-			if (path->slots[0] >= nritems) {
-				ret = btrfs_next_leaf(root, path);
-				if (ret == 1)
-					break;
-				else if (ret < 0)
-					goto out;
-			}
-			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-					      path->slots[0]);
+			ret = btrfs_get_next_valid_item(root, &found_key, path);
+			if (ret > 0)
+				break;
+			if (ret < 0)
+				goto out;
+
 			if (found_key.objectid != dirid ||
 			    found_key.type != dir_key.type) {
 				ret = 0;
@@ -5197,20 +5186,14 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		return ret;
 
 	while (true) {
-		struct extent_buffer *leaf = path->nodes[0];
-
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				return ret;
-			if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			leaf = path->nodes[0];
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			return ret;
+		if (ret > 0) {
+			ret = 0;
+			break;
 		}
 
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
@@ -5242,7 +5225,6 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 				return ret;
 			if (WARN_ON(ret > 0))
 				return -ENOENT;
-			leaf = path->nodes[0];
 		}
 
 		prev_extent_end = btrfs_file_extent_end(path);
@@ -6800,22 +6782,21 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		goto out;
 
 	while (true) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		struct extent_buffer *leaf;
+		int slot;
 		u32 cur_offset = 0;
 		u32 item_size;
 		unsigned long ptr;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
+
+		leaf = path->nodes[0];
+		slot = path->slots[0];
 
-		btrfs_item_key_to_cpu(leaf, &key, slot);
 		/* BTRFS_INODE_EXTREF_KEY is BTRFS_INODE_REF_KEY + 1 */
 		if (key.objectid != ino || key.type > BTRFS_INODE_EXTREF_KEY)
 			break;
@@ -6904,8 +6885,6 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
 
 	while (true) {
-		struct extent_buffer *leaf;
-		int slot;
 		struct btrfs_key search_key;
 		struct btrfs_inode *inode;
 		u64 ino;
@@ -6937,19 +6916,12 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (ret < 0)
 			return ret;
 
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				return ret;
-			else if (ret > 0)
-				return -ENOENT;
-			leaf = path->nodes[0];
-			slot = path->slots[0];
-		}
+		ret = btrfs_get_next_valid_item(root, &found_key, path);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			return -ENOENT;
 
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 		if (found_key.objectid != search_key.objectid ||
 		    found_key.type != BTRFS_INODE_REF_KEY)
 			return -ENOENT;
@@ -7028,20 +7000,15 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 		path->slots[0]++;
 
 	while (true) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
 		struct btrfs_key found_key;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
+		ret = btrfs_get_next_valid_item(root, &found_key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
+
 
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 		if (found_key.objectid != ino ||
 		    found_key.type > BTRFS_INODE_EXTREF_KEY)
 			break;
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487..f517d1f7a1da 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -332,8 +332,14 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 	}
 
 	while (len > 0) {
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
 		leaf = path->nodes[0];
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 		if (key.objectid != btrfs_ino(inode) || key.type != key_type)
 			break;
@@ -389,19 +395,6 @@ static int read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		copied += copy_bytes;
 
 		path->slots[0]++;
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			/*
-			 * We've reached the last slot in this leaf and we need
-			 * to go to the next leaf.
-			 */
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				break;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-		}
 	}
 out:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa7a929a0461..70e73cbf6b16 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1723,18 +1723,13 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 		goto out;
 
 	while (search_start < search_end) {
+		ret = btrfs_get_next_valid_item(root, &key, path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			break;
 		l = path->nodes[0];
 		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(l)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret == 0)
-				continue;
-			if (ret < 0)
-				goto out;
-
-			break;
-		}
-		btrfs_item_key_to_cpu(l, &key, slot);
 
 		if (key.objectid < device->devid)
 			goto next;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..8fe5b7e362c0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -306,14 +306,13 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 	if (ret < 0)
 		return ret;
 
-	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_leaf(root, path);
-		if (ret < 0)
-			return ret;
-		/* No dev extents at all? Not good */
-		if (ret > 0)
-			return -EUCLEAN;
-	}
+	ret = btrfs_get_next_valid_item(root, &key, path);
+	if (ret < 0)
+		return ret;
+	/* No dev extents at all? Not good */
+	if (ret > 0)
+		return -EUCLEAN;
+
 
 	leaf = path->nodes[0];
 	dext = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);
-- 
2.50.1


