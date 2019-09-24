Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE46BD0B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbfIXRdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:33:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730714AbfIXRdE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:33:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 650A9AF5A;
        Tue, 24 Sep 2019 17:33:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42E87DA835; Tue, 24 Sep 2019 19:33:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: move btrfs_set_path_blocking to other locking functions
Date:   Tue, 24 Sep 2019 19:33:24 +0200
Message-Id: <25f9e827d1677c9423c630bc948c12629729b2c1.1569345962.git.dsterba@suse.com>
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
 fs/btrfs/ctree.c   | 25 -------------------------
 fs/btrfs/locking.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/locking.h |  2 ++
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0231141de289..a55d55e5c913 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -56,31 +56,6 @@ struct btrfs_path *btrfs_alloc_path(void)
 	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
 }
 
-/*
- * set all locked nodes in the path to blocking locks.  This should
- * be done before scheduling
- */
-noinline void btrfs_set_path_blocking(struct btrfs_path *p)
-{
-	int i;
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		if (!p->nodes[i] || !p->locks[i])
-			continue;
-		/*
-		 * If we currently have a spinning reader or writer lock this
-		 * will bump the count of blocking holders and drop the
-		 * spinlock.
-		 */
-		if (p->locks[i] == BTRFS_READ_LOCK) {
-			btrfs_set_lock_blocking_read(p->nodes[i]);
-			p->locks[i] = BTRFS_READ_LOCK_BLOCKING;
-		} else if (p->locks[i] == BTRFS_WRITE_LOCK) {
-			btrfs_set_lock_blocking_write(p->nodes[i]);
-			p->locks[i] = BTRFS_WRITE_LOCK_BLOCKING;
-		}
-	}
-}
-
 /* this also releases the path */
 void btrfs_free_path(struct btrfs_path *p)
 {
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 028513153ac4..f58606887859 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -316,3 +316,29 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 		write_unlock(&eb->lock);
 	}
 }
+
+/*
+ * Set all locked nodes in the path to blocking locks.  This should be done
+ * before scheduling
+ */
+void btrfs_set_path_blocking(struct btrfs_path *p)
+{
+	int i;
+
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+		if (!p->nodes[i] || !p->locks[i])
+			continue;
+		/*
+		 * If we currently have a spinning reader or writer lock this
+		 * will bump the count of blocking holders and drop the
+		 * spinlock.
+		 */
+		if (p->locks[i] == BTRFS_READ_LOCK) {
+			btrfs_set_lock_blocking_read(p->nodes[i]);
+			p->locks[i] = BTRFS_READ_LOCK_BLOCKING;
+		} else if (p->locks[i] == BTRFS_WRITE_LOCK) {
+			btrfs_set_lock_blocking_write(p->nodes[i]);
+			p->locks[i] = BTRFS_WRITE_LOCK_BLOCKING;
+		}
+	}
+}
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index ab4020de25e7..98c92222eaf0 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -33,6 +33,8 @@ static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 #endif
 
+void btrfs_set_path_blocking(struct btrfs_path *p);
+
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
 	if (rw == BTRFS_WRITE_LOCK || rw == BTRFS_WRITE_LOCK_BLOCKING)
-- 
2.23.0

