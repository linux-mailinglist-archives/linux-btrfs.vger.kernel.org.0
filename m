Return-Path: <linux-btrfs+bounces-17081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1AB906FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 13:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8364A3B67D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB6305E33;
	Mon, 22 Sep 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKe55hJ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4E302CA6
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541017; cv=none; b=VG24v7iCE0un75M7y2tJgYEag3mQcLIgmB7f0+LczKnStSiWyOxJ85l4vZ1NOznLXNqosAuze+XN6geAB5dcVG9RDnzM9zK3PhB8Eb1p0Sl3Vx8L95+pTw/zlKfHy409mn9dTtnsA9RVLYI2cLvjRuDJVpbxY252F2ood+YIqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541017; c=relaxed/simple;
	bh=kVXyIeB79vzMsZclycJS9IhC7A8zZeVzGTWgul9E8NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJkME5pPPThtaSxl/gq6zoDmfoVj/ej3OBAQnEV512ypwPl7Ucgph5FZZCrEhVof9gqzj7gMu0zsiB/qX4mFyCpH5DujT4vXrhOhvihmP+7T6yvvtCddkqXV0Cv9cvKKUKfAVGdSkra4FRDjLdIDXv7hhybN5odCMmHAbvQ3YGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKe55hJ/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2698d47e6e7so9603185ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758541014; x=1759145814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2GsO7NZI/NeEsRDInypM6TYhAWV0IyZoLkArMw/CCg=;
        b=JKe55hJ/jdapbZFOrD1r18K7c3kWjB/hm8QS5FnvmvqmhvL/CL9XDYgVYfKHptFZmg
         +JgS0upJhGGv/uMw7ugjAhzM2y/qDHdK7txM7bAWZ14uKSf/BhOGAbXD07N1CAs1cpU9
         oQalEBSPlTji7+b5DvyQ7eqTb2K+g9rcx7PWJgleFR8g2Gp+lsyjPOnUJ1dBugTeXhcP
         pysJQne2Zwx/90cJbEGKDLD0WuwK1x8j9Y1dqbTQQQFQZafrwV9h0rTng/8GXoyuRjuh
         Q64SjWbSbBDfChxdHyuRJjz9yIpZBJ93grWPXK9EDnM1/me7H2O+m19bhOhvZp6wAAsf
         4lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541014; x=1759145814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2GsO7NZI/NeEsRDInypM6TYhAWV0IyZoLkArMw/CCg=;
        b=qFFsIDokvwNvjssp+/+cbEIHNkQpeLXryF9xwCSNE+vZe0OdQpK7NrKJ9Q7QE4rWvV
         hvKpKB1uqyXSNxWyVEwq5PWLu7XvEg2+0GhQE7KmXPPlPAlmBqTacFWNAVHiiPAMlZO+
         fYxvXmzgvRTp5yoZ/tsHyBzIdU2jjgp+D+bqFJtxYbJSwJbreRPb9rKDZf4w38f+FSXs
         PzCKIzbTZNgZScJOTz5pKcDhNF2jjEZneFBDAGzMiEcPRADTHyR8bw8LmybfT5U1SQdB
         Q5p0cBsCI/CH9+L1Z/Lc5ExhPlvRZjcODkAmkMGM1WTtYyJEx8rgS8KvZ0t5fValQERc
         MRYw==
X-Gm-Message-State: AOJu0YyzUbkVDUP+smBHP5/63rddfkyiesLS/PSEJEqSutEyJu8oc0yW
	vKqLkHcDRMh1hSH1oe+tYdpZ4L7s5mfQZxdDBnAGPBS0Pem5lF6Il+DFS/jl5XQW9zYSxQ==
X-Gm-Gg: ASbGncuqOOQaTsm8pnMQLZUM6+Z4emGMse4mp+yR1q0jraF7lVwbkEXUQU6bxbdSWOm
	Nc5B3o5kTvWy+sz60cjtHZbBZo/7dUe+mzbfLCxbB1HltK/VGwnaCU4UDUeeG2l/K/UwyzuIUQ2
	8n4F9OTPV1s5hrhEnHUPyn7pdTr2eV31zSeuSNop5Vx4WyzUGUDviUXVaj39jnE6gmF7n31XGXW
	sqBO6SGI6ZtmgQyz1pJYJ6Dzb7J/3+61jChST+xHMOsxOotW1nnj478UAIXwSXMYlyc/obJ5akk
	TYJ5PgDxOaJ8DozhtpqpRaoaqB+Ag+sFx4G0V3QpNZZahBK55tGohp30SNOjkiwCn3ytZfm9d7d
	zMOiaEodEipXlEAEJ3P4oqg==
