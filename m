Return-Path: <linux-btrfs+bounces-12055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD3A54FCE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 16:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C916C70D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE4210F56;
	Thu,  6 Mar 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZDiqMAY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD917BEBF
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276642; cv=none; b=qk65j2xxQg4fTbXqJFttejWS5Wwa8ovJgelSSzv+Scbs6HjSy/SlAIqSAoH0WbAlippk9xDqGhEFz59taSS5e8JXzBQSNC9AhYIWd0sha60YIeu6k/HFdpopRnJ+73fzepb5nsG4VbboDrTrVl9DPgY/QFm52wEuyDQs8TlPwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276642; c=relaxed/simple;
	bh=+GhhfsY8YKg6og4pmlOZpBtjrzYetJ8Jk43ZGSGtXl4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kbSX23BZP8f5J5o9g+CJppo/0deu8m0rfNvIR5qNqHl7mCTnnFlDlze22ea9zSW306nAnoHTaaAM1SNZ8/jwRd2zEdpXlmWltJZsadzZcMt7JcN1kSZcUcRCAn/bHkFl7gggXND5kReInOExumf0Qdrj4Eof2QHXfKzaRSi5thI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZDiqMAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FA0C4CEE0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741276641;
	bh=+GhhfsY8YKg6og4pmlOZpBtjrzYetJ8Jk43ZGSGtXl4=;
	h=From:To:Subject:Date:From;
	b=EZDiqMAYvtMCONc/OJrkq9na9kOLTA5rn38v4TAr7Sno0lFz4tCTN2WlZGAyWbmsi
	 Vv3RZFE0QxDrhstiOiF5GA5Iycoh3ZyJrn6fIsezb4fl7rQRZmN5OqueBIqLTxk2sl
	 BTGFI7cfJLwA7mUhBrqA9DcE4NJs4h3qyE4jslYDY1E5tBN6rym4AImTUKPYgI0rWQ
	 zL0Fc5S7CKaJvIqcp8DfgMFzGX1sfm+WGuSbbjgAIrc2ta2zvJ6NbKcSR4OaRRZjVa
	 FSadG/3HaJhRGsl7aI7yOfLEhQRR4YCrtgCJ5HYuYotvlghozIwBB6Y2Q+i1hrPFLX
	 7jVeNPoKMRZXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix non-empty delayed iputs list on unmount due to async workers
Date: Thu,  6 Mar 2025 15:57:18 +0000
Message-Id: <b07f13dbfadfdb5884b21b97bbf1316c45d06a32.1741272910.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At close_ctree() after we have ran delayed iputs either explicitly through
calling btrfs_run_delayed_iputs() or later during the call to
btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
delayed iputs list is empty.

We have (another) race where this assertion might fail because we have
queued an async write into the fs_info->workers workqueue. Here's how it
happens:

1) We are submitting a data bio for an inode that is not the data
   relocation inode, so we call btrfs_wq_submit_bio();

2) btrfs_wq_submit_bio() submits a work for the fs_info->workers queue
   that will run run_one_async_done();

3) We enter close_ctree(), flush several work queues except
   fs_info->workers, explicitly run delayed iputs with a call to
   btrfs_run_delayed_iputs() and then again shortly after by calling
   btrfs_commit_super() or btrfs_error_commit_super(), which also run
   delayed iputs;

4) run_one_async_done() is executed in the work queue, and because there
   was an IO error (bio->bi_status is not 0) it calls btrfs_bio_end_io(),
   which drops the final reference on the associated ordered extent by
   calling btrfs_put_ordered_extent() - and that adds a delayed iput for
   the inode;

5) At close_ctree() we find that after stopping the cleaner and
   transaction kthreads the delayed iputs list is not empty, failing the
   following assertion:

      ASSERT(list_empty(&fs_info->delayed_iputs));

Fix this by flushing the fs_info->workers workqueue before running delayed
iputs at close_ctree().

David reported this when running generic/648, which exercises IO error
paths by using the DM error table.

Reported-by: David Sterba <dsterba@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b0f125d8efa0..984145147716 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4340,6 +4340,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * We can have ordered extents getting their last reference dropped from
+	 * the fs_info->workers queue because for async writes for data bios we
+	 * queue a work for that queue, at btrfs_wq_submit_bio(), that runs
+	 * run_one_async_done() which calls btrfs_bio_end_io() in case the bio
+	 * has an error, and that later function can do the final
+	 * btrfs_put_ordered_extent() on the ordered extent attached to the bio,
+	 * which adds a delayed iput for the inode. So we must flush the queue
+	 * so that we don't have delayed iputs after committing the current
+	 * transaction below and stopping the cleaner and transaction kthreads.
+	 */
+	btrfs_flush_workqueue(fs_info->workers);
+
 	/*
 	 * When finishing a compressed write bio we schedule a work queue item
 	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
-- 
2.45.2


