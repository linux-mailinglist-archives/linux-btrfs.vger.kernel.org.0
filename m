Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF3153531
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBEQ1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 11:27:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:37128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEQ1I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 11:27:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 936CAAFD8;
        Wed,  5 Feb 2020 16:27:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A86ADA7E6; Wed,  5 Feb 2020 17:26:53 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: move root node locking helpers to locking.c
Date:   Wed,  5 Feb 2020 17:26:51 +0100
Message-Id: <20200205162651.32110-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helpers are related to locking so move them there, update comments.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c   | 38 --------------------------------------
 fs/btrfs/locking.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 968faaec0e39..b62721ac5ee8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -143,44 +143,6 @@ struct extent_buffer *btrfs_root_node(struct btrfs_root *root)
 	return eb;
 }
 
-/* loop around taking references on and locking the root node of the
- * tree until you end up with a lock on the root.  A locked buffer
- * is returned, with a reference held.
- */
-struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
-{
-	struct extent_buffer *eb;
-
-	while (1) {
-		eb = btrfs_root_node(root);
-		btrfs_tree_lock(eb);
-		if (eb == root->node)
-			break;
-		btrfs_tree_unlock(eb);
-		free_extent_buffer(eb);
-	}
-	return eb;
-}
-
-/* loop around taking references on and locking the root node of the
- * tree until you end up with a lock on the root.  A locked buffer
- * is returned, with a reference held.
- */
-struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
-{
-	struct extent_buffer *eb;
-
-	while (1) {
-		eb = btrfs_root_node(root);
-		btrfs_tree_read_lock(eb);
-		if (eb == root->node)
-			break;
-		btrfs_tree_read_unlock(eb);
-		free_extent_buffer(eb);
-	}
-	return eb;
-}
-
 /* cowonly root (everything not a reference counted cow subvolume), just get
  * put onto a simple dirty list.  transaction.c walks this to make sure they
  * get properly updated on disk.
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 571c4826c428..e713900f96b6 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -523,3 +523,45 @@ void btrfs_unlock_up_safe(struct btrfs_path *path, int level)
 		path->locks[i] = 0;
 	}
 }
+
+/*
+ * Loop around taking references on and locking the root node of the tree until
+ * we end up with a lock on the root node.
+ *
+ * Return: root extent buffer with write lock held
+ */
+struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
+{
+	struct extent_buffer *eb;
+
+	while (1) {
+		eb = btrfs_root_node(root);
+		btrfs_tree_lock(eb);
+		if (eb == root->node)
+			break;
+		btrfs_tree_unlock(eb);
+		free_extent_buffer(eb);
+	}
+	return eb;
+}
+
+/*
+ * Loop around taking references on and locking the root node of the tree until
+ * we end up with a lock on the root node.
+ *
+ * Return: root extent buffer with read lock held
+ */
+struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
+{
+	struct extent_buffer *eb;
+
+	while (1) {
+		eb = btrfs_root_node(root);
+		btrfs_tree_read_lock(eb);
+		if (eb == root->node)
+			break;
+		btrfs_tree_read_unlock(eb);
+		free_extent_buffer(eb);
+	}
+	return eb;
+}
-- 
2.24.0

