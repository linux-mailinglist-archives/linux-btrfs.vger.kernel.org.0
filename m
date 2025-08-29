Return-Path: <linux-btrfs+bounces-16524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1612B3B62F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D81C8504C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DB278E7E;
	Fri, 29 Aug 2025 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKnUhUza"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486020A5EA
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457162; cv=none; b=CdWDRxpq731KBXyF3Rjkd6H8jMPRwmaMfT5y1eDbiVUvVO6QTOkKb9CgXHvUA4LARoSrWdMpJnlvW5MrPJVw/OgteZuMphiZ7RneDOjPqTuWOQakxjGtZKsxtloytuMC/4xXeF72pTW+trSOc2AgtGNBbA29Dl4dAMjxMBWDlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457162; c=relaxed/simple;
	bh=Jat+j6qh4PtdhcG05oONbIFBxcVZ9k23W7PQ5dpDQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLjZiCYXWFvF5lmBAY3/ICrJ6M9x4CInUC4ZKhxUv0+vQGATNNqE/oH1NIpxE83j0/82ArRDW5AYJylyrFVAqxV+Cv22PDL//CWsziBhPUkOKfASFqj59uJeqTIxWP2/UA2Zqpfn3KWvY9Nvl8vXWe8x/FdScUrEjZLXFrr+BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKnUhUza; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4b309dbc6c3so608101cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457158; x=1757061958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq7zLEUccrP86ptzE0CYOO5aSBXDkWUyQ9PgC/eoZT0=;
        b=VKnUhUzaG7xk3mtTctLDsAs83/wjkfjmEtgamPhg472XPpjr5P1XM6wagzEzOgx7xX
         AZNY/W9h+npu1gAh5wTKOroWZUHUGdrbfWcTbKaYbBdNPF4J6HtSh+W+AOODw3RtdqGY
         vY+wiscYwQHtamtzqd6SNbPdmYjgRegJ9kPA9vmuebUtFfGYiW8N5A4oTuybq9jkS6kp
         SK7jERLYx+n4KnClnVFpeybdikbN48q6HgSh57hYABehYIOT6mWEkk6ZkpYyoRzi1Qns
         ZD8qp3fiozKXJNjAFvVNeuP3bBpcrJCj0BAEn+HCz6U/dlLhBey6otzppYIcDrQPuH4i
         BhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457158; x=1757061958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cq7zLEUccrP86ptzE0CYOO5aSBXDkWUyQ9PgC/eoZT0=;
        b=SO1Yf7UAGi8xnEf9SF1x2HyooYLSnLE6w+0WGivbMQzP4CjmyYH2Z7A8CLFrWWo3Ri
         bOfQjiuoi5Avzry+MV0uRzusUoADT/+xprjZBHScBnomm5SblMmMZ8dfWxpuv4yu3SBF
         oYT34T6BwJnWYuarQaZB7v76yhl5MCJ7JiPwqt9VaDvRsQY0ZqKygOSqpt2KV8L9UN8m
         6L/7M7fqKGRAGqGqVYgVMyWZEs72/fk19RpbYB4cbB30DOlcZ3zF1VqIu0+mi+QVSZlY
         uwn+Lwni/uDSxF8goHD1GjilrSkoa15hxSjziSAEPwsUwz/1xFoSehhXd9j37FfssqyM
         1K+A==
X-Gm-Message-State: AOJu0YzWn56zKvtTh7pnKHURUbuW1rUITiQJJJ84y2R+CdIxde5YBH+h
	xis4+ASI9df+LxCss9czpo43qbxQZo067A44EMTmjN9ATbnSBCWb7UOv5snJMRpqIZ6E+g==
X-Gm-Gg: ASbGncth4cfKljG90bwMu+H9fZJ0pJGjGnbJHfVGc0wuhiRFKudjHK7QqtD73HG1GFj
	PGfkiUrfUZUbrHIIvOS3UTMQ9lVNUQcXYLP+HnwHTNhlJvVcaOdbgS34eeGi66eDP4aRvmxlZQ5
	xNYNZNsl5AmWgmx71cxuR4fY8JeVOY+3nD+hgPEkh2jeQHfh/iqQhtvTfyeD6LKASVrAj8REs4g
	jFasn5aIN3LbHlCtEtXUDVum4D983VcyPhU3RPesO1QF/57VHQw5Q5tYrMsHcwTStmzDHo2QU1+
	Ta5vhzvfRsrINw/TwR2brG3xtGqsIhu7ylP18x1S8XtJDpWVu3tnn9FHhxMEKyN/fQD0M2wEPcu
	/fsVe+JOCnQo0NrOAr9bAnrtrUeZVTok/
X-Google-Smtp-Source: AGHT+IH3iX+K0OiMBeKXVvC8/ns9QvKQXKGoUh9fkiTKB39wFkv059gomT6wd6qeZkFfkobDq7cguw==
X-Received: by 2002:a05:622a:1a1e:b0:4b3:45a:2b44 with SMTP id d75a77b69052e-4b313b8b15dmr3561491cf.0.1756457157834;
        Fri, 29 Aug 2025 01:45:57 -0700 (PDT)
