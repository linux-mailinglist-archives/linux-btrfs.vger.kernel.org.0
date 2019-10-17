Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5691DB7A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 21:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436785AbfJQTiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 15:38:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436676AbfJQTit (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 15:38:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83761AFB0;
        Thu, 17 Oct 2019 19:38:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEAD3DA808; Thu, 17 Oct 2019 21:38:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: access eb::blocking_writers according to ACCESS_ONCE policies
Date:   Thu, 17 Oct 2019 21:38:58 +0200
Message-Id: <cb93f314165c09d91cbbeb7a1d4ee59b54496220.1571340084.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571340084.git.dsterba@suse.com>
References: <cover.1571340084.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A nice writeup of the LKMM (Linux Kernel Memory Model) rules for access
once policies can be found here
https://lwn.net/Articles/799218/#Access-Marking%20Policies .

The locked and unlocked access to eb::blocking_writers should be
annotated accordingly, following this:

Writes:

- locked write must use ONCE, may use plain read
- unlocked write must use ONCE

Reads:

- unlocked read must use ONCE
- locked read may use plain read iff not mixed with unlocked read
- unlocked read then locked must use ONCE

There's one difference on the assembly level, where
btrfs_tree_read_lock_atomic and btrfs_try_tree_read_lock used the cached
value and did not reevaluate it after taking the lock. This could have
missed some opportunities to take the lock in case blocking writers
changed between the calls, but the window is just a few instructions
long. As this is in try-lock, the callers handle that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 00edf91c3d1c..a12f3edc3505 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -109,7 +109,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	if (eb->blocking_writers == 0) {
 		btrfs_assert_spinning_writers_put(eb);
 		btrfs_assert_tree_locked(eb);
-		eb->blocking_writers = 1;
+		WRITE_ONCE(eb->blocking_writers, 1);
 		write_unlock(&eb->lock);
 	}
 }
@@ -145,7 +145,7 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 		}
 		read_unlock(&eb->lock);
 		wait_event(eb->write_lock_wq,
-			   eb->blocking_writers == 0);
+			   READ_ONCE(eb->blocking_writers) == 0);
 		goto again;
 	}
 	btrfs_assert_tree_read_locks_get(eb);
@@ -160,11 +160,12 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
  */
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
 {
-	if (eb->blocking_writers)
+	if (READ_ONCE(eb->blocking_writers))
 		return 0;
 
 	read_lock(&eb->lock);
-	if (eb->blocking_writers) {
+	/* Refetch value after lock */
+	if (READ_ONCE(eb->blocking_writers)) {
 		read_unlock(&eb->lock);
 		return 0;
 	}
@@ -180,13 +181,14 @@ int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
-	if (eb->blocking_writers)
+	if (READ_ONCE(eb->blocking_writers))
 		return 0;
 
 	if (!read_trylock(&eb->lock))
 		return 0;
 
-	if (eb->blocking_writers) {
+	/* Refetch value after lock */
+	if (READ_ONCE(eb->blocking_writers)) {
 		read_unlock(&eb->lock);
 		return 0;
 	}
@@ -202,11 +204,12 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
-	if (eb->blocking_writers || atomic_read(&eb->blocking_readers))
+	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers))
 		return 0;
 
 	write_lock(&eb->lock);
-	if (eb->blocking_writers || atomic_read(&eb->blocking_readers)) {
+	/* Refetch value after lock */
+	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers)) {
 		write_unlock(&eb->lock);
 		return 0;
 	}
@@ -277,9 +280,11 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 	WARN_ON(eb->lock_owner == current->pid);
 again:
 	wait_event(eb->read_lock_wq, atomic_read(&eb->blocking_readers) == 0);
-	wait_event(eb->write_lock_wq, eb->blocking_writers == 0);
+	wait_event(eb->write_lock_wq, READ_ONCE(eb->blocking_writers) == 0);
 	write_lock(&eb->lock);
-	if (atomic_read(&eb->blocking_readers) || eb->blocking_writers) {
+	/* Refetch value after lock */
+	if (atomic_read(&eb->blocking_readers) ||
+	    READ_ONCE(eb->blocking_writers)) {
 		write_unlock(&eb->lock);
 		goto again;
 	}
@@ -294,7 +299,8 @@ void btrfs_tree_lock(struct extent_buffer *eb)
  */
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
-	int blockers = eb->blocking_writers;
+	/* This is read both locked and unlocked */
+	int blockers = READ_ONCE(eb->blocking_writers);
 
 	BUG_ON(blockers > 1);
 
@@ -305,7 +311,8 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 
 	if (blockers) {
 		btrfs_assert_no_spinning_writers(eb);
-		eb->blocking_writers = 0;
+		/* Unlocked write */
+		WRITE_ONCE(eb->blocking_writers, 0);
 		/*
 		 * We need to order modifying blocking_writers above with
 		 * actually waking up the sleepers to ensure they see the
-- 
2.23.0

