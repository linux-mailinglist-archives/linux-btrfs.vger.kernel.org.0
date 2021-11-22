Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975A0458DF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhKVMGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 07:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMGs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 07:06:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 246CD601FC
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582621;
        bh=h2ZEl/J3JKq9Jyobqbwp0Oy+1uU33Sn9lU/1m24wMMI=;
        h=From:To:Subject:Date:From;
        b=b4uwbL+HzQb4t3xXd8wimDby0qHfNXsSWCYcY8HsUMBTus8wLZzy5SqYWD6yvyhwc
         gIDZRhz9xMxK6xnEZT9bGPglAqWtgzS4yE0UFnKCC3TirMLt9QAVfzWQ/4HZ+VnNWE
         0tmn8vsZXGh3qK0/pN4cnPe1S+JtXBylwDCNus3yaajIpsvRIdIDOdR3BTRSUVvHFY
         hvkjtG1CD49AM2jaIaq0/eSmfHzYJ7VY5YJbLmXyuVrZzYARs07DD31O+gQ6dXW/XB
         paIaKnyuQxmUMQImzGSUNNq5q2B/jV6zvJAagDjsbjqltbcH/5GGFWRH+iQdlj1D0Z
         00sQNBJnKD/gg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make send work with concurrent block group relocation
Date:   Mon, 22 Nov 2021 12:03:38 +0000
Message-Id: <5d89b416ce3cf1ee64a9f0f11a8fc5bab337ad22.1637582320.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We don't allow send and balance/relocation to run in parallel in order
to prevent send failing or silently producing some bad stream. This is
because while send is using an extent (specially metadata) or about to
read a metadata extent and expecting it belongs to a specific parent
node, relocation can run, the transaction used for the relocation is
committed and the extent gets reallocated while send is still using the
extent, so it ends up with a different content than expected. This can
result in just failing to read a metadata extent due to failure of the
validation checks (parent transid, level, etc), failure to find a
backreference for a data extent, and other unexpected failures. Besides
reallocation, there's also a similar problem of an extent getting
discarded when it's unpinned after the transaction used for block group
relocation is committed.

The restriction between balance and send was added in commit 9e967495e0e0
("Btrfs: prevent send failures and crashes due to concurrent relocation"),
kernel 5.3, while the more general restriction between send and relocation
was added in commit 1cea5cf0e664 ("btrfs: ensure relocation never runs
while we have send operations running"), kernel 5.14.

Both send and relocation can be very long running operations. Relocation
because it has to do a lot of IO and expensive backreference lookups in
case there are many snapshots, and send due to read IO when operating on
very large trees. This makes it inconvenient for users and tools to deal
with scheduling both operations.

For zoned filesystem we also have automatic block group relocation, so
send can fail with -EAGAIN when users least expect it or send can end up
delaying the block group relocation for too long. In the future we might
also get the automatic block group relocation for non zoned filesystems.

This change makes it possible for send and relocation to run in parallel.
This is achieved the following way:

1) For all tree searches, send acquires a read lock on the commit root
   semaphore;

2) After each tree search, and before releasing the commit root semaphore,
   the leaf is cloned and placed in the search path (struct btrfs_path);

3) After releasing the commit root semaphore, the changed_cb() callback
   is invoked, which operates on the leaf and writes commands to the pipe
   (or file in case send/receive is not used with a pipe). It's important
   here to not hold a lock on the commit root semaphore, because if we did
   we could deadlock when sending and receiving to the same filesystem
   using a pipe - the send task blocks on the pipe because it's full, the
   receive task, which is the only consumer of the pipe, triggers a
   transaction commit when attempting to create a subvolume or reserve
   space for a write operation for example, but the transaction commit
   blocks trying to write lock the commit root semaphore, resulting in a
   deadlock;

4) Before moving to the next key, or advancing to the next change in case
   of an incremental send, check if a transaction used for relocation was
   committed (or is about to finish its commit). If so, release the search
   path(s) and restart the search, to where we were before, so that we
   don't operate on stale extent buffers. The search restarts are always
   possible because both the send and parent roots are RO, and no one can
   add, remove of update keys (change their offset) in RO trees - the
   only exception is deduplication, but that is still not allowed to run
   in parallel with send;