Received: from SaltyKitkat ([104.28.205.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b535994sm11713751cf.5.2025.08.29.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:45:57 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.cz,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Fri, 29 Aug 2025 16:35:36 +0800
Message-ID: <20250829084533.17793-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trival pattern for the auto freeing with goto -> return conversions
if possible. No other function cleanup.

The following cases are considered trivial in this patch:
1. Cases where there are no operations between btrfs_free_path and the
function return.
2. Cases where only simple cleanup operations (such as kfree, kvfree,
clear_bit, and fs_path_free) are present between btrfs_free_path and the
function return.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>

---

Changelog:
v1 -> v3:
* Directly return 0 if info is NULL in send.c:get_inode_info()
* Limit the scope of the conversion to only what is described
  in the commit message.

---
 fs/btrfs/raid-stripe-tree.c |  15 +-
 fs/btrfs/ref-verify.c       |   3 +-
 fs/btrfs/reflink.c          |   3 +-
 fs/btrfs/relocation.c       |  47 ++----
 fs/btrfs/root-tree.c        |  52 +++---
 fs/btrfs/scrub.c            |  11 +-
 fs/btrfs/send.c             | 312 +++++++++++++-----------------------
 fs/btrfs/super.c            |   5 +-
 fs/btrfs/transaction.c      |   3 +-
 fs/btrfs/tree-log.c         | 107 +++++--------
 10 files changed, 200 insertions(+), 358 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index cab0b291088c..a69eaf0cef47 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -67,7 +67,7 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *stripe_root = fs_info->stripe_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	u64 found_start;
@@ -260,7 +260,6 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		btrfs_release_path(path);
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -269,7 +268,7 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 				   struct btrfs_stripe_extent *stripe_extent,
 				   const size_t item_size)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	int ret;
 	int slot;
@@ -288,7 +287,6 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer(leaf, stripe_extent, btrfs_item_ptr_offset(leaf, slot),
 			    item_size);
-	btrfs_free_path(path);
 
 	return ret;
 }
@@ -376,7 +374,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	struct btrfs_stripe_extent *stripe_extent;
 	struct btrfs_key stripe_key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	const u64 end = logical + *length;
 	int num_stripes;
@@ -402,7 +400,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
 	if (ret < 0)
-		goto free_path;
+		return ret;
 	if (ret) {
 		if (path->slots[0] != 0)
 			path->slots[0]--;
@@ -459,8 +457,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
 						   stripe->physical, devid);
 
-		ret = 0;
-		goto free_path;
+		return 0;
 	}
 
 	/* If we're here, we haven't found the requested devid in the stripe. */
@@ -474,8 +471,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 			  logical, logical + *length, stripe->dev->devid,
 			  btrfs_bg_type_to_raid_name(map_type));
 	}
-free_path:
-	btrfs_free_path(path);
 
 	return ret;
 }
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 3871c3a6c743..cba14eb75c0a 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -971,7 +971,7 @@ void btrfs_free_ref_tree_range(struct btrfs_fs_info *fs_info, u64 start,
 int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *extent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int tree_block_level = 0;
 	u64 bytenr = 0, num_bytes = 0;
@@ -1014,6 +1014,5 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
-	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index ce25ab7f0e99..98def02ce5cc 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -340,7 +340,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 destoff, int no_time_update)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_trans_handle *trans;
 	char *buf = NULL;
@@ -611,7 +611,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	}
 
 out:
-	btrfs_free_path(path);
 	kvfree(buf);
 	clear_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &BTRFS_I(inode)->runtime_flags);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7256f6748c8f..017f56bb5bcb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -821,7 +821,7 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 			    u64 bytenr, u64 num_bytes)
 {
 	struct btrfs_root *root = BTRFS_I(reloc_inode)->root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *leaf;
 	int ret;
@@ -834,11 +834,9 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	ret = btrfs_lookup_file_extent(NULL, root, path,
 			btrfs_ino(BTRFS_I(reloc_inode)), bytenr, 0);
 	if (ret < 0)
-		goto out;
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+		return ret;
+	if (ret > 0)
+		return -ENOENT;
 
 	leaf = path->nodes[0];
 	fi = btrfs_item_ptr(leaf, path->slots[0],
@@ -849,16 +847,11 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	       btrfs_file_extent_encryption(leaf, fi) ||
 	       btrfs_file_extent_other_encoding(leaf, fi));
 
-	if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi))
+		return -EINVAL;
 
 	*new_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -3158,7 +3151,7 @@ static int __add_tree_block(struct reloc_control *rc,
 			    struct rb_root *blocks)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret;
 	bool skinny = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
@@ -3186,7 +3179,7 @@ static int __add_tree_block(struct reloc_control *rc,
 	path->skip_locking = 1;
 	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret > 0 && skinny) {
 		if (path->slots[0]) {
@@ -3213,14 +3206,10 @@ static int __add_tree_block(struct reloc_control *rc,
 	     "tree block extent item (%llu) is not found in extent tree",
 		     bytenr);
 		WARN_ON(1);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = add_tree_block(rc, &key, path, blocks);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return add_tree_block(rc, &key, path, blocks);
 }
 
 static int delete_block_group_cache(struct btrfs_block_group *block_group,
@@ -3510,7 +3499,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct rb_root blocks = RB_ROOT;
 	struct btrfs_key key;
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_extent_item *ei;
 	u64 flags;
 	int ret;
@@ -3679,14 +3668,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	if (ret < 0 && !err)
 		err = ret;
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
-	btrfs_free_path(path);
 	return err;
 }
 
 static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root, u64 objectid)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
 	int ret;
