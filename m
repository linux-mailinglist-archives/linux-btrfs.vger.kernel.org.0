Return-Path: <linux-btrfs+bounces-12195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC2A5C8B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 16:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5992F3B2771
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529E25F7B5;
	Tue, 11 Mar 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WddZQcYD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224025EFBB;
	Tue, 11 Mar 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707639; cv=none; b=srmPhDZ4Ll3xAK9+MgKxPUmkPcL6zZXHrzwJur7Nc+c9Q8AB70QCvT4dtUEHxI/9AxUcj2MtdJV6h2G9kuzDuZa5br8mx0FB4T4bs2m9LfmDEf4ilstvGkvBRFIH73mT3c9WHRmVu+rhSiL9AAsnQq35goH/464AUfRsrj9q+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707639; c=relaxed/simple;
	bh=xf7M6BVFT8DAFcq/gg+MR74qJuXyUAQ6IqEImiReHu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuojwaOs+SBAF+5qTBIJwMyPw1k47vc+rTOE5oIMN1gfAbtUZAOYKJ+RhXx89Ppilsn8WJSiE98orp/zKHFDre7waW8HRnhlZmRJlO3u7es9tswaHSli0p3o8pZ8PQgKVVBAwrHmeahJHLpLUiIOEokqS4TfY46bpqzofTMiJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WddZQcYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6B8C4CEEA;
	Tue, 11 Mar 2025 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707639;
	bh=xf7M6BVFT8DAFcq/gg+MR74qJuXyUAQ6IqEImiReHu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WddZQcYDyCJ1Y3/gxML0klq5GVp0lzHsK8JCDIbJJLQx9xcyUD4fLQNC/UpctiVxu
	 dtLFVq4lZemJDAbxnbLbynHzF7jU5EDAqzfp03E9s1cdU79G/Ty0J+5HL+Elct0kvN
	 N55ZcKnBCdQRKhgADLFD9ty6RbRaK/UVR0hehThM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	pk <pkoroau@gmail.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 5.10 458/462] btrfs: bring back the incorrectly removed extent buffer lock recursion support
Date: Tue, 11 Mar 2025 16:02:04 +0100
Message-ID: <20250311145816.419610146@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/locking.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 4 deletions(-)

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
@@ -46,7 +71,31 @@ void __btrfs_tree_read_lock(struct exten
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
 
@@ -85,11 +134,22 @@ int btrfs_try_tree_write_lock(struct ext
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
 



