Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217CB3B063D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVN4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 09:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFVN4d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 09:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B2E6138C;
        Tue, 22 Jun 2021 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624370057;
        bh=TN76ArjfxqMpN+IKoZ2lzyCouSHGlcSq++H8SA/jLus=;
        h=From:To:Cc:Subject:Date:From;
        b=uMywfaBEtc6l04MC6n1fF7KoDPbCg+Xfa6FqRzuNVNsT0bWk7jUbkTujxuxoERZAA
         z3rBLcvteT157xzYU5He0rmDbRWJMUnavDqFqL0K8xYIgGXyY8GL22V7izs4lgiNLb
         XJ9SWGQVDm0PYURljKR98jqGUPwmt0D/tUzdApS7zNAWHEFf0Wzsxi6jzIWdx0wLOJ
         GmRuNZIZGk3+GudeuY4QE5vOzs9g42LIRbBHXiq2mtsUr2UxnRE8KJlw0WK7rg8y2F
         xgsU4Wtiqb6fQT7mQpL/JwKE5OLEwJjKt7+Vbk3bs1cEqtZ7SRx/gN0YC6ciL9nqHg
         MaoSncCvAoTnA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     naohiro.aota@wdc.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix deadlock with concurrent chunk allocations involving system chunks
Date:   Tue, 22 Jun 2021 14:54:10 +0100
Message-Id: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a task attempting to allocate a new chunk verifies that there is not
currently enough free space in the system space_info and there is another
task that allocated a new system chunk but it did not finish yet the
creation of the respective block group, it waits for that other task to
finish creating the block group. This is to avoid exhaustion of the system
chunk array in the superblock, which is limited, when we have a thundering
herd of tasks allocating new chunks. This problem was described and fixed
by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
due to concurrent allocations").

However there are two very similar scenarios where this can lead to a
deadlock:

1) Task B allocated a new system chunk and task A is waiting on task B
   to finish creation of the respective system block group. However before
   task B ends its transaction handle and finishes the creation of the
   system block group, it attempts to allocate another chunk (like a data
   chunk for an fallocate operation for a very large range). Task B will
   be unable to progress and allocate the new chunk, because task A set
   space_info->chunk_alloc to 1 and therefore it loops at
   btrfs_chunk_alloc() waiting for task A to finish its chunk allocation
   and set space_info->chunk_alloc to 0, but task A is waiting on task B
   to finish creation of the new system block group, therefore resulting
   in a deadlock;

2) Task B allocated a new system chunk and task A is waiting on task B to
   finish creation of the respective system block group. By the time that
   task B enter the final phase of block group allocation, which happens
   at btrfs_create_pending_block_groups(), when it modifies the extent
   tree, the device tree or the chunk tree to insert the items for some
   new block group, it needs to allocate a new chunk, so it ends up at
   btrfs_chunk_alloc() and keeps looping there because task A has set
   space_info->chunk_alloc to 1, but task A is waiting for task B to
   finish creation of the new system block group and release the reserved
   system space, therefore resulting in a deadlock.

In short, the problem is if a task B needs to allocate a new chunk after
it previously allocated a new system chunk and if another task A is
currently waiting for task B to complete the allocation of the new system
chunk.

Fix this by making a task that previously allocated a new system chunk to
not loop at btrfs_chunk_alloc() and proceed if there is another task that
is waiting for it.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7liz@naota-xeon/
Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array due to concurrent allocations")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 46 +++++++++++++++++++++++++++++++++---------
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/transaction.h |  2 ++
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cbcb3ec99e3f..780963bcb3b0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3241,6 +3241,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	struct btrfs_space_info *space_info;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
+	bool reset_alloc_state = true;
 	int ret = 0;
 
 	/* Don't re-enter if we're already allocating a chunk */
@@ -3267,16 +3268,37 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			spin_unlock(&space_info->lock);
 			return 0;
 		} else if (space_info->chunk_alloc) {
-			/*
-			 * Someone is already allocating, so we need to block
-			 * until this someone is finished and then loop to
-			 * recheck if we should continue with our allocation
-			 * attempt.
-			 */
-			wait_for_alloc = true;
 			spin_unlock(&space_info->lock);
-			mutex_lock(&fs_info->chunk_mutex);
-			mutex_unlock(&fs_info->chunk_mutex);
+			if (trans->chunk_bytes_reserved > 0) {
+				/*
+				 * If we have previously allocated a system chunk
+				 * and there is at least one other task waiting
+				 * for us to finish allocation of that chunk and
+				 * release reserved space, do not wait for that
+				 * task because it is waiting on us. Otherwise,
+				 * just wait for the task currently allocating a
+				 * chunk to finish, just like when we have not
+				 * previously allocated a system chunk.
+				 */
+				mutex_lock(&fs_info->chunk_mutex);
+				if (trans->transaction->chunk_reserve_waiters > 0) {
+					reset_alloc_state = false;
+					goto do_alloc;
+				} else {
+					wait_for_alloc = true;
+				}
+				mutex_unlock(&fs_info->chunk_mutex);
+			} else {
+				/*
+				 * Someone is already allocating, so we need to
+				 * block until this someone is finished and then
+				 * loop to recheck if we should continue with our
+				 * allocation attempt.
+				 */
+				wait_for_alloc = true;
+				mutex_lock(&fs_info->chunk_mutex);
+				mutex_unlock(&fs_info->chunk_mutex);
+			}
 		} else {
 			/* Proceed with allocation */
 			space_info->chunk_alloc = 1;
@@ -3288,6 +3310,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	} while (wait_for_alloc);
 
 	mutex_lock(&fs_info->chunk_mutex);
+do_alloc:
 	trans->allocating_chunk = true;
 
 	/*
@@ -3331,7 +3354,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
 out:
-	space_info->chunk_alloc = 0;
+	if (reset_alloc_state)
+		space_info->chunk_alloc = 0;
 	spin_unlock(&space_info->lock);
 	mutex_unlock(&fs_info->chunk_mutex);
 	/*
@@ -3449,11 +3473,13 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 		if (reserved > trans->chunk_bytes_reserved) {
 			const u64 min_needed = reserved - thresh;
 
+			cur_trans->chunk_reserve_waiters++;
 			mutex_unlock(&fs_info->chunk_mutex);
 			wait_event(cur_trans->chunk_reserve_wait,
 			   atomic64_read(&cur_trans->chunk_bytes_reserved) <=
 			   min_needed);
 			mutex_lock(&fs_info->chunk_mutex);
+			cur_trans->chunk_reserve_waiters--;
 			goto again;
 		}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 143f7a5dec30..2d02f4bb011a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -388,6 +388,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	atomic64_set(&cur_trans->chunk_bytes_reserved, 0);
 	init_waitqueue_head(&cur_trans->chunk_reserve_wait);
+	cur_trans->chunk_reserve_waiters = 0;
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 07d76029f598..fcbf26521de0 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -103,6 +103,8 @@ struct btrfs_transaction {
 	 */
 	atomic64_t chunk_bytes_reserved;
 	wait_queue_head_t chunk_reserve_wait;
+	/* Protected by fs_info->chunk_mutex. */
+	unsigned int chunk_reserve_waiters;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
-- 
2.28.0