X-Google-Smtp-Source: AGHT+IF9b5/pvl1hXSXGrvjTRAXmydpchsNabAsNml8PVqCg7FprJLyiZmX/SE4bLQvTCSk+nXlxAw==
X-Received: by 2002:a17:902:da8f:b0:24e:af92:70de with SMTP id d9443c01a7336-269ba5049dbmr110490875ad.7.1758541013635;
        Mon, 22 Sep 2025 04:36:53 -0700 (PDT)
Received: from SaltyKitkat ([152.69.226.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016da85sm129214735ad.50.2025.09.22.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:36:53 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v4] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Mon, 22 Sep 2025 19:30:07 +0800
Message-ID: <20250922113310.29724-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial pattern for the auto freeing with goto -> return conversions
if possible. No other function cleanup.

The following cases are considered trivial in this patch:

1. Cases where there are no operations between btrfs_free_path() and the
   function return.
2. Cases where only simple cleanup operations (such as kfree(), kvfree(),
   clear_bit(), and fs_path_free()) are present between
   btrfs_free_path() and the function return.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>

---

Changelog:
v1 -> v3:
* Directly return 0 if info is NULL in send.c:get_inode_info()
* Limit the scope of the conversion to only what is described
  in the commit message.

v3 -> v4:
* Fix missing conversions of BTRFS_PATH_AUTO_FREE
  and tested with btrfs/quick group in xfstests

---
 fs/btrfs/raid-stripe-tree.c |  15 +-
 fs/btrfs/ref-verify.c       |   3 +-
 fs/btrfs/reflink.c          |   3 +-
 fs/btrfs/relocation.c       |  47 ++----
 fs/btrfs/root-tree.c        |  54 +++----
 fs/btrfs/scrub.c            |  11 +-
 fs/btrfs/send.c             | 314 +++++++++++++-----------------------
 fs/btrfs/super.c            |   5 +-
 fs/btrfs/transaction.c      |   3 +-
 fs/btrfs/tree-log.c         |  91 ++++-------
 10 files changed, 195 insertions(+), 351 deletions(-)

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
index 9f1858b42c0e..de4cb0f3fbd0 100644
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
@@ -1021,6 +1021,5 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
-	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 0a85e1da9777..f78ac494197f 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -340,7 +340,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 destoff, bool no_time_update)
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
index 8bd97b24f375..7a90a4ef8375 100644
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
index e22e6b06927a..d1f5f6c42ef3 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -130,7 +130,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *item)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *l;
 	int ret;
 	int slot;
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
index ce28dcb60f78..e19e6bc5f074 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -588,7 +588,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 				       bool is_super, u64 logical, u64 physical)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key found_key;
 	struct extent_buffer *eb;
 	struct btrfs_extent_item *ei;
@@ -615,7 +615,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	ret = extent_from_logical(fs_info, swarn.logical, path, &found_key,
 				  &flags);
 	if (ret < 0)
-		goto out;
+		return;
 
 	swarn.extent_item_size = found_key.offset;
 
@@ -661,9 +661,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
 	}
-
-out:
-	btrfs_free_path(path);
 }
 
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
@@ -2606,7 +2603,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
 {
 	struct btrfs_dev_extent *dev_extent = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 chunk_offset;
@@ -2892,8 +2889,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		btrfs_release_path(path);
 	}
 
