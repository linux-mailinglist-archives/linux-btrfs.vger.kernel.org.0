Return-Path: <linux-btrfs+bounces-5791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F490CBE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0262D282C20
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F4913AD09;
	Tue, 18 Jun 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCaFK1ih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D814E2F9;
	Tue, 18 Jun 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714191; cv=none; b=FRpDdTUdmndnSB62qumVKjLLdf3CAx8MhnCoQKDBXCrdK2KjnFKZao2ZIOrrlR0TWffT7oc6CW1RaWCDWl42UBZZxPFcHmWAeOGMkujAOoP7WvGNH7zSUCKlEvYec/m61voAaw4pJOEoeAeMjAoJF5BgglHU+K8tDLjh4iDYVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714191; c=relaxed/simple;
	bh=FEgerRicwsgqA64gskyeRsgb5npmOerqY4Vj6eB2i+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOH4hxNGWy5exmPx2Z4npNA5R53uoIt3/cY8immdo+NTR3+RgzRRGfzOaoMFteI3OOK12efAeVy0sjN9tkpRun2Xm23i0X6gwO45HdmvYC6BQ0yycuuimnT6demm/wvFWWQQ0vnH9u5uOT1IaNPKYIa9ozveU7TvB6k/SAZ7Sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCaFK1ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483DC32786;
	Tue, 18 Jun 2024 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714189;
	bh=FEgerRicwsgqA64gskyeRsgb5npmOerqY4Vj6eB2i+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCaFK1ihhAZLoOVB2S2AzDDf4rYXcpZzl4HCWuCDIpzPotH4n3jbu9AUl4V/zcsb1
	 OKkQqs7X8xtyvrBJPN8NW7G6DQesoDGh2VOU4ZsexFIla1YHqUuAoOb9NK40A/+QeQ
	 g9GvSkI6kRXymcxHmt0vDnRHCXlYmhCGyG/2IUIXYO/ybGvMga3h8aFmpLlJ6IaVkV
	 ZbL1Ge5VoDEKikDvCWms4h0mdIEfKSBR+9qYbAbNgsXldGqEriI/PxMvoKrL3qcCT7
	 IZZ9tt29dirrTYCgC/NK/n3s7uani+pw+5H/LU6+X7qnupiH2Kxk6kHFobd6Sa2vsH
	 spcinREOEeH3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 10/44] btrfs: ensure fast fsync waits for ordered extents after a write failure
Date: Tue, 18 Jun 2024 08:34:51 -0400
Message-ID: <20240618123611.3301370-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit f13e01b89daf42330a4a722f451e48c3e2edfc8d ]

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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h  | 10 ++++++++++
 fs/btrfs/file.c         | 16 ++++++++++++++++
 fs/btrfs/ordered-data.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 100020ca4658e..787ca2892d7a6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -89,6 +89,16 @@ enum {
 	BTRFS_INODE_FREE_SPACE_INODE,
 	/* Set when there are no capabilities in XATTs for the inode. */
 	BTRFS_INODE_NO_CAP_XATTR,
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
index f9d76072398da..97f6133b6eee8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1875,6 +1875,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
+		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags);
 	} else {
 		/*
 		 * Get our ordered extents as soon as possible to avoid doing
@@ -1884,6 +1885,21 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
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
index c2a42bcde98e0..7dbf4162c75a5 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -382,6 +382,37 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
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


