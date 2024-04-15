Return-Path: <linux-btrfs+bounces-4279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DEF8A5C25
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 22:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080781F240F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619615687B;
	Mon, 15 Apr 2024 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i9qTkVct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE4156675
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212466; cv=none; b=YBkUG5nSrZfI5k4FArfEZwJsLZmcUqoZ37xCPun4ymWyHziumRPC2GFcZ36tS/o1RW6G8Y0WQKiAd9ChRiIIOt+QwZjrg/VORJJyzF5NwvWalEHbIoRPO5iXecPX9go4hia7leggk5EOU5j6Yqit+rFXA+1EMPErpn7Nm/jw/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212466; c=relaxed/simple;
	bh=K4LwbYKV2Ql6iVXV1O+yXRP6+ohKyJ+0sRFu9uOqhZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KadnRNxjVfWJKPnZVL8OdV/3Neawk83ZpEMYIUXbPkiYwvvOvQD1/3wbjNZsjuN2JxsStB3fBkym1sTEuCVxm3hKoxIK4xtJctWHq/6yVyqpAM4GvHjmYSfxDIrGZ7VgnXrOOWKpzHbXP6FXRNHT9KP88PL5U5OqNK0C1ALbaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i9qTkVct; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b9365e584so7215056d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713212456; x=1713817256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pEBNzYy7HJO58vcR6AXjVIuGzzbtwlBNBGZ0CSWzbE=;
        b=i9qTkVct6s3czJtoxIF+ihzQV1iU9gw9oUyoNkPaOYulc/Vce4IxpWQRNOI3KkW5TX
         Fqd0ABrZf4DHMRocEhG+fPFlbc3KH9yweazXq7uXp5cisjCQX2G7xJinLMgB0rmNZmzr
         AcX7QXpcx8bZ74h4k3/58zu9HR3++rXc0lZiZxcZcdW5IVJjeU5naTTsPUiu8vm+q6yZ
         BqujkCwAJQnBhNJ4j1rxKDRzSJanLvw+CnKHvvSfCr+ZhThmCG8afH9DUGH4iw6r3Cpx
         nv/ISjbJQzqN9yU32BUubcCJXxy2hReeT17+t3n/z8IDq4Q0rAd7STEnrDrjftNbyiTg
         5gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212456; x=1713817256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pEBNzYy7HJO58vcR6AXjVIuGzzbtwlBNBGZ0CSWzbE=;
        b=r8kVvP1ehBCo+Ir2U1ZZ9RFsUFoc3XLZCjF8RlH10ubhH4UdN3dujsG28e2icEdVCd
         QloK8zVfx2vWc86w+Ikn6pVKXQomGrEwd2NmF379KHPbLP/9bybDSxsfis35zgef79dC
         ODknFIgw2bIYjV5sCiGo/2Qxnrfd6JSmGYzRDDrKnjqP9teuTo3pZZ6Hp6yLAWtD6iGw
         nSGirpU2tGI6qv8LbOte5trwMeQG3YHQEtHiKVyuawW9guGPs97VLuFJTntl3z7LeM59
         x29+ClVNYM1wPOTTAKvZuE7/YnVvjFMsHTFogSmDPKGdpawbMG5npTp9VogO4Xh2yweH
         YZQw==
X-Gm-Message-State: AOJu0YxfaHpHNXv6tXZaNS09pa9mDlyi9YfLLt590Jg773DCLRsp0Zrc
	/K6zaIVIynnbAjR7cfnlKmUISIQ8R/AyOWRV3+dVJ53zhzmNzK09guX7FbgrT5vmQVlqs/W6a9K
	D
X-Google-Smtp-Source: AGHT+IEFZ6u094l6Gubh95bnkF8rLpSsgpEHY5kcrBBJ1SxVW0BzcyZsnw9umsmk6v5cEf4PEBp9WQ==
X-Received: by 2002:ad4:5de9:0:b0:69b:6578:93c1 with SMTP id jn9-20020ad45de9000000b0069b657893c1mr120929qvb.10.1713212455826;
        Mon, 15 Apr 2024 13:20:55 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y2-20020ad45302000000b0069b445b07fbsm6652930qvr.16.2024.04.15.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:20:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: change root->root_key.objectid to btrfs_root_id()
Date: Mon, 15 Apr 2024 16:20:51 -0400
Message-ID: <08243e0283d6f10f9f289b0963f385cf271bc796.1713212438.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment from Filipe on one of my previous cleanups brought my
attention to a new helper we have for getting the root id of a root,
which makes it easier to read in the code.

The changes where made with the following Coccinelle semantic patch:

