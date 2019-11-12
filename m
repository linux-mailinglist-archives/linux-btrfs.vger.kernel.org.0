Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375E1F93C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 16:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLPNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 10:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLPNh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 10:13:37 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254582067B
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573571615;
        bh=5JzTRqun53V2lyzxq0pZaX0TettkReS5Q2g9Wt6qqWM=;
        h=From:To:Subject:Date:From;
        b=C/i19Ke0rYNrbHlrWmF+kjT1ZwOZgGsZNdg0GODG/DSxHqrgWHkHQU2mKasBf7lCI
         CDS2TJOBZeMNgRG1tM6Ksp+SDmZwnWS1jgLRyt6/IUgpnzRUJjLvnY2biPaJywjM87
         vcIrebzOztyZu4ZdKNA5oqeyu+Jq3k0UmVotO4oU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES
Date:   Tue, 12 Nov 2019 15:13:31 +0000
Message-Id: <20191112151331.3641-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the NO_HOLES feature, if we punch a hole into a file and then
fsync it, there is a case where a subsequent fsync will miss the fact that
a hole was punched:

1) The extent items of the inode span multiple leafs;

2) The hole covers a range that affects only the extent items of the first
   leaf;

3) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
   is set in the inode's runtime flags).

That results in the hole not existing after replaying the log tree.

For example, if the fs/subvolume tree has the following layout for a
particular inode:

  Leaf N, generation 10:

  [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]

  Leaf N + 1, generation 10:

  [ EXTENT_ITEM (128K 64K) ... ]

If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
up dropping the two extent items from leaf N, but we don't touch the other
leaf, so we end up in the following state:

  Leaf N, generation 11:

  [ ... INODE_ITEM INODE_REF ]

  Leaf N + 1, generation 10:

  [ EXTENT_ITEM (128K 64K) ... ]

A full fsync after punching the hole will only process leaf N because it
was modified in the current transaction, but not leaf N + 1, since it was
not modified in the current transaction (generation 10 and not 11). As
a result the fsync will not log any holes, because it didn't process any
leaf with extent items.

So fix this by detecting any leading hole in the file for a full fsync
when using the NO_HOLES feature if we didn't process any extent items for
the file.

A test case for fstests follows soon.

Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8a6cc600bf18..dfc07d23c903 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4807,6 +4807,68 @@ static int btrfs_log_trailing_hole(struct btrfs_trans_handle *trans,
 }
 
 /*
+ * When using the NO_HOLES feature we need special care to make sure we don't
+ * miss a hole that starts at file offset 0. If we have an inode with extent
+ * items spanning multiple leafs and we punch a hole covering only the extents
+ * in the first leaf, then the hole punching operation deletes those extent
+ * items from the leaf without touching the remaining leafs (unless the leaf
+ * becomes too small in which case we may move items from the first leaf to the
+ * second leaf) - this causes a full fsync to not copy any extent items and
+ * therefore not detect and log a hole starting at offset 0. We check for such
+ * scenario here and log the hole.
+ */
+static int btrfs_log_leading_hole(struct btrfs_trans_handle *trans,
+				  struct btrfs_root *root,
+				  struct btrfs_inode *inode,
+				  struct btrfs_path *path)
+{
+	struct btrfs_key key;
+	const u64 ino = btrfs_ino(inode);
+	u64 hole_len;
+	int ret;
+
+	if (!btrfs_fs_incompat(root->fs_info, NO_HOLES))
+		return 0;
+
+	if (i_size_read(&inode->vfs_inode) == 0)
+		return 0;
+
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = 0;
+
+	/*
+	 * If there's an extent item at file offset 0 we don't have anything
+	 * to do, just return.
+	 */
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret <= 0)
+		return ret;
+
+	/*
+	 * Figure out the size of the hole. If there is no next extent, just
+	 * exit without doing anything (if the file consists of a single hole,
+	 * has no extents, we log the hole at btrfs_log_trailing_hole()).
+	 */
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+		ret = btrfs_next_leaf(root, path);
+		if (ret < 0)
+			return ret;
+		else if (ret > 0)
+			return 0;
+	}
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
+		return 0;
+
+	hole_len = key.offset;
+	btrfs_release_path(path);
+	ret = btrfs_insert_file_extent(trans, root->log_root, ino, 0, 0, 0,
+				       hole_len, 0, hole_len, 0, 0, 0);
+	return ret;
+}
+
+/*
  * When we are logging a new inode X, check if it doesn't have a reference that
  * matches the reference from some other inode Y created in a past transaction
  * and that was renamed in the current transaction. If we don't do this, then at
@@ -5393,6 +5455,18 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (err)
 		goto out_unlock;
 	xattrs_logged = true;
+	/*
+	 * If we are doing a full fsync and didn't copy any extent items, we
+	 * may need to log a leading hole extent item when using the NO_HOLES
+	 * feature, otherwise we end up not persisting the hole.
+	 */
+	if (!fast_search && last_extent == 0) {
+		btrfs_release_path(path);
+		btrfs_release_path(dst_path);
+		err = btrfs_log_leading_hole(trans, root, inode, path);
+		if (err)
+			goto out_unlock;
+	}
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-- 
2.11.0