@@ -3697,7 +3685,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_inode(trans, root, path, objectid);
 	if (ret)
-		goto out;
+		return ret;
 
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_inode_item);
@@ -3707,15 +3695,13 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
 	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
 					  BTRFS_INODE_PREALLOC);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static void delete_orphan_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root, u64 objectid)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret = 0;
 
@@ -3738,7 +3724,6 @@ static void delete_orphan_inode(struct btrfs_trans_handle *trans,
 out:
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
-	btrfs_free_path(path);
 }
 
 /*
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index e22e6b06927a..c7f7c55b7c28 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -143,7 +143,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret > 0) {
 		btrfs_crit(fs_info,
@@ -151,7 +151,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 			key->objectid, key->type, key->offset, btrfs_root_id(root));
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	l = path->nodes[0];
@@ -170,20 +170,20 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 				-1, 1);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 
 		ret = btrfs_del_item(trans, root, path);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		btrfs_release_path(path);
 		ret = btrfs_insert_empty_item(trans, root, path,
 				key, sizeof(*item));
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 		l = path->nodes[0];
 		slot = path->slots[0];
@@ -197,8 +197,6 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_root_generation_v2(item, btrfs_root_generation(item));
 
 	write_extent_buffer(l, item, ptr, sizeof(*item));
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -216,7 +214,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct extent_buffer *leaf;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root;
 	int err = 0;
@@ -309,7 +307,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(root);
 	}
 
-	btrfs_free_path(path);
 	return err;
 }
 
@@ -318,7 +315,7 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 		   const struct btrfs_key *key)
 {
 	struct btrfs_root *root = trans->fs_info->tree_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -326,17 +323,12 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
 	if (ret < 0)
-		goto out;
-	if (ret != 0) {
+		return ret;
+	if (ret > 0)
 		/* The root must exist but we did not find it by the key. */
-		ret = -EUCLEAN;
-		goto out;
-	}
+		return -EUCLEAN;
 
-	ret = btrfs_del_item(trans, root, path);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, root, path);
 }
 
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
@@ -344,7 +336,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       const struct fscrypt_str *name)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -361,7 +353,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0) {
-		goto out;
+		return ret;
 	} else if (ret == 0) {
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
@@ -369,18 +361,16 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		ptr = (unsigned long)(ref + 1);
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
 		    (btrfs_root_ref_name_len(leaf, ref) != name->len) ||
-		    memcmp_extent_buffer(leaf, name->name, ptr, name->len)) {
-			ret = -ENOENT;
-			goto out;
-		}
+		    memcmp_extent_buffer(leaf, name->name, ptr, name->len))
+			return -ENOENT;
+
 		*sequence = btrfs_root_ref_sequence(leaf, ref);
 
 		ret = btrfs_del_item(trans, tree_root, path);
 		if (ret)
-			goto out;
+			return ret;
 	} else {
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
@@ -391,8 +381,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		goto again;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -418,7 +406,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_key key;
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	unsigned long ptr;
@@ -435,7 +423,6 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 				      sizeof(*ref) + name->len);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_free_path(path);
 		return ret;
 	}
 
@@ -455,7 +442,6 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		goto again;
 	}
 
-	btrfs_free_path(path);
 	return 0;
 }
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d10..e23ce7887189 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -585,7 +585,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 				       bool is_super, u64 logical, u64 physical)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key found_key;
 	struct extent_buffer *eb;
 	struct btrfs_extent_item *ei;
@@ -612,7 +612,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	swarn.extent_item_size = found_key.offset;
 
@@ -658,9 +658,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
 	}
-
-out:
-	btrfs_free_path(path);
 }
 
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
@@ -2586,7 +2583,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
 {
 	struct btrfs_dev_extent *dev_extent = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 chunk_offset;
@@ -2872,8 +2869,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		btrfs_release_path(path);
 	}
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7664025a5af4..4041a4a228d7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -909,7 +909,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 			  struct btrfs_inode_info *info)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_inode_item *ii;
 	struct btrfs_key key;
 
@@ -924,11 +924,11 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		goto out;
+		return ret;
 	}
 
 	if (!info)
-		goto out;
+		return 0;
 
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			struct btrfs_inode_item);
@@ -945,9 +945,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
 	 */
 	info->fileattr = btrfs_inode_flags(path->nodes[0], ii);
 
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
@@ -979,7 +977,7 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	struct extent_buffer *eb = path->nodes[0];
 	struct btrfs_inode_ref *iref;
 	struct btrfs_inode_extref *extref;
-	struct btrfs_path *tmp_path;
+	BTRFS_PATH_AUTO_FREE(tmp_path);
 	struct fs_path *p;
 	u32 cur = 0;
 	u32 total;
@@ -1076,7 +1074,6 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 out:
-	btrfs_free_path(tmp_path);
 	fs_path_free(p);
 	return ret;
 }