// <smpl>
@@
expression E,E1;
@@
(
 E->root_key.objectid = E1
|
- E->root_key.objectid
+ btrfs_root_id(E)
)
// </smpl>

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c       |  8 +++---
 fs/btrfs/block-rsv.c     | 10 +++----
 fs/btrfs/compression.c   |  2 +-
 fs/btrfs/ctree.c         | 36 ++++++++++++------------
 fs/btrfs/defrag.c        |  2 +-
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/disk-io.c       | 36 ++++++++++++------------
 fs/btrfs/export.c        |  8 +++---
 fs/btrfs/extent-tree.c   | 50 ++++++++++++++++-----------------
 fs/btrfs/file-item.c     | 10 +++----
 fs/btrfs/file.c          | 22 +++++++--------
 fs/btrfs/inode-item.c    |  4 +--
 fs/btrfs/inode.c         | 58 +++++++++++++++++++-------------------
 fs/btrfs/ioctl.c         | 20 +++++++-------
 fs/btrfs/locking.c       |  2 +-
 fs/btrfs/ordered-data.c  |  2 +-
 fs/btrfs/props.c         |  2 +-
 fs/btrfs/qgroup.c        | 26 ++++++++---------
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/relocation.c    | 60 ++++++++++++++++++++--------------------
 fs/btrfs/root-tree.c     |  2 +-
 fs/btrfs/send.c          | 28 +++++++++----------
 fs/btrfs/super.c         | 10 +++----
 fs/btrfs/transaction.c   | 22 +++++++--------
 fs/btrfs/tree-log.c      | 10 +++----
 fs/btrfs/tree-mod-log.c  |  2 +-
 26 files changed, 218 insertions(+), 218 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 574fb1d515b3..0bc81b340295 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -261,7 +261,7 @@ static void update_share_count(struct share_check *sc, int oldcount,
 	else if (oldcount < 1 && newcount > 0)
 		sc->share_count++;
 
-	if (newref->root_id == sc->root->root_key.objectid &&
+	if (newref->root_id == btrfs_root_id(sc->root) &&
 	    newref->wanted_disk_byte == sc->data_bytenr &&
 	    newref->key_for_search.objectid == sc->inum)
 		sc->self_ref_count += newref->count;
@@ -769,7 +769,7 @@ static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
 			continue;
 		}
 
-		if (sc && ref->root_id != sc->root->root_key.objectid) {
+		if (sc && ref->root_id != btrfs_root_id(sc->root)) {
 			free_pref(ref);
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
@@ -2623,7 +2623,7 @@ static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
 			btrfs_debug(fs_root->fs_info,
 				"following ref at offset %u for inode %llu in tree %llu",
 				cur, found_key.objectid,
-				fs_root->root_key.objectid);
+				btrfs_root_id(fs_root));
 			ret = inode_to_path(parent, name_len,
 				      (unsigned long)(iref + 1), eb, ipath);
 			if (ret)
@@ -3361,7 +3361,7 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 	if (btrfs_node_blockptr(eb, path->slots[level]) != cur->bytenr) {
 		btrfs_err(fs_info,
 "couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
-			  cur->bytenr, level - 1, root->root_key.objectid,
+			  cur->bytenr, level - 1, btrfs_root_id(root),
 			  tree_key->objectid, tree_key->type, tree_key->offset);
 		btrfs_put_root(root);
 		ret = -ENOENT;
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 95c174f9fd4f..9cd722da1d86 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -341,9 +341,9 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	read_lock(&fs_info->global_root_lock);
 	rbtree_postorder_for_each_entry_safe(root, tmp, &fs_info->global_root_tree,
 					     rb_node) {
-		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID ||
-		    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
-		    root->root_key.objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
+		if (btrfs_root_id(root) == BTRFS_EXTENT_TREE_OBJECTID ||
+		    btrfs_root_id(root) == BTRFS_CSUM_TREE_OBJECTID ||
+		    btrfs_root_id(root) == BTRFS_FREE_SPACE_TREE_OBJECTID) {
 			num_bytes += btrfs_root_used(&root->root_item);
 			min_items++;
 		}
@@ -406,7 +406,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	switch (root->root_key.objectid) {
+	switch (btrfs_root_id(root)) {
 	case BTRFS_CSUM_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
@@ -469,7 +469,7 @@ static struct btrfs_block_rsv *get_block_rsv(
 	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
 	    (root == fs_info->uuid_root) ||
 	    (trans->adding_csums &&
-	     root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID))
+	     btrfs_root_id(root) == BTRFS_CSUM_TREE_OBJECTID))
 		block_rsv = trans->block_rsv;
 
 	if (!block_rsv)
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c981903c8cd7..6441e47d8a5e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -992,7 +992,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 
 		btrfs_crit(inode->root->fs_info,
 		"failed to get page cache, root %lld ino %llu file offset %llu",
-			   inode->root->root_key.objectid, btrfs_ino(inode), start);
+			   btrfs_root_id(inode->root), btrfs_ino(inode), start);
 		return -ENOENT;
 	}
 	*in_folio_ret = in_folio;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f6a98e7cf006..adcec4d247c5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -291,7 +291,7 @@ static void add_root_to_dirty_list(struct btrfs_root *root)
 	spin_lock(&fs_info->trans_lock);
 	if (!test_and_set_bit(BTRFS_ROOT_DIRTY, &root->state)) {
 		/* Want the extent tree to be the last on the list */
-		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID)
+		if (btrfs_root_id(root) == BTRFS_EXTENT_TREE_OBJECTID)
 			list_move_tail(&root->dirty_list,
 				       &fs_info->dirty_cowonly_roots);
 		else
@@ -454,7 +454,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		refs = 1;
-		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
+		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID ||
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			flags = BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		else
@@ -466,14 +466,14 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	       !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
 
 	if (refs > 1) {
-		if ((owner == root->root_key.objectid ||
-		     root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) &&
+		if ((owner == btrfs_root_id(root) ||
+		     btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) &&
 		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
 			ret = btrfs_inc_ref(trans, root, buf, 1);
 			if (ret)
 				return ret;
 
-			if (root->root_key.objectid ==
+			if (btrfs_root_id(root) ==
 			    BTRFS_TREE_RELOC_OBJECTID) {
 				ret = btrfs_dec_ref(trans, root, buf, 0);
 				if (ret)
@@ -485,7 +485,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			new_flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		} else {
 
-			if (root->root_key.objectid ==
+			if (btrfs_root_id(root) ==
 			    BTRFS_TREE_RELOC_OBJECTID)
 				ret = btrfs_inc_ref(trans, root, cow, 1);
 			else
@@ -500,7 +500,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-			if (root->root_key.objectid ==
+			if (btrfs_root_id(root) ==
 			    BTRFS_TREE_RELOC_OBJECTID)
 				ret = btrfs_inc_ref(trans, root, cow, 1);
 			else
@@ -563,13 +563,13 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
 		if (parent)
 			parent_start = parent->start;
 		reloc_src_root = btrfs_header_owner(buf);
 	}
 	cow = btrfs_alloc_tree_block(trans, root, parent_start,
-				     root->root_key.objectid, &disk_key, level,
+				     btrfs_root_id(root), &disk_key, level,
 				     search_start, empty_size, reloc_src_root, nest);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
@@ -582,10 +582,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	btrfs_set_header_backref_rev(cow, BTRFS_MIXED_BACKREF_REV);
 	btrfs_clear_header_flag(cow, BTRFS_HEADER_FLAG_WRITTEN |
 				     BTRFS_HEADER_FLAG_RELOC);
-	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
 		btrfs_set_header_flag(cow, BTRFS_HEADER_FLAG_RELOC);
 	else
-		btrfs_set_header_owner(cow, root->root_key.objectid);
+		btrfs_set_header_owner(cow, btrfs_root_id(root));
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
@@ -609,7 +609,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 
 	if (buf == root->node) {
 		WARN_ON(parent && parent != buf);
-		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
+		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID ||
 		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			parent_start = buf->start;
 
@@ -685,7 +685,7 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 	 */
 	if (btrfs_header_generation(buf) == trans->transid &&
 	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
-	    !(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
+	    !(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
 	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
 	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
 		return 0;
@@ -1511,7 +1511,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	check.has_first_key = true;
 	check.level = parent_level - 1;
 	check.transid = gen;
-	check.owner_root = root->root_key.objectid;
+	check.owner_root = btrfs_root_id(root);
 
 	/*
 	 * If we need to read an extent buffer from disk and we are holding locks
@@ -1556,7 +1556,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			btrfs_release_path(p);
 			return -EIO;
 		}
-		if (btrfs_check_eb_owner(tmp, root->root_key.objectid)) {
+		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
 			return -EUCLEAN;
@@ -2865,7 +2865,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(lower, &lower_key, 0);
 
-	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+	c = btrfs_alloc_tree_block(trans, root, 0, btrfs_root_id(root),
 				   &lower_key, level, root->node->start, 0,
 				   0, BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
@@ -3009,7 +3009,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	mid = (c_nritems + 1) / 2;
 	btrfs_node_key(c, &disk_key, mid);
 
-	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+	split = btrfs_alloc_tree_block(trans, root, 0, btrfs_root_id(root),
 				       &disk_key, level, c->start, 0,
 				       0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
@@ -3761,7 +3761,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	 * BTRFS_NESTING_SPLIT_THE_SPLITTENING if we need to, but for now just
 	 * use BTRFS_NESTING_NEW_ROOT.
 	 */
-	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+	right = btrfs_alloc_tree_block(trans, root, 0, btrfs_root_id(root),
 				       &disk_key, 0, l->start, 0, 0,
 				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
 				       BTRFS_NESTING_SPLIT);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f015fa1b6301..407ccec3e57e 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -147,7 +147,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 
 	defrag->ino = btrfs_ino(inode);
 	defrag->transid = transid;
-	defrag->root = root->root_key.objectid;
+	defrag->root = btrfs_root_id(root);
 	defrag->extent_thresh = extent_thresh;
 
 	spin_lock(&fs_info->defrag_inodes_lock);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 121ab890bd05..95a0497fa866 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1651,7 +1651,7 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
 			  "err add delayed dir index item(index: %llu) into the deletion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  index, node->root->root_key.objectid,
+			  index, btrfs_root_id(node->root),
 			  node->inode_id, ret);
 		btrfs_delayed_item_release_metadata(dir->root, item);
 		btrfs_release_delayed_item(item);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0474e9b6d302..22bc34d2f89a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -776,7 +776,7 @@ int btrfs_global_root_insert(struct btrfs_root *root)
 	if (tmp) {
 		ret = -EEXIST;
 		btrfs_warn(fs_info, "global root %llu %llu already exists",
-				root->root_key.objectid, root->root_key.offset);
+				btrfs_root_id(root), root->root_key.offset);
 	}
 	return ret;
 }
@@ -1012,7 +1012,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	}
 
 	log_root->last_trans = trans->transid;
-	log_root->root_key.offset = root->root_key.objectid;
+	log_root->root_key.offset = btrfs_root_id(root);
 
 	inode_item = &log_root->root_item.inode;
 	btrfs_set_stack_inode_generation(inode_item, 1);
@@ -1077,14 +1077,14 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 	 * match its root node owner
 	 */
 	if (!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state) &&
-	    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
-	    root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
-	    root->root_key.objectid != btrfs_header_owner(root->node)) {
+	    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
+	    btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+	    btrfs_root_id(root) != btrfs_header_owner(root->node)) {
 		btrfs_crit(fs_info,
 "root=%llu block=%llu, tree root owner mismatch, have %llu expect %llu",
-			   root->root_key.objectid, root->node->start,
+			   btrfs_root_id(root), root->node->start,
 			   btrfs_header_owner(root->node),
-			   root->root_key.objectid);
+			   btrfs_root_id(root));
 		ret = -EUCLEAN;
 		goto fail;
 	}
@@ -1121,9 +1121,9 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 
 	btrfs_drew_lock_init(&root->snapshot_lock);
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
+	if (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
 	    !btrfs_is_data_reloc_root(root) &&
-	    is_fstree(root->root_key.objectid)) {
+	    is_fstree(btrfs_root_id(root))) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
@@ -1132,7 +1132,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	 * Don't assign anonymous block device to roots that are not exposed to
 	 * userspace, the id pool is limited to 1M
 	 */
-	if (is_fstree(root->root_key.objectid) &&
+	if (is_fstree(btrfs_root_id(root)) &&
 	    btrfs_root_refs(&root->root_item) > 0) {
 		if (!anon_dev) {
 			ret = get_anon_bdev(&root->anon_dev);
@@ -1219,7 +1219,7 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	ret = radix_tree_insert(&fs_info->fs_roots_radix,
-				(unsigned long)root->root_key.objectid,
+				(unsigned long) btrfs_root_id(root),
 				root);
 	if (ret == 0) {
 		btrfs_grab_root(root);
@@ -2584,7 +2584,7 @@ static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int lev
 	struct btrfs_tree_parent_check check = {
 		.level = level,
 		.transid = gen,
-		.owner_root = root->root_key.objectid
+		.owner_root = btrfs_root_id(root)
 	};
 	int ret = 0;
 
@@ -2930,7 +2930,7 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
-		root_objectid = gang[ret - 1]->root_key.objectid + 1;
+		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
 
 		for (i = 0; i < ret; i++) {
 			/* Avoid to grab roots in dead_roots. */
@@ -2946,7 +2946,7 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 		for (i = 0; i < ret; i++) {
 			if (!gang[i])
 				continue;
-			root_objectid = gang[i]->root_key.objectid;
+			root_objectid = btrfs_root_id(gang[i]);
 			err = btrfs_orphan_cleanup(gang[i]);
 			if (err)
 				goto out;
@@ -4139,7 +4139,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
-			  (unsigned long)root->root_key.objectid);
+			  (unsigned long) btrfs_root_id(root));
 	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
 		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
@@ -4481,7 +4481,7 @@ static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
 		for (i = 0; i < ret; i++) {
 			if (!gang[i])
 				continue;
-			root_objectid = gang[i]->root_key.objectid;
+			root_objectid = btrfs_root_id(gang[i]);
 			btrfs_free_log(NULL, gang[i]);
 			btrfs_put_root(gang[i]);
 		}
@@ -4812,7 +4812,7 @@ static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
 
 			btrfs_qgroup_free_meta_all_pertrans(root);
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
-					(unsigned long)root->root_key.objectid,
+					(unsigned long) btrfs_root_id(root),
 					BTRFS_ROOT_TRANS_TAG);
 		}
 	}
@@ -4953,7 +4953,7 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 	if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
 		btrfs_warn(root->fs_info,
 			   "the objectid of root %llu reaches its highest value",
-			   root->root_key.objectid);
+			   btrfs_root_id(root));
 		ret = -ENOSPC;
 		goto out;
 	}
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 8398d345ec5b..9e81f89e76d8 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -34,7 +34,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	type = FILEID_BTRFS_WITHOUT_PARENT;
 
 	fid->objectid = btrfs_ino(BTRFS_I(inode));
-	fid->root_objectid = BTRFS_I(inode)->root->root_key.objectid;
+	fid->root_objectid = btrfs_root_id(BTRFS_I(inode)->root);
 	fid->gen = inode->i_generation;
 
 	if (parent) {
@@ -42,7 +42,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 
 		fid->parent_objectid = BTRFS_I(parent)->location.objectid;
 		fid->parent_gen = parent->i_generation;
-		parent_root_id = BTRFS_I(parent)->root->root_key.objectid;
+		parent_root_id = btrfs_root_id(BTRFS_I(parent)->root);
 
 		if (parent_root_id != fid->root_objectid) {
 			fid->parent_root_objectid = parent_root_id;
@@ -160,7 +160,7 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 		return ERR_PTR(-ENOMEM);
 
 	if (btrfs_ino(BTRFS_I(dir)) == BTRFS_FIRST_FREE_OBJECTID) {
-		key.objectid = root->root_key.objectid;
+		key.objectid = btrfs_root_id(root);
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 		root = fs_info->tree_root;
@@ -243,7 +243,7 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 		return -ENOMEM;
 
 	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
-		key.objectid = BTRFS_I(inode)->root->root_key.objectid;
+		key.objectid = btrfs_root_id(BTRFS_I(inode)->root);
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 		root = fs_info->tree_root;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 87a921b84bab..828d9e61f8a3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2328,7 +2328,7 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 		 * If our ref doesn't match the one we're currently looking at
 		 * then we have a cross reference.
 		 */
-		if (ref->ref_root != root->root_key.objectid ||
+		if (ref->ref_root != btrfs_root_id(root) ||
 		    ref_owner != objectid || ref_offset != offset) {
 			ret = 1;
 			break;
@@ -2423,7 +2423,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	if (btrfs_extent_refs(leaf, ei) !=
 	    btrfs_extent_data_ref_count(leaf, ref) ||
 	    btrfs_extent_data_ref_root(leaf, ref) !=
-	    root->root_key.objectid ||
+	    btrfs_root_id(root) ||
 	    btrfs_extent_data_ref_objectid(leaf, ref) != objectid ||
 	    btrfs_extent_data_ref_offset(leaf, ref) != offset)
 		goto out;
@@ -2515,7 +2515,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 
 			key.offset -= btrfs_file_extent_offset(buf, fi);
 			btrfs_init_data_ref(&ref, key.objectid, key.offset,
-					    root->root_key.objectid, for_reloc);
+					    btrfs_root_id(root), for_reloc);
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &ref);
 			else
@@ -2528,7 +2528,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			ref.num_bytes = fs_info->nodesize;
 
 			btrfs_init_tree_ref(&ref, level - 1,
-					    root->root_key.objectid, for_reloc);
+					    btrfs_root_id(root), for_reloc);
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &ref);
 			else
@@ -4671,7 +4671,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
-	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	bool for_treelog = (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID);
 	bool for_data_reloc = (btrfs_is_data_reloc_root(root) && is_data);
 
 	flags = get_alloc_profile_by_root(root, is_data);
@@ -4936,8 +4936,8 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 		.action = BTRFS_ADD_DELAYED_EXTENT,
 		.bytenr = ins->objectid,
 		.num_bytes = ins->offset,
-		.owning_root = root->root_key.objectid,
-		.ref_root = root->root_key.objectid,
+		.owning_root = btrfs_root_id(root),
+		.ref_root = btrfs_root_id(root),
 	};
 
 	ASSERT(generic_ref.ref_root != BTRFS_TREE_LOG_OBJECTID);
@@ -5083,7 +5083,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_header_owner(buf, owner);
 	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);
 	write_extent_buffer_chunk_tree_uuid(buf, fs_info->chunk_tree_uuid);
-	if (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID) {
+	if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID) {
 		buf->log_index = root->log_transid % 2;
 		/*
 		 * we allow two log transactions at a time, use different
@@ -5189,7 +5189,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->level = level;
 
 		btrfs_init_tree_ref(&generic_ref, level,
-				    root->root_key.objectid, false);
+				    btrfs_root_id(root), false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
 		if (ret)
@@ -5328,7 +5328,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (wc->stage == UPDATE_BACKREF &&
-	    btrfs_header_owner(eb) != root->root_key.objectid)
+	    btrfs_header_owner(eb) != btrfs_root_id(root))
 		return 1;
 
 	/*
@@ -5402,7 +5402,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 
 	ret = lookup_extent_backref(trans, path, &iref, bytenr,
 				    root->fs_info->nodesize, parent,
-				    root->root_key.objectid, level, 0);
+				    btrfs_root_id(root), level, 0);
 	btrfs_free_path(path);
 	if (ret == -ENOENT)
 		return 0;
@@ -5458,7 +5458,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	check.level = level - 1;
 	check.transid = generation;
-	check.owner_root = root->root_key.objectid;
+	check.owner_root = btrfs_root_id(root);
 	check.has_first_key = true;
 	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
 			      path->slots[level]);
@@ -5466,7 +5466,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	next = find_extent_buffer(fs_info, bytenr);
 	if (!next) {
 		next = btrfs_find_create_tree_block(fs_info, bytenr,
-				root->root_key.objectid, level - 1);
+				btrfs_root_id(root), level - 1);
 		if (IS_ERR(next))
 			return PTR_ERR(next);
 		reada = 1;
@@ -5556,14 +5556,14 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			.bytenr = bytenr,
 			.num_bytes = fs_info->nodesize,
 			.owning_root = owner_root,
-			.ref_root = root->root_key.objectid,
+			.ref_root = btrfs_root_id(root),
 		};
 		if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 			ref.parent = path->nodes[level]->start;
 		} else {
-			ASSERT(root->root_key.objectid ==
+			ASSERT(btrfs_root_id(root) ==
 			       btrfs_header_owner(path->nodes[level]));
-			if (root->root_key.objectid !=
+			if (btrfs_root_id(root) !=
 			    btrfs_header_owner(path->nodes[level])) {
 				btrfs_err(root->fs_info,
 						"mismatched block owner");
@@ -5594,7 +5594,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		 * already accounted them at merge time (replace_path),
 		 * thus we could skip expensive subtree trace here.
 		 */
-		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
 		    need_account) {
 			ret = btrfs_qgroup_trace_subtree(trans, next,
 							 generation, level - 1);
@@ -5705,7 +5705,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
 			BUG_ON(ret); /* -ENOMEM */
-			if (is_fstree(root->root_key.objectid)) {
+			if (is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
 					btrfs_err_rl(fs_info,
@@ -5725,12 +5725,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	if (eb == root->node) {
 		if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF)
 			parent = eb->start;
-		else if (root->root_key.objectid != btrfs_header_owner(eb))
+		else if (btrfs_root_id(root) != btrfs_header_owner(eb))
 			goto owner_mismatch;
 	} else {
 		if (wc->flags[level + 1] & BTRFS_BLOCK_FLAG_FULL_BACKREF)
 			parent = path->nodes[level + 1]->start;
-		else if (root->root_key.objectid !=
+		else if (btrfs_root_id(root) !=
 			 btrfs_header_owner(path->nodes[level + 1]))
 			goto owner_mismatch;
 	}
@@ -5744,7 +5744,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 
 owner_mismatch:
 	btrfs_err_rl(fs_info, "unexpected tree owner, have %llu expect %llu",
-		     btrfs_header_owner(eb), root->root_key.objectid);
+		     btrfs_header_owner(eb), btrfs_root_id(root));
 	return -EUCLEAN;
 }
 
@@ -5830,7 +5830,7 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
  */
 int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 {
-	const bool is_reloc_root = (root->root_key.objectid ==
+	const bool is_reloc_root = (btrfs_root_id(root) ==
 				    BTRFS_TREE_RELOC_OBJECTID);
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -5845,7 +5845,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	bool root_dropped = false;
 	bool unfinished_drop = false;
 
-	btrfs_debug(fs_info, "Drop subvolume %llu", root->root_key.objectid);
+	btrfs_debug(fs_info, "Drop subvolume %llu", btrfs_root_id(root));
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -6044,7 +6044,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			 * The most common failure here is just -ENOENT.
 			 */
 			btrfs_del_orphan_item(trans, tree_root,
-					      root->root_key.objectid);
+					      btrfs_root_id(root));
 		}
 	}
 
@@ -6108,7 +6108,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int wret;
 
-	BUG_ON(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
+	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1ea1ed44fe42..872fcee2e099 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -430,7 +430,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 			memset(csum_dst, 0, csum_size);
 			count = 1;
 
-			if (inode->root->root_key.objectid ==
+			if (btrfs_root_id(inode->root) ==
 			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
 				u64 file_offset = bbio->file_offset + bio_offset;
 
@@ -885,8 +885,8 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	const u32 csum_size = fs_info->csum_size;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
-	ASSERT(root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
-	       root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(btrfs_root_id(root) == BTRFS_CSUM_TREE_OBJECTID ||
+	       btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1186,7 +1186,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		 * search, etc, because log trees are temporary anyway and it
 		 * would only save a few bytes of leaf space.
 		 */
-		if (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID) {
+		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID) {
 			if (path->slots[0] + 1 >=
 			    btrfs_header_nritems(path->nodes[0])) {
 				ret = find_next_csum_offset(root, path, &next_offset);
@@ -1328,7 +1328,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		btrfs_err(fs_info,
 			  "unknown file extent item type %d, inode %llu, offset %llu, "
 			  "root %llu", type, btrfs_ino(inode), extent_start,
-			  root->root_key.objectid);
+			  btrfs_root_id(root));
 	}
 }
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 065658f2c061..0c7c1b42028e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -245,7 +245,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	if (args->start >= inode->disk_i_size && !args->replace_extent)
 		modify_tree = 0;
 
-	update_refs = (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID);
+	update_refs = (btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
 	while (1) {
 		recow = 0;
 		ret = btrfs_lookup_file_extent(trans, root, path, ino,
@@ -377,8 +377,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 					.bytenr = disk_bytenr,
 					.num_bytes = num_bytes,
 					.parent = 0,
-					.owning_root = root->root_key.objectid,
-					.ref_root = root->root_key.objectid,
+					.owning_root = btrfs_root_id(root),
+					.ref_root = btrfs_root_id(root),
 				};
 				btrfs_init_data_ref(&ref, new_key.objectid,
 						    args->start - extent_offset,
@@ -470,8 +470,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 					.bytenr = disk_bytenr,
 					.num_bytes = num_bytes,
 					.parent = 0,
-					.owning_root = root->root_key.objectid,
-					.ref_root = root->root_key.objectid,
+					.owning_root = btrfs_root_id(root),
+					.ref_root = btrfs_root_id(root),
 				};
 				btrfs_init_data_ref(&ref, key.objectid,
 						    key.offset - extent_offset,
@@ -755,8 +755,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		ref.bytenr = bytenr;
 		ref.num_bytes = num_bytes;
 		ref.parent = 0;
-		ref.owning_root = root->root_key.objectid;
-		ref.ref_root = root->root_key.objectid;
+		ref.owning_root = btrfs_root_id(root);
+		ref.ref_root = btrfs_root_id(root);
 		btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
@@ -785,8 +785,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	ref.bytenr = bytenr;
 	ref.num_bytes = num_bytes;
 	ref.parent = 0;
-	ref.owning_root = root->root_key.objectid;
-	ref.ref_root = root->root_key.objectid;
+	ref.owning_root = btrfs_root_id(root);
+	ref.ref_root = btrfs_root_id(root);
 	btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
 			     ino, bytenr, orig_offset,
@@ -2493,8 +2493,8 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 			.action = BTRFS_ADD_DELAYED_REF,
 			.bytenr = extent_info->disk_offset,
 			.num_bytes = extent_info->disk_len,
-			.owning_root = root->root_key.objectid,
-			.ref_root = root->root_key.objectid,
+			.owning_root = btrfs_root_id(root),
+			.ref_root = btrfs_root_id(root),
 		};
 		u64 ref_offset;
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 7565ff15a69a..84a94d19b22c 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -674,14 +674,14 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				.action = BTRFS_DROP_DELAYED_REF,
 				.bytenr = extent_start,
 				.num_bytes = extent_num_bytes,
-				.owning_root = root->root_key.objectid,
+				.owning_root = btrfs_root_id(root),
 				.ref_root = btrfs_header_owner(leaf),
 			};
 
 			bytes_deleted += extent_num_bytes;
 
 			btrfs_init_data_ref(&ref, control->ino, extent_offset,
-					    root->root_key.objectid, false);
+					    btrfs_root_id(root), false);
 			ret = btrfs_free_extent(trans, &ref);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 629706b98e31..30893f12c850 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -254,7 +254,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 		btrfs_warn_rl(fs_info, "has data reloc tree but no running relocation");
 		btrfs_warn_rl(fs_info,
 "csum failed root %lld ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			inode->root->root_key.objectid, btrfs_ino(inode), file_off,
+			btrfs_root_id(inode->root), btrfs_ino(inode), file_off,
 			CSUM_FMT_VALUE(csum_size, csum),
 			CSUM_FMT_VALUE(csum_size, csum_expected),
 			mirror_num);
@@ -264,7 +264,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 	logical += file_off;
 	btrfs_warn_rl(fs_info,
 "csum failed root %lld ino %llu off %llu logical %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			inode->root->root_key.objectid,
+			btrfs_root_id(inode->root),
 			btrfs_ino(inode), file_off, logical,
 			CSUM_FMT_VALUE(csum_size, csum),
 			CSUM_FMT_VALUE(csum_size, csum_expected),
@@ -331,15 +331,15 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 	const u32 csum_size = root->fs_info->csum_size;
 
 	/* For data reloc tree, it's better to do a backref lookup instead. */
-	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+	if (btrfs_root_id(root) == BTRFS_DATA_RELOC_TREE_OBJECTID)
 		return print_data_reloc_error(inode, logical_start, csum,
 					      csum_expected, mirror_num);
 
 	/* Output without objectid, which is more meaningful */
-	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID) {
+	if (btrfs_root_id(root) >= BTRFS_LAST_FREE_OBJECTID) {
 		btrfs_warn_rl(root->fs_info,
 "csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			root->root_key.objectid, btrfs_ino(inode),
+			btrfs_root_id(root), btrfs_ino(inode),
 			logical_start,
 			CSUM_FMT_VALUE(csum_size, csum),
 			CSUM_FMT_VALUE(csum_size, csum_expected),
@@ -347,7 +347,7 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 	} else {
 		btrfs_warn_rl(root->fs_info,
 "csum failed root %llu ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
-			root->root_key.objectid, btrfs_ino(inode),
+			btrfs_root_id(root), btrfs_ino(inode),
 			logical_start,
 			CSUM_FMT_VALUE(csum_size, csum),
 			CSUM_FMT_VALUE(csum_size, csum_expected),
@@ -1218,7 +1218,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		kthread_associate_blkcg(NULL);
 	btrfs_debug(fs_info,
 "async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
-		    root->root_key.objectid, btrfs_ino(inode), start,
+		    btrfs_root_id(root), btrfs_ino(inode), start,
 		    async_extent->ram_size, ret);
 	kfree(async_extent);
 }
@@ -3239,7 +3239,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			 * Actually free the qgroup rsv which was released when
 			 * the ordered extent was created.
 			 */
-			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+			btrfs_qgroup_free_refroot(fs_info, btrfs_root_id(inode->root),
 						  ordered_extent->qgroup_rsv,
 						  BTRFS_QGROUP_RSV_DATA);
 		}
@@ -3906,7 +3906,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
 				  btrfs_ino(BTRFS_I(inode)),
-				  root->root_key.objectid, ret);
+				  btrfs_root_id(root), ret);
 	}
 	if (path != in_path)
 		btrfs_free_path(path);
@@ -4265,7 +4265,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	/* This needs to handle no-key deletions later on */
 
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
-		objectid = inode->root->root_key.objectid;
+		objectid = btrfs_root_id(inode->root);
 	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
 		objectid = inode->location.objectid;
 	} else {
@@ -4323,7 +4323,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	} else {
 		ret = btrfs_del_root_ref(trans, objectid,
-					 root->root_key.objectid, dir_ino,
+					 btrfs_root_id(root), dir_ino,
 					 &index, &fname.disk_name);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -4373,7 +4373,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 				   dir_id, &name, 0);
 	if (di && !IS_ERR(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
-		if (key.objectid == root->root_key.objectid) {
+		if (key.objectid == btrfs_root_id(root)) {
 			ret = -EPERM;
 			btrfs_err(fs_info,
 				  "deleting default subvolume %llu is not allowed",
@@ -4383,7 +4383,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 		btrfs_release_path(path);
 	}
 
-	key.objectid = root->root_key.objectid;
+	key.objectid = btrfs_root_id(root);
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = (u64)-1;
 
@@ -4403,7 +4403,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	if (path->slots[0] > 0) {
 		path->slots[0]--;
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		if (key.objectid == root->root_key.objectid &&
+		if (key.objectid == btrfs_root_id(root) &&
 		    key.type == BTRFS_ROOT_REF_KEY)
 			ret = -ENOTEMPTY;
 	}
@@ -4462,7 +4462,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu during send",
-			   dest->root_key.objectid);
+			   btrfs_root_id(dest));
 		ret = -EPERM;
 		goto out_up_write;
 	}
@@ -4470,7 +4470,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
-			   root->root_key.objectid);
+			   btrfs_root_id(root));
 		ret = -EPERM;
 		goto out_up_write;
 	}
@@ -4531,7 +4531,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	if (!test_and_set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &dest->state)) {
 		ret = btrfs_insert_orphan_item(trans,
 					fs_info->tree_root,
-					dest->root_key.objectid);
+					btrfs_root_id(dest));
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
@@ -4540,7 +4540,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 
 	ret = btrfs_uuid_tree_remove(trans, dest->root_item.uuid,
 				  BTRFS_UUID_KEY_SUBVOL,
-				  dest->root_key.objectid);
+				  btrfs_root_id(dest));
 	if (ret && ret != -ENOENT) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
@@ -4549,7 +4549,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		ret = btrfs_uuid_tree_remove(trans,
 					  dest->root_item.received_uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-					  dest->root_key.objectid);
+					  btrfs_root_id(dest));
 		if (ret && ret != -ENOENT) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
@@ -5229,7 +5229,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 	if (inode->i_nlink &&
 	    ((btrfs_root_refs(&root->root_item) != 0 &&
-	      root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID) ||
+	      btrfs_root_id(root) != BTRFS_ROOT_TREE_OBJECTID) ||
 	     btrfs_is_free_space_inode(BTRFS_I(inode))))
 		goto out;
 
@@ -5241,7 +5241,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 	if (inode->i_nlink > 0) {
 		BUG_ON(btrfs_root_refs(&root->root_item) != 0 &&
-		       root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID);
+		       btrfs_root_id(root) != BTRFS_ROOT_TREE_OBJECTID);
 		goto out;
 	}
 
@@ -5413,7 +5413,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	}
 
 	err = -ENOENT;
