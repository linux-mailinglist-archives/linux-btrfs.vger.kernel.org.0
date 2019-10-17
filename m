Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF36DB7A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436849AbfJQTiw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 15:38:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436676AbfJQTiw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 15:38:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D51DAAFBB;
        Thu, 17 Oct 2019 19:38:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 077BFDA808; Thu, 17 Oct 2019 21:39:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: serialize blocking_writers updates
Date:   Thu, 17 Oct 2019 21:39:00 +0200
Message-Id: <2a310858bfa3754f6f7a4d4b7693959b0fdd7005.1571340084.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571340084.git.dsterba@suse.com>
References: <cover.1571340084.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's one potential memory ordering problem regarding
eb::blocking_writers, although this hasn't been hit in practice. On TSO
(total store ordering) architectures, the writes will always be seen in
right order.

In case the calls in btrfs_set_lock_blocking_write are seen in this
(wrong) order on another CPU:

0:  /* blocking_writers == 0 */
1:  write_unlock()
2:  blocking_writers = 1

btrfs_try_tree_read_lock, btrfs_tree_read_lock_atomic or
btrfs_try_tree_write_lock would have to squeeze all of this between 1:
and 2:

- check if blocking_writers is 0 (it is, continue)
- try read lock, read lock or write lock (succeeds after 1:)
- check blocking_writers again (continue)

All of that assumes that the reordered writes can survive for quite some
time (unlikely if its in the internal store buffer).

Another point against observing that in practice is that
blocking_writers and the lock are on the same cacheline (64B), so it's
more likely both values are stored in order, or some sort of pending
write flush will update blocking_writers, rwlock before the try lock
happens. Assuming the CPUs work like that and don't hide other
surprises.

struct extent_buffer {
	u64                        start;                /*     0     8 */
	long unsigned int          len;                  /*     8     8 */
	long unsigned int          bflags;               /*    16     8 */
	struct btrfs_fs_info *     fs_info;              /*    24     8 */
	spinlock_t                 refs_lock;            /*    32     4 */
	atomic_t                   refs;                 /*    36     4 */
	atomic_t                   io_pages;             /*    40     4 */
	int                        read_mirror;          /*    44     4 */
	struct callback_head callback_head __attribute__((__aligned__(8))); /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	pid_t                      lock_owner;           /*    64     4 */
	int                        blocking_writers;     /*    68     4 */
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	atomic_t                   blocking_readers;     /*    72     4 */
	bool                       lock_nested;          /*    76     1 */

	/* XXX 1 byte hole, try to pack */

	short int                  log_index;            /*    78     2 */
	rwlock_t                   lock;                 /*    80     8 */
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	wait_queue_head_t          write_lock_wq;        /*    88    24 */
	wait_queue_head_t          read_lock_wq;         /*   112    24 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	struct page *              pages[16];            /*   136   128 */

	/* size: 264, cachelines: 5, members: 18 */
	/* sum members: 263, holes: 1, sum holes: 1 */
	/* forced alignments: 1 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

Add the barriers for correctness sake.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index a12f3edc3505..e0e0430577aa 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -110,6 +110,18 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 		btrfs_assert_spinning_writers_put(eb);
 		btrfs_assert_tree_locked(eb);
 		WRITE_ONCE(eb->blocking_writers, 1);
+		/*
+		 * Writers must be be updated before the lock is released so
+		 * that other threads see that in order. Otherwise this could
+		 * theoretically lead to blocking_writers be still set to 1 but
+		 * this would be unexpected eg. for spinning locks.
+		 *
+		 * There are no pairing read barriers for unlocked access as we
+		 * don't strictly need them for correctness (eg. in
+		 * btrfs_try_tree_read_lock), and the unlock/lock is an implied
+		 * barrier in other cases.
+		 */
+		smp_wmb();
 		write_unlock(&eb->lock);
 	}
 }
@@ -316,7 +328,9 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 		/*
 		 * We need to order modifying blocking_writers above with
 		 * actually waking up the sleepers to ensure they see the
-		 * updated value of blocking_writers
+		 * updated value of blocking_writers.
+		 *
+		 * cond_wake_up calls smp_mb
 		 */
 		cond_wake_up(&eb->write_lock_wq);
 	} else {
-- 
2.23.0