@@ -1224,7 +1221,7 @@ static int get_inode_path(struct btrfs_root *root,
 {
 	int ret;
 	struct btrfs_key key, found_key;
-	struct btrfs_path *p;
+	BTRFS_PATH_AUTO_FREE(p);
 
 	p = alloc_path_for_send();
 	if (!p)
@@ -1238,28 +1235,21 @@ static int get_inode_path(struct btrfs_root *root,
 
 	ret = btrfs_search_slot_for_read(root, &key, p, 1, 0);
 	if (ret < 0)
-		goto out;
-	if (ret) {
-		ret = 1;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return 1;
+
 	btrfs_item_key_to_cpu(p->nodes[0], &found_key, p->slots[0]);
 	if (found_key.objectid != ino ||
 	    (found_key.type != BTRFS_INODE_REF_KEY &&
-	     found_key.type != BTRFS_INODE_EXTREF_KEY)) {
-		ret = -ENOENT;
-		goto out;
-	}
+	     found_key.type != BTRFS_INODE_EXTREF_KEY))
+		return -ENOENT;
 
 	ret = iterate_inode_ref(root, p, &found_key, 1,
 				__copy_first_ref, path);
 	if (ret < 0)
-		goto out;
-	ret = 0;
-
-out:
-	btrfs_free_path(p);
-	return ret;
+		return ret;
+	return 0;
 }
 
 struct backref_ctx {
@@ -1716,7 +1706,7 @@ static int read_symlink(struct btrfs_root *root,
 			struct fs_path *dest)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *ei;
 	u8 type;
@@ -1733,7 +1723,7 @@ static int read_symlink(struct btrfs_root *root,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret) {
 		/*
 		 * An empty symlink inode. Can happen in rare error paths when
@@ -1746,8 +1736,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_err(root->fs_info,
 			  "Found empty symlink inode %llu at root %llu",
 			  ino, btrfs_root_id(root));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -1758,7 +1747,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_crit(root->fs_info,
 "send: found symlink extent that is not inline, ino %llu root %llu extent type %d",
 			   ino, btrfs_root_id(root), type);
-		goto out;
+		return ret;
 	}
 	compression = btrfs_file_extent_compression(path->nodes[0], ei);
 	if (unlikely(compression != BTRFS_COMPRESS_NONE)) {
@@ -1766,17 +1755,13 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_crit(root->fs_info,
 "send: found symlink extent with compression, ino %llu root %llu compression type %d",
 			   ino, btrfs_root_id(root), compression);
-		goto out;
+		return ret;
 	}
 
 	off = btrfs_file_extent_inline_start(ei);
 	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
 
-	ret = fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
 }
 
 /*
@@ -1788,7 +1773,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 			   struct fs_path *dest)
 {
 	int ret = 0;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	char tmp[64];
 	int len;
@@ -1811,10 +1796,9 @@ static int gen_unique_name(struct send_ctx *sctx,
 				path, BTRFS_FIRST_FREE_OBJECTID,
 				&tmp_name, 0);
 		btrfs_release_path(path);
-		if (IS_ERR(di)) {
-			ret = PTR_ERR(di);
-			goto out;
-		}
+		if (IS_ERR(di))
+			return PTR_ERR(di);
+
 		if (di) {
 			/* not unique, try again */
 			idx++;
@@ -1831,10 +1815,9 @@ static int gen_unique_name(struct send_ctx *sctx,
 				path, BTRFS_FIRST_FREE_OBJECTID,
 				&tmp_name, 0);
 		btrfs_release_path(path);
-		if (IS_ERR(di)) {
-			ret = PTR_ERR(di);
-			goto out;
-		}
+		if (IS_ERR(di))
+			return PTR_ERR(di);
+
 		if (di) {
 			/* not unique, try again */
 			idx++;
@@ -1844,11 +1827,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 		break;
 	}
 
-	ret = fs_path_add(dest, tmp, len);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return fs_path_add(dest, tmp, len);
 }
 
 enum inode_state {
@@ -1960,7 +1939,7 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 	int ret = 0;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, name_len);
 
 	path = alloc_path_for_send();
@@ -1968,19 +1947,15 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(NULL, root, path, dir, &name_str, 0);
-	if (IS_ERR_OR_NULL(di)) {
-		ret = di ? PTR_ERR(di) : -ENOENT;
-		goto out;
-	}
+	if (IS_ERR_OR_NULL(di))
+		return di ? PTR_ERR(di) : -ENOENT;
+
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
-	if (key.type == BTRFS_ROOT_ITEM_KEY) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (key.type == BTRFS_ROOT_ITEM_KEY)
+		return -ENOENT;
+
 	*found_inode = key.objectid;
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1994,7 +1969,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int len;
 	u64 parent_dir;
 
@@ -2008,16 +1983,14 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 
 	ret = btrfs_search_slot_for_read(root, &key, path, 1, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (!ret)
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 				path->slots[0]);
 	if (ret || found_key.objectid != ino ||
 	    (found_key.type != BTRFS_INODE_REF_KEY &&
-	     found_key.type != BTRFS_INODE_EXTREF_KEY)) {
-		ret = -ENOENT;
-		goto out;
-	}
+	     found_key.type != BTRFS_INODE_EXTREF_KEY))
+		return -ENOENT;
 
 	if (found_key.type == BTRFS_INODE_REF_KEY) {
 		struct btrfs_inode_ref *iref;
@@ -2038,19 +2011,17 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 		parent_dir = btrfs_inode_extref_parent(path->nodes[0], extref);
 	}
 	if (ret < 0)