-	key.objectid = dir->root->root_key.objectid;
+	key.objectid = btrfs_root_id(dir->root);
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = location->objectid;
 
@@ -6372,7 +6372,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	if (ret) {
 		btrfs_err(fs_info,
 			  "error inheriting props for ino %llu (root %llu): %d",
-			  btrfs_ino(BTRFS_I(inode)), root->root_key.objectid,
+			  btrfs_ino(BTRFS_I(inode)), btrfs_root_id(root),
 			  ret);
 	}
 
@@ -6446,7 +6446,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_add_root_ref(trans, key.objectid,
-					 root->root_key.objectid, parent_ino,
+					 btrfs_root_id(root), parent_ino,
 					 index, name);
 	} else if (add_backref) {
 		ret = btrfs_insert_inode_ref(trans, root, name,
@@ -6489,7 +6489,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		u64 local_index;
 		int err;
 		err = btrfs_del_root_ref(trans, key.objectid,
-					 root->root_key.objectid, parent_ino,
+					 btrfs_root_id(root), parent_ino,
 					 &local_index, name);
 		if (err)
 			btrfs_abort_transaction(trans, err);
@@ -6587,7 +6587,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	int drop_inode = 0;
 
 	/* do not allow sys_link's with other subvols of the same device */
-	if (root->root_key.objectid != BTRFS_I(inode)->root->root_key.objectid)
+	if (btrfs_root_id(root) != btrfs_root_id(BTRFS_I(inode)->root))
 		return -EXDEV;
 
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
@@ -9433,7 +9433,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	 * or we leak qgroup data reservation.
 	 */
 	btrfs_qgroup_free_refroot(inode->root->fs_info,
-			inode->root->root_key.objectid, qgroup_released,
+			btrfs_root_id(inode->root), qgroup_released,
 			BTRFS_QGROUP_RSV_DATA);
 	return ERR_PTR(ret);
 }
@@ -10534,7 +10534,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 		"cannot activate swapfile because subvolume %llu is being deleted",
-			root->root_key.objectid);
+			btrfs_root_id(root));
 		return -EPERM;
 	}
 	atomic_inc(&root->nr_swapfiles);