-	btrfs_free_path(path);
-
 	return ret;
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5e073502b9e8..8ace5408d858 100644
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
@@ -1238,27 +1235,20 @@ static int get_inode_path(struct btrfs_root *root,
 
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
 
 	ret = iterate_inode_ref(root, p, &found_key, true, __copy_first_ref, path);
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
@@ -1715,7 +1705,7 @@ static int read_symlink(struct btrfs_root *root,
 			struct fs_path *dest)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *ei;
 	u8 type;
@@ -1732,7 +1722,7 @@ static int read_symlink(struct btrfs_root *root,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret) {
 		/*
 		 * An empty symlink inode. Can happen in rare error paths when
@@ -1745,8 +1735,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_err(root->fs_info,
 			  "Found empty symlink inode %llu at root %llu",
 			  ino, btrfs_root_id(root));
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -1757,7 +1746,7 @@ static int read_symlink(struct btrfs_root *root,
 		btrfs_crit(root->fs_info,
 "send: found symlink extent that is not inline, ino %llu root %llu extent type %d",
 			   ino, btrfs_root_id(root), type);
-		goto out;
+		return ret;
 	}
 	compression = btrfs_file_extent_compression(path->nodes[0], ei);
 	if (unlikely(compression != BTRFS_COMPRESS_NONE)) {
@@ -1765,17 +1754,13 @@ static int read_symlink(struct btrfs_root *root,
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
@@ -1786,8 +1771,7 @@ static int gen_unique_name(struct send_ctx *sctx,
 			   u64 ino, u64 gen,
 			   struct fs_path *dest)
 {
-	int ret = 0;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	char tmp[64];
 	int len;
@@ -1810,10 +1794,9 @@ static int gen_unique_name(struct send_ctx *sctx,
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
@@ -1822,7 +1805,6 @@ static int gen_unique_name(struct send_ctx *sctx,
 
 		if (!sctx->parent_root) {
 			/* unique */
-			ret = 0;
 			break;
 		}
 
@@ -1830,10 +1812,9 @@ static int gen_unique_name(struct send_ctx *sctx,
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
@@ -1843,11 +1824,7 @@ static int gen_unique_name(struct send_ctx *sctx,
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
@@ -1959,7 +1936,7 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 	int ret = 0;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct fscrypt_str name_str = FSTR_INIT((char *)name, name_len);
 
 	path = alloc_path_for_send();
@@ -1967,19 +1944,15 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
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
 
@@ -1993,7 +1966,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int len;
 	u64 parent_dir;
 
@@ -2007,16 +1980,14 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 
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
@@ -2037,19 +2008,17 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
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
 
@@ -2485,7 +2454,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	int ret;
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_root *parent_root = sctx->parent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
@@ -2497,10 +2466,8 @@ static int send_subvol_begin(struct send_ctx *sctx)
 		return -ENOMEM;
 
 	name = kmalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
-	if (!name) {
-		btrfs_free_path(path);
+	if (!name)
 		return -ENOMEM;
-	}
 
 	key.objectid = btrfs_root_id(send_root);
 	key.type = BTRFS_ROOT_BACKREF_KEY;
@@ -2563,7 +2530,6 @@ static int send_subvol_begin(struct send_ctx *sctx)
 
 tlv_put_failure:
 out:
-	btrfs_free_path(path);
 	kfree(name);
 	return ret;
 }
@@ -2714,7 +2680,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	int ret = 0;
 	struct fs_path *p = NULL;
 	struct btrfs_inode_item *ii;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	int slot;
@@ -2758,7 +2724,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 tlv_put_failure:
 out:
 	free_path_for_command(sctx, p);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2929,7 +2894,7 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 {
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_key di_key;
@@ -2969,7 +2934,6 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3749,7 +3713,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 				  struct recorded_ref *parent_ref,
 				  const bool is_orphan)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key di_key;
 	struct btrfs_dir_item *di;
@@ -3770,19 +3734,15 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
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
@@ -3792,26 +3752,22 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
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
@@ -3825,8 +3781,6 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		if (!ret)
 			ret = 1;
 	}
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3876,7 +3830,7 @@ static int is_ancestor(struct btrfs_root *root,
 	bool free_fs_path = false;
 	int ret = 0;
 	int iter_ret = 0;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 
 	if (!fs_path) {
@@ -3944,7 +3898,6 @@ static int is_ancestor(struct btrfs_root *root,
 		ret = iter_ret;
 
 out:
-	btrfs_free_path(path);
 	if (free_fs_path)
 		fs_path_free(fs_path);
 	return ret;
@@ -4801,7 +4754,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	iterate_inode_ref_t cb;
@@ -4820,8 +4773,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
 				"Wrong command %d in process_all_refs", cmd);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	key.objectid = sctx->cmp_key->objectid;
@@ -4835,13 +4787,12 @@ static int process_all_refs(struct send_ctx *sctx,
 
 		ret = iterate_inode_ref(root, path, &found_key, false, cb, sctx);
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
@@ -4849,10 +4800,7 @@ static int process_all_refs(struct send_ctx *sctx,
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
@@ -5078,7 +5026,7 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -5106,7 +5054,6 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5771,7 +5718,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
 	unsigned long data_ptr;
@@ -5809,7 +5756,6 @@ static int send_capabilities(struct send_ctx *sctx)
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5817,7 +5763,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		       struct clone_root *clone_root, const u64 disk_byte,
 		       u64 data_offset, u64 offset, u64 len)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret;
 	struct btrfs_inode_info info;
@@ -5853,7 +5799,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
 	btrfs_release_path(path);
 	if (ret < 0)
-		goto out;
+		return ret;
 	clone_src_i_size = info.size;
 
 	/*
@@ -5883,7 +5829,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	key.offset = clone_root->offset;
 	ret = btrfs_search_slot(NULL, clone_root->root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
 		if (key.objectid == clone_root->ino &&
@@ -5904,7 +5850,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(clone_root->root, path);
 			if (ret < 0)
-				goto out;
+				return ret;
 			else if (ret > 0)
 				break;
 			continue;
@@ -5941,7 +5887,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			ret = send_extent_data(sctx, dst_path, offset,
 					       hole_len);
 			if (ret < 0)
-				goto out;
+				return ret;
 
 			len -= hole_len;
 			if (len == 0)
@@ -6012,7 +5958,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 					ret = send_clone(sctx, offset, slen,
 							 clone_root);
 					if (ret < 0)
-						goto out;
+						return ret;
 				}
 				ret = send_extent_data(sctx, dst_path,
 						       offset + slen,
@@ -6046,7 +5992,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		}
 
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		len -= clone_len;
 		if (len == 0)
@@ -6077,8 +6023,6 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -6167,7 +6111,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct btrfs_key key;
-	struct btrfs_path *path = NULL;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_key found_key;
@@ -6193,10 +6137,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6228,11 +6171,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6241,11 +6182,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6255,10 +6194,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6271,11 +6208,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6285,10 +6220,8 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6308,17 +6241,15 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6329,10 +6260,9 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
 
@@ -6345,15 +6275,12 @@ static int is_extent_unchanged(struct send_ctx *sctx,
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
@@ -6369,15 +6296,13 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
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
 
@@ -6385,7 +6310,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 				   const u64 start,
 				   const u64 end)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = sctx->parent_root;
 	u64 search_start = start;
@@ -6400,7 +6325,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 	key.offset = search_start;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret > 0 && path->slots[0] > 0)
 		path->slots[0]--;
 
@@ -6413,8 +6338,8 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
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
@@ -6436,15 +6361,11 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
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
@@ -6552,7 +6473,7 @@ static int process_all_extents(struct send_ctx *sctx)
 	int ret = 0;
 	int iter_ret = 0;
 	struct btrfs_root *root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 
@@ -6579,7 +6500,6 @@ static int process_all_extents(struct send_ctx *sctx)
 	if (iter_ret < 0)
 		ret = iter_ret;
 
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -7329,7 +7249,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -7346,7 +7266,7 @@ static int full_send_tree(struct send_ctx *sctx)
 
 	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret)
 		goto out_finish;
 
@@ -7356,7 +7276,7 @@ static int full_send_tree(struct send_ctx *sctx)
 		ret = changed_cb(path, NULL, &key,
 				 BTRFS_COMPARE_TREE_NEW, sctx);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		down_read(&fs_info->commit_root_sem);
 		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
@@ -7375,14 +7295,14 @@ static int full_send_tree(struct send_ctx *sctx)
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
@@ -7390,11 +7310,7 @@ static int full_send_tree(struct send_ctx *sctx)
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
@@ -7649,8 +7565,8 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
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
@@ -7923,8 +7839,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 out_unlock:
 	up_read(&fs_info->commit_root_sem);
 out:
-	btrfs_free_path(left_path);
-	btrfs_free_path(right_path);
 	kvfree(tmp_buf);
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 49893c885855..a2593acc4970 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -925,7 +925,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_dir_item *di;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key location;
 	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 dir_id;
@@ -942,7 +942,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
 	if (IS_ERR(di)) {
-		btrfs_free_path(path);
 		return PTR_ERR(di);
 	}
 	if (!di) {
@@ -951,13 +950,11 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
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
index febf456a9ab0..12558404f927 100644
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
@@ -1905,7 +1905,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 free_pending:
 	kfree(new_root_item);
 	pending->root_item = NULL;
-	btrfs_free_path(path);
 	pending->path = NULL;
 
 	return ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 78d59b63748b..b34ae17c5d70 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1176,7 +1176,7 @@ static noinline int backref_in_log(struct btrfs_root *log,
 				   u64 ref_objectid,
 				   const struct fscrypt_str *name)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -1184,12 +1184,10 @@ static noinline int backref_in_log(struct btrfs_root *log,
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
@@ -1198,8 +1196,6 @@ static noinline int backref_in_log(struct btrfs_root *log,
 	else
 		ret = !!btrfs_find_name_in_backref(path->nodes[0],
 						   path->slots[0], name);
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2512,7 +2508,7 @@ static int replay_xattr_deletes(struct walk_control *wc)
 	struct btrfs_root *root = wc->root;
 	struct btrfs_root *log = wc->log;
 	struct btrfs_key search_key;
-	struct btrfs_path *log_path;
+	BTRFS_PATH_AUTO_FREE(log_path);
 	const u64 ino = wc->log_key.objectid;
 	int nritems;
 	int ret;
@@ -2626,7 +2622,6 @@ static int replay_xattr_deletes(struct walk_control *wc)
 			       "failed to get next leaf in subvolume root %llu",
 				       btrfs_root_id(root));
 out:
-	btrfs_free_path(log_path);
 	btrfs_release_path(wc->subvol_path);
 	return ret;
 }
@@ -3129,7 +3124,7 @@ static int walk_log_tree(struct walk_control *wc)
 	int ret = 0;
 	int wret;
 	int level;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int orig_level;
 
 	path = btrfs_alloc_path();
@@ -3146,18 +3141,14 @@ static int walk_log_tree(struct walk_control *wc)
 		wret = walk_down_log_tree(path, &level, wc);
 		if (wret > 0)
 			break;
-		if (wret < 0) {
-			ret = wret;
-			goto out;
-		}
+		if (wret < 0)
+			return wret;
 
 		wret = walk_up_log_tree(path, &level, wc);
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
@@ -3166,13 +3157,11 @@ static int walk_log_tree(struct walk_control *wc)
 			 btrfs_header_generation(path->nodes[orig_level]),
 			 orig_level);
 		if (ret)
-			goto out;
+			return ret;
 		if (wc->free)
 			ret = clean_log_buffer(wc->trans, path->nodes[orig_level]);
 	}
 
-out:
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -3910,13 +3899,13 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
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
@@ -3930,7 +3919,7 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	ret = join_running_log_trans(root);
 	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
 	if (WARN_ON(ret))
-		goto out;
+		return;
 
 	mutex_lock(&dir->log_mutex);
 
@@ -3940,8 +3929,6 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		btrfs_set_log_full_commit(trans);
 	btrfs_end_log_trans(root);
-out:
-	btrfs_free_path(path);
 }
 
 /* see comments for btrfs_del_dir_entries_in_log */
@@ -5218,7 +5205,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	const u64 i_size = i_size_read(&inode->vfs_inode);
 	const u64 ino = btrfs_ino(inode);
-	struct btrfs_path *dst_path = NULL;
+	BTRFS_PATH_AUTO_FREE(dst_path);
 	bool dropped_extents = false;
 	u64 truncate_offset = i_size;
 	struct extent_buffer *leaf;
@@ -5336,7 +5323,6 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				 start_slot, ins_nr, 1, 0, ctx);
 out:
 	btrfs_release_path(path);
-	btrfs_free_path(dst_path);
 	return ret;
 }
 
@@ -5709,7 +5695,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 					 u64 *other_ino, u64 *other_parent)
 {
 	int ret;
-	struct btrfs_path *search_path;
+	BTRFS_PATH_AUTO_FREE(search_path);
 	char *name = NULL;
 	u32 name_len = 0;
 	u32 item_size = btrfs_item_size(eb, slot);
@@ -5794,7 +5780,6 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 	}
 	ret = 0;
 out:
-	btrfs_free_path(search_path);
 	kfree(name);
 	return ret;
 }
@@ -7176,7 +7161,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	int ret;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
@@ -7192,7 +7177,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
@@ -7204,8 +7189,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
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
@@ -7263,10 +7248,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
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
@@ -7279,14 +7262,11 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
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
@@ -7397,7 +7377,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	const u64 ino = btrfs_ino(inode);
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret;
 
@@ -7418,7 +7398,7 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 again:
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret == 0)
 		path->slots[0]++;
 
@@ -7430,8 +7410,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
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
@@ -7448,10 +7428,8 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
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
@@ -7463,14 +7441,11 @@ static int log_all_new_ancestors(struct btrfs_trans_handle *trans,
 
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
2.51.0