-		goto out;
+		return ret;
 	btrfs_release_path(path);
 
 	if (dir_gen) {
 		ret = get_inode_gen(root, parent_dir, dir_gen);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	*dir = parent_dir;
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2486,7 +2457,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	int ret;
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_root *parent_root = sctx->parent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
@@ -2498,10 +2469,8 @@ static int send_subvol_begin(struct send_ctx *sctx)
 		return -ENOMEM;
 
 	name = kmalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
-	if (!name) {
-		btrfs_free_path(path);
+	if (!name)
 		return -ENOMEM;
-	}
 
 	key.objectid = btrfs_root_id(send_root);
 	key.type = BTRFS_ROOT_BACKREF_KEY;
@@ -2564,7 +2533,6 @@ static int send_subvol_begin(struct send_ctx *sctx)
 
 tlv_put_failure:
 out:
-	btrfs_free_path(path);
 	kfree(name);
 	return ret;
 }
@@ -2715,7 +2683,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	int ret = 0;
 	struct fs_path *p = NULL;
 	struct btrfs_inode_item *ii;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	int slot;
@@ -2759,7 +2727,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 tlv_put_failure:
 out:
 	free_path_for_command(sctx, p);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2930,7 +2897,7 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 {
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_key di_key;
@@ -2970,7 +2937,6 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3750,7 +3716,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 				  struct recorded_ref *parent_ref,
 				  const bool is_orphan)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key di_key;
 	struct btrfs_dir_item *di;
@@ -3771,19 +3737,15 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	key.offset = btrfs_name_hash(parent_ref->name, parent_ref->name_len);
 
 	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret > 0) {
-		ret = 0;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
 
 	di = btrfs_match_dir_item_name(path, parent_ref->name,
 				       parent_ref->name_len);
-	if (!di) {
-		ret = 0;
-		goto out;
-	}
+	if (!di)
+		return 0;
 	/*
 	 * di_key.objectid has the number of the inode that has a dentry in the
 	 * parent directory with the same name that sctx->cur_ino is being
@@ -3793,26 +3755,22 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	 * that it happens after that other inode is renamed.
 	 */
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &di_key);
-	if (di_key.type != BTRFS_INODE_ITEM_KEY) {
-		ret = 0;
-		goto out;
-	}
+	if (di_key.type != BTRFS_INODE_ITEM_KEY)
+		return 0;
 
 	ret = get_inode_gen(sctx->parent_root, di_key.objectid, &left_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = get_inode_gen(sctx->send_root, di_key.objectid, &right_gen);
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			ret = 0;
-		goto out;
+		return ret;
 	}
 
 	/* Different inode, no need to delay the rename of sctx->cur_ino */
