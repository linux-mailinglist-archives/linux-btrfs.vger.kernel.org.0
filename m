Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261D07491A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbfGYI1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 04:27:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389592AbfGYI1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 04:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 443A2AF94
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 08:27:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Remove unused locking functions
Date:   Thu, 25 Jul 2019 11:27:28 +0300
Message-Id: <20190725082729.14109-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725082729.14109-1-nborisov@suse.com>
References: <20190725082729.14109-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those were split out of btrfs_clear_lock_blocking_rw by
aa12c02778a9 ("btrfs: split btrfs_clear_lock_blocking_rw to read and write helpers")
however at that time this function was unused due to commit
523983401644 ("Btrfs: kill btrfs_clear_path_blocking"). Put the final
nail in the coffin of those 2 functions.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/locking.c           | 36 ------------------------------------
 fs/btrfs/locking.h           |  2 --
 include/trace/events/btrfs.h |  2 --
 3 files changed, 40 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index fe21bfc4e787..ceb23690b89b 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -119,42 +119,6 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	}
 }
 
-void btrfs_clear_lock_blocking_read(struct extent_buffer *eb)
-{
-	trace_btrfs_clear_lock_blocking_read(eb);
-	/*
-	 * No lock is required.  The lock owner may change if we have a read
-	 * lock, but it won't change to or away from us.  If we have the write
-	 * lock, we are the owner and it'll never change.
-	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
-		return;
-	BUG_ON(atomic_read(&eb->blocking_readers) == 0);
-	read_lock(&eb->lock);
-	btrfs_assert_spinning_readers_get(eb);
-	/* atomic_dec_and_test implies a barrier */
-	if (atomic_dec_and_test(&eb->blocking_readers))
-		cond_wake_up_nomb(&eb->read_lock_wq);
-}
-
-void btrfs_clear_lock_blocking_write(struct extent_buffer *eb)
-{
-	trace_btrfs_clear_lock_blocking_write(eb);
-	/*
-	 * no lock is required.  The lock owner may change if
-	 * we have a read lock, but it won't change to or away
-	 * from us.  If we have the write lock, we are the owner
-	 * and it'll never change.
-	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
-		return;
-	write_lock(&eb->lock);
-	BUG_ON(eb->blocking_writers != 1);
-	btrfs_assert_spinning_writers_get(eb);
-	if (--eb->blocking_writers == 0)
-		cond_wake_up(&eb->write_lock_wq);
-}
-
 /*
  * take a spinning read lock.  This will wait for any blocking
  * writers
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 27627d4fd3a9..6ee384027b94 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -24,8 +24,6 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
 void btrfs_set_lock_blocking_read(struct extent_buffer *eb);
 void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
-void btrfs_clear_lock_blocking_read(struct extent_buffer *eb);
-void btrfs_clear_lock_blocking_write(struct extent_buffer *eb);
 void btrfs_assert_tree_locked(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 2f6a669408bb..5cb95646b94e 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2086,8 +2086,6 @@ DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock_blocking);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_read);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_write);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_clear_lock_blocking_read);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_clear_lock_blocking_write);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_read_lock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_write_lock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_lock_atomic);
-- 
2.17.1

