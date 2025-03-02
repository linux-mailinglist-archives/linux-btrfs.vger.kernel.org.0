Return-Path: <linux-btrfs+bounces-11956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE0A4B1A0
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A2A18902EC
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A521E411D;
	Sun,  2 Mar 2025 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivNnvpKg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2A1C5F1E;
	Sun,  2 Mar 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919652; cv=none; b=tWCQG8fQoSA0Qh+LX9LEl0i3h+v5Ws/KmopetCe+xYYNtJnToOhOAuYIAsGwqBuFr1azrbY8R99ZI1zEjyUkjMS6oN7CuuKK8M1VFSg577PMOQKZB1/GvD29Uxk+/75GOCdDLn8jKO5y8MqNNi2k3EEOKJsk/3maud0CWHVecH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919652; c=relaxed/simple;
	bh=K4iEcyqSALl1hH+EtMfOApe8VcBESc/taK+y4iG0bgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P97kRiUpQyffkaR7MkRMCYw+RXo83GqLOxilzU7JpfxJ0/dyUQmOLnut8RI8ilDF5K0Xi7y8kltmkkxS+JofEka6CrCalzS3rXZOptWY6Bk2sJCn3Ym0jDpiG4+oLzaQjhFrbD17OYjXdrNO+XD3r821fKGooBx3C2KXlhGtwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivNnvpKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42731C4CED6;
	Sun,  2 Mar 2025 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740919651;
	bh=K4iEcyqSALl1hH+EtMfOApe8VcBESc/taK+y4iG0bgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ivNnvpKg/wvD17wYRjfqBr31MM/TO2aJ+xBDKGouD37rGJ3JRxEi1U5L+P/F/DJ8q
	 YgDFzQFjQy+D5GxJmhodzH7bFZZgVuNkj4UpT6M61JrNV2+mNaFvf9+0shnd0Fod7f
	 5C4ckzJK6b17BOKhz7spcuaGI3HN/dTbqmoO546lAHFZthNSJQiJjdPAPnBBxf0lvG
	 t9GA9XzYHVT/gIThTCPaFUEzIssW/NOX7ay2eltRHjFxHLuSzcbHqeJOEVOz5KKSiA
	 r9CrWZLqgueb5pFpbjDI6lfEd7at7C7jlKnAMBhp6bzTBIa8daCw7LwO7eUucn+M/v
	 8+y6m2b1fv9Dw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: pkoroau@gmail.com,
	dsterba@suse.com,
	stable@vger.kernel.org
Subject: [PATCH for stable 5.10.x] btrfs: bring back the incorrectly removed extent buffer lock recursion support
Date: Sun,  2 Mar 2025 12:47:27 +0000
Message-Id: <10637efdde5420993dd0611e3d3d5d8de6937e3b.1740919455.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Commit 51b03b7473a0 ("btrfs: locking: remove the recursion handling code")
from the 5.10.233 stable tree removed the support for extent buffer lock
recursion, but we need that code because in 5.10.x we load the free space
cache synchronously - while modifying the extent tree and holding a write
lock on some extent buffer, we may need to load the free space cache,
which requires acquiring read locks on the extent tree and therefore
result in a deadlock in case we need to read lock an extent buffer we had
write locked while modifying the extent tree.

Backporting that commit from Linus' tree is therefore wrong, and was done
so in order to backport upstream commit 97e86631bccd ("btrfs: don't set
lock_owner when locking extent buffer for reading"). However we should
have instead had the commit adapted to the 5.10 stable tree instead.

Note that the backport of that dependency is ok only for stable trees
5.11+, because in those tree the space cache loading code is not
synchronous anymore, so there is no need to have the lock recursion
and indeed there are no users of the extent buffer lock recursion
support. In other words, the backport is only valid for kernel releases
that have the asynchrounous free space cache loading support, which
was introduced in kernel 5.11 with commit e747853cae3a ("btrfs: load
free space cache asynchronously").

This was causing deadlocks and reported by a user (see below Link tag).

So revert commit 51b03b7473a0 ("btrfs: locking: remove the recursion
handling code") while not undoing what commit d5a30a6117ea ("btrfs: don't
set lock_owner when locking extent buffer for reading") from the 5.10.x
stable tree did.

Reported-by: pk <pkoroau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMNwjEKH6znTHE5hMc5er2dFs5ypw4Szx6TMDMb0H76yFq5DGQ@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/locking.c | 68 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 3d177ef92ab6..24049d054263 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -25,18 +25,43 @@
  * - reader/reader sharing
  * - try-lock semantics for readers and writers
  *
- * The rwsem implementation does opportunistic spinning which reduces number of
- * times the locking task needs to sleep.
+ * Additionally we need one level nesting recursion, see below. The rwsem
+ * implementation does opportunistic spinning which reduces number of times the
+ * locking task needs to sleep.
+ *
+ *
+ * Lock recursion
+ * --------------
+ *
+ * A write operation on a tree might indirectly start a look up on the same
+ * tree.  This can happen when btrfs_cow_block locks the tree and needs to
+ * lookup free extents.
+ *
+ * btrfs_cow_block
+ *   ..
+ *   alloc_tree_block_no_bg_flush
+ *     btrfs_alloc_tree_block
+ *       btrfs_reserve_extent
+ *         ..
+ *         load_free_space_cache
+ *           ..
+ *           btrfs_lookup_file_extent
+ *             btrfs_search_slot
+ *
  */
 
 /*
  * __btrfs_tree_read_lock - lock extent buffer for read
  * @eb:		the eb to be locked
  * @nest:	the nesting level to be used for lockdep
- * @recurse:	unused
+ * @recurse:	if this lock is able to be recursed
  *
  * This takes the read lock on the extent buffer, using the specified nesting
  * level for lockdep purposes.
+ *
+ * If you specify recurse = true, then we will allow this to be taken if we
+ * currently own the lock already.  This should only be used in specific
+ * usecases, and the subsequent unlock will not change the state of the lock.
  */
 void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
 			    bool recurse)
@@ -46,7 +71,31 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 	if (trace_btrfs_tree_read_lock_enabled())
 		start_ns = ktime_get_ns();
 
+	if (unlikely(recurse)) {
+		/* First see if we can grab the lock outright */
+		if (down_read_trylock(&eb->lock))
+			goto out;
+
+		/*
+		 * Ok still doesn't necessarily mean we are already holding the
+		 * lock, check the owner.
+		 */
+		if (eb->lock_owner != current->pid) {
+			down_read_nested(&eb->lock, nest);
+			goto out;
+		}
+
+		/*
+		 * Ok we have actually recursed, but we should only be recursing
+		 * once, so blow up if we're already recursed, otherwise set
+		 * ->lock_recursed and carry on.
+		 */
+		BUG_ON(eb->lock_recursed);
+		eb->lock_recursed = true;
+		goto out;
+	}
 	down_read_nested(&eb->lock, nest);
+out:
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
@@ -85,11 +134,22 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 }
 
 /*
- * Release read lock.
+ * Release read lock.  If the read lock was recursed then the lock stays in the
+ * original state that it was before it was recursively locked.
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
 	trace_btrfs_tree_read_unlock(eb);
+	/*
+	 * if we're nested, we have the write lock.  No new locking
+	 * is needed as long as we are the lock owner.
+	 * The write unlock will do a barrier for us, and the lock_recursed
+	 * field only matters to the lock owner.
+	 */
+	if (eb->lock_recursed && current->pid == eb->lock_owner) {
+		eb->lock_recursed = false;
+		return;
+	}
 	up_read(&eb->lock);
 }
 
-- 
2.45.2