-	if (right_gen != left_gen) {
-		ret = 0;
-		goto out;
-	}
+	if (right_gen != left_gen)
+		return 0;
 
 	wdm = get_waiting_dir_move(sctx, di_key.objectid);
 	if (wdm && !wdm->orphanized) {
@@ -3826,8 +3784,6 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		if (!ret)
 			ret = 1;
 	}
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3877,7 +3833,7 @@ static int is_ancestor(struct btrfs_root *root,
 	bool free_fs_path = false;
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	if (!fs_path) {
@@ -3945,7 +3901,6 @@ static int is_ancestor(struct btrfs_root *root,
 		ret = iter_ret;
 
 out:
-	btrfs_free_path(path);
 	if (free_fs_path)
 		fs_path_free(fs_path);
 	return ret;
@@ -4803,7 +4758,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	iterate_inode_ref_t cb;
@@ -4822,8 +4777,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
 				"Wrong command %d in process_all_refs", cmd);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	key.objectid = sctx->cmp_key->objectid;
@@ -4837,13 +4791,12 @@ static int process_all_refs(struct send_ctx *sctx,
 
 		ret = iterate_inode_ref(root, path, &found_key, 0, cb, sctx);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 	/* Catch error found during iteration */
-	if (iter_ret < 0) {
-		ret = iter_ret;
-		goto out;
-	}
+	if (iter_ret < 0)
+		return iter_ret;
+
 	btrfs_release_path(path);
 
 	/*
@@ -4851,10 +4804,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	 * re-creating this inode and will be rename'ing it into place once we
 	 * rename the parent directory.
 	 */
-	ret = process_recorded_refs(sctx, &pending_move);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return process_recorded_refs(sctx, &pending_move);
 }
 
 static int send_set_xattr(struct send_ctx *sctx,
@@ -5080,7 +5030,7 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -5108,7 +5058,6 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5766,7 +5715,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
 	unsigned long data_ptr;
@@ -5804,7 +5753,6 @@ static int send_capabilities(struct send_ctx *sctx)
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5812,7 +5760,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		       struct clone_root *clone_root, const u64 disk_byte,
 		       u64 data_offset, u64 offset, u64 len)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret;
 	struct btrfs_inode_info info;
@@ -5848,7 +5796,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
 	btrfs_release_path(path);
 	if (ret < 0)
-		goto out;
+		return ret;
 	clone_src_i_size = info.size;
 
 	/*
@@ -5878,7 +5826,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	key.offset = clone_root->offset;
 	ret = btrfs_search_slot(NULL, clone_root->root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
 		if (key.objectid == clone_root->ino &&
@@ -5899,7 +5847,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(clone_root->root, path);
 			if (ret < 0)
-				goto out;
+				return ret;
 			else if (ret > 0)
 				break;
 			continue;
@@ -5936,7 +5884,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			ret = send_extent_data(sctx, dst_path, offset,
 					       hole_len);
 			if (ret < 0)
-				goto out;
+				return ret;
 
 			len -= hole_len;
 			if (len == 0)
@@ -6007,7 +5955,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 					ret = send_clone(sctx, offset, slen,
 							 clone_root);
 					if (ret < 0)
-						goto out;
+						return ret;
 				}
 				ret = send_extent_data(sctx, dst_path,
 						       offset + slen,
@@ -6041,7 +5989,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		}
 
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		len -= clone_len;
 		if (len == 0)
@@ -6072,8 +6020,6 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -6162,7 +6108,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_key found_key;
@@ -6188,10 +6134,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 	left_type = btrfs_file_extent_type(eb, ei);
 
-	if (left_type != BTRFS_FILE_EXTENT_REG) {
-		ret = 0;
-		goto out;
-	}
+	if (left_type != BTRFS_FILE_EXTENT_REG)
+		return 0;
+
 	left_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
 	left_len = btrfs_file_extent_num_bytes(eb, ei);
 	left_offset = btrfs_file_extent_offset(eb, ei);
@@ -6223,11 +6168,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	key.offset = ekey->offset;
 	ret = btrfs_search_slot_for_read(sctx->parent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
-	if (ret) {
-		ret = 0;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return 0;
 
 	/*
 	 * Handle special case where the right side has no extents at all.
@@ -6236,11 +6179,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	slot = path->slots[0];
 	btrfs_item_key_to_cpu(eb, &found_key, slot);
 	if (found_key.objectid != key.objectid ||
-	    found_key.type != key.type) {
+	    found_key.type != key.type)
 		/* If we're a hole then just pretend nothing changed */
-		ret = (left_disknr) ? 0 : 1;
-		goto out;
-	}
+		return (left_disknr) ? 0 : 1;
 
 	/*
 	 * We're now on 2a, 2b or 7.
@@ -6250,10 +6191,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		right_type = btrfs_file_extent_type(eb, ei);
 		if (right_type != BTRFS_FILE_EXTENT_REG &&
-		    right_type != BTRFS_FILE_EXTENT_INLINE) {
-			ret = 0;
-			goto out;
-		}
+		    right_type != BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 
 		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
 			right_len = btrfs_file_extent_ram_bytes(eb, ei);
@@ -6266,11 +6205,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 * Are we at extent 8? If yes, we know the extent is changed.
 		 * This may only happen on the first iteration.
 		 */
-		if (found_key.offset + right_len <= ekey->offset) {
+		if (found_key.offset + right_len <= ekey->offset)
 			/* If we're a hole just pretend nothing changed */
-			ret = (left_disknr) ? 0 : 1;
-			goto out;
-		}
+			return (left_disknr) ? 0 : 1;
 
 		/*
 		 * We just wanted to see if when we have an inline extent, what
@@ -6280,10 +6217,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 * compressed extent representing data with a size matching
 		 * the page size (currently the same as sector size).
 		 */
-		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
-			ret = 0;
-			goto out;
-		}
+		if (right_type == BTRFS_FILE_EXTENT_INLINE)
+			return 0;
 
 		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
 		right_offset = btrfs_file_extent_offset(eb, ei);
@@ -6303,17 +6238,15 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 */
 		if (left_disknr != right_disknr ||
 		    left_offset_fixed != right_offset ||
-		    left_gen != right_gen) {
-			ret = 0;
-			goto out;
-		}
+		    left_gen != right_gen)
+			return 0;
 
 		/*
 		 * Go to the next extent.
 		 */
 		ret = btrfs_next_item(sctx->parent_root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (!ret) {
 			eb = path->nodes[0];
 			slot = path->slots[0];
@@ -6324,10 +6257,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 			key.offset += right_len;
 			break;
 		}
-		if (found_key.offset != key.offset + right_len) {
-			ret = 0;
-			goto out;
-		}
+		if (found_key.offset != key.offset + right_len)
+			return 0;
+
 		key = found_key;
 	}
 
@@ -6340,15 +6272,12 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 	else
 		ret = 0;
 
-
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
 static int get_last_extent(struct send_ctx *sctx, u64 offset)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_key key;
 	int ret;
@@ -6364,15 +6293,13 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.offset = offset;
 	ret = btrfs_search_slot_for_read(root, &key, path, 0, 1);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = 0;
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	if (key.objectid != sctx->cur_ino || key.type != BTRFS_EXTENT_DATA_KEY)
-		goto out;
+		return ret;
 
 	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -6380,7 +6307,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 				   const u64 start,
 				   const u64 end)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = sctx->parent_root;
 	u64 search_start = start;
@@ -6395,7 +6322,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 	key.offset = search_start;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0)
 		path->slots[0]--;
 
@@ -6408,8 +6335,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -6431,15 +6358,11 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 			search_start = extent_end;
 			goto next;
 		}
-		ret = 0;
-		goto out;
+		return 0;
 next:
 		path->slots[0]++;
 	}
-	ret = 1;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 1;
 }
 
 static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
