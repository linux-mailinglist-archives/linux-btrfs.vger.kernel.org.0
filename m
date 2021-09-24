Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0741E4170D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 13:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbhIXLaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 07:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244845AbhIXL3x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 07:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C106F60F11
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632482900;
        bh=I/nDhP4IfjQp+GOxgKmkg5FWdgh4+pGvKXDoaBWgJx8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EUFMXFvV9/pKfpFN/YX58xLnpcTzIkyuuFiF3n9lR2Pvsi9fdTm9HIDo+s7aVeUTK
         qCB9iDxP8oxKunkJNX8tk4hQcusyHaHAvrs6gRhUWwsUCrdt5uA/Lmr4Swmu3yidtw
         bgPIcfK3pjVta1XluxaJTBTQJZSknzYUwwIm1LW57fbDxB1x8uQV66zBjab2zJA56L
         g0cdy0/JpaHqJtmr7LUkLIk97as1nWtZro8Ou+d8B5BSFeTM6SbkXgcfxl2QzNMjL2
         JB05gqXRU2gC/6oouRxH0NwSAvQLq4FI7xcp2TNGfKA4ex04fu4J8C5Ff3oTHPXoDI
         yeo4ab90fYj6A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: unexport setup_items_for_insert()
Date:   Fri, 24 Sep 2021 12:28:14 +0100
Message-Id: <eb4ca29eb4a0086340469663ba4c627d69a24cf7.1632482680.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632482680.git.fdmanana@suse.com>
References: <cover.1632482680.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since setup_items_for_insert() is not used anymore outside of ctree.c,
make it static and remove its prototype from ctree.h. This also requires
to move the definition of setup_item_for_insert() from ctree.h to ctree.c
and move down btrfs_duplicate_item() so that it's defined after
setup_items_for_insert().

Further, since setup_item_for_insert() is used outside ctree.c, rename it
to btrfs_setup_item_for_insert().

This patch is part of a small patchset that is comprised of the following
patches:

  btrfs: loop only once over data sizes array when inserting an item batch
  btrfs: unexport setup_items_for_insert()
  btrfs: use single bulk copy operations when logging directories

This is patch 2/3 and performance results, and the specific tests, are
included in the changelog of patch 3/3.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c                     | 95 +++++++++++++++++-----------
 fs/btrfs/ctree.h                     | 24 ++-----
 fs/btrfs/file.c                      |  2 +-
 fs/btrfs/tests/extent-buffer-tests.c |  2 +-
 fs/btrfs/tests/inode-tests.c         |  4 +-
 5 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 49e2bbda2d7e..74c8e18f3720 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3580,40 +3580,6 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * This function duplicate a item, giving 'new_key' to the new item.
- * It guarantees both items live in the same tree leaf and the new item
- * is contiguous with the original item.
- *
- * This allows us to split file extent in place, keeping a lock on the
- * leaf the entire time.
- */
-int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root,
-			 struct btrfs_path *path,
-			 const struct btrfs_key *new_key)
-{
-	struct extent_buffer *leaf;
-	int ret;
-	u32 item_size;
-
-	leaf = path->nodes[0];
-	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
-	ret = setup_leaf_for_split(trans, root, path,
-				   item_size + sizeof(struct btrfs_item));
-	if (ret)
-		return ret;
-
-	path->slots[0]++;
-	setup_item_for_insert(root, path, new_key, item_size);
-	leaf = path->nodes[0];
-	memcpy_extent_buffer(leaf,
-			     btrfs_item_ptr_offset(leaf, path->slots[0]),
-			     btrfs_item_ptr_offset(leaf, path->slots[0] - 1),
-			     item_size);
-	return 0;
-}
-
 /*
  * make the item pointed to by the path smaller.  new_size indicates
  * how small to make it, and from_end tells us if we just chop bytes
@@ -3787,8 +3753,8 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
  * @path:	points to the leaf/slot where we are going to insert new items
  * @batch:      information about the batch of items to insert
  */
-void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
-			    const struct btrfs_item_batch *batch)
+static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
+				   const struct btrfs_item_batch *batch)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_item *item;
@@ -3881,6 +3847,29 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
 	}
 }
 
