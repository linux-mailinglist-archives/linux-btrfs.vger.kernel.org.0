Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A489CBD0B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501973AbfIXRdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:33:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730714AbfIXRdC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26A3FAFCE;
        Tue, 24 Sep 2019 17:33:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5BBCDA835; Tue, 24 Sep 2019 19:33:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: make btrfs_assert_tree_locked static inline
Date:   Tue, 24 Sep 2019 19:33:21 +0200
Message-Id: <1bc28a2a9768809f1ecfb3d908df30b14130419c.1569345962.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569345962.git.dsterba@suse.com>
References: <cover.1569345962.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_assert_tree_locked is used outside of the locking
code so it is exported, however we can make it static inine as it's
fairly trivial.

This is the only locking assertion used in release builds, inlining
improves the text size by 174 bytes and reduces stack consumption in the
callers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c |  6 ------
 fs/btrfs/locking.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 409c5a865079..028513153ac4 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -67,11 +67,6 @@ static inline void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb)
 	eb->write_locks--;
 }
 
-void btrfs_assert_tree_locked(struct extent_buffer *eb)
-{
-	BUG_ON(!eb->write_locks);
-}
-
 #else
 static void btrfs_assert_spinning_writers_get(struct extent_buffer *eb) { }
 static void btrfs_assert_spinning_writers_put(struct extent_buffer *eb) { }
@@ -81,7 +76,6 @@ static void btrfs_assert_spinning_readers_get(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_read_locked(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_read_locks_get(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_read_locks_put(struct extent_buffer *eb) { }
-void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
 #endif
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index b775a4207ed9..ab4020de25e7 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_LOCKING_H
 #define BTRFS_LOCKING_H
 
+#include "extent_io.h"
+
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
 #define BTRFS_WRITE_LOCK_BLOCKING 3
@@ -19,11 +21,17 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
 void btrfs_set_lock_blocking_read(struct extent_buffer *eb);
 void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
-void btrfs_assert_tree_locked(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb);
 
+#ifdef CONFIG_BTRFS_DEBUG
+static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
+	BUG_ON(!eb->write_locks);
+}
+#else
+static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
+#endif
 
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
-- 
2.23.0