@@ -6547,7 +6470,7 @@ static int process_all_extents(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -6574,7 +6497,6 @@ static int process_all_extents(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7324,7 +7246,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -7341,7 +7263,7 @@ static int full_send_tree(struct send_ctx *sctx)
 
 	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret)
 		goto out_finish;
 
@@ -7351,7 +7273,7 @@ static int full_send_tree(struct send_ctx *sctx)
 		ret = changed_cb(path, NULL, &key,
 				 BTRFS_COMPARE_TREE_NEW, sctx);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		down_read(&fs_info->commit_root_sem);
 		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
@@ -7370,14 +7292,14 @@ static int full_send_tree(struct send_ctx *sctx)
 			btrfs_release_path(path);
 			ret = search_key_again(sctx, send_root, path, &key);
 			if (ret < 0)
-				goto out;
+				return ret;
 		} else {
 			up_read(&fs_info->commit_root_sem);
 		}
 
 		ret = btrfs_next_item(send_root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret) {
 			ret  = 0;
 			break;
@@ -7385,11 +7307,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	}
 
 out_finish:
-	ret = finish_inode_if_needed(sctx, 1);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return finish_inode_if_needed(sctx, 1);
 }
 
 static int replace_node_with_clone(struct btrfs_path *path, int level)
@@ -7644,8 +7562,8 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	struct btrfs_fs_info *fs_info = left_root->fs_info;
 	int ret;
 	int cmp;
-	struct btrfs_path *left_path = NULL;
-	struct btrfs_path *right_path = NULL;
+	BTRFS_PATH_AUTO_FREE(left_path);
+	BTRFS_PATH_AUTO_FREE(right_path);
 	struct btrfs_key left_key;
 	struct btrfs_key right_key;
 	char *tmp_buf = NULL;
@@ -7918,8 +7836,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 out_unlock:
 	up_read(&fs_info->commit_root_sem);
 out:
-	btrfs_free_path(left_path);
-	btrfs_free_path(right_path);
 	kvfree(tmp_buf);
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..a05128b0db31 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -912,7 +912,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_dir_item *di;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key location;
 	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 dir_id;
@@ -929,7 +929,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
 	if (IS_ERR(di)) {
-		btrfs_free_path(path);
 		return PTR_ERR(di);
 	}
 	if (!di) {
@@ -938,13 +937,11 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 		 * it's always been there, but don't freak out, just try and
 		 * mount the top-level subvolume.
 		 */
-		btrfs_free_path(path);
 		*objectid = BTRFS_FS_TREE_OBJECTID;
 		return 0;
 	}
 
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
-	btrfs_free_path(path);
 	*objectid = location.objectid;
 	return 0;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c5c0d9cf1a80..1fea2aa7f81e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1641,7 +1641,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	struct btrfs_root *parent_root;
 	struct btrfs_block_rsv *rsv;
 	struct btrfs_inode *parent_inode = pending->dir;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *dir_item;
 	struct extent_buffer *tmp;
 	struct extent_buffer *old;
@@ -1907,7 +1907,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 free_pending:
 	kfree(new_root_item);
 	pending->root_item = NULL;
-	btrfs_free_path(path);
 	pending->path = NULL;
 
 	return ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 69e11557fd13..5f9ec7fa8df4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1013,7 +1013,7 @@ static noinline int backref_in_log(struct btrfs_root *log,
 				   u64 ref_objectid,
 				   const struct fscrypt_str *name)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -1021,12 +1021,10 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
-	if (ret < 0) {
-		goto out;
-	} else if (ret == 1) {
-		ret = 0;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
 
 	if (key->type == BTRFS_INODE_EXTREF_KEY)
 		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
@@ -1035,8 +1033,6 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	else
 		ret = !!btrfs_find_name_in_backref(path->nodes[0],
 						   path->slots[0], name);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -1657,13 +1653,13 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	ret = count_inode_refs(inode, path);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	nlink = ret;
 
 	ret = count_inode_extrefs(inode, path);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	nlink += ret;
 
@@ -1673,7 +1669,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 		set_nlink(&inode->vfs_inode, nlink);
 		ret = btrfs_update_inode(trans, inode);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	if (S_ISDIR(inode->vfs_inode.i_mode))
 		inode->index_cnt = (u64)-1;
@@ -1682,15 +1678,13 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
 			ret = replay_dir_deletes(trans, root, NULL, path, ino, true);
 			if (ret)
-				goto out;
+				return ret;
 		}
 		ret = btrfs_insert_orphan_item(trans, root, ino);
 		if (ret == -EEXIST)
 			ret = 0;
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2041,7 +2035,7 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 	 * dentries that can never be deleted.
 	 */
 	if (ret == 1 && btrfs_dir_ftype(eb, di) != BTRFS_FT_DIR) {
-		struct btrfs_path *fixup_path;
+		BTRFS_PATH_AUTO_FREE(fixup_path);
 		struct btrfs_key di_key;
 
 		fixup_path = btrfs_alloc_path();
@@ -2050,7 +2044,6 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 		ret = link_to_fixup_dir(trans, root, fixup_path, di_key.objectid);
-		btrfs_free_path(fixup_path);
 	}
 
 	return ret;
