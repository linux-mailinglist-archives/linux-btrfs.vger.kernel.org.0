Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8317C4E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFRu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFRu2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:50:28 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F892072A;
        Fri,  6 Mar 2020 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583517027;
        bh=oiRB+NBEYdyU5c3C6gT1lRYzpGwUj2YQcyI86QWkPas=;
        h=From:To:Cc:Subject:Date:From;
        b=BvRopj0gRLA85duPUDZOoO9dfTrTKXAm9BIw1MsjICZobIlU5YF9DRFxEYxLxaPyw
         oQeeStumLFhE1qJP72mn/x3B6QEWJjEErBtwGe6sb7Wm7uhQngeHE/N2cyByaSnumW
         +mXWJJMAoUbWeieQUzLjySc2KKU2q/brwAsmz85M=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 2/4] Btrfs: add helper to get the end offset of a file extent item
Date:   Fri,  6 Mar 2020 17:50:24 +0000
Message-Id: <20200306175024.12037-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Getting the end offset for a file extent item requires a bit of code since
the extent can be either inline or regular/prealloc. There are some places
all over the code base that open code this logic and in another patch
later in this series it will be needed again. Therefore encapsulate this
logic in a helper function and use it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h     |  1 +
 fs/btrfs/file-item.c | 40 ++++++++++++++++++++++++++++------------
 fs/btrfs/inode.c     | 10 +---------
 fs/btrfs/send.c      | 44 +++-----------------------------------------
 fs/btrfs/tree-log.c  | 15 +--------------
 5 files changed, 34 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 23d486d44202..670a65b452dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2852,6 +2852,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 				      u64 len);
 void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i_size);
+u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6c849e8fd5a1..b618ad5339ba 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1040,18 +1040,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
-
-	if (type == BTRFS_FILE_EXTENT_REG ||
-	    type == BTRFS_FILE_EXTENT_PREALLOC) {
-		extent_end = extent_start +
-			btrfs_file_extent_num_bytes(leaf, fi);
-	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
-		size_t size;
-		size = btrfs_file_extent_ram_bytes(leaf, fi);
-		extent_end = ALIGN(extent_start + size,
-				   fs_info->sectorsize);
-	}
-
+	extent_end = btrfs_file_extent_end(path);
 	em->ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -1098,3 +1087,30 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			  root->root_key.objectid);
 	}
 }
+
+/*
+ * Returns the end offset (non inclusive) of the file extent item the given path
+ * points to. If it points to an inline extent, the returned offset is rounded
+ * up to the sector size.
+ */
+u64 btrfs_file_extent_end(const struct btrfs_path *path)
+{
+	const struct extent_buffer *leaf = path->nodes[0];
+	const int slot = path->slots[0];
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_key key;
+	u64 end;
+
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
+	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+		end = btrfs_file_extent_ram_bytes(leaf, fi);
+		end = ALIGN(key.offset + end, leaf->fs_info->sectorsize);
+	} else {
+		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
+	}
+
+	return end;
+}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6fb9096e0e9f..e3529fe5874c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6520,6 +6520,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	extent_type = btrfs_file_extent_type(leaf, item);
 	extent_start = found_key.offset;
+	extent_end = btrfs_file_extent_end(path);
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		/* Only regular file could have regular/prealloc extent */
@@ -6530,18 +6531,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				   btrfs_ino(inode));
 			goto out;
 		}
-		extent_end = extent_start +
-		       btrfs_file_extent_num_bytes(leaf, item);
-
 		trace_btrfs_get_extent_show_fi_regular(inode, leaf, item,
 						       extent_start);
 	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		size_t size;
-
-		size = btrfs_file_extent_ram_bytes(leaf, item);
-		extent_end = ALIGN(extent_start + size,
-				   fs_info->sectorsize);
-
 		trace_btrfs_get_extent_show_fi_inline(inode, leaf, item,
 						      path->slots[0],
 						      extent_start);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6b86841315be..e47f768cec3d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5586,10 +5586,7 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 {
 	struct btrfs_path *path;
 	struct btrfs_root *root = sctx->send_root;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
-	u64 extent_end;
-	u8 type;
 	int ret;
 
 	path = alloc_path_for_send();
@@ -5609,18 +5606,7 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	if (key.objectid != sctx->cur_ino || key.type != BTRFS_EXTENT_DATA_KEY)
 		goto out;
 
-	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			    struct btrfs_file_extent_item);
-	type = btrfs_file_extent_type(path->nodes[0], fi);
-	if (type == BTRFS_FILE_EXTENT_INLINE) {
-		u64 size = btrfs_file_extent_ram_bytes(path->nodes[0], fi);
-		extent_end = ALIGN(key.offset + size,
-				   sctx->send_root->fs_info->sectorsize);
-	} else {
-		extent_end = key.offset +
-			btrfs_file_extent_num_bytes(path->nodes[0], fi);
-	}
-	sctx->cur_inode_last_extent = extent_end;
+	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -5674,16 +5660,7 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 			break;
 
 		fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, fi) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			u64 size = btrfs_file_extent_ram_bytes(leaf, fi);
-
-			extent_end = ALIGN(key.offset + size,
-					   root->fs_info->sectorsize);
-		} else {
-			extent_end = key.offset +
-				btrfs_file_extent_num_bytes(leaf, fi);
-		}
+		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
@@ -5704,9 +5681,6 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
 			   struct btrfs_key *key)
 {
-	struct btrfs_file_extent_item *fi;
-	u64 extent_end;
-	u8 type;
 	int ret = 0;
 
 	if (sctx->cur_ino != key->objectid || !need_send_hole(sctx))
@@ -5718,18 +5692,6 @@ static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
 			return ret;
 	}
 
-	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			    struct btrfs_file_extent_item);
-	type = btrfs_file_extent_type(path->nodes[0], fi);
-	if (type == BTRFS_FILE_EXTENT_INLINE) {
-		u64 size = btrfs_file_extent_ram_bytes(path->nodes[0], fi);
-		extent_end = ALIGN(key->offset + size,
-				   sctx->send_root->fs_info->sectorsize);
-	} else {
-		extent_end = key->offset +
-			btrfs_file_extent_num_bytes(path->nodes[0], fi);
-	}
-
 	if (path->slots[0] == 0 &&
 	    sctx->cur_inode_last_extent < key->offset) {
 		/*
@@ -5755,7 +5717,7 @@ static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
 		else
 			ret = 0;
 	}
-	sctx->cur_inode_last_extent = extent_end;
+	sctx->cur_inode_last_extent = btrfs_file_extent_end(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19c107be9ef6..b723ee03de26 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4555,9 +4555,7 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		return ret;
 
 	while (true) {
-		struct btrfs_file_extent_item *extent;
 		struct extent_buffer *leaf = path->nodes[0];
-		u64 len;
 
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 			ret = btrfs_next_leaf(root, path);
@@ -4606,18 +4604,7 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			leaf = path->nodes[0];
 		}
 
-		extent = btrfs_item_ptr(leaf, path->slots[0],
-					struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			len = btrfs_file_extent_ram_bytes(leaf, extent);
-			prev_extent_end = ALIGN(key.offset + len,
-						fs_info->sectorsize);
-		} else {
-			len = btrfs_file_extent_num_bytes(leaf, extent);
-			prev_extent_end = key.offset + len;
-		}
-
+		prev_extent_end = btrfs_file_extent_end(path);
 		path->slots[0]++;
 		cond_resched();
 	}
-- 
2.11.0