5) Periodically check if there is contention on the commit root semaphore,
   which means there is a transaction commit trying to write lock it, and
   release the semaphore and reschedule if there is contention, so as to
   avoid causing any significant delays to transaction commits.

This leaves some room for optimizations for send to have less path
releases and re searching the trees when there's relocation running, but
for now it's kept simple as it performs quite well (on very large trees
with resulting send streams in the order of a few hundred gigabytes).

Test case btrfs/187, from fstests, stresses relocation, send and
deduplication attempting to run in parallel, but without verifying if send
succeeds and if it produces correct streams. A new test case will be added
that exercises relocation happening in parallel with send and then checks
that send succeeds and the resulting streams are correct.

A final note is that for now this still leaves the mutual exclusion
between send operations and deduplication on files belonging to a root
used by send operations. A solution for that will be slightly more complex
but it will eventually be built on top of this change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |   9 +-
 fs/btrfs/ctree.c       |  98 +++++++++---
 fs/btrfs/ctree.h       |  14 +-
 fs/btrfs/disk-io.c     |   4 +-
 fs/btrfs/relocation.c  |  13 --
 fs/btrfs/send.c        | 346 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/transaction.c |   4 +
 7 files changed, 390 insertions(+), 98 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d56fc1b8bb99..e1ff6986088f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1508,7 +1508,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
-	LIST_HEAD(again_list);
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
@@ -1585,18 +1584,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
-		if (ret && ret != -EAGAIN)
+		if (ret)
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
 
 next:
+		btrfs_put_block_group(bg);
 		spin_lock(&fs_info->unused_bgs_lock);
-		if (ret == -EAGAIN && list_empty(&bg->bg_list))
-			list_add_tail(&bg->bg_list, &again_list);
-		else
-			btrfs_put_block_group(bg);
 	}
-	list_splice_tail(&again_list, &fs_info->reclaim_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f165a4ccde8f..216bf35f6caf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1567,7 +1567,6 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 							struct btrfs_path *p,
 							int write_lock_level)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *b;
 	int root_lock;
 	int level = 0;
@@ -1576,26 +1575,8 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 	root_lock = BTRFS_READ_LOCK;
 
 	if (p->search_commit_root) {
-		/*
-		 * The commit roots are read only so we always do read locks,
-		 * and we always must hold the commit_root_sem when doing
-		 * searches on them, the only exception is send where we don't
-		 * want to block transaction commits for a long time, so
-		 * we need to clone the commit root in order to avoid races
-		 * with transaction commits that create a snapshot of one of
-		 * the roots used by a send operation.
-		 */
-		if (p->need_commit_sem) {
-			down_read(&fs_info->commit_root_sem);
-			b = btrfs_clone_extent_buffer(root->commit_root);
-			up_read(&fs_info->commit_root_sem);
-			if (!b)
-				return ERR_PTR(-ENOMEM);
-
-		} else {
-			b = root->commit_root;
-			atomic_inc(&b->refs);
-		}
+		b = root->commit_root;
+		atomic_inc(&b->refs);
 		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
@@ -1647,6 +1628,42 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 	return b;
 }
 
