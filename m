Return-Path: <linux-btrfs+bounces-5074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538A8C8A5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDC11C213EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A113D8A1;
	Fri, 17 May 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA1ZridC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024013D8A2
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964762; cv=none; b=UIUP3e2DKiw/N4V0s2kkOnXFF1OgXcZSTnv5vhdl5V1HNmfMX0+YsTrMiNiWyVq4Uztp+mm2iDNJ2cXH3Dm/mKQiGO8u5JP3ZwKcbHTwF/sbkj31R92Xe8YZlWYfIc4B4BP9/AxDmQlpm29ueBe2wsR/5B5EUjZyh4O63j+xml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964762; c=relaxed/simple;
	bh=REt/3OJfNCITQy/2bGXlVBs6wsXgtZcqxRqyCSeg0W8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GU+gFjvCbvzfNVOkOlcDb474mLeA+e7GnuRs4X0O9LDsxL5jrOhmpVd/q9S7D7aws2e+v9E3GjESicXHsNmU5r9P16Ocv/+BiFmz0Pjcxy6Rh6d7yq3gwxO8pckeL/YVSwOnCxCZxUHorbYKoVwi80tb7i3RJ1Y0b6INdBmMlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA1ZridC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98707C32782
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964762;
	bh=REt/3OJfNCITQy/2bGXlVBs6wsXgtZcqxRqyCSeg0W8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gA1ZridCYLCIXnRSFrlPltIbINHnoBTEWwKubtTy9ZJhKJXQlBfyzYhv45zzn9eLn
	 R9RZkKohPEZIhb2e5Z1+Ba/phednAup16fxt1C/55/gBY/xrkn9xSzhWSs8QxCV4gd
	 +A/1sStYS9krSQXjnYMZrWXIQw06kbfMVeaASFcYYMy641ciIjK4lD5BMIeOwc+mgD
	 ItVMkG5lfg5eF85pAcRByyNw3VdTGYcCpQJAhPljFbNH1ZmbrGENOgd3AeWMXrHxDz
	 QIZB3MCioLF92meQYpHi1rUVSdMpl1WChmwP/W+YDIfHB9bhLE7rZxN+4Cm0kWZxmV
	 08LGfbFh0HRSA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: ensure fast fsync waits for ordered extents after a write failure
Date: Fri, 17 May 2024 17:52:37 +0100
Message-Id: <bc50545a6356d32644de712bbd0e6128276596a2.1715964570.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715964570.git.fdmanana@suse.com>
References: <cover.1715964570.git.fdmanana@suse.com>
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
 fs/btrfs/btrfs_inode.h  | 19 +++++++++++++------
 fs/btrfs/file.c         | 15 +++++++++++++++
 fs/btrfs/ordered-data.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 3c8bc7a8ebdd..26ee7251ad6c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -56,7 +56,9 @@ enum {
 	 /*
 	  * Always set under the VFS' inode lock, otherwise it can cause races
 	  * during fsync (we start as a fast fsync and then end up in a full
-	  * fsync racing with ordered extent completion).
+	  * fsync racing with ordered extent completion). It's also safe to be
+	  * set during writeback without holding the VFS' inode lock because
+	  * a fsync flushes and waits for delalloc before starting to log.
 	  */
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
@@ -453,14 +455,19 @@ static inline void btrfs_set_inode_last_sub_trans(struct btrfs_inode *inode)
 }
 
 /*
- * Should be called while holding the inode's VFS lock in exclusive mode, or
- * while holding the inode's mmap lock (struct btrfs_inode::i_mmap_lock) in
+ * Should be called while holding the inode's VFS lock in exclusive/shared mode,
+ * or while holding the inode's mmap lock (struct btrfs_inode::i_mmap_lock) in
  * either shared or exclusive mode, or in a context where no one else can access
  * the inode concurrently (during inode creation or when loading an inode from
- * disk).
+ * disk). Can also be called in irq context from btrfs_finish_ordered_extent()
+ * because at that point we are either in a direct IO write, in which case the
+ * inode's VFS lock is held, or in end IO callback of a buffered write, in which
+ * case fsync allways waits for writeback completion.
  */
 static inline void btrfs_set_inode_full_sync(struct btrfs_inode *inode)
 {
+	unsigned long flags;
+
 	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 	/*
 	 * The inode may have been part of a reflink operation in the last
@@ -478,10 +485,10 @@ static inline void btrfs_set_inode_full_sync(struct btrfs_inode *inode)
 	 * while ->last_trans was not yet updated in the current transaction,
 	 * and therefore has a lower value.
 	 */
-	spin_lock(&inode->lock);
+	spin_lock_irqsave(&inode->lock, flags);
 	if (inode->last_reflink_trans < inode->last_trans)
 		inode->last_reflink_trans = inode->last_trans;
-	spin_unlock(&inode->lock);
+	spin_unlock_irqrestore(&inode->lock, flags);
 }
 
 static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c7c1b42028e..d635bc0c01df 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1894,6 +1894,21 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
 						      &ctx.ordered_extents);
 		ret = filemap_fdatawait_range(inode->i_mapping, start, end);
+		if (ret)
+			goto out_release_extents;
+
+		/*
+		 * Check again the full sync flag, because it may have been set
+		 * during the end IO callback (end_bbio_data_write() ->
+		 * btrfs_finish_ordered_extent()) in case an error happened and
+		 * we need to wait for ordered extents to complete so that any
+		 * extent maps that point to unwritten locations are dropped and
+		 * we don't log them.
+		 */
+		full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+				     &BTRFS_I(inode)->runtime_flags);
+		if (full_sync)
+			ret = btrfs_wait_ordered_range(inode, start, len);
 	}
 
 	if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 44157e43fd2a..55a9aeed7344 100644
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
+		btrfs_set_inode_full_sync(inode);
+
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
 	return ret;
-- 
2.43.0