@@ -10760,7 +10760,7 @@ void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 en
 	if (ordered) {
 		btrfs_err(root->fs_info,
 "found unexpected ordered extent in file range [%llu, %llu] for inode %llu root %llu (ordered range [%llu, %llu])",
-			  start, end, btrfs_ino(inode), root->root_key.objectid,
+			  start, end, btrfs_ino(inode), btrfs_root_id(root),
 			  ordered->file_offset,
 			  ordered->file_offset + ordered->num_bytes - 1);
 		btrfs_put_ordered_extent(ordered);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 888dc92c6c75..0c977b7cc253 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -668,7 +668,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	/* Tree log can't currently deal with an inode which is a new root. */
 	btrfs_set_log_full_commit(trans);
 
-	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
+	ret = btrfs_qgroup_inherit(trans, 0, objectid, btrfs_root_id(root), inherit);
 	if (ret)
 		goto out;
 
@@ -1510,7 +1510,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 			spin_unlock(&root->root_item_lock);
 			btrfs_warn(fs_info,
 				   "Attempt to set subvolume %llu read-write during send",
-				   root->root_key.objectid);
+				   btrfs_root_id(root));
 			ret = -EPERM;
 			goto out_drop_sem;
 		}
@@ -1919,7 +1919,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct super_block *sb = inode->i_sb;
 	struct btrfs_key upper_limit = BTRFS_I(inode)->location;