+/*
+ * Replace the extent buffer at the lowest level of the path with a cloned
+ * version. The purpose is to be able to use it safely, after releasing the
+ * commit root semaphore, even if relocation is happening in parallel, the
+ * transaction used for relocation is committed and the extent buffer is
+ * reallocated in the next transaction.
+ *
+ * This is used in a context where the caller does not prevent transaction
+ * commits from happening, either by holding a transaction handle or holding
+ * some lock, while it's doing searches through a commit root.
+ * At the moment it's only used for send operations.
+ */
+static int finish_need_commit_sem_search(struct btrfs_path *path)
+{
+	const int i = path->lowest_level;
+	const int slot = path->slots[i];
+	struct extent_buffer *lowest = path->nodes[i];
+	struct extent_buffer *clone;
+
+	ASSERT(path->need_commit_sem);
+
+	if (!lowest)
+		return 0;
+
+	lockdep_assert_held_read(&lowest->fs_info->commit_root_sem);
+
+	clone = btrfs_clone_extent_buffer(lowest);
+	if (!clone)
+		return -ENOMEM;
+
+	btrfs_release_path(path);
+	path->nodes[i] = clone;
+	path->slots[i] = slot;
+
+	return 0;
+}
 
 /*
  * btrfs_search_slot - look for a key in a tree and perform necessary
@@ -1683,6 +1700,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, struct btrfs_path *p,
 		      int ins_len, int cow)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *b;
 	int slot;
 	int ret;
@@ -1724,6 +1742,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	min_write_lock_level = write_lock_level;
 
+	if (p->need_commit_sem) {
+		ASSERT(p->search_commit_root);
+		down_read(&fs_info->commit_root_sem);
+	}
+
 again:
 	prev_cmp = -1;
 	b = btrfs_search_slot_get_root(root, p, write_lock_level);
@@ -1918,6 +1941,16 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 done:
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
+
+	if (p->need_commit_sem) {
+		int ret2;
+
+		ret2 = finish_need_commit_sem_search(p);
+		up_read(&fs_info->commit_root_sem);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret;
 }
 ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
@@ -4372,7 +4405,9 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	int level;
 	struct extent_buffer *c;
 	struct extent_buffer *next;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
+	bool need_commit_sem = false;
 	u32 nritems;
 	int ret;
 	int i;
@@ -4389,14 +4424,20 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 
 	path->keep_locks = 1;
 
-	if (time_seq)
+	if (time_seq) {
 		ret = btrfs_search_old_slot(root, &key, path, time_seq);
-	else
+	} else {
+		if (path->need_commit_sem) {
+			path->need_commit_sem = 0;
+			need_commit_sem = true;
+			down_read(&fs_info->commit_root_sem);
+		}
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	}
 	path->keep_locks = 0;
 
 	if (ret < 0)
-		return ret;
+		goto done;
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	/*
@@ -4519,6 +4560,15 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	ret = 0;
 done:
 	unlock_up(path, 0, 1, 0, NULL);
+	if (need_commit_sem) {
+		int ret2;
+
+		path->need_commit_sem = 1;
+		ret2 = finish_need_commit_sem_search(path);
+		up_read(&fs_info->commit_root_sem);
+		if (ret2)
+			ret = ret2;
+	}
 
 	return ret;
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f1dd2486dcb3..9acf27ed16fb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -571,7 +571,6 @@ enum {
 	/*
 	 * Indicate that relocation of a chunk has started, it's set per chunk
 	 * and is toggled between chunks.
-	 * Set, tested and cleared while holding fs_info::send_reloc_lock.
 	 */
 	BTRFS_FS_RELOC_RUNNING,
 