@@ -2227,7 +2220,7 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 			      const u64 ino)
 {
 	struct btrfs_key search_key;
-	struct btrfs_path *log_path;
+	BTRFS_PATH_AUTO_FREE(log_path);
 	int i;
 	int nritems;
 	int ret;
@@ -2312,7 +2305,6 @@ static int replay_xattr_deletes(struct btrfs_trans_handle *trans,
 	else if (ret == 0)
 		goto process_leaf;
 out:
-	btrfs_free_path(log_path);
 	btrfs_release_path(path);
 	return ret;
 }
@@ -2443,7 +2435,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		.transid = gen,
 		.level = level
 	};
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = wc->replay_dest;
 	struct btrfs_key key;
 	int i;
@@ -2598,7 +2590,6 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 		 * older kernel with such keys, ignore them.
 		 */
 	}
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2768,7 +2759,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int wret;
 	int level;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int orig_level;
 
 	path = btrfs_alloc_path();
@@ -2785,18 +2776,14 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 		wret = walk_down_log_tree(trans, log, path, &level, wc);
 		if (wret > 0)
 			break;
-		if (wret < 0) {
-			ret = wret;
-			goto out;
-		}
+		if (wret < 0)
+			return wret;
 
 		wret = walk_up_log_tree(trans, log, path, &level, wc);
 		if (wret > 0)
 			break;
-		if (wret < 0) {
-			ret = wret;
-			goto out;
-		}
+		if (wret < 0)
+			return wret;
 	}
 
 	/* was the root node processed? if not, catch it here */
@@ -2805,13 +2792,11 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			 btrfs_header_generation(path->nodes[orig_level]),
 			 orig_level);
 		if (ret)
-			goto out;
+			return ret;
 		if (wc->free)
 			ret = clean_log_buffer(trans, path->nodes[orig_level]);
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3519,13 +3504,13 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  const struct fscrypt_str *name,
 				  struct btrfs_inode *dir, u64 index)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	ret = inode_logged(trans, dir, NULL);
 	if (ret == 0)
 		return;
-	else if (ret < 0) {
+	if (ret < 0) {
 		btrfs_set_log_full_commit(trans);
 		return;
 	}
@@ -3539,7 +3524,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	ret = join_running_log_trans(root);
 	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
 	if (WARN_ON(ret))
-		goto out;
+		return;
 
 	mutex_lock(&dir->log_mutex);
 
@@ -3549,8 +3534,6 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		btrfs_set_log_full_commit(trans);
 	btrfs_end_log_trans(root);
-out:
-	btrfs_free_path(path);
 }
 
 /* see comments for btrfs_del_dir_entries_in_log */
@@ -4829,7 +4812,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	const u64 i_size = i_size_read(&inode->vfs_inode);
 	const u64 ino = btrfs_ino(inode);
-	struct btrfs_path *dst_path = NULL;
+	BTRFS_PATH_AUTO_FREE(dst_path);
 	bool dropped_extents = false;
 	u64 truncate_offset = i_size;
 	struct extent_buffer *leaf;
@@ -4947,7 +4930,6 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				 start_slot, ins_nr, 1, 0, ctx);
 out:
 	btrfs_release_path(path);
-	btrfs_free_path(dst_path);
 	return ret;
 }
 
@@ -5320,7 +5302,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 					 u64 *other_ino, u64 *other_parent)
 {
 	int ret;
-	struct btrfs_path *search_path;
+	BTRFS_PATH_AUTO_FREE(search_path);
 	char *name = NULL;
 	u32 name_len = 0;
 	u32 item_size = btrfs_item_size(eb, slot);
@@ -5405,7 +5387,6 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	}
 	ret = 0;
 out:
-	btrfs_free_path(search_path);
 	kfree(name);
 	return ret;
 }
@@ -6788,7 +6769,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
@@ -6804,7 +6785,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
@@ -6816,8 +6797,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -6875,10 +6856,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			 * at both parents and the old parent B would still
 			 * exist.
 			 */
-			if (IS_ERR(dir_inode)) {
-				ret = PTR_ERR(dir_inode);
-				goto out;
-			}
+			if (IS_ERR(dir_inode))
+				return PTR_ERR(dir_inode);
 
 			if (!need_log_inode(trans, dir_inode)) {
 				btrfs_add_delayed_iput(dir_inode);
@@ -6891,14 +6870,11 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				ret = log_new_dir_dentries(trans, dir_inode, ctx);
 			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
-				goto out;
+				return ret;
 		}
 		path->slots[0]++;
 	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 static int log_new_ancestors(struct btrfs_trans_handle *trans,
@@ -7009,7 +6985,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret;
 
@@ -7030,7 +7006,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 again:
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret == 0)
 		path->slots[0]++;
 
@@ -7042,8 +7018,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-				goto out;
-			else if (ret > 0)
+				return ret;
+			if (ret > 0)
 				break;
 			continue;
 		}
@@ -7060,10 +7036,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 		 * this loop, etc). So just return some error to fallback to
 		 * a transaction commit.
 		 */
-		if (found_key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = -EMLINK;
-			goto out;
-		}
+		if (found_key.type == BTRFS_INODE_EXTREF_KEY)
+			return -EMLINK;
 
 		/*
 		 * Logging ancestors needs to do more searches on the fs/subvol
@@ -7075,14 +7049,11 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 
 		ret = log_new_ancestors(trans, root, path, ctx);
 		if (ret)
-			goto out;
+			return ret;
 		btrfs_release_path(path);
 		goto again;
 	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.50.1


