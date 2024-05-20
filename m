Return-Path: <linux-btrfs+bounces-5102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5F78C9AA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86DA281EEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6A48CDD;
	Mon, 20 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftjTe7X5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B036481DA
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198416; cv=none; b=oCrTj+/jnFSPX0L0QcMGb+NhMeG9+ueXJodtWwnwv/ClEDjGYfxXOaDpTLRu5xK8V6bqy0OCTiPNJ9/skyUtcjLoXdc7ztrstYUs8Juqj4L3bo1kmKA9yVgLs4gVrwZoRHSBa5055J9qcf0IAYiD9YLVVF5WXo+9b8x/f+vuPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198416; c=relaxed/simple;
	bh=0wPi7wed9g5WFXJJkFSa48fGVKUt1F8VnEoLK0JQdL0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwpfpvMjcd3LYdNnUTQaY5dqCFURsZtVbYNznw/Tijxx8Wj8xq832GpcsO2cvT+YqRnCHjQavN7BpzB0IUXuzoaqEHqmEmyBU4FCMvefRGuAsopqbiDye/Wld19dUtfA00ZQP6+XzWmuI4t/UHt69bMArIlPpMTogvu6jxL41YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftjTe7X5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B92C2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198416;
	bh=0wPi7wed9g5WFXJJkFSa48fGVKUt1F8VnEoLK0JQdL0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ftjTe7X54KVzLGJwZiCh/1RlgvgtlXczEXkMdQA9oL/VToXiNjTCxD9s0B9TqyyUV
	 NWrLrLhdgNFdjNHi+MFCVeMZhmlLgMiMLoAirOeF8U97mzSOuRU3Fjf/AhNa6Sphpm
	 hJ1fWEjf1AZY0aoj8Wmdttdm1v8ZSKf7JL1VcWAowxrCZKxx0PO44SAJuE7IhPYC7h
	 9hsZS0fVRFVPjIOB+XmUhI3W1yOppOfh8xWRC4VSlEcnPmTC/n06PNbEOLJQMn/Sxk
	 wljn1RTE5sqkujWblSQHqsti+1y3UF0VwVUz0W5lWFhuXeDWqnN5iR4qdsgoBOQyMb
	 eK1qH9UZaNlHg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/6] btrfs: ensure fast fsync waits for ordered extents after a write failure
Date: Mon, 20 May 2024 10:46:46 +0100
Message-Id: <3aac8d8b6e6caab81b3726ff857684c08fb2346d.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If a write path in COW mode fails, either before submitting a bio for the
new extents or an actual IO error happens, we can end up allowing a fast
fsync to log file extent items that point to unwritten extents.

This is because dropping the extent maps happens when completing ordered
extents, at btrfs_finish_one_ordered(), and the completion of an ordered
extent is executed in a work queue.

This can result in a fast fsync to start logging file extent items based
on existing extent maps before the ordered extents complete, therefore
resulting in a log that has file extent items that point to unwritten
extents, resulting in a corrupt file if a crash happens after and the log
tree is replayed the next time the fs is mounted.

This can happen for both direct IO writes and buffered writes.

For example consider a direct IO write, in COW mode, that fails at
btrfs_dio_submit_io() because btrfs_extract_ordered_extent() returned an
error:

1) We call btrfs_finish_ordered_extent() with the 'uptodate' parameter
   set to false, meaning an error happened;

2) That results in marking the ordered extent with the BTRFS_ORDERED_IOERR
   flag;

3) btrfs_finish_ordered_extent() queues the completion of the ordered
   extent - so that btrfs_finish_one_ordered() will be executed later in
   a work queue. That function will drop extent maps in the range when
   it's executed, since the extent maps point to unwritten locations
   (signaled by the BTRFS_ORDERED_IOERR flag);

4) After calling btrfs_finish_ordered_extent() we keep going down the
   write path and unlock the inode;

5) After that a fast fsync starts and locks the inode;

6) Before the work queue executes btrfs_finish_one_ordered(), the fsync
   task sees the extent maps that point to the unwritten locations and
   logs file extent items based on them - it does not know they are
   unwritten, and the fast fsync path does not wait for ordered extents
   to complete, which is an intentional behaviour in order to reduce
   latency.

For the buffered write case, here's one example:

1) A fast fsync begins, and it starts by flushing delalloc and waiting for
   the writeback to complete by calling filemap_fdatawait_range();

2) Flushing the dellaloc created a new extent map X;

