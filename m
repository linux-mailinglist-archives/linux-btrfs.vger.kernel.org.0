Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5553971365
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbfGWH52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 03:57:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731735AbfGWH51 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 03:57:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DB20AECD
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2019 07:57:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: extent-tree: Add comment for walk_control to explain how btrfs drops a subvolume.
Date:   Tue, 23 Jul 2019 15:57:21 +0800
Message-Id: <20190723075721.9383-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs uses several different ways to drop a subvolume. Some methods are
designed to reduce the modification to extent tree.
This design can be very confusing if not familiar with
btrfs_drop_snapshot().

Before wasting time of newcomers, just add some explanation.

Also add some basic comment for members of struct walk_control.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5faf057f6f37..8134273b9b88 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8617,14 +8617,84 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	return ERR_PTR(ret);
 }
 
+/*
+ * Btrfs tree walk control for dropping subvolume.
+ *
+ * Btrfs uses btrfs_root_item::drop_level and btrfs_root_item::drop_level
+ * to record where *next* should resume from.
+ *
+ * Btrfs uses several different ways to optimize subvolume deleting.
+ * All the following cases uses the same example tree:
+ * Root->root_key.object = 300
+ *       A	<- tree root, level 2
+ *      / \
+ *     B   C    <- tree nodes, level 1
+ *    / \ / \
+ *    D E F G   <- tree leaves, level 0
+ *
+ * 1) Basic dropping.
+ *    All above tree blocks are owned exclusively.
+ *    Drop tree blocks using LRN iteration.
+ *    Tree drop sequence is: D E B F C G A.
+ *
+ * 2) Dropping highest owned tree block.
+ *    In this example, we have tree 299, also owning tree block B and C
+ *    directly. (Root 299 only exists in this example)
+ *    Root 300 is a snapshot of root 299, no modification between them.
+ *
+ *    In this case, we only need to drop references of B, C
+ *    Tree drop sequence is: B, C
+ *
+ * 3) Convert to FULL_BACKREF, then back to 2)
+ *    For example, we have tree 301, also owning tree block B and C
+ *    directly. (Root 301 only exists in this example)
+ *    Root 301 is a snapshot of root 300, no modification between them.
+ *
+ *    In this case, we can't just drop reference to tree block B and C.
+ *    As in extent tree, tree block D~G are still referred by tree 300, e.g:
+ *            item XX key (bytenr_of_D METADATA_ITEM 0)
+ *              refs 1 gen 8 flags TREE_BLOCK
+ *              tree block skinny level 0
+ *              tree block backref root 300 <<
+ *
+ *    In this case, we convert such tree backref to FULL_BACKREF, which only
+ *    records its parent, so the new backref would look like:
+ *            item XX key (bytenr_of_D METADATA_ITEM 0) itemoff 3449 itemsize 33
+ *              refs 1 gen 8 flags TREE_BLOCK|FULL_BACKREF
+ *              tree block skinny level 0
+ *              shared block backref parent bytenr_of_B
+ *
+ *    By this, we can go back to 2) to drop the minimal number of backref.
+ */
 struct walk_control {
+	/* Number of direct owners of path->nodes[level]. */
 	u64 refs[BTRFS_MAX_LEVEL];
+
+	/* Backref flags, can be either TREE_BLOCK or TREE_BLOCK|FULL_BACKREF */
 	u64 flags[BTRFS_MAX_LEVEL];
+
+	/* Key of next location to update backrefs, in-memory only */
 	struct btrfs_key update_progress;
+
+	/* Key of next location to drop reference */
 	struct btrfs_key drop_progress;
+
+	/* Current drop kevel, used with drop_progress */
 	int drop_level;
+
+	/*
+	 * Either DROP_REFERENCE or UPDATE_BACKREF
+	 *
+	 * In DROP_REFERENCE stage, we drop reference of the target tree block.
+	 * In UPDATE_BACKREF stage, we convert the backref to FULL_BACKREF of
+	 * the target subtree.
+	 */
 	int stage;
+
+	/* Current working level, shared between both stages */
 	int level;
+
+	/* Where the shared node is for case 3) */
 	int shared_level;
 	int update_ref;
 	int keep_locks;
-- 
2.22.0