+/*
+ * Insert a new item into a leaf.
+ *
+ * @root:      The root of the btree.
+ * @path:      A path pointing to the target leaf and slot.
+ * @key:       The key of the new item.
+ * @data_size: The size of the data associated with the new key.
+ */
+void btrfs_setup_item_for_insert(struct btrfs_root *root,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key,
+				 u32 data_size)
+{
+	struct btrfs_item_batch batch;
+
+	batch.keys = key;
+	batch.data_sizes = &data_size;
+	batch.total_data_size = data_size;
+	batch.nr = 1;
+
+	setup_items_for_insert(root, path, &batch);
+}
+
 /*
  * Given a key and some data, insert items into the tree.
  * This does all the path init required, making room in the tree if needed.
@@ -3935,6 +3924,40 @@ int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return ret;
 }
 
+/*
+ * This function duplicates an item, giving 'new_key' to the new item.
+ * It guarantees both items live in the same tree leaf and the new item is
+ * contiguous with the original item.
+ *
+ * This allows us to split a file extent in place, keeping a lock on the leaf
+ * the entire time.
+ */
+int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *root,
+			 struct btrfs_path *path,
+			 const struct btrfs_key *new_key)
+{
+	struct extent_buffer *leaf;
+	int ret;
+	u32 item_size;
+
+	leaf = path->nodes[0];
+	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
+	ret = setup_leaf_for_split(trans, root, path,
+				   item_size + sizeof(struct btrfs_item));
+	if (ret)
+		return ret;
+
+	path->slots[0]++;
+	btrfs_setup_item_for_insert(root, path, new_key, item_size);
+	leaf = path->nodes[0];
+	memcpy_extent_buffer(leaf,
+			     btrfs_item_ptr_offset(leaf, path->slots[0]),
+			     btrfs_item_ptr_offset(leaf, path->slots[0] - 1),
+			     item_size);
+	return 0;
+}
+
 /*
  * delete the pointer from a given node.
  *
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 59f7fda3f5d1..400ce90efbb0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2899,7 +2899,7 @@ static inline int btrfs_del_item(struct btrfs_trans_handle *trans,
 
 /*
  * Describes a batch of items to insert in a btree. This is used by
- * btrfs_insert_empty_items() and setup_items_for_insert().
+ * btrfs_insert_empty_items().
  */
 struct btrfs_item_batch {
 	/*
@@ -2923,24 +2923,10 @@ struct btrfs_item_batch {
 	int nr;
 };
 
-void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
-			    const struct btrfs_item_batch *batch);
-
-static inline void setup_item_for_insert(struct btrfs_root *root,
-					 struct btrfs_path *path,
-					 const struct btrfs_key *key,
-					 u32 data_size)
-{
-	struct btrfs_item_batch batch;
-
-	batch.keys = key;
-	batch.data_sizes = &data_size;
-	batch.total_data_size = data_size;
-	batch.nr = 1;
-
-	setup_items_for_insert(root, path, &batch);
-}
-
+void btrfs_setup_item_for_insert(struct btrfs_root *root,
+				 struct btrfs_path *path,
+				 const struct btrfs_key *key,
+				 u32 data_size);
 int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, void *data, u32 data_size);
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 85de69529160..04e29b40a38e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1021,7 +1021,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (btrfs_comp_cpu_keys(&key, &slot_key) > 0)
 				path->slots[0]++;
 		}
-		setup_item_for_insert(root, path, &key, args->extent_item_size);
+		btrfs_setup_item_for_insert(root, path, &key, args->extent_item_size);
 		args->extent_inserted = true;
 	}
 
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index c9ab65e3d8e8..2a95f7224e18 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -60,7 +60,7 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = 0;
 
-	setup_item_for_insert(root, path, &key, value_len);
+	btrfs_setup_item_for_insert(root, path, &key, value_len);
 	item = btrfs_item_nr(0);
 	write_extent_buffer(eb, value, btrfs_item_ptr_offset(eb, 0),
 			    value_len);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index af62d05435b9..cac89c388131 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -33,7 +33,7 @@ static void insert_extent(struct btrfs_root *root, u64 start, u64 len,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = start;
 
-	setup_item_for_insert(root, &path, &key, value_len);
+	btrfs_setup_item_for_insert(root, &path, &key, value_len);
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	btrfs_set_file_extent_generation(leaf, fi, 1);
 	btrfs_set_file_extent_type(leaf, fi, type);
@@ -63,7 +63,7 @@ static void insert_inode_item_key(struct btrfs_root *root)
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	setup_item_for_insert(root, &path, &key, value_len);
+	btrfs_setup_item_for_insert(root, &path, &key, value_len);
 }
 
 /*
-- 
2.33.0

