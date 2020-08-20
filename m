Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2D24C26C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgHTPqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTPqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118DC061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so1927592qkb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XPBJkScxoAnO/ac31Yy+v74TVg3p7O6mcx0+7yGTUEM=;
        b=MWaunHlH95yyO1TQysjdmzJ0nOL21P9sr6Tw0My6CHgbxeLPopFx5G0tS4WDJnIA9O
         g6tKI+W7TocV0BwixFinmN3qjTxvR0K7soUwlMdI7ZMh5NjBrYc5HxzGOgzYe8yQN9/3
         ZcTBf28tZbFsg5Rc+LuBWx3t7JlFSS+xXw4VSzsyDwAG4GzjAXNdLfLdbdaTPvg8eKDD
         hkZ66N9Jv+H/57UJkdLGhEFKNoNr63udXI5+johwuGm939YXs1Vd5bxkJuIuJhT+cucN
         7+z5UDbQWaDvtDZXgNrPd7jHnmR1R2pTrhDihQo+CBL/WTdfXJE4UZzqQsIOXMLLZwRx
         eAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPBJkScxoAnO/ac31Yy+v74TVg3p7O6mcx0+7yGTUEM=;
        b=F6X0/RUhg4XwKMkDaufJp5cNwnYbM/rNVbEgC8NWRCiC/8Ael3AJztX2KsiMnvvrj9
         85E00Hk1FxBlxN6oMuTobMH3jGrQEg2ud6yHRWmTiHKktStFaLrOmyvHbNu2XFiIc1AQ
         nmMatE4xhmlbjYukaW9L4wZtQb76ebbwQSMoJ/4tz6C8W0qPQ+P6OsGVENmgk29UQX6G
         yD9gCiDOvNrMmuPi4EiabcSWzgCnKIQqEv9v4/kMM0aKg/mzkksgLq7CSJHoPWMZXLfE
         h8WsjHuMd5xTFMOSPLyR7gY6C+rgJn4KglmA70IDSapmhtpv+M1nitYB4ZW4GETDMYM/
         sxIg==
X-Gm-Message-State: AOAM532GE7yJMNvP3m5XBiIvDnLzrf4KQ+bQ6Ijn5TJaPodgCU6QjuIE
        d3CCdQsADVpwS0dx7EWJ+ECg2mN0aOo/037D
X-Google-Smtp-Source: ABdhPJxYSWYyTEq6GB51I+yi0q7aO3cFRvOGB3FU2zdqUeNKbj2arIwGXFd3mHCCYammslElzSY2ng==
X-Received: by 2002:a37:9987:: with SMTP id b129mr3090510qke.315.1597938376392;
        Thu, 20 Aug 2020 08:46:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i14sm3244108qtq.33.2020.08.20.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/12] btrfs: rename eb->lock_nested to eb->lock_recursed
Date:   Thu, 20 Aug 2020 11:46:00 -0400
Message-Id: <298c752d60239ae7e2832de6d2a3cfc46fd88f71.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nested locking with lockdep and everything else refers to lock hierarchy
within the same lock map.  This is how we indicate the same locks for
different objects are ok to take in a specific order, for our use case
that would be to take the lock on a leaf and then take a lock on an
adjacent leaf.

What ->lock_nested _actually_ refers to is if we happen to already be
holding the write lock on the extent buffer and we're allowing a read
lock to be taken on that extent buffer, which is recursion.  Rename this
so we don't get confused when we switch to a rwsem and have to start
using the _nested helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/locking.c   | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0320ddb0133e..35a095ed694a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4990,7 +4990,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	rwlock_init(&eb->lock);
 	atomic_set(&eb->blocking_readers, 0);
 	eb->blocking_writers = 0;
-	eb->lock_nested = false;
+	eb->lock_recursed = false;
 	init_waitqueue_head(&eb->write_lock_wq);
 	init_waitqueue_head(&eb->read_lock_wq);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 30794ae58498..9e1e22f1586a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -102,7 +102,7 @@ struct extent_buffer {
 
 	int blocking_writers;
 	atomic_t blocking_readers;
-	bool lock_nested;
+	bool lock_recursed;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	short log_index;
 
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index f75612e18a82..8e3d107a6192 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,7 +57,7 @@
  * performance reasons.
  *
  *
- * Lock nesting
+ * Lock recursion
  * ------------
  *
  * A write operation on a tree might indirectly start a look up on the same
@@ -201,7 +201,7 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 	 * lock, but it won't change to or away from us.  If we have the write
 	 * lock, we are the owner and it'll never change.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
+	if (eb->lock_recursed && current->pid == eb->lock_owner)
 		return;
 	btrfs_assert_tree_read_locked(eb);
 	atomic_inc(&eb->blocking_readers);
@@ -225,7 +225,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	 * lock, but it won't change to or away from us.  If we have the write
 	 * lock, we are the owner and it'll never change.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
+	if (eb->lock_recursed && current->pid == eb->lock_owner)
 		return;
 	if (eb->blocking_writers == 0) {
 		btrfs_assert_spinning_writers_put(eb);
@@ -263,8 +263,8 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 			 * depends on this as it may be called on a partly
 			 * (write-)locked tree.
 			 */
-			BUG_ON(eb->lock_nested);
-			eb->lock_nested = true;
+			BUG_ON(eb->lock_recursed);
+			eb->lock_recursed = true;
 			read_unlock(&eb->lock);
 			trace_btrfs_tree_read_lock(eb, start_ns);
 			return;
@@ -362,11 +362,11 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 	/*
 	 * if we're nested, we have the write lock.  No new locking
 	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_nested
+	 * The write unlock will do a barrier for us, and the lock_recursed
 	 * field only matters to the lock owner.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner) {
-		eb->lock_nested = false;
+	if (eb->lock_recursed && current->pid == eb->lock_owner) {
+		eb->lock_recursed = false;
 		return;
 	}
 	btrfs_assert_tree_read_locked(eb);
@@ -388,11 +388,11 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
 	/*
 	 * if we're nested, we have the write lock.  No new locking
 	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_nested
+	 * The write unlock will do a barrier for us, and the lock_recursed
 	 * field only matters to the lock owner.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner) {
-		eb->lock_nested = false;
+	if (eb->lock_recursed && current->pid == eb->lock_owner) {
+		eb->lock_recursed = false;
 		return;
 	}
 	btrfs_assert_tree_read_locked(eb);
-- 
2.24.1

