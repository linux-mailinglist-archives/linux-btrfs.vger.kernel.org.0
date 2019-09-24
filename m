Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D352BD0B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfIXRdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730693AbfIXRdH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:33:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AED69AF61;
        Tue, 24 Sep 2019 17:33:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DBC3DA835; Tue, 24 Sep 2019 19:33:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: move btrfs_unlock_up_safe to other locking functions
Date:   Tue, 24 Sep 2019 19:33:26 +0200
Message-Id: <565d96dc91bae7042a246170c4839b93ca30adf3.1569345962.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569345962.git.dsterba@suse.com>
References: <cover.1569345962.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function belongs to the family of locking functions, so move it
there. The 'noinline' keyword is dropped as it's now an exported
function that does not need it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c         | 26 --------------------------
 fs/btrfs/ctree.h         |  1 -
 fs/btrfs/delayed-inode.c |  1 +
 fs/btrfs/locking.c       | 26 ++++++++++++++++++++++++++
 fs/btrfs/locking.h       |  1 +
 5 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a55d55e5c913..f2f9cf1149a4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2353,32 +2353,6 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
 	}
 }
 
-/*
- * This releases any locks held in the path starting at level and
- * going all the way up to the root.
- *
- * btrfs_search_slot will keep the lock held on higher nodes in a few
- * corner cases, such as COW of the block at slot zero in the node.  This
- * ignores those rules, and it should only be called when there are no
- * more updates to be done higher up in the tree.
- */
-noinline void btrfs_unlock_up_safe(struct btrfs_path *path, int level)
-{
-	int i;
-
-	if (path->keep_locks)
-		return;
-
-	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
-		if (!path->nodes[i])
-			continue;
-		if (!path->locks[i])
-			continue;
-		btrfs_tree_unlock_rw(path->nodes[i], path->locks[i]);
-		path->locks[i] = 0;
-	}
-}
-
 /*
  * helper function for btrfs_search_slot.  The goal is to find a block
  * in cache without setting the path to blocking.  If we find the block
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e7ff169683c..4bf0433b1179 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2571,7 +2571,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
-void btrfs_set_path_blocking(struct btrfs_path *p);
 void btrfs_unlock_up_safe(struct btrfs_path *p, int level);
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 49ec3402886a..942cc2a59164 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -12,6 +12,7 @@
 #include "transaction.h"
 #include "ctree.h"
 #include "qgroup.h"
+#include "locking.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index f58606887859..93146b495276 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -342,3 +342,29 @@ void btrfs_set_path_blocking(struct btrfs_path *p)
 		}
 	}
 }
+
+/*
+ * This releases any locks held in the path starting at level and going all the
+ * way up to the root.
+ *
+ * btrfs_search_slot will keep the lock held on higher nodes in a few corner
+ * cases, such as COW of the block at slot zero in the node.  This ignores
+ * those rules, and it should only be called when there are no more updates to
+ * be done higher up in the tree.
+ */
+void btrfs_unlock_up_safe(struct btrfs_path *path, int level)
+{
+	int i;
+
+	if (path->keep_locks)
+		return;
+
+	for (i = level; i < BTRFS_MAX_LEVEL; i++) {
+		if (!path->nodes[i])
+			continue;
+		if (!path->locks[i])
+			continue;
+		btrfs_tree_unlock_rw(path->nodes[i], path->locks[i]);
+		path->locks[i] = 0;
+	}
+}
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 98c92222eaf0..21a285883e89 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -34,6 +34,7 @@ static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 #endif
 
 void btrfs_set_path_blocking(struct btrfs_path *p);
+void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
 
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
-- 
2.23.0