-	u64 treeid = BTRFS_I(inode)->root->root_key.objectid;
+	u64 treeid = btrfs_root_id(BTRFS_I(inode)->root);
 	u64 dirid = args->dirid;
 	unsigned long item_off;
 	unsigned long item_len;
@@ -2091,7 +2091,7 @@ static noinline int btrfs_ioctl_ino_lookup(struct btrfs_root *root,
 	 * path is reset so it's consistent with btrfs_search_path_in_tree.
 	 */
 	if (args->treeid == 0)
-		args->treeid = root->root_key.objectid;
+		args->treeid = btrfs_root_id(root);
 
 	if (args->objectid == BTRFS_FIRST_FREE_OBJECTID) {
 		args->name[0] = 0;
@@ -2187,7 +2187,7 @@ static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 	fs_info = BTRFS_I(inode)->root->fs_info;
 
 	/* Get root_item of inode's subvolume */
-	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
+	key.objectid = btrfs_root_id(BTRFS_I(inode)->root);
 	root = btrfs_get_fs_root(fs_info, key.objectid, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
@@ -2302,7 +2302,7 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 		return PTR_ERR(rootrefs);
 	}
 
-	objectid = root->root_key.objectid;
+	objectid = btrfs_root_id(root);
 	key.objectid = objectid;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = rootrefs->min_treeid;
@@ -2981,7 +2981,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!is_fstree(new_root->root_key.objectid)) {
+	if (!is_fstree(btrfs_root_id(new_root))) {
 		ret = -ENOENT;
 		goto out_free;
 	}
@@ -3920,7 +3920,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 	qgroupid = sa->qgroupid;
 	if (!qgroupid) {
 		/* take the current subvol as qgroup */
-		qgroupid = root->root_key.objectid;
+		qgroupid = btrfs_root_id(root);
 	}
 
 	ret = btrfs_limit_qgroup(trans, qgroupid, &sa->lim);
@@ -4051,7 +4051,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-					  root->root_key.objectid);
+					  btrfs_root_id(root));
 		if (ret && ret != -ENOENT) {
 		        btrfs_abort_transaction(trans, ret);
 		        btrfs_end_transaction(trans);
@@ -4075,7 +4075,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	if (received_uuid_changed && !btrfs_is_empty_uuid(sa->uuid)) {
 		ret = btrfs_uuid_tree_add(trans, sa->uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-					  root->root_key.objectid);
+					  btrfs_root_id(root));
 		if (ret < 0 && ret != -EEXIST) {
 			btrfs_abort_transaction(trans, ret);
 			btrfs_end_transaction(trans);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 72992e74c479..6a0b7abb5bd9 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -97,7 +97,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb, int
 void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root, struct extent_buffer *eb)
 {
 	if (test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
-		btrfs_set_buffer_lockdep_class(root->root_key.objectid,
+		btrfs_set_buffer_lockdep_class(btrfs_root_id(root),
 					       eb, btrfs_header_level(eb));
 }
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b749ba45da2b..03b2f646b2f9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -332,7 +332,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
 		btrfs_crit(fs_info,
 "bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%llu left=%llu",
-			   inode->root->root_key.objectid, btrfs_ino(inode),
+			   btrfs_root_id(inode->root), btrfs_ino(inode),
 			   ordered->file_offset, ordered->num_bytes,
 			   len, ordered->bytes_left);
 		ordered->bytes_left = 0;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 2a9b7b029eeb..155570e20f45 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -268,7 +268,7 @@ static void inode_prop_iterator(void *ctx,
 		btrfs_warn(root->fs_info,
 			   "error applying prop %s to ino %llu (root %llu): %d",
 			   handler->xattr_name, btrfs_ino(BTRFS_I(inode)),
-			   root->root_key.objectid, ret);
+			   btrfs_root_id(root), ret);
 	else
 		set_bit(BTRFS_INODE_HAS_PROPS, &BTRFS_I(inode)->runtime_flags);
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2cba6451d164..b5a055004fbc 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3471,7 +3471,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 {
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 ref_root = root->root_key.objectid;
+	u64 ref_root = btrfs_root_id(root);
 	int ret = 0;
 	LIST_HEAD(qgroup_list);
 
@@ -4112,7 +4112,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	int ret;
 
 	if (btrfs_qgroup_mode(root->fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(root->root_key.objectid) || len == 0)
+	    !is_fstree(btrfs_root_id(root)) || len == 0)
 		return 0;
 
 	/* @reserved parameter is mandatory for qgroup */
@@ -4228,7 +4228,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 			goto out;
 		freed += changeset.bytes_changed;
 	}
-	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid, freed,
+	btrfs_qgroup_free_refroot(root->fs_info, btrfs_root_id(root), freed,
 				  BTRFS_QGROUP_RSV_DATA);
 	if (freed_ret)
 		*freed_ret = freed;
@@ -4269,7 +4269,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 					changeset.bytes_changed, trace_op);
 	if (free)
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
-				inode->root->root_key.objectid,
+				btrfs_root_id(inode->root),
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
 	if (released)
 		*released = changeset.bytes_changed;
@@ -4364,7 +4364,7 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	int ret;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(root->root_key.objectid) || num_bytes == 0)
+	    !is_fstree(btrfs_root_id(root)) || num_bytes == 0)
 		return 0;
 
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
@@ -4409,13 +4409,13 @@ void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(root->root_key.objectid))
+	    !is_fstree(btrfs_root_id(root)))
 		return;
 
 	/* TODO: Update trace point to handle such free */
 	trace_qgroup_meta_free_all_pertrans(root);
 	/* Special value -1 means to free all reserved space */