3) During the writeback some IO error happened, and at the end io callback
   (end_bbio_data_write()) we call btrfs_finish_ordered_extent(), which
   sets the BTRFS_ORDERED_IOERR flag in the ordered extent and queues its
   completion;

4) After queuing the ordered extent completion, the end io callback clears
   the writeback flag from all pages (or folios), and from that moment the
   fast fsync can proceed;

5) The fast fsync proceeds sees extent map X and logs a file extent item
   based on extent map X, resulting in a log that points to an unwritten
   data extent - because the ordered extent completion hasn't run yet, it
   happens only after the logging.

To fix this make btrfs_finish_ordered_extent() set the inode flag
BTRFS_INODE_NEEDS_FULL_SYNC in case an error happened for a COW write,
so that a fast fsync will wait for ordered extent completion.

Note that this issues of using extent maps that point to unwritten
locations can not happen for reads, because in read paths we start by
locking the extent range and wait for any ordered extents in the range
to complete before looking for extent maps.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h  | 10 ++++++++++
 fs/btrfs/file.c         | 16 ++++++++++++++++
 fs/btrfs/ordered-data.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 3c8bc7a8ebdd..46db4027bf15 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -112,6 +112,16 @@ enum {
 	 * done at new_simple_dir(), called from btrfs_lookup_dentry().
 	 */
 	BTRFS_INODE_ROOT_STUB,
+	/*
+	 * Set if an error happened when doing a COW write before submitting a
+	 * bio or during writeback. Used for both buffered writes and direct IO
+	 * writes. This is to signal a fast fsync that it has to wait for
+	 * ordered extents to complete and therefore not log extent maps that
+	 * point to unwritten extents (when an ordered extent completes and it
+	 * has the BTRFS_ORDERED_IOERR flag set, it drops extent maps in its
+	 * range).
+	 */
+	BTRFS_INODE_COW_WRITE_ERROR,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c7c1b42028e..00670596bf06 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1885,6 +1885,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
+		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags);
 	} else {
 		/*
 		 * Get our ordered extents as soon as possible to avoid doing
@@ -1894,6 +1895,21 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
 						      &ctx.ordered_extents);
 		ret = filemap_fdatawait_range(inode->i_mapping, start, end);
+		if (ret)
+			goto out_release_extents;
+
+		/*
+		 * Check and clear the BTRFS_INODE_COW_WRITE_ERROR now after
+		 * starting and waiting for writeback, because for buffered IO
+		 * it may have been set during the end IO callback
+		 * (end_bbio_data_write() -> btrfs_finish_ordered_extent()) in
+		 * case an error happened and we need to wait for ordered
+		 * extents to complete so that any extent maps that point to
+		 * unwritten locations are dropped and we don't log them.
+		 */
+		if (test_and_clear_bit(BTRFS_INODE_COW_WRITE_ERROR,
+				       &BTRFS_I(inode)->runtime_flags))
+			ret = btrfs_wait_ordered_range(inode, start, len);
 	}
 
 	if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 44157e43fd2a..7d175d10a6d0 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -388,6 +388,37 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	ret = can_finish_ordered_extent(ordered, page, file_offset, len, uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
+	/*
+	 * If this is a COW write it means we created new extent maps for the
+	 * range and they point to unwritten locations if we got an error either
+	 * before submitting a bio or during IO.
+	 *
+	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
+	 * are queuing its completion below. During completion, at
+	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
+	 * unwritten extents.
+	 *
+	 * However because completion runs in a work queue we can end up having
+	 * a fast fsync running before that. In the case of direct IO, once we
+	 * unlock the inode the fsync might start, and we queue the completion
+	 * before unlocking the inode. In the case of buffered IO when writeback
+	 * finishes (end_bbio_data_write()) we queue the completion, so if the
+	 * writeback was triggered by a fast fsync, the fsync might start
+	 * logging before ordered extent completion runs in the work queue.
+	 *
+	 * The fast fsync will log file extent items based on the extent maps it
+	 * finds, so if by the time it collects extent maps the ordered extent
+	 * completion didn't happen yet, it will log file extent items that
+	 * point to unwritten extents, resulting in a corruption if a crash
+	 * happens and the log tree is replayed. Note that a fast fsync does not
+	 * wait for completion of ordered extents in order to reduce latency.
+	 *
+	 * Set a flag in the inode so that the next fast fsync will wait for
+	 * ordered extents to complete before starting to log.
+	 */
+	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
+		set_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
+
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
 	return ret;
-- 
2.43.0