@@ -668,6 +667,12 @@ struct btrfs_fs_info {
 
 	u64 generation;
 	u64 last_trans_committed;
+	/*
+	 * Generation of the last transaction used for block group relocation
+	 * since the filesystem was last mounted (or 0 if none happened yet).
+	 * Must be written and read while holding btrfs_fs_info::commit_root_sem.
+	 */
+	u64 last_reloc_trans;
 	u64 avg_delayed_ref_runtime;
 
 	/*
@@ -998,13 +1003,6 @@ struct btrfs_fs_info {
 
 	struct crypto_shash *csum_shash;
 
-	spinlock_t send_reloc_lock;
-	/*
-	 * Number of send operations in progress.
-	 * Updated while holding fs_info::send_reloc_lock.
-	 */
-	int send_in_progress;
-
 	/* Type of exclusive operation running, protected by super_lock */
 	enum btrfs_exclusive_operation exclusive_operation;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9d66d48945c6..5f6b18961717 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2848,6 +2848,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		/* All successful */
 		fs_info->generation = generation;
 		fs_info->last_trans_committed = generation;
+		fs_info->last_reloc_trans = 0;
 
 		/* Always begin writing backup roots after the one being used */
 		if (backup_index < 0) {
@@ -2983,9 +2984,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
 
-	spin_lock_init(&fs_info->send_reloc_lock);
-	fs_info->send_in_progress = 0;
-
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
 }
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a455a1ead0d6..6d0e13e11f2f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3859,25 +3859,14 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
  *   0             success
  *   -EINPROGRESS  operation is already in progress, that's probably a bug
  *   -ECANCELED    cancellation request was set before the operation started
- *   -EAGAIN       can not start because there are ongoing send operations
  */
 static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 {
-	spin_lock(&fs_info->send_reloc_lock);
-	if (fs_info->send_in_progress) {
-		btrfs_warn_rl(fs_info,
-"cannot run relocation while send operations are in progress (%d in progress)",
-			      fs_info->send_in_progress);
-		spin_unlock(&fs_info->send_reloc_lock);
-		return -EAGAIN;
-	}
 	if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
 		/* This should not happen */
-		spin_unlock(&fs_info->send_reloc_lock);
 		btrfs_err(fs_info, "reloc already running, cannot start");
 		return -EINPROGRESS;
 	}
-	spin_unlock(&fs_info->send_reloc_lock);
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
@@ -3899,9 +3888,7 @@ static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 	/* Requested after start, clear bit first so any waiters can continue */
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
 		btrfs_info(fs_info, "chunk relocation canceled during operation");
-	spin_lock(&fs_info->send_reloc_lock);
 	clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
-	spin_unlock(&fs_info->send_reloc_lock);
 	atomic_set(&fs_info->reloc_cancel_req, 0);
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6bdcb9d481d5..eee8f9488198 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -24,6 +24,7 @@
 #include "transaction.h"
 #include "compression.h"
 #include "xattr.h"
+#include "print-tree.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
@@ -97,6 +98,15 @@ struct send_ctx {
 	struct btrfs_path *right_path;
 	struct btrfs_key *cmp_key;
 
+	/*
+	 * Keep track of the generation of the last transaction that was used
+	 * for relocating a block group. This is periodically checked in order
+	 * to detect if a relocation happened since the last check, so that we
+	 * don't operate on stale extent buffers for nodes (level >= 1) or on
+	 * stale disk_bytenr values of file extent items.
+	 */
+	u64 last_reloc_trans;
+
 	/*
 	 * infos of the currently processed inode. In case of deleted inodes,
 	 * these are the values from the deleted inode.
@@ -1434,8 +1444,28 @@ static int find_extent_clone(struct send_ctx *sctx,
 		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
 		    data_offset, ino, num_bytes, logical);
 
-	if (!backref_ctx.found)
+	if (backref_ctx.found > 0) {
+		down_read(&fs_info->commit_root_sem);
+		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
+			/*
+			 * A transaction commit for a transaction in which block
+			 * group relocation was done just happened.
+			 * The disk_bytenr of the file extent item we processed
+			 * is possibly stale, referring to the extent's location
+			 * before relocation, so act as if we haven't found any
+			 * clone sources - otherwise we could end up later issuing
+			 * clone operations that could leave the receiver with
+			 * incorrect data, in case the old disk_bytenr got
+			 * reallocated for another extent.
+			 */
+			up_read(&fs_info->commit_root_sem);
+			ret = -ENOENT;
+			goto out;
+		}
+		up_read(&fs_info->commit_root_sem);
+	} else {
 		btrfs_debug(fs_info, "no clones found");
+	}
 
 	cur_clone_root = NULL;
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
@@ -6583,6 +6613,50 @@ static int changed_cb(struct btrfs_path *left_path,
 {
 	int ret = 0;
 
+	/*
+	 * We can not hold the commit root semaphore here. This is because in
+	 * the case of sending and receiving to the same filesystem, using a
+	 * pipe, could result in a deadlock:
+	 *
+	 * 1) The task running send blocks on the pipe because it's full;
+	 *
+	 * 2) The task running receive, which is the only consumer of the pipe,
+	 *    is waiting for a transaction commit (for example due to a space
+	 *    reservation when doing a write or triggering a transaction commit
+	 *    when creating a subvolume);
+	 *
+	 * 3) The transaction is waiting to write lock the commit root semaphore,
+	 *    but can not acquire it since it's being held at 1).
+	 *
+	 * Down this call chain we write to the pipe through kernel_write().
+	 * The same type of problem can also happen when sending to a file that
+	 * is stored in the same filesystem - when reserving space for a write
+	 * into the file, we can trigger a transaction commit.
+	 *
+	 * Our caller has supplied us with clones of leaves from the send and
+	 * parent roots, so we're safe here from a concurrent relocation and
+	 * further reallocation of metadata extents while we are here. Below we
+	 * also assert that the leaves are clones.
+	 */
+	lockdep_assert_not_held(&sctx->send_root->fs_info->commit_root_sem);
+
+	/*
+	 * We always have a send root, so left_path is never NULL. We will not
+	 * have a leaf when we have reached the end of the send root but have
+	 * not yet reached the end of the parent root.
+	 */
+	if (left_path->nodes[0])
+		ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED,
+				&left_path->nodes[0]->bflags));
+	/*
+	 * When doing a full send we don't have a parent root, so right_path is
+	 * NULL. When doing an incremental send, we may have reached the end of
+	 * the parent root already, so we don't have a leaf at right_path.
+	 */
+	if (right_path && right_path->nodes[0])
+		ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED,
+				&right_path->nodes[0]->bflags));
+
 	if (result == BTRFS_COMPARE_TREE_SAME) {
 		if (key->type == BTRFS_INODE_REF_KEY ||
 		    key->type == BTRFS_INODE_EXTREF_KEY) {
@@ -6629,14 +6703,46 @@ static int changed_cb(struct btrfs_path *left_path,
 	return ret;
 }
 
+static int search_key_again(const struct send_ctx *sctx,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path,
+			    const struct btrfs_key *key)
+{
+	int ret;
+
+	if (!path->need_commit_sem)
+		lockdep_assert_held_read(&root->fs_info->commit_root_sem);
+
+	/*
+	 * Roots used for send operations are readonly and no one can add,
+	 * update or remove keys from them, so we should be able to find our
+	 * key again. The only exception is deduplication, which can operate on
+	 * readonly roots and add, update or remove keys to/from them - but at
+	 * the moment we don't allow it to run in parallel with send.
+	 */
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	ASSERT(ret <= 0);
+	if (ret > 0) {
+		btrfs_print_tree(path->nodes[path->lowest_level], false);
+		btrfs_err(root->fs_info,
+"send: key (%llu %u %llu) not found in %s root %llu, lowest_level %d, slot %d",
+			  key->objectid, key->type, key->offset,
+			  (root == sctx->parent_root ? "parent" : "send"),
+			  root->root_key.objectid, path->lowest_level,
+			  path->slots[path->lowest_level]);
+		return -EUCLEAN;
+	}
+
+	return ret;
+}
+
 static int full_send_tree(struct send_ctx *sctx)
 {
 	int ret;
 	struct btrfs_root *send_root = sctx->send_root;
 	struct btrfs_key key;
+	struct btrfs_fs_info *fs_info = send_root->fs_info;
 	struct btrfs_path *path;
-	struct extent_buffer *eb;
-	int slot;
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -6647,6 +6753,10 @@ static int full_send_tree(struct send_ctx *sctx)
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
+	down_read(&fs_info->commit_root_sem);
+	sctx->last_reloc_trans = fs_info->last_reloc_trans;
+	up_read(&fs_info->commit_root_sem);
+
 	ret = btrfs_search_slot_for_read(send_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out;
@@ -6654,15 +6764,35 @@ static int full_send_tree(struct send_ctx *sctx)
 		goto out_finish;
 
 	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		btrfs_item_key_to_cpu(eb, &key, slot);
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
 		ret = changed_cb(path, NULL, &key,
 				 BTRFS_COMPARE_TREE_NEW, sctx);
 		if (ret < 0)
 			goto out;
 
+		down_read(&fs_info->commit_root_sem);
+		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
+			sctx->last_reloc_trans = fs_info->last_reloc_trans;
+			up_read(&fs_info->commit_root_sem);
+			/*
+			 * A transaction used for relocating a block group was
+			 * committed or is about to finish its commit. Release
+			 * our path (leaf) and restart the search, so that we
+			 * avoid operating on any file extent items that are
+			 * stale, with a disk_bytenr that reflects a pre
+			 * relocation value. This way we avoid as much as
+			 * possible to fallback to regular writes when checking
+			 * if we can clone file ranges.
+			 */
+			btrfs_release_path(path);
+			ret = search_key_again(sctx, send_root, path, &key);
+			if (ret < 0)
+				goto out;
+		} else {
+			up_read(&fs_info->commit_root_sem);
+		}
+
 		ret = btrfs_next_item(send_root, path);
 		if (ret < 0)
 			goto out;
@@ -6680,6 +6810,20 @@ static int full_send_tree(struct send_ctx *sctx)
 	return ret;
 }
 
+static int replace_node_with_clone(struct btrfs_path *path, int level)
+{
+	struct extent_buffer *clone;
+
+	clone = btrfs_clone_extent_buffer(path->nodes[level]);
+	if (!clone)
+		return -ENOMEM;
+
+	free_extent_buffer(path->nodes[level]);
+	path->nodes[level] = clone;
+
+	return 0;
+}
+
 static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen)
 {
 	struct extent_buffer *eb;
@@ -6689,6 +6833,8 @@ static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen
 	u64 reada_max;
 	u64 reada_done = 0;
 
+	lockdep_assert_held_read(&parent->fs_info->commit_root_sem);
+
 	BUG_ON(*level == 0);
 	eb = btrfs_read_node_slot(parent, slot);
 	if (IS_ERR(eb))
@@ -6712,6 +6858,10 @@ static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen
 	path->nodes[*level - 1] = eb;
 	path->slots[*level - 1] = 0;
 	(*level)--;
+
+	if (*level == 0)
+		return replace_node_with_clone(path, 0);
+
 	return 0;
 }
 
@@ -6725,8 +6875,10 @@ static int tree_move_next_or_upnext(struct btrfs_path *path,
 	path->slots[*level]++;
 
 	while (path->slots[*level] >= nritems) {
-		if (*level == root_level)
+		if (*level == root_level) {
+			path->slots[*level] = nritems - 1;
 			return -1;
+		}
 
 		/* move upnext */
 		path->slots[*level] = 0;
@@ -6758,14 +6910,20 @@ static int tree_advance(struct btrfs_path *path,
 	} else {
 		ret = tree_move_down(path, level, reada_min_gen);
 	}
-	if (ret >= 0) {
-		if (*level == 0)
-			btrfs_item_key_to_cpu(path->nodes[*level], key,
-					path->slots[*level]);
-		else
-			btrfs_node_key_to_cpu(path->nodes[*level], key,
-					path->slots[*level]);
-	}
+
+	/*
+	 * Even if we have reached the end of a tree, ret is -1, update the key
+	 * anyway, so that in case we need to restart due to a block group
+	 * relocation, we can assert that the last key of the root node still
+	 * exists in the tree.
+	 */
+	if (*level == 0)
+		btrfs_item_key_to_cpu(path->nodes[*level], key,
+				      path->slots[*level]);
+	else
+		btrfs_node_key_to_cpu(path->nodes[*level], key,
+				      path->slots[*level]);
+
 	return ret;
 }
 
@@ -6794,6 +6952,97 @@ static int tree_compare_item(struct btrfs_path *left_path,
 	return 0;
 }
 
+/*
+ * A transaction used for relocating a block group was committed or is about to
+ * finish its commit. Release our paths and restart the search, so that we are
+ * not using stale extent buffers:
+ *
+ * 1) For levels > 0, we are only holding references of extent buffers, without
+ *    any locks on them, which does not prevent them from having been relocated
+ *    and reallocated after the last time we released the commit root semaphore.
+ *    The exception are the root nodes, for which we always have a clone, see
+ *    the comment at btrfs_compare_trees();
+ *
+ * 2) For leaves, level 0, we are holding copies (clones) of extent buffers, so
+ *    we are safe from the concurrent relocation and reallocation. However they
+ *    can have file extent items with a pre relocation disk_bytenr value, so we
+ *    restart the start from the current commit roots and clone the new leaves so
+ *    that we get the post relocation disk_bytenr values. Not doing so, could
+ *    make us clone the wrong data in case there are new extents using the old
+ *    disk_bytenr that happen to be shared.
+ */
+static int restart_after_relocation(struct btrfs_path *left_path,
+				    struct btrfs_path *right_path,
+				    const struct btrfs_key *left_key,
+				    const struct btrfs_key *right_key,
+				    int left_level,
+				    int right_level,
+				    const struct send_ctx *sctx)
+{
+	int root_level;
+	int ret;
+
+	lockdep_assert_held_read(&sctx->send_root->fs_info->commit_root_sem);
+
+	btrfs_release_path(left_path);
+	btrfs_release_path(right_path);
+
+	/*
+	 * Since keys can not be added or removed to/from our roots because they
+	 * are readonly and we do not allow deduplication to run in parallel
+	 * (which can add, remove or change keys), the layout of the trees should
+	 * not change.
+	 */
+	left_path->lowest_level = left_level;
+	ret = search_key_again(sctx, sctx->send_root, left_path, left_key);
+	if (ret < 0)
+		return ret;
+
+	right_path->lowest_level = right_level;
+	ret = search_key_again(sctx, sctx->parent_root, right_path, right_key);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * If the lowest level nodes are leaves, clone them so that they can be
+	 * safely used by changed_cb() while not under the protection of the
+	 * commit root semaphore, even if relocation and reallocation happens in
+	 * parallel.
+	 */
+	if (left_level == 0) {
+		ret = replace_node_with_clone(left_path, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (right_level == 0) {
+		ret = replace_node_with_clone(right_path, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Now clone the root nodes (unless they happen to be the leaves we have
+	 * already cloned). This is to protect against concurrent snapshoting of
+	 * the send and parent roots (see the comment at btrfs_compare_trees()).
+	 */
+	root_level = btrfs_header_level(sctx->send_root->commit_root);
+	if (root_level > 0) {
+		ret = replace_node_with_clone(left_path, root_level);
+		if (ret < 0)
+			return ret;
+	}
+
+	root_level = btrfs_header_level(sctx->parent_root->commit_root);
+	if (root_level > 0) {
+		ret = replace_node_with_clone(right_path, root_level);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * This function compares two trees and calls the provided callback for
  * every changed/new/deleted item it finds.
@@ -6822,10 +7071,10 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	int right_root_level;
 	int left_level;
 	int right_level;
-	int left_end_reached;
-	int right_end_reached;
-	int advance_left;
-	int advance_right;
+	int left_end_reached = 0;
+	int right_end_reached = 0;
+	int advance_left = 0;
+	int advance_right = 0;
 	u64 left_blockptr;
 	u64 right_blockptr;
 	u64 left_gen;
@@ -6893,6 +7142,13 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	down_read(&fs_info->commit_root_sem);
 	left_level = btrfs_header_level(left_root->commit_root);
 	left_root_level = left_level;
+	/*
+	 * We clone the root node of the send and parent roots to prevent races
+	 * with snapshot creation of these roots. Snapshot creation COWs the
+	 * root node of a tree, so after the transaction is committed the old
+	 * extent can be reallocated while this send operation is still ongoing.
+	 * So we clone them, under the commit root semaphore, to be race free.
+	 */
 	left_path->nodes[left_level] =
 			btrfs_clone_extent_buffer(left_root->commit_root);
 	if (!left_path->nodes[left_level]) {
@@ -6918,7 +7174,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	 * will need to read them at some point.
 	 */
 	reada_min_gen = btrfs_header_generation(right_root->commit_root);
-	up_read(&fs_info->commit_root_sem);
 
 	if (left_level == 0)
 		btrfs_item_key_to_cpu(left_path->nodes[left_level],
@@ -6933,11 +7188,26 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		btrfs_node_key_to_cpu(right_path->nodes[right_level],
 				&right_key, right_path->slots[right_level]);
 
-	left_end_reached = right_end_reached = 0;
-	advance_left = advance_right = 0;
+	sctx->last_reloc_trans = fs_info->last_reloc_trans;
 
 	while (1) {
-		cond_resched();
+		if (need_resched() ||
+		    rwsem_is_contended(&fs_info->commit_root_sem)) {
+			up_read(&fs_info->commit_root_sem);
+			cond_resched();
+			down_read(&fs_info->commit_root_sem);
+		}
+
+		if (fs_info->last_reloc_trans > sctx->last_reloc_trans) {
+			ret = restart_after_relocation(left_path, right_path,
+						       &left_key, &right_key,
+						       left_level, right_level,
+						       sctx);
+			if (ret < 0)
+				goto out;
+			sctx->last_reloc_trans = fs_info->last_reloc_trans;
+		}
+
 		if (advance_left && !left_end_reached) {
 			ret = tree_advance(left_path, &left_level,
 					left_root_level,
@@ -6966,10 +7236,12 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			goto out;
 		} else if (left_end_reached) {
 			if (right_level == 0) {
+				up_read(&fs_info->commit_root_sem);
 				ret = changed_cb(left_path, right_path,
 						&right_key,
 						BTRFS_COMPARE_TREE_DELETED,
 						sctx);
+				down_read(&fs_info->commit_root_sem);
 				if (ret < 0)
 					goto out;
 			}
@@ -6977,10 +7249,12 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			continue;
 		} else if (right_end_reached) {
 			if (left_level == 0) {
+				up_read(&fs_info->commit_root_sem);
 				ret = changed_cb(left_path, right_path,
 						&left_key,
 						BTRFS_COMPARE_TREE_NEW,
 						sctx);
+				down_read(&fs_info->commit_root_sem);
 				if (ret < 0)
 					goto out;
 			}
@@ -6989,22 +7263,19 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		}
 
 		if (left_level == 0 && right_level == 0) {
+			up_read(&fs_info->commit_root_sem);
 			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
 			if (cmp < 0) {
 				ret = changed_cb(left_path, right_path,
 						&left_key,
 						BTRFS_COMPARE_TREE_NEW,
 						sctx);
-				if (ret < 0)
-					goto out;
 				advance_left = ADVANCE;
 			} else if (cmp > 0) {
 				ret = changed_cb(left_path, right_path,
 						&right_key,
 						BTRFS_COMPARE_TREE_DELETED,
 						sctx);
-				if (ret < 0)
-					goto out;
 				advance_right = ADVANCE;
 			} else {
 				enum btrfs_compare_tree_result result;
@@ -7018,11 +7289,13 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 					result = BTRFS_COMPARE_TREE_SAME;
 				ret = changed_cb(left_path, right_path,
 						 &left_key, result, sctx);
-				if (ret < 0)
-					goto out;
 				advance_left = ADVANCE;
 				advance_right = ADVANCE;
 			}
+
+			down_read(&fs_info->commit_root_sem);
+			if (ret < 0)
+				goto out;
 		} else if (left_level == right_level) {
 			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
 			if (cmp < 0) {
@@ -7063,6 +7336,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	}
 
 out:
+	up_read(&fs_info->commit_root_sem);
 	btrfs_free_path(left_path);
 	btrfs_free_path(right_path);
 	kvfree(tmp_buf);
@@ -7411,21 +7685,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	if (ret)
 		goto out;
 
-	spin_lock(&fs_info->send_reloc_lock);
-	if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
-		spin_unlock(&fs_info->send_reloc_lock);
-		btrfs_warn_rl(fs_info,
-		"cannot run send because a relocation operation is in progress");
-		ret = -EAGAIN;
-		goto out;
-	}
-	fs_info->send_in_progress++;
-	spin_unlock(&fs_info->send_reloc_lock);
-
 	ret = send_subvol(sctx);
-	spin_lock(&fs_info->send_reloc_lock);
-	fs_info->send_in_progress--;
-	spin_unlock(&fs_info->send_reloc_lock);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8b6a90fafcd4..0c52e28b585c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -169,6 +169,10 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 	ASSERT(cur_trans->state == TRANS_STATE_COMMIT_DOING);
 
 	down_write(&fs_info->commit_root_sem);
+
+	if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
+		fs_info->last_reloc_trans = trans->transid;
+
 	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
 				 dirty_list) {
 		list_del_init(&root->dirty_list);
-- 
2.33.0