-	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid, (u64)-1,
+	btrfs_qgroup_free_refroot(fs_info, btrfs_root_id(root), (u64)-1,
 				  BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
@@ -4425,7 +4425,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(root->root_key.objectid))
+	    !is_fstree(btrfs_root_id(root)))
 		return;
 
 	/*
@@ -4436,7 +4436,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 	num_bytes = sub_root_meta_rsv(root, num_bytes, type);
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
 	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
-	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid,
+	btrfs_qgroup_free_refroot(fs_info, btrfs_root_id(root),
 				  num_bytes, type);
 }
 
@@ -4485,13 +4485,13 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED ||
-	    !is_fstree(root->root_key.objectid))
+	    !is_fstree(btrfs_root_id(root)))
 		return;
 	/* Same as btrfs_qgroup_free_meta_prealloc() */
 	num_bytes = sub_root_meta_rsv(root, num_bytes,
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
-	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	qgroup_convert_meta(fs_info, btrfs_root_id(root), num_bytes);
 	if (!sb_rdonly(fs_info->sb))
 		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
@@ -4520,7 +4520,7 @@ void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode)
 				btrfs_ino(inode), unode->val, unode->aux);
 		}
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
-				inode->root->root_key.objectid,
+				btrfs_root_id(inode->root),
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
 
 	}
