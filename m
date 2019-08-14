Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C518C56A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfHNBEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHNBEs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B60DB0B6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: Introduce drop borderline for drop progress
Date:   Wed, 14 Aug 2019 09:04:39 +0800
Message-Id: <20190814010440.15186-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814010440.15186-1-wqu@suse.com>
References: <20190814010440.15186-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs kernel module drop its subvolume tree using post-order traversal,
this sometimes makes things harder to determine if we should print
one subtree.

For the full hassle it can lead to, please check the lengthy comment.

This patch will introduce a simple new facility, btrfs_drop_borderline,
to address the problem.

Currently the only user of such tree traversal is dump-tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.c | 31 +++++++++++++++++++++++++++++
 ctree.h | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/ctree.c b/ctree.c
index c97fbb40bb6e..59d0cb7ab89e 100644
--- a/ctree.c
+++ b/ctree.c
@@ -3233,3 +3233,34 @@ out:
 	btrfs_free_path(path);
 	return ret;
 }
+
+int btrfs_init_drop_borderline(struct btrfs_root *root,
+			       struct btrfs_drop_borderline *borderline)
+{
+	struct btrfs_path path;
+	struct btrfs_key drop_key;
+	int i;
+	int ret;
+
+	memset(borderline, 0, sizeof(*borderline));
+	btrfs_disk_key_to_cpu(&drop_key, &root->root_item.drop_progress);
+	if (is_empty_key(&drop_key) || root->root_item.drop_level == 0)
+		return 0;
+
+	btrfs_init_path(&path);
+	path.lowest_level = root->root_item.drop_level;
+
+	ret = btrfs_search_slot(NULL, root, &drop_key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+	ret = 0;
+
+	for (i = root->root_item.drop_level; i < BTRFS_MAX_LEVEL; i++) {
+		if (path.nodes[i])
+			btrfs_node_key_to_cpu(path.nodes[i],
+					&borderline->keys[i], path.slots[i]);
+	}
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
diff --git a/ctree.h b/ctree.h
index 0d12563b7261..ed4bfdac77eb 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1217,6 +1217,66 @@ struct btrfs_root {
 	struct rb_node rb_node;
 };
 
+/*
+ * drop progress indicator.
+ *
+ * Current kernel subvolume drop progress is post-order iteration of each
+ * level 1 node.
+ * We can't just easily compare a key of a node against root::drop_progress.
+ * E.g. The number is the first key of the tree block.
+ *     Level 3                 A (1)
+ *                        /         \
+ *     Level 2          B(1)         ...
+ *                  /   |   \
+ *     Level 1    C(1)  D(4)  E(7)
+ *               /|\   /|\   /|\
+ *     Level 0  F G H I J K L M N
+ *              1 2 3 4 5 6 7 8 9
+ * The number is the key of the leaf.
+ * The first key of B ~ D will be 1, 4, 7
+ *
+ * If we have drop progress of 5, tree blocks C F G H should haven been
+ * dropped. While A B D E J K L M N are still untouched.
+ *
+ * We can't simply compare the key of the a tree block against drop progress.
+ * Or D(4) will be considered already dropped.
+ * We can't simply compare the drop level, as it's always fixed to 1, while
+ * we have already dropped level 1 node C.
+ *
+ * What we need is a full path, at least a key for each level to mark the
+ * borderline. Here we don't use path is avoid holding tree blocks references.
+ *
+ * For above case, we need will create a borderline like:
+ * Level 4~7   0 (0 means not populated as no valid key is 0)
+ * Level 3     1
+ * Level 2     1
+ * Level 1     4
+ * (Level 0 makes no sense)
+ *
+ * Any tree block has smaller key than it's corresponding borderline key will
+ * be considered dropped.
+ *
+ * Currently, only btrfs check and print-tree need this feature.
+ * Kernel doesn't need to iterate a dropped tree, thus kernel has no need
+ * for such facility.
+ */
+struct btrfs_drop_borderline {
+       /*
+        * In theory, it can be BTRFS_MAX_LEVEL - 1, but that will be
+        * confusing against btrfs_path usage.
+        */
+       struct btrfs_key keys[BTRFS_MAX_LEVEL];
+};
+
+static inline bool is_empty_key(struct btrfs_key *key)
+{
+	if (key->objectid == 0 && key->type == 0 && key->offset == 0)
+		return true;
+	return false;
+}
+
+int btrfs_init_drop_borderline(struct btrfs_root *root,
+			       struct btrfs_drop_borderline *borderline);
 static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
 {
 	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
-- 
2.22.0