@@ -4706,7 +4706,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
-	if (!is_fstree(root->root_key.objectid) || !root->reloc_root)
+	if (!is_fstree(btrfs_root_id(root)) || !root->reloc_root)
 		return 0;
 
 	spin_lock(&blocks->lock);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f12ba2b75141..d0a3fcecc46a 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -665,7 +665,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 	if (root_dst->send_in_progress) {
 		btrfs_warn_rl(root_dst->fs_info,
 "cannot deduplicate to root %llu while send operations are using it (%d in progress)",
-			      root_dst->root_key.objectid,
+			      btrfs_root_id(root_dst),
 			      root_dst->send_in_progress);
 		spin_unlock(&root_dst->root_item_lock);
 		return -EAGAIN;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 00f33d8c4bf9..4ba1e21ab8a3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -754,7 +754,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root_key.offset = objectid;
 
-	if (root->root_key.objectid == objectid) {
+	if (btrfs_root_id(root) == objectid) {
 		u64 commit_root_gen;
 
 		/* called by btrfs_init_reloc_root */
@@ -798,7 +798,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	btrfs_set_root_level(root_item, btrfs_header_level(eb));
 	btrfs_set_root_generation(root_item, trans->transid);
 
-	if (root->root_key.objectid == objectid) {
+	if (btrfs_root_id(root) == objectid) {
 		btrfs_set_root_refs(root_item, 0);
 		memset(&root_item->drop_progress, 0,
 		       sizeof(struct btrfs_disk_key));
@@ -877,7 +877,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	 * reloc trees never need their own reloc tree.
 	 */
 	if (!rc->create_reloc_tree ||
-	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+	    btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
 		return 0;
 
 	if (!trans->reloc_reserved) {
@@ -885,7 +885,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 		trans->block_rsv = rc->block_rsv;
 		clear_rsv = 1;
 	}
-	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
+	reloc_root = create_reloc_root(trans, root, btrfs_root_id(root));
 	if (clear_rsv)
 		trans->block_rsv = rsv;
 	if (IS_ERR(reloc_root))
@@ -1027,7 +1027,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		return 0;
 
 	/* reloc trees always use full backref */
-	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
 		parent = leaf->start;
 	else
 		parent = 0;
@@ -1056,7 +1056,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		 * if we are modifying block in fs tree, wait for read_folio
 		 * to complete and drop the extent cache
 		 */
-		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID) {
 			if (first) {
 				inode = btrfs_find_first_inode(root, key.objectid);
 				first = 0;
@@ -1108,10 +1108,10 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		ref.bytenr = new_bytenr;
 		ref.num_bytes = num_bytes;
 		ref.parent = parent;
-		ref.owning_root = root->root_key.objectid;
+		ref.owning_root = btrfs_root_id(root);
 		ref.ref_root = btrfs_header_owner(leaf);
 		btrfs_init_data_ref(&ref, key.objectid, key.offset,
-				    root->root_key.objectid, false);
+				    btrfs_root_id(root), false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1122,10 +1122,10 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		ref.bytenr = bytenr;
 		ref.num_bytes = num_bytes;
 		ref.parent = parent;
-		ref.owning_root = root->root_key.objectid;
+		ref.owning_root = btrfs_root_id(root);
 		ref.ref_root = btrfs_header_owner(leaf);
 		btrfs_init_data_ref(&ref, key.objectid, key.offset,
-				    root->root_key.objectid, false);
+				    btrfs_root_id(root), false);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1181,8 +1181,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
-	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(btrfs_root_id(src) == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(btrfs_root_id(dest) != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1338,8 +1338,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.bytenr = old_bytenr;
 		ref.num_bytes = blocksize;
 		ref.parent = path->nodes[level]->start;
-		ref.owning_root = src->root_key.objectid;
-		ref.ref_root = src->root_key.objectid;
+		ref.owning_root = btrfs_root_id(src);
+		ref.ref_root = btrfs_root_id(src);
 		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
@@ -1351,8 +1351,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.bytenr = new_bytenr;
 		ref.num_bytes = blocksize;
 		ref.parent = 0;
-		ref.owning_root = dest->root_key.objectid;
-		ref.ref_root = dest->root_key.objectid;
+		ref.owning_root = btrfs_root_id(dest);
+		ref.ref_root = btrfs_root_id(dest);
 		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
@@ -1366,7 +1366,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.num_bytes = blocksize;
 		ref.parent = path->nodes[level]->start;
 		ref.owning_root = 0;
-		ref.ref_root = src->root_key.objectid;
+		ref.ref_root = btrfs_root_id(src);
 		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
@@ -1380,7 +1380,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.num_bytes = blocksize;
 		ref.parent = 0;
 		ref.owning_root = 0;
-		ref.ref_root = dest->root_key.objectid;
+		ref.ref_root = btrfs_root_id(dest);
 		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
@@ -1586,7 +1586,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
-	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
 	ASSERT(reloc_root);
 
 	reloc_root_item = &reloc_root->root_item;
@@ -1615,7 +1615,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 
 	list_for_each_entry_safe(root, next, &rc->dirty_subvol_roots,
 				 reloc_dirty_list) {
-		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID) {
 			/* Merged subvolume, cleanup its reloc root */
 			struct btrfs_root *reloc_root = root->reloc_root;
 
@@ -1890,13 +1890,13 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 			if (root->reloc_root) {
 				btrfs_err(fs_info,
 "reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
-					  root->root_key.objectid,
-					  root->reloc_root->root_key.objectid,
+					  btrfs_root_id(root),
+					  btrfs_root_id(root->reloc_root),
 					  root->reloc_root->root_key.type,
 					  root->reloc_root->root_key.offset,
 					  btrfs_root_generation(
 						  &root->reloc_root->root_item),
-					  reloc_root->root_key.objectid,
+					  btrfs_root_id(reloc_root),
 					  reloc_root->root_key.type,
 					  reloc_root->root_key.offset,
 					  btrfs_root_generation(
@@ -1904,8 +1904,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 			} else {
 				btrfs_err(fs_info,
 "reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
-					  root->root_key.objectid,
-					  reloc_root->root_key.objectid,
+					  btrfs_root_id(root),
+					  btrfs_root_id(reloc_root),
 					  reloc_root->root_key.type,
 					  reloc_root->root_key.offset,
 					  btrfs_root_generation(
@@ -2162,7 +2162,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			return ERR_PTR(-EUCLEAN);
 		}
 
-		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
+		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
 			ret = record_reloc_root_in_trans(trans, root);
 			if (ret)
 				return ERR_PTR(ret);
@@ -2269,7 +2269,7 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 			return root;
 
-		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID)
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID)
 			fs_root = root;
 
 		if (next != node)
@@ -2495,7 +2495,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_mark_buffer_dirty(trans, upper->eb);
 
 			btrfs_init_tree_ref(&ref, node->level,
-					    root->root_key.objectid, false);
+					    btrfs_root_id(root), false);
 			ret = btrfs_inc_extent_ref(trans, &ref);
 			if (!ret)
 				ret = btrfs_drop_subtree(trans, root, eb,
@@ -4463,7 +4463,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 	    btrfs_root_last_snapshot(&root->root_item))
 		first_cow = 1;
 
-	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID &&
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID &&
 	    rc->create_reloc_tree) {
 		WARN_ON(!first_cow && level == 0);
 
@@ -4558,7 +4558,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 
 	new_root = pending->snap;
 	reloc_root = create_reloc_root(trans, root->reloc_root,
-				       new_root->root_key.objectid);
+				       btrfs_root_id(new_root));
 	if (IS_ERR(reloc_root))
 		return PTR_ERR(reloc_root);
 
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 7007f9e0c972..39a920efd9bc 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -149,7 +149,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 		btrfs_crit(fs_info,
 			"unable to find root key (%llu %u %llu) in tree %llu",
 			key->objectid, key->type, key->offset,
-			root->root_key.objectid);
+			btrfs_root_id(root));
 		ret = -EUCLEAN;
 		btrfs_abort_transaction(trans, ret);
 		goto out;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 342fe5ff0f05..0ff587bf43e0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -392,9 +392,9 @@ static void inconsistent_snapshot_error(struct send_ctx *sctx,
 	btrfs_err(sctx->send_root->fs_info,
 		  "Send: inconsistent snapshot, found %s %s for inode %llu without updated inode item, send root is %llu, parent root is %llu",
 		  result_string, what, sctx->cmp_key->objectid,
-		  sctx->send_root->root_key.objectid,
+		  btrfs_root_id(sctx->send_root),
 		  (sctx->parent_root ?
-		   sctx->parent_root->root_key.objectid : 0));
+		   btrfs_root_id(sctx->parent_root) : 0));
 }
 
 __maybe_unused
@@ -1316,9 +1316,9 @@ static int __clone_root_cmp_bsearch(const void *key, const void *elt)
 	u64 root = (u64)(uintptr_t)key;
 	const struct clone_root *cr = elt;
 
-	if (root < cr->root->root_key.objectid)
+	if (root < btrfs_root_id(cr->root))
 		return -1;
-	if (root > cr->root->root_key.objectid)
+	if (root > btrfs_root_id(cr->root))
 		return 1;
 	return 0;
 }
@@ -1328,9 +1328,9 @@ static int __clone_root_cmp_sort(const void *e1, const void *e2)
 	const struct clone_root *cr1 = e1;
 	const struct clone_root *cr2 = e2;
 
-	if (cr1->root->root_key.objectid < cr2->root->root_key.objectid)
+	if (btrfs_root_id(cr1->root) < btrfs_root_id(cr2->root))
 		return -1;
-	if (cr1->root->root_key.objectid > cr2->root->root_key.objectid)
+	if (btrfs_root_id(cr1->root) > btrfs_root_id(cr2->root))
 		return 1;
 	return 0;
 }
@@ -1778,7 +1778,7 @@ static int read_symlink(struct btrfs_root *root,
 		 */
 		btrfs_err(root->fs_info,
 			  "Found empty symlink inode %llu at root %llu",
-			  ino, root->root_key.objectid);
+			  ino, btrfs_root_id(root));
 		ret = -EIO;
 		goto out;
 	}
@@ -2532,7 +2532,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 		return -ENOMEM;
 	}
 
-	key.objectid = send_root->root_key.objectid;
+	key.objectid = btrfs_root_id(send_root);
 	key.type = BTRFS_ROOT_BACKREF_KEY;
 	key.offset = 0;
 
@@ -2548,7 +2548,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.type != BTRFS_ROOT_BACKREF_KEY ||
-	    key.objectid != send_root->root_key.objectid) {
+	    key.objectid != btrfs_root_id(send_root)) {
 		ret = -ENOENT;
 		goto out;
 	}
@@ -5318,7 +5318,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 				btrfs_err(fs_info,
 			"send: IO error at offset %llu for inode %llu root %llu",
 					folio_pos(folio), sctx->cur_ino,
-					sctx->send_root->root_key.objectid);
+					btrfs_root_id(sctx->send_root));
 				folio_put(folio);
 				ret = -EIO;
 				break;
@@ -5389,7 +5389,7 @@ static int send_clone(struct send_ctx *sctx,
 
 	btrfs_debug(sctx->send_root->fs_info,
 		    "send_clone offset=%llu, len=%d, clone_root=%llu, clone_inode=%llu, clone_offset=%llu",
-		    offset, len, clone_root->root->root_key.objectid,
+		    offset, len, btrfs_root_id(clone_root->root),
 		    clone_root->ino, clone_root->offset);
 
 	p = fs_path_alloc();
@@ -7338,7 +7338,7 @@ static int search_key_again(const struct send_ctx *sctx,
 "send: key (%llu %u %llu) not found in %s root %llu, lowest_level %d, slot %d",
 			  key->objectid, key->type, key->offset,
 			  (root == sctx->parent_root ? "parent" : "send"),
-			  root->root_key.objectid, path->lowest_level,
+			  btrfs_root_id(root), path->lowest_level,
 			  path->slots[path->lowest_level]);
 		return -EUCLEAN;
 	}
@@ -8072,7 +8072,7 @@ static void btrfs_root_dec_send_in_progress(struct btrfs_root* root)
 	if (root->send_in_progress < 0)
 		btrfs_err(root->fs_info,
 			  "send_in_progress unbalanced %d root %llu",
-			  root->send_in_progress, root->root_key.objectid);
+			  root->send_in_progress, btrfs_root_id(root));
 	spin_unlock(&root->root_item_lock);
 }
 
@@ -8080,7 +8080,7 @@ static void dedupe_in_progress_warn(const struct btrfs_root *root)
 {
 	btrfs_warn_rl(root->fs_info,
 "cannot use root %llu for send while deduplications on it are in progress (%d in progress)",
-		      root->root_key.objectid, root->dedupe_in_progress);
+		      btrfs_root_id(root), root->dedupe_in_progress);
 }
 
 long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f..f0ce75df4e48 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1098,9 +1098,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
 	seq_printf(seq, ",subvolid=%llu",
-		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
+		  btrfs_root_id(BTRFS_I(d_inode(dentry))->root));
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
-			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
+			btrfs_root_id(BTRFS_I(d_inode(dentry))->root));
 	if (!IS_ERR(subvol_name)) {
 		seq_puts(seq, ",subvol=");
 		seq_escape(seq, subvol_name, " \t\n\\");
@@ -1152,7 +1152,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 		struct super_block *s = root->d_sb;
 		struct btrfs_fs_info *fs_info = btrfs_sb(s);
 		struct inode *root_inode = d_inode(root);
-		u64 root_objectid = BTRFS_I(root_inode)->root->root_key.objectid;
+		u64 root_objectid = btrfs_root_id(BTRFS_I(root_inode)->root);
 
 		ret = 0;
 		if (!is_subvolume_inode(root_inode)) {
@@ -1775,9 +1775,9 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_fsid.val[1] = be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
 	/* Mask in the root object ID too, to disambiguate subvols */
 	buf->f_fsid.val[0] ^=
-		BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
+		btrfs_root_id(BTRFS_I(d_inode(dentry))->root) >> 32;
 	buf->f_fsid.val[1] ^=
-		BTRFS_I(d_inode(dentry))->root->root_key.objectid;
+		btrfs_root_id(BTRFS_I(d_inode(dentry))->root);
 
 	return 0;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index df2e58aa824a..8a82df2f9627 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -426,7 +426,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			return 0;
 		}
 		radix_tree_tag_set(&fs_info->fs_roots_radix,
-				   (unsigned long)root->root_key.objectid,
+				   (unsigned long) btrfs_root_id(root),
 				   BTRFS_ROOT_TRANS_TAG);
 		spin_unlock(&fs_info->fs_roots_radix_lock);
 		root->last_trans = trans->transid;
@@ -472,7 +472,7 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 	/* Make sure we don't try to update the root at commit time */
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_tag_clear(&fs_info->fs_roots_radix,
-			     (unsigned long)root->root_key.objectid,
+			     (unsigned long) btrfs_root_id(root),
 			     BTRFS_ROOT_TRANS_TAG);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 }
@@ -550,7 +550,7 @@ static inline bool need_reserve_reloc_root(struct btrfs_root *root)
 
 	if (!fs_info->reloc_ctl ||
 	    !test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
-	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
+	    btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID ||
 	    root->reloc_root)
 		return false;
 
@@ -1229,7 +1229,7 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
 	bool errors = false;
 	int err;
 
-	ASSERT(log_root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(btrfs_root_id(log_root) == BTRFS_TREE_LOG_OBJECTID);
 
 	err = __btrfs_wait_marked_extents(fs_info, dirty_pages);
 	if ((mark & EXTENT_DIRTY) &&
@@ -1492,7 +1492,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			ASSERT(atomic_read(&root->log_commit[1]) == 0);
 
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
-					(unsigned long)root->root_key.objectid,
+					(unsigned long) btrfs_root_id(root),
 					BTRFS_ROOT_TRANS_TAG);
 			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
@@ -1583,8 +1583,8 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 		goto out;
 
 	/* Now qgroup are all updated, we can inherit it to new qgroups */
-	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
-				   parent->root_key.objectid, inherit);
+	ret = btrfs_qgroup_inherit(trans, btrfs_root_id(src), dst_objectid,
+				   btrfs_root_id(parent), inherit);
 	if (ret < 0)
 		goto out;
 
@@ -1822,7 +1822,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 * insert root back/forward references
 	 */
 	ret = btrfs_add_root_ref(trans, objectid,
-				 parent_root->root_key.objectid,
+				 btrfs_root_id(parent_root),
 				 btrfs_ino(BTRFS_I(parent_inode)), index,
 				 &fname.disk_name);
 	if (ret) {
@@ -1855,8 +1855,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		ret = qgroup_account_snapshot(trans, root, parent_root,
 					      pending->inherit, objectid);
 	else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
-		ret = btrfs_qgroup_inherit(trans, root->root_key.objectid, objectid,
-					   parent_root->root_key.objectid, pending->inherit);
+		ret = btrfs_qgroup_inherit(trans, btrfs_root_id(root), objectid,
+					   btrfs_root_id(parent_root), pending->inherit);
 	if (ret < 0)
 		goto fail;
 
@@ -2623,7 +2623,7 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 	list_del_init(&root->root_list);
 	spin_unlock(&fs_info->trans_lock);
 
-	btrfs_debug(fs_info, "cleaner removing %llu", root->root_key.objectid);
+	btrfs_debug(fs_info, "cleaner removing %llu", btrfs_root_id(root));
 
 	btrfs_kill_all_delayed_nodes(root);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1c7efb7c2160..a4e73081d477 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -391,7 +391,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	 * the leaf before writing into the log tree. See the comments at
 	 * copy_items() for more details.
 	 */
-	ASSERT(root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
 
 	item_size = btrfs_item_size(eb, slot);
 	src_ptr = btrfs_item_ptr_offset(eb, slot);
@@ -765,8 +765,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 					.action = BTRFS_ADD_DELAYED_REF,
 					.bytenr = ins.objectid,
 					.num_bytes = ins.offset,
-					.owning_root = root->root_key.objectid,
-					.ref_root = root->root_key.objectid,
+					.owning_root = btrfs_root_id(root),
+					.ref_root = btrfs_root_id(root),
 				};
 				btrfs_init_data_ref(&ref, key->objectid, offset,
 						    0, false);
@@ -779,7 +779,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				 * allocation tree
 				 */
 				ret = btrfs_alloc_logged_file_extent(trans,
-						root->root_key.objectid,
+						btrfs_root_id(root),
 						key->objectid, offset, &ins);
 				if (ret)
 					goto out;
@@ -3047,7 +3047,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		if (ret != -ENOSPC)
 			btrfs_err(fs_info,
 				  "failed to update log for root %llu ret %d",
-				  root->root_key.objectid, ret);
+				  btrfs_root_id(root), ret);
 		btrfs_wait_tree_log_extents(log, mark);
 		mutex_unlock(&log_root_tree->log_mutex);
 		goto out;
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 43b3accbed7a..fa45b5fb9683 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -1004,7 +1004,7 @@ struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq)
 		free_extent_buffer(eb_root);
 
 		check.level = level;
-		check.owner_root = root->root_key.objectid;
+		check.owner_root = btrfs_root_id(root);
 
 		old = read_tree_block(fs_info, logical, &check);
 		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
-- 
2.43.0


